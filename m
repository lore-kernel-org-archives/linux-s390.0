Return-Path: <linux-kernel-owner+w=401wt.eu-S1757889AbYDDQuE@vger.kernel.org>
Subject: [PATCH 1/3] hugetlbfs: architecture header cleanup
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
In-Reply-To: <1207327534.4605.18.camel@localhost.localdomain>
References: <1207327534.4605.18.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 04 Apr 2008 18:49:50 +0200
Message-Id: <1207327790.4605.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, Ingo Molnar <mingo@elte.hu>, "David S. Miller" <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Paul Mundt <lethal@linux-sh.org>
List-ID: <linux-s390.vger.kernel.org>

Subject: [PATCH 1/3] hugetlbfs: architecture header cleanup

From: Gerald Schaefer <gerald.schaefer@de.ibm.com>

This patch moves all architecture functions for hugetlb to architecture
header files (include/asm-foo/hugetlb.h) and converts all macros to inline
functions. It also removes (!) ARCH_HAS_HUGEPAGE_ONLY_RANGE,
ARCH_HAS_HUGETLB_FREE_PGD_RANGE, ARCH_HAS_PREPARE_HUGEPAGE_RANGE,
ARCH_HAS_SETCLEAR_HUGE_PTE and ARCH_HAS_HUGETLB_PREFAULT_HOOK.

Getting rid of the ARCH_HAS_xxx #ifdef and macro fugliness should increase
readability and maintainability, at the price of some code duplication.
An asm-generic common part would have reduced the loc, but we would end up
with new ARCH_HAS_xxx defines eventually.

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
---

 include/asm-ia64/hugetlb.h    |   37 +++++++++++++++++++++++++++++++
 include/asm-ia64/page.h       |    6 -----
 include/asm-powerpc/hugetlb.h |   37 +++++++++++++++++++++++++++++++
 include/asm-powerpc/page_64.h |    7 ------
 include/asm-sh/hugetlb.h      |   49 ++++++++++++++++++++++++++++++++++++++++++
 include/asm-sparc64/hugetlb.h |   42 ++++++++++++++++++++++++++++++++++++
 include/asm-sparc64/page.h    |    2 -
 include/asm-x86/hugetlb.h     |   49 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/hugetlb.h       |   46 ---------------------------------------
 9 files changed, 215 insertions(+), 60 deletions(-)

