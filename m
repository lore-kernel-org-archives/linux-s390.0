Return-Path: <linux-kernel-owner+w=401wt.eu-S966389AbXLTPle@vger.kernel.org>
Message-Id: <20071220152107.341575291@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:19:45 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 20/47] Fix tlb flushing with idte.
Content-Disposition: inline; filename=119-mm-idte.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The clear-by-asce operation of the idte instruction gets an asce
(address-space-control-element) as argument to specify which TLBs
need to get flushed. The current code passes a plain pointer to
the start of the pgd without the additional bits which would make
the pointer an asce. The current machines don't mind the difference
but a future model might want to use the designation type control
bits in the asce as a filter for the TLBs to flush.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/head64.S      |    2 +-
 include/asm-s390/mmu_context.h |   27 ++++++++++++---------------
 include/asm-s390/tlbflush.h    |   12 ++++++------
 3 files changed, 19 insertions(+), 22 deletions(-)

Index: quilt-2.6/arch/s390/kernel/head64.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/head64.S
+++ quilt-2.6/arch/s390/kernel/head64.S
@@ -157,7 +157,7 @@ startup_continue:
 	.long	0xb2b10000		# store facility list
 	tm	0xc8,0x08		# check bit for clearing-by-ASCE
 	bno	0f-.LPG1(%r13)
-	lhi	%r1,2094
+	lhi	%r1,2048
 	lhi	%r2,0
 	.long	0xb98e2001
 	oi	7(%r12),0x80		# set IDTE flag
Index: quilt-2.6/include/asm-s390/mmu_context.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/mmu_context.h
+++ quilt-2.6/include/asm-s390/mmu_context.h
@@ -12,10 +12,15 @@
 #include <asm/pgalloc.h>
 #include <asm-generic/mm_hooks.h>
 
-/*
- * get a new mmu context.. S390 don't know about contexts.
- */
-#define init_new_context(tsk,mm)        0
+static inline int init_new_context(struct task_struct *tsk,
+				   struct mm_struct *mm)
+{
+	mm->context = _ASCE_TABLE_LENGTH | _ASCE_USER_BITS;
+#ifdef CONFIG_64BIT
+	mm->context |= _ASCE_TYPE_REGION3;
+#endif
+	return 0;
+}
 
 #define destroy_context(mm)             do { } while (0)
 
@@ -27,19 +32,11 @@
 
 static inline void update_mm(struct mm_struct *mm, struct task_struct *tsk)
 {
-	pgd_t *pgd = mm->pgd;
-	unsigned long asce_bits;
-
-	/* Calculate asce bits from the first pgd table entry. */
-	asce_bits = _ASCE_TABLE_LENGTH | _ASCE_USER_BITS;
-#ifdef CONFIG_64BIT
-	asce_bits |= _ASCE_TYPE_REGION3;
-#endif
-	S390_lowcore.user_asce = asce_bits | __pa(pgd);
+	S390_lowcore.user_asce = mm->context | __pa(mm->pgd);
 	if (switch_amode) {
 		/* Load primary space page table origin. */
-		pgd_t *shadow_pgd = get_shadow_table(pgd) ? : pgd;
-		S390_lowcore.user_exec_asce = asce_bits | __pa(shadow_pgd);
+		pgd_t *shadow_pgd = get_shadow_table(mm->pgd) ? : mm->pgd;
+		S390_lowcore.user_exec_asce = mm->context | __pa(shadow_pgd);
 		asm volatile(LCTL_OPCODE" 1,1,%0\n"
 			     : : "m" (S390_lowcore.user_exec_asce) );
 	} else
Index: quilt-2.6/include/asm-s390/tlbflush.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/tlbflush.h
+++ quilt-2.6/include/asm-s390/tlbflush.h
@@ -42,11 +42,11 @@ static inline void __tlb_flush_global(vo
 /*
  * Flush all tlb entries of a page table on all cpus.
  */
-static inline void __tlb_flush_idte(pgd_t *pgd)
+static inline void __tlb_flush_idte(unsigned long asce)
 {
 	asm volatile(
 		"	.insn	rrf,0xb98e0000,0,%0,%1,0"
-		: : "a" (2048), "a" (__pa(pgd) & PAGE_MASK) : "cc" );
+		: : "a" (2048), "a" (asce) : "cc" );
 }
 
 static inline void __tlb_flush_mm(struct mm_struct * mm)
@@ -61,11 +61,11 @@ static inline void __tlb_flush_mm(struct
 	 * only ran on the local cpu.
 	 */
 	if (MACHINE_HAS_IDTE) {
-		pgd_t *shadow_pgd = get_shadow_table(mm->pgd);
+		pgd_t *shadow = get_shadow_table(mm->pgd);
 
-		if (shadow_pgd)
-			__tlb_flush_idte(shadow_pgd);
-		__tlb_flush_idte(mm->pgd);
+		if (shadow)
+			__tlb_flush_idte((unsigned long) shadow | mm->context);
+		__tlb_flush_idte((unsigned long) mm->pgd | mm->context);
 		return;
 	}
 	preempt_disable();

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
