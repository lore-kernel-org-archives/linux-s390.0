From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [RFC/PATCH v3 04/16] s390/mm: add gmap PMD invalidation notification
Date: Fri,  9 Feb 2018 10:34:12 +0100
Message-ID: <1518168864-147803-5-git-send-email-frankja@linux.vnet.ibm.com>
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

For later migration of huge pages we want to write-protect guest
PMDs. While doing this, we have to make absolutely sure, that the
guest's lowcore is always accessible when the VCPU is running. With
PTEs, this is solved by marking the PGSTEs of the lowcore pages with
the invalidation notification bit and kicking the guest out of the SIE
via a notifier function if we need to invalidate such a page.

With PMDs we do not have PGSTEs or some other bits we could use in the
host PMD. Instead we pick one of the free bits in the gmap PMD. Every
time a host pmd will be invalidated, we will check if the respective
gmap PMD has the bit set and in that case fire up the notifier.

In the first step we only support setting the invalidation bit, but we
do not support restricting access of guest pmds. It will follow
shortly.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
---
 arch/s390/include/asm/gmap.h    |  15 +++
 arch/s390/include/asm/pgtable.h |   9 +-
 arch/s390/mm/gmap.c             | 197 +++++++++++++++++++++++++++++++++++++---
 arch/s390/mm/pgtable.c          |   4 +
 4 files changed, 209 insertions(+), 16 deletions(-)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index c1bc563..4324b2a 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -13,6 +13,9 @@
 #define GMAP_NOTIFY_SHADOW	0x2
 #define GMAP_NOTIFY_MPROT	0x1
 
+/* Status bits in the gmap segment entry. */
+#define _SEGMENT_ENTRY_GMAP_SPLIT	0x0001  /* split huge pmd */
+
 /**
  * struct gmap_struct - guest address space
  * @list: list head for the mm->context gmap list
@@ -52,6 +55,7 @@ struct gmap {
 	struct radix_tree_root host_to_rmap;
 	struct list_head children;
 	struct list_head pt_list;
+	struct list_head split_list;
 	spinlock_t shadow_lock;
 	struct gmap *parent;
 	unsigned long orig_asce;
@@ -92,6 +96,17 @@ static inline int gmap_is_shadow(struct gmap *gmap)
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
index 2d24d33..e9b56b9 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -269,8 +269,10 @@ static inline int is_module_addr(void *addr)
 #define _REGION_ENTRY_BITS_LARGE 0xffffffff8000fe2fUL
 
 /* Bits in the segment table entry */
-#define _SEGMENT_ENTRY_BITS	0xfffffffffffffe33UL
-#define _SEGMENT_ENTRY_BITS_LARGE 0xfffffffffff0ff33UL
+#define _SEGMENT_ENTRY_BITS			0xfffffffffffffe33UL
+#define _SEGMENT_ENTRY_BITS_LARGE 		0xfffffffffff0ff33UL
+#define _SEGMENT_ENTRY_HARDWARE_BITS		0xfffffffffffffe30UL
+#define _SEGMENT_ENTRY_HARDWARE_BITS_LARGE	0xfffffffffff00730UL
 #define _SEGMENT_ENTRY_ORIGIN_LARGE ~0xfffffUL /* large page address	    */
 #define _SEGMENT_ENTRY_ORIGIN	~0x7ffUL/* page table origin		    */
 #define _SEGMENT_ENTRY_PROTECT	0x200	/* segment protection bit	    */
