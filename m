Return-Path: <linux-kernel-owner+w=401wt.eu-S1759743AbYBIMHq@vger.kernel.org>
Message-Id: <20080209120317.281606429@de.ibm.com>
References: <20080209120157.885371603@de.ibm.com>
Date: Sat, 09 Feb 2008 13:02:08 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 11/11] dynamic page tables.
Content-Disposition: inline; filename=052-mm-dynpgd.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Add support for different number of page table levels dependent
on the highest address used for a process. This will cause a 31 bit
process to use a two level page table instead of the four level page
table that is the default after the pud has been introduced. Likewise
a normal 64 bit process will use three levels instead of four. Only
if a process runs out of the 4 tera bytes which can be addressed with
a three level page table the fourth level is dynamically added. Then
the process can use up to 8 peta byte.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/binfmt_elf32.c |   11 +++++
 arch/s390/kernel/traps.c        |    3 +
 arch/s390/mm/fault.c            |   40 +++++++++++++++++++++
 arch/s390/mm/init.c             |    5 +-
 arch/s390/mm/mmap.c             |   65 +++++++++++++++++++++++++++++++++++
 arch/s390/mm/pgtable.c          |   74 ++++++++++++++++++++++++++++++++++++++++
 include/asm-s390/elf.h          |    2 -
 include/asm-s390/mmu.h          |    1 
 include/asm-s390/mmu_context.h  |    8 ++--
 include/asm-s390/pgalloc.h      |   24 +++++++-----
 include/asm-s390/pgtable.h      |   38 ++++++++++++++++----
 include/asm-s390/processor.h    |   25 +------------
 include/asm-s390/tlb.h          |   10 +++++
 13 files changed, 258 insertions(+), 48 deletions(-)

Index: quilt-2.6/arch/s390/kernel/binfmt_elf32.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/binfmt_elf32.c
+++ quilt-2.6/arch/s390/kernel/binfmt_elf32.c
@@ -134,6 +134,7 @@ static inline int dump_task_fpu(struct t
 }
 
 #include <asm/processor.h>
+#include <asm/pgalloc.h>
 #include <linux/module.h>
 #include <linux/elfcore.h>
 #include <linux/binfmts.h>
@@ -183,6 +184,16 @@ struct elf_prpsinfo32
 #undef start_thread
 #define start_thread                    start_thread31 
 
+static inline void start_thread31(struct pt_regs *regs, unsigned long new_psw,
+				  unsigned long new_stackp)
+{
+	set_fs(USER_DS);
+	regs->psw.mask	= psw_user32_bits;
+	regs->psw.addr	= new_psw;
+	regs->gprs[15]	= new_stackp;
+	crst_table_downgrade(current->mm, 1UL << 31);
+}
+
 MODULE_DESCRIPTION("Binary format loader for compatibility with 32bit Linux for S390 binaries,"
                    " Copyright 2000 IBM Corporation"); 
 MODULE_AUTHOR("Gerhard Tonn <ton@de.ibm.com>");
Index: quilt-2.6/arch/s390/kernel/traps.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/traps.c
+++ quilt-2.6/arch/s390/kernel/traps.c
@@ -60,6 +60,7 @@ int sysctl_userprocess_debug = 0;
 extern pgm_check_handler_t do_protection_exception;
 extern pgm_check_handler_t do_dat_exception;
 extern pgm_check_handler_t do_monitor_call;
+extern pgm_check_handler_t do_asce_exception;
 
 #define stack_pointer ({ void **sp; asm("la %0,0(15)" : "=&d" (sp)); sp; })
 
@@ -730,7 +731,7 @@ void __init trap_init(void)
         pgm_check_table[0x12] = &translation_exception;
         pgm_check_table[0x13] = &special_op_exception;
 #ifdef CONFIG_64BIT
-        pgm_check_table[0x38] = &do_dat_exception;
+	pgm_check_table[0x38] = &do_asce_exception;
 	pgm_check_table[0x39] = &do_dat_exception;
 	pgm_check_table[0x3A] = &do_dat_exception;
         pgm_check_table[0x3B] = &do_dat_exception;
Index: quilt-2.6/arch/s390/mm/fault.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/fault.c
+++ quilt-2.6/arch/s390/mm/fault.c
@@ -32,6 +32,7 @@
 #include <asm/system.h>
 #include <asm/pgtable.h>
 #include <asm/s390_ext.h>
+#include <asm/mmu_context.h>
 
 #ifndef CONFIG_64BIT
 #define __FAIL_ADDR_MASK 0x7ffff000
