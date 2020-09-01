Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52298 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726116AbgIARkc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 1 Sep 2020 13:40:32 -0400
Date: Tue, 1 Sep 2020 19:40:20 +0200
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: Re: [RFC PATCH 0/2] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200901194020.418da486@thinkpad>
In-Reply-To: <20200831121553.8be5dcdbdbc5256846ac513e@linux-foundation.org>
References: <20200828140314.8556-1-gerald.schaefer@linux.ibm.com>
        <9071c9fa-ba6a-90dc-2d7a-8b155141d890@de.ibm.com>
        <20200831121553.8be5dcdbdbc5256846ac513e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, John Hubbard <jhubbard@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>

On Mon, 31 Aug 2020 12:15:53 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Mon, 31 Aug 2020 13:53:36 +0200 Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
> > 
> > 
> > On 28.08.20 16:03, Gerald Schaefer wrote:
> > have some feedback soon if option 1 or option 2 would be acceptable 
> > from a common code perspective. Andrew, who of the mm people would 
> > be the right one to decide?
> 
> Jason and John Hubbard are doing most of the work in there at present,
> 
> Both patches look OK to me from a non-s390 perspective.  Unless we plan
> to implement Jason's more-general approach this time, I'd be inclined
> to defer to the s390 people as to the preferred implementation.

My gut feeling would say that the gup_pXd_addr_end approach makes
us behave more like other archs, at least for gup_fast, which cannot
be so bad.

Regarding generalization, both approaches would introduce some specific
helpers for this "page table walking w/o lock using READ_ONCE", currently
only used by gup_fast. What we initially had in mind wrt generalization
was replacing e.g. the pXd_addr_end() completely, with the new version that
takes the additional pXd value parameter. That would of course be quite
intrusive, also affecting other arch code, so it is probably not what we
want to do in the first step.

To make it a bit more generic and also usable for future paths in
mm/pagewalk.c for example, we could however at least name the new helpers
differently, e.g. pXd_addr_end_folded instead of gup_pXd_addr_end, and
also add some comment on why / where they should be used, like this
(will send again as proper patch with description if agreed):

---
 arch/s390/include/asm/pgtable.h | 49 +++++++++++++++++++++++++++++++++
 include/linux/pgtable.h         | 32 +++++++++++++++++++++
 mm/gup.c                        |  8 +++---
 3 files changed, 85 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 7eb01a5459cd..d74257f2cb5b 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -512,6 +512,55 @@ static inline bool mm_pmd_folded(struct mm_struct *mm)
 }
 #define mm_pmd_folded(mm) mm_pmd_folded(mm)
 
+static inline unsigned long rste_addr_end_folded(unsigned long rste,
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
+#define pgd_addr_end_folded pgd_addr_end_folded
+static inline unsigned long pgd_addr_end_folded(pgd_t pgd, unsigned long addr,
+						unsigned long end)
+{
+	return rste_addr_end_folded(pgd_val(pgd), addr, end);
+}
+
+#define p4d_addr_end_folded p4d_addr_end_folded
+static inline unsigned long p4d_addr_end_folded(p4d_t p4d, unsigned long addr,
+						unsigned long end)
+{
+	return rste_addr_end_folded(p4d_val(p4d), addr, end);
+}
+
+#define pud_addr_end_folded pud_addr_end_folded
+static inline unsigned long pud_addr_end_folded(pud_t pud, unsigned long addr,
+						unsigned long end)
+{
+	return rste_addr_end_folded(pud_val(pud), addr, end);
+}
+
 static inline int mm_has_pgste(struct mm_struct *mm)
 {
 #ifdef CONFIG_PGSTE
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index e8cbc2e795d5..43dacbce823f 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -681,6 +681,38 @@ static inline int arch_unmap_one(struct mm_struct *mm,
 })
 #endif
 
+/*
+ * With dynamic page table levels on s390, the static pXd_addr_end() functions
+ * will not return corresponding dynamic boundaries. This is no problem as long
+ * as only pXd pointers are passed down during page table walk, because
+ * pXd_offset() will simply return the given pointer for folded levels, and the
+ * pointer iteration over a range simply happens at the correct page table
+ * level.
+ * It is however a problem with gup_fast, or other places walking the page
+ * tables w/o locks using READ_ONCE(), and passing down the pXd values instead
+ * of pointers. In this case, the pointer given to pXd_offset() is a pointer to
+ * a stack variable, which cannot be used for pointer iteration at the correct
+ * level. Instead, the iteration then has to happen by going up to pgd level
+ * again. To allow this, provide pXd_addr_end_folded() functions with an
+ * additional pXd value parameter, which can be used on s390 to determine the
+ * folding level and return the corresponding boundary.
+ */
+#ifndef pgd_addr_end_folded
+#define pgd_addr_end_folded(pgd, addr, end)	pgd_addr_end(addr, end)
+#endif
+
+#ifndef p4d_addr_end_folded
+#define p4d_addr_end_folded(p4d, addr, end)	p4d_addr_end(addr, end)
+#endif
+
+#ifndef pud_addr_end_folded
+#define pud_addr_end_folded(pud, addr, end)	pud_addr_end(addr, end)
+#endif
+
+#ifndef pmd_addr_end_folded
+#define pmd_addr_end_folded(pmd, addr, end)	pmd_addr_end(addr, end)
+#endif
+
 /*
  * When walking page tables, we usually want to skip any p?d_none entries;
  * and any p?d_bad entries - reporting the error before resetting to none.
diff --git a/mm/gup.c b/mm/gup.c
index ae096ea7583f..3157bc5ede24 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2510,7 +2510,7 @@ static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
 	do {
 		pmd_t pmd = READ_ONCE(*pmdp);
 
-		next = pmd_addr_end(addr, end);
+		next = pmd_addr_end_folded(pmd, addr, end);
 		if (!pmd_present(pmd))
 			return 0;
 
@@ -2553,7 +2553,7 @@ static int gup_pud_range(p4d_t p4d, unsigned long addr, unsigned long end,
 	do {
 		pud_t pud = READ_ONCE(*pudp);
 
-		next = pud_addr_end(addr, end);
+		next = pud_addr_end_folded(pud, addr, end);
 		if (unlikely(!pud_present(pud)))
 			return 0;
 		if (unlikely(pud_huge(pud))) {
@@ -2581,7 +2581,7 @@ static int gup_p4d_range(pgd_t pgd, unsigned long addr, unsigned long end,
 	do {
 		p4d_t p4d = READ_ONCE(*p4dp);
 
-		next = p4d_addr_end(addr, end);
+		next = p4d_addr_end_folded(p4d, addr, end);
 		if (p4d_none(p4d))
 			return 0;
 		BUILD_BUG_ON(p4d_huge(p4d));
@@ -2606,7 +2606,7 @@ static void gup_pgd_range(unsigned long addr, unsigned long end,
 	do {
 		pgd_t pgd = READ_ONCE(*pgdp);
 
-		next = pgd_addr_end(addr, end);
+		next = pgd_addr_end_folded(pgd, addr, end);
 		if (pgd_none(pgd))
 			return;
 		if (unlikely(pgd_huge(pgd))) {
