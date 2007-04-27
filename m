Return-Path: <linux-kernel-owner+w=401wt.eu-S1755871AbXD0OPt@vger.kernel.org>
Message-Id: <20070427140515.761777028@de.ibm.com>
References: <20070427140503.087958775@de.ibm.com>
Date: Fri, 27 Apr 2007 16:05:20 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 17/38] System call cleanup.
Content-Disposition: inline; filename=120-svc-glue.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Remove system call glue for sys_clone, sys_fork, sys_vfork, sys_execve,
sys_sigreturn, sys_rt_sigreturn and sys_sigaltstack. Call do_execve from
kernel_execve directly, move pt_regs to the right place and branch to
sysc_return to start the user space program. This removes the last
in-kernel system call.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/kernel/compat_linux.c  |   62 +++++++++++++-----------
 arch/s390/kernel/compat_signal.c |   14 +++--
 arch/s390/kernel/entry.S         |   87 ++++++++++++---------------------
 arch/s390/kernel/entry64.S       |  100 ++++++++++-----------------------------
 arch/s390/kernel/process.c       |   82 ++++++++++++++++++-------------
 arch/s390/kernel/signal.c        |   10 ++-
 arch/s390/kernel/sys_s390.c      |   20 -------
 arch/s390/kernel/syscalls.S      |   14 ++---
 8 files changed, 163 insertions(+), 226 deletions(-)

Index: quilt-2.6/arch/s390/kernel/compat_linux.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/compat_linux.c	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/arch/s390/kernel/compat_linux.c	2007-04-27 16:04:56.000000000 +0200
@@ -495,29 +495,34 @@
  * sys32_execve() executes a new program after the asm stub has set
  * things up for us.  This should basically do what I want it to.
  */
-asmlinkage long
-sys32_execve(struct pt_regs regs)
+asmlinkage long sys32_execve(void)
 {
-        int error;
-        char * filename;
-
-        filename = getname(compat_ptr(regs.orig_gpr2));
-        error = PTR_ERR(filename);
-        if (IS_ERR(filename))
+	struct pt_regs *regs = task_pt_regs(current);
+	char *filename;
+	unsigned long result;
+	int rc;
+
+	filename = getname(compat_ptr(regs->orig_gpr2));
+	if (IS_ERR(filename)) {
+		result = PTR_ERR(filename);
                 goto out;
-        error = compat_do_execve(filename, compat_ptr(regs.gprs[3]),
-				 compat_ptr(regs.gprs[4]), &regs);
-	if (error == 0)
-	{
-		task_lock(current);
-		current->ptrace &= ~PT_DTRACE;
-		task_unlock(current);
-		current->thread.fp_regs.fpc=0;
-		asm volatile("sfpc %0,0" : : "d" (0));
 	}
+	rc = compat_do_execve(filename, compat_ptr(regs->gprs[3]),
+			      compat_ptr(regs->gprs[4]), regs);
+	if (rc) {
+		result = rc;
+		goto out_putname;
+	}
+	task_lock(current);
+	current->ptrace &= ~PT_DTRACE;
+	task_unlock(current);
+	current->thread.fp_regs.fpc=0;
+	asm volatile("sfpc %0,0" : : "d" (0));
+	result = regs->gprs[2];
+out_putname:
         putname(filename);
 out:
-        return error;
+	return result;
 }
 
 
@@ -918,19 +923,20 @@
 	return sys_write(fd, buf, count);
 }
 
