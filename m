Return-Path: <linux-kernel-owner+w=401wt.eu-S1764987AbYD2OUS@vger.kernel.org>
Message-Id: <20080429140251.975867546@de.ibm.com>
References: <20080429140117.631962807@de.ibm.com>
Date: Tue, 29 Apr 2008 16:01:31 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 14/15] System z large page support.
Content-Disposition: inline; filename=014-large-page.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Gerald Schaefer <geraldsc@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Gerald Schaefer <geraldsc@de.ibm.com>

This adds hugetlbfs support on System z, using both hardware large page
support if available and software large page emulation on older hardware.
Shared (large) page tables are implemented in software emulation mode,
by using page->index of the first tail page from a compound large page
to store page table information.

Signed-off-by: Gerald Schaefer <geraldsc@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/early.c    |   16 +++
 arch/s390/kernel/head64.S   |    2 
 arch/s390/kernel/setup.c    |   10 +-
 arch/s390/mm/Makefile       |    2 
 arch/s390/mm/fault.c        |    3 
 arch/s390/mm/hugetlbpage.c  |  134 ++++++++++++++++++++++++++++++++
 arch/s390/mm/init.c         |   23 -----
 arch/s390/mm/vmem.c         |   55 +++++++++++--
 fs/Kconfig                  |    3 
 include/asm-s390/hugetlb.h  |  183 ++++++++++++++++++++++++++++++++++++++++++++
 include/asm-s390/page.h     |   29 +++++-
 include/asm-s390/pgtable.h  |   12 ++
 include/asm-s390/setup.h    |    6 +
 include/asm-s390/tlbflush.h |    1 
 14 files changed, 437 insertions(+), 42 deletions(-)

Index: quilt-2.6/arch/s390/kernel/early.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/early.c
+++ quilt-2.6/arch/s390/kernel/early.c
@@ -268,6 +268,19 @@ static noinline __init void setup_lowcor
 	s390_base_pgm_handler_fn = early_pgm_check_handler;
 }
 
+static noinline __init void setup_hpage(void)
+{
+#ifndef CONFIG_DEBUG_PAGEALLOC
+	unsigned int facilities;
+
+	facilities = stfl();
+	if (!(facilities & (1UL << 23)) || !(facilities & (1UL << 29)))
+		return;
+	machine_flags |= MACHINE_FLAG_HPAGE;
+	__ctl_set_bit(0, 23);
+#endif
+}
+
 static __init void detect_mvpg(void)
 {
 #ifndef CONFIG_64BIT
@@ -360,6 +373,8 @@ static __init void detect_machine_facili
 	facilities = stfl();
 	if (facilities & (1 << 28))
 		machine_flags |= MACHINE_FLAG_IDTE;
+	if (facilities & (1 << 23))
+		machine_flags |= MACHINE_FLAG_PFMF;
 	if (facilities & (1 << 4))
 		machine_flags |= MACHINE_FLAG_MVCOS;
 #endif
@@ -388,6 +403,7 @@ void __init startup_init(void)
 	detect_diag9c();
 	detect_diag44();
 	detect_machine_facilities();
+	setup_hpage();
 	sclp_read_info_early();
 	sclp_facilities_detect();
 	memsize = sclp_memory_detect();
Index: quilt-2.6/arch/s390/kernel/head64.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/head64.S
+++ quilt-2.6/arch/s390/kernel/head64.S
@@ -129,7 +129,7 @@ startup_continue:
 					# virtual and never return ...
 	.align	16
 .Lentry:.quad	0x0000000180000000,_stext
-.Lctl:	.quad	0x04b50002		# cr0: various things
+.Lctl:	.quad	0x04350002		# cr0: various things
 	.quad	0			# cr1: primary space segment table
 	.quad	.Lduct			# cr2: dispatchable unit control table
 	.quad	0			# cr3: instruction authorization
Index: quilt-2.6/arch/s390/kernel/setup.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/setup.c
+++ quilt-2.6/arch/s390/kernel/setup.c
@@ -749,6 +749,9 @@ static void __init setup_hwcaps(void)
 			elf_hwcap |= 1UL << 6;
 	}
 
