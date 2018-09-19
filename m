From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 19 Sep 2018 08:47:52 +0000
Subject: [RFC 04/14] s390/mm: split huge pages in GMAP when protecting
Message-Id: <20180919084802.183381-5-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Dirty tracking, vsie protection and lowcore invalidation notification
are best done on the smallest page size available to avoid unnecessary
flushing and table management operations.

Hence we now split huge pages and introduce a page table if a
notification bit is set or memory is protected via gmap_protect_range
or gmap_protect_rmap.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/include/asm/gmap.h    |  18 +++
 arch/s390/include/asm/pgtable.h |   3 +
 arch/s390/mm/gmap.c             | 243 +++++++++++++++++++++++++++++++---------
 arch/s390/mm/pgtable.c          |  33 ++++++
 4 files changed, 247 insertions(+), 50 deletions(-)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index fcbd638fb9f4..c667bd0181d4 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -16,6 +16,11 @@
 /* Status bits only for huge segment entries */
 #define _SEGMENT_ENTRY_GMAP_IN		0x8000	/* invalidation notify bit */
 #define _SEGMENT_ENTRY_GMAP_UC		0x4000	/* dirty (migration) */
+/* Status bits in the gmap segment entry. */
+#define _SEGMENT_ENTRY_GMAP_SPLIT	0x0001  /* split huge pmd */
+
+#define GMAP_SEGMENT_STATUS_BITS (_SEGMENT_ENTRY_GMAP_UC | _SEGMENT_ENTRY_GMAP_SPLIT)
+#define GMAP_SEGMENT_NOTIFY_BITS _SEGMENT_ENTRY_GMAP_IN
 
 /**
  * struct gmap_struct - guest address space
@@ -56,6 +61,8 @@ struct gmap {
 	struct radix_tree_root host_to_rmap;
 	struct list_head children;
 	struct list_head pt_list;
+	struct list_head split_list;
+	spinlock_t split_list_lock;
 	spinlock_t shadow_lock;
 	struct gmap *parent;
 	unsigned long orig_asce;
@@ -96,6 +103,17 @@ static inline int gmap_is_shadow(struct gmap *gmap)
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
index c0abd57c5a21..54d8376b7a10 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1103,6 +1103,9 @@ int ptep_shadow_pte(struct mm_struct *mm, unsigned long saddr,
 		    pte_t *sptep, pte_t *tptep, pte_t pte);
 void ptep_unshadow_pte(struct mm_struct *mm, unsigned long saddr, pte_t *ptep);
 
+unsigned long ptep_get_and_clear_notification_bits(pte_t *ptep);
+void ptep_remove_protection_split(struct mm_struct *mm, pte_t *ptep,
+				  unsigned long gaddr);
 bool ptep_test_and_clear_uc(struct mm_struct *mm, unsigned long address,
 			    pte_t *ptep);
 int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 795f558c8246..8e78a124d31a 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -62,11 +62,13 @@ static struct gmap *gmap_alloc(unsigned long limit)
 	INIT_LIST_HEAD(&gmap->crst_list);
 	INIT_LIST_HEAD(&gmap->children);
 	INIT_LIST_HEAD(&gmap->pt_list);
+	INIT_LIST_HEAD(&gmap->split_list);
 	INIT_RADIX_TREE(&gmap->guest_to_host, GFP_KERNEL);
 	INIT_RADIX_TREE(&gmap->host_to_guest, GFP_ATOMIC);
 	INIT_RADIX_TREE(&gmap->host_to_rmap, GFP_ATOMIC);
 	spin_lock_init(&gmap->guest_table_lock);
 	spin_lock_init(&gmap->shadow_lock);
+	spin_lock_init(&gmap->split_list_lock);
 	atomic_set(&gmap->ref_count, 1);
 	page = alloc_pages(GFP_KERNEL, CRST_ALLOC_ORDER);
 	if (!page)
@@ -193,6 +195,10 @@ static void gmap_free(struct gmap *gmap)
 	gmap_radix_tree_free(&gmap->guest_to_host);
 	gmap_radix_tree_free(&gmap->host_to_guest);
 
+	/* Free split pmd page tables */
+	list_for_each_entry_safe(page, next, &gmap->split_list, lru)
+		page_table_free_pgste(page);
+
 	/* Free additional data for a shadow gmap */
 	if (gmap_is_shadow(gmap)) {
 		/* Free all page tables. */
@@ -547,6 +553,7 @@ int __gmap_link(struct gmap *gmap, unsigned long gaddr, unsigned long vmaddr)
 	pud_t *pud;
 	pmd_t *pmd;
 	u64 unprot;
+	pte_t *ptep;
 	int rc;
 
 	BUG_ON(gmap_is_shadow(gmap));
@@ -597,9 +604,15 @@ int __gmap_link(struct gmap *gmap, unsigned long gaddr, unsigned long vmaddr)
 	rc = radix_tree_preload(GFP_KERNEL);
 	if (rc)
 		return rc;
+	/*
+	 * do_exception() does remove the pte index for huge
+	 * pages, so we need to re-add it here to work on the
+	 * correct pte.
+	 */
+	vmaddr = vmaddr | (gaddr & ~PMD_MASK);
 	ptl = pmd_lock(mm, pmd);
-	spin_lock(&gmap->guest_table_lock);
 	if (*table == _SEGMENT_ENTRY_EMPTY) {
+		spin_lock(&gmap->guest_table_lock);
 		rc = radix_tree_insert(&gmap->host_to_guest,
 				       vmaddr >> PMD_SHIFT, table);
 		if (!rc) {
@@ -611,14 +624,24 @@ int __gmap_link(struct gmap *gmap, unsigned long gaddr, unsigned long vmaddr)
 				*table = pmd_val(*pmd) &
 					_SEGMENT_ENTRY_HARDWARE_BITS;
 		}
+		spin_unlock(&gmap->guest_table_lock);
 	} else if (*table & _SEGMENT_ENTRY_PROTECT &&
 		   !(pmd_val(*pmd) & _SEGMENT_ENTRY_PROTECT)) {
 		unprot = (u64)*table;
 		unprot &= ~_SEGMENT_ENTRY_PROTECT;
 		unprot |= _SEGMENT_ENTRY_GMAP_UC;
 		gmap_pmdp_xchg(gmap, (pmd_t *)table, __pmd(unprot), gaddr);
+	} else if (gmap_pmd_is_split((pmd_t *)table)) {
+		/*
+		 * Split pmds are somewhere in-between a normal and a
+		 * large pmd. As we don't share the page table, the
+		 * host does not remove protection on a fault and we
+		 * have to do it ourselves for the guest mapping.
+		 */
+		ptep = pte_offset_map((pmd_t *)table, vmaddr);
+		if (pte_val(*ptep) & _PAGE_PROTECT)
+			ptep_remove_protection_split(mm, ptep, vmaddr);
 	}
-	spin_unlock(&gmap->guest_table_lock);
 	spin_unlock(ptl);
 	radix_tree_preload_end();
 	return rc;
@@ -856,7 +879,7 @@ static pte_t *gmap_pte_op_walk(struct gmap *gmap, unsigned long gaddr,
 }
 
 /**
- * gmap_pte_op_fixup - force a page in and connect the gmap page table
+ * gmap_fixup - force memory in and connect the gmap table entry
  * @gmap: pointer to guest mapping meta data structure
  * @gaddr: virtual address in the guest address space
  * @vmaddr: address in the host process address space
@@ -864,10 +887,10 @@ static pte_t *gmap_pte_op_walk(struct gmap *gmap, unsigned long gaddr,
  *
  * Returns 0 if the caller can retry __gmap_translate (might fail again),
  * -ENOMEM if out of memory and -EFAULT if anything goes wrong while fixing
- * up or connecting the gmap page table.
+ * up or connecting the gmap table entry.
  */
-static int gmap_pte_op_fixup(struct gmap *gmap, unsigned long gaddr,
-			     unsigned long vmaddr, int prot)
+static int gmap_fixup(struct gmap *gmap, unsigned long gaddr,
+		      unsigned long vmaddr, int prot)
 {
 	struct mm_struct *mm = gmap->mm;
 	unsigned int fault_flags;
@@ -953,6 +976,76 @@ static inline void gmap_pmd_op_end(spinlock_t *ptl)
 		spin_unlock(ptl);
 }
 
+static pte_t *gmap_pte_from_pmd(struct gmap *gmap, pmd_t *pmdp,
+				unsigned long addr, spinlock_t **ptl)
+{
+	*ptl = NULL;
+	if (likely(!gmap_pmd_is_split(pmdp)))
+		return pte_alloc_map_lock(gmap->mm, pmdp, addr, ptl);
+
+	return pte_offset_map(pmdp, addr);
+}
+
+/**
+ * gmap_pmd_split_free - Free a split pmd's page table
+ * @pmdp The split pmd that we free of its page table
+ *
+ * If the userspace pmds are exchanged, we'll remove the gmap pmds as
+ * well, so we fault on them and link them again. We would leak
+ * memory, if we didn't free split pmds here.
+ */
+static inline void gmap_pmd_split_free(struct gmap *gmap, pmd_t *pmdp)
+{
+	unsigned long pgt = pmd_val(*pmdp) & _SEGMENT_ENTRY_ORIGIN;
+	struct page *page;
+
+	if (gmap_pmd_is_split(pmdp)) {
+		page = pfn_to_page(pgt >> PAGE_SHIFT);
+		spin_lock(&gmap->split_list_lock);
+		list_del(&page->lru);
+		spin_unlock(&gmap->split_list_lock);
+		page_table_free_pgste(page);
+	}
+}
+
+/**
+ * gmap_pmd_split - Split a huge gmap pmd and use a page table instead
+ * @gmap: pointer to guest mapping meta data structure
+ * @gaddr: virtual address in the guest address space
+ * @pmdp: pointer to the pmd that will be split
+ * @pgtable: Pre-allocated page table
+ *
+ * When splitting gmap pmds, we have to make the resulting page table
+ * look like it's a normal one to be able to use the common pte
+ * handling functions. Also we need to track these new tables as they
+ * aren't tracked anywhere else.
+ */
+static void gmap_pmd_split(struct gmap *gmap, unsigned long gaddr,
+			   pmd_t *pmdp, struct page *page)
+{
+	unsigned long *ptable = (unsigned long *) page_to_phys(page);
+	pmd_t new;
+	int i;
+
+	for (i = 0; i < 256; i++) {
+		ptable[i] = (pmd_val(*pmdp) & HPAGE_MASK) + i * PAGE_SIZE;
+		/* Carry over hardware permission from the pmd */
+		if (pmd_val(*pmdp) & _SEGMENT_ENTRY_PROTECT)
+			ptable[i] |= _PAGE_PROTECT;
+		/* pmd_large() implies pmd/pte_present() */
+		ptable[i] |=  _PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE;
+		/* ptes are directly marked as dirty */
+		ptable[i + PTRS_PER_PTE] |= PGSTE_UC_BIT;
+	}
+
+	pmd_val(new) = ((unsigned long)ptable | _SEGMENT_ENTRY |
+			(_SEGMENT_ENTRY_GMAP_SPLIT));
+	spin_lock(&gmap->split_list_lock);
+	list_add(&page->lru, &gmap->split_list);
+	spin_unlock(&gmap->split_list_lock);
+	gmap_pmdp_xchg(gmap, pmdp, new, gaddr);
+}
+
 /*
  * gmap_protect_pmd - remove access rights to memory and set pmd notification bits
  * @pmdp: pointer to the pmd to be protected
@@ -1041,7 +1134,8 @@ static int gmap_protect_pte(struct gmap *gmap, unsigned long gaddr,
 static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 			      unsigned long len, int prot, unsigned long bits)
 {
-	unsigned long vmaddr, dist;
+	struct page *page = NULL;
+	unsigned long vmaddr;
 	spinlock_t *ptl_pmd = NULL, *ptl_pte = NULL;
 	pmd_t *pmdp;
 	pte_t *ptep;
@@ -1050,12 +1144,12 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 	BUG_ON(gmap_is_shadow(gmap));
 	while (len) {
 		rc = -EAGAIN;
+
 		pmdp = gmap_pmd_op_walk(gmap, gaddr, &ptl_pmd);
-		if (pmdp) {
+		if (pmdp && !(pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)) {
 			if (!pmd_large(*pmdp)) {
-				ptl_pte = NULL;
-				ptep = pte_alloc_map_lock(gmap->mm, pmdp, gaddr,
-							  &ptl_pte);
+				ptep = gmap_pte_from_pmd(gmap, pmdp, gaddr,
+							 &ptl_pte);
 				if (ptep)
 					rc = gmap_protect_pte(gmap, gaddr,
 							      ptep, prot, bits);
@@ -1067,25 +1161,33 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 					gaddr += PAGE_SIZE;
 				}
 			} else {
-				rc = gmap_protect_pmd(gmap, gaddr, pmdp, prot,
-						      bits);
-				if (!rc) {
-					dist = HPAGE_SIZE - (gaddr & ~HPAGE_MASK);
-					len = len < dist ? 0 : len - dist;
-					gaddr = (gaddr & HPAGE_MASK) + HPAGE_SIZE;
+				if (!page) {
+					/* Drop locks for allocation. */
+					gmap_pmd_op_end(ptl_pmd);
+					ptl_pmd = NULL;
+					page = page_table_alloc_pgste(gmap->mm);
+					if (!page)
+						return -ENOMEM;
+					continue;
+				} else {
+					gmap_pmd_split(gmap, gaddr,
+						       pmdp, page);
+					page = NULL;
 				}
 			}
 			gmap_pmd_op_end(ptl_pmd);
 		}
