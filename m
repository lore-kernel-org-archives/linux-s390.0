From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [RFC/PATCH v2 19/22] s390/mm: Split huge pages if granular protection is needed
Date: Wed, 13 Dec 2017 13:53:30 +0100
Message-ID: <1513169613-13509-20-git-send-email-frankja@linux.vnet.ibm.com>
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

A guest can put DAT tables for a lower level guest in the same huge
segment as one of its prefixes or a g3 page. This would make it
necessary for the segment to be unprotected (because of the prefix)
and protected (because of the shadowing) at the same time. This is not
possible in this universe.

Hence we split the affected huge segment, so we can protect on a
per-page basis. Such gmap segments are special and get a new software
bit, that helps us handling this edge case.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
---
 arch/s390/include/asm/gmap.h    |  13 ++
 arch/s390/include/asm/pgtable.h |   7 +-
 arch/s390/mm/fault.c            |  10 +-
 arch/s390/mm/gmap.c             | 256 ++++++++++++++++++++++++++++++++++++----
 arch/s390/mm/pgtable.c          |  51 ++++++++
 5 files changed, 313 insertions(+), 24 deletions(-)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index d0a47d1..a187033 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -15,6 +15,7 @@
 
 /* Status bits in huge and non-huge gmap segment entries. */
 #define _SEGMENT_ENTRY_GMAP_IN		0x0001	/* invalidation notify bit */
+#define _SEGMENT_ENTRY_GMAP_SPLIT	0x0002  /* split huge pmd */
 /* Status bits only for huge segment entries */
 #define _SEGMENT_ENTRY_GMAP_UC		0x4000	/* user dirty (migration) */
 #define _SEGMENT_ENTRY_GMAP_VSIE	0x8000	/* vsie bit */
@@ -58,6 +59,7 @@ struct gmap {
 	struct radix_tree_root host_to_rmap;
 	struct list_head children;
 	struct list_head pt_list;
+	struct list_head split_list;
 	spinlock_t shadow_lock;
 	struct gmap *parent;
 	unsigned long orig_asce;
@@ -98,6 +100,17 @@ static inline int gmap_is_shadow(struct gmap *gmap)
 	return !!gmap->parent;
 }
 
+/**
+ * gmap_pmd_is_split - Returns if a huge gmap pmd has been split.
+ * @pmdp: pointer to the pmd
+ *
+ * Returns true if the passed huge gmap pmd has been split.
+ */
+static inline bool gmap_pmd_is_split(pmd_t *pmdp)
+{
+	return !!(pmd_val(*pmdp) & _SEGMENT_ENTRY_GMAP_SPLIT);
+}
+
 struct gmap *gmap_create(struct mm_struct *mm, unsigned long limit);
 void gmap_remove(struct gmap *gmap);
 struct gmap *gmap_get(struct gmap *gmap);
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 647c300..e68691a 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1095,6 +1095,8 @@ void ptep_set_pte_at(struct mm_struct *mm, unsigned long addr,
 void ptep_set_notify(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
 void ptep_notify(struct mm_struct *mm, unsigned long addr,
 		 pte_t *ptep, unsigned long bits);
+void ptep_notify_gmap(struct mm_struct *mm, unsigned long vmaddr,
+		      pte_t *pte, unsigned long bits);
 void pmdp_notify(struct mm_struct *mm, unsigned long addr);
 int ptep_force_prot(struct mm_struct *mm, unsigned long gaddr,
 		    pte_t *ptep, int prot, unsigned long bit);
@@ -1104,8 +1106,11 @@ void ptep_zap_key(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
 int ptep_shadow_pte(struct mm_struct *mm, unsigned long saddr,
 		    pte_t *sptep, pte_t *tptep, pte_t pte);
 void ptep_unshadow_pte(struct mm_struct *mm, unsigned long saddr, pte_t *ptep);
-
+void ptep_remove_dirty_protection_split(struct mm_struct *mm, pte_t *ptep,
+					unsigned long vmaddr);
 bool test_and_clear_guest_dirty(struct mm_struct *mm, unsigned long address);
+bool test_and_clear_guest_dirty_split(struct mm_struct *mm, pmd_t *pmdp,
+				      unsigned long vmaddr);
 int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 			  unsigned char key, bool nq);
 int cond_set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 93faeca..ba92860 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -418,7 +418,7 @@ static inline int do_exception(struct pt_regs *regs, int access)
 	struct vm_area_struct *vma;
 	enum fault_type type;
 	unsigned long trans_exc_code;
-	unsigned long address;
+	unsigned long address, gaddress = 0;
 	unsigned int flags;
 	int fault;
 
@@ -475,6 +475,12 @@ static inline int do_exception(struct pt_regs *regs, int access)
 			fault = VM_FAULT_BADMAP;
 			goto out_up;
 		}
+		/*
+		 * The GMAP code needs the full fault address even
+		 * when using large pages. Hence we take an unmasked
+		 * copy to feed to __gmap_link.
+		 */
+		gaddress = address;
 		if (gmap->pfault_enabled)
 			flags |= FAULT_FLAG_RETRY_NOWAIT;
 	}