@@ -444,6 +445,45 @@ void __kprobes do_dat_exception(struct p
 	do_exception(regs, error_code & 0xff, 0);
 }
 
+#ifdef CONFIG_64BIT
+void __kprobes do_asce_exception(struct pt_regs *regs, unsigned long error_code)
+{
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;
+	unsigned long address;
+	int space;
+
+	mm = current->mm;
+	address = S390_lowcore.trans_exc_code & __FAIL_ADDR_MASK;
+	space = check_space(current);
+
+	if (unlikely(space == 0 || in_atomic() || !mm))
+		goto no_context;
+
+	local_irq_enable();
+
+	down_read(&mm->mmap_sem);
+	vma = find_vma(mm, address);
+	up_read(&mm->mmap_sem);
+
+	if (vma) {
+		update_mm(mm, current);
+		return;
+	}
+
+	/* User mode accesses just cause a SIGSEGV */
+	if (regs->psw.mask & PSW_MASK_PSTATE) {
+		current->thread.prot_addr = address;
+		current->thread.trap_no = error_code;
+		do_sigsegv(regs, error_code, SEGV_MAPERR, address);
+		return;
+	}
+
+no_context:
+	do_no_context(regs, error_code, address);
+}
+#endif
+
 #ifdef CONFIG_PFAULT 
 /*
  * 'pfault' pseudo page faults routines.
Index: quilt-2.6/arch/s390/mm/init.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/init.c
+++ quilt-2.6/arch/s390/mm/init.c
@@ -112,8 +112,9 @@ void __init paging_init(void)
 	init_mm.pgd = swapper_pg_dir;
 	S390_lowcore.kernel_asce = __pa(init_mm.pgd) & PAGE_MASK;
 #ifdef CONFIG_64BIT
-	S390_lowcore.kernel_asce |= _ASCE_TYPE_REGION2 | _ASCE_TABLE_LENGTH;
-	pgd_type = _REGION2_ENTRY_EMPTY;
+	/* A three level page table (4TB) is enough for the kernel space. */
+	S390_lowcore.kernel_asce |= _ASCE_TYPE_REGION3 | _ASCE_TABLE_LENGTH;
+	pgd_type = _REGION3_ENTRY_EMPTY;
 #else
 	S390_lowcore.kernel_asce |= _ASCE_TABLE_LENGTH;
 	pgd_type = _SEGMENT_ENTRY_EMPTY;
Index: quilt-2.6/arch/s390/mm/mmap.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/mmap.c
+++ quilt-2.6/arch/s390/mm/mmap.c
@@ -27,6 +27,7 @@
 #include <linux/personality.h>
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <asm/pgalloc.h>
 
 /*
  * Top of mmap area (just below the process stack).
@@ -62,6 +63,8 @@ static inline int mmap_is_legacy(void)
 	    current->signal->rlim[RLIMIT_STACK].rlim_cur == RLIM_INFINITY;
 }
 
+#ifndef CONFIG_64BIT
+
 /*
  * This function, called very early during the creation of a new
  * process VM image, sets up which VM layout function to use:
@@ -84,3 +87,65 @@ void arch_pick_mmap_layout(struct mm_str
 }
 EXPORT_SYMBOL_GPL(arch_pick_mmap_layout);
 
+#else
+
+static unsigned long
+s390_get_unmapped_area(struct file *filp, unsigned long addr,
+		unsigned long len, unsigned long pgoff, unsigned long flags)
+{
+	struct mm_struct *mm = current->mm;
+	int rc;
+
+	addr = arch_get_unmapped_area(filp, addr, len, pgoff, flags);
+	if (addr & ~PAGE_MASK)
+		return addr;
+	if (unlikely(mm->context.asce_limit < addr + len)) {
+		rc = crst_table_upgrade(mm, addr + len);
+		if (rc)
+			return (unsigned long) rc;
+	}
+	return addr;
+}
+
+static unsigned long
+s390_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
+			  const unsigned long len, const unsigned long pgoff,
+			  const unsigned long flags)
+{
+	struct mm_struct *mm = current->mm;
+	unsigned long addr = addr0;
+	int rc;
+
+	addr = arch_get_unmapped_area_topdown(filp, addr, len, pgoff, flags);
+	if (addr & ~PAGE_MASK)
+		return addr;
+	if (unlikely(mm->context.asce_limit < addr + len)) {
+		rc = crst_table_upgrade(mm, addr + len);
+		if (rc)
+			return (unsigned long) rc;
+	}
+	return addr;
+}
+/*
+ * This function, called very early during the creation of a new
+ * process VM image, sets up which VM layout function to use:
+ */
+void arch_pick_mmap_layout(struct mm_struct *mm)
+{
+	/*
+	 * Fall back to the standard layout if the personality
+	 * bit is set, or if the expected stack growth is unlimited:
+	 */
+	if (mmap_is_legacy()) {
+		mm->mmap_base = TASK_UNMAPPED_BASE;
+		mm->get_unmapped_area = s390_get_unmapped_area;
+		mm->unmap_area = arch_unmap_area;
+	} else {
+		mm->mmap_base = mmap_base();
+		mm->get_unmapped_area = s390_get_unmapped_area_topdown;
+		mm->unmap_area = arch_unmap_area_topdown;
+	}
+}
+EXPORT_SYMBOL_GPL(arch_pick_mmap_layout);
+
+#endif
Index: quilt-2.6/arch/s390/mm/pgtable.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/pgtable.c
+++ quilt-2.6/arch/s390/mm/pgtable.c
@@ -23,6 +23,7 @@
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
+#include <asm/mmu_context.h>
 
 #ifndef CONFIG_64BIT
 #define ALLOC_ORDER	1