-asmlinkage long sys32_clone(struct pt_regs regs)
+asmlinkage long sys32_clone(void)
 {
-        unsigned long clone_flags;
-        unsigned long newsp;
+	struct pt_regs *regs = task_pt_regs(current);
+	unsigned long clone_flags;
+	unsigned long newsp;
 	int __user *parent_tidptr, *child_tidptr;
 
-        clone_flags = regs.gprs[3] & 0xffffffffUL;
-        newsp = regs.orig_gpr2 & 0x7fffffffUL;
-	parent_tidptr = compat_ptr(regs.gprs[4]);
-	child_tidptr = compat_ptr(regs.gprs[5]);
-        if (!newsp)
-                newsp = regs.gprs[15];
-        return do_fork(clone_flags, newsp, &regs, 0,
+	clone_flags = regs->gprs[3] & 0xffffffffUL;
+	newsp = regs->orig_gpr2 & 0x7fffffffUL;
+	parent_tidptr = compat_ptr(regs->gprs[4]);
+	child_tidptr = compat_ptr(regs->gprs[5]);
+	if (!newsp)
+		newsp = regs->gprs[15];
+	return do_fork(clone_flags, newsp, regs, 0,
 		       parent_tidptr, child_tidptr);
 }
 
Index: quilt-2.6/arch/s390/kernel/compat_signal.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/compat_signal.c	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/arch/s390/kernel/compat_signal.c	2007-04-27 16:04:56.000000000 +0200
@@ -255,9 +255,9 @@
 }
 
 asmlinkage long
-sys32_sigaltstack(const stack_t32 __user *uss, stack_t32 __user *uoss,
-							struct pt_regs *regs)
+sys32_sigaltstack(const stack_t32 __user *uss, stack_t32 __user *uoss)
 {
+	struct pt_regs *regs = task_pt_regs(current);
 	stack_t kss, koss;
 	unsigned long ss_sp;
 	int ret, err = 0;
@@ -344,8 +344,9 @@
 	return 0;
 }
 
-asmlinkage long sys32_sigreturn(struct pt_regs *regs)
+asmlinkage long sys32_sigreturn(void)
 {
+	struct pt_regs *regs = task_pt_regs(current);
 	sigframe32 __user *frame = (sigframe32 __user *)regs->gprs[15];
 	sigset_t set;
 
@@ -370,8 +371,9 @@
 	return 0;
 }
 