Index: linux-2.6.25-rc8/include/asm-ia64/hugetlb.h
===================================================================
--- /dev/null
+++ linux-2.6.25-rc8/include/asm-ia64/hugetlb.h
@@ -0,0 +1,37 @@
+#ifndef _ASM_IA64_HUGETLB_H
+#define _ASM_IA64_HUGETLB_H
+
+#include <asm/page.h>
+
+
+void hugetlb_free_pgd_range(struct mmu_gather **tlb, unsigned long addr,
+			    unsigned long end, unsigned long floor,
+			    unsigned long ceiling);
+
+int prepare_hugepage_range(unsigned long addr, unsigned long len);
+
+static inline int is_hugepage_only_range(struct mm_struct *mm,
+					 unsigned long addr,
+					 unsigned long len)
+{
+	return (REGION_NUMBER(addr) == RGN_HPAGE ||
+		REGION_NUMBER((addr)+(len)-1) == RGN_HPAGE);
+}
+
+static inline void hugetlb_prefault_arch_hook(struct mm_struct *mm)
+{
+}
+
+static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
+				   pte_t *ptep, pte_t pte)
+{
+	set_pte_at(mm, addr, ptep, pte);
+}
+
+static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
+					    unsigned long addr, pte_t *ptep)
+{
+	return ptep_get_and_clear(mm, addr, ptep);
+}
+
+#endif /* _ASM_IA64_HUGETLB_H */
Index: linux-2.6.25-rc8/include/asm-sh/hugetlb.h
===================================================================
--- /dev/null
+++ linux-2.6.25-rc8/include/asm-sh/hugetlb.h
@@ -0,0 +1,49 @@
+#ifndef _ASM_SH_HUGETLB_H
+#define _ASM_SH_HUGETLB_H
+
+#include <asm/page.h>
+
+
+static inline int is_hugepage_only_range(struct mm_struct *mm,
+					 unsigned long addr,
+					 unsigned long len) {
+	return 0;
+}
+
+/*
+ * If the arch doesn't supply something else, assume that hugepage
+ * size aligned regions are ok without further preparation.
+ */
+static inline int prepare_hugepage_range(unsigned long addr, unsigned long len)
+{
+	if (len & ~HPAGE_MASK)
+		return -EINVAL;
+	if (addr & ~HPAGE_MASK)
+		return -EINVAL;
+	return 0;
+}
+
+static inline void hugetlb_prefault_arch_hook(struct mm_struct *mm) {
+}
+
+static inline void hugetlb_free_pgd_range(struct mmu_gather **tlb,
+					  unsigned long addr, unsigned long end,
+					  unsigned long floor,
+					  unsigned long ceiling)
+{
+	free_pgd_range(tlb, addr, end, floor, ceiling);
+}
+
+static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
+				   pte_t *ptep, pte_t pte)
+{
+	set_pte_at(mm, addr, ptep, pte);
+}
+
+static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
+					    unsigned long addr, pte_t *ptep)
+{
+	return ptep_get_and_clear(mm, addr, ptep);
+}
+
+#endif /* _ASM_SH_HUGETLB_H */
Index: linux-2.6.25-rc8/include/asm-sparc64/hugetlb.h
===================================================================
--- /dev/null
+++ linux-2.6.25-rc8/include/asm-sparc64/hugetlb.h
@@ -0,0 +1,42 @@
+#ifndef _ASM_SPARC64_HUGETLB_H
+#define _ASM_SPARC64_HUGETLB_H
+
+#include <asm/page.h>
+
+
+void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
+		     pte_t *ptep, pte_t pte);
+
+pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep);
+
+void hugetlb_prefault_arch_hook(struct mm_struct *mm);
+
+static inline int is_hugepage_only_range(struct mm_struct *mm,
+					 unsigned long addr,
+					 unsigned long len) {
+	return 0;
+}
+
+/*
+ * If the arch doesn't supply something else, assume that hugepage
+ * size aligned regions are ok without further preparation.
+ */
+static inline int prepare_hugepage_range(unsigned long addr, unsigned long len)
+{
+	if (len & ~HPAGE_MASK)
+		return -EINVAL;
+	if (addr & ~HPAGE_MASK)
+		return -EINVAL;
+	return 0;
+}
+
+static inline void hugetlb_free_pgd_range(struct mmu_gather **tlb,
+					  unsigned long addr, unsigned long end,
+					  unsigned long floor,
+					  unsigned long ceiling)
+{
+	free_pgd_range(tlb, addr, end, floor, ceiling);
+}
+
+#endif /* _ASM_SPARC64_HUGETLB_H */
Index: linux-2.6.25-rc8/include/asm-x86/hugetlb.h
===================================================================
--- /dev/null
+++ linux-2.6.25-rc8/include/asm-x86/hugetlb.h
@@ -0,0 +1,49 @@
+#ifndef _ASM_X86_HUGETLB_H
+#define _ASM_X86_HUGETLB_H
+
+#include <asm/page.h>
+
+
+static inline int is_hugepage_only_range(struct mm_struct *mm,
+					 unsigned long addr,
+					 unsigned long len) {
+	return 0;
+}
+
+/*
+ * If the arch doesn't supply something else, assume that hugepage
+ * size aligned regions are ok without further preparation.
+ */
+static inline int prepare_hugepage_range(unsigned long addr, unsigned long len)
+{
+	if (len & ~HPAGE_MASK)
+		return -EINVAL;
+	if (addr & ~HPAGE_MASK)
+		return -EINVAL;
+	return 0;
+}
+
+static inline void hugetlb_prefault_arch_hook(struct mm_struct *mm) {
+}
+
+static inline void hugetlb_free_pgd_range(struct mmu_gather **tlb,
+					  unsigned long addr, unsigned long end,
+					  unsigned long floor,
+					  unsigned long ceiling)
+{
+	free_pgd_range(tlb, addr, end, floor, ceiling);
+}
+
+static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
+				   pte_t *ptep, pte_t pte)
+{
+	set_pte_at(mm, addr, ptep, pte);
+}
+
+static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
+					    unsigned long addr, pte_t *ptep)
+{
+	return ptep_get_and_clear(mm, addr, ptep);
+}
+
+#endif /* _ASM_X86_HUGETLB_H */
Index: linux-2.6.25-rc8/include/linux/hugetlb.h
===================================================================
--- linux-2.6.25-rc8.orig/include/linux/hugetlb.h
+++ linux-2.6.25-rc8/include/linux/hugetlb.h
@@ -8,6 +8,7 @@
 #include <linux/mempolicy.h>
 #include <linux/shm.h>
 #include <asm/tlbflush.h>
