Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62528 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726236AbgH1OEB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 28 Aug 2020 10:04:01 -0400
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: [RFC PATCH 1/2] mm/gup: fix gup_fast with dynamic page table folding
Date: Fri, 28 Aug 2020 16:03:13 +0200
Message-Id: <20200828140314.8556-2-gerald.schaefer@linux.ibm.com>
In-Reply-To: <20200828140314.8556-1-gerald.schaefer@linux.ibm.com>
References: <20200828140314.8556-1-gerald.schaefer@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Vasily Gorbik <gor@linux.ibm.com>

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

Fix this with an approach that has already been discussed in
https://lkml.kernel.org/r/20190418100218.0a4afd51@mschwideX1
It will additionally pass along pXd pointers in gup_pXd_range, and
also introduce pXd_offset_orig for s390, which takes an additional
pXd entry value parameter. This allows returning correct pointers
while still preseving the READ_ONCE logic for gup_fast. No change
for other architectures introduced.

Cc: <stable@vger.kernel.org> # 5.2+
Fixes: 1a42010cdc26 ("s390/mm: convert to the generic get_user_pages_fast code")
Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 arch/s390/include/asm/pgtable.h | 42 +++++++++++++++++++++++----------
 include/linux/pgtable.h         | 10 ++++++++
 mm/gup.c                        | 18 +++++++-------
 3 files changed, 49 insertions(+), 21 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 7eb01a5459cd..69a92e39d7b8 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1260,26 +1260,44 @@ static inline pgd_t *pgd_offset_raw(pgd_t *pgd, unsigned long address)
 
 #define pgd_offset(mm, address) pgd_offset_raw(READ_ONCE((mm)->pgd), address)
 
-static inline p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
+static inline p4d_t *p4d_offset_orig(pgd_t *pgdp, pgd_t pgd, unsigned long address)
 {
-	if ((pgd_val(*pgd) & _REGION_ENTRY_TYPE_MASK) >= _REGION_ENTRY_TYPE_R1)
-		return (p4d_t *) pgd_deref(*pgd) + p4d_index(address);
-	return (p4d_t *) pgd;
+	if ((pgd_val(pgd) & _REGION_ENTRY_TYPE_MASK) >= _REGION_ENTRY_TYPE_R1)
+		return (p4d_t *) pgd_deref(pgd) + p4d_index(address);
+	return (p4d_t *) pgdp;
 }
+#define p4d_offset_orig p4d_offset_orig
 
-static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
+static inline p4d_t *p4d_offset(pgd_t *pgdp, unsigned long address)
 {
-	if ((p4d_val(*p4d) & _REGION_ENTRY_TYPE_MASK) >= _REGION_ENTRY_TYPE_R2)
-		return (pud_t *) p4d_deref(*p4d) + pud_index(address);
-	return (pud_t *) p4d;
+	return p4d_offset_orig(pgdp, *pgdp, address);
+}
+
+static inline pud_t *pud_offset_orig(p4d_t *p4dp, p4d_t p4d, unsigned long address)
+{
+	if ((p4d_val(p4d) & _REGION_ENTRY_TYPE_MASK) >= _REGION_ENTRY_TYPE_R2)
+		return (pud_t *) p4d_deref(p4d) + pud_index(address);
+	return (pud_t *) p4dp;
+}
+#define pud_offset_orig pud_offset_orig
+
+static inline pud_t *pud_offset(p4d_t *p4dp, unsigned long address)
+{
+	return pud_offset_orig(p4dp, *p4dp, address);
 }
 #define pud_offset pud_offset
 
-static inline pmd_t *pmd_offset(pud_t *pud, unsigned long address)
+static inline pmd_t *pmd_offset_orig(pud_t *pudp, pud_t pud, unsigned long address)
+{
+	if ((pud_val(pud) & _REGION_ENTRY_TYPE_MASK) >= _REGION_ENTRY_TYPE_R3)
+		return (pmd_t *) pud_deref(pud) + pmd_index(address);
+	return (pmd_t *) pudp;
+}
+#define pmd_offset_orig pmd_offset_orig
+
+static inline pmd_t *pmd_offset(pud_t *pudp, unsigned long address)
 {
-	if ((pud_val(*pud) & _REGION_ENTRY_TYPE_MASK) >= _REGION_ENTRY_TYPE_R3)
-		return (pmd_t *) pud_deref(*pud) + pmd_index(address);
-	return (pmd_t *) pud;
+	return pmd_offset_orig(pudp, *pudp, address);
 }
 #define pmd_offset pmd_offset
 
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index a124c21e3204..02f93358126e 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1425,6 +1425,16 @@ typedef unsigned int pgtbl_mod_mask;
 #define mm_pmd_folded(mm)	__is_defined(__PAGETABLE_PMD_FOLDED)
 #endif
 