+	if (MACHINE_HAS_HPAGE)
+		elf_hwcap |= 1UL << 7;
+
 	switch (cpuinfo->cpu_id.machine) {
 	case 0x9672:
 #if !defined(CONFIG_64BIT)
@@ -872,8 +875,9 @@ void __cpuinit print_cpu_info(struct cpu
 
 static int show_cpuinfo(struct seq_file *m, void *v)
 {
-	static const char *hwcap_str[7] = {
-		"esan3", "zarch", "stfle", "msa", "ldisp", "eimm", "dfp"
+	static const char *hwcap_str[8] = {
+		"esan3", "zarch", "stfle", "msa", "ldisp", "eimm", "dfp",
+		"edat"
 	};
         struct cpuinfo_S390 *cpuinfo;
 	unsigned long n = (unsigned long) v - 1;
@@ -888,7 +892,7 @@ static int show_cpuinfo(struct seq_file 
 			       num_online_cpus(), loops_per_jiffy/(500000/HZ),
 			       (loops_per_jiffy/(5000/HZ))%100);
 		seq_puts(m, "features\t: ");
-		for (i = 0; i < 7; i++)
+		for (i = 0; i < 8; i++)
 			if (hwcap_str[i] && (elf_hwcap & (1UL << i)))
 				seq_printf(m, "%s ", hwcap_str[i]);
 		seq_puts(m, "\n");
Index: quilt-2.6/arch/s390/mm/fault.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/fault.c
+++ quilt-2.6/arch/s390/mm/fault.c
@@ -28,6 +28,7 @@
 #include <linux/hardirq.h>
 #include <linux/kprobes.h>
 #include <linux/uaccess.h>
+#include <linux/hugetlb.h>
 #include <asm/system.h>
 #include <asm/pgtable.h>
 #include <asm/s390_ext.h>
@@ -367,6 +368,8 @@ good_area:
 	}
 
 survive:
+	if (is_vm_hugetlb_page(vma))
+		address &= HPAGE_MASK;
 	/*
 	 * If for any reason at all we couldn't handle the fault,
 	 * make sure we exit gracefully rather than endlessly redo
Index: quilt-2.6/arch/s390/mm/hugetlbpage.c
===================================================================
--- /dev/null
+++ quilt-2.6/arch/s390/mm/hugetlbpage.c
@@ -0,0 +1,134 @@
+/*
+ *  IBM System z Huge TLB Page Support for Kernel.
+ *
+ *    Copyright 2007 IBM Corp.
+ *    Author(s): Gerald Schaefer <gerald.schaefer@de.ibm.com>
+ */
+
+#include <linux/mm.h>
+#include <linux/hugetlb.h>
+
+
+void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
+				   pte_t *pteptr, pte_t pteval)
+{
+	pmd_t *pmdp = (pmd_t *) pteptr;
+	pte_t shadow_pteval = pteval;
+	unsigned long mask;
+
+	if (!MACHINE_HAS_HPAGE) {
+		pteptr = (pte_t *) pte_page(pteval)[1].index;
+		mask = pte_val(pteval) &
+				(_SEGMENT_ENTRY_INV | _SEGMENT_ENTRY_RO);
+		pte_val(pteval) = (_SEGMENT_ENTRY + __pa(pteptr)) | mask;
+		if (mm->context.noexec) {
+			pteptr += PTRS_PER_PTE;
+			pte_val(shadow_pteval) =
+					(_SEGMENT_ENTRY + __pa(pteptr)) | mask;
+		}
+	}
+
+	pmd_val(*pmdp) = pte_val(pteval);
+	if (mm->context.noexec) {
+		pmdp = get_shadow_table(pmdp);
+		pmd_val(*pmdp) = pte_val(shadow_pteval);
+	}
+}
+
+int arch_prepare_hugepage(struct page *page)
+{
+	unsigned long addr = page_to_phys(page);
+	pte_t pte;
+	pte_t *ptep;
+	int i;
+
+	if (MACHINE_HAS_HPAGE)
+		return 0;
+
+	ptep = (pte_t *) pte_alloc_one(&init_mm, address);
+	if (!ptep)
+		return -ENOMEM;
+
+	pte = mk_pte(page, PAGE_RW);
+	for (i = 0; i < PTRS_PER_PTE; i++) {
+		set_pte_at(&init_mm, addr + i * PAGE_SIZE, ptep + i, pte);
+		pte_val(pte) += PAGE_SIZE;
+	}
+	page[1].index = (unsigned long) ptep;
+	return 0;
+}
+
+void arch_release_hugepage(struct page *page)
+{
+	pte_t *ptep;
+
+	if (MACHINE_HAS_HPAGE)
+		return;
+
+	ptep = (pte_t *) page[1].index;
+	if (!ptep)
+		return;
+	pte_free(&init_mm, ptep);
+	page[1].index = 0;
+}
+
+pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
+{
+	pgd_t *pgdp;
+	pud_t *pudp;
+	pmd_t *pmdp = NULL;
+
+	pgdp = pgd_offset(mm, addr);
+	pudp = pud_alloc(mm, pgdp, addr);
+	if (pudp)
+		pmdp = pmd_alloc(mm, pudp, addr);
+	return (pte_t *) pmdp;
+}
+
+pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
+{
+	pgd_t *pgdp;
+	pud_t *pudp;
+	pmd_t *pmdp = NULL;
+
+	pgdp = pgd_offset(mm, addr);
+	if (pgd_present(*pgdp)) {
+		pudp = pud_offset(pgdp, addr);
+		if (pud_present(*pudp))
+			pmdp = pmd_offset(pudp, addr);
+	}
+	return (pte_t *) pmdp;
+}
+
+int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr, pte_t *ptep)
+{
+	return 0;
+}
+
+struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address,
+			      int write)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+int pmd_huge(pmd_t pmd)
+{
+	if (!MACHINE_HAS_HPAGE)
+		return 0;
+
+	return !!(pmd_val(pmd) & _SEGMENT_ENTRY_LARGE);
+}
+
+struct page *follow_huge_pmd(struct mm_struct *mm, unsigned long address,
+			     pmd_t *pmdp, int write)
+{
+	struct page *page;
+
+	if (!MACHINE_HAS_HPAGE)
+		return NULL;
+
+	page = pmd_page(*pmdp);
+	if (page)
+		page += ((address & ~HPAGE_MASK) >> PAGE_SHIFT);
+	return page;
+}
Index: quilt-2.6/arch/s390/mm/init.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/init.c
+++ quilt-2.6/arch/s390/mm/init.c
@@ -77,28 +77,6 @@ void show_mem(void)
 	printk("%lu pages pagetables\n", global_page_state(NR_PAGETABLE));
 }
 
