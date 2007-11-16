Return-Path: <linux-kernel-owner+w=401wt.eu-S934009AbXKPO0r@vger.kernel.org>
Message-Id: <20071116142526.390441584@de.ibm.com>
References: <20071116142441.484714036@de.ibm.com>
Date: Fri, 16 Nov 2007 15:24:44 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 03/10] Fix irq tracing and lockdep_sys_exit calls.
Content-Disposition: inline; filename=003-lockdep.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Current support for TRACE_IRQFLAGS and lockdep_sys_exit is broken.
IRQ flag tracing is broken for program checks. Even worse is that
the newly introduced calls to lockdep_sys_exit are in the critical
section code which is not supposed to call any C functions. In
addition the checks if locks are still held are also done when
returning to kernel code which is broken as well.
Fix all this by disabling interrupts and machine checks at the
exit paths and then do the appropriate checks and calls.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/entry.S   |  109 +++++++++++++++++++++++++++++++--------------
 arch/s390/kernel/entry64.S |  106 ++++++++++++++++++++++++++++++-------------
 arch/s390/kernel/setup.c   |    4 +
 include/asm-s390/system.h  |    5 ++
 4 files changed, 158 insertions(+), 66 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/entry64.S linux-2.6-patched/arch/s390/kernel/entry64.S
