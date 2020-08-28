Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26586 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726101AbgH1OD6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 28 Aug 2020 10:03:58 -0400
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: [RFC PATCH 2/2] mm/gup: fix gup_fast with dynamic page table folding
Date: Fri, 28 Aug 2020 16:03:14 +0200
Message-Id: <20200828140314.8556-3-gerald.schaefer@linux.ibm.com>
In-Reply-To: <20200828140314.8556-1-gerald.schaefer@linux.ibm.com>
References: <20200828140314.8556-1-gerald.schaefer@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Alexander Gordeev <agordeev@linux.ibm.com>

Commit 1a42010cdc26 ("s390/mm: convert to the generic get_user_pages_fast
code") introduced a subtle but severe bug on s390 with gup_fast, due to
dynamic page table folding.

The question "What would it require for the generic code to work for s390"
has already been discussed here
https://lkml.kernel.org/r/20190418100218.0a4afd51@mschwideX1
and ended with a promising approach here
https://lkml.kernel.org/r/20190419153307.4f2911b5@mschwideX1
which in the end unfortunately didn't quite work completely.

We tried to mimic static level folding by changing pgd_offset to always
calculate top level page table offset, and do nothing in folded pXd_offset.
What has been overlooked is that PxD_SIZE/MASK and thus pXd_addr_end do
not reflect this dynamic behaviour, and still act like static 5-level
page tables.

Here is an example of what happens with gup_fast on s390, for a task with
3-levels paging, crossing a 2 GB pud boundary:

// addr = 0x1007ffff000, end = 0x10080001000
static int gup_pud_range(p4d_t p4d, unsigned long addr, unsigned long end,
                         unsigned int flags, struct page **pages, int *nr)
{
        unsigned long next;
        pud_t *pudp;

        // pud_offset returns &p4d itself (a pointer to a value on stack)
        pudp = pud_offset(&p4d, addr);
        do {
                // on second iteratation reading "random" stack value
                pud_t pud = READ_ONCE(*pudp);

                // next = 0x10080000000, due to PUD_SIZE/MASK != PGDIR_SIZE/MASK on s390
                next = pud_addr_end(addr, end);
                ...
        } while (pudp++, addr = next, addr != end); // pudp++ iterating over stack

        return 1;
}

pud_addr_end = 0x10080000000 is correct, but the previous pgd/p4d_addr_end
should also have returned that limit, instead of the 5-level static
pgd/p4d limits with PUD_SIZE/MASK != PGDIR_SIZE/MASK. Then the "end"
parameter for gup_pud_range would also have been 0x10080000000, and we
would not iterate further in gup_pud_range, but rather go back and
(correctly) do it in gup_pgd_range.

So, for the second iteration in gup_pud_range, we will increase pudp,
which pointed to a stack value and not the real pud table. This new pudp
will then point to whatever lies behind the p4d stack value. In general,
this happens to be the previously read pgd, but it probably could also
be something different, depending on compiler decisions.

Most unfortunately, if it happens to be the pgd value, which is the
same as the p4d / pud due to folding, it is a valid and present entry.
So after the increment, we would still point to the same pud entry.
The addr however has been increased in the second iteration, so that we
now have different pmd/pte_index values, which will result in very wrong
behaviour for the remaining gup_pmd/pte_range calls. We will effectively
operate on an address minus 2 GB, due to missing pudp increase.

In the "good case", if nothing is mapped there, we will fall back to
the slow gup path. But if something is mapped there, and valid
for gup_fast, we will end up (silently) getting references on the wrong
pages and also add the wrong pages to the **pages result array. This
can cause data corruption.

Fix this by introducing new gup_pXd_addr_end helpers, which take an
additional pXd entry value parameter, that can be used on s390
to determine the correct page table level and return corresponding
end / boundary. With that, the pointer iteration will always
happen in gup_pgd_range for s390. No change for other architectures
introduced.

Cc: <stable@vger.kernel.org> # 5.2+
Fixes: 1a42010cdc26 ("s390/mm: convert to the generic get_user_pages_fast code")
Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390/include/asm/pgtable.h | 49 +++++++++++++++++++++++++++++++++
 include/linux/pgtable.h         | 16 +++++++++++
 mm/gup.c                        |  8 +++---
 3 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 7eb01a5459cd..1b8f461f5783 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -512,6 +512,55 @@ static inline bool mm_pmd_folded(struct mm_struct *mm)
 }
 #define mm_pmd_folded(mm) mm_pmd_folded(mm)
 