-static void __init setup_ro_region(void)
-{
-	pgd_t *pgd;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-	pte_t new_pte;
-	unsigned long address, end;
-
-	address = ((unsigned long)&_stext) & PAGE_MASK;
-	end = PFN_ALIGN((unsigned long)&_eshared);
-
-	for (; address < end; address += PAGE_SIZE) {
-		pgd = pgd_offset_k(address);
-		pud = pud_offset(pgd, address);
-		pmd = pmd_offset(pud, address);
-		pte = pte_offset_kernel(pmd, address);
-		new_pte = mk_pte_phys(address, __pgprot(_PAGE_RO));
-		*pte = new_pte;
-	}
-}
-
 /*
  * paging_init() sets up the page tables
  */
@@ -121,7 +99,6 @@ void __init paging_init(void)
 	clear_table((unsigned long *) init_mm.pgd, pgd_type,
 		    sizeof(unsigned long)*2048);
 	vmem_map_init();
-	setup_ro_region();
 
         /* enable virtual mapping in kernel mode */
 	__ctl_load(S390_lowcore.kernel_asce, 1, 1);
Index: quilt-2.6/arch/s390/mm/Makefile
===================================================================
--- quilt-2.6.orig/arch/s390/mm/Makefile
+++ quilt-2.6/arch/s390/mm/Makefile
@@ -4,4 +4,4 @@
 
 obj-y	 := init.o fault.o extmem.o mmap.o vmem.o pgtable.o
 obj-$(CONFIG_CMM) += cmm.o
