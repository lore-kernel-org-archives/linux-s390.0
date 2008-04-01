Return-Path: <linux-kernel-owner+w=401wt.eu-S1758656AbYDAOIX@vger.kernel.org>
Subject: [PATCH 2/3] hugetlbfs: cleanup and new primitives for s390
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
In-Reply-To: <1207058485.5063.36.camel@localhost.localdomain>
References: <1207058485.5063.36.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 01 Apr 2008 16:08:11 +0200
Message-Id: <1207058891.5063.41.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, Ingo Molnar <mingo@elte.hu>, "David S. Miller" <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Paul Mundt <lethal@linux-sh.org>
List-ID: <linux-s390.vger.kernel.org>

[PATCH 2/3] hugetlbfs: cleanup and new primitives for s390

A cow break on a hugetlbfs page with page_count > 1 will set a new pte
with set_huge_pte_at(), w/o any tlb flush operation. The old pte will
remain in the tlb and subsequent write access to the page will result
in a page fault loop, for as long as it may take until the tlb is
flushed from somewhere else.
This patch introduces an architecture-specific huge_ptep_clear_flush()
function, which is called before the the set_huge_pte_at() in
hugetlb_cow().

NOTE: This is just a nop on all architectures for now, there will be an
s390 implementation with our large page patch later. Other architectures
should define their own huge_ptep_clear_flush() if needed.

Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-ia64/hugetlb.h    |    2 ++
 include/asm-powerpc/hugetlb.h |    2 ++
 include/asm-sh/hugetlb.h      |    2 ++
 include/asm-sparc64/hugetlb.h |    2 ++
 include/asm-x86/hugetlb.h     |    2 ++
 mm/hugetlb.c                  |    1 +
 6 files changed, 11 insertions(+)

Index: linux-2.6.25-rc7/mm/hugetlb.c
===================================================================
--- linux-2.6.25-rc7.orig/mm/hugetlb.c
+++ linux-2.6.25-rc7/mm/hugetlb.c
@@ -864,6 +864,7 @@ static int hugetlb_cow(struct mm_struct 
 	ptep = huge_pte_offset(mm, address & HPAGE_MASK);
 	if (likely(pte_same(*ptep, pte))) {
 		/* Break COW */
+		huge_ptep_clear_flush(vma, address, ptep);
 		set_huge_pte_at(mm, address, ptep,
 				make_huge_pte(vma, new_page, 1));
 		/* Make the old page be freed below */
Index: linux-2.6.25-rc7/include/asm-ia64/hugetlb.h
===================================================================
--- linux-2.6.25-rc7.orig/include/asm-ia64/hugetlb.h
+++ linux-2.6.25-rc7/include/asm-ia64/hugetlb.h
@@ -18,4 +18,6 @@ int prepare_hugepage_range(unsigned long
 
 #define hugetlb_prefault_arch_hook(mm)		do { } while (0)
 
+#define huge_ptep_clear_flush(vma, addr, ptep)	do { } while (0)
+
 #endif /* _ASM_IA64_HUGETLB_H */
Index: linux-2.6.25-rc7/include/asm-powerpc/hugetlb.h
===================================================================
--- linux-2.6.25-rc7.orig/include/asm-powerpc/hugetlb.h
+++ linux-2.6.25-rc7/include/asm-powerpc/hugetlb.h
@@ -32,4 +32,6 @@ pte_t huge_ptep_get_and_clear(struct mm_
 
 #define hugetlb_prefault_arch_hook(mm)		do { } while (0)
 
+#define huge_ptep_clear_flush(vma, addr, ptep)	do { } while (0)
+
 #endif /* _ASM_POWERPC_HUGETLB_H */
Index: linux-2.6.25-rc7/include/asm-sh/hugetlb.h
===================================================================
--- linux-2.6.25-rc7.orig/include/asm-sh/hugetlb.h
+++ linux-2.6.25-rc7/include/asm-sh/hugetlb.h
@@ -25,4 +25,6 @@ static inline int prepare_hugepage_range
 
 #define hugetlb_prefault_arch_hook(mm)		do { } while (0)
 
+#define huge_ptep_clear_flush(vma, addr, ptep)	do { } while (0)
+
 #endif /* _ASM_SH_HUGETLB_H */
Index: linux-2.6.25-rc7/include/asm-sparc64/hugetlb.h
===================================================================
--- linux-2.6.25-rc7.orig/include/asm-sparc64/hugetlb.h
+++ linux-2.6.25-rc7/include/asm-sparc64/hugetlb.h
@@ -27,4 +27,6 @@ pte_t huge_ptep_get_and_clear(struct mm_
 
 void hugetlb_prefault_arch_hook(struct mm_struct *mm);
 
+#define huge_ptep_clear_flush(vma, addr, ptep)	do { } while (0)
+
 #endif /* _ASM_SPARC64_HUGETLB_H */
Index: linux-2.6.25-rc7/include/asm-x86/hugetlb.h
===================================================================
--- linux-2.6.25-rc7.orig/include/asm-x86/hugetlb.h
+++ linux-2.6.25-rc7/include/asm-x86/hugetlb.h
@@ -25,4 +25,6 @@ static inline int prepare_hugepage_range
 
 #define hugetlb_prefault_arch_hook(mm)		do { } while (0)
 
+#define huge_ptep_clear_flush(vma, addr, ptep)	do { } while (0)
+
 #endif /* _ASM_X86_HUGETLB_H */
