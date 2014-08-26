From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 13/15] KVM: s390/mm: use radix trees for guest to host mappings
Date: Tue, 26 Aug 2014 10:28:25 +0200
Message-ID: <1409041707-39938-14-git-send-email-borntraeger@de.ibm.com>
References: <1409041707-39938-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1409041707-39938-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Store the target address for the gmap segments in a radix tree
instead of using invalid segment table entries. gmap_translate
becomes a simple radix_tree_lookup, gmap_fault is split into the
address translation with gmap_translate and the part that does
the linking of the gmap shadow page table with the process page
table.
A second radix tree is used to keep the pointers to the segment
table entries for segments that are mapped in the guest address
space. On unmap of a segment the pointer is retrieved from the
radix tree and is used to carry out the segment invalidation in
the gmap shadow page table. As the radix tree can only store one
pointer, each host segment may only be mapped to exactly one
guest location.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/pgalloc.h |   8 +-
 arch/s390/include/asm/pgtable.h |  15 +-
 arch/s390/include/asm/tlb.h     |   2 +-
 arch/s390/kvm/kvm-s390.c        |  18 +-
 arch/s390/mm/fault.c            |  25 +-
 arch/s390/mm/pgtable.c          | 621 +++++++++++++++++-----------------------
 arch/s390/mm/vmem.c             |   2 +-
 7 files changed, 308 insertions(+), 383 deletions(-)

diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
index 9e18a61..d39a31c 100644
--- a/arch/s390/include/asm/pgalloc.h
+++ b/arch/s390/include/asm/pgalloc.h
@@ -18,9 +18,9 @@
 unsigned long *crst_table_alloc(struct mm_struct *);
 void crst_table_free(struct mm_struct *, unsigned long *);
 
-unsigned long *page_table_alloc(struct mm_struct *, unsigned long);
+unsigned long *page_table_alloc(struct mm_struct *);
 void page_table_free(struct mm_struct *, unsigned long *);
-void page_table_free_rcu(struct mmu_gather *, unsigned long *);
+void page_table_free_rcu(struct mmu_gather *, unsigned long *, unsigned long);
 
 void page_table_reset_pgste(struct mm_struct *, unsigned long, unsigned long,
 			    bool init_skey);
@@ -145,8 +145,8 @@ static inline void pmd_populate(struct mm_struct *mm,
 /*
  * page table entry allocation/free routines.
  */
-#define pte_alloc_one_kernel(mm, vmaddr) ((pte_t *) page_table_alloc(mm, vmaddr))
-#define pte_alloc_one(mm, vmaddr) ((pte_t *) page_table_alloc(mm, vmaddr))
+#define pte_alloc_one_kernel(mm, vmaddr) ((pte_t *) page_table_alloc(mm))
+#define pte_alloc_one(mm, vmaddr) ((pte_t *) page_table_alloc(mm))
 
 #define pte_free_kernel(mm, pte) page_table_free(mm, (unsigned long *) pte)
 #define pte_free(mm, pte) page_table_free(mm, (unsigned long *) pte)
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index d95012f..9bfdbca 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -30,6 +30,7 @@
 #include <linux/sched.h>
 #include <linux/mm_types.h>
 #include <linux/page-flags.h>
+#include <linux/radix-tree.h>
 #include <asm/bug.h>
 #include <asm/page.h>
 
@@ -789,19 +790,25 @@ static inline pgste_t pgste_set_pte(pte_t *ptep, pgste_t pgste, pte_t entry)
 
 /**
  * struct gmap_struct - guest address space
+ * @crst_list: list of all crst tables used in the guest address space
  * @mm: pointer to the parent mm_struct
+ * @guest_to_host: radix tree with guest to host address translation
+ * @host_to_guest: radix tree with pointer to segment table entries
+ * @guest_table_lock: spinlock to protect all entries in the guest page table
  * @table: pointer to the page directory
  * @asce: address space control element for gmap page table
- * @crst_list: list of all crst tables used in the guest address space
  * @pfault_enabled: defines if pfaults are applicable for the guest
  */
 struct gmap {
 	struct list_head list;
+	struct list_head crst_list;
 	struct mm_struct *mm;
+	struct radix_tree_root guest_to_host;
+	struct radix_tree_root host_to_guest;
+	spinlock_t guest_table_lock;
 	unsigned long *table;
 	unsigned long asce;
 	void *private;
-	struct list_head crst_list;
 	bool pfault_enabled;
 };
 
@@ -846,8 +853,8 @@ int gmap_map_segment(struct gmap *gmap, unsigned long from,
 int gmap_unmap_segment(struct gmap *gmap, unsigned long to, unsigned long len);
 unsigned long __gmap_translate(struct gmap *, unsigned long gaddr);
 unsigned long gmap_translate(struct gmap *, unsigned long gaddr);
-unsigned long __gmap_fault(struct gmap *, unsigned long gaddr);
-unsigned long gmap_fault(struct gmap *, unsigned long gaddr);
+int __gmap_link(struct gmap *gmap, unsigned long gaddr, unsigned long vmaddr);
+int gmap_fault(struct gmap *, unsigned long gaddr, unsigned int fault_flags);
 void gmap_discard(struct gmap *, unsigned long from, unsigned long to);
 void __gmap_zap(struct gmap *, unsigned long gaddr);
 bool gmap_test_and_clear_dirty(unsigned long address, struct gmap *);
diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index a25f09f..572c599 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -105,7 +105,7 @@ static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
 static inline void pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 				unsigned long address)
 {
-	page_table_free_rcu(tlb, (unsigned long *) pte);
+	page_table_free_rcu(tlb, (unsigned long *) pte, address);
 }
 
 /*
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 5c877c8..543c24b 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1092,18 +1092,8 @@ retry:
  */
 long kvm_arch_fault_in_page(struct kvm_vcpu *vcpu, gpa_t gpa, int writable)
 {
-	struct mm_struct *mm = current->mm;
-	hva_t hva;
-	long rc;
-
-	hva = gmap_fault(vcpu->arch.gmap, gpa);
-	if (IS_ERR_VALUE(hva))
-		return (long)hva;
-	down_read(&mm->mmap_sem);
-	rc = get_user_pages(current, mm, hva, 1, writable, 0, NULL, NULL);
-	up_read(&mm->mmap_sem);
-
-	return rc < 0 ? rc : 0;
+	return gmap_fault(vcpu->arch.gmap, gpa,
+			  writable ? FAULT_FLAG_WRITE : 0);
 }
 
 static void __kvm_inject_pfault_token(struct kvm_vcpu *vcpu, bool start_token,
@@ -1683,9 +1673,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	}
 #endif
 	case KVM_S390_VCPU_FAULT: {
-		r = gmap_fault(vcpu->arch.gmap, arg);
-		if (!IS_ERR_VALUE(r))
-			r = 0;
+		r = gmap_fault(vcpu->arch.gmap, arg, 0);
 		break;
 	}
 	case KVM_ENABLE_CAP:
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 4880399..a2b81d6 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -442,18 +442,15 @@ static inline int do_exception(struct pt_regs *regs, int access)
 	down_read(&mm->mmap_sem);
 
 #ifdef CONFIG_PGSTE
-	gmap = (struct gmap *)
-		((current->flags & PF_VCPU) ? S390_lowcore.gmap : 0);
+	gmap = (current->flags & PF_VCPU) ?
+		(struct gmap *) S390_lowcore.gmap : NULL;
 	if (gmap) {
-		address = __gmap_fault(gmap, address);
+		current->thread.gmap_addr = address;
+		address = __gmap_translate(gmap, address);
 		if (address == -EFAULT) {
 			fault = VM_FAULT_BADMAP;
 			goto out_up;
 		}
-		if (address == -ENOMEM) {
-			fault = VM_FAULT_OOM;
-			goto out_up;
-		}
 		if (gmap->pfault_enabled)
 			flags |= FAULT_FLAG_RETRY_NOWAIT;
 	}
@@ -530,6 +527,20 @@ retry:
 			goto retry;
 		}
 	}