-
+obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
Index: quilt-2.6/arch/s390/mm/vmem.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/vmem.c
+++ quilt-2.6/arch/s390/mm/vmem.c
@@ -10,10 +10,12 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/list.h>
+#include <linux/hugetlb.h>
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/setup.h>
 #include <asm/tlbflush.h>
+#include <asm/sections.h>
 
 static DEFINE_MUTEX(vmem_mutex);
 
@@ -113,7 +115,7 @@ static pte_t __init_refok *vmem_pte_allo
 /*
  * Add a physical memory range to the 1:1 mapping.
  */
-static int vmem_add_range(unsigned long start, unsigned long size)
+static int vmem_add_range(unsigned long start, unsigned long size, int ro)
 {
 	unsigned long address;
 	pgd_t *pg_dir;
@@ -140,7 +142,19 @@ static int vmem_add_range(unsigned long 
 			pud_populate_kernel(&init_mm, pu_dir, pm_dir);
 		}
 
+		pte = mk_pte_phys(address, __pgprot(ro ? _PAGE_RO : 0));
 		pm_dir = pmd_offset(pu_dir, address);
+
+#ifdef __s390x__
+		if (MACHINE_HAS_HPAGE && !(address & ~HPAGE_MASK) &&
+		    (address + HPAGE_SIZE <= start + size) &&
+		    (address >= HPAGE_SIZE)) {
+			pte_val(pte) |= _SEGMENT_ENTRY_LARGE;
+			pmd_val(*pm_dir) = pte_val(pte);
+			address += HPAGE_SIZE - PAGE_SIZE;
+			continue;
+		}
+#endif
 		if (pmd_none(*pm_dir)) {
 			pt_dir = vmem_pte_alloc();
 			if (!pt_dir)
@@ -149,7 +163,6 @@ static int vmem_add_range(unsigned long 
 		}
 
 		pt_dir = pte_offset_kernel(pm_dir, address);
-		pte = pfn_pte(address >> PAGE_SHIFT, PAGE_KERNEL);
 		*pt_dir = pte;
 	}
 	ret = 0;
@@ -180,6 +193,13 @@ static void vmem_remove_range(unsigned l
 		pm_dir = pmd_offset(pu_dir, address);
 		if (pmd_none(*pm_dir))
 			continue;
+
+		if (pmd_huge(*pm_dir)) {
+			pmd_clear_kernel(pm_dir);
+			address += HPAGE_SIZE - PAGE_SIZE;
+			continue;
+		}
+
 		pt_dir = pte_offset_kernel(pm_dir, address);
 		*pt_dir = pte;
 	}
@@ -248,14 +268,14 @@ out:
 	return ret;
 }
 