--- linux-2.6/arch/s390/kernel/entry64.S	2007-11-16 14:27:30.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/entry64.S	2007-11-16 14:27:38.000000000 +0100
@@ -67,12 +67,28 @@ _TIF_WORK_INT = (_TIF_SIGPENDING | _TIF_
 	 brasl	%r14,trace_hardirqs_off
 	.endm
 
-	.macro	LOCKDEP_SYS_EXIT
-	 brasl	%r14,lockdep_sys_exit
+	.macro TRACE_IRQS_CHECK
+	tm	SP_PSW(%r15),0x03	# irqs enabled?
+	jz	0f
+	brasl	%r14,trace_hardirqs_on
+	j	1f
+0:	brasl	%r14,trace_hardirqs_off
+1:
 	.endm
 #else
 #define TRACE_IRQS_ON
 #define TRACE_IRQS_OFF
+#define TRACE_IRQS_CHECK
+#endif
+
+#ifdef CONFIG_LOCKDEP
+	.macro	LOCKDEP_SYS_EXIT
+	tm	SP_PSW+1(%r15),0x01	# returning to user ?
+	jz	0f
+	brasl	%r14,lockdep_sys_exit
+0:
+	.endm
+#else
 #define LOCKDEP_SYS_EXIT
 #endif
 
@@ -222,8 +238,6 @@ sysc_saveall:
 	llgh	%r7,__LC_SVC_INT_CODE	# get svc number from lowcore
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 sysc_vtime:
-	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
-	jz	sysc_do_svc
 	UPDATE_VTIME __LC_EXIT_TIMER,__LC_SYNC_ENTER_TIMER,__LC_USER_TIMER
 sysc_stime:
 	UPDATE_VTIME __LC_LAST_UPDATE_TIMER,__LC_EXIT_TIMER,__LC_SYSTEM_TIMER
@@ -257,19 +271,34 @@ sysc_noemu:
 
 sysc_return:
 	tm	SP_PSW+1(%r15),0x01	# returning to user ?
-	jno	sysc_leave
+	jno	sysc_restore
 	tm	__TI_flags+7(%r9),_TIF_WORK_SVC
 	jnz	sysc_work	# there is work to do (signals etc.)
+sysc_restore:
+#ifdef CONFIG_TRACE_IRQFLAGS
+	larl	%r1,sysc_restore_trace_psw
+	lpswe	0(%r1)
+sysc_restore_trace:
+	TRACE_IRQS_CHECK
 	LOCKDEP_SYS_EXIT
+#endif
 sysc_leave:
 	RESTORE_ALL __LC_RETURN_PSW,1
+sysc_done:
+
+#ifdef CONFIG_TRACE_IRQFLAGS
+	.align	8
+	.globl sysc_restore_trace_psw
+sysc_restore_trace_psw:
+	.quad	0, sysc_restore_trace
+#endif
 
 #
 # recheck if there is more work to do
 #
 sysc_work_loop:
 	tm	__TI_flags+7(%r9),_TIF_WORK_SVC
-	jz	sysc_leave	  # there is no work to do
+	jz	sysc_restore	  # there is no work to do
 #
 # One of the work bits is on. Find out which one.
 #
@@ -284,8 +313,8 @@ sysc_work:
 	jo	sysc_restart
 	tm	__TI_flags+7(%r9),_TIF_SINGLE_STEP
 	jo	sysc_singlestep
-	LOCKDEP_SYS_EXIT
-	j	sysc_leave
+	j	sysc_restore
+sysc_work_done:
 
 #
 # _TIF_NEED_RESCHED is set, call schedule
@@ -445,6 +474,7 @@ pgm_check_handler:
 pgm_no_vtime:
 #endif
 	lg	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
+	TRACE_IRQS_OFF
 	lgf	%r3,__LC_PGM_ILC	# load program interruption code
 	lghi	%r8,0x7f
 	ngr	%r8,%r3
@@ -484,6 +514,7 @@ pgm_per_std:
 pgm_no_vtime2:
 #endif
 	lg	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
+	TRACE_IRQS_OFF
 	lg	%r1,__TI_task(%r9)
 	tm	SP_PSW+1(%r15),0x01	# kernel per event ?
 	jz	kernel_per
@@ -504,12 +535,9 @@ pgm_svcper:
 	SAVE_ALL_SYNC __LC_SVC_OLD_PSW,__LC_SAVE_AREA
 	CREATE_STACK_FRAME __LC_SVC_OLD_PSW,__LC_SAVE_AREA
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
-	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
-	jz	pgm_no_vtime3
 	UPDATE_VTIME __LC_EXIT_TIMER,__LC_SYNC_ENTER_TIMER,__LC_USER_TIMER
 	UPDATE_VTIME __LC_LAST_UPDATE_TIMER,__LC_EXIT_TIMER,__LC_SYSTEM_TIMER
 	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_SYNC_ENTER_TIMER
-pgm_no_vtime3:
 #endif
 	llgh	%r7,__LC_SVC_INT_CODE	# get svc number from lowcore
 	lg	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
@@ -529,7 +557,7 @@ kernel_per:
 	lhi	%r0,__LC_PGM_OLD_PSW
 	sth	%r0,SP_TRAP(%r15)	# set trap indication to pgm check
 	la	%r2,SP_PTREGS(%r15)	# address of register-save area
-	larl	%r14,sysc_leave		# load adr. of system ret, no work
+	larl	%r14,sysc_restore	# load adr. of system ret, no work
 	jg	do_single_step		# branch to do_single_step
 
 /*
@@ -554,26 +582,38 @@ io_no_vtime:
 	TRACE_IRQS_OFF
 	la	%r2,SP_PTREGS(%r15)	# address of register-save area
 	brasl	%r14,do_IRQ		# call standard irq handler
-	TRACE_IRQS_ON
-
 io_return:
 	tm	SP_PSW+1(%r15),0x01	# returning to user ?
 #ifdef CONFIG_PREEMPT
 	jno	io_preempt		# no -> check for preemptive scheduling
 #else
-	jno	io_leave		# no-> skip resched & signal
+	jno	io_restore		# no-> skip resched & signal
 #endif
 	tm	__TI_flags+7(%r9),_TIF_WORK_INT
 	jnz	io_work 		# there is work to do (signals etc.)
+io_restore:
+#ifdef CONFIG_TRACE_IRQFLAGS
+	larl	%r1,io_restore_trace_psw
+	lpswe	0(%r1)
+io_restore_trace:
+	TRACE_IRQS_CHECK
 	LOCKDEP_SYS_EXIT
+#endif
 io_leave:
 	RESTORE_ALL __LC_RETURN_PSW,0
 io_done:
 
+#ifdef CONFIG_TRACE_IRQFLAGS
+	.align	8
+	.globl io_restore_trace_psw
+io_restore_trace_psw:
+	.quad	0, io_restore_trace
+#endif
+
 #ifdef CONFIG_PREEMPT
 io_preempt:
 	icm	%r0,15,__TI_precount(%r9)
-	jnz	io_leave
+	jnz	io_restore
 	# switch to kernel stack
 	lg	%r1,SP_R15(%r15)
 	aghi	%r1,-SP_SIZE
@@ -582,12 +622,14 @@ io_preempt:
 	lgr	%r15,%r1
 io_resume_loop:
 	tm	__TI_flags+7(%r9),_TIF_NEED_RESCHED
-	jno	io_leave
+	jno	io_restore
 	larl	%r1,.Lc_pactive
 	mvc	__TI_precount(4,%r9),0(%r1)
+	TRACE_IRQS_ON
 	stosm	__SF_EMPTY(%r15),0x03	# reenable interrupts
 	brasl	%r14,schedule		# call schedule
 	stnsm	__SF_EMPTY(%r15),0xfc	# disable I/O and ext. interrupts
+	TRACE_IRQS_OFF
 	xc	__TI_precount(4,%r9),__TI_precount(%r9)
 	j	io_resume_loop
 #endif
@@ -613,37 +655,39 @@ io_work_loop:
 	jo	io_reschedule
 	tm	__TI_flags+7(%r9),(_TIF_SIGPENDING | _TIF_RESTORE_SIGMASK)
 	jnz	io_sigpending
-	LOCKDEP_SYS_EXIT
-	j	io_leave
+	j	io_restore
+io_work_done:
 
 #
 # _TIF_MCCK_PENDING is set, call handler
 #
 io_mcck_pending:
-	TRACE_IRQS_OFF
 	brasl	%r14,s390_handle_mcck	# TIF bit will be cleared by handler
-	TRACE_IRQS_ON
 	j	io_work_loop
 
 #
 # _TIF_NEED_RESCHED is set, call schedule
 #
 io_reschedule:
+	TRACE_IRQS_ON
 	stosm	__SF_EMPTY(%r15),0x03	# reenable interrupts
 	brasl	%r14,schedule		# call scheduler
 	stnsm	__SF_EMPTY(%r15),0xfc	# disable I/O and ext. interrupts
+	TRACE_IRQS_OFF
 	tm	__TI_flags+7(%r9),_TIF_WORK_INT
-	jz	io_leave		# there is no work to do
+	jz	io_restore		# there is no work to do
 	j	io_work_loop
 
 #
 # _TIF_SIGPENDING or _TIF_RESTORE_SIGMASK is set, call do_signal
 #
 io_sigpending:
+	TRACE_IRQS_ON
 	stosm	__SF_EMPTY(%r15),0x03	# reenable interrupts
 	la	%r2,SP_PTREGS(%r15)	# load pt_regs
 	brasl	%r14,do_signal		# call do_signal
 	stnsm	__SF_EMPTY(%r15),0xfc	# disable I/O and ext. interrupts
+	TRACE_IRQS_OFF
 	j	io_work_loop
 
 /*
@@ -669,7 +713,6 @@ ext_no_vtime:
 	la	%r2,SP_PTREGS(%r15)	# address of register-save area
 	llgh	%r3,__LC_EXT_INT_CODE	# get interruption code
 	brasl	%r14,do_extint
-	TRACE_IRQS_ON
 	j	io_return
 
 __critical_end:
@@ -824,15 +867,15 @@ cleanup_table_system_call:
 cleanup_table_sysc_return:
 	.quad	sysc_return, sysc_leave
 cleanup_table_sysc_leave:
-	.quad	sysc_leave, sysc_work_loop
+	.quad	sysc_leave, sysc_done
 cleanup_table_sysc_work_loop:
-	.quad	sysc_work_loop, sysc_reschedule
+	.quad	sysc_work_loop, sysc_work_done
 cleanup_table_io_return:
 	.quad	io_return, io_leave
 cleanup_table_io_leave:
 	.quad	io_leave, io_done
 cleanup_table_io_work_loop:
-	.quad	io_work_loop, io_mcck_pending
+	.quad	io_work_loop, io_work_done
 
 cleanup_critical:
 	clc	8(8,%r12),BASED(cleanup_table_system_call)
@@ -901,8 +944,6 @@ cleanup_system_call:
 cleanup_vtime:
 	clc	__LC_RETURN_PSW+8(8),BASED(cleanup_system_call_insn+24)
 	jhe	cleanup_stime
-	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
-	jz	cleanup_novtime
 	UPDATE_VTIME __LC_EXIT_TIMER,__LC_SYNC_ENTER_TIMER,__LC_USER_TIMER
 cleanup_stime:
 	clc	__LC_RETURN_PSW+8(8),BASED(cleanup_system_call_insn+32)
@@ -910,7 +951,6 @@ cleanup_stime:
 	UPDATE_VTIME __LC_LAST_UPDATE_TIMER,__LC_EXIT_TIMER,__LC_SYSTEM_TIMER
 cleanup_update:
 	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_SYNC_ENTER_TIMER
-cleanup_novtime:
 #endif
 	mvc	__LC_RETURN_PSW+8(8),BASED(cleanup_table_system_call+8)
 	la	%r12,__LC_RETURN_PSW
@@ -949,10 +989,10 @@ cleanup_sysc_leave:
 2:	la	%r12,__LC_RETURN_PSW
 	br	%r14
 cleanup_sysc_leave_insn:
+	.quad	sysc_done - 4
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
-	.quad	sysc_leave + 16
+	.quad	sysc_done - 8
 #endif
-	.quad	sysc_leave + 12
 
 cleanup_io_return:
 	mvc	__LC_RETURN_PSW(8),0(%r12)
@@ -979,10 +1019,10 @@ cleanup_io_leave:
 2:	la	%r12,__LC_RETURN_PSW
 	br	%r14
 cleanup_io_leave_insn:
+	.quad	io_done - 4
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
-	.quad	io_leave + 20
+	.quad	io_done - 8
 #endif
-	.quad	io_leave + 16
 
 /*
  * Integer constants
diff -urpN linux-2.6/arch/s390/kernel/entry.S linux-2.6-patched/arch/s390/kernel/entry.S
--- linux-2.6/arch/s390/kernel/entry.S	2007-11-16 14:27:30.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/entry.S	2007-11-16 14:27:38.000000000 +0100
@@ -69,13 +69,31 @@ STACK_SIZE  = 1 << STACK_SHIFT
 	basr	%r14,%r1
 	.endm
 
-	.macro	LOCKDEP_SYS_EXIT
-	l	%r1,BASED(.Llockdep_sys_exit)
+	.macro	TRACE_IRQS_CHECK
+	tm	SP_PSW(%r15),0x03	# irqs enabled?
+	jz	0f
+	l	%r1,BASED(.Ltrace_irq_on)
+	basr	%r14,%r1
+	j	1f
+0:	l	%r1,BASED(.Ltrace_irq_off)
 	basr	%r14,%r1
+1:
 	.endm
 #else
 #define TRACE_IRQS_ON
 #define TRACE_IRQS_OFF
+#define TRACE_IRQS_CHECK
+#endif
+
+#ifdef CONFIG_LOCKDEP
+	.macro	LOCKDEP_SYS_EXIT
+	tm	SP_PSW+1(%r15),0x01	# returning to user ?
+	jz	0f
+	l	%r1,BASED(.Llockdep_sys_exit)
+	basr	%r14,%r1
+0:
+	.endm
+#else
 #define LOCKDEP_SYS_EXIT
 #endif
 
@@ -234,8 +252,6 @@ sysc_saveall:
 	lh	%r7,0x8a	  # get svc number from lowcore
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 sysc_vtime:
-	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
-	bz	BASED(sysc_do_svc)
 	UPDATE_VTIME __LC_EXIT_TIMER,__LC_SYNC_ENTER_TIMER,__LC_USER_TIMER
 sysc_stime:
 	UPDATE_VTIME __LC_LAST_UPDATE_TIMER,__LC_EXIT_TIMER,__LC_SYSTEM_TIMER
@@ -263,19 +279,34 @@ sysc_do_restart:
 
 sysc_return:
 	tm	SP_PSW+1(%r15),0x01	# returning to user ?
-	bno	BASED(sysc_leave)
+	bno	BASED(sysc_restore)
 	tm	__TI_flags+3(%r9),_TIF_WORK_SVC
 	bnz	BASED(sysc_work)  # there is work to do (signals etc.)
+sysc_restore:
+#ifdef CONFIG_TRACE_IRQFLAGS
+	la	%r1,BASED(sysc_restore_trace_psw)
+	lpsw	0(%r1)
+sysc_restore_trace:
+	TRACE_IRQS_CHECK
 	LOCKDEP_SYS_EXIT
+#endif
 sysc_leave:
 	RESTORE_ALL __LC_RETURN_PSW,1
+sysc_done:
+
+#ifdef CONFIG_TRACE_IRQFLAGS
+	.align	8
+	.globl	sysc_restore_trace_psw
+sysc_restore_trace_psw:
+	.long	0, sysc_restore_trace + 0x80000000
+#endif
 
 #
 # recheck if there is more work to do
 #
 sysc_work_loop:
 	tm	__TI_flags+3(%r9),_TIF_WORK_SVC
-	bz	BASED(sysc_leave)	# there is no work to do
+	bz	BASED(sysc_restore)	# there is no work to do
 #
 # One of the work bits is on. Find out which one.
 #
@@ -290,8 +321,8 @@ sysc_work:
 	bo	BASED(sysc_restart)
 	tm	__TI_flags+3(%r9),_TIF_SINGLE_STEP
 	bo	BASED(sysc_singlestep)
-	LOCKDEP_SYS_EXIT
-	b	BASED(sysc_leave)
+	b	BASED(sysc_restore)
+sysc_work_done:
 
 #
 # _TIF_NEED_RESCHED is set, call schedule
@@ -458,6 +489,7 @@ pgm_check_handler:
 pgm_no_vtime:
 #endif
 	l	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
+	TRACE_IRQS_OFF
 	l	%r3,__LC_PGM_ILC	# load program interruption code
 	la	%r8,0x7f
 	nr	%r8,%r3
@@ -497,6 +529,7 @@ pgm_per_std:
 pgm_no_vtime2:
 #endif
 	l	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
+	TRACE_IRQS_OFF
 	l	%r1,__TI_task(%r9)
 	mvc	__THREAD_per+__PER_atmid(2,%r1),__LC_PER_ATMID
 	mvc	__THREAD_per+__PER_address(4,%r1),__LC_PER_ADDRESS
@@ -517,15 +550,13 @@ pgm_svcper:
 	SAVE_ALL_SYNC __LC_SVC_OLD_PSW,__LC_SAVE_AREA
 	CREATE_STACK_FRAME __LC_SVC_OLD_PSW,__LC_SAVE_AREA
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
-	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
-	bz	BASED(pgm_no_vtime3)
 	UPDATE_VTIME __LC_EXIT_TIMER,__LC_SYNC_ENTER_TIMER,__LC_USER_TIMER
 	UPDATE_VTIME __LC_LAST_UPDATE_TIMER,__LC_EXIT_TIMER,__LC_SYSTEM_TIMER
 	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_SYNC_ENTER_TIMER
-pgm_no_vtime3:
 #endif
 	lh	%r7,0x8a		# get svc number from lowcore
 	l	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
+	TRACE_IRQS_OFF
 	l	%r1,__TI_task(%r9)
 	mvc	__THREAD_per+__PER_atmid(2,%r1),__LC_PER_ATMID
 	mvc	__THREAD_per+__PER_address(4,%r1),__LC_PER_ADDRESS
@@ -542,7 +573,7 @@ kernel_per:
 	mvi	SP_TRAP+1(%r15),0x28	# set trap indication to pgm check
 	la	%r2,SP_PTREGS(%r15)	# address of register-save area
 	l	%r1,BASED(.Lhandle_per)	# load adr. of per handler
-	la	%r14,BASED(sysc_leave)	# load adr. of system return
+	la	%r14,BASED(sysc_restore)# load adr. of system return
 	br	%r1			# branch to do_single_step
 
 /*
@@ -569,26 +600,38 @@ io_no_vtime:
 	l	%r1,BASED(.Ldo_IRQ)	# load address of do_IRQ
 	la	%r2,SP_PTREGS(%r15)	# address of register-save area
 	basr	%r14,%r1		# branch to standard irq handler
-	TRACE_IRQS_ON
-
 io_return:
 	tm	SP_PSW+1(%r15),0x01	# returning to user ?
 #ifdef CONFIG_PREEMPT
 	bno	BASED(io_preempt)	# no -> check for preemptive scheduling
 #else
-	bno	BASED(io_leave) 	# no-> skip resched & signal
+	bno	BASED(io_restore)	# no-> skip resched & signal
 #endif
 	tm	__TI_flags+3(%r9),_TIF_WORK_INT
 	bnz	BASED(io_work)		# there is work to do (signals etc.)
+io_restore:
+#ifdef CONFIG_TRACE_IRQFLAGS
+	la	%r1,BASED(io_restore_trace_psw)
+	lpsw	0(%r1)
+io_restore_trace:
+	TRACE_IRQS_CHECK
 	LOCKDEP_SYS_EXIT
+#endif
 io_leave:
 	RESTORE_ALL __LC_RETURN_PSW,0
 io_done:
 
+#ifdef CONFIG_TRACE_IRQFLAGS
+	.align	8
+	.globl	io_restore_trace_psw
+io_restore_trace_psw:
+	.long	0, io_restore_trace + 0x80000000
+#endif
+
 #ifdef CONFIG_PREEMPT
 io_preempt:
 	icm	%r0,15,__TI_precount(%r9)
-	bnz	BASED(io_leave)
+	bnz	BASED(io_restore)
 	l	%r1,SP_R15(%r15)
 	s	%r1,BASED(.Lc_spsize)
 	mvc	SP_PTREGS(__PT_SIZE,%r1),SP_PTREGS(%r15)
@@ -596,12 +639,14 @@ io_preempt:
 	lr	%r15,%r1
 io_resume_loop:
 	tm	__TI_flags+3(%r9),_TIF_NEED_RESCHED
-	bno	BASED(io_leave)
+	bno	BASED(io_restore)
 	mvc	__TI_precount(4,%r9),BASED(.Lc_pactive)
+	TRACE_IRQS_ON
 	stosm	__SF_EMPTY(%r15),0x03  # reenable interrupts
 	l	%r1,BASED(.Lschedule)
 	basr	%r14,%r1	       # call schedule
 	stnsm	__SF_EMPTY(%r15),0xfc  # disable I/O and ext. interrupts
+	TRACE_IRQS_OFF
 	xc	__TI_precount(4,%r9),__TI_precount(%r9)
 	b	BASED(io_resume_loop)
 #endif
@@ -627,40 +672,42 @@ io_work_loop:
 	bo	BASED(io_reschedule)
 	tm	__TI_flags+3(%r9),(_TIF_SIGPENDING | _TIF_RESTORE_SIGMASK)
 	bnz	BASED(io_sigpending)
-	LOCKDEP_SYS_EXIT
-	b	BASED(io_leave)
+	b	BASED(io_restore)
+io_work_done:
 
 #
 # _TIF_MCCK_PENDING is set, call handler
 #
 io_mcck_pending:
-	TRACE_IRQS_OFF
 	l	%r1,BASED(.Ls390_handle_mcck)
 	basr	%r14,%r1		# TIF bit will be cleared by handler
-	TRACE_IRQS_ON
 	b	BASED(io_work_loop)
 
 #
 # _TIF_NEED_RESCHED is set, call schedule
 #
 io_reschedule:
+	TRACE_IRQS_ON
 	l	%r1,BASED(.Lschedule)
 	stosm	__SF_EMPTY(%r15),0x03	# reenable interrupts
 	basr	%r14,%r1		# call scheduler
 	stnsm	__SF_EMPTY(%r15),0xfc	# disable I/O and ext. interrupts
+	TRACE_IRQS_OFF
 	tm	__TI_flags+3(%r9),_TIF_WORK_INT
-	bz	BASED(io_leave) 	# there is no work to do
+	bz	BASED(io_restore)	# there is no work to do
 	b	BASED(io_work_loop)
 
 #
 # _TIF_SIGPENDING or _TIF_RESTORE_SIGMASK is set, call do_signal
 #
 io_sigpending:
+	TRACE_IRQS_ON
 	stosm	__SF_EMPTY(%r15),0x03	# reenable interrupts
 	la	%r2,SP_PTREGS(%r15)	# load pt_regs
 	l	%r1,BASED(.Ldo_signal)
 	basr	%r14,%r1		# call do_signal
 	stnsm	__SF_EMPTY(%r15),0xfc	# disable I/O and ext. interrupts
+	TRACE_IRQS_OFF
 	b	BASED(io_work_loop)
 
 /*
@@ -688,7 +735,6 @@ ext_no_vtime:
 	lh	%r3,__LC_EXT_INT_CODE	# get interruption code
 	l	%r1,BASED(.Ldo_extint)
 	basr	%r14,%r1
-	TRACE_IRQS_ON
 	b	BASED(io_return)
 
 __critical_end:
@@ -853,15 +899,15 @@ cleanup_table_system_call:
 cleanup_table_sysc_return:
 	.long	sysc_return + 0x80000000, sysc_leave + 0x80000000
 cleanup_table_sysc_leave:
-	.long	sysc_leave + 0x80000000, sysc_work_loop + 0x80000000
+	.long	sysc_leave + 0x80000000, sysc_done + 0x80000000
 cleanup_table_sysc_work_loop:
-	.long	sysc_work_loop + 0x80000000, sysc_reschedule + 0x80000000
+	.long	sysc_work_loop + 0x80000000, sysc_work_done + 0x80000000
 cleanup_table_io_return:
 	.long	io_return + 0x80000000, io_leave + 0x80000000
 cleanup_table_io_leave:
 	.long	io_leave + 0x80000000, io_done + 0x80000000
 cleanup_table_io_work_loop:
-	.long	io_work_loop + 0x80000000, io_mcck_pending + 0x80000000
+	.long	io_work_loop + 0x80000000, io_work_done + 0x80000000
 
 cleanup_critical:
 	clc	4(4,%r12),BASED(cleanup_table_system_call)
@@ -930,8 +976,6 @@ cleanup_system_call:
 cleanup_vtime:
 	clc	__LC_RETURN_PSW+4(4),BASED(cleanup_system_call_insn+12)
 	bhe	BASED(cleanup_stime)
-	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
-	bz	BASED(cleanup_novtime)
 	UPDATE_VTIME __LC_EXIT_TIMER,__LC_SYNC_ENTER_TIMER,__LC_USER_TIMER
 cleanup_stime:
 	clc	__LC_RETURN_PSW+4(4),BASED(cleanup_system_call_insn+16)
@@ -939,7 +983,6 @@ cleanup_stime:
 	UPDATE_VTIME __LC_LAST_UPDATE_TIMER,__LC_EXIT_TIMER,__LC_SYSTEM_TIMER
 cleanup_update:
 	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_SYNC_ENTER_TIMER
-cleanup_novtime:
 #endif
 	mvc	__LC_RETURN_PSW+4(4),BASED(cleanup_table_system_call+4)
 	la	%r12,__LC_RETURN_PSW
@@ -978,10 +1021,10 @@ cleanup_sysc_leave:
 2:	la	%r12,__LC_RETURN_PSW
 	br	%r14
 cleanup_sysc_leave_insn:
+	.long	sysc_done - 4 + 0x80000000
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
-	.long	sysc_leave + 14 + 0x80000000
+	.long	sysc_done - 8 + 0x80000000
 #endif
-	.long	sysc_leave + 10 + 0x80000000
 
 cleanup_io_return:
 	mvc	__LC_RETURN_PSW(4),0(%r12)
@@ -1008,10 +1051,10 @@ cleanup_io_leave:
 2:	la	%r12,__LC_RETURN_PSW
 	br	%r14
 cleanup_io_leave_insn:
+	.long	io_done - 4 + 0x80000000
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
-	.long	io_leave + 18 + 0x80000000
+	.long	io_done - 8 + 0x80000000
 #endif
-	.long	io_leave + 14 + 0x80000000
 
 /*
  * Integer constants
diff -urpN linux-2.6/arch/s390/kernel/setup.c linux-2.6-patched/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	2007-11-16 14:27:38.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/setup.c	2007-11-16 14:27:38.000000000 +0100
@@ -492,6 +492,10 @@ static void setup_addressing_mode(void)
 		printk("S390 address spaces switched, ");
 		set_amode_and_uaccess(PSW_ASC_PRIMARY, PSW32_ASC_PRIMARY);
 	}
+#ifdef CONFIG_TRACE_IRQFLAGS
+	sysc_restore_trace_psw.mask = psw_kernel_bits & ~PSW_MASK_MCHECK;
+	io_restore_trace_psw.mask = psw_kernel_bits & ~PSW_MASK_MCHECK;
+#endif
 }
 
 static void __init
diff -urpN linux-2.6/include/asm-s390/system.h linux-2.6-patched/include/asm-s390/system.h
--- linux-2.6/include/asm-s390/system.h	2007-11-16 14:27:34.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/system.h	2007-11-16 14:27:38.000000000 +0100
@@ -388,6 +388,11 @@ extern void (*_machine_power_off)(void);
 
 #define arch_align_stack(x) (x)
 
+#ifdef CONFIG_TRACE_IRQFLAGS
+extern psw_t sysc_restore_trace_psw;
+extern psw_t io_restore_trace_psw;
+#endif
+
 #endif /* __KERNEL__ */
 
 #endif

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