@@ -70,6 +71,79 @@ void crst_table_free(struct mm_struct *m
 	free_pages((unsigned long) table, ALLOC_ORDER);
 }
 
+#ifdef CONFIG_64BIT
+int crst_table_upgrade(struct mm_struct *mm, unsigned long limit)
+{
+	unsigned long *table, *pgd;
+	unsigned long entry;
+
+	BUG_ON(limit > (1UL << 53));
+repeat:
+	table = crst_table_alloc(mm, mm->context.noexec);
+	if (!table)
+		return -ENOMEM;
+	spin_lock(&mm->page_table_lock);
+	if (mm->context.asce_limit < limit) {
+		pgd = (unsigned long *) mm->pgd;
+		if (mm->context.asce_limit <= (1UL << 31)) {
+			entry = _REGION3_ENTRY_EMPTY;
+			mm->context.asce_limit = 1UL << 42;
+			mm->context.asce_bits = _ASCE_TABLE_LENGTH |
+						_ASCE_USER_BITS |
+						_ASCE_TYPE_REGION3;
+		} else {
+			entry = _REGION2_ENTRY_EMPTY;
+			mm->context.asce_limit = 1UL << 53;
+			mm->context.asce_bits = _ASCE_TABLE_LENGTH |
+						_ASCE_USER_BITS |
+						_ASCE_TYPE_REGION2;
+		}
+		crst_table_init(table, entry);
+		pgd_populate(mm, (pgd_t *) table, (pud_t *) pgd);
+		mm->pgd = (pgd_t *) table;
+		table = NULL;
+	}
+	spin_unlock(&mm->page_table_lock);
+	if (table)
+		crst_table_free(mm, table);
+	if (mm->context.asce_limit < limit)
+		goto repeat;
+	update_mm(mm, current);
+	return 0;
+}
+
+void crst_table_downgrade(struct mm_struct *mm, unsigned long limit)
+{
+	pgd_t *pgd;
+
+	if (mm->context.asce_limit <= limit)
+		return;
+	__tlb_flush_mm(mm);
+	while (mm->context.asce_limit > limit) {
+		pgd = mm->pgd;
+		switch (pgd_val(*pgd) & _REGION_ENTRY_TYPE_MASK) {
+		case _REGION_ENTRY_TYPE_R2:
+			mm->context.asce_limit = 1UL << 42;
+			mm->context.asce_bits = _ASCE_TABLE_LENGTH |
+						_ASCE_USER_BITS |
+						_ASCE_TYPE_REGION3;
+			break;
+		case _REGION_ENTRY_TYPE_R3:
+			mm->context.asce_limit = 1UL << 31;
+			mm->context.asce_bits = _ASCE_TABLE_LENGTH |
+						_ASCE_USER_BITS |
+						_ASCE_TYPE_SEGMENT;
+			break;
+		default:
+			BUG();
+		}
+		mm->pgd = (pgd_t *) (pgd_val(*pgd) & _REGION_ENTRY_ORIGIN);
+		crst_table_free(mm, (unsigned long *) pgd);
+	}
+	update_mm(mm, current);
+}
+#endif
+
 /*
  * page table entry allocation/free routines.
  */