-asmlinkage long sys32_rt_sigreturn(struct pt_regs *regs)
+asmlinkage long sys32_rt_sigreturn(void)
 {
+	struct pt_regs *regs = task_pt_regs(current);
 	rt_sigframe32 __user *frame = (rt_sigframe32 __user *)regs->gprs[15];
 	sigset_t set;
 	stack_t st;
@@ -407,8 +409,8 @@
 	return regs->gprs[2];
 
 badframe:
-        force_sig(SIGSEGV, current);
-        return 0;
+	force_sig(SIGSEGV, current);
+	return 0;
 }	
 
 /*
Index: quilt-2.6/arch/s390/kernel/entry64.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/entry64.S	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/arch/s390/kernel/entry64.S	2007-04-27 16:04:56.000000000 +0200
@@ -244,8 +244,6 @@
 	jnz	sysc_tracesys
 	basr	%r14,%r8	# call sys_xxxx
 	stg	%r2,SP_R2(%r15) # store return value (change R2 on stack)
-				# ATTENTION: check sys_execve_glue before
-				# changing anything here !!
 
 sysc_return:
 	tm	SP_PSW+1(%r15),0x01	# returning to user ?
@@ -371,77 +369,35 @@
 	j	sysc_return
 
 #
-# clone, fork, vfork, exec and sigreturn need glue,
-# because they all expect pt_regs as parameter,
-# but are called with different parameter.
-# return-address is set up above
+# kernel_execve function needs to deal with pt_regs that is not
+# at the usual place
 #
-sys_clone_glue:
-	la	%r2,SP_PTREGS(%r15)	# load pt_regs
-	jg	sys_clone		# branch to sys_clone
-
-#ifdef CONFIG_COMPAT
-sys32_clone_glue:
-	la	%r2,SP_PTREGS(%r15)	# load pt_regs
-	jg	sys32_clone		# branch to sys32_clone
-#endif
-
-sys_fork_glue:
-	la	%r2,SP_PTREGS(%r15)	# load pt_regs
-	jg	sys_fork		# branch to sys_fork
-
-sys_vfork_glue:
-	la	%r2,SP_PTREGS(%r15)	# load pt_regs
-	jg	sys_vfork		# branch to sys_vfork
-
-sys_execve_glue:
-	la	%r2,SP_PTREGS(%r15)	# load pt_regs
-	lgr	%r12,%r14		# save return address
-	brasl	%r14,sys_execve 	# call sys_execve
-	ltgr	%r2,%r2 		# check if execve failed
-	bnz	0(%r12) 		# it did fail -> store result in gpr2
-	b	6(%r12) 		# SKIP STG 2,SP_R2(15) in
-					# system_call/sysc_tracesys
-#ifdef CONFIG_COMPAT
-sys32_execve_glue:
-	la	%r2,SP_PTREGS(%r15)	# load pt_regs
-	lgr	%r12,%r14		# save return address
-	brasl	%r14,sys32_execve	# call sys32_execve
-	ltgr	%r2,%r2 		# check if execve failed
-	bnz	0(%r12) 		# it did fail -> store result in gpr2
-	b	6(%r12) 		# SKIP STG 2,SP_R2(15) in
-					# system_call/sysc_tracesys
-#endif
-
-sys_sigreturn_glue:
-	la	%r2,SP_PTREGS(%r15)	# load pt_regs as parameter
-	jg	sys_sigreturn		# branch to sys_sigreturn
-
-#ifdef CONFIG_COMPAT
-sys32_sigreturn_glue:
-	la	%r2,SP_PTREGS(%r15)	# load pt_regs as parameter
-	jg	sys32_sigreturn 	# branch to sys32_sigreturn
-#endif
-
-sys_rt_sigreturn_glue:
-	la	%r2,SP_PTREGS(%r15)	# load pt_regs as parameter
-	jg	sys_rt_sigreturn	# branch to sys_sigreturn
-
-#ifdef CONFIG_COMPAT
-sys32_rt_sigreturn_glue:
-	la	%r2,SP_PTREGS(%r15)	# load pt_regs as parameter
-	jg	sys32_rt_sigreturn	# branch to sys32_sigreturn
-#endif
-
-sys_sigaltstack_glue:
-	la	%r4,SP_PTREGS(%r15)	# load pt_regs as parameter
-	jg	sys_sigaltstack 	# branch to sys_sigreturn
-
-#ifdef CONFIG_COMPAT
-sys32_sigaltstack_glue:
-	la	%r4,SP_PTREGS(%r15)	# load pt_regs as parameter
-	jg	sys32_sigaltstack_wrapper # branch to sys_sigreturn
-#endif
+	.globl	kernel_execve
+kernel_execve:
+	stmg	%r12,%r15,96(%r15)
+	lgr	%r14,%r15
+	aghi	%r15,-SP_SIZE
+	stg	%r14,__SF_BACKCHAIN(%r15)
+	la	%r12,SP_PTREGS(%r15)
+	xc	0(__PT_SIZE,%r12),0(%r12)
+	lgr	%r5,%r12
+	brasl	%r14,do_execve
+	ltgfr	%r2,%r2
+	je	0f
+	aghi	%r15,SP_SIZE
+	lmg	%r12,%r15,96(%r15)
+	br	%r14
+	# execve succeeded.
+0:	stnsm	__SF_EMPTY(%r15),0xfc	# disable interrupts
+	lg	%r15,__LC_KERNEL_STACK	# load ksp
+	aghi	%r15,-SP_SIZE		# make room for registers & psw
+	lg	%r13,__LC_SVC_NEW_PSW+8
+	lg	%r9,__LC_THREAD_INFO
+	mvc	SP_PTREGS(__PT_SIZE,%r15),0(%r12)	# copy pt_regs
+	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
+	stosm	__SF_EMPTY(%r15),0x03	# reenable interrupts
+	brasl	%r14,execve_tail
+	j	sysc_return
 
 /*
  * Program check handler routine
Index: quilt-2.6/arch/s390/kernel/entry.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/entry.S	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/arch/s390/kernel/entry.S	2007-04-27 16:04:56.000000000 +0200
@@ -249,8 +249,6 @@
 	bnz	BASED(sysc_tracesys)
 	basr	%r14,%r8	  # call sys_xxxx
 	st	%r2,SP_R2(%r15)   # store return value (change R2 on stack)
-				  # ATTENTION: check sys_execve_glue before
-				  # changing anything here !!
 
 sysc_return:
 	tm	SP_PSW+1(%r15),0x01	# returning to user ?
@@ -381,50 +379,37 @@
 	b	BASED(sysc_return)
 
 #
-# clone, fork, vfork, exec and sigreturn need glue,
-# because they all expect pt_regs as parameter,
-# but are called with different parameter.
-# return-address is set up above
+# kernel_execve function needs to deal with pt_regs that is not
+# at the usual place
 #
-sys_clone_glue:
-	la	%r2,SP_PTREGS(%r15)	# load pt_regs
-	l	%r1,BASED(.Lclone)
-	br	%r1			# branch to sys_clone
-
-sys_fork_glue:
-	la	%r2,SP_PTREGS(%r15)	# load pt_regs
-	l	%r1,BASED(.Lfork)
-	br	%r1			# branch to sys_fork
-
-sys_vfork_glue:
-	la	%r2,SP_PTREGS(%r15)	# load pt_regs
-	l	%r1,BASED(.Lvfork)
-	br	%r1			# branch to sys_vfork
-
-sys_execve_glue:
-	la	%r2,SP_PTREGS(%r15)	# load pt_regs
-	l	%r1,BASED(.Lexecve)
-	lr	%r12,%r14		# save return address
-	basr	%r14,%r1		# call sys_execve
-	ltr	%r2,%r2			# check if execve failed
-	bnz	0(%r12)			# it did fail -> store result in gpr2
-	b	4(%r12)			# SKIP ST 2,SP_R2(15) after BASR 14,8
-					# in system_call/sysc_tracesys
-
-sys_sigreturn_glue:
-	la	%r2,SP_PTREGS(%r15)	# load pt_regs as parameter
-	l	%r1,BASED(.Lsigreturn)
-	br	%r1			# branch to sys_sigreturn
-
-sys_rt_sigreturn_glue:
-	la	%r2,SP_PTREGS(%r15)	# load pt_regs as parameter
-	l	%r1,BASED(.Lrt_sigreturn)
-	br	%r1			# branch to sys_sigreturn
-
-sys_sigaltstack_glue:
-	la	%r4,SP_PTREGS(%r15)	# load pt_regs as parameter
-	l	%r1,BASED(.Lsigaltstack)
-	br	%r1			# branch to sys_sigreturn
+	.globl	kernel_execve
+kernel_execve:
+	stm	%r12,%r15,48(%r15)
+	lr	%r14,%r15
+	l	%r13,__LC_SVC_NEW_PSW+4
+	s	%r15,BASED(.Lc_spsize)
+	st	%r14,__SF_BACKCHAIN(%r15)
+	la	%r12,SP_PTREGS(%r15)
+	xc	0(__PT_SIZE,%r12),0(%r12)
+	l	%r1,BASED(.Ldo_execve)
+	lr	%r5,%r12
+	basr	%r14,%r1
+	ltr	%r2,%r2
+	be	BASED(0f)
+	a	%r15,BASED(.Lc_spsize)
+	lm	%r12,%r15,48(%r15)
+	br	%r14
+	# execve succeeded.
+0:	stnsm	__SF_EMPTY(%r15),0xfc	# disable interrupts
+	l	%r15,__LC_KERNEL_STACK	# load ksp
+	s	%r15,BASED(.Lc_spsize)	# make room for registers & psw
+	l	%r9,__LC_THREAD_INFO
+	mvc	SP_PTREGS(__PT_SIZE,%r15),0(%r12)	# copy pt_regs
+	xc	__SF_BACKCHAIN(4,%r15),__SF_BACKCHAIN(%r15)
+	stosm	__SF_EMPTY(%r15),0x03	# reenable interrupts
+	l	%r1,BASED(.Lexecve_tail)
+	basr	%r14,%r1
+	b	BASED(sysc_return)
 
 /*
  * Program check handler routine
@@ -1031,19 +1016,11 @@
 .Ldo_extint:	.long	do_extint
 .Ldo_signal:	.long	do_signal
 .Lhandle_per:	.long	do_single_step
+.Ldo_execve:	.long	do_execve
+.Lexecve_tail:	.long	execve_tail
 .Ljump_table:	.long	pgm_check_table
 .Lschedule:	.long	schedule
-.Lclone:	.long	sys_clone
-.Lexecve:	.long	sys_execve
-.Lfork: 	.long	sys_fork
-.Lrt_sigreturn: .long	sys_rt_sigreturn
-.Lrt_sigsuspend:
-		.long	sys_rt_sigsuspend
-.Lsigreturn:	.long	sys_sigreturn
-.Lsigsuspend:	.long	sys_sigsuspend
-.Lsigaltstack:	.long	sys_sigaltstack
 .Ltrace:	.long	syscall_trace
-.Lvfork:	.long	sys_vfork
 .Lschedtail:	.long	schedule_tail
 .Lsysc_table:	.long	sys_call_table
 #ifdef CONFIG_TRACE_IRQFLAGS
Index: quilt-2.6/arch/s390/kernel/process.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/process.c	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/arch/s390/kernel/process.c	2007-04-27 16:04:56.000000000 +0200
@@ -280,24 +280,26 @@
         return 0;
 }
 
-asmlinkage long sys_fork(struct pt_regs regs)
+asmlinkage long sys_fork(void)
 {
-	return do_fork(SIGCHLD, regs.gprs[15], &regs, 0, NULL, NULL);
+	struct pt_regs *regs = task_pt_regs(current);
+	return do_fork(SIGCHLD, regs->gprs[15], regs, 0, NULL, NULL);
 }
 
-asmlinkage long sys_clone(struct pt_regs regs)
+asmlinkage long sys_clone(void)
 {
-        unsigned long clone_flags;
-        unsigned long newsp;
+	struct pt_regs *regs = task_pt_regs(current);
+	unsigned long clone_flags;
+	unsigned long newsp;
 	int __user *parent_tidptr, *child_tidptr;
 
-        clone_flags = regs.gprs[3];
-        newsp = regs.orig_gpr2;
-	parent_tidptr = (int __user *) regs.gprs[4];
-	child_tidptr = (int __user *) regs.gprs[5];
-        if (!newsp)
-                newsp = regs.gprs[15];
-        return do_fork(clone_flags, newsp, &regs, 0,
+	clone_flags = regs->gprs[3];
+	newsp = regs->orig_gpr2;
+	parent_tidptr = (int __user *) regs->gprs[4];
+	child_tidptr = (int __user *) regs->gprs[5];
+	if (!newsp)
+		newsp = regs->gprs[15];
+	return do_fork(clone_flags, newsp, regs, 0,
 		       parent_tidptr, child_tidptr);
 }
 
@@ -311,40 +313,52 @@
  * do not have enough call-clobbered registers to hold all
  * the information you need.
  */
