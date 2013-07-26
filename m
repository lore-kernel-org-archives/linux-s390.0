From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 3/8] KVM: s390: allow sie enablement for multi-threaded programs
Date: Fri, 26 Jul 2013 15:04:02 +0200
Message-ID: <1374843847-5046-4-git-send-email-borntraeger@de.ibm.com>
References: <1374843847-5046-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1374843847-5046-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Improve the code to upgrade the standard 2K page tables to 4K page tables
with PGSTEs to allow the operation to happen when the program is already
multi-threaded.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/mmu.h         |   2 -
 arch/s390/include/asm/mmu_context.h |  19 +---
 arch/s390/include/asm/pgtable.h     |  11 +++
 arch/s390/mm/pgtable.c              | 181 +++++++++++++++++++++++-------------
 4 files changed, 129 insertions(+), 84 deletions(-)

diff --git a/arch/s390/include/asm/mmu.h b/arch/s390/include/asm/mmu.h
index 6340178..ff132ac 100644
--- a/arch/s390/include/asm/mmu.h
+++ b/arch/s390/include/asm/mmu.h
@@ -12,8 +12,6 @@ typedef struct {
 	unsigned long asce_bits;
 	unsigned long asce_limit;
 	unsigned long vdso_base;
-	/* Cloned contexts will be created with extended page tables. */
-	unsigned int alloc_pgste:1;
 	/* The mmu context has extended page tables. */
 	unsigned int has_pgste:1;
 } mm_context_t;
diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
index 084e775..4fb67a0 100644
--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -21,24 +21,7 @@ static inline int init_new_context(struct task_struct *tsk,
 #ifdef CONFIG_64BIT
 	mm->context.asce_bits |= _ASCE_TYPE_REGION3;
 #endif
-	if (current->mm && current->mm->context.alloc_pgste) {
-		/*
-		 * alloc_pgste indicates, that any NEW context will be created
-		 * with extended page tables. The old context is unchanged. The
-		 * page table allocation and the page table operations will
-		 * look at has_pgste to distinguish normal and extended page
-		 * tables. The only way to create extended page tables is to
-		 * set alloc_pgste and then create a new context (e.g. dup_mm).
-		 * The page table allocation is called after init_new_context
-		 * and if has_pgste is set, it will create extended page
-		 * tables.
-		 */
-		mm->context.has_pgste = 1;
-		mm->context.alloc_pgste = 1;
-	} else {
-		mm->context.has_pgste = 0;
-		mm->context.alloc_pgste = 0;
-	}
+	mm->context.has_pgste = 0;
 	mm->context.asce_limit = STACK_TOP_MAX;
 	crst_table_init((unsigned long *) mm->pgd, pgd_entry_type(mm));
 	return 0;
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 75fb726..7a60bb9 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1361,6 +1361,17 @@ static inline pmd_t pmd_mkwrite(pmd_t pmd)
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLB_PAGE */
 
+static inline void pmdp_flush_lazy(struct mm_struct *mm,
+				   unsigned long address, pmd_t *pmdp)
+{
+	int active = (mm == current->active_mm) ? 1 : 0;
+
+	if ((atomic_read(&mm->context.attach_count) & 0xffff) > active)
+		__pmd_idte(address, pmdp);
+	else
+		mm->context.flush_mm = 1;
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 
 #define __HAVE_ARCH_PGTABLE_DEPOSIT
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index a8154a1..6d33248 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -731,6 +731,11 @@ void gmap_do_ipte_notify(struct mm_struct *mm, unsigned long addr, pte_t *pte)
 	spin_unlock(&gmap_notifier_lock);
 }
 
+static inline int page_table_with_pgste(struct page *page)
+{
+	return atomic_read(&page->_mapcount) == 0;
+}
+
 static inline unsigned long *page_table_alloc_pgste(struct mm_struct *mm,
 						    unsigned long vmaddr)
 {
@@ -750,7 +755,7 @@ static inline unsigned long *page_table_alloc_pgste(struct mm_struct *mm,
 	mp->vmaddr = vmaddr & PMD_MASK;
 	INIT_LIST_HEAD(&mp->mapper);
 	page->index = (unsigned long) mp;
-	atomic_set(&page->_mapcount, 3);
+	atomic_set(&page->_mapcount, 0);
 	table = (unsigned long *) page_to_phys(page);
 	clear_table(table, _PAGE_TYPE_EMPTY, PAGE_SIZE/2);
 	clear_table(table + PTRS_PER_PTE, 0, PAGE_SIZE/2);
@@ -821,6 +826,11 @@ EXPORT_SYMBOL(set_guest_storage_key);
 
 #else /* CONFIG_PGSTE */
 
+static inline int page_table_with_pgste(struct page *page)
+{
+	return 0;
+}
+
 static inline unsigned long *page_table_alloc_pgste(struct mm_struct *mm,
 						    unsigned long vmaddr)
 {
@@ -897,12 +907,12 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
 	struct page *page;
 	unsigned int bit, mask;
 
-	if (mm_has_pgste(mm)) {
+	page = pfn_to_page(__pa(table) >> PAGE_SHIFT);
+	if (page_table_with_pgste(page)) {
 		gmap_disconnect_pgtable(mm, table);
 		return page_table_free_pgste(table);
 	}
 	/* Free 1K/2K page table fragment of a 4K page */
-	page = pfn_to_page(__pa(table) >> PAGE_SHIFT);
 	bit = 1 << ((__pa(table) & ~PAGE_MASK)/(PTRS_PER_PTE*sizeof(pte_t)));
 	spin_lock_bh(&mm->context.list_lock);
 	if ((atomic_read(&page->_mapcount) & FRAG_MASK) != FRAG_MASK)
@@ -940,14 +950,14 @@ void page_table_free_rcu(struct mmu_gather *tlb, unsigned long *table)
 	unsigned int bit, mask;
 
 	mm = tlb->mm;
-	if (mm_has_pgste(mm)) {
+	page = pfn_to_page(__pa(table) >> PAGE_SHIFT);
+	if (page_table_with_pgste(page)) {
 		gmap_disconnect_pgtable(mm, table);
 		table = (unsigned long *) (__pa(table) | FRAG_MASK);
 		tlb_remove_table(tlb, table);
 		return;
 	}
 	bit = 1 << ((__pa(table) & ~PAGE_MASK) / (PTRS_PER_PTE*sizeof(pte_t)));
-	page = pfn_to_page(__pa(table) >> PAGE_SHIFT);
 	spin_lock_bh(&mm->context.list_lock);
 	if ((atomic_read(&page->_mapcount) & FRAG_MASK) != FRAG_MASK)
 		list_del(&page->lru);
@@ -1033,36 +1043,120 @@ void tlb_remove_table(struct mmu_gather *tlb, void *table)
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-void thp_split_vma(struct vm_area_struct *vma)
+static inline void thp_split_vma(struct vm_area_struct *vma)
 {
 	unsigned long addr;
-	struct page *page;
 
-	for (addr = vma->vm_start; addr < vma->vm_end; addr += PAGE_SIZE) {
-		page = follow_page(vma, addr, FOLL_SPLIT);
-	}
+	for (addr = vma->vm_start; addr < vma->vm_end; addr += PAGE_SIZE)
+		follow_page(vma, addr, FOLL_SPLIT);
 }
 
-void thp_split_mm(struct mm_struct *mm)
+static inline void thp_split_mm(struct mm_struct *mm)
 {
-	struct vm_area_struct *vma = mm->mmap;
+	struct vm_area_struct *vma;
 
-	while (vma != NULL) {
+	for (vma = mm->mmap; vma != NULL; vma = vma->vm_next) {
 		thp_split_vma(vma);
 		vma->vm_flags &= ~VM_HUGEPAGE;
 		vma->vm_flags |= VM_NOHUGEPAGE;
-		vma = vma->vm_next;
 	}
+	mm->def_flags |= VM_NOHUGEPAGE;
+}
+#else
+static inline void thp_split_mm(struct mm_struct *mm)
+{
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
+static unsigned long page_table_realloc_pmd(struct mmu_gather *tlb,
+				struct mm_struct *mm, pud_t *pud,
+				unsigned long addr, unsigned long end)
+{
+	unsigned long next, *table, *new;
+	struct page *page;
+	pmd_t *pmd;
+
+	pmd = pmd_offset(pud, addr);
+	do {
+		next = pmd_addr_end(addr, end);
+again:
+		if (pmd_none_or_clear_bad(pmd))
+			continue;
+		table = (unsigned long *) pmd_deref(*pmd);
+		page = pfn_to_page(__pa(table) >> PAGE_SHIFT);
+		if (page_table_with_pgste(page))
+			continue;
+		/* Allocate new page table with pgstes */
+		new = page_table_alloc_pgste(mm, addr);
+		if (!new) {
+			mm->context.has_pgste = 0;
+			continue;
+		}
+		spin_lock(&mm->page_table_lock);
+		if (likely((unsigned long *) pmd_deref(*pmd) == table)) {
+			/* Nuke pmd entry pointing to the "short" page table */
+			pmdp_flush_lazy(mm, addr, pmd);
+			pmd_clear(pmd);
+			/* Copy ptes from old table to new table */
+			memcpy(new, table, PAGE_SIZE/2);
+			clear_table(table, _PAGE_INVALID, PAGE_SIZE/2);
+			/* Establish new table */
+			pmd_populate(mm, pmd, (pte_t *) new);
+			/* Free old table with rcu, there might be a walker! */
+			page_table_free_rcu(tlb, table);
+			new = NULL;
+		}
+		spin_unlock(&mm->page_table_lock);
+		if (new) {
+			page_table_free_pgste(new);
+			goto again;
+		}
+	} while (pmd++, addr = next, addr != end);
+
+	return addr;
+}
+
+static unsigned long page_table_realloc_pud(struct mmu_gather *tlb,
+				   struct mm_struct *mm, pgd_t *pgd,
+				   unsigned long addr, unsigned long end)
+{
+	unsigned long next;
+	pud_t *pud;
+
+	pud = pud_offset(pgd, addr);
+	do {
+		next = pud_addr_end(addr, end);
+		if (pud_none_or_clear_bad(pud))
+			continue;
+		next = page_table_realloc_pmd(tlb, mm, pud, addr, next);
+	} while (pud++, addr = next, addr != end);
+
+	return addr;
+}
+
+static void page_table_realloc(struct mmu_gather *tlb, struct mm_struct *mm,
+			       unsigned long addr, unsigned long end)
+{
+	unsigned long next;
+	pgd_t *pgd;
+
+	pgd = pgd_offset(mm, addr);
+	do {
+		next = pgd_addr_end(addr, end);
+		if (pgd_none_or_clear_bad(pgd))
+			continue;
+		next = page_table_realloc_pud(tlb, mm, pgd, addr, next);
+	} while (pgd++, addr = next, addr != end);
+}
+
 /*
  * switch on pgstes for its userspace process (for kvm)
  */
 int s390_enable_sie(void)
 {
 	struct task_struct *tsk = current;
-	struct mm_struct *mm, *old_mm;
+	struct mm_struct *mm = tsk->mm;
+	struct mmu_gather tlb;
 
 	/* Do we have switched amode? If no, we cannot do sie */
 	if (s390_user_mode == HOME_SPACE_MODE)
@@ -1072,57 +1166,16 @@ int s390_enable_sie(void)
 	if (mm_has_pgste(tsk->mm))
 		return 0;
 
-	/* lets check if we are allowed to replace the mm */
-	task_lock(tsk);
-	if (!tsk->mm || atomic_read(&tsk->mm->mm_users) > 1 ||
-#ifdef CONFIG_AIO
-	    !hlist_empty(&tsk->mm->ioctx_list) ||
-#endif
-	    tsk->mm != tsk->active_mm) {
-		task_unlock(tsk);
-		return -EINVAL;
-	}
-	task_unlock(tsk);
-
-	/* we copy the mm and let dup_mm create the page tables with_pgstes */
-	tsk->mm->context.alloc_pgste = 1;
-	/* make sure that both mms have a correct rss state */
-	sync_mm_rss(tsk->mm);
-	mm = dup_mm(tsk);
-	tsk->mm->context.alloc_pgste = 0;
-	if (!mm)
-		return -ENOMEM;
-
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	down_write(&mm->mmap_sem);
 	/* split thp mappings and disable thp for future mappings */
 	thp_split_mm(mm);
-	mm->def_flags |= VM_NOHUGEPAGE;
-#endif
-
-	/* Now lets check again if something happened */
-	task_lock(tsk);
-	if (!tsk->mm || atomic_read(&tsk->mm->mm_users) > 1 ||
-#ifdef CONFIG_AIO
-	    !hlist_empty(&tsk->mm->ioctx_list) ||
-#endif
-	    tsk->mm != tsk->active_mm) {
-		mmput(mm);
-		task_unlock(tsk);
-		return -EINVAL;
-	}
-
-	/* ok, we are alone. No ptrace, no threads, etc. */
-	old_mm = tsk->mm;
-	tsk->mm = tsk->active_mm = mm;
-	preempt_disable();
-	update_mm(mm, tsk);
-	atomic_inc(&mm->context.attach_count);
-	atomic_dec(&old_mm->context.attach_count);
-	cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
-	preempt_enable();
-	task_unlock(tsk);
-	mmput(old_mm);
-	return 0;
+	/* Reallocate the page tables with pgstes */
+	mm->context.has_pgste = 1;
+	tlb_gather_mmu(&tlb, mm, 0);
+	page_table_realloc(&tlb, mm, 0, TASK_SIZE);
+	tlb_finish_mmu(&tlb, 0, -1);
+	up_write(&mm->mmap_sem);
+	return mm->context.has_pgste ? 0 : -ENOMEM;
 }
 EXPORT_SYMBOL_GPL(s390_enable_sie);
 
-- 
1.8.3.1
