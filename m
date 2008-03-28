Return-Path: <linux-kernel-owner+w=401wt.eu-S1754325AbYC1ODl@vger.kernel.org>
Subject: Re: [patch 09/10] Hugetlb common code update for System z.
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Reply-To: gerald.schaefer@de.ibm.com
In-Reply-To: <20080312164303.cac9cab5.akpm@linux-foundation.org>
References: <20080312173155.703966894@de.ibm.com>
	 <20080312173218.186436562@de.ibm.com>
	 <1205344286.9828.91.camel@nimitz.home.sr71.net>
	 <1205363937.5237.60.camel@localhost.localdomain>
	 <20080312164303.cac9cab5.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Fri, 28 Mar 2008 15:05:19 +0100
Message-Id: <1206713119.5186.52.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: haveblue@us.ibm.com, schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Paul Mundt <lethal@linux-sh.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2008-03-12 at 16:43 -0700, Andrew Morton wrote:
> > There are already several ARCH_HAS_xxx defines which are being used in
> > inlude/linux/hugetlb.h. All of them are defined in
> > include/asm-<arch>/page.h for every architecture that needs them (with
> > the exception of powerpc, where it is include/asm-powerpc/page_64.h).
> 
> Yes, but that's fugly and it would be better to put in place the
> infrastructure for cleaning it up, rather than worsening it.
> 
> So...
> 
> Put this:
> 
> +#define huge_pte_none(pte)			pte_none(pte)
> +#define huge_pte_wrprotect(pte)			pte_wrprotect(pte)
> +#define huge_ptep_set_wrprotect(mm, addr, ptep)	\
> +	ptep_set_wrprotect(mm, addr, ptep)
> +#define huge_ptep_set_access_flags(vma, addr, ptep, pte, dirty)	\
> +	ptep_set_access_flags(vma, addr, ptep, pte, dirty)
> +#define huge_ptep_get(ptep)			(*ptep)
> 
> into include/asm-generic/hugetlb.h
> 
> then for each architecture except s390 add an include/asm-foo/hugetlb.h
> which does
> 
> #include <asm-generic/hugetlb.h>
> 
> then in include/linux/hugetlb.h add
> 
> #include <asm/hugetlb.h>
> 
> and then in include/asm-s390/hugetlb.h, add your s390-specific versions of
> huge_pte_none() and friends.
> 
> later, someone can hopefully use this new infrastructure to rid us of
> ARCH_HAS_HUGEPAGE_ONLY_RANGE, ARCH_HAS_HUGETLB_FREE_PGD_RANGE,
> ARCH_HAS_PREPARE_HUGEPAGE_RANGE, ARCH_HAS_SETCLEAR_HUGE_PTE and
> ARCH_HAS_HUGETLB_PREFAULT_HOOK.

This patch moves all architecture functions for hugetlb to architecture
header files (include/asm-foo/hugetlb.h). It also removes (!)
ARCH_HAS_HUGEPAGE_ONLY_RANGE, ARCH_HAS_HUGETLB_FREE_PGD_RANGE,
ARCH_HAS_PREPARE_HUGEPAGE_RANGE, ARCH_HAS_SETCLEAR_HUGE_PTE and
ARCH_HAS_HUGETLB_PREFAULT_HOOK.

Cross-Compile tests on the affected architectures (and one unaffected)
worked fine, but I had no cross-compiler for sh.

If this patch is accepted, we will resend the s390 large page patches
so that they will use/extend this new infrastructure.

--
Gerald Schaefer

---
 include/asm-ia64/hugetlb.h    |   21 +++++++++++++++++++
 include/asm-ia64/page.h       |    6 -----
 include/asm-powerpc/hugetlb.h |   35 +++++++++++++++++++++++++++++++
 include/asm-powerpc/page_64.h |    7 ------
 include/asm-sh/hugetlb.h      |   28 +++++++++++++++++++++++++
 include/asm-sparc64/hugetlb.h |   30 +++++++++++++++++++++++++++
 include/asm-sparc64/page.h    |    2 -
 include/asm-x86/hugetlb.h     |   28 +++++++++++++++++++++++++
 include/linux/hugetlb.h       |   46 ------------------------------------------
 9 files changed, 143 insertions(+), 60 deletions(-)