+#ifdef CONFIG_PGSTE
+	if (gmap) {
+		address =  __gmap_link(gmap, current->thread.gmap_addr,
+				       address);
+		if (address == -EFAULT) {
+			fault = VM_FAULT_BADMAP;
+			goto out_up;
+		}
+		if (address == -ENOMEM) {
+			fault = VM_FAULT_OOM;
+			goto out_up;
+		}
+	}
+#endif
 	fault = 0;
 out_up:
 	up_read(&mm->mmap_sem);
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 16ca861..74dfd9e 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -158,17 +158,23 @@ struct gmap *gmap_alloc(struct mm_struct *mm)
 	if (!gmap)
 		goto out;
 	INIT_LIST_HEAD(&gmap->crst_list);
+	INIT_RADIX_TREE(&gmap->guest_to_host, GFP_KERNEL);
+	INIT_RADIX_TREE(&gmap->host_to_guest, GFP_ATOMIC);
+	spin_lock_init(&gmap->guest_table_lock);
 	gmap->mm = mm;
 	page = alloc_pages(GFP_KERNEL, ALLOC_ORDER);
 	if (!page)
 		goto out_free;
+	page->index = 0;
 	list_add(&page->lru, &gmap->crst_list);
 	table = (unsigned long *) page_to_phys(page);
 	crst_table_init(table, _REGION1_ENTRY_EMPTY);
 	gmap->table = table;
 	gmap->asce = _ASCE_TYPE_REGION1 | _ASCE_TABLE_LENGTH |
 		     _ASCE_USER_BITS | __pa(table);
+	down_write(&mm->mmap_sem);
 	list_add(&gmap->list, &mm->context.gmap_list);
+	up_write(&mm->mmap_sem);
 	return gmap;
 
 out_free:
@@ -178,27 +184,6 @@ out:
 }
 EXPORT_SYMBOL_GPL(gmap_alloc);
 
-static int gmap_unlink_segment(struct gmap *gmap, unsigned long *table)
-{
-	struct gmap_pgtable *mp;
-	struct gmap_rmap *rmap;
-	struct page *page;
-
-	if (*table & _SEGMENT_ENTRY_INVALID)
-		return 0;
-	page = pfn_to_page(*table >> PAGE_SHIFT);
-	mp = (struct gmap_pgtable *) page->index;
-	list_for_each_entry(rmap, &mp->mapper, list) {
-		if (rmap->entry != table)
-			continue;
-		list_del(&rmap->list);
-		kfree(rmap);
-		break;
-	}
-	*table = mp->vmaddr | _SEGMENT_ENTRY_INVALID | _SEGMENT_ENTRY_PROTECT;
-	return 1;
-}
-
 static void gmap_flush_tlb(struct gmap *gmap)
 {
 	if (MACHINE_HAS_IDTE)
@@ -208,6 +193,30 @@ static void gmap_flush_tlb(struct gmap *gmap)
 		__tlb_flush_global();
 }
 
+static void gmap_radix_tree_free(struct radix_tree_root *root)
+{
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
+			radix_tree_delete(root, index);
+		}
+	} while (nr > 0);
+}
+
 /**
  * gmap_free - free a guest address space
  * @gmap: pointer to the guest address space structure
@@ -215,9 +224,6 @@ static void gmap_flush_tlb(struct gmap *gmap)
 void gmap_free(struct gmap *gmap)
 {
 	struct page *page, *next;
-	unsigned long *table;
-	int i;
-
 
 	/* Flush tlb. */
 	if (MACHINE_HAS_IDTE)
@@ -227,19 +233,13 @@ void gmap_free(struct gmap *gmap)
 		__tlb_flush_global();
 
 	/* Free all segment & region tables. */
