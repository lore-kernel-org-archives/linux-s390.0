From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/1] s390/mm: avoid empty zero pages for KVM guests to avoid postcopy hangs
Date: Mon, 28 Aug 2017 10:28:07 +0200
Message-ID: <1503908887-67060-2-git-send-email-borntraeger@de.ibm.com>
References: <1503908887-67060-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1503908887-67060-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, linux-s390 <linux-s390@vger.kernel.org>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Right now there is a potential hang situation for postcopy migrations,
if the guest is enabling storage keys on the target system during the
postcopy process.

For storage key virtualization, we have to forbid the empty zero page as
the storage key is a property of the physical page frame.  As we enable
storage key handling lazily we then drop all mappings for empty zero
pages for lazy refaulting later on.

This does not work with the postcopy migration, which relies on the
empty zero page never triggering a fault again in the future. The reason
is that postcopy migration will simply read a page on the target system
if that page is a known zero page to fault in an empty zero page.  At
the same time postcopy remembers that this page was already transferred
- so any future userfault on that page will be NOT retransmitted again
to avoid races.

If now the guest enters the storage key mode while in postcopy, we will
break this assumption of postcopy.

The solution is to disable the empty zero page for KVM guests early on
and not during storage key enablement. With this change, the postcopy
migration process is guaranteed to start after no zero pages are left.

As guest pages are very likely not empty zero pages anyway the memory
overhead is also pretty small.

While at it this also adds proper page table locking to the zero page
removal.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: stable@vger.kernel.org
---
 arch/s390/include/asm/pgtable.h |  2 +-
 arch/s390/mm/gmap.c             | 41 ++++++++++++++++++++++++++++++++++-------
 2 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index bb59a0a..9d7f62a 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -506,7 +506,7 @@ static inline int mm_alloc_pgste(struct mm_struct *mm)
  * In the case that a guest uses storage keys
  * faults should no longer be backed by zero pages
  */
-#define mm_forbids_zeropage mm_use_skey
+#define mm_forbids_zeropage mm_has_pgste
 static inline int mm_use_skey(struct mm_struct *mm)
 {
 #ifdef CONFIG_PGSTE
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 4fb3d3c..ae8bd57 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2121,6 +2121,39 @@ static inline void thp_split_mm(struct mm_struct *mm)
 }
 
 /*
+ * Remove all empty zero pages from the mapping for lazy refaulting
+ * - This must be called after mm->context.has_pgste is set, to avoid
+ *   future creation of zero pages
+ * - This must be called after THP was enabled
+ */
+static int __zap_zero_pages(pmd_t *pmd, unsigned long start,
+			   unsigned long end, struct mm_walk *walk)
+{
+	unsigned long addr;
+
+	for (addr = start; addr != end; addr += PAGE_SIZE) {
+		pte_t *ptep;
+		spinlock_t *ptl;
+
+		ptep = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+		if (is_zero_pfn(pte_pfn(*ptep)))
+			ptep_xchg_direct(walk->mm, addr, ptep, __pte(_PAGE_INVALID));
+		pte_unmap_unlock(ptep, ptl);
+	}
+
+	return 0;
+
+}
+
+static inline void zap_zero_pages(struct mm_struct *mm)
+{
+	struct mm_walk walk = { .pmd_entry = __zap_zero_pages };
+
+	walk.mm = mm;
+	walk_page_range(0, TASK_SIZE, &walk);
+}
+
+/*
  * switch on pgstes for its userspace process (for kvm)
  */
 int s390_enable_sie(void)
@@ -2137,6 +2170,7 @@ int s390_enable_sie(void)
 	mm->context.has_pgste = 1;
 	/* split thp mappings and disable thp for future mappings */
 	thp_split_mm(mm);
+	zap_zero_pages(mm);
 	up_write(&mm->mmap_sem);
 	return 0;
 }
@@ -2149,13 +2183,6 @@ EXPORT_SYMBOL_GPL(s390_enable_sie);
 static int __s390_enable_skey(pte_t *pte, unsigned long addr,
 			      unsigned long next, struct mm_walk *walk)
 {
-	/*
-	 * Remove all zero page mappings,
-	 * after establishing a policy to forbid zero page mappings
-	 * following faults for that page will get fresh anonymous pages
-	 */
-	if (is_zero_pfn(pte_pfn(*pte)))
-		ptep_xchg_direct(walk->mm, addr, pte, __pte(_PAGE_INVALID));
 	/* Clear storage key */
 	ptep_zap_key(walk->mm, addr, pte);
 	return 0;
-- 
2.7.4