+#ifndef p4d_offset_orig
+#define p4d_offset_orig(pgdp, pgd, address) p4d_offset(&pgd, address)
+#endif
+#ifndef pud_offset_orig
+#define pud_offset_orig(p4dp, p4d, address) pud_offset(&p4d, address)
+#endif
+#ifndef pmd_offset_orig
+#define pmd_offset_orig(pudp, pud, address) pmd_offset(&pud, address)
+#endif
+
 /*
  * p?d_leaf() - true if this entry is a final mapping to a physical address.
  * This differs from p?d_huge() by the fact that they are always available (if
diff --git a/mm/gup.c b/mm/gup.c
index ae096ea7583f..fbdd9f0bf219 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2500,13 +2500,13 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
 	return 1;
 }
 
-static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
+static int gup_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr, unsigned long end,
 		unsigned int flags, struct page **pages, int *nr)
 {
 	unsigned long next;
 	pmd_t *pmdp;
 
-	pmdp = pmd_offset(&pud, addr);
+	pmdp = pmd_offset_orig(pudp, pud, addr);
 	do {
 		pmd_t pmd = READ_ONCE(*pmdp);
 
@@ -2543,13 +2543,13 @@ static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
 	return 1;
 }
 
-static int gup_pud_range(p4d_t p4d, unsigned long addr, unsigned long end,
+static int gup_pud_range(p4d_t *p4dp, p4d_t p4d, unsigned long addr, unsigned long end,
 			 unsigned int flags, struct page **pages, int *nr)
 {
 	unsigned long next;
 	pud_t *pudp;
 
-	pudp = pud_offset(&p4d, addr);
+	pudp = pud_offset_orig(p4dp, p4d, addr);
 	do {
 		pud_t pud = READ_ONCE(*pudp);
 
@@ -2564,20 +2564,20 @@ static int gup_pud_range(p4d_t p4d, unsigned long addr, unsigned long end,
 			if (!gup_huge_pd(__hugepd(pud_val(pud)), addr,
 					 PUD_SHIFT, next, flags, pages, nr))
 				return 0;
-		} else if (!gup_pmd_range(pud, addr, next, flags, pages, nr))
+		} else if (!gup_pmd_range(pudp, pud, addr, next, flags, pages, nr))
 			return 0;
 	} while (pudp++, addr = next, addr != end);
 
 	return 1;
 }
 
-static int gup_p4d_range(pgd_t pgd, unsigned long addr, unsigned long end,
+static int gup_p4d_range(pgd_t *pgdp, pgd_t pgd, unsigned long addr, unsigned long end,
 			 unsigned int flags, struct page **pages, int *nr)
 {
 	unsigned long next;
 	p4d_t *p4dp;
 
-	p4dp = p4d_offset(&pgd, addr);
+	p4dp = p4d_offset_orig(pgdp, pgd, addr);
 	do {
 		p4d_t p4d = READ_ONCE(*p4dp);
 
@@ -2589,7 +2589,7 @@ static int gup_p4d_range(pgd_t pgd, unsigned long addr, unsigned long end,
 			if (!gup_huge_pd(__hugepd(p4d_val(p4d)), addr,
 					 P4D_SHIFT, next, flags, pages, nr))
 				return 0;
-		} else if (!gup_pud_range(p4d, addr, next, flags, pages, nr))
+		} else if (!gup_pud_range(p4dp, p4d, addr, next, flags, pages, nr))
 			return 0;
 	} while (p4dp++, addr = next, addr != end);
 
@@ -2617,7 +2617,7 @@ static void gup_pgd_range(unsigned long addr, unsigned long end,
 			if (!gup_huge_pd(__hugepd(pgd_val(pgd)), addr,
 					 PGDIR_SHIFT, next, flags, pages, nr))
 				return;
-		} else if (!gup_p4d_range(pgd, addr, next, flags, pages, nr))
+		} else if (!gup_p4d_range(pgdp, pgd, addr, next, flags, pages, nr))
 			return;
 	} while (pgdp++, addr = next, addr != end);
 }
-- 
2.17.1