Index: quilt-2.6/include/asm-s390/elf.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/elf.h
+++ quilt-2.6/include/asm-s390/elf.h
@@ -138,7 +138,7 @@ typedef s390_regs elf_gregset_t;
    use of this is to invoke "./ld.so someprog" to test out a new version of
    the loader.  We need to make sure that it is out of the way of the program
    that it will "exec", and that there is sufficient room for the brk.  */
-#define ELF_ET_DYN_BASE		(TASK_SIZE / 3 * 2)
+#define ELF_ET_DYN_BASE		(STACK_TOP / 3 * 2)
 
 /* Wow, the "main" arch needs arch dependent functions too.. :) */
 
Index: quilt-2.6/include/asm-s390/mmu_context.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/mmu_context.h
+++ quilt-2.6/include/asm-s390/mmu_context.h
@@ -18,9 +18,11 @@ static inline int init_new_context(struc
 {
 	mm->context.asce_bits = _ASCE_TABLE_LENGTH | _ASCE_USER_BITS;
 #ifdef CONFIG_64BIT
-	mm->context.asce_bits |= _ASCE_TYPE_REGION2;
+	mm->context.asce_bits |= _ASCE_TYPE_REGION3;
 #endif
 	mm->context.noexec = s390_noexec;
+	mm->context.asce_limit = STACK_TOP_MAX;
+	crst_table_init((unsigned long *) mm->pgd, pgd_entry_type(mm));
 	return 0;
 }
 
@@ -47,13 +49,12 @@ static inline void update_mm(struct mm_s
 		/* Load home space page table origin. */
 		asm volatile(LCTL_OPCODE" 13,13,%0"
 			     : : "m" (S390_lowcore.user_asce) );
+	set_fs(current->thread.mm_segment);
 }
 
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 			     struct task_struct *tsk)
 {
-	if (unlikely(prev == next))
-		return;
 	cpu_set(smp_processor_id(), next->cpu_vm_mask);
 	update_mm(next, tsk);
 }
@@ -65,7 +66,6 @@ static inline void activate_mm(struct mm
                                struct mm_struct *next)
 {
         switch_mm(prev, next, current);
-	set_fs(current->thread.mm_segment);
 }
 
 #endif /* __S390_MMU_CONTEXT_H */
Index: quilt-2.6/include/asm-s390/mmu.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/mmu.h
+++ quilt-2.6/include/asm-s390/mmu.h
@@ -5,6 +5,7 @@ typedef struct {
 	struct list_head crst_list;
 	struct list_head pgtable_list;
 	unsigned long asce_bits;
+	unsigned long asce_limit;
 	int noexec;
 } mm_context_t;
 
Index: quilt-2.6/include/asm-s390/pgalloc.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/pgalloc.h
+++ quilt-2.6/include/asm-s390/pgalloc.h
@@ -73,9 +73,16 @@ static inline unsigned long pgd_entry_ty
 
 static inline unsigned long pgd_entry_type(struct mm_struct *mm)
 {
+	if (mm->context.asce_limit <= (1UL << 31))
+		return _SEGMENT_ENTRY_EMPTY;
+	if (mm->context.asce_limit <= (1UL << 42))
+		return _REGION3_ENTRY_EMPTY;
 	return _REGION2_ENTRY_EMPTY;
 }
 