-	down_read(&gmap->mm->mmap_sem);
-	spin_lock(&gmap->mm->page_table_lock);
-	list_for_each_entry_safe(page, next, &gmap->crst_list, lru) {
-		table = (unsigned long *) page_to_phys(page);
-		if ((*table & _REGION_ENTRY_TYPE_MASK) == 0)
-			/* Remove gmap rmap structures for segment table. */
-			for (i = 0; i < PTRS_PER_PMD; i++, table++)
-				gmap_unlink_segment(gmap, table);
+	list_for_each_entry_safe(page, next, &gmap->crst_list, lru)
 		__free_pages(page, ALLOC_ORDER);
-	}
-	spin_unlock(&gmap->mm->page_table_lock);
-	up_read(&gmap->mm->mmap_sem);
+	gmap_radix_tree_free(&gmap->guest_to_host);
+	gmap_radix_tree_free(&gmap->host_to_guest);
+	down_write(&gmap->mm->mmap_sem);
 	list_del(&gmap->list);
+	up_write(&gmap->mm->mmap_sem);
 	kfree(gmap);
 }
 EXPORT_SYMBOL_GPL(gmap_free);
@@ -267,32 +267,88 @@ EXPORT_SYMBOL_GPL(gmap_disable);
 /*
  * gmap_alloc_table is assumed to be called with mmap_sem held
  */