-static int vmem_add_mem(unsigned long start, unsigned long size)
+static int vmem_add_mem(unsigned long start, unsigned long size, int ro)
 {
 	int ret;
 
 	ret = vmem_add_mem_map(start, size);
 	if (ret)
 		return ret;
-	return vmem_add_range(start, size);
+	return vmem_add_range(start, size, ro);
 }
 
 /*
@@ -338,7 +358,7 @@ int add_shared_memory(unsigned long star
 	if (ret)
 		goto out_free;
 
-	ret = vmem_add_mem(start, size);
+	ret = vmem_add_mem(start, size, 0);
 	if (ret)
 		goto out_remove;
 
@@ -374,14 +394,35 @@ out:
  */
 void __init vmem_map_init(void)
 {
+	unsigned long ro_start, ro_end;
+	unsigned long start, end;
 	int i;
 
 	INIT_LIST_HEAD(&init_mm.context.crst_list);
 	INIT_LIST_HEAD(&init_mm.context.pgtable_list);
 	init_mm.context.noexec = 0;
 	NODE_DATA(0)->node_mem_map = VMEM_MAP;
-	for (i = 0; i < MEMORY_CHUNKS && memory_chunk[i].size > 0; i++)
-		vmem_add_mem(memory_chunk[i].addr, memory_chunk[i].size);
+	ro_start = ((unsigned long)&_stext) & PAGE_MASK;
+	ro_end = PFN_ALIGN((unsigned long)&_eshared);
+	for (i = 0; i < MEMORY_CHUNKS && memory_chunk[i].size > 0; i++) {
+		start = memory_chunk[i].addr;
+		end = memory_chunk[i].addr + memory_chunk[i].size;
+		if (start >= ro_end || end <= ro_start)
+			vmem_add_mem(start, end - start, 0);
+		else if (start >= ro_start && end <= ro_end)
+			vmem_add_mem(start, end - start, 1);
+		else if (start >= ro_start) {
+			vmem_add_mem(start, ro_end - start, 1);
+			vmem_add_mem(ro_end, end - ro_end, 0);
+		} else if (end < ro_end) {
+			vmem_add_mem(start, ro_start - start, 0);
+			vmem_add_mem(ro_start, end - ro_start, 1);
+		} else {
+			vmem_add_mem(start, ro_start - start, 0);
+			vmem_add_mem(ro_start, ro_end - ro_start, 1);
+			vmem_add_mem(ro_end, end - ro_end, 0);
+		}
+	}
 }
 
 /*
Index: quilt-2.6/fs/Kconfig
===================================================================
--- quilt-2.6.orig/fs/Kconfig
+++ quilt-2.6/fs/Kconfig
@@ -1005,7 +1005,8 @@ config TMPFS_POSIX_ACL
 
 config HUGETLBFS
 	bool "HugeTLB file system support"
-	depends on X86 || IA64 || PPC64 || SPARC64 || (SUPERH && MMU) || BROKEN
+	depends on X86 || IA64 || PPC64 || SPARC64 || (SUPERH && MMU) || \
+		   (S390 && 64BIT) || BROKEN
 	help
 	  hugetlbfs is a filesystem backing for HugeTLB pages, based on
 	  ramfs. For architectures that support it, say Y here and read
Index: quilt-2.6/include/asm-s390/hugetlb.h
===================================================================
--- /dev/null
+++ quilt-2.6/include/asm-s390/hugetlb.h
@@ -0,0 +1,183 @@
+/*
+ *  IBM System z Huge TLB Page Support for Kernel.
+ *
+ *    Copyright IBM Corp. 2008
+ *    Author(s): Gerald Schaefer <gerald.schaefer@de.ibm.com>
+ */
+
+#ifndef _ASM_S390_HUGETLB_H
+#define _ASM_S390_HUGETLB_H
+
+#include <asm/page.h>
+#include <asm/pgtable.h>
+
+
+#define is_hugepage_only_range(mm, addr, len)	0
+#define hugetlb_free_pgd_range			free_pgd_range
+
+void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
+		     pte_t *ptep, pte_t pte);
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
+#define hugetlb_prefault_arch_hook(mm)		do { } while (0)
+
+int arch_prepare_hugepage(struct page *page);
+void arch_release_hugepage(struct page *page);
+
+static inline pte_t pte_mkhuge(pte_t pte)
+{
+	/*
+	 * PROT_NONE needs to be remapped from the pte type to the ste type.
+	 * The HW invalid bit is also different for pte and ste. The pte
+	 * invalid bit happens to be the same as the ste _SEGMENT_ENTRY_LARGE
+	 * bit, so we don't have to clear it.
+	 */
+	if (pte_val(pte) & _PAGE_INVALID) {
+		if (pte_val(pte) & _PAGE_SWT)
+			pte_val(pte) |= _HPAGE_TYPE_NONE;
+		pte_val(pte) |= _SEGMENT_ENTRY_INV;
+	}
+	/*
+	 * Clear SW pte bits SWT and SWX, there are no SW bits in a segment
+	 * table entry.
+	 */
+	pte_val(pte) &= ~(_PAGE_SWT | _PAGE_SWX);
+	/*
+	 * Also set the change-override bit because we don't need dirty bit
+	 * tracking for hugetlbfs pages.
+	 */
+	pte_val(pte) |= (_SEGMENT_ENTRY_LARGE | _SEGMENT_ENTRY_CO);
+	return pte;
+}
+
+static inline pte_t huge_pte_wrprotect(pte_t pte)
+{
+	pte_val(pte) |= _PAGE_RO;
+	return pte;
+}
+
+static inline int huge_pte_none(pte_t pte)
+{
+	return (pte_val(pte) & _SEGMENT_ENTRY_INV) &&
+		!(pte_val(pte) & _SEGMENT_ENTRY_RO);
+}
+
+static inline pte_t huge_ptep_get(pte_t *ptep)
+{
+	pte_t pte = *ptep;
+	unsigned long mask;
+
+	if (!MACHINE_HAS_HPAGE) {
+		ptep = (pte_t *) (pte_val(pte) & _SEGMENT_ENTRY_ORIGIN);
+		if (ptep) {
+			mask = pte_val(pte) &
+				(_SEGMENT_ENTRY_INV | _SEGMENT_ENTRY_RO);
+			pte = pte_mkhuge(*ptep);
+			pte_val(pte) |= mask;
+		}
+	}
+	return pte;
+}
+
+static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
+					    unsigned long addr, pte_t *ptep)
+{
+	pte_t pte = huge_ptep_get(ptep);
+
+	pmd_clear((pmd_t *) ptep);
+	return pte;
+}
+
+static inline void __pmd_csp(pmd_t *pmdp)
+{
+	register unsigned long reg2 asm("2") = pmd_val(*pmdp);
+	register unsigned long reg3 asm("3") = pmd_val(*pmdp) |
+					       _SEGMENT_ENTRY_INV;
+	register unsigned long reg4 asm("4") = ((unsigned long) pmdp) + 5;
+
+	asm volatile(
+		"	csp %1,%3"
+		: "=m" (*pmdp)
+		: "d" (reg2), "d" (reg3), "d" (reg4), "m" (*pmdp) : "cc");
+	pmd_val(*pmdp) = _SEGMENT_ENTRY_INV | _SEGMENT_ENTRY;
+}
+
+static inline void __pmd_idte(unsigned long address, pmd_t *pmdp)
+{
+	unsigned long sto = (unsigned long) pmdp -
+				pmd_index(address) * sizeof(pmd_t);
+
+	if (!(pmd_val(*pmdp) & _SEGMENT_ENTRY_INV)) {
+		asm volatile(
+			"	.insn	rrf,0xb98e0000,%2,%3,0,0"
+			: "=m" (*pmdp)
+			: "m" (*pmdp), "a" (sto),
+			  "a" ((address & HPAGE_MASK))
+		);
+	}
+	pmd_val(*pmdp) = _SEGMENT_ENTRY_INV | _SEGMENT_ENTRY;
+}
+
+static inline void huge_ptep_invalidate(struct mm_struct *mm,
+					unsigned long address, pte_t *ptep)
+{
+	pmd_t *pmdp = (pmd_t *) ptep;
+
+	if (!MACHINE_HAS_IDTE) {
+		__pmd_csp(pmdp);
+		if (mm->context.noexec) {
+			pmdp = get_shadow_table(pmdp);
+			__pmd_csp(pmdp);
+		}
+		return;
+	}
+
+	__pmd_idte(address, pmdp);
+	if (mm->context.noexec) {
+		pmdp = get_shadow_table(pmdp);
+		__pmd_idte(address, pmdp);
+	}
+	return;
+}
+
+#define huge_ptep_set_access_flags(__vma, __addr, __ptep, __entry, __dirty) \
+({									    \
+	int __changed = !pte_same(huge_ptep_get(__ptep), __entry);	    \
+	if (__changed) {						    \
+		huge_ptep_invalidate((__vma)->vm_mm, __addr, __ptep);	    \
+		set_huge_pte_at((__vma)->vm_mm, __addr, __ptep, __entry);   \
+	}								    \
+	__changed;							    \
+})
+
+#define huge_ptep_set_wrprotect(__mm, __addr, __ptep)			\
+({									\
+	pte_t __pte = huge_ptep_get(__ptep);				\
+	if (pte_write(__pte)) {						\
+		if (atomic_read(&(__mm)->mm_users) > 1 ||		\
+		    (__mm) != current->active_mm)			\
+			huge_ptep_invalidate(__mm, __addr, __ptep);	\
+		set_huge_pte_at(__mm, __addr, __ptep,			\
+				huge_pte_wrprotect(__pte));		\
+	}								\
+})
+
+static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
+					 unsigned long address, pte_t *ptep)
+{
+	huge_ptep_invalidate(vma->vm_mm, address, ptep);
+}
+
+#endif /* _ASM_S390_HUGETLB_H */
Index: quilt-2.6/include/asm-s390/page.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/page.h
+++ quilt-2.6/include/asm-s390/page.h
@@ -19,17 +19,34 @@
 #define PAGE_DEFAULT_ACC	0
 #define PAGE_DEFAULT_KEY	(PAGE_DEFAULT_ACC << 4)
 