+static inline unsigned long gup_folded_addr_end(unsigned long rste,
+						unsigned long addr, unsigned long end)
+{
+	unsigned int type = rste & _REGION_ENTRY_TYPE_MASK;
+	unsigned long size, mask, boundary;
+
+	switch (type) {
+	case _REGION_ENTRY_TYPE_R1:
+		size = PGDIR_SIZE;
+		mask = PGDIR_MASK;
+		break;
+	case _REGION_ENTRY_TYPE_R2:
+		size = P4D_SIZE;
+		mask = P4D_MASK;
+		break;
+	case _REGION_ENTRY_TYPE_R3:
+		size = PUD_SIZE;
+		mask = PUD_MASK;
+		break;
+	default:
+		BUG();
+	};
+
+	boundary = (addr + size) & mask;
+
+	return (boundary - 1) < (end - 1) ? boundary : end;
+}
+
+#define gup_pgd_addr_end gup_pgd_addr_end
+static inline unsigned long gup_pgd_addr_end(pgd_t pgd,
+					     unsigned long addr, unsigned long end)
+{
+	return gup_folded_addr_end(pgd_val(pgd), addr, end);
+}
+
+#define gup_p4d_addr_end gup_p4d_addr_end
+static inline unsigned long gup_p4d_addr_end(p4d_t p4d,
+					     unsigned long addr, unsigned long end)
+{
+	return gup_folded_addr_end(p4d_val(p4d), addr, end);
+}
+
+#define gup_pud_addr_end gup_pud_addr_end
+static inline unsigned long gup_pud_addr_end(pud_t pud,
+					     unsigned long addr, unsigned long end)
+{
+	return gup_folded_addr_end(pud_val(pud), addr, end);
+}
+
 static inline int mm_has_pgste(struct mm_struct *mm)
 {
 #ifdef CONFIG_PGSTE
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index e8cbc2e795d5..620a83c774c7 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -681,6 +681,22 @@ static inline int arch_unmap_one(struct mm_struct *mm,
 })
 #endif
 
+#ifndef gup_pgd_addr_end
+#define gup_pgd_addr_end(pgd, addr, end)	pgd_addr_end(addr, end)
+#endif
+
+#ifndef gup_p4d_addr_end
+#define gup_p4d_addr_end(p4d, addr, end)	p4d_addr_end(addr, end)
+#endif
+
+#ifndef gup_pud_addr_end
+#define gup_pud_addr_end(pud, addr, end)	pud_addr_end(addr, end)
+#endif
+
+#ifndef gup_pmd_addr_end
+#define gup_pmd_addr_end(pmd, addr, end)	pmd_addr_end(addr, end)
+#endif
+
 /*
  * When walking page tables, we usually want to skip any p?d_none entries;
  * and any p?d_bad entries - reporting the error before resetting to none.
diff --git a/mm/gup.c b/mm/gup.c
index ae096ea7583f..149ef3d71457 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2510,7 +2510,7 @@ static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
 	do {
 		pmd_t pmd = READ_ONCE(*pmdp);
 
-		next = pmd_addr_end(addr, end);
+		next = gup_pmd_addr_end(pmd, addr, end);
 		if (!pmd_present(pmd))
 			return 0;
 
@@ -2553,7 +2553,7 @@ static int gup_pud_range(p4d_t p4d, unsigned long addr, unsigned long end,
 	do {
 		pud_t pud = READ_ONCE(*pudp);
 
-		next = pud_addr_end(addr, end);
+		next = gup_pud_addr_end(pud, addr, end);
 		if (unlikely(!pud_present(pud)))
 			return 0;
 		if (unlikely(pud_huge(pud))) {
@@ -2581,7 +2581,7 @@ static int gup_p4d_range(pgd_t pgd, unsigned long addr, unsigned long end,
 	do {
 		p4d_t p4d = READ_ONCE(*p4dp);
 
-		next = p4d_addr_end(addr, end);
+		next = gup_p4d_addr_end(p4d, addr, end);
 		if (p4d_none(p4d))
 			return 0;
 		BUILD_BUG_ON(p4d_huge(p4d));
@@ -2606,7 +2606,7 @@ static void gup_pgd_range(unsigned long addr, unsigned long end,
 	do {
 		pgd_t pgd = READ_ONCE(*pgdp);
 
-		next = pgd_addr_end(addr, end);
+		next = gup_pgd_addr_end(pgd, addr, end);
 		if (pgd_none(pgd))
 			return;
 		if (unlikely(pgd_huge(pgd))) {
-- 
2.17.1
