From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 05/51] s390/mm: add shadow gmap support
Date: Tue, 21 Jun 2016 15:12:43 +0200
Message-ID: <1466514809-146638-6-git-send-email-borntraeger@de.ibm.com>
References: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

For a nested KVM guest the outer KVM host needs to create shadow
page tables for the nested guest. This patch adds the basic support
to the guest address space (gmap) code.

For each guest address space the inner KVM host creates, the first
outer KVM host needs to create shadow page tables. The address space
is identified by the ASCE loaded into the control register 1 at the
time the inner SIE instruction for the second nested KVM guest is
executed. The outer KVM host creates the shadow tables starting with
the table identified by the ASCE on a on-demand basis. The outer KVM
host will get repeated faults for all the shadow tables needed to
run the second KVM guest.

While a shadow page table for the second KVM guest is active the access
to the origin region, segment and page tables needs to be restricted
for the first KVM guest. For region and segment and page tables the first
KVM guest may read the memory, but write attempt has to lead to an
unshadow.  This is done using the page invalid and read-only bits in the
page table of the first KVM guest. If the first guest re-accesses one of
the origin pages of a shadow, it gets a fault and the affected parts of
the shadow page table hierarchy needs to be removed again.

PGSTE tables don't have to be shadowed, as all interpretation assist can't
deal with the invalid bits in the shadow pte being set differently than
the original ones provided by the first KVM guest.

Many bug fixes and improvements by David Hildenbrand.

Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/gmap.h      |   52 +-
 arch/s390/include/asm/pgalloc.h   |    2 +
 arch/s390/include/asm/pgtable.h   |   10 +-
 arch/s390/include/asm/processor.h |    1 +
 arch/s390/mm/fault.c              |    1 +
 arch/s390/mm/gmap.c               | 1168 +++++++++++++++++++++++++++++++++++--
 arch/s390/mm/pgalloc.c            |   23 +
 arch/s390/mm/pgtable.c            |   57 +-
 8 files changed, 1271 insertions(+), 43 deletions(-)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index e69853c..58e65ee 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -10,6 +10,7 @@
 
 /**
  * struct gmap_struct - guest address space
+ * @list: list head for the mm->context gmap list
  * @crst_list: list of all crst tables used in the guest address space
  * @mm: pointer to the parent mm_struct
  * @guest_to_host: radix tree with guest to host address translation
@@ -19,6 +20,13 @@
  * @table: pointer to the page directory
  * @asce: address space control element for gmap page table
  * @pfault_enabled: defines if pfaults are applicable for the guest
+ * @host_to_rmap: radix tree with gmap_rmap lists
+ * @children: list of shadow gmap structures
+ * @pt_list: list of all page tables used in the shadow guest address space
+ * @shadow_lock: spinlock to protect the shadow gmap list
+ * @parent: pointer to the parent gmap for shadow guest address spaces
+ * @orig_asce: ASCE for which the shadow page table has been created
+ * @removed: flag to indicate if a shadow guest address space has been removed
  */
 struct gmap {
 	struct list_head list;
@@ -33,9 +41,33 @@ struct gmap {
 	unsigned long asce_end;
 	void *private;
 	bool pfault_enabled;
+	/* Additional data for shadow guest address spaces */
+	struct radix_tree_root host_to_rmap;
+	struct list_head children;
+	struct list_head pt_list;
+	spinlock_t shadow_lock;
+	struct gmap *parent;
+	unsigned long orig_asce;
+	bool removed;
 };
 
 /**
+ * struct gmap_rmap - reverse mapping for shadow page table entries
+ * @next: pointer to next rmap in the list
+ * @raddr: virtual rmap address in the shadow guest address space
+ */
+struct gmap_rmap {
+	struct gmap_rmap *next;
+	unsigned long raddr;
+};
+
+#define gmap_for_each_rmap(pos, head) \
+	for (pos = (head); pos; pos = pos->next)
+
+#define gmap_for_each_rmap_safe(pos, n, head) \
+	for (pos = (head); n = pos ? pos->next : NULL, pos; pos = n)
+
+/**
  * struct gmap_notifier - notify function block for page invalidation
  * @notifier_call: address of callback function
  */
@@ -46,6 +78,11 @@ struct gmap_notifier {
 			      unsigned long end);
 };
 
+static inline int gmap_is_shadow(struct gmap *gmap)
+{
+	return !!gmap->parent;
+}
+
 struct gmap *gmap_create(struct mm_struct *mm, unsigned long limit);
 void gmap_remove(struct gmap *gmap);
 struct gmap *gmap_get(struct gmap *gmap);
@@ -64,9 +101,22 @@ void gmap_discard(struct gmap *, unsigned long from, unsigned long to);
 void __gmap_zap(struct gmap *, unsigned long gaddr);
 void gmap_unlink(struct mm_struct *, unsigned long *table, unsigned long vmaddr);
 
+int gmap_read_table(struct gmap *gmap, unsigned long gaddr, unsigned long *val);
+
+struct gmap *gmap_shadow(struct gmap *parent, unsigned long asce);
+int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t);
+int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t);
+int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt);
+int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt);
+int gmap_shadow_pgt_lookup(struct gmap *sg, unsigned long saddr,
+			   unsigned long *pgt, int *dat_protection);
+int gmap_shadow_page(struct gmap *sg, unsigned long saddr,
+		     unsigned long paddr, int write);
+
 void gmap_register_pte_notifier(struct gmap_notifier *);
 void gmap_unregister_pte_notifier(struct gmap_notifier *);
-void gmap_pte_notify(struct mm_struct *, unsigned long addr, pte_t *);
+void gmap_pte_notify(struct mm_struct *, unsigned long addr, pte_t *,
+		     unsigned long bits);
 
 int gmap_mprotect_notify(struct gmap *, unsigned long start,
 			 unsigned long len, int prot);
diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
index da34cb6..f4eb984 100644
--- a/arch/s390/include/asm/pgalloc.h
+++ b/arch/s390/include/asm/pgalloc.h
@@ -19,8 +19,10 @@ unsigned long *crst_table_alloc(struct mm_struct *);
 void crst_table_free(struct mm_struct *, unsigned long *);
 
 unsigned long *page_table_alloc(struct mm_struct *);
+struct page *page_table_alloc_pgste(struct mm_struct *mm);
 void page_table_free(struct mm_struct *, unsigned long *);
 void page_table_free_rcu(struct mmu_gather *, unsigned long *, unsigned long);
+void page_table_free_pgste(struct page *page);
 extern int page_table_allocate_pgste;
 
 static inline void clear_table(unsigned long *s, unsigned long val, size_t n)
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 35dde6a..a6e7fc8 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -256,6 +256,7 @@ static inline int is_module_addr(void *addr)
 /* Bits in the region table entry */
 #define _REGION_ENTRY_ORIGIN	~0xfffUL/* region/segment table origin	    */
 #define _REGION_ENTRY_PROTECT	0x200	/* region protection bit	    */
+#define _REGION_ENTRY_OFFSET	0xc0	/* region table offset		    */
 #define _REGION_ENTRY_INVALID	0x20	/* invalid region table entry	    */
 #define _REGION_ENTRY_TYPE_MASK	0x0c	/* region/segment table type mask   */
 #define _REGION_ENTRY_TYPE_R1	0x0c	/* region first table type	    */
@@ -327,6 +328,7 @@ static inline int is_module_addr(void *addr)
 #define PGSTE_GC_BIT	0x0002000000000000UL
 #define PGSTE_UC_BIT	0x0000800000000000UL	/* user dirty (migration) */
 #define PGSTE_IN_BIT	0x0000400000000000UL	/* IPTE notify bit */
+#define PGSTE_VSIE_BIT	0x0000200000000000UL	/* ref'd in a shadow table */
 
 /* Guest Page State used for virtualization */
 #define _PGSTE_GPS_ZERO		0x0000000080000000UL
