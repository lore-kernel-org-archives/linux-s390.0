Return-Path: <linux-kernel-owner+w=401wt.eu-S1756194AbYJORtV@vger.kernel.org>
Message-Id: <20081015174414.418334201@de.ibm.com>
References: <20081015174215.337001494@de.ibm.com>
Date: Wed, 15 Oct 2008 19:42:19 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 4/5] pgtables: Fix race in enable_sie vs. page table ops
Content-Disposition: inline; filename=004-pgste-alloc.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

The current enable_sie code sets the mm->context.pgstes bit to tell
dup_mm that the new mm should have extended page tables. This bit is also
used by the s390 specific page table primitives to decide about the page
table layout - which means context.pgstes has two meanings. This can cause
any kind of bugs. For example  - e.g. shrink_zone can call
ptep_clear_flush_young while enable_sie is running. ptep_clear_flush_young
will test for context.pgstes. Since enable_sie changed that value of the old
struct mm without changing the page table layout ptep_clear_flush_young will
do the wrong thing.
The solution is to split pgstes into two bits
- one for the allocation
- one for the current state

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/mmu.h         |    3 ++-
 arch/s390/include/asm/mmu_context.h |   19 ++++++++++++++++---
 arch/s390/include/asm/pgtable.h     |    8 ++++----
 arch/s390/mm/pgtable.c              |   16 ++++++++--------
 4 files changed, 30 insertions(+), 16 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/mmu_context.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/mmu_context.h
