From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [RFC/PATCH 08/22] s390/mm: Add huge page dirty sync support
Date: Mon,  6 Nov 2017 23:29:46 +0100
Message-ID: <1510007400-42493-9-git-send-email-frankja@linux.vnet.ibm.com>
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
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
Reviewed-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/include/asm/gmap.h |  6 +++-
 arch/s390/kvm/kvm-s390.c     | 18 ++++++----
 arch/s390/mm/gmap.c          | 85 +++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 96 insertions(+), 13 deletions(-)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index 99cf6d8..16474c3 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -12,8 +12,10 @@
 #define GMAP_ENTRY_VSIE	0x2
 #define GMAP_ENTRY_IN	0x1
 
-/* Status bits in the gmap segment entry. */
+/* Status bits in huge and non-huge gmap segment entries. */
 #define _SEGMENT_ENTRY_GMAP_IN		0x0001	/* invalidation notify bit */
+/* Status bits only for huge segment entries */
+#define _SEGMENT_ENTRY_GMAP_UC		0x4000	/* user dirty (migration) */
 
 /**
  * struct gmap_struct - guest address space
@@ -138,4 +140,6 @@ void gmap_pte_notify(struct mm_struct *, unsigned long addr, pte_t *,
 int gmap_mprotect_notify(struct gmap *, unsigned long start,
 			 unsigned long len, int prot);
 
+void gmap_sync_dirty_log_pmd(struct gmap *gmap, unsigned long dirty_bitmap[4],
+			     unsigned long gaddr, unsigned long vmaddr);
 #endif /* _ASM_S390_GMAP_H */
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 40d0a1a..62d8bd1 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -430,19 +430,23 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
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
index 3054b413..bebf83f 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -544,6 +544,7 @@ int __gmap_link(struct gmap *gmap, unsigned long gaddr, unsigned long vmaddr)
 	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
+	pmd_t unprot;
 	int rc;
 
 	BUG_ON(gmap_is_shadow(gmap));
@@ -601,14 +602,20 @@ int __gmap_link(struct gmap *gmap, unsigned long gaddr, unsigned long vmaddr)
 				       vmaddr >> PMD_SHIFT, table);
 		if (!rc) {
 			if (pmd_large(*pmd)) {
-				*table = pmd_val(*pmd) &
-					(_SEGMENT_ENTRY_ORIGIN_LARGE
-					 | _SEGMENT_ENTRY_INVALID
-					 | _SEGMENT_ENTRY_LARGE
-					 | _SEGMENT_ENTRY_PROTECT);
+				*table = (pmd_val(*pmd) &
+					  (_SEGMENT_ENTRY_ORIGIN_LARGE
+					   | _SEGMENT_ENTRY_INVALID
+					   | _SEGMENT_ENTRY_LARGE
+					   | _SEGMENT_ENTRY_PROTECT))
+					| _SEGMENT_ENTRY_GMAP_UC;
 			} else
 				*table = pmd_val(*pmd) & ~0x03UL;
 		}
+	} else if (*table & _SEGMENT_ENTRY_PROTECT &&
+		   !(pmd_val(*pmd) & _SEGMENT_ENTRY_PROTECT)) {
+		unprot = __pmd((*table & ~_SEGMENT_ENTRY_PROTECT)
+			       | _SEGMENT_ENTRY_GMAP_UC);
+		gmap_pmdp_xchg(gmap, (pmd_t *)table, unprot, gaddr);
 	}
 	spin_unlock(&gmap->guest_table_lock);
 	spin_unlock(ptl);
@@ -2525,6 +2532,74 @@ static void gmap_pmdp_xchg(struct gmap *gmap, pmd_t *pmdp, pmd_t new,
 	*pmdp = new;
 }
 
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
+	gmap_protect_large(gmap, gaddr, vmaddr, pmdp, hpmdp, PROT_READ, 0);
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
+			memset(bitmap, 0xFF, 32);
+	} else {
+		for (; i < _PAGE_ENTRIES; i++, vmaddr += PAGE_SIZE) {
+			if (test_and_clear_guest_dirty(gmap->mm, vmaddr))
+				set_bit_le(i, bitmap);
+		}
+	}
+	gmap_pmd_op_end(gmap, pmdp);
+	spin_unlock(ptl);
+}
+
 static inline void thp_split_mm(struct mm_struct *mm)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-- 
2.7.4