+#include <asm/hugetlb.h>
 
 struct ctl_table;
 
@@ -51,51 +52,6 @@ int pmd_huge(pmd_t pmd);
 void hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot);
 
-#ifndef ARCH_HAS_HUGEPAGE_ONLY_RANGE
-#define is_hugepage_only_range(mm, addr, len)	0
-#endif
-
-#ifndef ARCH_HAS_HUGETLB_FREE_PGD_RANGE
-#define hugetlb_free_pgd_range	free_pgd_range
-#else
-void hugetlb_free_pgd_range(struct mmu_gather **tlb, unsigned long addr,
-			    unsigned long end, unsigned long floor,
-			    unsigned long ceiling);
-#endif
-
-#ifndef ARCH_HAS_PREPARE_HUGEPAGE_RANGE
-/*
- * If the arch doesn't supply something else, assume that hugepage
- * size aligned regions are ok without further preparation.
- */
-static inline int prepare_hugepage_range(unsigned long addr, unsigned long len)
-{
-	if (len & ~HPAGE_MASK)
-		return -EINVAL;
-	if (addr & ~HPAGE_MASK)
-		return -EINVAL;
-	return 0;
-}
-#else
-int prepare_hugepage_range(unsigned long addr, unsigned long len);
-#endif
-
-#ifndef ARCH_HAS_SETCLEAR_HUGE_PTE
-#define set_huge_pte_at(mm, addr, ptep, pte)	set_pte_at(mm, addr, ptep, pte)
-#define huge_ptep_get_and_clear(mm, addr, ptep) ptep_get_and_clear(mm, addr, ptep)
-#else
-void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
-		     pte_t *ptep, pte_t pte);
-pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep);
-#endif
-
-#ifndef ARCH_HAS_HUGETLB_PREFAULT_HOOK
-#define hugetlb_prefault_arch_hook(mm)		do { } while (0)
-#else
-void hugetlb_prefault_arch_hook(struct mm_struct *mm);
-#endif
-
 #else /* !CONFIG_HUGETLB_PAGE */
 
 static inline int is_vm_hugetlb_page(struct vm_area_struct *vma)
