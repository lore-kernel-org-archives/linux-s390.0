Return-Path: <linux-kernel-owner+w=401wt.eu-S935595AbXJSRX0@vger.kernel.org>
Message-Id: <20071019171945.867167088@de.ibm.com>
References: <20071019171857.430999834@de.ibm.com>
Date: Fri, 19 Oct 2007 19:19:07 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 10/10] 4level-fixup cleanup
Content-Disposition: inline; filename=010-mm-fixup.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Get independent from asm-generic/4level-fixup.h

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/lib/uaccess_pt.c |    7 ++
 arch/s390/mm/init.c        |    6 +-
 arch/s390/mm/vmem.c        |   34 ++++++++++--
 include/asm-s390/page.h    |    4 +
 include/asm-s390/pgalloc.h |   32 ++++++++---
 include/asm-s390/pgtable.h |  123 ++++++++++++++++++++++-----------------------
 include/asm-s390/tlb.h     |    2 
 7 files changed, 128 insertions(+), 80 deletions(-)

Index: quilt-2.6/arch/s390/lib/uaccess_pt.c
===================================================================
--- quilt-2.6.orig/arch/s390/lib/uaccess_pt.c
+++ quilt-2.6/arch/s390/lib/uaccess_pt.c
@@ -18,13 +18,18 @@
 static inline pte_t *follow_table(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
+	pud_t *pud;
 	pmd_t *pmd;
 
 	pgd = pgd_offset(mm, addr);
 	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
 		return NULL;
 
-	pmd = pmd_offset(pgd, addr);
+	pud = pud_offset(pgd, addr);
+	if (pud_none(*pud) || unlikely(pud_bad(*pud)))
+		return NULL;
+
+	pmd = pmd_offset(pud, addr);
 	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
 		return NULL;
 
Index: quilt-2.6/arch/s390/mm/init.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/init.c
+++ quilt-2.6/arch/s390/mm/init.c
@@ -81,6 +81,7 @@ void show_mem(void)
 static void __init setup_ro_region(void)
 {
 	pgd_t *pgd;
+	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
 	pte_t new_pte;
@@ -91,7 +92,8 @@ static void __init setup_ro_region(void)
 
 	for (; address < end; address += PAGE_SIZE) {
 		pgd = pgd_offset_k(address);
-		pmd = pmd_offset(pgd, address);
+		pud = pud_offset(pgd, address);
+		pmd = pmd_offset(pud, address);
 		pte = pte_offset_kernel(pmd, address);
 		new_pte = mk_pte_phys(address, __pgprot(_PAGE_RO));
 		*pte = new_pte;
@@ -110,7 +112,7 @@ void __init paging_init(void)
 	S390_lowcore.kernel_asce = __pa(init_mm.pgd) & PAGE_MASK;
 #ifdef CONFIG_64BIT
 	S390_lowcore.kernel_asce |= _ASCE_TYPE_REGION3 | _ASCE_TABLE_LENGTH;
-	pgd_val(*((pgd_t *) init_mm.pgd)) = _REGION3_ENTRY_EMPTY;
+	pud_val(*((pud_t *) init_mm.pgd)) = _REGION3_ENTRY_EMPTY;
 #else
 	S390_lowcore.kernel_asce |= _ASCE_TABLE_LENGTH;
 	pmd_val(*((pmd_t *) init_mm.pgd)) = _SEGMENT_ENTRY_EMPTY;
Index: quilt-2.6/arch/s390/mm/vmem.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/vmem.c
+++ quilt-2.6/arch/s390/mm/vmem.c
@@ -73,6 +73,8 @@ static void __init_refok *vmem_alloc_pag
 	return alloc_bootmem_pages((1 << order) * PAGE_SIZE);
 }
 
+#define vmem_pud_alloc()	({ BUG(); ((pud_t *) NULL); })
+
 static inline pmd_t *vmem_pmd_alloc(void)
 {
 	pmd_t *pmd = NULL;
@@ -103,6 +105,7 @@ static int vmem_add_range(unsigned long 
 {
 	unsigned long address;
 	pgd_t *pg_dir;
+	pud_t *pu_dir;
 	pmd_t *pm_dir;
 	pte_t *pt_dir;
 	pte_t  pte;
@@ -111,13 +114,21 @@ static int vmem_add_range(unsigned long 
 	for (address = start; address < start + size; address += PAGE_SIZE) {
 		pg_dir = pgd_offset_k(address);
 		if (pgd_none(*pg_dir)) {
+			pu_dir = vmem_pud_alloc();
+			if (!pu_dir)
+				goto out;
+			pgd_populate_kernel(&init_mm, pg_dir, pu_dir);
+		}
+
+		pu_dir = pud_offset(pg_dir, address);
+		if (pud_none(*pu_dir)) {
 			pm_dir = vmem_pmd_alloc();
 			if (!pm_dir)
 				goto out;
-			pgd_populate_kernel(&init_mm, pg_dir, pm_dir);
+			pud_populate_kernel(&init_mm, pu_dir, pm_dir);
 		}
 
-		pm_dir = pmd_offset(pg_dir, address);
+		pm_dir = pmd_offset(pu_dir, address);
 		if (pmd_none(*pm_dir)) {
 			pt_dir = vmem_pte_alloc();
 			if (!pt_dir)
@@ -143,6 +154,7 @@ static void vmem_remove_range(unsigned l
 {
 	unsigned long address;
 	pgd_t *pg_dir;
+	pud_t *pu_dir;
 	pmd_t *pm_dir;
 	pte_t *pt_dir;
 	pte_t  pte;
@@ -150,9 +162,10 @@ static void vmem_remove_range(unsigned l
 	pte_val(pte) = _PAGE_TYPE_EMPTY;
 	for (address = start; address < start + size; address += PAGE_SIZE) {
 		pg_dir = pgd_offset_k(address);
-		if (pgd_none(*pg_dir))
+		pu_dir = pud_offset(pg_dir, address);
+		if (pud_none(*pu_dir))
 			continue;
-		pm_dir = pmd_offset(pg_dir, address);
+		pm_dir = pmd_offset(pu_dir, address);
 		if (pmd_none(*pm_dir))
 			continue;
 		pt_dir = pte_offset_kernel(pm_dir, address);
@@ -169,6 +182,7 @@ static int vmem_add_mem_map(unsigned lon
 	unsigned long address, start_addr, end_addr;
 	struct page *map_start, *map_end;
 	pgd_t *pg_dir;
+	pud_t *pu_dir;
 	pmd_t *pm_dir;
 	pte_t *pt_dir;
 	pte_t  pte;
@@ -183,13 +197,21 @@ static int vmem_add_mem_map(unsigned lon
 	for (address = start_addr; address < end_addr; address += PAGE_SIZE) {
 		pg_dir = pgd_offset_k(address);
 		if (pgd_none(*pg_dir)) {
+			pu_dir = vmem_pud_alloc();
+			if (!pu_dir)
+				goto out;
+			pgd_populate_kernel(&init_mm, pg_dir, pu_dir);
+		}
+
+		pu_dir = pud_offset(pg_dir, address);
+		if (pud_none(*pu_dir)) {
 			pm_dir = vmem_pmd_alloc();
 			if (!pm_dir)
 				goto out;
-			pgd_populate_kernel(&init_mm, pg_dir, pm_dir);
+			pud_populate_kernel(&init_mm, pu_dir, pm_dir);
 		}
 
-		pm_dir = pmd_offset(pg_dir, address);
+		pm_dir = pmd_offset(pu_dir, address);
 		if (pmd_none(*pm_dir)) {
 			pt_dir = vmem_pte_alloc();
 			if (!pt_dir)
Index: quilt-2.6/include/asm-s390/page.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/page.h
+++ quilt-2.6/include/asm-s390/page.h
@@ -82,6 +82,7 @@ typedef struct { unsigned long pte; } pt
 #ifndef __s390x__
 
 typedef struct { unsigned long pmd; } pmd_t;
+typedef struct { unsigned long pud; } pud_t;
 typedef struct {
         unsigned long pgd0;
         unsigned long pgd1;
@@ -90,6 +91,7 @@ typedef struct {
         } pgd_t;
 
 #define pmd_val(x)      ((x).pmd)
+#define pud_val(x)	((x).pud)
 #define pgd_val(x)      ((x).pgd0)
 
 #else /* __s390x__ */
@@ -98,10 +100,12 @@ typedef struct { 
         unsigned long pmd0;
         unsigned long pmd1; 
         } pmd_t;
+typedef struct { unsigned long pud; } pud_t;
 typedef struct { unsigned long pgd; } pgd_t;
 
 #define pmd_val(x)      ((x).pmd0)
 #define pmd_val1(x)     ((x).pmd1)
+#define pud_val(x)	((x).pud)
 #define pgd_val(x)      ((x).pgd)
 
 #endif /* __s390x__ */
Index: quilt-2.6/include/asm-s390/pgalloc.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/pgalloc.h
+++ quilt-2.6/include/asm-s390/pgalloc.h
@@ -43,11 +43,17 @@ static inline unsigned long pgd_entry_ty
 	return _SEGMENT_ENTRY_EMPTY;
 }
 
+#define pud_alloc_one(mm,address)		({ BUG(); ((pud_t *)2); })
+#define pud_free(x)				do { } while (0)
+
 #define pmd_alloc_one(mm,address)		({ BUG(); ((pmd_t *)2); })
 #define pmd_free(x)				do { } while (0)
 
-#define pgd_populate(mm, pmd, pte)		BUG()
-#define pgd_populate_kernel(mm, pmd, pte)	BUG()
+#define pgd_populate(mm, pgd, pud)		BUG()
+#define pgd_populate_kernel(mm, pgd, pud)	BUG()
+
+#define pud_populate(mm, pud, pmd)		BUG()
+#define pud_populate_kernel(mm, pud, pmd)	BUG()
 
 #else /* __s390x__ */
 
@@ -56,6 +62,9 @@ static inline unsigned long pgd_entry_ty
 	return _REGION3_ENTRY_EMPTY;
 }
 
+#define pud_alloc_one(mm,address)		({ BUG(); ((pud_t *)2); })
+#define pud_free(x)				do { } while (0)
+
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long vmaddr)
 {
 	unsigned long *crst = crst_table_alloc(mm, s390_noexec);
@@ -65,20 +74,23 @@ static inline pmd_t *pmd_alloc_one(struc
 }
 #define pmd_free(pmd) crst_table_free((unsigned long *) pmd)
 
-static inline void pgd_populate_kernel(struct mm_struct *mm,
-				       pgd_t *pgd, pmd_t *pmd)
+#define pgd_populate(mm, pgd, pud)		BUG()
+#define pgd_populate_kernel(mm, pgd, pud)	BUG()
+
+static inline void pud_populate_kernel(struct mm_struct *mm,
+				       pud_t *pud, pmd_t *pmd)
 {
-	pgd_val(*pgd) = _REGION3_ENTRY | __pa(pmd);
+	pud_val(*pud) = _REGION3_ENTRY | __pa(pmd);
 }
 
-static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pmd_t *pmd)
+static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 {
-	pgd_t *shadow_pgd = get_shadow_table(pgd);
+	pud_t *shadow_pud = get_shadow_table(pud);
 	pmd_t *shadow_pmd = get_shadow_table(pmd);
 
-	if (shadow_pgd && shadow_pmd)
-		pgd_populate_kernel(mm, shadow_pgd, shadow_pmd);
-	pgd_populate_kernel(mm, pgd, pmd);
+	if (shadow_pud && shadow_pmd)
+		pud_populate_kernel(mm, shadow_pud, shadow_pmd);
+	pud_populate_kernel(mm, pud, pmd);
 }
 
 #endif /* __s390x__ */
Index: quilt-2.6/include/asm-s390/pgtable.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/pgtable.h
+++ quilt-2.6/include/asm-s390/pgtable.h
@@ -13,8 +13,6 @@
 #ifndef _ASM_S390_PGTABLE_H
 #define _ASM_S390_PGTABLE_H
 
-#include <asm-generic/4level-fixup.h>
-
 /*
  * The Linux memory management assumes a three-level page table setup. For
  * s390 31 bit we "fold" the mid level into the top-level page table, so
@@ -60,14 +58,18 @@ extern char empty_zero_page[PAGE_SIZE];
  */
 #ifndef __s390x__
 # define PMD_SHIFT	22
+# define PUD_SHIFT	22
 # define PGDIR_SHIFT	22
 #else /* __s390x__ */
 # define PMD_SHIFT	21
+# define PUD_SHIFT	31
 # define PGDIR_SHIFT	31
 #endif /* __s390x__ */
 
 #define PMD_SIZE        (1UL << PMD_SHIFT)
 #define PMD_MASK        (~(PMD_SIZE-1))
+#define PUD_SIZE	(1UL << PUD_SHIFT)
+#define PUD_MASK	(~(PUD_SIZE-1))
 #define PGDIR_SIZE      (1UL << PGDIR_SHIFT)
 #define PGDIR_MASK      (~(PGDIR_SIZE-1))
 
@@ -80,10 +82,12 @@ extern char empty_zero_page[PAGE_SIZE];
 #ifndef __s390x__
 # define PTRS_PER_PTE    1024
 # define PTRS_PER_PMD    1
+# define PTRS_PER_PUD	1
 # define PTRS_PER_PGD    512
 #else /* __s390x__ */
 # define PTRS_PER_PTE    512
 # define PTRS_PER_PMD    1024
+# define PTRS_PER_PUD	1
 # define PTRS_PER_PGD    2048
 #endif /* __s390x__ */
 
@@ -93,6 +97,8 @@ extern char empty_zero_page[PAGE_SIZE];
 	printk("%s:%d: bad pte %p.\n", __FILE__, __LINE__, (void *) pte_val(e))
 #define pmd_ERROR(e) \
 	printk("%s:%d: bad pmd %p.\n", __FILE__, __LINE__, (void *) pmd_val(e))
+#define pud_ERROR(e) \
+	printk("%s:%d: bad pud %p.\n", __FILE__, __LINE__, (void *) pud_val(e))
 #define pgd_ERROR(e) \
 	printk("%s:%d: bad pgd %p.\n", __FILE__, __LINE__, (void *) pgd_val(e))
 
@@ -192,7 +198,7 @@ extern unsigned long vmalloc_end;
  * I Segment-Invalid Bit:    Segment is not available for address-translation
  * TT Type 01
  * TF
- * TL Table lenght
+ * TL Table length
  *
  * The 64 bit regiontable origin of S390 has following format:
  * |      region table origon                          |       DTTL
@@ -435,22 +441,30 @@ static inline int pgd_present(pgd_t pgd)
 static inline int pgd_none(pgd_t pgd)    { return 0; }
 static inline int pgd_bad(pgd_t pgd)     { return 0; }
 
+static inline int pud_present(pud_t pud) { return 1; }
+static inline int pud_none(pud_t pud)	 { return 0; }
+static inline int pud_bad(pud_t pud)	 { return 0; }
+
 #else /* __s390x__ */
 
-static inline int pgd_present(pgd_t pgd)
+static inline int pgd_present(pgd_t pgd) { return 1; }
+static inline int pgd_none(pgd_t pgd)	 { return 0; }
+static inline int pgd_bad(pgd_t pgd)	 { return 0; }
+
+static inline int pud_present(pud_t pud)
 {
-	return pgd_val(pgd) & _REGION_ENTRY_ORIGIN;
+	return pud_val(pud) & _REGION_ENTRY_ORIGIN;
 }
 
-static inline int pgd_none(pgd_t pgd)
+static inline int pud_none(pud_t pud)
 {
-	return pgd_val(pgd) & _REGION_ENTRY_INV;
+	return pud_val(pud) & _REGION_ENTRY_INV;
 }
 
-static inline int pgd_bad(pgd_t pgd)
+static inline int pud_bad(pud_t pud)
 {
 	unsigned long mask = ~_REGION_ENTRY_ORIGIN & ~_REGION_ENTRY_INV;
-	return (pgd_val(pgd) & mask) != _REGION3_ENTRY;
+	return (pud_val(pud) & mask) != _REGION3_ENTRY;
 }
 
 #endif /* __s390x__ */
@@ -526,7 +540,8 @@ static inline int pte_young(pte_t pte)
 
 #ifndef __s390x__
 
-static inline void pgd_clear(pgd_t * pgdp)      { }
+#define pgd_clear(pgd)		do { } while (0)
+#define pud_clear(pud)		do { } while (0)
 
 static inline void pmd_clear_kernel(pmd_t * pmdp)
 {
@@ -538,18 +553,20 @@ static inline void pmd_clear_kernel(pmd_
 
 #else /* __s390x__ */
 
-static inline void pgd_clear_kernel(pgd_t * pgdp)
+#define pgd_clear(pgd)		do { } while (0)
+
+static inline void pud_clear_kernel(pud_t *pud)
 {
-	pgd_val(*pgdp) = _REGION3_ENTRY_EMPTY;
+	pud_val(*pud) = _REGION3_ENTRY_EMPTY;
 }
 
-static inline void pgd_clear(pgd_t * pgdp)
+static inline void pud_clear(pud_t * pud)
 {
-	pgd_t *shadow_pgd = get_shadow_table(pgdp);
+	pud_t *shadow = get_shadow_table(pud);
 
-	pgd_clear_kernel(pgdp);
-	if (shadow_pgd)
-		pgd_clear_kernel(shadow_pgd);
+	pud_clear_kernel(pud);
+	if (shadow)
+		pud_clear_kernel(shadow);
 }
 
 static inline void pmd_clear_kernel(pmd_t * pmdp)
@@ -810,63 +827,48 @@ static inline pte_t mk_pte(struct page *
 	return mk_pte_phys(physpage, pgprot);
 }
 
-static inline pte_t pfn_pte(unsigned long pfn, pgprot_t pgprot)
-{
-	unsigned long physpage = __pa((pfn) << PAGE_SHIFT);
-
-	return mk_pte_phys(physpage, pgprot);
-}
-
-#ifdef __s390x__
-
-static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t pgprot)
-{
-	unsigned long physpage = __pa((pfn) << PAGE_SHIFT);
-
-	return __pmd(physpage + pgprot_val(pgprot));
-}
-
-#endif /* __s390x__ */
-
-#define pte_pfn(x) (pte_val(x) >> PAGE_SHIFT)
-#define pte_page(x) pfn_to_page(pte_pfn(x))
+#define pgd_index(address) (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
+#define pud_index(address) (((address) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
+#define pmd_index(address) (((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
+#define pte_index(address) (((address) >> PAGE_SHIFT) & (PTRS_PER_PTE-1))
 
-#define pmd_page_vaddr(pmd) (pmd_val(pmd) & PAGE_MASK)
+#define pgd_offset(mm, address) ((mm)->pgd + pgd_index(address))
+#define pgd_offset_k(address) pgd_offset(&init_mm, address)
 
-#define pmd_page(pmd) pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT)
+#ifndef __s390x__
 
-#define pgd_page_vaddr(pgd) (pgd_val(pgd) & PAGE_MASK)
+#define pmd_deref(pmd) (pmd_val(pmd) & _SEGMENT_ENTRY_ORIGIN)
+#define pud_deref(pmd) ({ BUG(); 0UL; })
+#define pgd_deref(pmd) ({ BUG(); 0UL; })
 
-#define pgd_page(pgd) pfn_to_page(pgd_val(pgd) >> PAGE_SHIFT)
+#define pud_offset(pgd, address) ((pud_t *) pgd)
+#define pmd_offset(pud, address) ((pmd_t *) pud + pmd_index(address))
 
-/* to find an entry in a page-table-directory */
-#define pgd_index(address) (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
-#define pgd_offset(mm, address) ((mm)->pgd+pgd_index(address))
+#else /* __s390x__ */
 
-/* to find an entry in a kernel page-table-directory */
-#define pgd_offset_k(address) pgd_offset(&init_mm, address)
+#define pmd_deref(pmd) (pmd_val(pmd) & _SEGMENT_ENTRY_ORIGIN)
+#define pud_deref(pud) (pud_val(pud) & _REGION_ENTRY_ORIGIN)
+#define pgd_deref(pgd) ({ BUG(); 0UL; })
 
-#ifndef __s390x__
+#define pud_offset(pgd, address) ((pud_t *) pgd)
 
-/* Find an entry in the second-level page table.. */
-static inline pmd_t * pmd_offset(pgd_t * dir, unsigned long address)
+static inline pmd_t *pmd_offset(pud_t *pud, unsigned long address)
 {
-        return (pmd_t *) dir;
+	pmd_t *pmd = (pmd_t *) pud_deref(*pud);
+	return pmd + pmd_index(address);
 }
 
-#else /* __s390x__ */
+#endif /* __s390x__ */
 
-/* Find an entry in the second-level page table.. */
-#define pmd_index(address) (((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
-#define pmd_offset(dir,addr) \
-	((pmd_t *) pgd_page_vaddr(*(dir)) + pmd_index(addr))
+#define pfn_pte(pfn,pgprot) mk_pte_phys(__pa((pfn) << PAGE_SHIFT),(pgprot))
+#define pte_pfn(x) (pte_val(x) >> PAGE_SHIFT)
+#define pte_page(x) pfn_to_page(pte_pfn(x))
 
-#endif /* __s390x__ */
+#define pmd_page(pmd) pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT)
 
-/* Find an entry in the third-level page table.. */
-#define pte_index(address) (((address) >> PAGE_SHIFT) & (PTRS_PER_PTE-1))
-#define pte_offset_kernel(pmd, address) \
-	((pte_t *) pmd_page_vaddr(*(pmd)) + pte_index(address))
+/* Find an entry in the lowest level page table.. */
+#define pte_offset(pmd, addr) ((pte_t *) pmd_deref(*(pmd)) + pte_index(addr))
+#define pte_offset_kernel(pmd, address) pte_offset(pmd,address)
 #define pte_offset_map(pmd, address) pte_offset_kernel(pmd, address)
 #define pte_offset_map_nested(pmd, address) pte_offset_kernel(pmd, address)
 #define pte_unmap(pte) do { } while (0)
@@ -959,4 +961,3 @@ extern void memmap_init(unsigned long, i
 #include <asm-generic/pgtable.h>
 
 #endif /* _S390_PAGE_H */
-
Index: quilt-2.6/include/asm-s390/tlb.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/tlb.h
+++ quilt-2.6/include/asm-s390/tlb.h
@@ -121,6 +121,8 @@ static inline void pmd_free_tlb(struct m
 #endif
 }
 
+#define pud_free_tlb(tlb, pud)			do { } while (0)
+
 #define tlb_start_vma(tlb, vma)			do { } while (0)
 #define tlb_end_vma(tlb, vma)			do { } while (0)
 #define tlb_remove_tlb_entry(tlb, ptep, addr)	do { } while (0)

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