+		if (page)
+			page_table_free_pgste(page);
 		if (rc) {
-			if (rc == -EINVAL)
+			if (rc == -EINVAL || rc == -ENOMEM)
 				return rc;
 
 			/* -EAGAIN, fixup of userspace mm and gmap */
 			vmaddr = __gmap_translate(gmap, gaddr);
 			if (IS_ERR_VALUE(vmaddr))
 				return vmaddr;
-			rc = gmap_pte_op_fixup(gmap, gaddr, vmaddr, prot);
+			rc = gmap_fixup(gmap, gaddr, vmaddr, prot);
 			if (rc)
 				return rc;
 		}
@@ -1168,7 +1270,7 @@ int gmap_read_table(struct gmap *gmap, unsigned long gaddr, unsigned long *val)
 			rc = vmaddr;
 			break;
 		}
-		rc = gmap_pte_op_fixup(gmap, gaddr, vmaddr, PROT_READ);
+		rc = gmap_fixup(gmap, gaddr, vmaddr, PROT_READ);
 		if (rc)
 			break;
 	}
@@ -1251,7 +1353,7 @@ static int gmap_protect_rmap(struct gmap *sg, unsigned long raddr,
 		radix_tree_preload_end();
 		if (rc) {
 			kfree(rmap);
-			rc = gmap_pte_op_fixup(parent, paddr, vmaddr, PROT_READ);
+			rc = gmap_fixup(parent, paddr, vmaddr, PROT_READ);
 			if (rc)
 				return rc;
 			continue;
@@ -2165,7 +2267,7 @@ int gmap_shadow_page(struct gmap *sg, unsigned long saddr, pte_t pte)
 		radix_tree_preload_end();
 		if (!rc)
 			break;
-		rc = gmap_pte_op_fixup(parent, paddr, vmaddr, prot);
+		rc = gmap_fixup(parent, paddr, vmaddr, prot);
 		if (rc)
 			break;
 	}
@@ -2231,6 +2333,30 @@ static void gmap_shadow_notify(struct gmap *sg, unsigned long vmaddr,
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
+static void ptep_notify_gmap(struct gmap *gmap, unsigned long gaddr,
+			     unsigned long vmaddr, unsigned long bits)
+{
+	struct gmap *sg, *next;
+
+	if (!list_empty(&gmap->children) && (bits & PGSTE_VSIE_BIT)) {
+		spin_lock(&gmap->shadow_lock);
+		list_for_each_entry_safe(sg, next, &gmap->children, list)
+			gmap_shadow_notify(sg, vmaddr, gaddr);
+		spin_unlock(&gmap->shadow_lock);
+	}
+	if (bits & PGSTE_IN_BIT)
+		gmap_call_notifier(gmap, gaddr, gaddr + PAGE_SIZE - 1);
+}
+
 /**
  * ptep_notify - call all invalidation callbacks for a specific pte.
  * @mm: pointer to the process mm_struct
@@ -2246,7 +2372,7 @@ void ptep_notify(struct mm_struct *mm, unsigned long vmaddr,
 {
 	unsigned long offset, gaddr = 0;
 	unsigned long *table;
-	struct gmap *gmap, *sg, *next;
+	struct gmap *gmap;
 
 	offset = ((unsigned long) pte) & (255 * sizeof(pte_t));
 	offset = offset * (PAGE_SIZE / sizeof(pte_t));
@@ -2261,23 +2387,34 @@ void ptep_notify(struct mm_struct *mm, unsigned long vmaddr,
 		if (!table)
 			continue;
 
-		if (!list_empty(&gmap->children) && (bits & PGSTE_VSIE_BIT)) {
-			spin_lock(&gmap->shadow_lock);
-			list_for_each_entry_safe(sg, next,
-						 &gmap->children, list)
-				gmap_shadow_notify(sg, vmaddr, gaddr);
-			spin_unlock(&gmap->shadow_lock);
-		}
-		if (bits & PGSTE_IN_BIT)
-			gmap_call_notifier(gmap, gaddr, gaddr + PAGE_SIZE - 1);
+		ptep_notify_gmap(gmap, gaddr, vmaddr, bits);
 	}
 	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(ptep_notify);
 
-static void pmdp_notify_gmap(struct gmap *gmap, pmd_t *pmdp,
-			     unsigned long gaddr)
+static inline void pmdp_notify_split(struct gmap *gmap, pmd_t *pmdp,
+				     unsigned long gaddr, unsigned long vmaddr)
 {
+	int i = 0;
+	unsigned long bits;
+	pte_t *ptep = (pte_t *)(pmd_val(*pmdp) & PAGE_MASK);
+
+	for (; i < 256; i++, gaddr += PAGE_SIZE, vmaddr += PAGE_SIZE, ptep++) {
+		bits = ptep_get_and_clear_notification_bits(ptep);
+		if (bits)
+			ptep_notify_gmap(gmap, gaddr, vmaddr, bits);
+	}
+}
+
+static void pmdp_notify_gmap(struct gmap *gmap, pmd_t *pmdp,
+			     unsigned long gaddr, unsigned long vmaddr)
+{
+	if (gmap_pmd_is_split(pmdp))
+		return pmdp_notify_split(gmap, pmdp, gaddr, vmaddr);
+
+	if (!(pmd_val(*pmdp) & _SEGMENT_ENTRY_GMAP_IN))
+		return;
 	pmd_val(*pmdp) &= ~_SEGMENT_ENTRY_GMAP_IN;
 	gmap_call_notifier(gmap, gaddr, gaddr + HPAGE_SIZE - 1);
 }
@@ -2296,8 +2433,9 @@ static void gmap_pmdp_xchg(struct gmap *gmap, pmd_t *pmdp, pmd_t new,
 			   unsigned long gaddr)
 {
 	gaddr &= HPAGE_MASK;
-	pmdp_notify_gmap(gmap, pmdp, gaddr);
-	pmd_val(new) &= ~_SEGMENT_ENTRY_GMAP_IN;
+	pmdp_notify_gmap(gmap, pmdp, gaddr, 0);
+	if (pmd_large(new))
+		pmd_val(new) &= ~GMAP_SEGMENT_NOTIFY_BITS;
 	if (MACHINE_HAS_TLB_GUEST)
 		__pmdp_idte(gaddr, pmdp, IDTE_GUEST_ASCE, gmap->asce,
 			    IDTE_GLOBAL);
@@ -2322,11 +2460,13 @@ static void gmap_pmdp_clear(struct mm_struct *mm, unsigned long vmaddr,
 						  vmaddr >> PMD_SHIFT);
 		if (pmdp) {
 			gaddr = __gmap_segment_gaddr((unsigned long *)pmdp);
-			pmdp_notify_gmap(gmap, pmdp, gaddr);
-			WARN_ON(pmd_val(*pmdp) & ~(_SEGMENT_ENTRY_HARDWARE_BITS_LARGE |
-						   _SEGMENT_ENTRY_GMAP_UC));
+			pmdp_notify_gmap(gmap, pmdp, gaddr, vmaddr);
+			if (pmd_large(*pmdp))
+				WARN_ON(pmd_val(*pmdp) &
+					GMAP_SEGMENT_NOTIFY_BITS);
 			if (purge)
 				__pmdp_csp(pmdp);
+			gmap_pmd_split_free(gmap, pmdp);
 			pmd_val(*pmdp) = _SEGMENT_ENTRY_EMPTY;
 		}
 		spin_unlock(&gmap->guest_table_lock);
@@ -2376,14 +2516,15 @@ void gmap_pmdp_idte_local(struct mm_struct *mm, unsigned long vmaddr)
 		if (entry) {
 			pmdp = (pmd_t *)entry;
 			gaddr = __gmap_segment_gaddr(entry);
-			pmdp_notify_gmap(gmap, pmdp, gaddr);
-			WARN_ON(*entry & ~(_SEGMENT_ENTRY_HARDWARE_BITS_LARGE |
-					   _SEGMENT_ENTRY_GMAP_UC));
+			pmdp_notify_gmap(gmap, pmdp, gaddr, vmaddr);
+			if (pmd_large(*pmdp))
+				WARN_ON(*entry & GMAP_SEGMENT_NOTIFY_BITS);
 			if (MACHINE_HAS_TLB_GUEST)
 				__pmdp_idte(gaddr, pmdp, IDTE_GUEST_ASCE,
 					    gmap->asce, IDTE_LOCAL);
 			else if (MACHINE_HAS_IDTE)
 				__pmdp_idte(gaddr, pmdp, 0, 0, IDTE_LOCAL);
+			gmap_pmd_split_free(gmap, pmdp);
 			*entry = _SEGMENT_ENTRY_EMPTY;
 		}
 		spin_unlock(&gmap->guest_table_lock);
@@ -2411,9 +2552,9 @@ void gmap_pmdp_idte_global(struct mm_struct *mm, unsigned long vmaddr)
 		if (entry) {
 			pmdp = (pmd_t *)entry;
 			gaddr = __gmap_segment_gaddr(entry);
-			pmdp_notify_gmap(gmap, pmdp, gaddr);
-			WARN_ON(*entry & ~(_SEGMENT_ENTRY_HARDWARE_BITS_LARGE |
-					   _SEGMENT_ENTRY_GMAP_UC));
+			pmdp_notify_gmap(gmap, pmdp, gaddr, vmaddr);
+			if (pmd_large(*pmdp))
+				WARN_ON(*entry & GMAP_SEGMENT_NOTIFY_BITS);
 			if (MACHINE_HAS_TLB_GUEST)
 				__pmdp_idte(gaddr, pmdp, IDTE_GUEST_ASCE,
 					    gmap->asce, IDTE_GLOBAL);
@@ -2421,6 +2562,7 @@ void gmap_pmdp_idte_global(struct mm_struct *mm, unsigned long vmaddr)
 				__pmdp_idte(gaddr, pmdp, 0, 0, IDTE_GLOBAL);
 			else
 				__pmdp_csp(pmdp);
+			gmap_pmd_split_free(gmap, pmdp);
 			*entry = _SEGMENT_ENTRY_EMPTY;
 		}
 		spin_unlock(&gmap->guest_table_lock);
@@ -2471,9 +2613,10 @@ void gmap_sync_dirty_log_pmd(struct gmap *gmap, unsigned long bitmap[4],
 	int i;
 	pmd_t *pmdp;
 	pte_t *ptep;
-	spinlock_t *ptl = NULL;
+	spinlock_t *ptl_pmd = NULL;
+	spinlock_t *ptl_pte = NULL;
 
-	pmdp = gmap_pmd_op_walk(gmap, gaddr, &ptl);
+	pmdp = gmap_pmd_op_walk(gmap, gaddr, &ptl_pmd);
 	if (!pmdp)
 		return;
 
@@ -2482,15 +2625,15 @@ void gmap_sync_dirty_log_pmd(struct gmap *gmap, unsigned long bitmap[4],
 			bitmap_fill(bitmap, _PAGE_ENTRIES);
 	} else {
 		for (i = 0; i < _PAGE_ENTRIES; i++, vmaddr += PAGE_SIZE) {
-			ptep = pte_alloc_map_lock(gmap->mm, pmdp, vmaddr, &ptl);
+			ptep = gmap_pte_from_pmd(gmap, pmdp, vmaddr, &ptl_pte);
 			if (!ptep)
 				continue;
 			if (ptep_test_and_clear_uc(gmap->mm, vmaddr, ptep))
 				set_bit(i, bitmap);
-			spin_unlock(ptl);
+			gmap_pte_op_end(ptl_pte);
 		}
 	}
-	gmap_pmd_op_end(ptl);
+	gmap_pmd_op_end(ptl_pmd);
 }
 EXPORT_SYMBOL_GPL(gmap_sync_dirty_log_pmd);
 
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 4b184744350b..55855192c41f 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -719,6 +719,39 @@ void ptep_zap_key(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 	preempt_enable();
 }
 
+unsigned long ptep_get_and_clear_notification_bits(pte_t *ptep)
+{
+	pgste_t pgste;
+	unsigned long bits;
+
+	pgste = pgste_get_lock(ptep);
+	bits = pgste_val(pgste) & (PGSTE_IN_BIT | PGSTE_VSIE_BIT);
+	pgste_val(pgste) ^= bits;
+	pgste_set_unlock(ptep, pgste);
+
+	return bits;
+}
+EXPORT_SYMBOL_GPL(ptep_get_and_clear_notification_bits);
+
+void ptep_remove_protection_split(struct mm_struct *mm, pte_t *ptep,
+				  unsigned long gaddr)
+{
+	pte_t pte;
+	pgste_t pgste;
+
+	pgste = pgste_get_lock(ptep);
+	pgste_val(pgste) |= PGSTE_UC_BIT;
+	pte = *ptep;
+	pte_val(pte) &= ~_PAGE_PROTECT;
+
+	pgste = pgste_pte_notify(mm, gaddr, ptep, pgste);
+	ptep_ipte_global(mm, gaddr, ptep, 0);
+
+	*ptep = pte;
+	pgste_set_unlock(ptep, pgste);
+}
+EXPORT_SYMBOL_GPL(ptep_remove_protection_split);
+
 /*
  * Test and reset if a guest page is dirty
  */
-- 
2.14.3