@@ -1093,6 +1095,9 @@ void ptep_set_pte_at(struct mm_struct *mm, unsigned long addr,
 void ptep_set_notify(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
 void ptep_notify(struct mm_struct *mm, unsigned long addr,
 		 pte_t *ptep, unsigned long bits);
+void ptep_notify_gmap(struct mm_struct *mm, unsigned long vmaddr,
+		      pte_t *pte, unsigned long bits);
+void pmdp_notify(struct mm_struct *mm, unsigned long addr);
 int ptep_force_prot(struct mm_struct *mm, unsigned long gaddr,
 		    pte_t *ptep, int prot, unsigned long bit);
 void ptep_zap_unused(struct mm_struct *mm, unsigned long addr,
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 16c877a9..cb03e66 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -63,6 +63,7 @@ static struct gmap *gmap_alloc(unsigned long limit)
 	INIT_LIST_HEAD(&gmap->crst_list);
 	INIT_LIST_HEAD(&gmap->children);
 	INIT_LIST_HEAD(&gmap->pt_list);
+	INIT_LIST_HEAD(&gmap->split_list);
 	INIT_RADIX_TREE(&gmap->guest_to_host, GFP_KERNEL);
 	INIT_RADIX_TREE(&gmap->host_to_guest, GFP_ATOMIC);
 	INIT_RADIX_TREE(&gmap->host_to_rmap, GFP_ATOMIC);
@@ -194,6 +195,10 @@ static void gmap_free(struct gmap *gmap)
 	gmap_radix_tree_free(&gmap->guest_to_host);
 	gmap_radix_tree_free(&gmap->host_to_guest);
 
+	/* Free split pmd page tables */
+	list_for_each_entry_safe(page, next, &gmap->split_list, lru)
+		page_table_free_pgste(page);
+
 	/* Free additional data for a shadow gmap */
 	if (gmap_is_shadow(gmap)) {
 		/* Free all page tables. */
@@ -599,10 +604,15 @@ int __gmap_link(struct gmap *gmap, unsigned long gaddr, unsigned long vmaddr)
 	if (*table == _SEGMENT_ENTRY_EMPTY) {
 		rc = radix_tree_insert(&gmap->host_to_guest,
 				       vmaddr >> PMD_SHIFT, table);
-		if (!rc)
-			*table = pmd_val(*pmd);
-	} else
-		rc = 0;
+		if (!rc) {
+			if (pmd_large(*pmd)) {
+				*table = pmd_val(*pmd) &
+					_SEGMENT_ENTRY_HARDWARE_BITS_LARGE;
+			} else
+				*table = pmd_val(*pmd) &
+					_SEGMENT_ENTRY_HARDWARE_BITS;
+		}
+	}
 	spin_unlock(&gmap->guest_table_lock);
 	spin_unlock(ptl);
 	radix_tree_preload_end();
@@ -902,8 +912,11 @@ static inline pmd_t *gmap_pmd_op_walk(struct gmap *gmap, unsigned long gaddr)
 		return NULL;
 	}
 
-	/* 4k page table entries are locked via the pte (pte_alloc_map_lock). */
-	if (!pmd_large(*pmdp))
+	/*
+	 * Non-split 4k page table entries are locked via the pte
+	 * (pte_alloc_map_lock).
+	 */
+	if (!gmap_pmd_is_split(pmdp) && !pmd_large(*pmdp))
 		spin_unlock(&gmap->guest_table_lock);
 	return pmdp;
 }
@@ -915,10 +928,77 @@ static inline pmd_t *gmap_pmd_op_walk(struct gmap *gmap, unsigned long gaddr)
  */
 static inline void gmap_pmd_op_end(struct gmap *gmap, pmd_t *pmdp)
 {
-	if (pmd_large(*pmdp))
+	if (pmd_large(*pmdp) || gmap_pmd_is_split(pmdp))
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
@@ -941,7 +1021,7 @@ static int gmap_protect_pte(struct gmap *gmap, unsigned long gaddr,
 	spinlock_t *ptl = NULL;
 	unsigned long pbits = 0;
 
-	ptep = pte_alloc_map_lock(gmap->mm, pmdp, gaddr, &ptl);
+	ptep = gmap_pte_from_pmd(gmap, pmdp, gaddr, &ptl);
 	if (!ptep)
 		return -ENOMEM;
 
@@ -979,15 +1059,21 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 		rc = -EAGAIN;
 		pmdp = gmap_pmd_op_walk(gmap, gaddr);
 		if (pmdp && !(pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)) {
-			rc = gmap_protect_pte(gmap, gaddr, pmdp, prot,
-					      bits);
-			if (!rc) {
-				len -= PAGE_SIZE;
-				gaddr += PAGE_SIZE;
+			if (!pmd_large(*pmdp)) {
+				rc = gmap_protect_pte(gmap, gaddr, pmdp, prot,
+						      bits);
+				if (!rc) {
+					len -= PAGE_SIZE;
+					gaddr += PAGE_SIZE;
+				}
+			} else {
+				rc = gmap_pmd_split(gmap, gaddr, pmdp);
+				if (!rc)
+					rc = -EFAULT;
 			}
 			gmap_pmd_op_end(gmap, pmdp);
 		}
-		if (rc) {
+		if (rc && rc != -EFAULT) {
 			vmaddr = __gmap_translate(gmap, gaddr);
 			if (IS_ERR_VALUE(vmaddr))
 				return vmaddr;
@@ -2133,6 +2219,39 @@ static void gmap_shadow_notify(struct gmap *sg, unsigned long vmaddr,
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
+	struct gmap *gmap;
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
+		if (bits & PGSTE_IN_BIT)
+			gmap_call_notifier(gmap, gaddr, gaddr + PAGE_SIZE - 1);
+	}
+	rcu_read_unlock();
+}
+
 /**
  * ptep_notify - call all invalidation callbacks for a specific pte.
  * @mm: pointer to the process mm_struct
@@ -2177,6 +2296,23 @@ void ptep_notify(struct mm_struct *mm, unsigned long vmaddr,
 }
 EXPORT_SYMBOL_GPL(ptep_notify);
 
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
  * gmap_pmdp_xchg - exchange a gmap pmd with another and notify
  * @gmap: pointer to the guest address space structure
@@ -2202,6 +2338,39 @@ static void gmap_pmdp_xchg(struct gmap *gmap, pmd_t *pmdp, pmd_t new,
 	*pmdp = new;
 }
 
+/**
+ * pmdp_notify - call all invalidation callbacks for a specific pmd
+ * @mm: pointer to the process mm_struct
+ * @vmaddr: virtual address in the process address space
+ *
+ * This function is expected to be called with mmap_sem held in read.
+ */
+void pmdp_notify(struct mm_struct *mm, unsigned long vmaddr)
+{
+	unsigned long *table, gaddr;
+	struct gmap *gmap;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(gmap, &mm->context.gmap_list, list) {
+		spin_lock(&gmap->guest_table_lock);
+		table = radix_tree_lookup(&gmap->host_to_guest,
+					  vmaddr >> PMD_SHIFT);
+		if (!table) {
+			spin_unlock(&gmap->guest_table_lock);
+			continue;
+		}
+		gaddr = __gmap_segment_gaddr(table);
+		if (gmap_pmd_is_split((pmd_t *)table)) {
+			pmdp_notify_split(mm, vmaddr, table);
+			spin_unlock(&gmap->guest_table_lock);
+			continue;
+		}
+		spin_unlock(&gmap->guest_table_lock);
+	}
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL_GPL(pmdp_notify);
+
 static inline void thp_split_mm(struct mm_struct *mm)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 4f2b65d..a6cc540 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -405,6 +405,8 @@ pmd_t pmdp_xchg_direct(struct mm_struct *mm, unsigned long addr,
 	pmd_t old;
 
 	preempt_disable();
+	if (mm_has_pgste(mm))
+		pmdp_notify(mm, addr);
 	old = pmdp_flush_direct(mm, addr, pmdp);
 	*pmdp = new;
 	preempt_enable();
@@ -418,6 +420,8 @@ pmd_t pmdp_xchg_lazy(struct mm_struct *mm, unsigned long addr,
 	pmd_t old;
 
 	preempt_disable();
+	if (mm_has_pgste(mm))
+		pmdp_notify(mm, addr);
 	old = pmdp_flush_lazy(mm, addr, pmdp);
 	*pmdp = new;
 	preempt_enable();
-- 
2.7.4
