Return-Path: <linux-kernel-owner+w=401wt.eu-S1757763AbZCRMuZ@vger.kernel.org>
Message-Id: <20090318124846.081782218@de.ibm.com>
References: <20090318124829.637003183@de.ibm.com>
Date: Wed, 18 Mar 2009 13:48:34 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 5/6] make page table walking more robust
Content-Disposition: inline; filename=005-page-walk.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Make page table walking on s390 more robust. The current code requires
that the pgd/pud/pmd/pte loop is only done for address ranges that are
below the end address of the last vma of the address space. But this
is not always true, e.g. the generic page table walker does not guarantee
this. Change TASK_SIZE/TASK_SIZE_OF to reflect the current size of the
address space. This makes the generic page table walker happy but it
breaks the upgrade of a 3 level page table to a 4 level page table.
To make the upgrade work again another fix is required.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/processor.h |    5 ++---
 arch/s390/mm/mmap.c               |    4 ++--
 arch/s390/mm/pgtable.c            |    2 ++
 3 files changed, 6 insertions(+), 5 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/processor.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/processor.h
+++ quilt-2.6/arch/s390/include/asm/processor.h
@@ -61,7 +61,7 @@ extern void print_cpu_info(struct cpuinf
 extern int get_cpu_capability(unsigned int *);
 
 /*
- * User space process size: 2GB for 31 bit, 4TB for 64 bit.
+ * User space process size: 2GB for 31 bit, 4TB or 8PT for 64 bit.
  */
 #ifndef __s390x__
 
@@ -70,8 +70,7 @@ extern int get_cpu_capability(unsigned i
 
 #else /* __s390x__ */
 
-#define TASK_SIZE_OF(tsk)	(test_tsk_thread_flag(tsk,TIF_31BIT) ? \
-					(1UL << 31) : (1UL << 53))
+#define TASK_SIZE_OF(tsk)	((tsk)->mm->context.asce_limit)
 #define TASK_UNMAPPED_BASE	(test_thread_flag(TIF_31BIT) ? \
 					(1UL << 30) : (1UL << 41))
 #define TASK_SIZE		TASK_SIZE_OF(current)
Index: quilt-2.6/arch/s390/mm/mmap.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/mmap.c
+++ quilt-2.6/arch/s390/mm/mmap.c
@@ -35,7 +35,7 @@
  * Leave an at least ~128 MB hole.
  */
 #define MIN_GAP (128*1024*1024)
-#define MAX_GAP (TASK_SIZE/6*5)
+#define MAX_GAP (STACK_TOP/6*5)
 
 static inline unsigned long mmap_base(void)
 {
@@ -46,7 +46,7 @@ static inline unsigned long mmap_base(vo
 	else if (gap > MAX_GAP)
 		gap = MAX_GAP;
 
-	return TASK_SIZE - (gap & PAGE_MASK);
+	return STACK_TOP - (gap & PAGE_MASK);
 }
 
 static inline int mmap_is_legacy(void)
Index: quilt-2.6/arch/s390/mm/pgtable.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/pgtable.c
+++ quilt-2.6/arch/s390/mm/pgtable.c
@@ -117,6 +117,7 @@ repeat:
 		crst_table_init(table, entry);
 		pgd_populate(mm, (pgd_t *) table, (pud_t *) pgd);
 		mm->pgd = (pgd_t *) table;
+		mm->task_size = mm->context.asce_limit;
 		table = NULL;
 	}
 	spin_unlock(&mm->page_table_lock);
@@ -154,6 +155,7 @@ void crst_table_downgrade(struct mm_stru
 			BUG();
 		}
 		mm->pgd = (pgd_t *) (pgd_val(*pgd) & _REGION_ENTRY_ORIGIN);
+		mm->task_size = mm->context.asce_limit;
 		crst_table_free(mm, (unsigned long *) pgd);
 	}
 	update_mm(mm, current);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