@@ -885,12 +887,16 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
 void ptep_set_pte_at(struct mm_struct *mm, unsigned long addr,
 		     pte_t *ptep, pte_t entry);
 void ptep_set_notify(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
-void ptep_notify(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
+void ptep_notify(struct mm_struct *mm, unsigned long addr,
+		 pte_t *ptep, unsigned long bits);
 int ptep_force_prot(struct mm_struct *mm, unsigned long gaddr,
-		    pte_t *ptep, int prot);
+		    pte_t *ptep, int prot, unsigned long bit);
 void ptep_zap_unused(struct mm_struct *mm, unsigned long addr,
 		     pte_t *ptep , int reset);
 void ptep_zap_key(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
+int ptep_shadow_pte(struct mm_struct *mm, unsigned long saddr,
+		    pte_t *sptep, pte_t *tptep, int write);
+void ptep_unshadow_pte(struct mm_struct *mm, unsigned long saddr, pte_t *ptep);
 
 bool test_and_clear_guest_dirty(struct mm_struct *mm, unsigned long address);
 int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 9d4d311..94c80b6 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -109,6 +109,7 @@ struct thread_struct {
         unsigned long ksp;              /* kernel stack pointer             */
 	mm_segment_t mm_segment;
 	unsigned long gmap_addr;	/* address of last gmap fault. */
+	unsigned int gmap_write_flag;	/* gmap fault write indication */
 	unsigned int gmap_pfault;	/* signal of a pending guest pfault */
 	struct per_regs per_user;	/* User specified PER registers */
 	struct per_event per_event;	/* Cause of the last PER trap */
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 19288c1..b84416c 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -418,6 +418,7 @@ static inline int do_exception(struct pt_regs *regs, int access)
 		(struct gmap *) S390_lowcore.gmap : NULL;
 	if (gmap) {
 		current->thread.gmap_addr = address;
+		current->thread.gmap_write_flag = !!(flags & FAULT_FLAG_WRITE);
 		address = __gmap_translate(gmap, address);
 		if (address == -EFAULT) {
 			fault = VM_FAULT_BADMAP;
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index fe25f19..6695a09 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -55,9 +55,13 @@ static struct gmap *gmap_alloc(unsigned long limit)
 	if (!gmap)
 		goto out;
 	INIT_LIST_HEAD(&gmap->crst_list);
+	INIT_LIST_HEAD(&gmap->children);
+	INIT_LIST_HEAD(&gmap->pt_list);
 	INIT_RADIX_TREE(&gmap->guest_to_host, GFP_KERNEL);
 	INIT_RADIX_TREE(&gmap->host_to_guest, GFP_ATOMIC);
+	INIT_RADIX_TREE(&gmap->host_to_rmap, GFP_ATOMIC);
 	spin_lock_init(&gmap->guest_table_lock);
+	spin_lock_init(&gmap->shadow_lock);
 	atomic_set(&gmap->ref_count, 1);
 	page = alloc_pages(GFP_KERNEL, 2);
 	if (!page)
@@ -132,9 +136,38 @@ static void gmap_radix_tree_free(struct radix_tree_root *root)
 	} while (nr > 0);
 }
 
+static void gmap_rmap_radix_tree_free(struct radix_tree_root *root)
+{
+	struct gmap_rmap *rmap, *rnext, *head;
+	struct radix_tree_iter iter;
+	unsigned long indices[16];
+	unsigned long index;
+	void **slot;
+	int i, nr;
+
+	/* A radix tree is freed by deleting all of its entries */
+	index = 0;
+	do {
+		nr = 0;
+		radix_tree_for_each_slot(slot, root, &iter, index) {
+			indices[nr] = iter.index;
+			if (++nr == 16)
+				break;
+		}
+		for (i = 0; i < nr; i++) {
+			index = indices[i];
+			head = radix_tree_delete(root, index);
+			gmap_for_each_rmap_safe(rmap, rnext, head)
+				kfree(rmap);
+		}
+	} while (nr > 0);
+}
+
 /**
  * gmap_free - free a guest address space
  * @gmap: pointer to the guest address space structure
+ *
+ * No locks required. There are no references to this gmap anymore.
  */
 static void gmap_free(struct gmap *gmap)
 {
@@ -145,6 +178,17 @@ static void gmap_free(struct gmap *gmap)
 		__free_pages(page, 2);
 	gmap_radix_tree_free(&gmap->guest_to_host);
 	gmap_radix_tree_free(&gmap->host_to_guest);
+
+	/* Free additional data for a shadow gmap */
+	if (gmap_is_shadow(gmap)) {
+		/* Free all page tables. */
+		list_for_each_entry_safe(page, next, &gmap->pt_list, lru)
+			page_table_free_pgste(page);
+		gmap_rmap_radix_tree_free(&gmap->host_to_rmap);
+		/* Release reference to the parent */
+		gmap_put(gmap->parent);
+	}
+
 	kfree(gmap);
 }
 
@@ -180,8 +224,20 @@ EXPORT_SYMBOL_GPL(gmap_put);
  */
 void gmap_remove(struct gmap *gmap)
 {
+	struct gmap *sg, *next;
+
 	/* Flush tlb. */
 	gmap_flush_tlb(gmap);
+	/* Remove all shadow gmaps linked to this gmap */
+	if (!list_empty(&gmap->children)) {
+		spin_lock(&gmap->shadow_lock);
+		list_for_each_entry_safe(sg, next, &gmap->children, list) {
+			gmap_flush_tlb(sg);
+			list_del(&sg->list);
+			gmap_put(sg);
+		}
+		spin_unlock(&gmap->shadow_lock);
+	}
 	/* Remove gmap from the pre-mm list */
 	spin_lock(&gmap->mm->context.gmap_lock);
 	list_del_rcu(&gmap->list);
@@ -227,7 +283,7 @@ static int gmap_alloc_table(struct gmap *gmap, unsigned long *table,
 		return -ENOMEM;
 	new = (unsigned long *) page_to_phys(page);
 	crst_table_init(new, init);
-	spin_lock(&gmap->mm->page_table_lock);
+	spin_lock(&gmap->guest_table_lock);
 	if (*table & _REGION_ENTRY_INVALID) {
 		list_add(&page->lru, &gmap->crst_list);
 		*table = (unsigned long) new | _REGION_ENTRY_LENGTH |
@@ -235,7 +291,7 @@ static int gmap_alloc_table(struct gmap *gmap, unsigned long *table,
 		page->index = gaddr;
 		page = NULL;
 	}
-	spin_unlock(&gmap->mm->page_table_lock);
+	spin_unlock(&gmap->guest_table_lock);
 	if (page)
 		__free_pages(page, 2);
 	return 0;
@@ -271,6 +327,7 @@ static int __gmap_unlink_by_vmaddr(struct gmap *gmap, unsigned long vmaddr)
 	unsigned long *entry;
 	int flush = 0;
 
+	BUG_ON(gmap_is_shadow(gmap));
 	spin_lock(&gmap->guest_table_lock);
 	entry = radix_tree_delete(&gmap->host_to_guest, vmaddr >> PMD_SHIFT);
 	if (entry) {
@@ -310,6 +367,7 @@ int gmap_unmap_segment(struct gmap *gmap, unsigned long to, unsigned long len)
 	unsigned long off;
 	int flush;
 
+	BUG_ON(gmap_is_shadow(gmap));
 	if ((to | len) & (PMD_SIZE - 1))
 		return -EINVAL;
 	if (len == 0 || to + len < to)
@@ -341,6 +399,7 @@ int gmap_map_segment(struct gmap *gmap, unsigned long from,
 	unsigned long off;
 	int flush;
 
+	BUG_ON(gmap_is_shadow(gmap));
 	if ((from | to | len) & (PMD_SIZE - 1))
 		return -EINVAL;
 	if (len == 0 || from + len < from || to + len < to ||
@@ -378,6 +437,8 @@ EXPORT_SYMBOL_GPL(gmap_map_segment);
  * This function does not establish potentially missing page table entries.
  * The mmap_sem of the mm that belongs to the address space must be held
  * when this function gets called.
+ *
+ * Note: Can also be called for shadow gmaps.
  */
 unsigned long __gmap_translate(struct gmap *gmap, unsigned long gaddr)
 {
@@ -385,6 +446,7 @@ unsigned long __gmap_translate(struct gmap *gmap, unsigned long gaddr)
 
 	vmaddr = (unsigned long)
 		radix_tree_lookup(&gmap->guest_to_host, gaddr >> PMD_SHIFT);
+	/* Note: guest_to_host is empty for a shadow gmap */
 	return vmaddr ? (vmaddr | (gaddr & ~PMD_MASK)) : -EFAULT;
 }
 EXPORT_SYMBOL_GPL(__gmap_translate);
@@ -451,6 +513,7 @@ int __gmap_link(struct gmap *gmap, unsigned long gaddr, unsigned long vmaddr)
 	pmd_t *pmd;
 	int rc;
 
+	BUG_ON(gmap_is_shadow(gmap));
 	/* Create higher level tables in the gmap page table */
 	table = gmap->table;
 	if ((gmap->asce & _ASCE_TYPE_MASK) >= _ASCE_TYPE_REGION1) {
@@ -646,36 +709,65 @@ static void gmap_call_notifier(struct gmap *gmap, unsigned long start,
  * gmap_table_walk - walk the gmap page tables
  * @gmap: pointer to guest mapping meta data structure
  * @gaddr: virtual address in the guest address space
+ * @level: page table level to stop at
  *
- * Returns a table pointer for the given guest address.
+ * Returns a table entry pointer for the given guest address and @level
+ * @level=0 : returns a pointer to a page table table entry (or NULL)
+ * @level=1 : returns a pointer to a segment table entry (or NULL)
+ * @level=2 : returns a pointer to a region-3 table entry (or NULL)
+ * @level=3 : returns a pointer to a region-2 table entry (or NULL)
+ * @level=4 : returns a pointer to a region-1 table entry (or NULL)
+ *
+ * Returns NULL if the gmap page tables could not be walked to the
+ * requested level.
+ *
+ * Note: Can also be called for shadow gmaps.
  */
 static inline unsigned long *gmap_table_walk(struct gmap *gmap,
-					     unsigned long gaddr)
+					     unsigned long gaddr, int level)
 {
 	unsigned long *table;
 
+	if ((gmap->asce & _ASCE_TYPE_MASK) + 4 < (level * 4))
+		return NULL;
+	if (gmap_is_shadow(gmap) && gmap->removed)
+		return NULL;
+	if (gaddr & (-1UL << (31 + ((gmap->asce & _ASCE_TYPE_MASK) >> 2)*11)))
+		return NULL;
 	table = gmap->table;
 	switch (gmap->asce & _ASCE_TYPE_MASK) {
 	case _ASCE_TYPE_REGION1:
 		table += (gaddr >> 53) & 0x7ff;
+		if (level == 4)
+			break;
 		if (*table & _REGION_ENTRY_INVALID)
 			return NULL;
 		table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
 		/* Fallthrough */
 	case _ASCE_TYPE_REGION2:
 		table += (gaddr >> 42) & 0x7ff;
+		if (level == 3)
+			break;
 		if (*table & _REGION_ENTRY_INVALID)
 			return NULL;
 		table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
 		/* Fallthrough */
 	case _ASCE_TYPE_REGION3:
 		table += (gaddr >> 31) & 0x7ff;
+		if (level == 2)
+			break;
 		if (*table & _REGION_ENTRY_INVALID)
 			return NULL;
 		table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
 		/* Fallthrough */
 	case _ASCE_TYPE_SEGMENT:
 		table += (gaddr >> 20) & 0x7ff;
+		if (level == 1)
+			break;
+		if (*table & _REGION_ENTRY_INVALID)
+			return NULL;
+		table = (unsigned long *)(*table & _SEGMENT_ENTRY_ORIGIN);
+		table += (gaddr >> 12) & 0xff;
 	}
 	return table;
 }
@@ -688,16 +780,27 @@ static inline unsigned long *gmap_table_walk(struct gmap *gmap,
  * @ptl: pointer to the spinlock pointer
  *
  * Returns a pointer to the locked pte for a guest address, or NULL
+ *
+ * Note: Can also be called for shadow gmaps.
  */
 static pte_t *gmap_pte_op_walk(struct gmap *gmap, unsigned long gaddr,
 			       spinlock_t **ptl)
 {
 	unsigned long *table;
 
+	if (gmap_is_shadow(gmap))
+		spin_lock(&gmap->guest_table_lock);
 	/* Walk the gmap page table, lock and get pte pointer */
-	table = gmap_table_walk(gmap, gaddr);
-	if (!table || *table & _SEGMENT_ENTRY_INVALID)
+	table = gmap_table_walk(gmap, gaddr, 1); /* get segment pointer */
+	if (!table || *table & _SEGMENT_ENTRY_INVALID) {
+		if (gmap_is_shadow(gmap))
+			spin_unlock(&gmap->guest_table_lock);
 		return NULL;
+	}
+	if (gmap_is_shadow(gmap)) {
+		*ptl = &gmap->guest_table_lock;
+		return pte_offset_map((pmd_t *) table, gaddr);
+	}
 	return pte_alloc_map_lock(gmap->mm, (pmd_t *) table, gaddr, ptl);
 }
 
@@ -717,6 +820,7 @@ static int gmap_pte_op_fixup(struct gmap *gmap, unsigned long gaddr,
 	struct mm_struct *mm = gmap->mm;
 	bool unlocked = false;
 
+	BUG_ON(gmap_is_shadow(gmap));
 	if (fixup_user_fault(current, mm, vmaddr, FAULT_FLAG_WRITE, &unlocked))
 		return -EFAULT;
 	if (unlocked)
@@ -735,6 +839,51 @@ static void gmap_pte_op_end(spinlock_t *ptl)
 	spin_unlock(ptl);
 }
 
+/*
+ * gmap_protect_range - remove access rights to memory and set pgste bits
+ * @gmap: pointer to guest mapping meta data structure
+ * @gaddr: virtual address in the guest address space
+ * @len: size of area
+ * @prot: indicates access rights: PROT_NONE, PROT_READ or PROT_WRITE
+ * @bits: pgste notification bits to set
+ *
+ * Returns 0 if successfully protected, -ENOMEM if out of memory and
+ * -EFAULT if gaddr is invalid (or mapping for shadows is missing).
+ *
+ * Called with sg->mm->mmap_sem in read.
+ *
+ * Note: Can also be called for shadow gmaps.
+ */
+static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
+			      unsigned long len, int prot, unsigned long bits)
+{
+	unsigned long vmaddr;
+	spinlock_t *ptl;
+	pte_t *ptep;
+	int rc;
+
+	while (len) {
+		rc = -EAGAIN;
+		ptep = gmap_pte_op_walk(gmap, gaddr, &ptl);
+		if (ptep) {
+			rc = ptep_force_prot(gmap->mm, gaddr, ptep, prot, bits);
+			gmap_pte_op_end(ptl);
+		}
+		if (rc) {
+			vmaddr = __gmap_translate(gmap, gaddr);
+			if (IS_ERR_VALUE(vmaddr))
+				return vmaddr;
+			rc = gmap_pte_op_fixup(gmap, gaddr, vmaddr);
+			if (rc)
+				return rc;
+			continue;
+		}
+		gaddr += PAGE_SIZE;
+		len -= PAGE_SIZE;
+	}
+	return 0;
+}
+
 /**
  * gmap_mprotect_notify - change access rights for a range of ptes and
  *                        call the notifier if any pte changes again
@@ -752,61 +901,1012 @@ static void gmap_pte_op_end(spinlock_t *ptl)
 int gmap_mprotect_notify(struct gmap *gmap, unsigned long gaddr,
 			 unsigned long len, int prot)
 {
-	unsigned long vmaddr;
-	spinlock_t *ptl;
-	pte_t *ptep;
-	int rc = 0;
+	int rc;
 
-	if ((gaddr & ~PAGE_MASK) || (len & ~PAGE_MASK))
+	if ((gaddr & ~PAGE_MASK) || (len & ~PAGE_MASK) || gmap_is_shadow(gmap))
 		return -EINVAL;
 	if (!MACHINE_HAS_ESOP && prot == PROT_READ)
 		return -EINVAL;
 	down_read(&gmap->mm->mmap_sem);
-	while (len) {
-		rc = -EAGAIN;
-		ptep = gmap_pte_op_walk(gmap, gaddr, &ptl);
-		if (ptep) {
-			rc = ptep_force_prot(gmap->mm, gaddr, ptep, prot);
-			gmap_pte_op_end(ptl);
-		}
-		if (rc) {
-			vmaddr = __gmap_translate(gmap, gaddr);
-			if (IS_ERR_VALUE(vmaddr)) {
-				rc = vmaddr;
-				break;
-			}
-			rc = gmap_pte_op_fixup(gmap, gaddr, vmaddr);
-			if (rc)
-				break;
-			continue;
-		}
-		gaddr += PAGE_SIZE;
-		len -= PAGE_SIZE;
-	}
+	rc = gmap_protect_range(gmap, gaddr, len, prot, PGSTE_IN_BIT);
 	up_read(&gmap->mm->mmap_sem);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(gmap_mprotect_notify);
 
 /**
+ * gmap_read_table - get an unsigned long value from a guest page table using
+ *                   absolute addressing, without marking the page referenced.
+ * @gmap: pointer to guest mapping meta data structure
+ * @gaddr: virtual address in the guest address space
+ * @val: pointer to the unsigned long value to return
+ *
+ * Returns 0 if the value was read, -ENOMEM if out of memory and -EFAULT
+ * if reading using the virtual address failed.
+ *
+ * Called with gmap->mm->mmap_sem in read.
+ */
+int gmap_read_table(struct gmap *gmap, unsigned long gaddr, unsigned long *val)
+{
+	unsigned long address, vmaddr;
+	spinlock_t *ptl;
+	pte_t *ptep, pte;
+	int rc;
+
+	while (1) {
+		rc = -EAGAIN;
+		ptep = gmap_pte_op_walk(gmap, gaddr, &ptl);
+		if (ptep) {
+			pte = *ptep;
+			if (pte_present(pte) && (pte_val(pte) & _PAGE_READ)) {
+				address = pte_val(pte) & PAGE_MASK;
+				address += gaddr & ~PAGE_MASK;
+				*val = *(unsigned long *) address;
+				pte_val(*ptep) |= _PAGE_YOUNG;
+				/* Do *NOT* clear the _PAGE_INVALID bit! */
+				rc = 0;
+			}
+			gmap_pte_op_end(ptl);
+		}
+		if (!rc)
+			break;
+		vmaddr = __gmap_translate(gmap, gaddr);
+		if (IS_ERR_VALUE(vmaddr)) {
+			rc = vmaddr;
+			break;
+		}
+		rc = gmap_pte_op_fixup(gmap, gaddr, vmaddr);
+		if (rc)
+			break;
+	}
+	return rc;
+}
+EXPORT_SYMBOL_GPL(gmap_read_table);
+
+/**
+ * gmap_insert_rmap - add a rmap to the host_to_rmap radix tree
+ * @sg: pointer to the shadow guest address space structure
+ * @vmaddr: vm address associated with the rmap
+ * @rmap: pointer to the rmap structure
+ *
+ * Called with the sg->guest_table_lock
+ */
+static inline void gmap_insert_rmap(struct gmap *sg, unsigned long vmaddr,
+				    struct gmap_rmap *rmap)
+{
+	void **slot;
+
+	BUG_ON(!gmap_is_shadow(sg));
+	slot = radix_tree_lookup_slot(&sg->host_to_rmap, vmaddr >> PAGE_SHIFT);
+	if (slot) {
+		rmap->next = radix_tree_deref_slot_protected(slot,
+							&sg->guest_table_lock);
+		radix_tree_replace_slot(slot, rmap);
+	} else {
+		rmap->next = NULL;
+		radix_tree_insert(&sg->host_to_rmap, vmaddr >> PAGE_SHIFT,
+				  rmap);
+	}
+}
+
+/**
+ * gmap_protect_rmap - modify access rights to memory and create an rmap
+ * @sg: pointer to the shadow guest address space structure
+ * @raddr: rmap address in the shadow gmap
+ * @paddr: address in the parent guest address space
+ * @len: length of the memory area to protect
+ * @prot: indicates access rights: none, read-only or read-write
+ *
+ * Returns 0 if successfully protected and the rmap was created, -ENOMEM
+ * if out of memory and -EFAULT if paddr is invalid.
+ */
+static int gmap_protect_rmap(struct gmap *sg, unsigned long raddr,
+			     unsigned long paddr, unsigned long len, int prot)
+{
+	struct gmap *parent;
+	struct gmap_rmap *rmap;
+	unsigned long vmaddr;
+	spinlock_t *ptl;
+	pte_t *ptep;
+	int rc;
+
+	BUG_ON(!gmap_is_shadow(sg));
+	parent = sg->parent;
+	while (len) {
+		vmaddr = __gmap_translate(parent, paddr);
+		if (IS_ERR_VALUE(vmaddr))
+			return vmaddr;
+		rmap = kzalloc(sizeof(*rmap), GFP_KERNEL);
+		if (!rmap)
+			return -ENOMEM;
+		rmap->raddr = raddr;
+		rc = radix_tree_preload(GFP_KERNEL);
+		if (rc) {
+			kfree(rmap);
+			return rc;
+		}
+		rc = -EAGAIN;
+		ptep = gmap_pte_op_walk(parent, paddr, &ptl);
+		if (ptep) {
+			spin_lock(&sg->guest_table_lock);
+			rc = ptep_force_prot(parent->mm, paddr, ptep, prot,
+					     PGSTE_VSIE_BIT);
+			if (!rc)
+				gmap_insert_rmap(sg, vmaddr, rmap);
+			spin_unlock(&sg->guest_table_lock);
+			gmap_pte_op_end(ptl);
+		}
+		radix_tree_preload_end();
+		if (rc) {
+			kfree(rmap);
+			rc = gmap_pte_op_fixup(parent, paddr, vmaddr);
+			if (rc)
+				return rc;
+			continue;
+		}
+		paddr += PAGE_SIZE;
+		len -= PAGE_SIZE;
+	}
+	return 0;
+}
+
+#define _SHADOW_RMAP_MASK	0x7
+#define _SHADOW_RMAP_REGION1	0x5
+#define _SHADOW_RMAP_REGION2	0x4
+#define _SHADOW_RMAP_REGION3	0x3
+#define _SHADOW_RMAP_SEGMENT	0x2
+#define _SHADOW_RMAP_PGTABLE	0x1
+
+/**
+ * gmap_idte_one - invalidate a single region or segment table entry
+ * @asce: region or segment table *origin* + table-type bits
+ * @vaddr: virtual address to identify the table entry to flush
+ *
+ * The invalid bit of a single region or segment table entry is set
+ * and the associated TLB entries depending on the entry are flushed.
+ * The table-type of the @asce identifies the portion of the @vaddr
+ * that is used as the invalidation index.
+ */
+static inline void gmap_idte_one(unsigned long asce, unsigned long vaddr)
+{
+	asm volatile(
+		"	.insn	rrf,0xb98e0000,%0,%1,0,0"
+		: : "a" (asce), "a" (vaddr) : "cc", "memory");
+}
+
+/**
+ * gmap_unshadow_page - remove a page from a shadow page table
+ * @sg: pointer to the shadow guest address space structure
+ * @raddr: rmap address in the shadow guest address space
+ *
+ * Called with the sg->guest_table_lock
+ */
+static void gmap_unshadow_page(struct gmap *sg, unsigned long raddr)
+{
+	unsigned long *table;
+
+	BUG_ON(!gmap_is_shadow(sg));
+	table = gmap_table_walk(sg, raddr, 0); /* get page table pointer */
+	if (!table || *table & _PAGE_INVALID)
+		return;
+	gmap_call_notifier(sg, raddr, raddr + (1UL << 12) - 1);
+	ptep_unshadow_pte(sg->mm, raddr, (pte_t *) table);
+}
+
+/**
+ * __gmap_unshadow_pgt - remove all entries from a shadow page table
+ * @sg: pointer to the shadow guest address space structure
+ * @raddr: rmap address in the shadow guest address space
+ * @pgt: pointer to the start of a shadow page table
+ *
+ * Called with the sg->guest_table_lock
+ */
+static void __gmap_unshadow_pgt(struct gmap *sg, unsigned long raddr,
+				unsigned long *pgt)
+{
+	int i;
+
+	BUG_ON(!gmap_is_shadow(sg));
+	for (i = 0; i < 256; i++, raddr += 1UL << 12)
+		pgt[i] = _PAGE_INVALID;
+}
+
+/**
+ * gmap_unshadow_pgt - remove a shadow page table from a segment entry
+ * @sg: pointer to the shadow guest address space structure
+ * @raddr: address in the shadow guest address space
+ *
+ * Called with the sg->guest_table_lock
+ */
+static void gmap_unshadow_pgt(struct gmap *sg, unsigned long raddr)
+{
+	unsigned long sto, *ste, *pgt;
+	struct page *page;
+
+	BUG_ON(!gmap_is_shadow(sg));
+	ste = gmap_table_walk(sg, raddr, 1); /* get segment pointer */
+	if (!ste || *ste & _SEGMENT_ENTRY_INVALID)
+		return;
+	gmap_call_notifier(sg, raddr, raddr + (1UL << 20) - 1);
+	sto = (unsigned long) (ste - ((raddr >> 20) & 0x7ff));
+	gmap_idte_one(sto | _ASCE_TYPE_SEGMENT, raddr);
+	pgt = (unsigned long *)(*ste & _SEGMENT_ENTRY_ORIGIN);
+	*ste = _SEGMENT_ENTRY_EMPTY;
+	__gmap_unshadow_pgt(sg, raddr, pgt);
+	/* Free page table */
+	page = pfn_to_page(__pa(pgt) >> PAGE_SHIFT);
+	list_del(&page->lru);
+	page_table_free_pgste(page);
+}
+
+/**
+ * __gmap_unshadow_sgt - remove all entries from a shadow segment table
+ * @sg: pointer to the shadow guest address space structure
+ * @raddr: rmap address in the shadow guest address space
+ * @sgt: pointer to the start of a shadow segment table
+ *
+ * Called with the sg->guest_table_lock
+ */
+static void __gmap_unshadow_sgt(struct gmap *sg, unsigned long raddr,
+				unsigned long *sgt)
+{
+	unsigned long asce, *pgt;
+	struct page *page;
+	int i;
+
+	BUG_ON(!gmap_is_shadow(sg));
+	asce = (unsigned long) sgt | _ASCE_TYPE_SEGMENT;
+	for (i = 0; i < 2048; i++, raddr += 1UL << 20) {
+		if (sgt[i] & _SEGMENT_ENTRY_INVALID)
+			continue;
+		pgt = (unsigned long *)(sgt[i] & _REGION_ENTRY_ORIGIN);
+		sgt[i] = _SEGMENT_ENTRY_EMPTY;
+		__gmap_unshadow_pgt(sg, raddr, pgt);
+		/* Free page table */
+		page = pfn_to_page(__pa(pgt) >> PAGE_SHIFT);
+		list_del(&page->lru);
+		page_table_free_pgste(page);
+	}
+}
+
+/**
+ * gmap_unshadow_sgt - remove a shadow segment table from a region-3 entry
+ * @sg: pointer to the shadow guest address space structure
+ * @raddr: rmap address in the shadow guest address space
+ *
+ * Called with the shadow->guest_table_lock
+ */
+static void gmap_unshadow_sgt(struct gmap *sg, unsigned long raddr)
+{
+	unsigned long r3o, *r3e, *sgt;
+	struct page *page;
+
+	BUG_ON(!gmap_is_shadow(sg));
+	r3e = gmap_table_walk(sg, raddr, 2); /* get region-3 pointer */
+	if (!r3e || *r3e & _REGION_ENTRY_INVALID)
+		return;
+	gmap_call_notifier(sg, raddr, raddr + (1UL << 31) - 1);
+	r3o = (unsigned long) (r3e - ((raddr >> 31) & 0x7ff));
+	gmap_idte_one(r3o | _ASCE_TYPE_REGION3, raddr);
+	sgt = (unsigned long *)(*r3e & _REGION_ENTRY_ORIGIN);
+	*r3e = _REGION3_ENTRY_EMPTY;
+	__gmap_unshadow_sgt(sg, raddr, sgt);
+	/* Free segment table */
+	page = pfn_to_page(__pa(sgt) >> PAGE_SHIFT);
+	list_del(&page->lru);
+	__free_pages(page, 2);
+}
+
+/**
+ * __gmap_unshadow_r3t - remove all entries from a shadow region-3 table
+ * @sg: pointer to the shadow guest address space structure
+ * @raddr: address in the shadow guest address space
+ * @r3t: pointer to the start of a shadow region-3 table
+ *
+ * Called with the sg->guest_table_lock
+ */
+static void __gmap_unshadow_r3t(struct gmap *sg, unsigned long raddr,
+				unsigned long *r3t)
+{
+	unsigned long asce, *sgt;
+	struct page *page;
+	int i;
+
+	BUG_ON(!gmap_is_shadow(sg));
+	asce = (unsigned long) r3t | _ASCE_TYPE_REGION3;
+	for (i = 0; i < 2048; i++, raddr += 1UL << 31) {
+		if (r3t[i] & _REGION_ENTRY_INVALID)
+			continue;
+		sgt = (unsigned long *)(r3t[i] & _REGION_ENTRY_ORIGIN);
+		r3t[i] = _REGION3_ENTRY_EMPTY;
+		__gmap_unshadow_sgt(sg, raddr, sgt);
+		/* Free segment table */
+		page = pfn_to_page(__pa(sgt) >> PAGE_SHIFT);
+		list_del(&page->lru);
+		__free_pages(page, 2);
+	}
+}
+
+/**
+ * gmap_unshadow_r3t - remove a shadow region-3 table from a region-2 entry
+ * @sg: pointer to the shadow guest address space structure
+ * @raddr: rmap address in the shadow guest address space
+ *
+ * Called with the sg->guest_table_lock
+ */
+static void gmap_unshadow_r3t(struct gmap *sg, unsigned long raddr)
+{
+	unsigned long r2o, *r2e, *r3t;
+	struct page *page;
+
+	BUG_ON(!gmap_is_shadow(sg));
+	r2e = gmap_table_walk(sg, raddr, 3); /* get region-2 pointer */
+	if (!r2e || *r2e & _REGION_ENTRY_INVALID)
+		return;
+	gmap_call_notifier(sg, raddr, raddr + (1UL << 42) - 1);
+	r2o = (unsigned long) (r2e - ((raddr >> 42) & 0x7ff));
+	gmap_idte_one(r2o | _ASCE_TYPE_REGION2, raddr);
+	r3t = (unsigned long *)(*r2e & _REGION_ENTRY_ORIGIN);
+	*r2e = _REGION2_ENTRY_EMPTY;
+	__gmap_unshadow_r3t(sg, raddr, r3t);
+	/* Free region 3 table */
+	page = pfn_to_page(__pa(r3t) >> PAGE_SHIFT);
+	list_del(&page->lru);
+	__free_pages(page, 2);
+}
+
+/**
+ * __gmap_unshadow_r2t - remove all entries from a shadow region-2 table
+ * @sg: pointer to the shadow guest address space structure
+ * @raddr: rmap address in the shadow guest address space
+ * @r2t: pointer to the start of a shadow region-2 table
+ *
+ * Called with the sg->guest_table_lock
+ */
+static void __gmap_unshadow_r2t(struct gmap *sg, unsigned long raddr,
+				unsigned long *r2t)
+{
+	unsigned long asce, *r3t;
+	struct page *page;
+	int i;
+
+	BUG_ON(!gmap_is_shadow(sg));
+	asce = (unsigned long) r2t | _ASCE_TYPE_REGION2;
+	for (i = 0; i < 2048; i++, raddr += 1UL << 42) {
+		if (r2t[i] & _REGION_ENTRY_INVALID)
+			continue;
+		r3t = (unsigned long *)(r2t[i] & _REGION_ENTRY_ORIGIN);
+		r2t[i] = _REGION2_ENTRY_EMPTY;
+		__gmap_unshadow_r3t(sg, raddr, r3t);
+		/* Free region 3 table */
+		page = pfn_to_page(__pa(r3t) >> PAGE_SHIFT);
+		list_del(&page->lru);
+		__free_pages(page, 2);
+	}
+}
+
+/**
+ * gmap_unshadow_r2t - remove a shadow region-2 table from a region-1 entry
+ * @sg: pointer to the shadow guest address space structure
+ * @raddr: rmap address in the shadow guest address space
+ *
+ * Called with the sg->guest_table_lock
+ */
+static void gmap_unshadow_r2t(struct gmap *sg, unsigned long raddr)
+{
+	unsigned long r1o, *r1e, *r2t;
+	struct page *page;
+
+	BUG_ON(!gmap_is_shadow(sg));
+	r1e = gmap_table_walk(sg, raddr, 4); /* get region-1 pointer */
+	if (!r1e || *r1e & _REGION_ENTRY_INVALID)
+		return;
+	gmap_call_notifier(sg, raddr, raddr + (1UL << 53) - 1);
+	r1o = (unsigned long) (r1e - ((raddr >> 53) & 0x7ff));
+	gmap_idte_one(r1o | _ASCE_TYPE_REGION1, raddr);
+	r2t = (unsigned long *)(*r1e & _REGION_ENTRY_ORIGIN);
+	*r1e = _REGION1_ENTRY_EMPTY;
+	__gmap_unshadow_r2t(sg, raddr, r2t);
+	/* Free region 2 table */
+	page = pfn_to_page(__pa(r2t) >> PAGE_SHIFT);
+	list_del(&page->lru);
+	__free_pages(page, 2);
+}
+
+/**
+ * __gmap_unshadow_r1t - remove all entries from a shadow region-1 table
+ * @sg: pointer to the shadow guest address space structure
+ * @raddr: rmap address in the shadow guest address space
+ * @r1t: pointer to the start of a shadow region-1 table
+ *
+ * Called with the shadow->guest_table_lock
+ */
+static void __gmap_unshadow_r1t(struct gmap *sg, unsigned long raddr,
+				unsigned long *r1t)
+{
+	unsigned long asce, *r2t;
+	struct page *page;
+	int i;
+
+	BUG_ON(!gmap_is_shadow(sg));
+	asce = (unsigned long) r1t | _ASCE_TYPE_REGION1;
+	for (i = 0; i < 2048; i++, raddr += 1UL << 53) {
+		if (r1t[i] & _REGION_ENTRY_INVALID)
+			continue;
+		r2t = (unsigned long *)(r1t[i] & _REGION_ENTRY_ORIGIN);
+		__gmap_unshadow_r2t(sg, raddr, r2t);
+		/* Clear entry and flush translation r1t -> r2t */
+		gmap_idte_one(asce, raddr);
+		r1t[i] = _REGION1_ENTRY_EMPTY;
+		/* Free region 2 table */
+		page = pfn_to_page(__pa(r2t) >> PAGE_SHIFT);
+		list_del(&page->lru);
+		__free_pages(page, 2);
+	}
+}
+
+/**
+ * gmap_unshadow - remove a shadow page table completely
+ * @sg: pointer to the shadow guest address space structure
+ *
+ * Called with sg->guest_table_lock
+ */
+static void gmap_unshadow(struct gmap *sg)
+{
+	unsigned long *table;
+
+	BUG_ON(!gmap_is_shadow(sg));
+	if (sg->removed)
+		return;
+	sg->removed = 1;
+	gmap_call_notifier(sg, 0, -1UL);
+	table = (unsigned long *)(sg->asce & _ASCE_ORIGIN);
+	switch (sg->asce & _ASCE_TYPE_MASK) {
+	case _ASCE_TYPE_REGION1:
+		__gmap_unshadow_r1t(sg, 0, table);
+		break;
+	case _ASCE_TYPE_REGION2:
+		__gmap_unshadow_r2t(sg, 0, table);
+		break;
+	case _ASCE_TYPE_REGION3:
+		__gmap_unshadow_r3t(sg, 0, table);
+		break;
+	case _ASCE_TYPE_SEGMENT:
+		__gmap_unshadow_sgt(sg, 0, table);
+		break;
+	}
+}
+
+/**
+ * gmap_find_shadow - find a specific asce in the list of shadow tables
+ * @parent: pointer to the parent gmap
+ * @asce: ASCE for which the shadow table is created
+ *
+ * Returns the pointer to a gmap if a shadow table with the given asce is
+ * already available, otherwise NULL
+ */
+static struct gmap *gmap_find_shadow(struct gmap *parent, unsigned long asce)
+{
+	struct gmap *sg;
+
+	list_for_each_entry(sg, &parent->children, list) {
+		if (sg->orig_asce != asce || sg->removed)
+			continue;
+		atomic_inc(&sg->ref_count);
+		return sg;
+	}
+	return NULL;
+}
+
+/**
+ * gmap_shadow - create/find a shadow guest address space
+ * @parent: pointer to the parent gmap
+ * @asce: ASCE for which the shadow table is created
+ *
+ * The pages of the top level page table referred by the asce parameter
+ * will be set to read-only and marked in the PGSTEs of the kvm process.
+ * The shadow table will be removed automatically on any change to the
+ * PTE mapping for the source table.
+ *
+ * Returns a guest address space structure, NULL if out of memory or if
+ * anything goes wrong while protecting the top level pages.
+ */
+struct gmap *gmap_shadow(struct gmap *parent, unsigned long asce)
+{
+	struct gmap *sg, *new;
+	unsigned long limit;
+	int rc;
+
+	BUG_ON(gmap_is_shadow(parent));
+	spin_lock(&parent->shadow_lock);
+	sg = gmap_find_shadow(parent, asce);
+	spin_unlock(&parent->shadow_lock);
+	if (sg)
+		return sg;
+	/* Create a new shadow gmap */
+	limit = -1UL >> (33 - (((asce & _ASCE_TYPE_MASK) >> 2) * 11));
+	new = gmap_alloc(limit);
+	if (!new)
+		return NULL;
+	new->mm = parent->mm;
+	new->parent = gmap_get(parent);
+	new->orig_asce = asce;
+	down_read(&parent->mm->mmap_sem);
+	rc = gmap_protect_range(parent, asce & _ASCE_ORIGIN,
+				((asce & _ASCE_TABLE_LENGTH) + 1) * 4096,
+				PROT_READ, PGSTE_VSIE_BIT);
+	up_read(&parent->mm->mmap_sem);
+	if (rc) {
+		atomic_set(&new->ref_count, 2);
+		spin_lock(&parent->shadow_lock);
+		/* Recheck if another CPU created the same shadow */
+		sg = gmap_find_shadow(parent, asce);
+		if (!sg) {
+			list_add(&new->list, &parent->children);
+			sg = new;
+			new = NULL;
+		}
+		spin_unlock(&parent->shadow_lock);
+	}
+	if (new)
+		gmap_free(new);
+	return sg;
+}
+EXPORT_SYMBOL_GPL(gmap_shadow);
+
+/**
+ * gmap_shadow_r2t - create an empty shadow region 2 table
+ * @sg: pointer to the shadow guest address space structure
+ * @saddr: faulting address in the shadow gmap
+ * @r2t: parent gmap address of the region 2 table to get shadowed
+ *
+ * The r2t parameter specifies the address of the source table. The
+ * four pages of the source table are made read-only in the parent gmap
+ * address space. A write to the source table area @r2t will automatically
+ * remove the shadow r2 table and all of its decendents.
+ *
+ * Returns 0 if successfully shadowed or already shadowed, -EAGAIN if the
+ * shadow table structure is incomplete, -ENOMEM if out of memory and
+ * -EFAULT if an address in the parent gmap could not be resolved.
+ *
+ * Called with sg->mm->mmap_sem in read.
+ */
+int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t)
+{
+	unsigned long raddr, origin, offset, len;
+	unsigned long *s_r2t, *table;
+	struct page *page;
+	int rc;
+
+	BUG_ON(!gmap_is_shadow(sg));
+	/* Allocate a shadow region second table */
+	page = alloc_pages(GFP_KERNEL, 2);
+	if (!page)
+		return -ENOMEM;
+	page->index = r2t & _REGION_ENTRY_ORIGIN;
+	s_r2t = (unsigned long *) page_to_phys(page);
+	/* Install shadow region second table */
+	spin_lock(&sg->guest_table_lock);
+	table = gmap_table_walk(sg, saddr, 4); /* get region-1 pointer */
+	if (!table) {
+		rc = -EAGAIN;		/* Race with unshadow */
+		goto out_free;
+	}
+	if (!(*table & _REGION_ENTRY_INVALID)) {
+		rc = 0;			/* Already established */
+		goto out_free;
+	}
+	crst_table_init(s_r2t, _REGION2_ENTRY_EMPTY);
+	*table = (unsigned long) s_r2t |
+		_REGION_ENTRY_LENGTH | _REGION_ENTRY_TYPE_R1;
+	list_add(&page->lru, &sg->crst_list);
+	spin_unlock(&sg->guest_table_lock);
+	/* Make r2t read-only in parent gmap page table */
+	raddr = (saddr & 0xffe0000000000000UL) | _SHADOW_RMAP_REGION1;
+	origin = r2t & _REGION_ENTRY_ORIGIN;
+	offset = ((r2t & _REGION_ENTRY_OFFSET) >> 6) * 4096;
+	len = ((r2t & _REGION_ENTRY_LENGTH) + 1) * 4096 - offset;
+	rc = gmap_protect_rmap(sg, raddr, origin + offset, len, PROT_READ);
+	if (rc) {
+		spin_lock(&sg->guest_table_lock);
+		gmap_unshadow_r2t(sg, raddr);
+		spin_unlock(&sg->guest_table_lock);
+	}
+	return rc;
+out_free:
+	spin_unlock(&sg->guest_table_lock);
+	__free_pages(page, 2);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(gmap_shadow_r2t);
+
+/**
+ * gmap_shadow_r3t - create a shadow region 3 table
+ * @sg: pointer to the shadow guest address space structure
+ * @saddr: faulting address in the shadow gmap
+ * @r3t: parent gmap address of the region 3 table to get shadowed
+ *
+ * Returns 0 if successfully shadowed or already shadowed, -EAGAIN if the
+ * shadow table structure is incomplete, -ENOMEM if out of memory and
+ * -EFAULT if an address in the parent gmap could not be resolved.
+ *
+ * Called with sg->mm->mmap_sem in read.
+ */
+int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t)
+{
+	unsigned long raddr, origin, offset, len;
+	unsigned long *s_r3t, *table;
+	struct page *page;
+	int rc;
+
+	BUG_ON(!gmap_is_shadow(sg));
+	/* Allocate a shadow region second table */
+	page = alloc_pages(GFP_KERNEL, 2);
+	if (!page)
+		return -ENOMEM;
+	page->index = r3t & _REGION_ENTRY_ORIGIN;
+	s_r3t = (unsigned long *) page_to_phys(page);
+	/* Install shadow region second table */
+	spin_lock(&sg->guest_table_lock);
+	table = gmap_table_walk(sg, saddr, 3); /* get region-2 pointer */
+	if (!table) {
+		rc = -EAGAIN;		/* Race with unshadow */
+		goto out_free;
+	}
+	if (!(*table & _REGION_ENTRY_INVALID)) {
+		rc = 0;			/* Already established */
+		goto out_free;
+	}
+	crst_table_init(s_r3t, _REGION3_ENTRY_EMPTY);
+	*table = (unsigned long) s_r3t |
+		_REGION_ENTRY_LENGTH | _REGION_ENTRY_TYPE_R2;
+	list_add(&page->lru, &sg->crst_list);
+	spin_unlock(&sg->guest_table_lock);
+	/* Make r3t read-only in parent gmap page table */
+	raddr = (saddr & 0xfffffc0000000000UL) | _SHADOW_RMAP_REGION2;
+	origin = r3t & _REGION_ENTRY_ORIGIN;
+	offset = ((r3t & _REGION_ENTRY_OFFSET) >> 6) * 4096;
+	len = ((r3t & _REGION_ENTRY_LENGTH) + 1) * 4096 - offset;
+	rc = gmap_protect_rmap(sg, raddr, origin + offset, len, PROT_READ);
+	if (rc) {
+		spin_lock(&sg->guest_table_lock);
+		gmap_unshadow_r3t(sg, raddr);
+		spin_unlock(&sg->guest_table_lock);
+	}
+	return rc;
+out_free:
+	spin_unlock(&sg->guest_table_lock);
+	__free_pages(page, 2);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(gmap_shadow_r3t);
+
+/**
+ * gmap_shadow_sgt - create a shadow segment table
+ * @sg: pointer to the shadow guest address space structure
+ * @saddr: faulting address in the shadow gmap
+ * @sgt: parent gmap address of the segment table to get shadowed
+ *
+ * Returns: 0 if successfully shadowed or already shadowed, -EAGAIN if the
+ * shadow table structure is incomplete, -ENOMEM if out of memory and
+ * -EFAULT if an address in the parent gmap could not be resolved.
+ *
+ * Called with sg->mm->mmap_sem in read.
+ */
+int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt)
+{
+	unsigned long raddr, origin, offset, len;
+	unsigned long *s_sgt, *table;
+	struct page *page;
+	int rc;
+
+	BUG_ON(!gmap_is_shadow(sg));
+	/* Allocate a shadow segment table */
+	page = alloc_pages(GFP_KERNEL, 2);
+	if (!page)
+		return -ENOMEM;
+	page->index = sgt & _REGION_ENTRY_ORIGIN;
+	s_sgt = (unsigned long *) page_to_phys(page);
+	/* Install shadow region second table */
+	spin_lock(&sg->guest_table_lock);
+	table = gmap_table_walk(sg, saddr, 2); /* get region-3 pointer */
+	if (!table) {
+		rc = -EAGAIN;		/* Race with unshadow */
+		goto out_free;
+	}
+	if (!(*table & _REGION_ENTRY_INVALID)) {
+		rc = 0;			/* Already established */
+		goto out_free;
+	}
+	crst_table_init(s_sgt, _SEGMENT_ENTRY_EMPTY);
+	*table = (unsigned long) s_sgt |
+		_REGION_ENTRY_LENGTH | _REGION_ENTRY_TYPE_R3;
+	list_add(&page->lru, &sg->crst_list);
+	spin_unlock(&sg->guest_table_lock);
+	/* Make sgt read-only in parent gmap page table */
+	raddr = (saddr & 0xffffffff80000000UL) | _SHADOW_RMAP_REGION3;
+	origin = sgt & _REGION_ENTRY_ORIGIN;
+	offset = ((sgt & _REGION_ENTRY_OFFSET) >> 6) * 4096;
+	len = ((sgt & _REGION_ENTRY_LENGTH) + 1) * 4096 - offset;
+	rc = gmap_protect_rmap(sg, raddr, origin + offset, len, PROT_READ);
+	if (rc) {
+		spin_lock(&sg->guest_table_lock);
+		gmap_unshadow_sgt(sg, raddr);
+		spin_unlock(&sg->guest_table_lock);
+	}
+	return rc;
+out_free:
+	spin_unlock(&sg->guest_table_lock);
+	__free_pages(page, 2);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(gmap_shadow_sgt);
+
+/**
+ * gmap_shadow_lookup_pgtable - find a shadow page table
+ * @sg: pointer to the shadow guest address space structure
+ * @saddr: the address in the shadow aguest address space
+ * @pgt: parent gmap address of the page table to get shadowed
+ * @dat_protection: if the pgtable is marked as protected by dat
+ *
+ * Returns 0 if the shadow page table was found and -EAGAIN if the page
+ * table was not found.
+ *
+ * Called with sg->mm->mmap_sem in read.
+ */
+int gmap_shadow_pgt_lookup(struct gmap *sg, unsigned long saddr,
+			   unsigned long *pgt, int *dat_protection)
+{
+	unsigned long *table;
+	struct page *page;
+	int rc;
+
+	BUG_ON(!gmap_is_shadow(sg));
+	spin_lock(&sg->guest_table_lock);
+	table = gmap_table_walk(sg, saddr, 1); /* get segment pointer */
+	if (table && !(*table & _SEGMENT_ENTRY_INVALID)) {
+		/* Shadow page tables are full pages (pte+pgste) */
+		page = pfn_to_page(*table >> PAGE_SHIFT);
+		*pgt = page->index;
+		*dat_protection = !!(*table & _SEGMENT_ENTRY_PROTECT);
+		rc = 0;
+	} else  {
+		rc = -EAGAIN;
+	}
+	spin_unlock(&sg->guest_table_lock);
+	return rc;
+
+}
+EXPORT_SYMBOL_GPL(gmap_shadow_pgt_lookup);
+
+/**
+ * gmap_shadow_pgt - instantiate a shadow page table
+ * @sg: pointer to the shadow guest address space structure
+ * @saddr: faulting address in the shadow gmap
+ * @pgt: parent gmap address of the page table to get shadowed
+ *
+ * Returns 0 if successfully shadowed or already shadowed, -EAGAIN if the
+ * shadow table structure is incomplete, -ENOMEM if out of memory,
+ * -EFAULT if an address in the parent gmap could not be resolved and
+ *
+ * Called with gmap->mm->mmap_sem in read
+ */
+int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt)
+{
+	unsigned long raddr, origin;
+	unsigned long *s_pgt, *table;
+	struct page *page;
+	int rc;
+
+	BUG_ON(!gmap_is_shadow(sg));
+	/* Allocate a shadow page table */
+	page = page_table_alloc_pgste(sg->mm);
+	if (!page)
+		return -ENOMEM;
+	page->index = pgt & _SEGMENT_ENTRY_ORIGIN;
+	s_pgt = (unsigned long *) page_to_phys(page);
+	/* Install shadow page table */
+	spin_lock(&sg->guest_table_lock);
+	table = gmap_table_walk(sg, saddr, 1); /* get segment pointer */
+	if (!table) {
+		rc = -EAGAIN;		/* Race with unshadow */
+		goto out_free;
+	}
+	if (!(*table & _SEGMENT_ENTRY_INVALID)) {
+		rc = 0;			/* Already established */
+		goto out_free;
+	}
+	*table = (unsigned long) s_pgt | _SEGMENT_ENTRY |
+		 (pgt & _SEGMENT_ENTRY_PROTECT);
+	list_add(&page->lru, &sg->pt_list);
+	spin_unlock(&sg->guest_table_lock);
+	/* Make pgt read-only in parent gmap page table (not the pgste) */
+	raddr = (saddr & 0xfffffffffff00000UL) | _SHADOW_RMAP_SEGMENT;
+	origin = pgt & _SEGMENT_ENTRY_ORIGIN & PAGE_MASK;
+	rc = gmap_protect_rmap(sg, raddr, origin, PAGE_SIZE, PROT_READ);
+	if (rc) {
+		spin_lock(&sg->guest_table_lock);
+		gmap_unshadow_pgt(sg, raddr);
+		spin_unlock(&sg->guest_table_lock);
+	}
+	return rc;
+out_free:
+	spin_unlock(&sg->guest_table_lock);
+	page_table_free_pgste(page);
+	return rc;
+
+}
+EXPORT_SYMBOL_GPL(gmap_shadow_pgt);
+
+/**
+ * gmap_shadow_page - create a shadow page mapping
+ * @sg: pointer to the shadow guest address space structure
+ * @saddr: faulting address in the shadow gmap
+ * @paddr: parent gmap address to get mapped at @saddr
+ * @write: =1 map r/w, =0 map r/o
+ *
+ * Returns 0 if successfully shadowed or already shadowed, -EAGAIN if the
+ * shadow table structure is incomplete, -ENOMEM if out of memory and
+ * -EFAULT if an address in the parent gmap could not be resolved.
+ *
+ * Called with sg->mm->mmap_sem in read.
+ */
+int gmap_shadow_page(struct gmap *sg, unsigned long saddr,
+		     unsigned long paddr, int write)
+{
+	struct gmap *parent;
+	struct gmap_rmap *rmap;
+	unsigned long vmaddr;
+	spinlock_t *ptl;
+	pte_t *sptep, *tptep;
+	int rc;
+
+	BUG_ON(!gmap_is_shadow(sg));
+	parent = sg->parent;
+
+	rmap = kzalloc(sizeof(*rmap), GFP_KERNEL);
+	if (!rmap)
+		return -ENOMEM;
+	rmap->raddr = (saddr & PAGE_MASK) | _SHADOW_RMAP_PGTABLE;
+
+	while (1) {
+		vmaddr = __gmap_translate(parent, paddr);
+		if (IS_ERR_VALUE(vmaddr)) {
+			rc = vmaddr;
+			break;
+		}
+		rc = radix_tree_preload(GFP_KERNEL);
+		if (rc)
+			break;
+		rc = -EAGAIN;
+		sptep = gmap_pte_op_walk(parent, paddr, &ptl);
+		if (sptep) {
+			spin_lock(&sg->guest_table_lock);
+			/* Get page table pointer */
+			tptep = (pte_t *) gmap_table_walk(sg, saddr, 0);
+			if (!tptep) {
+				spin_unlock(&sg->guest_table_lock);
+				gmap_pte_op_end(ptl);
+				radix_tree_preload_end();
+				break;
+			}
+			rc = ptep_shadow_pte(sg->mm, saddr,
+					     sptep, tptep, write);
+			if (rc > 0) {
+				/* Success and a new mapping */
+				gmap_insert_rmap(sg, vmaddr, rmap);
+				rmap = NULL;
+				rc = 0;
+			}
+			gmap_pte_op_end(ptl);
+			spin_unlock(&sg->guest_table_lock);
+		}
+		radix_tree_preload_end();
+		if (!rc)
+			break;
+		rc = gmap_pte_op_fixup(parent, paddr, vmaddr);
+		if (rc)
+			break;
+	}
+	kfree(rmap);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(gmap_shadow_page);
+
+/**
+ * gmap_shadow_notify - handle notifications for shadow gmap
+ *
+ * Called with sg->parent->shadow_lock.
+ */
+static void gmap_shadow_notify(struct gmap *sg, unsigned long vmaddr,
+			       unsigned long offset, pte_t *pte)
+{
+	struct gmap_rmap *rmap, *rnext, *head;
+	unsigned long gaddr, start, end, bits, raddr;
+	unsigned long *table;
+
+	BUG_ON(!gmap_is_shadow(sg));
+	spin_lock(&sg->parent->guest_table_lock);
+	table = radix_tree_lookup(&sg->parent->host_to_guest,
+				  vmaddr >> PMD_SHIFT);
+	gaddr = table ? __gmap_segment_gaddr(table) + offset : 0;
+	spin_unlock(&sg->parent->guest_table_lock);
+	if (!table)
+		return;
+
+	spin_lock(&sg->guest_table_lock);
+	if (sg->removed) {
+		spin_unlock(&sg->guest_table_lock);
+		return;
+	}
+	/* Check for top level table */
+	start = sg->orig_asce & _ASCE_ORIGIN;
+	end = start + ((sg->orig_asce & _ASCE_TABLE_LENGTH) + 1) * 4096;
+	if (gaddr >= start && gaddr < end) {
+		/* The complete shadow table has to go */
+		gmap_unshadow(sg);
+		spin_unlock(&sg->guest_table_lock);
+		list_del(&sg->list);
+		gmap_put(sg);
+		return;
+	}
+	/* Remove the page table tree from on specific entry */
+	head = radix_tree_delete(&sg->host_to_rmap, vmaddr >> 12);
+	gmap_for_each_rmap_safe(rmap, rnext, head) {
+		bits = rmap->raddr & _SHADOW_RMAP_MASK;
+		raddr = rmap->raddr ^ bits;
+		switch (bits) {
+		case _SHADOW_RMAP_REGION1:
+			gmap_unshadow_r2t(sg, raddr);
+			break;
+		case _SHADOW_RMAP_REGION2:
+			gmap_unshadow_r3t(sg, raddr);
+			break;
+		case _SHADOW_RMAP_REGION3:
+			gmap_unshadow_sgt(sg, raddr);
+			break;
+		case _SHADOW_RMAP_SEGMENT:
+			gmap_unshadow_pgt(sg, raddr);
+			break;
+		case _SHADOW_RMAP_PGTABLE:
+			gmap_unshadow_page(sg, raddr);
+			break;
+		}
+		kfree(rmap);
+	}
+	spin_unlock(&sg->guest_table_lock);
+}
+
+/**
  * ptep_notify - call all invalidation callbacks for a specific pte.
  * @mm: pointer to the process mm_struct
  * @addr: virtual address in the process address space
  * @pte: pointer to the page table entry
+ * @bits: bits from the pgste that caused the notify call
  *
  * This function is assumed to be called with the page table lock held
  * for the pte to notify.
  */
-void ptep_notify(struct mm_struct *mm, unsigned long vmaddr, pte_t *pte)
+void ptep_notify(struct mm_struct *mm, unsigned long vmaddr,
+		 pte_t *pte, unsigned long bits)
 {
 	unsigned long offset, gaddr;
 	unsigned long *table;
-	struct gmap *gmap;
+	struct gmap *gmap, *sg, *next;
 
 	offset = ((unsigned long) pte) & (255 * sizeof(pte_t));
 	offset = offset * (4096 / sizeof(pte_t));
 	rcu_read_lock();
 	list_for_each_entry_rcu(gmap, &mm->context.gmap_list, list) {
+		if (!list_empty(&gmap->children) && (bits & PGSTE_VSIE_BIT)) {
+			spin_lock(&gmap->shadow_lock);
+			list_for_each_entry_safe(sg, next,
+						 &gmap->children, list)
+				gmap_shadow_notify(sg, vmaddr, offset, pte);
+			spin_unlock(&gmap->shadow_lock);
+		}
+		if (!(bits & PGSTE_IN_BIT))
+			continue;
 		spin_lock(&gmap->guest_table_lock);
 		table = radix_tree_lookup(&gmap->host_to_guest,
 					  vmaddr >> PMD_SHIFT);
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 7be1f94..9c57a29 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -137,6 +137,29 @@ static inline unsigned int atomic_xor_bits(atomic_t *v, unsigned int bits)
 	return new;
 }
 
+#ifdef CONFIG_PGSTE
+
+struct page *page_table_alloc_pgste(struct mm_struct *mm)
+{
+	struct page *page;
+	unsigned long *table;
+
+	page = alloc_page(GFP_KERNEL|__GFP_REPEAT);
+	if (page) {
+		table = (unsigned long *) page_to_phys(page);
+		clear_table(table, _PAGE_INVALID, PAGE_SIZE/2);
+		clear_table(table + PTRS_PER_PTE, 0, PAGE_SIZE/2);
+	}
+	return page;
+}
+
+void page_table_free_pgste(struct page *page)
+{
+	__free_page(page);
+}
+
+#endif /* CONFIG_PGSTE */
+
 /*
  * page table entry allocation/free routines.
  */
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index ab65fb1..5b02583 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -184,9 +184,12 @@ static inline pgste_t pgste_pte_notify(struct mm_struct *mm,
 				       pte_t *ptep, pgste_t pgste)
 {
 #ifdef CONFIG_PGSTE
-	if (pgste_val(pgste) & PGSTE_IN_BIT) {
-		pgste_val(pgste) &= ~PGSTE_IN_BIT;
-		ptep_notify(mm, addr, ptep);
+	unsigned long bits;
+
+	bits = pgste_val(pgste) & (PGSTE_IN_BIT | PGSTE_VSIE_BIT);
+	if (bits) {
+		pgste_val(pgste) ^= bits;
+		ptep_notify(mm, addr, ptep, bits);
 	}
 #endif
 	return pgste;
@@ -420,12 +423,13 @@ void ptep_set_notify(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
  * @addr: virtual address in the guest address space
  * @ptep: pointer to the page table entry
  * @prot: indicates guest access rights: PROT_NONE, PROT_READ or PROT_WRITE
+ * @bit: pgste bit to set (e.g. for notification)
  *
  * Returns 0 if the access rights were changed and -EAGAIN if the current
  * and requested access rights are incompatible.
  */
 int ptep_force_prot(struct mm_struct *mm, unsigned long addr,
-		    pte_t *ptep, int prot)
+		    pte_t *ptep, int prot, unsigned long bit)
 {
 	pte_t entry;
 	pgste_t pgste;
@@ -441,7 +445,7 @@ int ptep_force_prot(struct mm_struct *mm, unsigned long addr,
 		pgste_set_unlock(ptep, pgste);
 		return -EAGAIN;
 	}
-	/* Change access rights and set the pgste notification bit */
+	/* Change access rights and set pgste bit */
 	if (prot == PROT_NONE && !pte_i) {
 		ptep_flush_direct(mm, addr, ptep);
 		pgste = pgste_update_all(entry, pgste, mm);
@@ -452,12 +456,53 @@ int ptep_force_prot(struct mm_struct *mm, unsigned long addr,
 		pte_val(entry) &= ~_PAGE_INVALID;
 		pte_val(entry) |= _PAGE_PROTECT;
 	}
-	pgste_val(pgste) |= PGSTE_IN_BIT;
+	pgste_val(pgste) |= bit;
 	pgste = pgste_set_pte(ptep, pgste, entry);
 	pgste_set_unlock(ptep, pgste);
 	return 0;
 }
 
+int ptep_shadow_pte(struct mm_struct *mm, unsigned long saddr,
+		    pte_t *sptep, pte_t *tptep, int write)
+{
+	pgste_t spgste, tpgste;
+	pte_t spte, tpte;
+	int rc = -EAGAIN;
+
+	spgste = pgste_get_lock(sptep);
+	spte = *sptep;
+	if (!(pte_val(spte) & _PAGE_INVALID) &&
+	    !(pte_val(spte) & _PAGE_PROTECT)) {
+		rc = 0;
+		if (!(pte_val(*tptep) & _PAGE_INVALID))
+			/* Update existing mapping */
+			ptep_flush_direct(mm, saddr, tptep);
+		else
+			rc = 1;
+		pgste_val(spgste) |= PGSTE_VSIE_BIT;
+		tpgste = pgste_get_lock(tptep);
+		pte_val(tpte) = (pte_val(spte) & PAGE_MASK) |
+			(write ? 0 : _PAGE_PROTECT);
+		/* don't touch the storage key - it belongs to parent pgste */
+		tpgste = pgste_set_pte(tptep, tpgste, tpte);
+		pgste_set_unlock(tptep, tpgste);
+	}
+	pgste_set_unlock(sptep, spgste);
+	return rc;
+}
+
+void ptep_unshadow_pte(struct mm_struct *mm, unsigned long saddr, pte_t *ptep)
+{
+	pgste_t pgste;
+
+	pgste = pgste_get_lock(ptep);
+	/* notifier is called by the caller */
+	ptep_flush_direct(mm, saddr, ptep);
+	/* don't touch the storage key - it belongs to parent pgste */
+	pgste = pgste_set_pte(ptep, pgste, __pte(_PAGE_INVALID));
+	pgste_set_unlock(ptep, pgste);
+}
+
 static void ptep_zap_swap_entry(struct mm_struct *mm, swp_entry_t entry)
 {
 	if (!non_swap_entry(entry))
-- 
2.5.5