-static int gmap_alloc_table(struct gmap *gmap,
-			    unsigned long *table, unsigned long init)
-	__releases(&gmap->mm->page_table_lock)
-	__acquires(&gmap->mm->page_table_lock)
+static int gmap_alloc_table(struct gmap *gmap, unsigned long *table,
+			    unsigned long init, unsigned long gaddr)
 {
 	struct page *page;
 	unsigned long *new;
 
 	/* since we dont free the gmap table until gmap_free we can unlock */
-	spin_unlock(&gmap->mm->page_table_lock);
 	page = alloc_pages(GFP_KERNEL, ALLOC_ORDER);
-	spin_lock(&gmap->mm->page_table_lock);
 	if (!page)
 		return -ENOMEM;
 	new = (unsigned long *) page_to_phys(page);
 	crst_table_init(new, init);
+	spin_lock(&gmap->mm->page_table_lock);
 	if (*table & _REGION_ENTRY_INVALID) {
 		list_add(&page->lru, &gmap->crst_list);
 		*table = (unsigned long) new | _REGION_ENTRY_LENGTH |
 			(*table & _REGION_ENTRY_TYPE_MASK);
-	} else
+		page->index = gaddr;
+		page = NULL;
+	}
+	spin_unlock(&gmap->mm->page_table_lock);
+	if (page)
 		__free_pages(page, ALLOC_ORDER);
 	return 0;
 }
 
 /**
+ * __gmap_segment_gaddr - find virtual address from segment pointer
+ * @entry: pointer to a segment table entry in the guest address space
+ *
+ * Returns the virtual address in the guest address space for the segment
+ */
+static unsigned long __gmap_segment_gaddr(unsigned long *entry)
+{
+	struct page *page;
+	unsigned long offset;
+
+	offset = (unsigned long) entry / sizeof(unsigned long);
+	offset = (offset & (PTRS_PER_PMD - 1)) * PMD_SIZE;
+	page = pmd_to_page((pmd_t *) entry);
+	return page->index + offset;
+}
+
+/**
+ * __gmap_unlink_by_vmaddr - unlink a single segment via a host address
+ * @gmap: pointer to the guest address space structure
+ * @vmaddr: address in the host process address space
+ *
+ * Returns 1 if a TLB flush is required
+ */
+static int __gmap_unlink_by_vmaddr(struct gmap *gmap, unsigned long vmaddr)
+{
+	unsigned long *entry;
+	int flush = 0;
+
+	spin_lock(&gmap->guest_table_lock);
+	entry = radix_tree_delete(&gmap->host_to_guest, vmaddr >> PMD_SHIFT);
+	if (entry) {
+		flush = (*entry != _SEGMENT_ENTRY_INVALID);
+		*entry = _SEGMENT_ENTRY_INVALID;
+	}
+	spin_unlock(&gmap->guest_table_lock);
+	return flush;
+}
+
+/**
+ * __gmap_unmap_by_gaddr - unmap a single segment via a guest address
+ * @gmap: pointer to the guest address space structure
+ * @gaddr: address in the guest address space
+ *
+ * Returns 1 if a TLB flush is required
+ */
+static int __gmap_unmap_by_gaddr(struct gmap *gmap, unsigned long gaddr)
+{
+	unsigned long vmaddr;
+
+	vmaddr = (unsigned long) radix_tree_delete(&gmap->guest_to_host,
+						   gaddr >> PMD_SHIFT);
+	return vmaddr ? __gmap_unlink_by_vmaddr(gmap, vmaddr) : 0;
+}
+
+/**
  * gmap_unmap_segment - unmap segment from the guest address space
  * @gmap: pointer to the guest address space structure
  * @to: address in the guest address space
@@ -302,7 +358,6 @@ static int gmap_alloc_table(struct gmap *gmap,
  */
 int gmap_unmap_segment(struct gmap *gmap, unsigned long to, unsigned long len)
 {
-	unsigned long *table;
 	unsigned long off;
 	int flush;
 
@@ -312,31 +367,10 @@ int gmap_unmap_segment(struct gmap *gmap, unsigned long to, unsigned long len)
 		return -EINVAL;
 
 	flush = 0;
-	down_read(&gmap->mm->mmap_sem);
-	spin_lock(&gmap->mm->page_table_lock);
-	for (off = 0; off < len; off += PMD_SIZE) {
-		/* Walk the guest addr space page table */
-		table = gmap->table + (((to + off) >> 53) & 0x7ff);
-		if (*table & _REGION_ENTRY_INVALID)
-			goto out;
-		table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
-		table = table + (((to + off) >> 42) & 0x7ff);
-		if (*table & _REGION_ENTRY_INVALID)
-			goto out;
-		table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
-		table = table + (((to + off) >> 31) & 0x7ff);
-		if (*table & _REGION_ENTRY_INVALID)
-			goto out;
-		table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
-		table = table + (((to + off) >> 20) & 0x7ff);
-
-		/* Clear segment table entry in guest address space. */
-		flush |= gmap_unlink_segment(gmap, table);
-		*table = _SEGMENT_ENTRY_INVALID;
-	}
-out:
-	spin_unlock(&gmap->mm->page_table_lock);
-	up_read(&gmap->mm->mmap_sem);
+	down_write(&gmap->mm->mmap_sem);
+	for (off = 0; off < len; off += PMD_SIZE)
+		flush |= __gmap_unmap_by_gaddr(gmap, to + off);
+	up_write(&gmap->mm->mmap_sem);
 	if (flush)
 		gmap_flush_tlb(gmap);
 	return 0;
@@ -355,7 +389,6 @@ EXPORT_SYMBOL_GPL(gmap_unmap_segment);
 int gmap_map_segment(struct gmap *gmap, unsigned long from,
 		     unsigned long to, unsigned long len)
 {
-	unsigned long *table;
 	unsigned long off;
 	int flush;
 
@@ -366,66 +399,26 @@ int gmap_map_segment(struct gmap *gmap, unsigned long from,
 		return -EINVAL;
 
 	flush = 0;
-	down_read(&gmap->mm->mmap_sem);
-	spin_lock(&gmap->mm->page_table_lock);
+	down_write(&gmap->mm->mmap_sem);
 	for (off = 0; off < len; off += PMD_SIZE) {
-		/* Walk the gmap address space page table */
-		table = gmap->table + (((to + off) >> 53) & 0x7ff);
-		if ((*table & _REGION_ENTRY_INVALID) &&
-		    gmap_alloc_table(gmap, table, _REGION2_ENTRY_EMPTY))
-			goto out_unmap;
-		table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
-		table = table + (((to + off) >> 42) & 0x7ff);
-		if ((*table & _REGION_ENTRY_INVALID) &&
-		    gmap_alloc_table(gmap, table, _REGION3_ENTRY_EMPTY))
-			goto out_unmap;
-		table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
-		table = table + (((to + off) >> 31) & 0x7ff);
-		if ((*table & _REGION_ENTRY_INVALID) &&
-		    gmap_alloc_table(gmap, table, _SEGMENT_ENTRY_EMPTY))
-			goto out_unmap;
-		table = (unsigned long *) (*table & _REGION_ENTRY_ORIGIN);
-		table = table + (((to + off) >> 20) & 0x7ff);
-
-		/* Store 'from' address in an invalid segment table entry. */
-		flush |= gmap_unlink_segment(gmap, table);
-		*table =  (from + off) | (_SEGMENT_ENTRY_INVALID |
-					  _SEGMENT_ENTRY_PROTECT);
+		/* Remove old translation */
+		flush |= __gmap_unmap_by_gaddr(gmap, to + off);
+		/* Store new translation */
+		if (radix_tree_insert(&gmap->guest_to_host,
+				      (to + off) >> PMD_SHIFT,
+				      (void *) from + off))
+			break;
 	}
-	spin_unlock(&gmap->mm->page_table_lock);
-	up_read(&gmap->mm->mmap_sem);
+	up_write(&gmap->mm->mmap_sem);
 	if (flush)
 		gmap_flush_tlb(gmap);
-	return 0;
-
-out_unmap:
-	spin_unlock(&gmap->mm->page_table_lock);
-	up_read(&gmap->mm->mmap_sem);
+	if (off >= len)
+		return 0;
 	gmap_unmap_segment(gmap, to, len);
 	return -ENOMEM;
 }
 EXPORT_SYMBOL_GPL(gmap_map_segment);
 
-static unsigned long *gmap_table_walk(struct gmap *gmap, unsigned long gaddr)
-{
-	unsigned long *table;
-
-	table = gmap->table + ((gaddr >> 53) & 0x7ff);
-	if (unlikely(*table & _REGION_ENTRY_INVALID))
-		return ERR_PTR(-EFAULT);
-	table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
-	table = table + ((gaddr >> 42) & 0x7ff);
-	if (unlikely(*table & _REGION_ENTRY_INVALID))
-		return ERR_PTR(-EFAULT);
-	table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
-	table = table + ((gaddr >> 31) & 0x7ff);
-	if (unlikely(*table & _REGION_ENTRY_INVALID))
-		return ERR_PTR(-EFAULT);
-	table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
-	table = table + ((gaddr >> 20) & 0x7ff);
-	return table;
-}
-
 /**
  * __gmap_translate - translate a guest address to a user space address
  * @gmap: pointer to guest mapping meta data structure
@@ -439,25 +432,11 @@ static unsigned long *gmap_table_walk(struct gmap *gmap, unsigned long gaddr)
  */
 unsigned long __gmap_translate(struct gmap *gmap, unsigned long gaddr)
 {
-	unsigned long *segment_ptr, vmaddr, segment;
-	struct gmap_pgtable *mp;
-	struct page *page;
+	unsigned long vmaddr;
 
-	current->thread.gmap_addr = gaddr;
-	segment_ptr = gmap_table_walk(gmap, gaddr);
-	if (IS_ERR(segment_ptr))
-		return PTR_ERR(segment_ptr);
-	/* Convert the gmap address to an mm address. */
-	segment = *segment_ptr;
-	if (!(segment & _SEGMENT_ENTRY_INVALID)) {
-		page = pfn_to_page(segment >> PAGE_SHIFT);
-		mp = (struct gmap_pgtable *) page->index;
-		return mp->vmaddr | (gaddr & ~PMD_MASK);
-	} else if (segment & _SEGMENT_ENTRY_PROTECT) {
-		vmaddr = segment & _SEGMENT_ENTRY_ORIGIN;
-		return vmaddr | (gaddr & ~PMD_MASK);
-	}
-	return -EFAULT;
+	vmaddr = (unsigned long)
+		radix_tree_lookup(&gmap->guest_to_host, gaddr >> PMD_SHIFT);
+	return vmaddr ? (vmaddr | (gaddr & ~PMD_MASK)) : -EFAULT;
 }
 EXPORT_SYMBOL_GPL(__gmap_translate);
 
@@ -481,125 +460,124 @@ unsigned long gmap_translate(struct gmap *gmap, unsigned long gaddr)
 }
 EXPORT_SYMBOL_GPL(gmap_translate);
 
-static int gmap_connect_pgtable(struct gmap *gmap, unsigned long gaddr,
-				unsigned long segment,
-				unsigned long *segment_ptr)
+/**
+ * gmap_unlink - disconnect a page table from the gmap shadow tables
+ * @gmap: pointer to guest mapping meta data structure
+ * @table: pointer to the host page table
+ * @vmaddr: vm address associated with the host page table
+ */
+static void gmap_unlink(struct mm_struct *mm, unsigned long *table,
+			unsigned long vmaddr)
+{
+	struct gmap *gmap;
+	int flush;
+
+	list_for_each_entry(gmap, &mm->context.gmap_list, list) {
+		flush = __gmap_unlink_by_vmaddr(gmap, vmaddr);
+		if (flush)
+			gmap_flush_tlb(gmap);
+	}
+}
+
+/**
+ * gmap_link - set up shadow page tables to connect a host to a guest address
+ * @gmap: pointer to guest mapping meta data structure
+ * @gaddr: guest address
+ * @vmaddr: vm address
+ *
+ * Returns 0 on success, -ENOMEM for out of memory conditions, and -EFAULT
+ * if the vm address is already mapped to a different guest segment.
+ * The mmap_sem of the mm that belongs to the address space must be held
+ * when this function gets called.
+ */
+int __gmap_link(struct gmap *gmap, unsigned long gaddr, unsigned long vmaddr)
 {
-	unsigned long vmaddr;
-	struct vm_area_struct *vma;
-	struct gmap_pgtable *mp;
-	struct gmap_rmap *rmap;
 	struct mm_struct *mm;
-	struct page *page;
+	unsigned long *table;
+	spinlock_t *ptl;
 	pgd_t *pgd;
 	pud_t *pud;
 	pmd_t *pmd;
+	int rc;
 
-	mm = gmap->mm;
-	vmaddr = segment & _SEGMENT_ENTRY_ORIGIN;
-	vma = find_vma(mm, vmaddr);
-	if (!vma || vma->vm_start > vmaddr)
-		return -EFAULT;
-	/* Walk the parent mm page table */
-	pgd = pgd_offset(mm, vmaddr);
-	pud = pud_alloc(mm, pgd, vmaddr);
-	if (!pud)
+	/* Create higher level tables in the gmap page table */
+	table = gmap->table + ((gaddr >> 53) & 0x7ff);
+	if ((*table & _REGION_ENTRY_INVALID) &&
+	    gmap_alloc_table(gmap, table, _REGION2_ENTRY_EMPTY,
+			     gaddr & 0xffe0000000000000))
 		return -ENOMEM;
-	pmd = pmd_alloc(mm, pud, vmaddr);
-	if (!pmd)
+	table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
+	table = table + ((gaddr >> 42) & 0x7ff);
+	if ((*table & _REGION_ENTRY_INVALID) &&
+	    gmap_alloc_table(gmap, table, _REGION3_ENTRY_EMPTY,
+			     gaddr & 0xfffffc0000000000))
 		return -ENOMEM;
-	if (!pmd_present(*pmd) &&
-	    __pte_alloc(mm, vma, pmd, vmaddr))
+	table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
+	table = table + ((gaddr >> 31) & 0x7ff);
+	if ((*table & _REGION_ENTRY_INVALID) &&
+	    gmap_alloc_table(gmap, table, _SEGMENT_ENTRY_EMPTY,
+			     gaddr & 0xffffffff80000000))
 		return -ENOMEM;
+	table = (unsigned long *) (*table & _REGION_ENTRY_ORIGIN);
+	table = table + ((gaddr >> 20) & 0x7ff);
+	/* Walk the parent mm page table */
+	mm = gmap->mm;
+	pgd = pgd_offset(mm, vmaddr);
+	VM_BUG_ON(pgd_none(*pgd));
+	pud = pud_offset(pgd, vmaddr);
+	VM_BUG_ON(pud_none(*pud));
+	pmd = pmd_offset(pud, vmaddr);
+	VM_BUG_ON(pmd_none(*pmd));
 	/* large pmds cannot yet be handled */
 	if (pmd_large(*pmd))
 		return -EFAULT;
-	/* pmd now points to a valid segment table entry. */
-	rmap = kmalloc(sizeof(*rmap), GFP_KERNEL|__GFP_REPEAT);
-	if (!rmap)
-		return -ENOMEM;
 	/* Link gmap segment table entry location to page table. */
-	page = pmd_page(*pmd);
-	mp = (struct gmap_pgtable *) page->index;
-	rmap->gmap = gmap;
-	rmap->entry = segment_ptr;
-	rmap->vmaddr = gaddr & PMD_MASK;
-	spin_lock(&mm->page_table_lock);
-	if (*segment_ptr == segment) {
-		list_add(&rmap->list, &mp->mapper);
-		/* Set gmap segment table entry to page table. */
-		*segment_ptr = pmd_val(*pmd) & PAGE_MASK;
-		rmap = NULL;
-	}
-	spin_unlock(&mm->page_table_lock);
-	kfree(rmap);
-	return 0;
-}
-
-static void gmap_disconnect_pgtable(struct mm_struct *mm, unsigned long *table)
-{
-	struct gmap_rmap *rmap, *next;
-	struct gmap_pgtable *mp;
-	struct page *page;
-	int flush;
-
-	flush = 0;
-	spin_lock(&mm->page_table_lock);
-	page = pfn_to_page(__pa(table) >> PAGE_SHIFT);
-	mp = (struct gmap_pgtable *) page->index;
-	list_for_each_entry_safe(rmap, next, &mp->mapper, list) {
-		*rmap->entry = mp->vmaddr | (_SEGMENT_ENTRY_INVALID |
-					     _SEGMENT_ENTRY_PROTECT);
-		list_del(&rmap->list);
-		kfree(rmap);
-		flush = 1;
-	}
-	spin_unlock(&mm->page_table_lock);
-	if (flush)
-		__tlb_flush_global();
+	rc = radix_tree_preload(GFP_KERNEL);
+	if (rc)
+		return rc;
+	ptl = pmd_lock(mm, pmd);
+	spin_lock(&gmap->guest_table_lock);
+	if (*table == _SEGMENT_ENTRY_INVALID) {
+		rc = radix_tree_insert(&gmap->host_to_guest,
+				       vmaddr >> PMD_SHIFT, table);
+		if (!rc)
+			*table = pmd_val(*pmd);
+	} else
+		rc = 0;
+	spin_unlock(&gmap->guest_table_lock);
+	spin_unlock(ptl);
+	radix_tree_preload_end();
+	return rc;
 }
 
-/*
- * this function is assumed to be called with mmap_sem held
+/**
+ * gmap_fault - resolve a fault on a guest address
+ * @gmap: pointer to guest mapping meta data structure
+ * @gaddr: guest address
+ * @fault_flags: flags to pass down to handle_mm_fault()
+ *
+ * Returns 0 on success, -ENOMEM for out of memory conditions, and -EFAULT
+ * if the vm address is already mapped to a different guest segment.
  */
-unsigned long __gmap_fault(struct gmap *gmap, unsigned long gaddr)
+int gmap_fault(struct gmap *gmap, unsigned long gaddr,
+	       unsigned int fault_flags)
 {
-	unsigned long *segment_ptr, segment;
-	struct gmap_pgtable *mp;
-	struct page *page;
+	unsigned long vmaddr;
 	int rc;
 
-	current->thread.gmap_addr = gaddr;
-	segment_ptr = gmap_table_walk(gmap, gaddr);
-	if (IS_ERR(segment_ptr))
-		return -EFAULT;
-	/* Convert the gmap address to an mm address. */
-	while (1) {
-		segment = *segment_ptr;
-		if (!(segment & _SEGMENT_ENTRY_INVALID)) {
-			/* Page table is present */
-			page = pfn_to_page(segment >> PAGE_SHIFT);
-			mp = (struct gmap_pgtable *) page->index;
-			return mp->vmaddr | (gaddr & ~PMD_MASK);
-		}
-		if (!(segment & _SEGMENT_ENTRY_PROTECT))
-			/* Nothing mapped in the gmap address space. */
-			break;
-		rc = gmap_connect_pgtable(gmap, gaddr, segment, segment_ptr);
-		if (rc)
-			return rc;
-	}
-	return -EFAULT;
-}
-
-unsigned long gmap_fault(struct gmap *gmap, unsigned long gaddr)
-{
-	unsigned long rc;
-
 	down_read(&gmap->mm->mmap_sem);
-	rc = __gmap_fault(gmap, gaddr);
+	vmaddr = __gmap_translate(gmap, gaddr);
+	if (IS_ERR_VALUE(vmaddr)) {
+		rc = vmaddr;
+		goto out_up;
+	}
+	if (fixup_user_fault(current, gmap->mm, vmaddr, fault_flags)) {
+		rc = -EFAULT;
+		goto out_up;
+	}
+	rc = __gmap_link(gmap, gaddr, vmaddr);
+out_up:
 	up_read(&gmap->mm->mmap_sem);
-
 	return rc;
 }
 EXPORT_SYMBOL_GPL(gmap_fault);
@@ -619,17 +597,24 @@ static void gmap_zap_swap_entry(swp_entry_t entry, struct mm_struct *mm)
 	free_swap_and_cache(entry);
 }
 
