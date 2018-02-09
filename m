From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [RFC/PATCH v3 06/16] s390/mm: Add huge page dirty sync support
Date: Fri,  9 Feb 2018 10:34:14 +0100
Message-ID: <1518168864-147803-7-git-send-email-frankja@linux.vnet.ibm.com>
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

To do dirty loging with huge pages, we protect huge pmds in the
gmap. When they are written to, we unprotect them and mark them dirty.

We introduce the function gmap_test_and_clear_dirty_segment which
handles dirty sync for huge pages.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
---
 arch/s390/include/asm/gmap.h    |   4 +
 arch/s390/include/asm/pgtable.h |   6 +-
 arch/s390/kvm/kvm-s390.c        |  18 ++--
 arch/s390/mm/gmap.c             | 209 +++++++++++++++++++++++++++++++++++++++-
 arch/s390/mm/pgtable.c          |  57 +++++++++--
 5 files changed, 278 insertions(+), 16 deletions(-)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index 4324b2a..26a31c3 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -15,6 +15,8 @@
 
 /* Status bits in the gmap segment entry. */
 #define _SEGMENT_ENTRY_GMAP_SPLIT	0x0001  /* split huge pmd */
+/* Status bits only for huge segment entries */
+#define _SEGMENT_ENTRY_GMAP_UC		0x4000	/* user dirty (migration) */
 
 /**
  * struct gmap_struct - guest address space
@@ -151,4 +153,6 @@ void gmap_pte_notify(struct mm_struct *, unsigned long addr, pte_t *,
 int gmap_mprotect_notify(struct gmap *, unsigned long start,
 			 unsigned long len, int prot);
 
+void gmap_sync_dirty_log_pmd(struct gmap *gmap, unsigned long dirty_bitmap[4],
+			     unsigned long gaddr, unsigned long vmaddr);
 #endif /* _ASM_S390_GMAP_H */
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 223791b..e8837a2 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1105,8 +1105,12 @@ void ptep_zap_unused(struct mm_struct *mm, unsigned long addr,
 void ptep_zap_key(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
 int ptep_shadow_pte(struct mm_struct *mm, unsigned long saddr,
 		    pte_t *sptep, pte_t *tptep, pte_t pte);
-void ptep_unshadow_pte(struct mm_struct *mm, unsigned long saddr, pte_t *ptep);
 
+void ptep_unshadow_pte(struct mm_struct *mm, unsigned long saddr, pte_t *ptep);
+void ptep_remove_dirty_protection_split(struct mm_struct *mm, pte_t *ptep,
+					unsigned long vmaddr);
+bool test_and_clear_guest_dirty_split(struct mm_struct *mm, pmd_t *pmdp,
+				      unsigned long vmaddr);
 bool test_and_clear_guest_dirty(struct mm_struct *mm, unsigned long address);
 int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 			  unsigned char key, bool nq);
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 1371dff..0862bf0 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -431,19 +431,23 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 }
 
 static void kvm_s390_sync_dirty_log(struct kvm *kvm,
-					struct kvm_memory_slot *memslot)
+				    struct kvm_memory_slot *memslot)
 {
 	gfn_t cur_gfn, last_gfn;
-	unsigned long address;
+	unsigned long gaddr, vmaddr;
+	unsigned long *dirty = memslot->dirty_bitmap;
 	struct gmap *gmap = kvm->arch.gmap;
 
-	/* Loop over all guest pages */
+	/* Loop over all guest segments */
 	last_gfn = memslot->base_gfn + memslot->npages;
-	for (cur_gfn = memslot->base_gfn; cur_gfn <= last_gfn; cur_gfn++) {
-		address = gfn_to_hva_memslot(memslot, cur_gfn);
+	for (cur_gfn = memslot->base_gfn; cur_gfn <= last_gfn; cur_gfn += _PAGE_ENTRIES, dirty += 4) {
+		gaddr = gfn_to_gpa(cur_gfn);
+		vmaddr = gfn_to_hva_memslot(memslot, cur_gfn);
+		if (kvm_is_error_hva(vmaddr))
+			continue;
+
+		gmap_sync_dirty_log_pmd(gmap, dirty, gaddr, vmaddr);
 
-		if (test_and_clear_guest_dirty(gmap->mm, address))
-			mark_page_dirty(kvm, cur_gfn);
 		if (fatal_signal_pending(current))
 			return;
 		cond_resched();
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 9046c91..4dafa1e 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -15,6 +15,7 @@
 #include <linux/swapops.h>
 #include <linux/ksm.h>
 #include <linux/mman.h>
+#include <linux/hugetlb.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -549,6 +550,8 @@ int __gmap_link(struct gmap *gmap, unsigned long gaddr, unsigned long vmaddr)
 	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
+	pmd_t unprot;
+	pte_t *ptep;
 	int rc;
 
 	BUG_ON(gmap_is_shadow(gmap));
@@ -606,12 +609,29 @@ int __gmap_link(struct gmap *gmap, unsigned long gaddr, unsigned long vmaddr)
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
+		unprot = __pmd((*table & (_SEGMENT_ENTRY_HARDWARE_BITS_LARGE
+					  & ~_SEGMENT_ENTRY_PROTECT))
+			       | _SEGMENT_ENTRY_GMAP_UC);
+		gmap_pmdp_xchg(gmap, (pmd_t *)table, unprot, gaddr);
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
@@ -999,6 +1019,113 @@ static int gmap_pmd_split(struct gmap *gmap, unsigned long gaddr, pmd_t *pmdp)
 	return 0;
 }
 
+/**
+ * gmap_pmdp_force_prot - change access rights of a locked pmd
+ * @mm: pointer to the process mm_struct
+ * @addr: virtual address in the guest address space
+ * @pmdp: pointer to the page table entry
+ * @prot: indicates guest access rights: PROT_NONE, PROT_READ or PROT_WRITE
+ * @bits: software bit to set (e.g. for notification)
+ *
+ * Returns 0 if the access rights were changed and -EAGAIN if the current
+ * and requested access rights are incompatible.
+ */
+static int gmap_pmdp_force_prot(struct gmap *gmap, unsigned long addr,
+				pmd_t *pmdp, int prot)
+{
+	int pmd_i = pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID;
+	int pmd_p = pmd_val(*pmdp) & _SEGMENT_ENTRY_PROTECT;
+	pmd_t new = *pmdp;
+
+	/* Fixup needed */
+	if ((pmd_i && (prot != PROT_NONE)) || (pmd_p && (prot == PROT_WRITE)))
+		return -EAGAIN;
+
+	if (prot == PROT_NONE && !pmd_i) {
+		pmd_val(new) |= _SEGMENT_ENTRY_INVALID;
+		gmap_pmdp_xchg(gmap, pmdp, new, addr);
+	}
+
+	if (prot == PROT_READ && !pmd_p) {
+		pmd_val(new) &= ~_SEGMENT_ENTRY_INVALID;
+		pmd_val(new) |= _SEGMENT_ENTRY_PROTECT;
+		gmap_pmdp_xchg(gmap, pmdp, new, addr);
+	}
+	return 0;
+}
+
+/**
+ * gmap_pmdp_transfer_prot - transfer protection of guest pmd to host pmd
+ * @mm: the memory context
+ * @address: the affected host virtual address
+ * @gpmdp: guest pmd ptr
+ * @hpmdp: host pmd ptr
+ *
+ * Transfers the protection from a guest pmd to the associated guest
+ * pmd. This has to be done with a plain idte to circumvent the gmap
+ * invalidation hooks in the standard invalidation functions provided
+ * by pgtable.c.
+ */
+static void gmap_pmdp_transfer_prot(struct mm_struct *mm, unsigned long addr,
+				    pmd_t *gpmdp, pmd_t *hpmdp)
+{
+	const int gpmd_i = pmd_val(*gpmdp) & _SEGMENT_ENTRY_INVALID;
+	const int gpmd_p = pmd_val(*gpmdp) & _SEGMENT_ENTRY_PROTECT;
+	const int hpmd_i = pmd_val(*hpmdp) & _SEGMENT_ENTRY_INVALID;
+	const int hpmd_p = pmd_val(*hpmdp) & _SEGMENT_ENTRY_PROTECT;
+	pmd_t new = *hpmdp;
+
+	/* Fastpath, change not needed. */
+	if (hpmd_i || (hpmd_p && gpmd_p) || (!gpmd_i && !gpmd_p))
+		return;
+
+	if (gpmd_p && !hpmd_p)
+		pmd_val(new) |= _SEGMENT_ENTRY_PROTECT;
+	if (!gpmd_i && !hpmd_i)
+		pmd_val(new) &= ~_SEGMENT_ENTRY_INVALID;
+
+	if (MACHINE_HAS_TLB_GUEST)
+		__pmdp_idte(addr, hpmdp,
+			    IDTE_NODAT | IDTE_GUEST_ASCE,
+			    mm->context.asce, IDTE_GLOBAL);
+	else if (MACHINE_HAS_IDTE)
+		__pmdp_idte(addr, hpmdp, 0, 0,
+			    IDTE_GLOBAL);
+	else
+		__pmdp_csp(hpmdp);
+	*hpmdp = new;
+}
+
+/*
+ * gmap_protect_pmd - set pmd notification bits
+ * @pmdp: pointer to the pmd to be protected
+ * @prot: indicates access rights: PROT_NONE, PROT_READ or PROT_WRITE
+ * @bits: notification bits to set
+ *
+ * Returns 0 if successfully protected, -ENOMEM if out of memory and
+ * -EAGAIN if a fixup is needed.
+ *
+ * Expected to be called with sg->mm->mmap_sem in read and
+ * guest_table_lock held.
+ */
+static int gmap_protect_pmd(struct gmap *gmap, unsigned long gaddr,
+			    unsigned long vmaddr, pmd_t *pmdp, pmd_t *hpmdp,
+			    int prot)
+{
+	int ret = 0;
+
+	/* Protect gmap pmd for dirty tracking. */
+	ret = gmap_pmdp_force_prot(gmap, gaddr, pmdp, prot);
+	/*
+	 * Transfer protection back to the host pmd, so userspace has
+	 * never more access rights than the VM.
+	 */
+	if (!ret)
+		gmap_pmdp_transfer_prot(gmap->mm, vmaddr, pmdp, hpmdp);
+	return ret;
+}
+
+
 /*
  * gmap_protect_pte - remove access rights to memory and set pgste bits
  * @gmap: pointer to guest mapping meta data structure
@@ -2488,6 +2615,84 @@ void gmap_pmdp_idte_global(struct mm_struct *mm, unsigned long vmaddr)
 }
 EXPORT_SYMBOL_GPL(gmap_pmdp_idte_global);
 
+/**
+ * gmap_test_and_clear_dirty_segment - test and reset segment dirty status
+ * @gmap: pointer to guest address space
+ * @pmdp: pointer to the pmd to be tested
+ * @gaddr: virtual address in the guest address space
+ *
+ * This function is assumed to be called with the guest_table_lock
+ * held.
+ */
+bool gmap_test_and_clear_dirty_segment(struct gmap *gmap, pmd_t *pmdp,
+				       pmd_t *hpmdp, unsigned long gaddr,
+				       unsigned long vmaddr)
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
+	gmap_protect_pmd(gmap, gaddr, vmaddr, pmdp, hpmdp, PROT_READ);
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
+	int i = 0;
+	pmd_t *pmdp, *hpmdp;
+	spinlock_t *ptl;
+
+	hpmdp = (pmd_t *)huge_pte_offset(gmap->mm, vmaddr, HPAGE_SIZE);
+	if (!hpmdp)
+		return;
+	ptl = pmd_lock(gmap->mm, hpmdp);
+	pmdp = gmap_pmd_op_walk(gmap, gaddr);
+	if (!pmdp) {
+		spin_unlock(ptl);
+		return;
+	}
+
+	if (pmd_large(*pmdp)) {
+		if (gmap_test_and_clear_dirty_segment(gmap, pmdp, hpmdp,
+						      gaddr, vmaddr))
+			memset(bitmap, 0xff, 32);
+	} else {
+		/* We handle this here, as it's of the records from mm. */
+		if (unlikely(gmap_pmd_is_split(pmdp))) {
+			for (; i < _PAGE_ENTRIES; i++, vmaddr += PAGE_SIZE) {
+				if (test_and_clear_guest_dirty_split(gmap->mm, pmdp, vmaddr))
+					set_bit_le(i, bitmap);
+				//TODO: protection transfer
+			}
+		} else {
+			for (; i < _PAGE_ENTRIES; i++, vmaddr += PAGE_SIZE) {
+				if (test_and_clear_guest_dirty(gmap->mm, vmaddr))
+					set_bit_le(i, bitmap);
+			}
+		}
+	}
+	gmap_pmd_op_end(gmap, pmdp);
+	spin_unlock(ptl);
+}
+EXPORT_SYMBOL_GPL(gmap_sync_dirty_log_pmd);
+
 static inline void thp_split_mm(struct mm_struct *mm)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index e690879..497fefe 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -705,6 +705,57 @@ void ptep_zap_key(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 	preempt_enable();
 }
 
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
 /*
  * Test and reset if a guest page is dirty
  */
@@ -731,12 +782,6 @@ bool test_and_clear_guest_dirty(struct mm_struct *mm, unsigned long addr)
 	pmd = pmd_alloc(mm, pud, addr);
 	if (!pmd)
 		return false;
-	/* We can't run guests backed by huge pages, but userspace can
-	 * still set them up and then try to migrate them without any
-	 * migration support.
-	 */
-	if (pmd_large(*pmd))
-		return true;
 
 	ptep = pte_alloc_map_lock(mm, pmd, addr, &ptl);
 	if (unlikely(!ptep))
-- 
2.7.4
