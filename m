Return-Path: <linux-kernel-owner+w=401wt.eu-S935263AbXJSRY2@vger.kernel.org>
Message-Id: <20071019171945.647777819@de.ibm.com>
References: <20071019171857.430999834@de.ibm.com>
Date: Fri, 19 Oct 2007 19:19:06 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 09/10] Cleanup page table definitions.
Content-Disposition: inline; filename=009-mm-pgdefs.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

- De-confuse the defines for the address-space-control-elements
  and the segment/region table entries.
- Create out of line functions for page table allocation / freeing.
- Simplify get_shadow_xxx functions.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/mm/Makefile          |    2 
 arch/s390/mm/init.c            |   26 +---
 arch/s390/mm/pgtable.c         |   96 +++++++++++++++++
 arch/s390/mm/vmem.c            |   23 +---
 include/asm-s390/mmu_context.h |   50 ++++-----
 include/asm-s390/pgalloc.h     |  204 +++++++++++---------------------------
 include/asm-s390/pgtable.h     |  219 +++++++++++++++++------------------------
 include/asm-s390/processor.h   |    6 -
 include/asm-s390/tlbflush.h    |    2 
 9 files changed, 296 insertions(+), 332 deletions(-)

Index: quilt-2.6/arch/s390/mm/init.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/init.c
+++ quilt-2.6/arch/s390/mm/init.c
@@ -103,32 +103,26 @@ static void __init setup_ro_region(void)
  */
 void __init paging_init(void)
 {
-	pgd_t *pg_dir;
-	int i;
-	unsigned long pgdir_k;
 	static const int ssm_mask = 0x04000000L;
 	unsigned long max_zone_pfns[MAX_NR_ZONES];
 
-	pg_dir = swapper_pg_dir;
-	
+	init_mm.pgd = swapper_pg_dir;
+	S390_lowcore.kernel_asce = __pa(init_mm.pgd) & PAGE_MASK;
 #ifdef CONFIG_64BIT
-	pgdir_k = (__pa(swapper_pg_dir) & PAGE_MASK) | _KERN_REGION_TABLE;
-	for (i = 0; i < PTRS_PER_PGD; i++)
-		pgd_clear_kernel(pg_dir + i);
+	S390_lowcore.kernel_asce |= _ASCE_TYPE_REGION3 | _ASCE_TABLE_LENGTH;
+	pgd_val(*((pgd_t *) init_mm.pgd)) = _REGION3_ENTRY_EMPTY;
 #else
-	pgdir_k = (__pa(swapper_pg_dir) & PAGE_MASK) | _KERNSEG_TABLE;
-	for (i = 0; i < PTRS_PER_PGD; i++)
-		pmd_clear_kernel((pmd_t *)(pg_dir + i));
+	S390_lowcore.kernel_asce |= _ASCE_TABLE_LENGTH;
+	pmd_val(*((pmd_t *) init_mm.pgd)) = _SEGMENT_ENTRY_EMPTY;
 #endif
+	memcpy(init_mm.pgd + 1, init_mm.pgd, (PTRS_PER_PGD - 1)*sizeof(pgd_t));
 	vmem_map_init();
 	setup_ro_region();
 
-	S390_lowcore.kernel_asce = pgdir_k;
-
         /* enable virtual mapping in kernel mode */
-	__ctl_load(pgdir_k, 1, 1);
-	__ctl_load(pgdir_k, 7, 7);
-	__ctl_load(pgdir_k, 13, 13);
+	__ctl_load(S390_lowcore.kernel_asce, 1, 1);
+	__ctl_load(S390_lowcore.kernel_asce, 7, 7);
+	__ctl_load(S390_lowcore.kernel_asce, 13, 13);
 	__raw_local_irq_ssm(ssm_mask);
 
 	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
Index: quilt-2.6/arch/s390/mm/Makefile
===================================================================
--- quilt-2.6.orig/arch/s390/mm/Makefile
+++ quilt-2.6/arch/s390/mm/Makefile
@@ -2,6 +2,6 @@
 # Makefile for the linux s390-specific parts of the memory manager.
 #
 
-obj-y	 := init.o fault.o extmem.o mmap.o vmem.o
+obj-y	 := init.o fault.o extmem.o mmap.o vmem.o pgtable.o
 obj-$(CONFIG_CMM) += cmm.o
 
Index: quilt-2.6/arch/s390/mm/pgtable.c
===================================================================
--- /dev/null
+++ quilt-2.6/arch/s390/mm/pgtable.c
@@ -0,0 +1,96 @@
+/*
+ *  arch/s390/mm/pgtable.c
+ *
+ *    Copyright IBM Corp. 2007
+ *    Author(s): Martin Schwidefsky <schwidefsky@de.ibm.com>
+ */
+
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/mm.h>
+#include <linux/swap.h>
+#include <linux/smp.h>
+#include <linux/highmem.h>
+#include <linux/slab.h>
+#include <linux/pagemap.h>
+#include <linux/spinlock.h>
+#include <linux/module.h>
+#include <linux/quicklist.h>
+
+#include <asm/system.h>
+#include <asm/pgtable.h>
+#include <asm/pgalloc.h>
+#include <asm/tlb.h>
+#include <asm/tlbflush.h>
+
+#ifndef CONFIG_64BIT
+#define ALLOC_ORDER	1
+#else
+#define ALLOC_ORDER	2
+#endif
+
+unsigned long *crst_table_alloc(struct mm_struct *mm, int noexec)
+{
+	struct page *page = alloc_pages(GFP_KERNEL, ALLOC_ORDER);
+
+	if (!page)
+		return NULL;
+	page->index = 0;
+	if (noexec) {
+		struct page *shadow = alloc_pages(GFP_KERNEL, ALLOC_ORDER);
+		if (!shadow) {
+			__free_pages(page, ALLOC_ORDER);
+			return NULL;
+		}
+		page->index = page_to_phys(shadow);
+	}
+	return (unsigned long *) page_to_phys(page);
+}
+
+void crst_table_free(unsigned long *table)
+{
+	unsigned long *shadow = get_shadow_table(table);
+
+	if (shadow)
+		free_pages((unsigned long) shadow, ALLOC_ORDER);
+	free_pages((unsigned long) table, ALLOC_ORDER);
+}
+
+/*
+ * page table entry allocation/free routines.
+ */
+unsigned long *page_table_alloc(int noexec)
+{
+	struct page *page = alloc_page(GFP_KERNEL);
+	unsigned long *table;
+
+	if (!page)
+		return NULL;
+	page->index = 0;
+	if (noexec) {
+		struct page *shadow = alloc_page(GFP_KERNEL);
+		if (!shadow) {
+			__free_page(page);
+			return NULL;
+		}
+		table = (unsigned long *) page_to_phys(shadow);
+		table[0] = _PAGE_TYPE_EMPTY;
+		memcpy(table + 1, table, PAGE_SIZE - sizeof(unsigned long));
+		page->index = (addr_t) table;
+	}
+	table = (unsigned long *) page_to_phys(page);
+	table[0] = _PAGE_TYPE_EMPTY;
+	memcpy(table + 1, table, PAGE_SIZE - sizeof(unsigned long));
+	return table;
+}
+
+void page_table_free(unsigned long *table)
+{
+	unsigned long *shadow = get_shadow_pte(table);
+
+	if (shadow)
+		free_page((unsigned long) shadow);
+	free_page((unsigned long) table);
+
+}
Index: quilt-2.6/arch/s390/mm/vmem.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/vmem.c
+++ quilt-2.6/arch/s390/mm/vmem.c
@@ -75,29 +75,24 @@ static void __init_refok *vmem_alloc_pag
 
 static inline pmd_t *vmem_pmd_alloc(void)
 {
-	pmd_t *pmd;
-	int i;
-
-	pmd = vmem_alloc_pages(PMD_ALLOC_ORDER);
+	pmd_t *pmd = NULL;
+#ifdef CONFIG_64BIT
+	pmd = vmem_alloc_pages(2);
 	if (!pmd)
 		return NULL;
-	for (i = 0; i < PTRS_PER_PMD; i++)
-		pmd_clear_kernel(pmd + i);
+	pmd_clear_kernel(pmd);
+	memcpy(pmd + 1, pmd, (PTRS_PER_PMD - 1)*sizeof(pmd_t));
+#endif
 	return pmd;
 }
 
 static inline pte_t *vmem_pte_alloc(void)
 {
-	pte_t *pte;
-	pte_t empty_pte;
-	int i;
-
-	pte = vmem_alloc_pages(PTE_ALLOC_ORDER);
+	pte_t *pte = vmem_alloc_pages(1);
 	if (!pte)
 		return NULL;
-	pte_val(empty_pte) = _PAGE_TYPE_EMPTY;
-	for (i = 0; i < PTRS_PER_PTE; i++)
-		pte[i] = empty_pte;
+	pte_val(*pte) = _PAGE_TYPE_EMPTY;
+	memcpy(pte + 1, pte, (PTRS_PER_PTE - 1)*sizeof(pte_t));
 	return pte;
 }
 
Index: quilt-2.6/include/asm-s390/mmu_context.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/mmu_context.h
+++ quilt-2.6/include/asm-s390/mmu_context.h
@@ -21,45 +21,43 @@
 
 #ifndef __s390x__
 #define LCTL_OPCODE "lctl"
-#define PGTABLE_BITS (_SEGMENT_TABLE|USER_STD_MASK)
 #else
 #define LCTL_OPCODE "lctlg"
-#define PGTABLE_BITS (_REGION_TABLE|USER_STD_MASK)
 #endif
 
-static inline void enter_lazy_tlb(struct mm_struct *mm,
-                                  struct task_struct *tsk)
+static inline void update_mm(struct mm_struct *mm, struct task_struct *tsk)
 {
+	pgd_t *pgd = mm->pgd;
+	unsigned long asce_bits;
+
+	/* Calculate asce bits from the first pgd table entry. */
+	asce_bits = _ASCE_TABLE_LENGTH | _ASCE_USER_BITS;
+#ifdef CONFIG_64BIT
+	asce_bits |= _ASCE_TYPE_REGION3;
+#endif
+	S390_lowcore.user_asce = asce_bits | __pa(pgd);
+	if (switch_amode) {
+		/* Load primary space page table origin. */
+		pgd_t *shadow_pgd = get_shadow_table(pgd) ? : pgd;
+		S390_lowcore.user_exec_asce = asce_bits | __pa(shadow_pgd);
+		asm volatile(LCTL_OPCODE" 1,1,%0\n"
+			     : : "m" (S390_lowcore.user_exec_asce) );
+	} else
+		/* Load home space page table origin. */
+		asm volatile(LCTL_OPCODE" 13,13,%0"
+			     : : "m" (S390_lowcore.user_asce) );
 }
 
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 			     struct task_struct *tsk)
 {
-	pgd_t *shadow_pgd = get_shadow_pgd(next->pgd);
-
-	if (prev != next) {
-		S390_lowcore.user_asce = (__pa(next->pgd) & PAGE_MASK) |
-					 PGTABLE_BITS;
-		if (shadow_pgd) {
-			/* Load primary/secondary space page table origin. */
-			S390_lowcore.user_exec_asce =
-				(__pa(shadow_pgd) & PAGE_MASK) | PGTABLE_BITS;
-			asm volatile(LCTL_OPCODE" 1,1,%0\n"
-				     LCTL_OPCODE" 7,7,%1"
-				     : : "m" (S390_lowcore.user_exec_asce),
-					 "m" (S390_lowcore.user_asce) );
-		} else if (switch_amode) {
-			/* Load primary space page table origin. */
-			asm volatile(LCTL_OPCODE" 1,1,%0"
-				     : : "m" (S390_lowcore.user_asce) );
-		} else
-			/* Load home space page table origin. */
-			asm volatile(LCTL_OPCODE" 13,13,%0"
-				     : : "m" (S390_lowcore.user_asce) );
-	}
+	if (unlikely(prev == next))
+		return;
 	cpu_set(smp_processor_id(), next->cpu_vm_mask);
+	update_mm(next, tsk);
 }
 