+++ quilt-2.6/arch/s390/include/asm/mmu_context.h
@@ -20,12 +20,25 @@ static inline int init_new_context(struc
 #ifdef CONFIG_64BIT
 	mm->context.asce_bits |= _ASCE_TYPE_REGION3;
 #endif
-	if (current->mm->context.pgstes) {
+	if (current->mm->context.alloc_pgste) {
+		/*
+		 * alloc_pgste indicates, that any NEW context will be created
+		 * with extended page tables. The old context is unchanged. The
+		 * page table allocation and the page table operations will
+		 * look at has_pgste to distinguish normal and extended page
+		 * tables. The only way to create extended page tables is to
+		 * set alloc_pgste and then create a new context (e.g. dup_mm).
+		 * The page table allocation is called after init_new_context
+		 * and if has_pgste is set, it will create extended page
+		 * tables.
+		 */
 		mm->context.noexec = 0;
-		mm->context.pgstes = 1;
+		mm->context.has_pgste = 1;
+		mm->context.alloc_pgste = 1;
 	} else {
 		mm->context.noexec = s390_noexec;
-		mm->context.pgstes = 0;
+		mm->context.has_pgste = 0;
+		mm->context.alloc_pgste = 0;
 	}
 	mm->context.asce_limit = STACK_TOP_MAX;
 	crst_table_init((unsigned long *) mm->pgd, pgd_entry_type(mm));
Index: quilt-2.6/arch/s390/include/asm/mmu.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/mmu.h
+++ quilt-2.6/arch/s390/include/asm/mmu.h
@@ -7,7 +7,8 @@ typedef struct {
 	unsigned long asce_bits;
 	unsigned long asce_limit;
 	int noexec;
-	int pgstes;
+	int has_pgste;	 /* The mmu context has extended page tables */
+	int alloc_pgste; /* cloned contexts will have extended page tables */
 } mm_context_t;
 
 #endif
Index: quilt-2.6/arch/s390/include/asm/pgtable.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/pgtable.h
+++ quilt-2.6/arch/s390/include/asm/pgtable.h
@@ -679,7 +679,7 @@ static inline void pmd_clear(pmd_t *pmd)
 
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
-	if (mm->context.pgstes)
+	if (mm->context.has_pgste)
 		ptep_rcp_copy(ptep);
 	pte_val(*ptep) = _PAGE_TYPE_EMPTY;
 	if (mm->context.noexec)
@@ -763,7 +763,7 @@ static inline int kvm_s390_test_and_clea
 	struct page *page;
 	unsigned int skey;
 
-	if (!mm->context.pgstes)
+	if (!mm->context.has_pgste)
 		return -EINVAL;
 	rcp_lock(ptep);
 	pgste = (unsigned long *) (ptep + PTRS_PER_PTE);
@@ -794,7 +794,7 @@ static inline int ptep_test_and_clear_yo
 	int young;
 	unsigned long *pgste;
 
-	if (!vma->vm_mm->context.pgstes)
+	if (!vma->vm_mm->context.has_pgste)
 		return 0;
 	physpage = pte_val(*ptep) & PAGE_MASK;
 	pgste = (unsigned long *) (ptep + PTRS_PER_PTE);
@@ -844,7 +844,7 @@ static inline void __ptep_ipte(unsigned 
 static inline void ptep_invalidate(struct mm_struct *mm,
 				   unsigned long address, pte_t *ptep)
 {
-	if (mm->context.pgstes) {
+	if (mm->context.has_pgste) {
 		rcp_lock(ptep);
 		__ptep_ipte(address, ptep);
 		ptep_rcp_copy(ptep);
Index: quilt-2.6/arch/s390/mm/pgtable.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/pgtable.c
+++ quilt-2.6/arch/s390/mm/pgtable.c
@@ -169,7 +169,7 @@ unsigned long *page_table_alloc(struct m
 	unsigned long *table;
 	unsigned long bits;
 
-	bits = (mm->context.noexec || mm->context.pgstes) ? 3UL : 1UL;
+	bits = (mm->context.noexec || mm->context.has_pgste) ? 3UL : 1UL;
 	spin_lock(&mm->page_table_lock);
 	page = NULL;
 	if (!list_empty(&mm->context.pgtable_list)) {
@@ -186,7 +186,7 @@ unsigned long *page_table_alloc(struct m
 		pgtable_page_ctor(page);
 		page->flags &= ~FRAG_MASK;
 		table = (unsigned long *) page_to_phys(page);
-		if (mm->context.pgstes)
+		if (mm->context.has_pgste)
 			clear_table_pgstes(table);
 		else
 			clear_table(table, _PAGE_TYPE_EMPTY, PAGE_SIZE);
@@ -210,7 +210,7 @@ void page_table_free(struct mm_struct *m
 	struct page *page;
 	unsigned long bits;
 
-	bits = (mm->context.noexec || mm->context.pgstes) ? 3UL : 1UL;
+	bits = (mm->context.noexec || mm->context.has_pgste) ? 3UL : 1UL;
 	bits <<= (__pa(table) & (PAGE_SIZE - 1)) / 256 / sizeof(unsigned long);
 	page = pfn_to_page(__pa(table) >> PAGE_SHIFT);
 	spin_lock(&mm->page_table_lock);
@@ -257,7 +257,7 @@ int s390_enable_sie(void)
 	struct mm_struct *mm, *old_mm;
 
 	/* Do we have pgstes? if yes, we are done */
-	if (tsk->mm->context.pgstes)
+	if (tsk->mm->context.has_pgste)
 		return 0;
 
 	/* lets check if we are allowed to replace the mm */
@@ -269,14 +269,14 @@ int s390_enable_sie(void)
 	}
 	task_unlock(tsk);
 
-	/* we copy the mm with pgstes enabled */
-	tsk->mm->context.pgstes = 1;
+	/* we copy the mm and let dup_mm create the page tables with_pgstes */
+	tsk->mm->context.alloc_pgste = 1;
 	mm = dup_mm(tsk);
-	tsk->mm->context.pgstes = 0;
+	tsk->mm->context.alloc_pgste = 0;
 	if (!mm)
 		return -ENOMEM;
 
-	/* Now lets check again if somebody attached ptrace etc */
+	/* Now lets check again if something happened */
 	task_lock(tsk);
 	if (!tsk->mm || atomic_read(&tsk->mm->mm_users) > 1 ||
 	    tsk->mm != tsk->active_mm || tsk->mm->ioctx_list) {

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