-asmlinkage long sys_vfork(struct pt_regs regs)
+asmlinkage long sys_vfork(void)
 {
+	struct pt_regs *regs = task_pt_regs(current);
 	return do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD,
-		       regs.gprs[15], &regs, 0, NULL, NULL);
+		       regs->gprs[15], regs, 0, NULL, NULL);
+}
+
+asmlinkage void execve_tail(void)
+{
+	task_lock(current);
+	current->ptrace &= ~PT_DTRACE;
+	task_unlock(current);
+	current->thread.fp_regs.fpc = 0;
+	if (MACHINE_HAS_IEEE)
+		asm volatile("sfpc %0,%0" : : "d" (0));
 }
 
 /*
  * sys_execve() executes a new program.
  */
-asmlinkage long sys_execve(struct pt_regs regs)
+asmlinkage long sys_execve(void)
 {
-        int error;
-        char * filename;
-
-        filename = getname((char __user *) regs.orig_gpr2);
-        error = PTR_ERR(filename);
-        if (IS_ERR(filename))
-                goto out;
-        error = do_execve(filename, (char __user * __user *) regs.gprs[3],
-			  (char __user * __user *) regs.gprs[4], &regs);
-	if (error == 0) {
-		task_lock(current);
-		current->ptrace &= ~PT_DTRACE;
-		task_unlock(current);
-		current->thread.fp_regs.fpc = 0;
-		if (MACHINE_HAS_IEEE)
-			asm volatile("sfpc %0,%0" : : "d" (0));
+	struct pt_regs *regs = task_pt_regs(current);
+	char *filename;
+	unsigned long result;
+	int rc;
+
+	filename = getname((char __user *) regs->orig_gpr2);
+	if (IS_ERR(filename)) {
+		result = PTR_ERR(filename);
+		goto out;
+	}
+	rc = do_execve(filename, (char __user * __user *) regs->gprs[3],
+		       (char __user * __user *) regs->gprs[4], regs);
+	if (rc) {
+		result = rc;
+		goto out_putname;
 	}
-        putname(filename);
+	execve_tail();
+	result = regs->gprs[2];
+out_putname:
+	putname(filename);
 out:
-        return error;
+	return result;
 }
 
-
 /*
  * fill in the FPU structure for a core dump.
  */
Index: quilt-2.6/arch/s390/kernel/signal.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/signal.c	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/arch/s390/kernel/signal.c	2007-04-27 16:04:56.000000000 +0200
@@ -102,9 +102,9 @@
 }
 
 asmlinkage long