-/**
- * The mm->mmap_sem lock must be held
+/*
+ * this function is assumed to be called with mmap_sem held
  */
-static void gmap_zap_unused(struct mm_struct *mm, unsigned long vmaddr)
+void __gmap_zap(struct gmap *gmap, unsigned long gaddr)
 {
-	unsigned long ptev, pgstev;
+	unsigned long vmaddr, ptev, pgstev;
+	pte_t *ptep, pte;
 	spinlock_t *ptl;
 	pgste_t pgste;
-	pte_t *ptep, pte;
 
-	ptep = get_locked_pte(mm, vmaddr, &ptl);
+	/* Find the vm address for the guest address */
+	vmaddr = (unsigned long) radix_tree_lookup(&gmap->guest_to_host,
+						   gaddr >> PMD_SHIFT);
+	if (!vmaddr)
+		return;
+	vmaddr |= gaddr & ~PMD_MASK;
+	/* Get pointer to the page table entry */
+	ptep = get_locked_pte(gmap->mm, vmaddr, &ptl);
 	if (unlikely(!ptep))
 		return;
 	pte = *ptep;
@@ -641,87 +626,34 @@ static void gmap_zap_unused(struct mm_struct *mm, unsigned long vmaddr)
 	ptev = pte_val(pte);
 	if (((pgstev & _PGSTE_GPS_USAGE_MASK) == _PGSTE_GPS_USAGE_UNUSED) ||
 	    ((pgstev & _PGSTE_GPS_ZERO) && (ptev & _PAGE_INVALID))) {
-		gmap_zap_swap_entry(pte_to_swp_entry(pte), mm);
-		pte_clear(mm, vmaddr, ptep);
+		gmap_zap_swap_entry(pte_to_swp_entry(pte), gmap->mm);
+		pte_clear(gmap->mm, vmaddr, ptep);
 	}
 	pgste_set_unlock(ptep, pgste);
 out_pte:
 	pte_unmap_unlock(*ptep, ptl);
 }
