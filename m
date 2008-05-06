Return-Path: <linux-kernel-owner+w=401wt.eu-S1764454AbYEFQFi@vger.kernel.org>
Message-Id: <20080506155112.277198997@de.ibm.com>
References: <20080506155027.974409738@de.ibm.com>
Date: Tue, 06 May 2008 17:50:33 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 6/8] compat ptrace cleanup
Content-Disposition: inline; filename=006-ptrace-compat.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Roland McGrath <roland@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Roland McGrath <roland@redhat.com>

This removes redundant arch code for generic ptrace requests
already handled by ptrace_request and compat_ptrace_request.
It simplifies things to just have the standard entry points,
and use the generic compat_sys_ptrace.

Signed-off-by: Roland McGrath <roland@redhat.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/compat_wrapper.S |    2 
 arch/s390/kernel/ptrace.c         |  100 ++------------------------------------
 include/asm-s390/ptrace.h         |    2 
 3 files changed, 9 insertions(+), 95 deletions(-)

Index: quilt-2.6/arch/s390/kernel/compat_wrapper.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/compat_wrapper.S
+++ quilt-2.6/arch/s390/kernel/compat_wrapper.S
@@ -121,7 +121,7 @@ sys32_ptrace_wrapper:
 	lgfr	%r3,%r3			# long
 	llgtr	%r4,%r4			# long
 	llgfr	%r5,%r5			# long
-	jg	sys_ptrace		# branch to system call
+	jg	compat_sys_ptrace	# branch to system call
 
 	.globl	sys32_alarm_wrapper
 sys32_alarm_wrapper:
Index: quilt-2.6/arch/s390/kernel/ptrace.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/ptrace.c
+++ quilt-2.6/arch/s390/kernel/ptrace.c
@@ -292,8 +292,7 @@ poke_user(struct task_struct *child, add
 	return 0;
 }
 
-static int
-do_ptrace_normal(struct task_struct *child, long request, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 {
 	ptrace_area parea; 
 	int copied, ret;
@@ -529,35 +528,19 @@ poke_user_emu31(struct task_struct *chil
 	return 0;
 }
 
-static int
-do_ptrace_emu31(struct task_struct *child, long request, long addr, long data)
+long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
+			compat_ulong_t caddr, compat_ulong_t cdata)
 {
-	unsigned int tmp;  /* 4 bytes !! */
+	unsigned long addr = caddr;
+	unsigned long data = cdata;
 	ptrace_area_emu31 parea; 
 	int copied, ret;
 
 	switch (request) {
-	case PTRACE_PEEKTEXT:
-	case PTRACE_PEEKDATA:
-		/* read word at location addr. */
-		copied = access_process_vm(child, addr, &tmp, sizeof(tmp), 0);
-		if (copied != sizeof(tmp))
-			return -EIO;
-		return put_user(tmp, (unsigned int __force __user *) data);
-
 	case PTRACE_PEEKUSR:
 		/* read the word at location addr in the USER area. */
 		return peek_user_emu31(child, addr, data);
 
-	case PTRACE_POKETEXT:
-	case PTRACE_POKEDATA:
-		/* write the word at location addr. */
-		tmp = data;
-		copied = access_process_vm(child, addr, &tmp, sizeof(tmp), 1);
-		if (copied != sizeof(tmp))
-			return -EIO;
-		return 0;
-
 	case PTRACE_POKEUSR:
 		/* write the word at location addr in the USER area */
 		return poke_user_emu31(child, addr, data);
@@ -587,82 +570,11 @@ do_ptrace_emu31(struct task_struct *chil
 			copied += sizeof(unsigned int);
 		}
 		return 0;
-	case PTRACE_GETEVENTMSG:
-		return put_user((__u32) child->ptrace_message,
-				(unsigned int __force __user *) data);
-	case PTRACE_GETSIGINFO:
-		if (child->last_siginfo == NULL)
-			return -EINVAL;
-		return copy_siginfo_to_user32((compat_siginfo_t
-					       __force __user *) data,
-					      child->last_siginfo);
-	case PTRACE_SETSIGINFO:
-		if (child->last_siginfo == NULL)
-			return -EINVAL;
-		return copy_siginfo_from_user32(child->last_siginfo,
-						(compat_siginfo_t
-						 __force __user *) data);
 	}
-	return ptrace_request(child, request, addr, data);
+	return compat_ptrace_request(child, request, addr, data);
 }
 #endif
 
-long arch_ptrace(struct task_struct *child, long request, long addr, long data)
-{
-	switch (request) {
-	case PTRACE_SYSCALL:
-		/* continue and stop at next (return from) syscall */
-	case PTRACE_CONT:
-		/* restart after signal. */
-		if (!valid_signal(data))
-			return -EIO;
-		if (request == PTRACE_SYSCALL)
-			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
-		else
-			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
-		child->exit_code = data;
-		/* make sure the single step bit is not set. */
-		user_disable_single_step(child);
-		wake_up_process(child);
-		return 0;
-
-	case PTRACE_KILL:
-		/*
-		 * make the child exit.  Best I can do is send it a sigkill. 
-		 * perhaps it should be put in the status that it wants to 
-		 * exit.
-		 */
-		if (child->exit_state == EXIT_ZOMBIE) /* already dead */
-			return 0;
-		child->exit_code = SIGKILL;
-		/* make sure the single step bit is not set. */
-		user_disable_single_step(child);
-		wake_up_process(child);
-		return 0;
-
-	case PTRACE_SINGLESTEP:
-		/* set the trap flag. */
-		if (!valid_signal(data))
-			return -EIO;
-		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
-		child->exit_code = data;
-		user_enable_single_step(child);
-		/* give it a chance to run. */
-		wake_up_process(child);
-		return 0;
-
-	/* Do requests that differ for 31/64 bit */
-	default:
-#ifdef CONFIG_COMPAT
-		if (test_thread_flag(TIF_31BIT))
-			return do_ptrace_emu31(child, request, addr, data);
-#endif
-		return do_ptrace_normal(child, request, addr, data);
-	}
-	/* Not reached.  */
-	return -EIO;
-}
-
 asmlinkage void
 syscall_trace(struct pt_regs *regs, int entryexit)
 {
Index: quilt-2.6/include/asm-s390/ptrace.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/ptrace.h
+++ quilt-2.6/include/asm-s390/ptrace.h
@@ -471,6 +471,8 @@ struct task_struct;
 extern void user_enable_single_step(struct task_struct *);
 extern void user_disable_single_step(struct task_struct *);
 
+#define __ARCH_WANT_COMPAT_SYS_PTRACE
+
 #define user_mode(regs) (((regs)->psw.mask & PSW_MASK_PSTATE) != 0)
 #define instruction_pointer(regs) ((regs)->psw.addr & PSW_ADDR_INSN)
 #define regs_return_value(regs)((regs)->gprs[2])

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