+int crst_table_upgrade(struct mm_struct *, unsigned long limit);
+void crst_table_downgrade(struct mm_struct *, unsigned long limit);
+
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	unsigned long *table = crst_table_alloc(mm, mm->context.noexec);
@@ -102,12 +109,12 @@ static inline void pgd_populate_kernel(s
 
 static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pud_t *pud)
 {
-	pgd_t *shadow_pgd = get_shadow_table(pgd);
-	pud_t *shadow_pud = get_shadow_table(pud);
-
-	if (shadow_pgd && shadow_pud)
-		pgd_populate_kernel(mm, shadow_pgd, shadow_pud);
 	pgd_populate_kernel(mm, pgd, pud);
+	if (mm->context.noexec) {
+		pgd = get_shadow_table(pgd);
+		pud = get_shadow_table(pud);
+		pgd_populate_kernel(mm, pgd, pud);
+	}
 }
 
 static inline void pud_populate_kernel(struct mm_struct *mm,
@@ -130,14 +137,9 @@ static inline void pud_populate(struct m
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	unsigned long *crst;
-
 	INIT_LIST_HEAD(&mm->context.crst_list);
 	INIT_LIST_HEAD(&mm->context.pgtable_list);
-	crst = crst_table_alloc(mm, s390_noexec);
-	if (crst)
-		crst_table_init(crst, pgd_entry_type(mm));
-	return (pgd_t *) crst;
+	return (pgd_t *) crst_table_alloc(mm, s390_noexec);
 }
 #define pgd_free(mm, pgd) crst_table_free(mm, (unsigned long *) pgd)
 
Index: quilt-2.6/include/asm-s390/pgtable.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/pgtable.h
+++ quilt-2.6/include/asm-s390/pgtable.h
@@ -421,36 +421,54 @@ static inline int pud_bad(pud_t pud)	 { 
 
 static inline int pgd_present(pgd_t pgd)
 {
+	if ((pgd_val(pgd) & _REGION_ENTRY_TYPE_MASK) < _REGION_ENTRY_TYPE_R2)
+		return 1;
 	return (pgd_val(pgd) & _REGION_ENTRY_ORIGIN) != 0UL;
 }
 
 static inline int pgd_none(pgd_t pgd)
 {
+	if ((pgd_val(pgd) & _REGION_ENTRY_TYPE_MASK) < _REGION_ENTRY_TYPE_R2)
+		return 0;
 	return (pgd_val(pgd) & _REGION_ENTRY_INV) != 0UL;
 }
 
 static inline int pgd_bad(pgd_t pgd)
 {
+	/*
+	 * With dynamic page table levels the pgd can be a region table
+	 * entry or a segment table entry. Check for the bit that are
+	 * invalid for either table entry.
+	 */
 	unsigned long mask =
-		~_REGION_ENTRY_ORIGIN & ~_REGION_ENTRY_INV &
+		~_SEGMENT_ENTRY_ORIGIN & ~_REGION_ENTRY_INV &
 		~_REGION_ENTRY_TYPE_MASK & ~_REGION_ENTRY_LENGTH;
 	return (pgd_val(pgd) & mask) != 0;
 }
 
 static inline int pud_present(pud_t pud)
 {
+	if ((pud_val(pud) & _REGION_ENTRY_TYPE_MASK) < _REGION_ENTRY_TYPE_R3)
+		return 1;
 	return (pud_val(pud) & _REGION_ENTRY_ORIGIN) != 0UL;
 }
 
 static inline int pud_none(pud_t pud)
 {
+	if ((pud_val(pud) & _REGION_ENTRY_TYPE_MASK) < _REGION_ENTRY_TYPE_R3)
+		return 0;
 	return (pud_val(pud) & _REGION_ENTRY_INV) != 0UL;
 }
 
 static inline int pud_bad(pud_t pud)
 {
+	/*
+	 * With dynamic page table levels the pud can be a region table
+	 * entry or a segment table entry. Check for the bit that are
+	 * invalid for either table entry.
+	 */
 	unsigned long mask =
-		~_REGION_ENTRY_ORIGIN & ~_REGION_ENTRY_INV &
+		~_SEGMENT_ENTRY_ORIGIN & ~_REGION_ENTRY_INV &
 		~_REGION_ENTRY_TYPE_MASK & ~_REGION_ENTRY_LENGTH;
 	return (pud_val(pud) & mask) != 0;
 }
@@ -535,7 +553,8 @@ static inline int pte_young(pte_t pte)
 
 static inline void pgd_clear_kernel(pgd_t * pgd)
 {
-	pgd_val(*pgd) = _REGION2_ENTRY_EMPTY;
+	if ((pgd_val(*pgd) & _REGION_ENTRY_TYPE_MASK) == _REGION_ENTRY_TYPE_R2)
+		pgd_val(*pgd) = _REGION2_ENTRY_EMPTY;
 }
 
 static inline void pgd_clear(pgd_t * pgd)
@@ -549,10 +568,11 @@ static inline void pgd_clear(pgd_t * pgd
 
 static inline void pud_clear_kernel(pud_t *pud)
 {
-	pud_val(*pud) = _REGION3_ENTRY_EMPTY;
+	if ((pud_val(*pud) & _REGION_ENTRY_TYPE_MASK) == _REGION_ENTRY_TYPE_R3)
+		pud_val(*pud) = _REGION3_ENTRY_EMPTY;
 }
 
-static inline void pud_clear(pud_t * pud)
+static inline void pud_clear(pud_t *pud)
 {
 	pud_t *shadow = get_shadow_table(pud);
 
@@ -841,13 +861,17 @@ static inline pte_t mk_pte(struct page *
 
 static inline pud_t *pud_offset(pgd_t *pgd, unsigned long address)
 {
-	pud_t *pud = (pud_t *) pgd_deref(*pgd);
+	pud_t *pud = (pud_t *) pgd;
+	if ((pgd_val(*pgd) & _REGION_ENTRY_TYPE_MASK) == _REGION_ENTRY_TYPE_R2)
+		pud = (pud_t *) pgd_deref(*pgd);
 	return pud  + pud_index(address);
 }
 
 static inline pmd_t *pmd_offset(pud_t *pud, unsigned long address)
 {
-	pmd_t *pmd = (pmd_t *) pud_deref(*pud);
+	pmd_t *pmd = (pmd_t *) pud;
+	if ((pud_val(*pud) & _REGION_ENTRY_TYPE_MASK) == _REGION_ENTRY_TYPE_R3)
+		pmd = (pmd_t *) pud_deref(*pud);
 	return pmd + pmd_index(address);
 }
 
Index: quilt-2.6/include/asm-s390/processor.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/processor.h
+++ quilt-2.6/include/asm-s390/processor.h
@@ -81,11 +81,12 @@ extern int get_cpu_capability(unsigned i
 
 #ifndef __s390x__
 #define STACK_TOP		(1UL << 31)
+#define STACK_TOP_MAX		(1UL << 31)
 #else /* __s390x__ */
-#define STACK_TOP		(1UL << (test_thread_flag(TIF_31BIT) ? 31:53))
+#define STACK_TOP		(1UL << (test_thread_flag(TIF_31BIT) ? 31:42))
+#define STACK_TOP_MAX		(1UL << 42)
 #endif /* __s390x__ */
 
-#define STACK_TOP_MAX		STACK_TOP
 
 #endif
 
@@ -142,8 +143,6 @@ struct stack_frame {
 /*
  * Do necessary setup to start up a new thread.
  */
-#ifndef __s390x__
-
 #define start_thread(regs, new_psw, new_stackp) do {            \
 	set_fs(USER_DS);					\
 	regs->psw.mask	= psw_user_bits;			\
@@ -151,24 +150,6 @@ struct stack_frame {
         regs->gprs[15]  = new_stackp ;                          \
 } while (0)
 
-#else /* __s390x__ */
-
-#define start_thread(regs, new_psw, new_stackp) do {            \
-	set_fs(USER_DS);					\
-	regs->psw.mask	= psw_user_bits;			\
-        regs->psw.addr  = new_psw;                              \
-        regs->gprs[15]  = new_stackp;                           \
-} while (0)
-
-#define start_thread31(regs, new_psw, new_stackp) do {          \
-	set_fs(USER_DS);					\
-	regs->psw.mask	= psw_user32_bits;			\
-        regs->psw.addr  = new_psw;                              \
-        regs->gprs[15]  = new_stackp;                           \
-} while (0)
-
-#endif /* __s390x__ */
-
 /* Forward declaration, a strange C thing */
 struct task_struct;
 struct mm_struct;
Index: quilt-2.6/include/asm-s390/tlb.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/tlb.h
+++ quilt-2.6/include/asm-s390/tlb.h
@@ -109,10 +109,15 @@ static inline void pte_free_tlb(struct m
 /*
  * pmd_free_tlb frees a pmd table and clears the CRSTE for the
  * segment table entry from the tlb.
+ * If the mm uses a two level page table the single pmd is freed
+ * as the pgd. pmd_free_tlb checks the asce_limit against 2GB
+ * to avoid the double free of the pmd in this case.
  */
 static inline void pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
 {
 #ifdef __s390x__
+	if (tlb->mm->context.asce_limit <= (1UL << 31))
+		return;
 	if (!tlb->fullmm) {
 		tlb->array[--tlb->nr_pxds] = pmd;
 		if (tlb->nr_ptes >= tlb->nr_pxds)
@@ -125,10 +130,15 @@ static inline void pmd_free_tlb(struct m
 /*
  * pud_free_tlb frees a pud table and clears the CRSTE for the
  * region third table entry from the tlb.
+ * If the mm uses a three level page table the single pud is freed
+ * as the pgd. pud_free_tlb checks the asce_limit against 4TB
+ * to avoid the double free of the pud in this case.
  */
 static inline void pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
 {
 #ifdef __s390x__
+	if (tlb->mm->context.asce_limit <= (1UL << 42))
+		return;
 	if (!tlb->fullmm) {
 		tlb->array[--tlb->nr_pxds] = pud;
 		if (tlb->nr_ptes >= tlb->nr_pxds)

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
