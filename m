Return-Path: <linux-kernel-owner+w=401wt.eu-S1754606AbYCLRfB@vger.kernel.org>
Message-Id: <20080312173217.941471391@de.ibm.com>
References: <20080312173155.703966894@de.ibm.com>
Date: Wed, 12 Mar 2008 18:32:03 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 08/10] Add missing TLB flush to hugetlb_cow().
Content-Disposition: inline; filename=108-hugetlb-tlbflush.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Andi Kleen <ak@suse.de>, "David S. Miller" <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>, Gerald Schaefer <geraldsc@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Gerald Schaefer <geraldsc@de.ibm.com>

A cow break on a hugetlbfs page with page_count > 1 will set a new pte
with set_huge_pte_at(), w/o any tlb flush operation. The old pte will
remain in the tlb and subsequent write access to the page will result
in a page fault loop, for as long as it may take until the tlb is
flushed from somewhere else.
This patch introduces an architecture-specific huge_ptep_clear_flush()
function, which is called before the the set_huge_pte_at() in
hugetlb_cow().

Cc: Andi Kleen <ak@suse.de>
Cc: David S. Miller <davem@davemloft.net>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Signed-off-by: Gerald Schaefer <geraldsc@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/linux/hugetlb.h |    4 ++++
 mm/hugetlb.c            |    1 +
 2 files changed, 5 insertions(+)

Index: quilt-2.6/include/linux/hugetlb.h
===================================================================
--- quilt-2.6.orig/include/linux/hugetlb.h
+++ quilt-2.6/include/linux/hugetlb.h
@@ -80,6 +80,10 @@ static inline int prepare_hugepage_range
 int prepare_hugepage_range(unsigned long addr, unsigned long len);
 #endif
 
+#ifndef ARCH_HAS_HUGEPAGE_CLEAR_FLUSH
+#define huge_ptep_clear_flush(vma, addr, ptep)	do { } while (0)
+#endif
+
 #ifndef ARCH_HAS_SETCLEAR_HUGE_PTE
 #define set_huge_pte_at(mm, addr, ptep, pte)	set_pte_at(mm, addr, ptep, pte)
 #define huge_ptep_get_and_clear(mm, addr, ptep) ptep_get_and_clear(mm, addr, ptep)
Index: quilt-2.6/mm/hugetlb.c
===================================================================
--- quilt-2.6.orig/mm/hugetlb.c
+++ quilt-2.6/mm/hugetlb.c
@@ -864,6 +864,7 @@ static int hugetlb_cow(struct mm_struct 
 	ptep = huge_pte_offset(mm, address & HPAGE_MASK);
 	if (likely(pte_same(*ptep, pte))) {
 		/* Break COW */
+		huge_ptep_clear_flush(vma, address, ptep);
 		set_huge_pte_at(mm, address, ptep,
 				make_huge_pte(vma, new_page, 1));
 		/* Make the old page be freed below */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