@@ -551,7 +557,7 @@ static inline int do_exception(struct pt_regs *regs, int access)
 	}
 	if (IS_ENABLED(CONFIG_PGSTE) && gmap) {
 		address =  __gmap_link(gmap, current->thread.gmap_addr,
-				       address);
+				       gaddress);
 		if (address == -EFAULT) {
 			fault = VM_FAULT_BADMAP;
 			goto out_up;
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 74f6f06..1c15a98 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -64,6 +64,7 @@ static struct gmap *gmap_alloc(unsigned long limit)
 	INIT_LIST_HEAD(&gmap->crst_list);
 	INIT_LIST_HEAD(&gmap->children);
 	INIT_LIST_HEAD(&gmap->pt_list);
+	INIT_LIST_HEAD(&gmap->split_list);
 	INIT_RADIX_TREE(&gmap->guest_to_host, GFP_KERNEL);
 	INIT_RADIX_TREE(&gmap->host_to_guest, GFP_ATOMIC);
 	INIT_RADIX_TREE(&gmap->host_to_rmap, GFP_ATOMIC);
@@ -195,6 +196,12 @@ static void gmap_free(struct gmap *gmap)
 	gmap_radix_tree_free(&gmap->guest_to_host);
 	gmap_radix_tree_free(&gmap->host_to_guest);
 
+	/* Free split pmd page tables */
+	spin_lock(&gmap->guest_table_lock);
+	list_for_each_entry_safe(page, next, &gmap->split_list, lru)
+		page_table_free_pgste(page);
+	spin_unlock(&gmap->guest_table_lock);
+
 	/* Free additional data for a shadow gmap */
 	if (gmap_is_shadow(gmap)) {
 		/* Free all page tables. */
@@ -546,6 +553,7 @@ int __gmap_link(struct gmap *gmap, unsigned long gaddr, unsigned long vmaddr)
 	pud_t *pud;
 	pmd_t *pmd;
 	pmd_t unprot;
+	pte_t *ptep;
 	int rc;
 
 	BUG_ON(gmap_is_shadow(gmap));
@@ -616,6 +624,16 @@ int __gmap_link(struct gmap *gmap, unsigned long gaddr, unsigned long vmaddr)
 					  & ~_SEGMENT_ENTRY_PROTECT))
 			       | _SEGMENT_ENTRY_GMAP_UC);
 		gmap_pmdp_xchg(gmap, (pmd_t *)table, unprot, gaddr);
+	} else if (gmap_pmd_is_split((pmd_t *)table)) {
+		/*
+		 * Split pmds are somewhere in-between a normal and a
+		 * large pmd. As we don't share the page table, the
+		 * host does not remove protection on a fault and we
+		 * have to do it ourselves for the guest mapping.
+		 */
+		ptep = pte_offset_map((pmd_t *)table, gaddr);
+		if (pte_val(*ptep) & _PAGE_PROTECT)
+			ptep_remove_dirty_protection_split(mm, ptep, vmaddr);
 	}
 	spin_unlock(&gmap->guest_table_lock);
 	spin_unlock(ptl);
@@ -895,7 +913,7 @@ static inline pmd_t *gmap_pmd_op_walk(struct gmap *gmap, unsigned long gaddr)
 	 * suffices to take the pte lock later on. Thus we can unlock
 	 * the guest_table_lock here.
 	 */
