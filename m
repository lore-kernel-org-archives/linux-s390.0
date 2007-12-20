Return-Path: <linux-kernel-owner+w=401wt.eu-S1764184AbXLTP3Y@vger.kernel.org>
Message-Id: <20071220152112.640894891@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:20:09 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 44/47] single-step cleanup
Content-Disposition: inline; filename=143-single-step.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Roland McGrath <roland@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Roland McGrath <roland@redhat.com>

Signed-off-by: Roland McGrath <roland@redhat.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/ptrace.c |   15 ++++++---------
 arch/s390/kernel/signal.c |   20 +++++++++++++-------
 include/asm-s390/ptrace.h |    8 ++++++++
 3 files changed, 27 insertions(+), 16 deletions(-)

Index: quilt-2.6/arch/s390/kernel/ptrace.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/ptrace.c
+++ quilt-2.6/arch/s390/kernel/ptrace.c
@@ -86,13 +86,13 @@ FixPerRegisters(struct task_struct *task
 		per_info->control_regs.bits.storage_alt_space_ctl = 0;
 }
 
-static void set_single_step(struct task_struct *task)
+void user_enable_single_step(struct task_struct *task)
 {
 	task->thread.per_info.single_step = 1;
 	FixPerRegisters(task);
 }
 
-static void clear_single_step(struct task_struct *task)
+void user_disable_single_step(struct task_struct *task)
 {
 	task->thread.per_info.single_step = 0;
 	FixPerRegisters(task);
@@ -107,7 +107,7 @@ void
 ptrace_disable(struct task_struct *child)
 {
 	/* make sure the single step bit is not set. */
-	clear_single_step(child);
+	user_disable_single_step(child);
 }
 
 #ifndef CONFIG_64BIT
@@ -651,7 +651,7 @@ do_ptrace(struct task_struct *child, lon
 			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		child->exit_code = data;
 		/* make sure the single step bit is not set. */
-		clear_single_step(child);
+		user_disable_single_step(child);
 		wake_up_process(child);
 		return 0;
 
@@ -665,7 +665,7 @@ do_ptrace(struct task_struct *child, lon
 			return 0;
 		child->exit_code = SIGKILL;
 		/* make sure the single step bit is not set. */
-		clear_single_step(child);
+		user_disable_single_step(child);
 		wake_up_process(child);
 		return 0;
 
@@ -675,10 +675,7 @@ do_ptrace(struct task_struct *child, lon
 			return -EIO;
 		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		child->exit_code = data;
-		if (data)
-			set_tsk_thread_flag(child, TIF_SINGLE_STEP);
-		else
-			set_single_step(child);
+		user_enable_single_step(child);
 		/* give it a chance to run. */
 		wake_up_process(child);
 		return 0;
Index: quilt-2.6/arch/s390/kernel/signal.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/signal.c
+++ quilt-2.6/arch/s390/kernel/signal.c
@@ -471,6 +471,7 @@ void do_signal(struct pt_regs *regs)
 
 	if (signr > 0) {
 		/* Whee!  Actually deliver the signal.  */
+		int ret;
 #ifdef CONFIG_COMPAT
 		if (test_thread_flag(TIF_31BIT)) {
 			extern int handle_signal32(unsigned long sig,
@@ -478,15 +479,12 @@ void do_signal(struct pt_regs *regs)
 						   siginfo_t *info,
 						   sigset_t *oldset,
 						   struct pt_regs *regs);
-			if (handle_signal32(
-				    signr, &ka, &info, oldset, regs) == 0) {
-				if (test_thread_flag(TIF_RESTORE_SIGMASK))
-					clear_thread_flag(TIF_RESTORE_SIGMASK);
-			}
-			return;
+			ret = handle_signal32(signr, &ka, &info, oldset, regs);
 	        }
+		else
 #endif
-		if (handle_signal(signr, &ka, &info, oldset, regs) == 0) {
+			ret = handle_signal(signr, &ka, &info, oldset, regs);
+		if (!ret) {
 			/*
 			 * A signal was successfully delivered; the saved
 			 * sigmask will have been stored in the signal frame,
@@ -495,6 +493,14 @@ void do_signal(struct pt_regs *regs)
 			 */
 			if (test_thread_flag(TIF_RESTORE_SIGMASK))
 				clear_thread_flag(TIF_RESTORE_SIGMASK);
+
+			/*
+			 * If we would have taken a single-step trap
+			 * for a normal instruction, act like we took
+			 * one for the handler setup.
+			 */
+			if (current->thread.per_info.single_step)
+				set_thread_flag(TIF_SINGLE_STEP);
 		}
 		return;
 	}
Index: quilt-2.6/include/asm-s390/ptrace.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/ptrace.h
+++ quilt-2.6/include/asm-s390/ptrace.h
@@ -465,6 +465,14 @@ struct user_regs_struct
 #ifdef __KERNEL__
 #define __ARCH_SYS_PTRACE	1
 
+/*
+ * These are defined as per linux/ptrace.h, which see.
+ */
+#define arch_has_single_step()	(1)
+struct task_struct;
+extern void user_enable_single_step(struct task_struct *);
+extern void user_disable_single_step(struct task_struct *);
+
 #define user_mode(regs) (((regs)->psw.mask & PSW_MASK_PSTATE) != 0)
 #define instruction_pointer(regs) ((regs)->psw.addr & PSW_ADDR_INSN)
 #define regs_return_value(regs)((regs)->gprs[2])

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