Index: linux-2.6.25-rc8/include/asm-powerpc/hugetlb.h
===================================================================
--- /dev/null
+++ linux-2.6.25-rc8/include/asm-powerpc/hugetlb.h
@@ -0,0 +1,37 @@
+#ifndef _ASM_POWERPC_HUGETLB_H
+#define _ASM_POWERPC_HUGETLB_H
+
+#include <asm/page.h>
+
+
+int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
+			   unsigned long len);
+
+void hugetlb_free_pgd_range(struct mmu_gather **tlb, unsigned long addr,
+			    unsigned long end, unsigned long floor,
+			    unsigned long ceiling);
+
+void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
+		     pte_t *ptep, pte_t pte);
+
+pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep);
+
+/*
+ * If the arch doesn't supply something else, assume that hugepage
+ * size aligned regions are ok without further preparation.
+ */
+static inline int prepare_hugepage_range(unsigned long addr, unsigned long len)
+{
+	if (len & ~HPAGE_MASK)
+		return -EINVAL;
+	if (addr & ~HPAGE_MASK)
+		return -EINVAL;
+	return 0;
+}
+
+static inline void hugetlb_prefault_arch_hook(struct mm_struct *mm)
+{
+}
+
+#endif /* _ASM_POWERPC_HUGETLB_H */
Index: linux-2.6.25-rc8/include/asm-ia64/page.h
===================================================================
--- linux-2.6.25-rc8.orig/include/asm-ia64/page.h
+++ linux-2.6.25-rc8/include/asm-ia64/page.h
@@ -54,9 +54,6 @@
 # define HPAGE_MASK		(~(HPAGE_SIZE - 1))
 
 # define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
-# define ARCH_HAS_HUGEPAGE_ONLY_RANGE
-# define ARCH_HAS_PREPARE_HUGEPAGE_RANGE
-# define ARCH_HAS_HUGETLB_FREE_PGD_RANGE
 #endif /* CONFIG_HUGETLB_PAGE */
 
 #ifdef __ASSEMBLY__
@@ -153,9 +150,6 @@ typedef union ia64_va {
 # define htlbpage_to_page(x)	(((unsigned long) REGION_NUMBER(x) << 61)			\
 				 | (REGION_OFFSET(x) >> (HPAGE_SHIFT-PAGE_SHIFT)))
 # define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
-# define is_hugepage_only_range(mm, addr, len)		\
-	 (REGION_NUMBER(addr) == RGN_HPAGE ||	\
-	  REGION_NUMBER((addr)+(len)-1) == RGN_HPAGE)
 extern unsigned int hpage_shift;
 #endif
 
Index: linux-2.6.25-rc8/include/asm-powerpc/page_64.h
===================================================================
--- linux-2.6.25-rc8.orig/include/asm-powerpc/page_64.h
+++ linux-2.6.25-rc8/include/asm-powerpc/page_64.h
@@ -128,11 +128,6 @@ extern void slice_init_context(struct mm
 extern void slice_set_user_psize(struct mm_struct *mm, unsigned int psize);
 #define slice_mm_new_context(mm)	((mm)->context.id == 0)
 
-#define ARCH_HAS_HUGEPAGE_ONLY_RANGE
-extern int is_hugepage_only_range(struct mm_struct *m,
-				  unsigned long addr,
-				  unsigned long len);
-
 #endif /* __ASSEMBLY__ */
 #else
 #define slice_init()
@@ -146,8 +141,6 @@ do {						\
 
 #ifdef CONFIG_HUGETLB_PAGE
 
-#define ARCH_HAS_HUGETLB_FREE_PGD_RANGE
-#define ARCH_HAS_SETCLEAR_HUGE_PTE
 #define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
 
 #endif /* !CONFIG_HUGETLB_PAGE */
Index: linux-2.6.25-rc8/include/asm-sparc64/page.h
===================================================================
--- linux-2.6.25-rc8.orig/include/asm-sparc64/page.h
+++ linux-2.6.25-rc8/include/asm-sparc64/page.h
@@ -39,8 +39,6 @@
 #define HPAGE_SIZE		(_AC(1,UL) << HPAGE_SHIFT)
 #define HPAGE_MASK		(~(HPAGE_SIZE - 1UL))
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
-#define ARCH_HAS_SETCLEAR_HUGE_PTE
-#define ARCH_HAS_HUGETLB_PREFAULT_HOOK
 #define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
 #endif
 