+#define HPAGE_SHIFT	20
+#define HPAGE_SIZE	(1UL << HPAGE_SHIFT)
+#define HPAGE_MASK	(~(HPAGE_SIZE - 1))
+#define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
+
+#define ARCH_HAS_SETCLEAR_HUGE_PTE
+#define ARCH_HAS_HUGE_PTE_TYPE
+#define ARCH_HAS_PREPARE_HUGEPAGE
+#define ARCH_HAS_HUGEPAGE_CLEAR_FLUSH
+
 #include <asm/setup.h>
 #ifndef __ASSEMBLY__
 
 static inline void clear_page(void *page)
 {
-	register unsigned long reg1 asm ("1") = 0;
-	register void *reg2 asm ("2") = page;
-	register unsigned long reg3 asm ("3") = 4096;
-	asm volatile(
-		"	mvcl	2,0"
-		: "+d" (reg2), "+d" (reg3) : "d" (reg1) : "memory", "cc");
+	if (MACHINE_HAS_PFMF) {
+		asm volatile(
+			"	.insn	rre,0xb9af0000,%0,%1"
+			: : "d" (0x10000), "a" (page) : "memory", "cc");
+	} else {
+		register unsigned long reg1 asm ("1") = 0;
+		register void *reg2 asm ("2") = page;
+		register unsigned long reg3 asm ("3") = 4096;
+		asm volatile(
+			"	mvcl	2,0"
+			: "+d" (reg2), "+d" (reg3) : "d" (reg1)
+			: "memory", "cc");
+	}
 }
 
 static inline void copy_page(void *to, void *from)
