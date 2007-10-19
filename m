Return-Path: <linux-kernel-owner+w=401wt.eu-S934272AbXJSRVV@vger.kernel.org>
Message-Id: <20071019171945.183678607@de.ibm.com>
References: <20071019171857.430999834@de.ibm.com>
Date: Fri, 19 Oct 2007 19:19:04 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 07/10] Remove unused user_seg from thread structure.
Content-Disposition: inline; filename=007-mm-userseg.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/process.c   |    2 --
 include/asm-s390/processor.h |   14 +++-----------
 2 files changed, 3 insertions(+), 13 deletions(-)

Index: quilt-2.6/arch/s390/kernel/process.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/process.c
+++ quilt-2.6/arch/s390/kernel/process.c
@@ -270,14 +270,12 @@ int copy_thread(int nr, unsigned long cl
 	save_fp_regs(&current->thread.fp_regs);
 	memcpy(&p->thread.fp_regs, &current->thread.fp_regs,
 	       sizeof(s390_fp_regs));
-        p->thread.user_seg = __pa((unsigned long) p->mm->pgd) | _SEGMENT_TABLE;
 	/* Set a new TLS ?  */
 	if (clone_flags & CLONE_SETTLS)
 		p->thread.acrs[0] = regs->gprs[6];
 #else /* CONFIG_64BIT */
 	/* Save the fpu registers to new thread structure. */
 	save_fp_regs(&p->thread.fp_regs);
-        p->thread.user_seg = __pa((unsigned long) p->mm->pgd) | _REGION_TABLE;
 	/* Set a new TLS ?  */
 	if (clone_flags & CLONE_SETTLS) {
 		if (test_thread_flag(TIF_31BIT)) {
Index: quilt-2.6/include/asm-s390/processor.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/processor.h
+++ quilt-2.6/include/asm-s390/processor.h
@@ -93,7 +93,6 @@ struct thread_struct {
 	s390_fp_regs fp_regs;
 	unsigned int  acrs[NUM_ACRS];
         unsigned long ksp;              /* kernel stack pointer             */
-        unsigned long user_seg;         /* HSTD                             */
 	mm_segment_t mm_segment;
         unsigned long prot_addr;        /* address of protection-excep.     */
         unsigned int error_code;        /* error-code of last prog-excep.   */
@@ -134,16 +133,9 @@ struct stack_frame {
 # define __SWAPPER_PG_DIR __pa(&swapper_pg_dir[0]) + _REGION_TABLE
 #endif /* __s390x__ */
 
-#define INIT_THREAD {{0,{{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},	       \
-			    {0},{0},{0},{0},{0},{0}}},			       \
-		     {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},	       \
-		     sizeof(init_stack) + (unsigned long) &init_stack,	       \
-		     __SWAPPER_PG_DIR,					       \
-		     {0},						       \
-		     0,0,0,						       \
-		     (per_struct) {{{{0,}}},0,0,0,0,{{0,}}},		       \
-		     0, 0						       \
-} 
+#define INIT_THREAD {							\
+	.ksp = sizeof(init_stack) + (unsigned long) &init_stack,	\
+}
 
 /*
  * Do necessary setup to start up a new thread.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