-
-/*
- * this function is assumed to be called with mmap_sem held
- */
-void __gmap_zap(struct gmap *gmap, unsigned long gaddr)
-{
-	unsigned long *table, *segment_ptr;
-	unsigned long segment, vmaddr, pgstev, ptev;
-	struct gmap_pgtable *mp;
-	struct page *page;
-
-	segment_ptr = gmap_table_walk(gmap, gaddr);
-	if (IS_ERR(segment_ptr))
-		return;
-	segment = *segment_ptr;
-	if (segment & _SEGMENT_ENTRY_INVALID)
-		return;
-	page = pfn_to_page(segment >> PAGE_SHIFT);
-	mp = (struct gmap_pgtable *) page->index;
-	vmaddr = mp->vmaddr | (gaddr & ~PMD_MASK);
-	/* Page table is present */
-	table = (unsigned long *)(segment & _SEGMENT_ENTRY_ORIGIN);
-	table = table + ((vmaddr >> 12) & 0xff);
-	pgstev = table[PTRS_PER_PTE];
-	ptev = table[0];
-	/* quick check, checked again with locks held */
-	if (((pgstev & _PGSTE_GPS_USAGE_MASK) == _PGSTE_GPS_USAGE_UNUSED) ||
-	    ((pgstev & _PGSTE_GPS_ZERO) && (ptev & _PAGE_INVALID)))
-		gmap_zap_unused(gmap->mm, vmaddr);
-}
 EXPORT_SYMBOL_GPL(__gmap_zap);
 
 void gmap_discard(struct gmap *gmap, unsigned long from, unsigned long to)
 {
-
-	unsigned long *table, gaddr, size;
+	unsigned long gaddr, vmaddr, size;
 	struct vm_area_struct *vma;
-	struct gmap_pgtable *mp;
-	struct page *page;
 
 	down_read(&gmap->mm->mmap_sem);
-	gaddr = from;
-	while (gaddr < to) {
-		/* Walk the gmap address space page table */
-		table = gmap->table + ((gaddr >> 53) & 0x7ff);
-		if (unlikely(*table & _REGION_ENTRY_INVALID)) {
-			gaddr = (gaddr + PMD_SIZE) & PMD_MASK;
-			continue;
-		}
-		table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
-		table = table + ((gaddr >> 42) & 0x7ff);
-		if (unlikely(*table & _REGION_ENTRY_INVALID)) {
-			gaddr = (gaddr + PMD_SIZE) & PMD_MASK;
-			continue;
-		}
-		table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
-		table = table + ((gaddr >> 31) & 0x7ff);
-		if (unlikely(*table & _REGION_ENTRY_INVALID)) {
-			gaddr = (gaddr + PMD_SIZE) & PMD_MASK;
-			continue;
-		}
-		table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
-		table = table + ((gaddr >> 20) & 0x7ff);
-		if (unlikely(*table & _SEGMENT_ENTRY_INVALID)) {
-			gaddr = (gaddr + PMD_SIZE) & PMD_MASK;
+	for (gaddr = from; gaddr < to;
+	     gaddr = (gaddr + PMD_SIZE) & PMD_MASK) {
+		/* Find the vm address for the guest address */
+		vmaddr = (unsigned long)
+			radix_tree_lookup(&gmap->guest_to_host,
+					  gaddr >> PMD_SHIFT);
+		if (!vmaddr)
 			continue;
-		}
-		page = pfn_to_page(*table >> PAGE_SHIFT);
-		mp = (struct gmap_pgtable *) page->index;
-		vma = find_vma(gmap->mm, mp->vmaddr);
+		vmaddr |= gaddr & ~PMD_MASK;
+		/* Find vma in the parent mm */
+		vma = find_vma(gmap->mm, vmaddr);
 		size = min(to - gaddr, PMD_SIZE - (gaddr & ~PMD_MASK));
-		zap_page_range(vma, mp->vmaddr | (gaddr & ~PMD_MASK),
-			       size, NULL);
-		gaddr = (gaddr + PMD_SIZE) & PMD_MASK;
+		zap_page_range(vma, vmaddr, size, NULL);
 	}
 	up_read(&gmap->mm->mmap_sem);
 }
@@ -778,7 +710,7 @@ int gmap_ipte_notify(struct gmap *gmap, unsigned long gaddr, unsigned long len)
 	down_read(&gmap->mm->mmap_sem);
 	while (len) {
 		/* Convert gmap address and connect the page tables */
-		addr = __gmap_fault(gmap, gaddr);
+		addr = __gmap_translate(gmap, gaddr);
 		if (IS_ERR_VALUE(addr)) {
 			rc = addr;
 			break;
@@ -788,6 +720,9 @@ int gmap_ipte_notify(struct gmap *gmap, unsigned long gaddr, unsigned long len)
 			rc = -EFAULT;
 			break;
 		}
+		rc = __gmap_link(gmap, gaddr, addr);
+		if (rc)
+			break;
 		/* Walk the process page table, lock and get pte pointer */
 		ptep = get_locked_pte(gmap->mm, addr, &ptl);
 		if (unlikely(!ptep))
@@ -817,23 +752,24 @@ EXPORT_SYMBOL_GPL(gmap_ipte_notify);
  * This function is assumed to be called with the page table lock held
  * for the pte to notify.
  */
-void gmap_do_ipte_notify(struct mm_struct *mm, unsigned long addr, pte_t *pte)
+void gmap_do_ipte_notify(struct mm_struct *mm, unsigned long vmaddr, pte_t *pte)
 {
-	unsigned long segment_offset;
+	unsigned long offset, gaddr;
+	unsigned long *table;
 	struct gmap_notifier *nb;
-	struct gmap_pgtable *mp;
-	struct gmap_rmap *rmap;
-	struct page *page;
+	struct gmap *gmap;
 
-	segment_offset = ((unsigned long) pte) & (255 * sizeof(pte_t));
-	segment_offset = segment_offset * (4096 / sizeof(pte_t));
-	page = pfn_to_page(__pa(pte) >> PAGE_SHIFT);
-	mp = (struct gmap_pgtable *) page->index;
+	offset = ((unsigned long) pte) & (255 * sizeof(pte_t));
+	offset = offset * (4096 / sizeof(pte_t));
 	spin_lock(&gmap_notifier_lock);
-	list_for_each_entry(rmap, &mp->mapper, list) {
+	list_for_each_entry(gmap, &mm->context.gmap_list, list) {
+		table = radix_tree_lookup(&gmap->host_to_guest,
+					  vmaddr >> PMD_SHIFT);
+		if (!table)
+			continue;
+		gaddr = __gmap_segment_gaddr(table) + offset;
 		list_for_each_entry(nb, &gmap_notifier_list, list)
-			nb->notifier_call(rmap->gmap,
-					  rmap->vmaddr + segment_offset);
+			nb->notifier_call(gmap, gaddr);
 	}
 	spin_unlock(&gmap_notifier_lock);
 }
@@ -844,29 +780,18 @@ static inline int page_table_with_pgste(struct page *page)
 	return atomic_read(&page->_mapcount) == 0;
 }
 
-static inline unsigned long *page_table_alloc_pgste(struct mm_struct *mm,
-						    unsigned long vmaddr)
+static inline unsigned long *page_table_alloc_pgste(struct mm_struct *mm)
 {
 	struct page *page;
 	unsigned long *table;
-	struct gmap_pgtable *mp;
 
 	page = alloc_page(GFP_KERNEL|__GFP_REPEAT);
 	if (!page)
 		return NULL;
-	mp = kmalloc(sizeof(*mp), GFP_KERNEL|__GFP_REPEAT);
-	if (!mp) {
-		__free_page(page);
-		return NULL;
-	}
 	if (!pgtable_page_ctor(page)) {
-		kfree(mp);
 		__free_page(page);
 		return NULL;
 	}
-	mp->vmaddr = vmaddr & PMD_MASK;
-	INIT_LIST_HEAD(&mp->mapper);
-	page->index = (unsigned long) mp;
 	atomic_set(&page->_mapcount, 0);
 	table = (unsigned long *) page_to_phys(page);
 	clear_table(table, _PAGE_INVALID, PAGE_SIZE/2);
@@ -877,14 +802,10 @@ static inline unsigned long *page_table_alloc_pgste(struct mm_struct *mm,
 static inline void page_table_free_pgste(unsigned long *table)
 {
 	struct page *page;
-	struct gmap_pgtable *mp;
 
 	page = pfn_to_page(__pa(table) >> PAGE_SHIFT);
-	mp = (struct gmap_pgtable *) page->index;
-	BUG_ON(!list_empty(&mp->mapper));
 	pgtable_page_dtor(page);
 	atomic_set(&page->_mapcount, -1);
-	kfree(mp);
 	__free_page(page);
 }
 
@@ -1041,8 +962,7 @@ static inline int page_table_with_pgste(struct page *page)
 	return 0;
 }
 
-static inline unsigned long *page_table_alloc_pgste(struct mm_struct *mm,
-						    unsigned long vmaddr)
+static inline unsigned long *page_table_alloc_pgste(struct mm_struct *mm)
 {
 	return NULL;
 }
@@ -1056,8 +976,8 @@ static inline void page_table_free_pgste(unsigned long *table)
 {
 }
 
-static inline void gmap_disconnect_pgtable(struct mm_struct *mm,
-					   unsigned long *table)
+static inline void gmap_unlink(struct mm_struct *mm, unsigned long *table,
+			unsigned long vmaddr)
 {
 }
 
@@ -1077,14 +997,14 @@ static inline unsigned int atomic_xor_bits(atomic_t *v, unsigned int bits)
 /*
  * page table entry allocation/free routines.
  */
-unsigned long *page_table_alloc(struct mm_struct *mm, unsigned long vmaddr)
+unsigned long *page_table_alloc(struct mm_struct *mm)
 {
 	unsigned long *uninitialized_var(table);
 	struct page *uninitialized_var(page);
 	unsigned int mask, bit;
 
 	if (mm_has_pgste(mm))
-		return page_table_alloc_pgste(mm, vmaddr);
+		return page_table_alloc_pgste(mm);
 	/* Allocate fragments of a 4K page as 1K/2K page table */
 	spin_lock_bh(&mm->context.list_lock);
 	mask = FRAG_MASK;
@@ -1126,10 +1046,8 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
 	unsigned int bit, mask;
 
 	page = pfn_to_page(__pa(table) >> PAGE_SHIFT);
-	if (page_table_with_pgste(page)) {
-		gmap_disconnect_pgtable(mm, table);
+	if (page_table_with_pgste(page))
 		return page_table_free_pgste(table);
-	}
 	/* Free 1K/2K page table fragment of a 4K page */
 	bit = 1 << ((__pa(table) & ~PAGE_MASK)/(PTRS_PER_PTE*sizeof(pte_t)));
 	spin_lock_bh(&mm->context.list_lock);
@@ -1161,7 +1079,8 @@ static void __page_table_free_rcu(void *table, unsigned bit)
 	}
 }
 
-void page_table_free_rcu(struct mmu_gather *tlb, unsigned long *table)
+void page_table_free_rcu(struct mmu_gather *tlb, unsigned long *table,
+			 unsigned long vmaddr)
 {
 	struct mm_struct *mm;
 	struct page *page;
@@ -1170,7 +1089,7 @@ void page_table_free_rcu(struct mmu_gather *tlb, unsigned long *table)
 	mm = tlb->mm;
 	page = pfn_to_page(__pa(table) >> PAGE_SHIFT);
 	if (page_table_with_pgste(page)) {
-		gmap_disconnect_pgtable(mm, table);
+		gmap_unlink(mm, table, vmaddr);
 		table = (unsigned long *) (__pa(table) | FRAG_MASK);
 		tlb_remove_table(tlb, table);
 		return;
@@ -1306,7 +1225,7 @@ again:
 		if (page_table_with_pgste(page))
 			continue;
 		/* Allocate new page table with pgstes */
-		new = page_table_alloc_pgste(mm, addr);
+		new = page_table_alloc_pgste(mm);
 		if (!new)
 			return -ENOMEM;
 
@@ -1321,7 +1240,7 @@ again:
 			/* Establish new table */
 			pmd_populate(mm, pmd, (pte_t *) new);
 			/* Free old table with rcu, there might be a walker! */
-			page_table_free_rcu(tlb, table);
+			page_table_free_rcu(tlb, table, addr);
 			new = NULL;
 		}
 		spin_unlock(ptl);
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index fe9012a..fdbd788 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -65,7 +65,7 @@ static pte_t __ref *vmem_pte_alloc(unsigned long address)
 	pte_t *pte;
 
 	if (slab_is_available())
-		pte = (pte_t *) page_table_alloc(&init_mm, address);
+		pte = (pte_t *) page_table_alloc(&init_mm);
 	else
 		pte = alloc_bootmem_align(PTRS_PER_PTE * sizeof(pte_t),
 					  PTRS_PER_PTE * sizeof(pte_t));
-- 
1.8.4.2