Index: quilt-2.6/include/asm-s390/pgtable.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/pgtable.h
+++ quilt-2.6/include/asm-s390/pgtable.h
@@ -234,6 +234,15 @@ extern char empty_zero_page[PAGE_SIZE];
 #define _PAGE_TYPE_EX_RW	0x002
 
 /*
+ * Only four types for huge pages, using the invalid bit and protection bit
+ * of a segment table entry.
+ */
+#define _HPAGE_TYPE_EMPTY	0x020	/* _SEGMENT_ENTRY_INV */
+#define _HPAGE_TYPE_NONE	0x220
+#define _HPAGE_TYPE_RO		0x200	/* _SEGMENT_ENTRY_RO  */
+#define _HPAGE_TYPE_RW		0x000
+
+/*
  * PTE type bits are rather complicated. handle_pte_fault uses pte_present,
  * pte_none and pte_file to find out the pte type WITHOUT holding the page
  * table lock. ptep_clear_flush on the other hand uses ptep_clear_flush to
@@ -325,6 +334,9 @@ extern char empty_zero_page[PAGE_SIZE];
 #define _SEGMENT_ENTRY		(0)
 #define _SEGMENT_ENTRY_EMPTY	(_SEGMENT_ENTRY_INV)
 
+#define _SEGMENT_ENTRY_LARGE	0x400	/* STE-format control, large page   */
+#define _SEGMENT_ENTRY_CO	0x100	/* change-recording override   */
+
 #endif /* __s390x__ */
 
 /*
Index: quilt-2.6/include/asm-s390/setup.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/setup.h
+++ quilt-2.6/include/asm-s390/setup.h
@@ -69,6 +69,8 @@ extern unsigned long machine_flags;
 #define MACHINE_FLAG_DIAG9C	(1UL << 7)
 #define MACHINE_FLAG_MVCOS	(1UL << 8)
 #define MACHINE_FLAG_KVM	(1UL << 9)
+#define MACHINE_FLAG_HPAGE	(1UL << 10)
+#define MACHINE_FLAG_PFMF	(1UL << 11)
 
 #define MACHINE_IS_VM		(machine_flags & MACHINE_FLAG_VM)
 #define MACHINE_IS_KVM		(machine_flags & MACHINE_FLAG_KVM)
@@ -82,6 +84,8 @@ extern unsigned long machine_flags;
 #define MACHINE_HAS_DIAG44	(1)
 #define MACHINE_HAS_MVPG	(machine_flags & MACHINE_FLAG_MVPG)
 #define MACHINE_HAS_MVCOS	(0)
+#define MACHINE_HAS_HPAGE	(0)
+#define MACHINE_HAS_PFMF	(0)
 #else /* __s390x__ */
 #define MACHINE_HAS_IEEE	(1)
 #define MACHINE_HAS_CSP		(1)
@@ -89,6 +93,8 @@ extern unsigned long machine_flags;
 #define MACHINE_HAS_DIAG44	(machine_flags & MACHINE_FLAG_DIAG44)
 #define MACHINE_HAS_MVPG	(1)
 #define MACHINE_HAS_MVCOS	(machine_flags & MACHINE_FLAG_MVCOS)
+#define MACHINE_HAS_HPAGE	(machine_flags & MACHINE_FLAG_HPAGE)
+#define MACHINE_HAS_PFMF	(machine_flags & MACHINE_FLAG_PFMF)
 #endif /* __s390x__ */
 
 #define MACHINE_HAS_SCLP	(!MACHINE_IS_P390)
Index: quilt-2.6/include/asm-s390/tlbflush.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/tlbflush.h
+++ quilt-2.6/include/asm-s390/tlbflush.h
@@ -2,6 +2,7 @@
 #define _S390_TLBFLUSH_H
 
 #include <linux/mm.h>
+#include <linux/sched.h>
 #include <asm/processor.h>
 #include <asm/pgalloc.h>
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
