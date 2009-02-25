Return-Path: <linux-kernel-owner+w=401wt.eu-S1760434AbZBYPLR@vger.kernel.org>
Message-Id: <20090225150830.043564920@de.ibm.com>
References: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:06:33 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 11/46] arch/s390/kernel/process.c: fix whitespace damage
Content-Disposition: inline; filename=110-process-whitespace.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Fix all the whitespace damage in process.c, especially copy_thread().
Next patch will add code to copy_thread() which needs to 'fixed' first.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/process.c |   62 ++++++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 36 deletions(-)

Index: quilt-2.6/arch/s390/kernel/process.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/process.c
+++ quilt-2.6/arch/s390/kernel/process.c
@@ -1,18 +1,10 @@
 /*
- *  arch/s390/kernel/process.c
+ * This file handles the architecture dependent parts of process handling.
  *
- *  S390 version
- *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com),
- *               Hartmut Penner (hp@de.ibm.com),
- *               Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com),
- *
- *  Derived from "arch/i386/kernel/process.c"
- *    Copyright (C) 1995, Linus Torvalds
- */
-
-/*
- * This file handles the architecture-dependent parts of process handling..
+ *    Copyright IBM Corp. 1999,2009
+ *    Author(s): Martin Schwidefsky <schwidefsky@de.ibm.com>,
+ *		 Hartmut Penner <hp@de.ibm.com>,
+ *		 Denis Joseph Barrow,
  */
 
 #include <linux/compiler.h>
@@ -168,34 +160,34 @@ void release_thread(struct task_struct *
 }
 
 int copy_thread(int nr, unsigned long clone_flags, unsigned long new_stackp,
-	unsigned long unused,
-        struct task_struct * p, struct pt_regs * regs)
+		unsigned long unused,
+		struct task_struct *p, struct pt_regs *regs)
 {
-        struct fake_frame
-          {
-	    struct stack_frame sf;
-            struct pt_regs childregs;
-          } *frame;
+	struct fake_frame
+	{
+		struct stack_frame sf;
+		struct pt_regs childregs;
+	} *frame;
 
-        frame = container_of(task_pt_regs(p), struct fake_frame, childregs);
-        p->thread.ksp = (unsigned long) frame;
+	frame = container_of(task_pt_regs(p), struct fake_frame, childregs);
+	p->thread.ksp = (unsigned long) frame;
 	/* Store access registers to kernel stack of new process. */
-        frame->childregs = *regs;
+	frame->childregs = *regs;
 	frame->childregs.gprs[2] = 0;	/* child returns 0 on fork. */
-        frame->childregs.gprs[15] = new_stackp;
-        frame->sf.back_chain = 0;
+	frame->childregs.gprs[15] = new_stackp;
+	frame->sf.back_chain = 0;
 
-        /* new return point is ret_from_fork */
-        frame->sf.gprs[8] = (unsigned long) ret_from_fork;
+	/* new return point is ret_from_fork */
+	frame->sf.gprs[8] = (unsigned long) ret_from_fork;
 
-        /* fake return stack for resume(), don't go back to schedule */
-        frame->sf.gprs[9] = (unsigned long) frame;
+	/* fake return stack for resume(), don't go back to schedule */
+	frame->sf.gprs[9] = (unsigned long) frame;
 
 	/* Save access registers to new thread structure. */
 	save_access_regs(&p->thread.acrs[0]);
 
 #ifndef CONFIG_64BIT
-        /*
+	/*
 	 * save fprs to current->thread.fp_regs to merge them with
 	 * the emulated registers and then copy the result to the child.
 	 */
@@ -220,10 +212,9 @@ int copy_thread(int nr, unsigned long cl
 #endif /* CONFIG_64BIT */
 	/* start new process with ar4 pointing to the correct address space */
 	p->thread.mm_segment = get_fs();
-        /* Don't copy debug registers */
-        memset(&p->thread.per_info,0,sizeof(p->thread.per_info));
-
-        return 0;
+	/* Don't copy debug registers */
+	memset(&p->thread.per_info, 0, sizeof(p->thread.per_info));
+	return 0;
 }
 
 SYSCALL_DEFINE0(fork)
@@ -311,7 +302,7 @@ out:
 int dump_fpu (struct pt_regs * regs, s390_fp_regs *fpregs)
 {
 #ifndef CONFIG_64BIT
-        /*
+	/*
 	 * save fprs to current->thread.fp_regs to merge them with
 	 * the emulated registers and then copy the result to the dump.
 	 */
@@ -346,4 +337,3 @@ unsigned long get_wchan(struct task_stru
 	}
 	return 0;
 }
-

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
