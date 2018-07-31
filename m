From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 31 Jul 2018 08:43:57 +0000
Subject: [GIT PULL 11/19] s390/mm: Add huge page dirty sync support
Message-Id: <20180731084405.28953-12-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Janosch Frank <frankja@linux.ibm.com>

To do dirty loging with huge pages, we protect huge pmds in the
gmap. When they are written to, we unprotect them and mark them dirty.

We introduce the function gmap_test_and_clear_dirty_pmd which handles
dirty sync for huge pages.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/include/asm/gmap.h    |   3 +
 arch/s390/include/asm/pgtable.h |   3 +-
 arch/s390/kvm/kvm-s390.c        |  25 +++++--
 arch/s390/mm/gmap.c             | 127 ++++++++++++++++++++++++++++++--
 arch/s390/mm/pgtable.c          |  34 +--------
 5 files changed, 148 insertions(+), 44 deletions(-)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index 276268b48aff..fcbd638fb9f4 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -15,6 +15,7 @@
 
 /* Status bits only for huge segment entries */
 #define _SEGMENT_ENTRY_GMAP_IN		0x8000	/* invalidation notify bit */
+#define _SEGMENT_ENTRY_GMAP_UC		0x4000	/* dirty (migration) */
 
 /**
  * struct gmap_struct - guest address space
@@ -139,4 +140,6 @@ void gmap_pte_notify(struct mm_struct *, unsigned long addr, pte_t *,
 int gmap_mprotect_notify(struct gmap *, unsigned long start,
 			 unsigned long len, int prot);
 
+void gmap_sync_dirty_log_pmd(struct gmap *gmap, unsigned long dirty_bitmap[4],
+			     unsigned long gaddr, unsigned long vmaddr);
 #endif /* _ASM_S390_GMAP_H */
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 087e0282f165..0e7cb0dc9c33 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1103,7 +1103,8 @@ int ptep_shadow_pte(struct mm_struct *mm, unsigned long saddr,
 		    pte_t *sptep, pte_t *tptep, pte_t pte);
 void ptep_unshadow_pte(struct mm_struct *mm, unsigned long saddr, pte_t *ptep);
 