-sys_sigaltstack(const stack_t __user *uss, stack_t __user *uoss,
-					struct pt_regs *regs)
+sys_sigaltstack(const stack_t __user *uss, stack_t __user *uoss)
 {
+	struct pt_regs *regs = task_pt_regs(current);
 	return do_sigaltstack(uss, uoss, regs->gprs[15]);
 }
 
@@ -163,8 +163,9 @@
 	return 0;
 }
 
-asmlinkage long sys_sigreturn(struct pt_regs *regs)
+asmlinkage long sys_sigreturn(void)
 {
+	struct pt_regs *regs = task_pt_regs(current);
 	sigframe __user *frame = (sigframe __user *)regs->gprs[15];
 	sigset_t set;
 
@@ -189,8 +190,9 @@
 	return 0;
 }
 
-asmlinkage long sys_rt_sigreturn(struct pt_regs *regs)
+asmlinkage long sys_rt_sigreturn(void)
 {
+	struct pt_regs *regs = task_pt_regs(current);
 	rt_sigframe __user *frame = (rt_sigframe __user *)regs->gprs[15];
 	sigset_t set;
 
Index: quilt-2.6/arch/s390/kernel/syscalls.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/syscalls.S	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/arch/s390/kernel/syscalls.S	2007-04-27 16:04:56.000000000 +0200
@@ -10,7 +10,7 @@
 
 NI_SYSCALL							/* 0 */
 SYSCALL(sys_exit,sys_exit,sys32_exit_wrapper)
-SYSCALL(sys_fork_glue,sys_fork_glue,sys_fork_glue)
+SYSCALL(sys_fork,sys_fork,sys_fork)
 SYSCALL(sys_read,sys_read,sys32_read_wrapper)
 SYSCALL(sys_write,sys_write,sys32_write_wrapper)
 SYSCALL(sys_open,sys_open,sys32_open_wrapper)			/* 5 */
@@ -19,7 +19,7 @@
 SYSCALL(sys_creat,sys_creat,sys32_creat_wrapper)
 SYSCALL(sys_link,sys_link,sys32_link_wrapper)
 SYSCALL(sys_unlink,sys_unlink,sys32_unlink_wrapper)		/* 10 */
-SYSCALL(sys_execve_glue,sys_execve_glue,sys32_execve_glue)
+SYSCALL(sys_execve,sys_execve,sys32_execve)
 SYSCALL(sys_chdir,sys_chdir,sys32_chdir_wrapper)
 SYSCALL(sys_time,sys_ni_syscall,sys32_time_wrapper)		/* old time syscall */
 SYSCALL(sys_mknod,sys_mknod,sys32_mknod_wrapper)
@@ -127,8 +127,8 @@
 SYSCALL(sys_sysinfo,sys_sysinfo,compat_sys_sysinfo_wrapper)
 SYSCALL(sys_ipc,sys_ipc,sys32_ipc_wrapper)
 SYSCALL(sys_fsync,sys_fsync,sys32_fsync_wrapper)
-SYSCALL(sys_sigreturn_glue,sys_sigreturn_glue,sys32_sigreturn_glue)
-SYSCALL(sys_clone_glue,sys_clone_glue,sys32_clone_glue)		/* 120 */
+SYSCALL(sys_sigreturn,sys_sigreturn,sys32_sigreturn)
+SYSCALL(sys_clone,sys_clone,sys32_clone)			/* 120 */
 SYSCALL(sys_setdomainname,sys_setdomainname,sys32_setdomainname_wrapper)
 SYSCALL(sys_newuname,s390x_newuname,sys32_newuname_wrapper)
 NI_SYSCALL							/* modify_ldt for i386 */
@@ -181,7 +181,7 @@
 SYSCALL(sys_setresgid16,sys_ni_syscall,sys32_setresgid16_wrapper)	/* 170 old setresgid16 syscall */
 SYSCALL(sys_getresgid16,sys_ni_syscall,sys32_getresgid16_wrapper)	/* old getresgid16 syscall */
 SYSCALL(sys_prctl,sys_prctl,sys32_prctl_wrapper)
-SYSCALL(sys_rt_sigreturn_glue,sys_rt_sigreturn_glue,sys32_rt_sigreturn_glue)
+SYSCALL(sys_rt_sigreturn,sys_rt_sigreturn,sys32_rt_sigreturn)
 SYSCALL(sys_rt_sigaction,sys_rt_sigaction,sys32_rt_sigaction_wrapper)
 SYSCALL(sys_rt_sigprocmask,sys_rt_sigprocmask,sys32_rt_sigprocmask_wrapper)	/* 175 */
 SYSCALL(sys_rt_sigpending,sys_rt_sigpending,sys32_rt_sigpending_wrapper)
@@ -194,11 +194,11 @@
 SYSCALL(sys_getcwd,sys_getcwd,sys32_getcwd_wrapper)
 SYSCALL(sys_capget,sys_capget,sys32_capget_wrapper)
 SYSCALL(sys_capset,sys_capset,sys32_capset_wrapper)		/* 185 */
-SYSCALL(sys_sigaltstack_glue,sys_sigaltstack_glue,sys32_sigaltstack_glue)
+SYSCALL(sys_sigaltstack,sys_sigaltstack,sys32_sigaltstack)
 SYSCALL(sys_sendfile,sys_sendfile64,sys32_sendfile_wrapper)
 NI_SYSCALL							/* streams1 */
 NI_SYSCALL							/* streams2 */
-SYSCALL(sys_vfork_glue,sys_vfork_glue,sys_vfork_glue)		/* 190 */
+SYSCALL(sys_vfork,sys_vfork,sys_vfork)				/* 190 */
 SYSCALL(sys_getrlimit,sys_getrlimit,compat_sys_getrlimit_wrapper)
 SYSCALL(sys_mmap2,sys_mmap2,sys32_mmap2_wrapper)
 SYSCALL(sys_truncate64,sys_ni_syscall,sys32_truncate64_wrapper)
Index: quilt-2.6/arch/s390/kernel/sys_s390.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/sys_s390.c	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/arch/s390/kernel/sys_s390.c	2007-04-27 16:04:56.000000000 +0200
@@ -266,23 +266,3 @@
 		return -EFAULT;
 	return sys_fadvise64_64(a.fd, a.offset, a.len, a.advice);
 }
-
-/*
- * Do a system call from kernel instead of calling sys_execve so we
- * end up with proper pt_regs.
- */
-int kernel_execve(const char *filename, char *const argv[], char *const envp[])
-{
-	register const char *__arg1 asm("2") = filename;
-	register char *const*__arg2 asm("3") = argv;
-	register char *const*__arg3 asm("4") = envp;
-	register long __svcres asm("2");
-	asm volatile(
-		"svc %b1"
-		: "=d" (__svcres)
-		: "i" (__NR_execve),
-		  "0" (__arg1),
-		  "d" (__arg2),
-		  "d" (__arg3) : "memory");
-	return __svcres;
-}

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
