From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 31 Jul 2018 08:43:59 +0000
Subject: [GIT PULL 13/19] s390/mm: Clear skeys for newly mapped huge guest pmds
Message-Id: <20180731084405.28953-14-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Janosch Frank <frankja@linux.ibm.com>

Similarly to the pte skey handling, where we set the storage key to
the default key for each newly mapped pte, we have to also do that for
huge pmds.

With the PG_arch_1 flag we keep track if the area has already been
cleared of its skeys.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/include/asm/hugetlb.h |  5 ++++-
 arch/s390/mm/gmap.c             |  2 ++
 arch/s390/mm/hugetlbpage.c      | 24 ++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
index 9c5fc50204dd..2d1afa58a4b6 100644
--- a/arch/s390/include/asm/hugetlb.h
+++ b/arch/s390/include/asm/hugetlb.h
@@ -37,7 +37,10 @@ static inline int prepare_hugepage_range(struct file *file,
 	return 0;
 }
 
-#define arch_clear_hugepage_flags(page)		do { } while (0)
+static inline void arch_clear_hugepage_flags(struct page *page)
+{
+	clear_bit(PG_arch_1, &page->flags);
+}
 
 static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 				  pte_t *ptep, unsigned long sz)
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index a8e32e60226b..a6738c0c4499 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2553,6 +2553,7 @@ static int __s390_enable_skey_hugetlb(pte_t *pte, unsigned long addr,
 {
 	pmd_t *pmd = (pmd_t *)pte;
 	unsigned long start, end;
+	struct page *page = pmd_page(*pmd);
 
 	/*
 	 * The write check makes sure we do not set a key on shared
@@ -2567,6 +2568,7 @@ static int __s390_enable_skey_hugetlb(pte_t *pte, unsigned long addr,
 	start = pmd_val(*pmd) & HPAGE_MASK;
 	end = start + HPAGE_SIZE - 1;
 	__storage_key_init_range(start, end);
+	set_bit(PG_arch_1, &page->flags);
 	return 0;
 }
 
diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index e804090f4470..b0246c705a19 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -123,6 +123,29 @@ static inline pte_t __rste_to_pte(unsigned long rste)
 	return pte;
 }
 
+static void clear_huge_pte_skeys(struct mm_struct *mm, unsigned long rste)
+{
+	struct page *page;
+	unsigned long size, paddr;
+
+	if (!mm_uses_skeys(mm) ||
+	    rste & _SEGMENT_ENTRY_INVALID)
+		return;
+
+	if ((rste & _REGION_ENTRY_TYPE_MASK) == _REGION_ENTRY_TYPE_R3) {
+		page = pud_page(__pud(rste));
+		size = PUD_SIZE;
+		paddr = rste & PUD_MASK;
+	} else {
+		page = pmd_page(__pmd(rste));
+		size = PMD_SIZE;
+		paddr = rste & PMD_MASK;
+	}
+
+	if (!test_and_set_bit(PG_arch_1, &page->flags))
+		__storage_key_init_range(paddr, paddr + size - 1);
+}
+
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 		     pte_t *ptep, pte_t pte)
 {
@@ -137,6 +160,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 		rste |= _REGION_ENTRY_TYPE_R3 | _REGION3_ENTRY_LARGE;
 	else
 		rste |= _SEGMENT_ENTRY_LARGE;
+	clear_huge_pte_skeys(mm, rste);
 	pte_val(*ptep) = rste;
 }
 
-- 
2.17.0