-bool test_and_clear_guest_dirty(struct mm_struct *mm, unsigned long address);
+bool ptep_test_and_clear_uc(struct mm_struct *mm, unsigned long address,
+			    pte_t *ptep);
 int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 			  unsigned char key, bool nq);
 int cond_set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 3b7a5151b6a5..4cff5e31ca36 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -511,19 +511,30 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 }
 
 static void kvm_s390_sync_dirty_log(struct kvm *kvm,
-					struct kvm_memory_slot *memslot)
+				    struct kvm_memory_slot *memslot)
 {
+	int i;
 	gfn_t cur_gfn, last_gfn;
-	unsigned long address;
+	unsigned long gaddr, vmaddr;
 	struct gmap *gmap = kvm->arch.gmap;
+	DECLARE_BITMAP(bitmap, _PAGE_ENTRIES);
 
-	/* Loop over all guest pages */
+	/* Loop over all guest segments */
+	cur_gfn = memslot->base_gfn;
 	last_gfn = memslot->base_gfn + memslot->npages;
-	for (cur_gfn = memslot->base_gfn; cur_gfn <= last_gfn; cur_gfn++) {
-		address = gfn_to_hva_memslot(memslot, cur_gfn);
+	for (; cur_gfn <= last_gfn; cur_gfn += _PAGE_ENTRIES) {
+		gaddr = gfn_to_gpa(cur_gfn);
+		vmaddr = gfn_to_hva_memslot(memslot, cur_gfn);
+		if (kvm_is_error_hva(vmaddr))
+			continue;
+
+		bitmap_zero(bitmap, _PAGE_ENTRIES);
+		gmap_sync_dirty_log_pmd(gmap, bitmap, gaddr, vmaddr);
+		for (i = 0; i < _PAGE_ENTRIES; i++) {
+			if (test_bit(i, bitmap))
+				mark_page_dirty(kvm, cur_gfn + i);
+		}
 
-		if (test_and_clear_guest_dirty(gmap->mm, address))
-			mark_page_dirty(kvm, cur_gfn);
 		if (fatal_signal_pending(current))
 			return;
 		cond_resched();
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 87c174ee3a8c..3807de25a706 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -521,6 +521,9 @@ void gmap_unlink(struct mm_struct *mm, unsigned long *table,
 	rcu_read_unlock();
 }
 
+static void gmap_pmdp_xchg(struct gmap *gmap, pmd_t *old, pmd_t new,
+			   unsigned long gaddr);
+
 /**
  * gmap_link - set up shadow page tables to connect a host to a guest address
  * @gmap: pointer to guest mapping meta data structure
@@ -541,6 +544,7 @@ int __gmap_link(struct gmap *gmap, unsigned long gaddr, unsigned long vmaddr)
 	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
+	u64 unprot;
 	int rc;
 
 	BUG_ON(gmap_is_shadow(gmap));
@@ -598,12 +602,19 @@ int __gmap_link(struct gmap *gmap, unsigned long gaddr, unsigned long vmaddr)
 				       vmaddr >> PMD_SHIFT, table);
 		if (!rc) {
 			if (pmd_large(*pmd)) {
-				*table = pmd_val(*pmd) &
-					_SEGMENT_ENTRY_HARDWARE_BITS_LARGE;
+				*table = (pmd_val(*pmd) &
+					  _SEGMENT_ENTRY_HARDWARE_BITS_LARGE)
+					| _SEGMENT_ENTRY_GMAP_UC;
 			} else
 				*table = pmd_val(*pmd) &
 					_SEGMENT_ENTRY_HARDWARE_BITS;
 		}
+	} else if (*table & _SEGMENT_ENTRY_PROTECT &&
+		   !(pmd_val(*pmd) & _SEGMENT_ENTRY_PROTECT)) {
+		unprot = (u64)*table;
+		unprot &= ~_SEGMENT_ENTRY_PROTECT;
+		unprot |= _SEGMENT_ENTRY_GMAP_UC;
+		gmap_pmdp_xchg(gmap, (pmd_t *)table, __pmd(unprot), gaddr);
 	}
 	spin_unlock(&gmap->guest_table_lock);
 	spin_unlock(ptl);
@@ -930,11 +941,23 @@ static int gmap_protect_pmd(struct gmap *gmap, unsigned long gaddr,
 {
 	int pmd_i = pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID;
 	int pmd_p = pmd_val(*pmdp) & _SEGMENT_ENTRY_PROTECT;
+	pmd_t new = *pmdp;
 
 	/* Fixup needed */
 	if ((pmd_i && (prot != PROT_NONE)) || (pmd_p && (prot == PROT_WRITE)))
 		return -EAGAIN;
 
+	if (prot == PROT_NONE && !pmd_i) {
+		pmd_val(new) |= _SEGMENT_ENTRY_INVALID;
+		gmap_pmdp_xchg(gmap, pmdp, new, gaddr);
+	}
+
+	if (prot == PROT_READ && !pmd_p) {
+		pmd_val(new) &= ~_SEGMENT_ENTRY_INVALID;
+		pmd_val(new) |= _SEGMENT_ENTRY_PROTECT;
+		gmap_pmdp_xchg(gmap, pmdp, new, gaddr);
+	}
+
 	if (bits & GMAP_NOTIFY_MPROT)
 		pmd_val(*pmdp) |= _SEGMENT_ENTRY_GMAP_IN;
 
@@ -2228,6 +2251,32 @@ static void pmdp_notify_gmap(struct gmap *gmap, pmd_t *pmdp,
 	gmap_call_notifier(gmap, gaddr, gaddr + HPAGE_SIZE - 1);
 }
 
+/**
+ * gmap_pmdp_xchg - exchange a gmap pmd with another
+ * @gmap: pointer to the guest address space structure
+ * @pmdp: pointer to the pmd entry
+ * @new: replacement entry
+ * @gaddr: the affected guest address
+ *
+ * This function is assumed to be called with the guest_table_lock
+ * held.
+ */
+static void gmap_pmdp_xchg(struct gmap *gmap, pmd_t *pmdp, pmd_t new,
+			   unsigned long gaddr)
+{
+	gaddr &= HPAGE_MASK;
+	pmdp_notify_gmap(gmap, pmdp, gaddr);
+	pmd_val(new) &= ~_SEGMENT_ENTRY_GMAP_IN;
+	if (MACHINE_HAS_TLB_GUEST)
+		__pmdp_idte(gaddr, (pmd_t *)pmdp, IDTE_GUEST_ASCE, gmap->asce,
+			    IDTE_GLOBAL);
+	else if (MACHINE_HAS_IDTE)
+		__pmdp_idte(gaddr, (pmd_t *)pmdp, 0, 0, IDTE_GLOBAL);
+	else
+		__pmdp_csp(pmdp);
+	*pmdp = new;
+}
+
 static void gmap_pmdp_clear(struct mm_struct *mm, unsigned long vmaddr,
 			    int purge)
 {
@@ -2243,7 +2292,8 @@ static void gmap_pmdp_clear(struct mm_struct *mm, unsigned long vmaddr,
 		if (pmdp) {
 			gaddr = __gmap_segment_gaddr((unsigned long *)pmdp);
 			pmdp_notify_gmap(gmap, pmdp, gaddr);
-			WARN_ON(pmd_val(*pmdp) & ~_SEGMENT_ENTRY_HARDWARE_BITS_LARGE);
+			WARN_ON(pmd_val(*pmdp) & ~(_SEGMENT_ENTRY_HARDWARE_BITS_LARGE |
+						   _SEGMENT_ENTRY_GMAP_UC));
 			if (purge)
 				__pmdp_csp(pmdp);
 			pmd_val(*pmdp) = _SEGMENT_ENTRY_EMPTY;
@@ -2296,7 +2346,8 @@ void gmap_pmdp_idte_local(struct mm_struct *mm, unsigned long vmaddr)
 			pmdp = (pmd_t *)entry;
 			gaddr = __gmap_segment_gaddr(entry);
 			pmdp_notify_gmap(gmap, pmdp, gaddr);
-			WARN_ON(*entry & ~_SEGMENT_ENTRY_HARDWARE_BITS_LARGE);
+			WARN_ON(*entry & ~(_SEGMENT_ENTRY_HARDWARE_BITS_LARGE |
+					   _SEGMENT_ENTRY_GMAP_UC));
 			if (MACHINE_HAS_TLB_GUEST)
 				__pmdp_idte(gaddr, pmdp, IDTE_GUEST_ASCE,
 					    gmap->asce, IDTE_LOCAL);
@@ -2330,7 +2381,8 @@ void gmap_pmdp_idte_global(struct mm_struct *mm, unsigned long vmaddr)
 			pmdp = (pmd_t *)entry;
 			gaddr = __gmap_segment_gaddr(entry);
 			pmdp_notify_gmap(gmap, pmdp, gaddr);
-			WARN_ON(*entry & ~_SEGMENT_ENTRY_HARDWARE_BITS_LARGE);
+			WARN_ON(*entry & ~(_SEGMENT_ENTRY_HARDWARE_BITS_LARGE |
+					   _SEGMENT_ENTRY_GMAP_UC));
 			if (MACHINE_HAS_TLB_GUEST)
 				__pmdp_idte(gaddr, pmdp, IDTE_GUEST_ASCE,
 					    gmap->asce, IDTE_GLOBAL);
@@ -2346,6 +2398,71 @@ void gmap_pmdp_idte_global(struct mm_struct *mm, unsigned long vmaddr)
 }
 EXPORT_SYMBOL_GPL(gmap_pmdp_idte_global);
 
+/**
+ * gmap_test_and_clear_dirty_pmd - test and reset segment dirty status
+ * @gmap: pointer to guest address space
+ * @pmdp: pointer to the pmd to be tested
+ * @gaddr: virtual address in the guest address space
+ *
+ * This function is assumed to be called with the guest_table_lock
+ * held.
+ */
+bool gmap_test_and_clear_dirty_pmd(struct gmap *gmap, pmd_t *pmdp,
+				   unsigned long gaddr)
+{
+	if (pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)
+		return false;
+
+	/* Already protected memory, which did not change is clean */
+	if (pmd_val(*pmdp) & _SEGMENT_ENTRY_PROTECT &&
+	    !(pmd_val(*pmdp) & _SEGMENT_ENTRY_GMAP_UC))
+		return false;
+
+	/* Clear UC indication and reset protection */
+	pmd_val(*pmdp) &= ~_SEGMENT_ENTRY_GMAP_UC;
+	gmap_protect_pmd(gmap, gaddr, pmdp, PROT_READ, 0);
+	return true;
+}
+
+/**
+ * gmap_sync_dirty_log_pmd - set bitmap based on dirty status of segment
+ * @gmap: pointer to guest address space
+ * @bitmap: dirty bitmap for this pmd
+ * @gaddr: virtual address in the guest address space
+ * @vmaddr: virtual address in the host address space
+ *
+ * This function is assumed to be called with the guest_table_lock
+ * held.
+ */
+void gmap_sync_dirty_log_pmd(struct gmap *gmap, unsigned long bitmap[4],
+			     unsigned long gaddr, unsigned long vmaddr)
+{
+	int i;
+	pmd_t *pmdp;
+	pte_t *ptep;
+	spinlock_t *ptl;
+
+	pmdp = gmap_pmd_op_walk(gmap, gaddr);
+	if (!pmdp)
+		return;
+
+	if (pmd_large(*pmdp)) {
+		if (gmap_test_and_clear_dirty_pmd(gmap, pmdp, gaddr))
+			bitmap_fill(bitmap, _PAGE_ENTRIES);
+	} else {
+		for (i = 0; i < _PAGE_ENTRIES; i++, vmaddr += PAGE_SIZE) {
+			ptep = pte_alloc_map_lock(gmap->mm, pmdp, vmaddr, &ptl);
+			if (!ptep)
+				continue;
+			if (ptep_test_and_clear_uc(gmap->mm, vmaddr, ptep))
+				set_bit(i, bitmap);
+			spin_unlock(ptl);
+		}
+	}
+	gmap_pmd_op_end(gmap, pmdp);
+}
+EXPORT_SYMBOL_GPL(gmap_sync_dirty_log_pmd);
+
 static inline void thp_split_mm(struct mm_struct *mm)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index fe84c0715395..684df964e345 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -704,40 +704,14 @@ void ptep_zap_key(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 /*
  * Test and reset if a guest page is dirty
  */
-bool test_and_clear_guest_dirty(struct mm_struct *mm, unsigned long addr)
+bool ptep_test_and_clear_uc(struct mm_struct *mm, unsigned long addr,
+		       pte_t *ptep)
 {
-	spinlock_t *ptl;
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
 	pgste_t pgste;
-	pte_t *ptep;
 	pte_t pte;
 	bool dirty;
 	int nodat;
 
-	pgd = pgd_offset(mm, addr);
-	p4d = p4d_alloc(mm, pgd, addr);
-	if (!p4d)
-		return false;
-	pud = pud_alloc(mm, p4d, addr);
-	if (!pud)
-		return false;
-	pmd = pmd_alloc(mm, pud, addr);
-	if (!pmd)
-		return false;
-	/* We can't run guests backed by huge pages, but userspace can
-	 * still set them up and then try to migrate them without any
-	 * migration support.
-	 */
-	if (pmd_large(*pmd))
-		return true;
-
-	ptep = pte_alloc_map_lock(mm, pmd, addr, &ptl);
-	if (unlikely(!ptep))
-		return false;
-
 	pgste = pgste_get_lock(ptep);
 	dirty = !!(pgste_val(pgste) & PGSTE_UC_BIT);
 	pgste_val(pgste) &= ~PGSTE_UC_BIT;
@@ -753,11 +727,9 @@ bool test_and_clear_guest_dirty(struct mm_struct *mm, unsigned long addr)
 		*ptep = pte;
 	}
 	pgste_set_unlock(ptep, pgste);
-
-	spin_unlock(ptl);
 	return dirty;
 }
-EXPORT_SYMBOL_GPL(test_and_clear_guest_dirty);
+EXPORT_SYMBOL_GPL(ptep_test_and_clear_uc);
 
 int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 			  unsigned char key, bool nq)
-- 
2.17.0