Index: linux-2.6.25-rc7/include/asm-ia64/hugetlb.h
===================================================================
--- /dev/null
+++ linux-2.6.25-rc7/include/asm-ia64/hugetlb.h
@@ -0,0 +1,21 @@
+#ifndef _ASM_IA64_HUGETLB_H
+#define _ASM_IA64_HUGETLB_H
+
+#include <asm/page.h>
+
+
+#define is_hugepage_only_range(mm, addr, len)		\
+	(REGION_NUMBER(addr) == RGN_HPAGE ||	\
+	 REGION_NUMBER((addr)+(len)-1) == RGN_HPAGE)
+
+void hugetlb_free_pgd_range(struct mmu_gather **tlb, unsigned long addr,
+			    unsigned long end, unsigned long floor,
+			    unsigned long ceiling);
+int prepare_hugepage_range(unsigned long addr, unsigned long len);
+
+#define set_huge_pte_at(mm, addr, ptep, pte)	set_pte_at(mm, addr, ptep, pte)
+#define huge_ptep_get_and_clear(mm, addr, ptep) ptep_get_and_clear(mm, addr, ptep)
+
+#define hugetlb_prefault_arch_hook(mm)		do { } while (0)
+
+#endif /* _ASM_IA64_HUGETLB_H */
Index: linux-2.6.25-rc7/include/asm-sh/hugetlb.h
===================================================================
--- /dev/null
+++ linux-2.6.25-rc7/include/asm-sh/hugetlb.h
@@ -0,0 +1,28 @@
+#ifndef _ASM_SH_HUGETLB_H
+#define _ASM_SH_HUGETLB_H
+
+#include <asm/page.h>
+
+
+#define is_hugepage_only_range(mm, addr, len)	0
+#define hugetlb_free_pgd_range			free_pgd_range
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
+#define set_huge_pte_at(mm, addr, ptep, pte)	set_pte_at(mm, addr, ptep, pte)
+#define huge_ptep_get_and_clear(mm, addr, ptep) ptep_get_and_clear(mm, addr, ptep)
+
+#define hugetlb_prefault_arch_hook(mm)		do { } while (0)
+
+#endif /* _ASM_SH_HUGETLB_H */
Index: linux-2.6.25-rc7/include/asm-sparc64/hugetlb.h
===================================================================
--- /dev/null
+++ linux-2.6.25-rc7/include/asm-sparc64/hugetlb.h
@@ -0,0 +1,30 @@
+#ifndef _ASM_SPARC64_HUGETLB_H
+#define _ASM_SPARC64_HUGETLB_H
+
+#include <asm/page.h>
+
+
+#define is_hugepage_only_range(mm, addr, len)	0
+#define hugetlb_free_pgd_range			free_pgd_range
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
+void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
+		     pte_t *ptep, pte_t pte);
+pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep);
+
+void hugetlb_prefault_arch_hook(struct mm_struct *mm);
+
+#endif /* _ASM_SPARC64_HUGETLB_H */
Index: linux-2.6.25-rc7/include/asm-x86/hugetlb.h
===================================================================
--- /dev/null
+++ linux-2.6.25-rc7/include/asm-x86/hugetlb.h
@@ -0,0 +1,28 @@
+#ifndef _ASM_X86_HUGETLB_H
+#define _ASM_X86_HUGETLB_H
+
+#include <asm/page.h>
+
+
+#define is_hugepage_only_range(mm, addr, len)	0
+#define hugetlb_free_pgd_range			free_pgd_range
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
+#define set_huge_pte_at(mm, addr, ptep, pte)	set_pte_at(mm, addr, ptep, pte)
+#define huge_ptep_get_and_clear(mm, addr, ptep) ptep_get_and_clear(mm, addr, ptep)
+
+#define hugetlb_prefault_arch_hook(mm)		do { } while (0)
+
+#endif /* _ASM_X86_HUGETLB_H */
Index: linux-2.6.25-rc7/include/linux/hugetlb.h
===================================================================
--- linux-2.6.25-rc7.orig/include/linux/hugetlb.h
+++ linux-2.6.25-rc7/include/linux/hugetlb.h
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
Index: linux-2.6.25-rc7/include/asm-powerpc/hugetlb.h
===================================================================
--- /dev/null
+++ linux-2.6.25-rc7/include/asm-powerpc/hugetlb.h
@@ -0,0 +1,35 @@
+#ifndef _ASM_POWERPC_HUGETLB_H
+#define _ASM_POWERPC_HUGETLB_H
+
+#include <asm/page.h>
+
+
+extern int is_hugepage_only_range(struct mm_struct *m,
+				  unsigned long addr,
+				  unsigned long len);
+
+void hugetlb_free_pgd_range(struct mmu_gather **tlb, unsigned long addr,
+			    unsigned long end, unsigned long floor,
+			    unsigned long ceiling);
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
+void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
+		     pte_t *ptep, pte_t pte);
+pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep);
+
+#define hugetlb_prefault_arch_hook(mm)		do { } while (0)
+
+#endif /* _ASM_POWERPC_HUGETLB_H */
Index: linux-2.6.25-rc7/include/asm-ia64/page.h
===================================================================
--- linux-2.6.25-rc7.orig/include/asm-ia64/page.h
+++ linux-2.6.25-rc7/include/asm-ia64/page.h
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
 
Index: linux-2.6.25-rc7/include/asm-powerpc/page_64.h
===================================================================
--- linux-2.6.25-rc7.orig/include/asm-powerpc/page_64.h
+++ linux-2.6.25-rc7/include/asm-powerpc/page_64.h
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
Index: linux-2.6.25-rc7/include/asm-sparc64/page.h
===================================================================
--- linux-2.6.25-rc7.orig/include/asm-sparc64/page.h
+++ linux-2.6.25-rc7/include/asm-sparc64/page.h
@@ -39,8 +39,6 @@
 #define HPAGE_SIZE		(_AC(1,UL) << HPAGE_SHIFT)
 #define HPAGE_MASK		(~(HPAGE_SIZE - 1UL))
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
-#define ARCH_HAS_SETCLEAR_HUGE_PTE
-#define ARCH_HAS_HUGETLB_PREFAULT_HOOK
 #define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
 #endif
 