+#define enter_lazy_tlb(mm,tsk)	do { } while (0)
 #define deactivate_mm(tsk,mm)	do { } while (0)
 
 static inline void activate_mm(struct mm_struct *prev,
Index: quilt-2.6/include/asm-s390/pgalloc.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/pgalloc.h
+++ quilt-2.6/include/asm-s390/pgalloc.h
@@ -19,114 +19,62 @@
 
 #define check_pgt_cache()	do {} while (0)
 
-/*
- * Page allocation orders.
- */
-#ifndef __s390x__
-# define PTE_ALLOC_ORDER	0
-# define PMD_ALLOC_ORDER	0
-# define PGD_ALLOC_ORDER	1
-#else /* __s390x__ */
-# define PTE_ALLOC_ORDER	0
-# define PMD_ALLOC_ORDER	2
-# define PGD_ALLOC_ORDER	2
-#endif /* __s390x__ */
+unsigned long *crst_table_alloc(struct mm_struct *, int);
+void crst_table_free(unsigned long *);
 
-/*
- * Allocate and free page tables. The xxx_kernel() versions are
- * used to allocate a kernel page table - this turns on ASN bits
- * if any.
- */
+unsigned long *page_table_alloc(int);
+void page_table_free(unsigned long *);
 
-static inline pgd_t *pgd_alloc(struct mm_struct *mm)
+static inline void crst_table_init(unsigned long *crst, unsigned long entry)
 {
-	pgd_t *pgd = (pgd_t *) __get_free_pages(GFP_KERNEL, PGD_ALLOC_ORDER);
-	int i;
-
-	if (!pgd)
-		return NULL;
-	if (s390_noexec) {
-		pgd_t *shadow_pgd = (pgd_t *)
-			__get_free_pages(GFP_KERNEL, PGD_ALLOC_ORDER);
-		struct page *page = virt_to_page(pgd);
-
-		if (!shadow_pgd) {
-			free_pages((unsigned long) pgd, PGD_ALLOC_ORDER);
-			return NULL;
-		}
-		page->lru.next = (void *) shadow_pgd;
+	crst[0] = entry;
+	memcpy(crst + 1, crst, sizeof(unsigned long)*2047);
+	crst = get_shadow_table(crst);
+	if (crst) {
+		crst[0] = entry;
+		memcpy(crst + 1, crst, sizeof(unsigned long)*2047);
 	}
-	for (i = 0; i < PTRS_PER_PGD; i++)
-#ifndef __s390x__
-		pmd_clear(pmd_offset(pgd + i, i*PGDIR_SIZE));
-#else
-		pgd_clear(pgd + i);
-#endif
-	return pgd;
 }
 
-static inline void pgd_free(pgd_t *pgd)
-{
-	pgd_t *shadow_pgd = get_shadow_pgd(pgd);
+#ifndef __s390x__
 
-	if (shadow_pgd)
-		free_pages((unsigned long) shadow_pgd, PGD_ALLOC_ORDER);
-	free_pages((unsigned long) pgd, PGD_ALLOC_ORDER);
+static inline unsigned long pgd_entry_type(struct mm_struct *mm)
+{
+	return _SEGMENT_ENTRY_EMPTY;
 }
 
-#ifndef __s390x__
-/*
- * page middle directory allocation/free routines.
- * We use pmd cache only on s390x, so these are dummy routines. This
- * code never triggers because the pgd will always be present.
- */
-#define pmd_alloc_one(mm,address)       ({ BUG(); ((pmd_t *)2); })
-#define pmd_free(x)                     do { } while (0)
-#define pgd_populate(mm, pmd, pte)      BUG()
+#define pmd_alloc_one(mm,address)		({ BUG(); ((pmd_t *)2); })
+#define pmd_free(x)				do { } while (0)
+
+#define pgd_populate(mm, pmd, pte)		BUG()
 #define pgd_populate_kernel(mm, pmd, pte)	BUG()
+
 #else /* __s390x__ */
-static inline pmd_t * pmd_alloc_one(struct mm_struct *mm, unsigned long vmaddr)
-{
-	pmd_t *pmd = (pmd_t *) __get_free_pages(GFP_KERNEL, PMD_ALLOC_ORDER);
-	int i;
 
-	if (!pmd)
-		return NULL;
-	if (s390_noexec) {
-		pmd_t *shadow_pmd = (pmd_t *)
-			__get_free_pages(GFP_KERNEL, PMD_ALLOC_ORDER);
-		struct page *page = virt_to_page(pmd);
-
-		if (!shadow_pmd) {
-			free_pages((unsigned long) pmd, PMD_ALLOC_ORDER);
-			return NULL;
-		}
-		page->lru.next = (void *) shadow_pmd;
-	}
-	for (i=0; i < PTRS_PER_PMD; i++)
-		pmd_clear(pmd + i);
-	return pmd;
+static inline unsigned long pgd_entry_type(struct mm_struct *mm)
+{
+	return _REGION3_ENTRY_EMPTY;
 }
 
-static inline void pmd_free (pmd_t *pmd)
+static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long vmaddr)
 {
-	pmd_t *shadow_pmd = get_shadow_pmd(pmd);
-
-	if (shadow_pmd)
-		free_pages((unsigned long) shadow_pmd, PMD_ALLOC_ORDER);
-	free_pages((unsigned long) pmd, PMD_ALLOC_ORDER);
+	unsigned long *crst = crst_table_alloc(mm, s390_noexec);
+	if (crst)
+		crst_table_init(crst, _SEGMENT_ENTRY_EMPTY);
+	return (pmd_t *) crst;
 }
+#define pmd_free(pmd) crst_table_free((unsigned long *) pmd)
 
-static inline void
-pgd_populate_kernel(struct mm_struct *mm, pgd_t *pgd, pmd_t *pmd)
+static inline void pgd_populate_kernel(struct mm_struct *mm,
+				       pgd_t *pgd, pmd_t *pmd)
 {
-	pgd_val(*pgd) = _PGD_ENTRY | __pa(pmd);
+	pgd_val(*pgd) = _REGION3_ENTRY | __pa(pmd);
 }
 
 static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pmd_t *pmd)
 {
-	pgd_t *shadow_pgd = get_shadow_pgd(pgd);
-	pmd_t *shadow_pmd = get_shadow_pmd(pmd);
+	pgd_t *shadow_pgd = get_shadow_table(pgd);
+	pmd_t *shadow_pmd = get_shadow_table(pmd);
 
 	if (shadow_pgd && shadow_pmd)
 		pgd_populate_kernel(mm, shadow_pgd, shadow_pmd);
@@ -135,17 +83,26 @@ static inline void pgd_populate(struct m
 
 #endif /* __s390x__ */
 
+static inline pgd_t *pgd_alloc(struct mm_struct *mm)
+{
+	unsigned long *crst = crst_table_alloc(mm, s390_noexec);
+	if (crst)
+		crst_table_init(crst, pgd_entry_type(mm));
+	return (pgd_t *) crst;
+}
+#define pgd_free(pgd) crst_table_free((unsigned long *) pgd)
+
 static inline void 
 pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd, pte_t *pte)
 {
 #ifndef __s390x__
-	pmd_val(pmd[0]) = _PAGE_TABLE + __pa(pte);
-	pmd_val(pmd[1]) = _PAGE_TABLE + __pa(pte+256);
-	pmd_val(pmd[2]) = _PAGE_TABLE + __pa(pte+512);
-	pmd_val(pmd[3]) = _PAGE_TABLE + __pa(pte+768);
+	pmd_val(pmd[0]) = _SEGMENT_ENTRY + __pa(pte);
+	pmd_val(pmd[1]) = _SEGMENT_ENTRY + __pa(pte+256);
+	pmd_val(pmd[2]) = _SEGMENT_ENTRY + __pa(pte+512);
+	pmd_val(pmd[3]) = _SEGMENT_ENTRY + __pa(pte+768);
 #else /* __s390x__ */
-	pmd_val(*pmd) = _PMD_ENTRY + __pa(pte);
-	pmd_val1(*pmd) = _PMD_ENTRY + __pa(pte+256);
+	pmd_val(*pmd) = _SEGMENT_ENTRY + __pa(pte);
+	pmd_val1(*pmd) = _SEGMENT_ENTRY + __pa(pte+256);
 #endif /* __s390x__ */
 }
 
@@ -153,7 +110,7 @@ static inline void
 pmd_populate(struct mm_struct *mm, pmd_t *pmd, struct page *page)
 {
 	pte_t *pte = (pte_t *)page_to_phys(page);
-	pmd_t *shadow_pmd = get_shadow_pmd(pmd);
+	pmd_t *shadow_pmd = get_shadow_table(pmd);
 	pte_t *shadow_pte = get_shadow_pte(pte);
 
 	pmd_populate_kernel(mm, pmd, pte);
@@ -164,57 +121,14 @@ pmd_populate(struct mm_struct *mm, pmd_t
 /*
  * page table entry allocation/free routines.
  */
-static inline pte_t *
-pte_alloc_one_kernel(struct mm_struct *mm, unsigned long vmaddr)
-{
-	pte_t *pte = (pte_t *) __get_free_page(GFP_KERNEL|__GFP_REPEAT);
-	int i;
-
-	if (!pte)
-		return NULL;
-	if (s390_noexec) {
-		pte_t *shadow_pte = (pte_t *)
-			__get_free_page(GFP_KERNEL|__GFP_REPEAT);
-		struct page *page = virt_to_page(pte);
-
-		if (!shadow_pte) {
-			free_page((unsigned long) pte);
-			return NULL;
-		}
-		page->lru.next = (void *) shadow_pte;
-	}
-	for (i=0; i < PTRS_PER_PTE; i++) {
-		pte_clear(mm, vmaddr, pte + i);
-		vmaddr += PAGE_SIZE;
-	}
-	return pte;
-}
-
-static inline struct page *
-pte_alloc_one(struct mm_struct *mm, unsigned long vmaddr)
-{
-	pte_t *pte = pte_alloc_one_kernel(mm, vmaddr);
-	if (pte)
-		return virt_to_page(pte);
-	return NULL;
-}
-
-static inline void pte_free_kernel(pte_t *pte)
-{
-	pte_t *shadow_pte = get_shadow_pte(pte);
-
-	if (shadow_pte)
-		free_page((unsigned long) shadow_pte);
-	free_page((unsigned long) pte);
-}
-
-static inline void pte_free(struct page *pte)
-{
-	struct page *shadow_page = get_shadow_page(pte);
-
-	if (shadow_page)
-		__free_page(shadow_page);
-	__free_page(pte);
-}
+#define pte_alloc_one_kernel(mm, vmaddr) \
+	((pte_t *) page_table_alloc(s390_noexec))
+#define pte_alloc_one(mm, vmaddr) \
+	virt_to_page(page_table_alloc(s390_noexec))
+
+#define pte_free_kernel(pte) \
+	page_table_free((unsigned long *) pte)
+#define pte_free(pte) \
+	page_table_free((unsigned long *) page_to_phys((struct page *) pte))
 
 #endif /* _S390_PGALLOC_H */
Index: quilt-2.6/include/asm-s390/pgtable.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/pgtable.h
+++ quilt-2.6/include/asm-s390/pgtable.h
@@ -35,9 +35,6 @@
 #include <asm/bug.h>
 #include <asm/processor.h>
 
-struct vm_area_struct; /* forward declaration (include/linux/mm.h) */
-struct mm_struct;
-
 extern pgd_t swapper_pg_dir[] __attribute__ ((aligned (4096)));
 extern void paging_init(void);
 extern void vmem_map_init(void);
@@ -221,6 +218,8 @@ extern unsigned long vmalloc_end;
 /* Hardware bits in the page table entry */
 #define _PAGE_RO	0x200		/* HW read-only bit  */
 #define _PAGE_INVALID	0x400		/* HW invalid bit    */
+
+/* Software bits in the page table entry */
 #define _PAGE_SWT	0x001		/* SW pte type bit t */
 #define _PAGE_SWX	0x002		/* SW pte type bit x */
 
@@ -264,60 +263,75 @@ extern unsigned long vmalloc_end;
 
 #ifndef __s390x__
 
-/* Bits in the segment table entry */
-#define _PAGE_TABLE_LEN 0xf            /* only full page-tables            */
-#define _PAGE_TABLE_COM 0x10           /* common page-table                */
-#define _PAGE_TABLE_INV 0x20           /* invalid page-table               */
-#define _SEG_PRESENT    0x001          /* Software (overlap with PTL)      */
-
-/* Bits int the storage key */
-#define _PAGE_CHANGED    0x02          /* HW changed bit                   */
-#define _PAGE_REFERENCED 0x04          /* HW referenced bit                */
-
-#define _USER_SEG_TABLE_LEN    0x7f    /* user-segment-table up to 2 GB    */
-#define _KERNEL_SEG_TABLE_LEN  0x7f    /* kernel-segment-table up to 2 GB  */
-
-/*
- * User and Kernel pagetables are identical
- */
-#define _PAGE_TABLE	_PAGE_TABLE_LEN
-#define _KERNPG_TABLE	_PAGE_TABLE_LEN
-
-/*
- * The Kernel segment-tables includes the User segment-table
- */
+/* Bits in the segment table address-space-control-element */
+#define _ASCE_SPACE_SWITCH	0x80000000UL	/* space switch event	    */
+#define _ASCE_ORIGIN_MASK	0x7ffff000UL	/* segment table origin	    */
+#define _ASCE_PRIVATE_SPACE	0x100	/* private space control	    */
+#define _ASCE_ALT_EVENT		0x80	/* storage alteration event control */
+#define _ASCE_TABLE_LENGTH	0x7f	/* 128 x 64 entries = 8k	    */
 
-#define _SEGMENT_TABLE	(_USER_SEG_TABLE_LEN|0x80000000|0x100)
-#define _KERNSEG_TABLE	_KERNEL_SEG_TABLE_LEN
+/* Bits in the segment table entry */
+#define _SEGMENT_ENTRY_ORIGIN	0x7fffffc0UL	/* page table origin	    */
+#define _SEGMENT_ENTRY_INV	0x20	/* invalid segment table entry	    */
+#define _SEGMENT_ENTRY_COMMON	0x10	/* common segment bit		    */
+#define _SEGMENT_ENTRY_PTL	0x0f	/* page table length		    */
 
-#define USER_STD_MASK	0x00000080UL
+#define _SEGMENT_ENTRY		(_SEGMENT_ENTRY_PTL)
+#define _SEGMENT_ENTRY_EMPTY	(_SEGMENT_ENTRY_INV)
 
 #else /* __s390x__ */
 
+/* Bits in the segment/region table address-space-control-element */
+#define _ASCE_ORIGIN		~0xfffUL/* segment table origin		    */
+#define _ASCE_PRIVATE_SPACE	0x100	/* private space control	    */
+#define _ASCE_ALT_EVENT		0x80	/* storage alteration event control */
+#define _ASCE_SPACE_SWITCH	0x40	/* space switch event		    */
+#define _ASCE_REAL_SPACE	0x20	/* real space control		    */
+#define _ASCE_TYPE_MASK		0x0c	/* asce table type mask		    */
+#define _ASCE_TYPE_REGION1	0x0c	/* region first table type	    */
+#define _ASCE_TYPE_REGION2	0x08	/* region second table type	    */
+#define _ASCE_TYPE_REGION3	0x04	/* region third table type	    */
+#define _ASCE_TYPE_SEGMENT	0x00	/* segment table type		    */
+#define _ASCE_TABLE_LENGTH	0x03	/* region table length		    */
+
+/* Bits in the region table entry */
+#define _REGION_ENTRY_ORIGIN	~0xfffUL/* region/segment table origin	    */
+#define _REGION_ENTRY_INV	0x20	/* invalid region table entry	    */
+#define _REGION_ENTRY_TYPE_MASK	0x0c	/* region/segment table type mask   */
+#define _REGION_ENTRY_TYPE_R1	0x0c	/* region first table type	    */
+#define _REGION_ENTRY_TYPE_R2	0x08	/* region second table type	    */
+#define _REGION_ENTRY_TYPE_R3	0x04	/* region third table type	    */
+#define _REGION_ENTRY_LENGTH	0x03	/* region third length		    */
+
+#define _REGION1_ENTRY		(_REGION_ENTRY_TYPE_R1 | _REGION_ENTRY_LENGTH)
+#define _REGION1_ENTRY_EMPTY	(_REGION_ENTRY_TYPE_R1 | _REGION_ENTRY_INV)
+#define _REGION2_ENTRY		(_REGION_ENTRY_TYPE_R2 | _REGION_ENTRY_LENGTH)
+#define _REGION2_ENTRY_EMPTY	(_REGION_ENTRY_TYPE_R2 | _REGION_ENTRY_INV)
+#define _REGION3_ENTRY		(_REGION_ENTRY_TYPE_R3 | _REGION_ENTRY_LENGTH)
+#define _REGION3_ENTRY_EMPTY	(_REGION_ENTRY_TYPE_R3 | _REGION_ENTRY_INV)
+
 /* Bits in the segment table entry */
-#define _PMD_ENTRY_INV   0x20          /* invalid segment table entry      */
-#define _PMD_ENTRY       0x00        
+#define _SEGMENT_ENTRY_ORIGIN	~0x7ffUL/* segment table origin		    */
+#define _SEGMENT_ENTRY_RO	0x200	/* page protection bit		    */
+#define _SEGMENT_ENTRY_INV	0x20	/* invalid segment table entry	    */
 
-/* Bits in the region third table entry */
-#define _PGD_ENTRY_INV   0x20          /* invalid region table entry       */
-#define _PGD_ENTRY       0x07
+#define _SEGMENT_ENTRY		(0)
+#define _SEGMENT_ENTRY_EMPTY	(_SEGMENT_ENTRY_INV)
+
+#endif /* __s390x__ */
 
 /*
- * User and kernel page directory
+ * A user page table pointer has the space-switch-event bit, the
+ * private-space-control bit and the storage-alteration-event-control
+ * bit set. A kernel page table pointer doesn't need them.
  */
-#define _REGION_THIRD       0x4
-#define _REGION_THIRD_LEN   0x3 
-#define _REGION_TABLE       (_REGION_THIRD|_REGION_THIRD_LEN|0x40|0x100)
-#define _KERN_REGION_TABLE  (_REGION_THIRD|_REGION_THIRD_LEN)
-
-#define USER_STD_MASK           0x0000000000000080UL
+#define _ASCE_USER_BITS		(_ASCE_SPACE_SWITCH | _ASCE_PRIVATE_SPACE | \
+				 _ASCE_ALT_EVENT)
 
-/* Bits in the storage key */
+/* Bits int the storage key */
 #define _PAGE_CHANGED    0x02          /* HW changed bit                   */
 #define _PAGE_REFERENCED 0x04          /* HW referenced bit                */
 
-#endif /* __s390x__ */
-
 /*
  * Page protection definitions.
  */
@@ -358,65 +372,38 @@ extern unsigned long vmalloc_end;
 #define __S111	PAGE_EX_RW
 
 #ifndef __s390x__
-# define PMD_SHADOW_SHIFT	1
-# define PGD_SHADOW_SHIFT	1
+# define PxD_SHADOW_SHIFT	1
 #else /* __s390x__ */
-# define PMD_SHADOW_SHIFT	2
-# define PGD_SHADOW_SHIFT	2
+# define PxD_SHADOW_SHIFT	2
 #endif /* __s390x__ */
 
 static inline struct page *get_shadow_page(struct page *page)
 {
-	if (s390_noexec && !list_empty(&page->lru))
-		return virt_to_page(page->lru.next);
-	return NULL;
-}
-
-static inline pte_t *get_shadow_pte(pte_t *ptep)
-{
-	unsigned long pteptr = (unsigned long) (ptep);
-
-	if (s390_noexec) {
-		unsigned long offset = pteptr & (PAGE_SIZE - 1);
-		void *addr = (void *) (pteptr ^ offset);
-		struct page *page = virt_to_page(addr);
-		if (!list_empty(&page->lru))
-			return (pte_t *) ((unsigned long) page->lru.next |
-								offset);
-	}
+	if (s390_noexec && page->index)
+		return virt_to_page((void *)(addr_t) page->index);
 	return NULL;
 }
 
-static inline pmd_t *get_shadow_pmd(pmd_t *pmdp)
+static inline void *get_shadow_pte(void *table)
 {
-	unsigned long pmdptr = (unsigned long) (pmdp);
+	unsigned long addr, offset;
+	struct page *page;
 
-	if (s390_noexec) {
-		unsigned long offset = pmdptr &
-				((PAGE_SIZE << PMD_SHADOW_SHIFT) - 1);
-		void *addr = (void *) (pmdptr ^ offset);
-		struct page *page = virt_to_page(addr);
-		if (!list_empty(&page->lru))
-			return (pmd_t *) ((unsigned long) page->lru.next |
-								offset);
-	}
-	return NULL;
+	addr = (unsigned long) table;
+	offset = addr & (PAGE_SIZE - 1);
+	page = virt_to_page((void *)(addr ^ offset));
+	return (void *)(addr_t)(page->index ? (page->index | offset) : 0ULL);
 }
 
-static inline pgd_t *get_shadow_pgd(pgd_t *pgdp)
+static inline void *get_shadow_table(void *table)
 {
-	unsigned long pgdptr = (unsigned long) (pgdp);
+	unsigned long addr, offset;
+	struct page *page;
 
-	if (s390_noexec) {
-		unsigned long offset = pgdptr &
-				((PAGE_SIZE << PGD_SHADOW_SHIFT) - 1);
-		void *addr = (void *) (pgdptr ^ offset);
-		struct page *page = virt_to_page(addr);
-		if (!list_empty(&page->lru))
-			return (pgd_t *) ((unsigned long) page->lru.next |
-								offset);
-	}
-	return NULL;
+	addr = (unsigned long) table;
+	offset = addr & ((PAGE_SIZE << PxD_SHADOW_SHIFT) - 1);
+	page = virt_to_page((void *)(addr ^ offset));
+	return (void *)(addr_t)(page->index ? (page->index | offset) : 0ULL);
 }
 
 /*
@@ -448,47 +435,42 @@ static inline int pgd_present(pgd_t pgd)
 static inline int pgd_none(pgd_t pgd)    { return 0; }
 static inline int pgd_bad(pgd_t pgd)     { return 0; }
 
-static inline int pmd_present(pmd_t pmd) { return pmd_val(pmd) & _SEG_PRESENT; }
-static inline int pmd_none(pmd_t pmd)    { return pmd_val(pmd) & _PAGE_TABLE_INV; }
-static inline int pmd_bad(pmd_t pmd)
-{
-	return (pmd_val(pmd) & (~PAGE_MASK & ~_PAGE_TABLE_INV)) != _PAGE_TABLE;
-}
-
 #else /* __s390x__ */
 
 static inline int pgd_present(pgd_t pgd)
 {
-	return (pgd_val(pgd) & ~PAGE_MASK) == _PGD_ENTRY;
+	return pgd_val(pgd) & _REGION_ENTRY_ORIGIN;
 }
 
 static inline int pgd_none(pgd_t pgd)
 {
-	return pgd_val(pgd) & _PGD_ENTRY_INV;
+	return pgd_val(pgd) & _REGION_ENTRY_INV;
 }
 
 static inline int pgd_bad(pgd_t pgd)
 {
-	return (pgd_val(pgd) & (~PAGE_MASK & ~_PGD_ENTRY_INV)) != _PGD_ENTRY;
+	unsigned long mask = ~_REGION_ENTRY_ORIGIN & ~_REGION_ENTRY_INV;
+	return (pgd_val(pgd) & mask) != _REGION3_ENTRY;
 }
 
+#endif /* __s390x__ */
+
 static inline int pmd_present(pmd_t pmd)
 {
-	return (pmd_val(pmd) & ~PAGE_MASK) == _PMD_ENTRY;
+	return pmd_val(pmd) & _SEGMENT_ENTRY_ORIGIN;
 }
 
 static inline int pmd_none(pmd_t pmd)
 {
-	return pmd_val(pmd) & _PMD_ENTRY_INV;
+	return pmd_val(pmd) & _SEGMENT_ENTRY_INV;
 }
 
 static inline int pmd_bad(pmd_t pmd)
 {
-	return (pmd_val(pmd) & (~PAGE_MASK & ~_PMD_ENTRY_INV)) != _PMD_ENTRY;
+	unsigned long mask = ~_SEGMENT_ENTRY_ORIGIN & ~_SEGMENT_ENTRY_INV;
+	return (pmd_val(pmd) & mask) != _SEGMENT_ENTRY;
 }
 
-#endif /* __s390x__ */
-
 static inline int pte_none(pte_t pte)
 {
 	return (pte_val(pte) & _PAGE_INVALID) && !(pte_val(pte) & _PAGE_SWT);
@@ -548,31 +530,22 @@ static inline void pgd_clear(pgd_t * pgd
 
 static inline void pmd_clear_kernel(pmd_t * pmdp)
 {
-	pmd_val(pmdp[0]) = _PAGE_TABLE_INV;
-	pmd_val(pmdp[1]) = _PAGE_TABLE_INV;
-	pmd_val(pmdp[2]) = _PAGE_TABLE_INV;
-	pmd_val(pmdp[3]) = _PAGE_TABLE_INV;
-}
-
-static inline void pmd_clear(pmd_t * pmdp)
-{
-	pmd_t *shadow_pmd = get_shadow_pmd(pmdp);
-
-	pmd_clear_kernel(pmdp);
-	if (shadow_pmd)
-		pmd_clear_kernel(shadow_pmd);
+	pmd_val(pmdp[0]) = _SEGMENT_ENTRY_EMPTY;
+	pmd_val(pmdp[1]) = _SEGMENT_ENTRY_EMPTY;
+	pmd_val(pmdp[2]) = _SEGMENT_ENTRY_EMPTY;
+	pmd_val(pmdp[3]) = _SEGMENT_ENTRY_EMPTY;
 }
 
 #else /* __s390x__ */
 
 static inline void pgd_clear_kernel(pgd_t * pgdp)
 {
-	pgd_val(*pgdp) = _PGD_ENTRY_INV | _PGD_ENTRY;
+	pgd_val(*pgdp) = _REGION3_ENTRY_EMPTY;
 }
 
 static inline void pgd_clear(pgd_t * pgdp)
 {
-	pgd_t *shadow_pgd = get_shadow_pgd(pgdp);
+	pgd_t *shadow_pgd = get_shadow_table(pgdp);
 
 	pgd_clear_kernel(pgdp);
 	if (shadow_pgd)
@@ -581,21 +554,21 @@ static inline void pgd_clear(pgd_t * pgd
 
 static inline void pmd_clear_kernel(pmd_t * pmdp)
 {
-	pmd_val(*pmdp) = _PMD_ENTRY_INV | _PMD_ENTRY;
-	pmd_val1(*pmdp) = _PMD_ENTRY_INV | _PMD_ENTRY;
+	pmd_val(*pmdp) = _SEGMENT_ENTRY_EMPTY;
+	pmd_val1(*pmdp) = _SEGMENT_ENTRY_EMPTY;
 }
 
+#endif /* __s390x__ */
+
 static inline void pmd_clear(pmd_t * pmdp)
 {
-	pmd_t *shadow_pmd = get_shadow_pmd(pmdp);
+	pmd_t *shadow_pmd = get_shadow_table(pmdp);
 
 	pmd_clear_kernel(pmdp);
 	if (shadow_pmd)
 		pmd_clear_kernel(shadow_pmd);
 }
 
-#endif /* __s390x__ */
-
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	pte_t *shadow_pte = get_shadow_pte(ptep);
Index: quilt-2.6/include/asm-s390/processor.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/processor.h
+++ quilt-2.6/include/asm-s390/processor.h
@@ -127,12 +127,6 @@ struct stack_frame {
 
 #define ARCH_MIN_TASKALIGN	8
 
-#ifndef __s390x__
-# define __SWAPPER_PG_DIR __pa(&swapper_pg_dir[0]) + _SEGMENT_TABLE
-#else /* __s390x__ */
-# define __SWAPPER_PG_DIR __pa(&swapper_pg_dir[0]) + _REGION_TABLE
-#endif /* __s390x__ */
-
 #define INIT_THREAD {							\
 	.ksp = sizeof(init_stack) + (unsigned long) &init_stack,	\
 }
Index: quilt-2.6/include/asm-s390/tlbflush.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/tlbflush.h
+++ quilt-2.6/include/asm-s390/tlbflush.h
@@ -61,7 +61,7 @@ static inline void __tlb_flush_mm(struct
 	 * only ran on the local cpu.
 	 */
 	if (MACHINE_HAS_IDTE) {
-		pgd_t *shadow_pgd = get_shadow_pgd(mm->pgd);
+		pgd_t *shadow_pgd = get_shadow_table(mm->pgd);
 
 		if (shadow_pgd)
 			__tlb_flush_idte(shadow_pgd);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