-	if (!pmd_large(*pmdp) && !gmap_is_shadow(gmap))
+	if (!gmap_pmd_is_split(pmdp) && !pmd_large(*pmdp) && !gmap_is_shadow(gmap))
 		spin_unlock(&gmap->guest_table_lock);
 	return pmdp;
 }
@@ -907,10 +925,20 @@ static inline pmd_t *gmap_pmd_op_walk(struct gmap *gmap, unsigned long gaddr)
  */
 static inline void gmap_pmd_op_end(struct gmap *gmap, pmd_t *pmdp)
 {
-	if (pmd_large(*pmdp) || gmap_is_shadow(gmap))
+	if (gmap_pmd_is_split(pmdp) || pmd_large(*pmdp) || gmap_is_shadow(gmap))
 		spin_unlock(&gmap->guest_table_lock);
 }
 
+static pte_t *gmap_pte_from_pmd(struct gmap *gmap, pmd_t *pmdp,
+				unsigned long addr, spinlock_t **ptl)
+{
+	if (likely(!gmap_pmd_is_split(pmdp)))
+		return pte_alloc_map_lock(gmap->mm, pmdp, addr, ptl);
+
+	*ptl = NULL;
+	return pte_offset_map(pmdp, addr);
+}
+
 /**
  * gmap_pmdp_transfer_prot - transfer protection of guest pmd to host pmd
  * @mm: the memory context
@@ -953,6 +981,18 @@ static void gmap_pmdp_transfer_prot(struct mm_struct *mm, unsigned long addr,
 	*hpmdp = new;
 }
 
+static void gmap_pte_transfer_prot(struct mm_struct *mm, unsigned long addr,
+				   pte_t *gptep, pmd_t *hpmdp)
+{
+	pmd_t mpmd = __pmd(0);
+
+	if (pte_val(*gptep) & _PAGE_PROTECT)
+		pmd_val(mpmd) |= _SEGMENT_ENTRY_PROTECT;
+	if (pte_val(*gptep) & _PAGE_INVALID)
+		pmd_val(mpmd) |= _SEGMENT_ENTRY_INVALID;
+	gmap_pmdp_transfer_prot(mm, addr, &mpmd, hpmdp);
+}
+
 /**
  * gmap_pmdp_force_prot - change access rights of a locked pmd
  * @mm: pointer to the process mm_struct
@@ -989,6 +1029,63 @@ static int gmap_pmdp_force_prot(struct gmap *gmap, unsigned long addr,
 	return 0;
 }
 
+/**
+ * gmap_pmd_split_free - Free a split pmd's page table
+ * @pmdp The split pmd that we free of its page table
+ *
+ * If the userspace pmds are exchanged, we'll remove the gmap pmds as
+ * well, so we fault on them and link them again. We would leak
+ * memory, if we didn't free split pmds here.
+ */
+static inline void gmap_pmd_split_free(pmd_t *pmdp)
+{
+	unsigned long pgt = pmd_val(*pmdp) & _SEGMENT_ENTRY_ORIGIN;
+	struct page *page;
+
+	if (gmap_pmd_is_split(pmdp)) {
+		page = pfn_to_page(pgt >> PAGE_SHIFT);
+		list_del(&page->lru);
+		page_table_free_pgste(page);
+	}
+}
+
+/**
+ * gmap_pmd_split - Split a huge gmap pmd and use a page table instead
+ * @gmap: pointer to guest mapping meta data structure
+ * @gaddr: virtual address in the guest address space
+ * @pmdp: pointer to the pmd that will be split
+ *
+ * When splitting gmap pmds, we have to make the resulting page table
+ * look like it's a normal one to be able to use the common pte
+ * handling functions. Also we need to track these new tables as they
+ * aren't tracked anywhere else.
+ */
+static int gmap_pmd_split(struct gmap *gmap, unsigned long gaddr, pmd_t *pmdp)
+{
+	unsigned long *table;
+	struct page *page;
+	pmd_t new;
+	int i;
+
+	page = page_table_alloc_pgste(gmap->mm);
+	if (!page)
+		return -ENOMEM;
+	table = (unsigned long *) page_to_phys(page);
+	for (i = 0; i < 256; i++) {
+		table[i] = (pmd_val(*pmdp) & HPAGE_MASK) + i * PAGE_SIZE;
+		/* pmd_large() implies pmd/pte_present() */
+		table[i] |=  _PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE;
+		/* ptes are directly marked as dirty */
+		table[i + PTRS_PER_PTE] |= PGSTE_UC_BIT;
+	}
+
+	pmd_val(new) = ((unsigned long)table | _SEGMENT_ENTRY |
+			(_SEGMENT_ENTRY_GMAP_SPLIT));
+	list_add(&page->lru, &gmap->split_list);
+	gmap_pmdp_xchg(gmap, pmdp, new, gaddr);
+	return 0;
+}
+
 /*
  * gmap_protect_pte - remove access rights to memory and set pgste bits
  * @gmap: pointer to guest mapping meta data structure
@@ -1004,7 +1101,8 @@ static int gmap_pmdp_force_prot(struct gmap *gmap, unsigned long addr,
  * guest_table_lock held for shadow gmaps.
  */
 static int gmap_protect_pte(struct gmap *gmap, unsigned long gaddr,
-			    pmd_t *pmdp, int prot, unsigned long bits)
+			    unsigned long vmaddr, pmd_t *pmdp, pmd_t *hpmdp,
+			    int prot, unsigned long bits)
 {
 	int rc;
 	pte_t *ptep;
@@ -1015,7 +1113,7 @@ static int gmap_protect_pte(struct gmap *gmap, unsigned long gaddr,
 	if (pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)
 		return -EAGAIN;
 
-	ptep = pte_alloc_map_lock(gmap->mm, pmdp, gaddr, &ptl);
+	ptep = gmap_pte_from_pmd(gmap, pmdp, gaddr, &ptl);
 	if (!ptep)
 		return -ENOMEM;
 
@@ -1024,6 +1122,8 @@ static int gmap_protect_pte(struct gmap *gmap, unsigned long gaddr,
 	/* Protect and unlock. */
 	rc = ptep_force_prot(gmap->mm, gaddr, ptep, prot, pbits);
 	gmap_pte_op_end(ptl);
+	if (!rc && gmap_pmd_is_split(pmdp))
+		gmap_pte_transfer_prot(gmap->mm, vmaddr, ptep, hpmdp);
 	return rc;
 }
 
@@ -1048,6 +1148,14 @@ static int gmap_protect_pmd(struct gmap *gmap, unsigned long gaddr,
 
 	sbits |= (bits & GMAP_NOTIFY_MPROT) ? _SEGMENT_ENTRY_GMAP_IN : 0;
 	sbits |= (bits & GMAP_NOTIFY_SHADOW) ? _SEGMENT_ENTRY_GMAP_VSIE : 0;
+
+	if (((prot != PROT_WRITE) && (bits & GMAP_NOTIFY_SHADOW))) {
+		ret = gmap_pmd_split(gmap, gaddr, pmdp);
+		if (ret)
+			return ret;
+		return -EFAULT;
+	}
+
 	/* Protect gmap pmd */
 	ret = gmap_pmdp_force_prot(gmap, gaddr, pmdp, prot, sbits);
 	/*
@@ -1081,20 +1189,27 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 	spinlock_t *ptl;
 	unsigned long vmaddr, dist;
 	pmd_t *pmdp, *hpmdp;
-	int rc;
+	int rc = 0;
 
 	while (len) {
 		rc = -EAGAIN;
 		vmaddr = __gmap_translate(gmap, gaddr);
 		hpmdp = (pmd_t *)huge_pte_offset(gmap->mm, vmaddr, HPAGE_SIZE);
+		if (!hpmdp)
+			BUG();
 		/* Do we need tests here? */
 		ptl = pmd_lock(gmap->mm, hpmdp);
 
 		pmdp = gmap_pmd_op_walk(gmap, gaddr);
 		if (pmdp) {
 			if (!pmd_large(*pmdp)) {
-				rc = gmap_protect_pte(gmap, gaddr, pmdp, prot,
-						      bits);
+				if (gmap_pmd_is_split(pmdp) &&
+				    (bits & GMAP_NOTIFY_MPROT)) {
+					pmd_val(*pmdp) |= _SEGMENT_ENTRY_GMAP_IN;
+				}
+
+				rc = gmap_protect_pte(gmap, gaddr, vmaddr,
+						      pmdp, hpmdp, prot, bits);
 				if (!rc) {
 					len -= PAGE_SIZE;
 					gaddr += PAGE_SIZE;
@@ -1111,7 +1226,9 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 			gmap_pmd_op_end(gmap, pmdp);
 		}
 		spin_unlock(ptl);
-		if (rc) {
+		if (rc == -EFAULT)
+			continue;
+		if (rc == -EAGAIN) {
 			vmaddr = __gmap_translate(gmap, gaddr);
 			if (IS_ERR_VALUE(vmaddr))
 				return vmaddr;
@@ -1179,7 +1296,7 @@ int gmap_read_table(struct gmap *gmap, unsigned long gaddr, unsigned long *val,
 		pmdp = gmap_pmd_op_walk(gmap, gaddr);
 		if (pmdp) {
 			if (!pmd_large(*pmdp)) {
-				ptep = pte_alloc_map_lock(gmap->mm, pmdp, gaddr, &ptl);
+				ptep = gmap_pte_from_pmd(gmap, pmdp, gaddr, &ptl);
 				if (ptep) {
 					pte = *ptep;
 					if (pte_present(pte) && (pte_val(pte) & _PAGE_READ)) {
@@ -1188,6 +1305,8 @@ int gmap_read_table(struct gmap *gmap, unsigned long gaddr, unsigned long *val,
 						*val = *(unsigned long *) address;
 						pte_val(*ptep) |= _PAGE_YOUNG;
 						/* Do *NOT* clear the _PAGE_INVALID bit! */
+						if (gmap_pmd_is_split(pmdp))
+							*fc = 1;
 						rc = 0;
 					}
 					gmap_pte_op_end(ptl);
@@ -1277,7 +1396,7 @@ static int gmap_protect_rmap_pte(struct gmap *sg, struct gmap_rmap *rmap,
 	if (pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)
 		return -EAGAIN;
 
-	ptep = pte_alloc_map_lock(sg->parent->mm, pmdp, paddr, &ptl);
+	ptep = gmap_pte_from_pmd(sg->parent, pmdp, paddr, &ptl);
 	if (ptep) {
 		spin_lock(&sg->guest_table_lock);
 		rc = ptep_force_prot(sg->parent->mm, paddr, ptep, prot,
@@ -1356,12 +1475,12 @@ static int gmap_protect_rmap(struct gmap *sg, unsigned long raddr,
 		}
 		spin_unlock(ptl);
 		radix_tree_preload_end();
-		if (rc) {
+		if (rc)
 			kfree(rmap);
+		if (rc == -EAGAIN) {
 			rc = gmap_pte_op_fixup(parent, paddr, vmaddr, prot);
 			if (rc)
 				return rc;
-			continue;
 		}
 	}
 	return 0;
@@ -2244,7 +2363,8 @@ int gmap_shadow_segment(struct gmap *sg, unsigned long saddr, pmd_t pmd)
 	struct gmap *parent;
 	struct gmap_rmap *rmap;
 	unsigned long vmaddr, paddr;
-	pmd_t spmd, tpmd, *spmdp = NULL, *tpmdp;
+	pmd_t spmd, tpmd, *spmdp = NULL, *tpmdp, *hpmdp;
+	spinlock_t *ptl;
 	int prot;
 	int rc;
 
@@ -2264,6 +2384,11 @@ int gmap_shadow_segment(struct gmap *sg, unsigned long saddr, pmd_t pmd)
 			rc = vmaddr;
 			break;
 		}
+		hpmdp = (pmd_t *)huge_pte_offset(sg->mm, vmaddr, HPAGE_SIZE);
+		if (!hpmdp)
+			BUG();
+		/* Do we need tests here? */
+		ptl = pmd_lock(sg->mm, hpmdp);
 		rc = radix_tree_preload(GFP_KERNEL);
 		if (rc)
 			break;
@@ -2272,12 +2397,15 @@ int gmap_shadow_segment(struct gmap *sg, unsigned long saddr, pmd_t pmd)
 		/* Let's look up the parent's mapping */
 		spmdp = gmap_pmd_op_walk(parent, paddr);
 		if (spmdp) {
+			if (!pmd_large(*spmdp))
+				BUG();
 			spin_lock(&sg->guest_table_lock);
 			/* Get shadow segment table pointer */
 			tpmdp = (pmd_t *) gmap_table_walk(sg, saddr, 1);
 			if (!tpmdp) {
 				spin_unlock(&sg->guest_table_lock);
 				gmap_pmd_op_end(parent, spmdp);
+				spin_unlock(ptl);
 				radix_tree_preload_end();
 				break;
 			}
@@ -2286,6 +2414,7 @@ int gmap_shadow_segment(struct gmap *sg, unsigned long saddr, pmd_t pmd)
 				rc = 0;	/* already shadowed */
 				spin_unlock(&sg->guest_table_lock);
 				gmap_pmd_op_end(parent, spmdp);
+				spin_unlock(ptl);
 				radix_tree_preload_end();
 				break;
 			}
@@ -2309,6 +2438,7 @@ int gmap_shadow_segment(struct gmap *sg, unsigned long saddr, pmd_t pmd)
 			spin_unlock(&sg->guest_table_lock);
 			gmap_pmd_op_end(parent, spmdp);
 		}
+		spin_unlock(ptl);
 		radix_tree_preload_end();
 		if (!rc)
 			break;
@@ -2388,7 +2518,7 @@ int gmap_shadow_page(struct gmap *sg, unsigned long saddr, pte_t pte)
 				rmap = NULL;
 				rc = 0;
 			} else {
-				sptep = pte_alloc_map_lock(parent->mm, spmdp, paddr, &ptl);
+				sptep = gmap_pte_from_pmd(parent, spmdp, paddr, &ptl);
 				if (sptep) {
 					rc = ptep_shadow_pte(sg->mm, saddr, sptep, tptep, pte);
 					if (rc > 0) {
@@ -2538,6 +2668,9 @@ static void gmap_shadow_notify(struct gmap *sg, unsigned long vmaddr,
 		case _SHADOW_RMAP_REGION3:
 			gmap_unshadow_sgt(sg, raddr);
 			break;
+		case _SHADOW_RMAP_SEGMENT_LP:
+			gmap_unshadow_segment(sg, raddr);
+			break;
 		case _SHADOW_RMAP_SEGMENT:
 			gmap_unshadow_pgt(sg, raddr);
 			break;
@@ -2550,6 +2683,46 @@ static void gmap_shadow_notify(struct gmap *sg, unsigned long vmaddr,
 	spin_unlock(&sg->guest_table_lock);
 }
 
+/*
+ * ptep_notify_gmap - call all invalidation callbacks for a specific pte of a gmap
+ * @mm: pointer to the process mm_struct
+ * @addr: virtual address in the process address space
+ * @pte: pointer to the page table entry
+ * @bits: bits from the pgste that caused the notify call
+ *
+ * This function is assumed to be called with the guest_table_lock held.
+ */
+void ptep_notify_gmap(struct mm_struct *mm, unsigned long vmaddr,
+		      pte_t *pte, unsigned long bits)
+{
+	unsigned long offset, gaddr = 0;
+	unsigned long *table;
+	struct gmap *gmap, *sg, *next;
+
+	offset = ((unsigned long) pte) & (255 * sizeof(pte_t));
+	offset = offset * (4096 / sizeof(pte_t));
+	rcu_read_lock();
+	list_for_each_entry_rcu(gmap, &mm->context.gmap_list, list) {
+		table = radix_tree_lookup(&gmap->host_to_guest,
+					  vmaddr >> PMD_SHIFT);
+		if (table)
+			gaddr = __gmap_segment_gaddr(table) + offset;
+		else
+			continue;
+
+		if (!list_empty(&gmap->children) && (bits & PGSTE_VSIE_BIT)) {
+			spin_lock(&gmap->shadow_lock);
+			list_for_each_entry_safe(sg, next,
+						 &gmap->children, list)
+				gmap_shadow_notify(sg, vmaddr, gaddr);
+			spin_unlock(&gmap->shadow_lock);
+		}
+		if (bits & PGSTE_IN_BIT)
+			gmap_call_notifier(gmap, gaddr, gaddr + PAGE_SIZE - 1);
+	}
+	rcu_read_unlock();
+}
+
 /**
  * ptep_notify - call all invalidation callbacks for a specific pte.
  * @mm: pointer to the process mm_struct
@@ -2612,10 +2785,12 @@ static void pmdp_notify_gmap(struct gmap *gmap, unsigned long gaddr)
 	table = gmap_table_walk(gmap, gaddr, 1);
 	if (!table)
 		return;
-	bits = *table & (_SEGMENT_ENTRY_GMAP_IN | _SEGMENT_ENTRY_GMAP_VSIE);
+	bits = *table & _SEGMENT_ENTRY_GMAP_IN;
+	if (pmd_large(__pmd(*table)) && (*table & _SEGMENT_ENTRY_GMAP_VSIE))
+		bits |= _SEGMENT_ENTRY_GMAP_VSIE;
 	if (!bits)
 		return;
-	*table ^= bits;
+	*table &= ~bits;
 	vmaddr = __gmap_translate(gmap, gaddr);
 	if (!list_empty(&gmap->children) && (bits & _SEGMENT_ENTRY_GMAP_VSIE)
 	    && (*table & _SEGMENT_ENTRY_PROTECT)) {
@@ -2629,6 +2804,23 @@ static void pmdp_notify_gmap(struct gmap *gmap, unsigned long gaddr)
 		gmap_call_notifier(gmap, gaddr, gaddr + HPAGE_SIZE - 1);
 }
 
+static void pmdp_notify_split(struct mm_struct *mm, unsigned long vmaddr,
+			      unsigned long *table)
+{
+	int i = 0;
+	unsigned long bits;
+	unsigned long *ptep = (unsigned long *)(*table & PAGE_MASK);
+	unsigned long *pgste = ptep + PTRS_PER_PTE;
+
+	for (; i < 256; i++, vmaddr += PAGE_SIZE, ptep++, pgste++) {
+		bits = *pgste & (PGSTE_IN_BIT | PGSTE_VSIE_BIT);
+		if (bits) {
+			*pgste ^= bits;
+			ptep_notify_gmap(mm, vmaddr, (pte_t *)ptep, bits);
+		}
+	}
+}
+
 /**
  * pmdp_notify - call all invalidation callbacks for a specific pmd
  * @mm: pointer to the process mm_struct
@@ -2650,8 +2842,17 @@ void pmdp_notify(struct mm_struct *mm, unsigned long vmaddr)
 			spin_unlock(&gmap->guest_table_lock);
 			continue;
 		}
-		bits = *table & (_SEGMENT_ENTRY_GMAP_IN | _SEGMENT_ENTRY_GMAP_VSIE);
-		*table ^= bits;
+
+		if (gmap_pmd_is_split((pmd_t *)table)) {
+			pmdp_notify_split(mm, vmaddr, table);
+			spin_unlock(&gmap->guest_table_lock);
+			continue;
+		}
+
+		bits = *table & (_SEGMENT_ENTRY_GMAP_IN);
+		if (pmd_large(__pmd(*table)) && (*table & _SEGMENT_ENTRY_GMAP_VSIE))
+			bits |= _SEGMENT_ENTRY_GMAP_VSIE;
+		*table &= ~bits;
 		gaddr = __gmap_segment_gaddr(table);
 		spin_unlock(&gmap->guest_table_lock);
 		if (!list_empty(&gmap->children) && (bits & _SEGMENT_ENTRY_GMAP_VSIE)) {
@@ -2682,6 +2883,7 @@ static void gmap_pmdp_clear(struct mm_struct *mm, unsigned long vmaddr,
 		if (pmdp) {
 			if (purge)
 				__pmdp_csp(pmdp);
+			gmap_pmd_split_free(pmdp);
 			pmd_val(*pmdp) = _SEGMENT_ENTRY_EMPTY;
 		}
 		spin_unlock(&gmap->guest_table_lock);
@@ -2738,6 +2940,7 @@ void gmap_pmdp_idte_local(struct mm_struct *mm, unsigned long vmaddr)
 			else if (MACHINE_HAS_IDTE)
 				__pmdp_idte(gaddr, pmdp, 0, 0,
 					    IDTE_LOCAL);
+			gmap_pmd_split_free(pmdp);
 			*entry = _SEGMENT_ENTRY_EMPTY;
 		}
 		spin_unlock(&gmap->guest_table_lock);
@@ -2774,6 +2977,8 @@ void gmap_pmdp_idte_global(struct mm_struct *mm, unsigned long vmaddr)
 					    IDTE_GLOBAL);
 			else
 				__pmdp_csp(pmdp);
+
+			gmap_pmd_split_free(pmdp);
 			*entry = _SEGMENT_ENTRY_EMPTY;
 		}
 		spin_unlock(&gmap->guest_table_lock);
@@ -2852,6 +3057,7 @@ void gmap_sync_dirty_log_pmd(struct gmap *gmap, unsigned long bitmap[4],
 	pmd_t *pmdp, *hpmdp;
 	spinlock_t *ptl;
 
+	/* Protection against gmap_link vsie unprotection. */
 	hpmdp = (pmd_t *)huge_pte_offset(gmap->mm, vmaddr, HPAGE_SIZE);
 	if (!hpmdp)
 		return;
@@ -2867,9 +3073,17 @@ void gmap_sync_dirty_log_pmd(struct gmap *gmap, unsigned long bitmap[4],
 						      gaddr, vmaddr))
 			memset(bitmap, 0xFF, 32);
 	} else {
-		for (; i < _PAGE_ENTRIES; i++, vmaddr += PAGE_SIZE) {
-			if (test_and_clear_guest_dirty(gmap->mm, vmaddr))
-				set_bit_le(i, bitmap);
+		/* We handle this here, as it's of the records from mm. */
+		if (unlikely(gmap_pmd_is_split(pmdp))) {
+			for (; i < _PAGE_ENTRIES; i++, vmaddr += PAGE_SIZE) {
+				if (test_and_clear_guest_dirty_split(gmap->mm, pmdp, vmaddr))
+					set_bit_le(i, bitmap);
+			}
+		} else {
+			for (; i < _PAGE_ENTRIES; i++, vmaddr += PAGE_SIZE) {
+				if (test_and_clear_guest_dirty(gmap->mm, vmaddr))
+					set_bit_le(i, bitmap);
+			}
 		}
 	}
 	gmap_pmd_op_end(gmap, pmdp);
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index d18b80e..c0408b2 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -763,6 +763,57 @@ bool test_and_clear_guest_dirty(struct mm_struct *mm, unsigned long addr)
 }
 EXPORT_SYMBOL_GPL(test_and_clear_guest_dirty);
 
+void ptep_remove_dirty_protection_split(struct mm_struct *mm,
+					pte_t *ptep, unsigned long vmaddr)
+{
+	pte_t unprot = __pte(pte_val(*ptep) & ~_PAGE_PROTECT);
+	pgste_t pgste;
+	unsigned long bits;
+
+	pgste = pgste_get_lock(ptep);
+	pgste_val(pgste) |= PGSTE_UC_BIT;
+
+	bits = pgste_val(pgste) & (PGSTE_IN_BIT | PGSTE_VSIE_BIT);
+	pgste_val(pgste) ^= bits;
+	ptep_notify_gmap(mm, vmaddr, ptep, bits);
+	ptep_ipte_global(mm, vmaddr, ptep, 0);
+
+	*ptep = unprot;
+	pgste_set_unlock(ptep, pgste);
+}
+EXPORT_SYMBOL_GPL(ptep_remove_dirty_protection_split);
+
+bool test_and_clear_guest_dirty_split(struct mm_struct *mm, pmd_t *pmdp,
+				      unsigned long vmaddr)
+{
+	bool dirty;
+	pte_t *ptep, pte;
+	pgste_t pgste;
+	unsigned long bits;
+
+	ptep = pte_offset_map(pmdp, vmaddr);
+	pgste = pgste_get_lock(ptep);
+	dirty = !!(pgste_val(pgste) & PGSTE_UC_BIT);
+	pgste_val(pgste) &= ~PGSTE_UC_BIT;
+	pte = *ptep;
+	if (dirty) {
+		bits = pgste_val(pgste) & (PGSTE_IN_BIT | PGSTE_VSIE_BIT);
+		if (bits) {
+			pgste_val(pgste) ^= bits;
+			ptep_notify_gmap(mm, vmaddr, ptep, bits);
+		}
+		ptep_ipte_global(mm, vmaddr, ptep, 0);
+		if (MACHINE_HAS_ESOP || !(pte_val(pte) & _PAGE_WRITE))
+			pte_val(pte) |= _PAGE_PROTECT;
+		else
+			pte_val(pte) |= _PAGE_INVALID;
+		*ptep = pte;
+	}
+	pgste_set_unlock(ptep, pgste);
+	return dirty;
+}
+EXPORT_SYMBOL_GPL(test_and_clear_guest_dirty_split);
+
 int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 			  unsigned char key, bool nq)
 {
-- 
2.7.4
