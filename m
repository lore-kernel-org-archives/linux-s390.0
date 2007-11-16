Return-Path: <linux-kernel-owner+w=401wt.eu-S934489AbXKPO2u@vger.kernel.org>
Message-Id: <20071116142527.043274700@de.ibm.com>
References: <20071116142441.484714036@de.ibm.com>
Date: Fri, 16 Nov 2007 15:24:47 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 06/10] Fix kernel preemption.
Content-Disposition: inline; filename=006-preemption.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

When returning from IRQ handling and TIF_NEED_RESCHED is set we must
call preempt_schedule_irq() instead of schedule().
Otherwise the BKL might be unlocked in schedule() and therfore
everything that relies on the BKL is broken.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/entry.S   |   15 +++++----------
 arch/s390/kernel/entry64.S |   12 ++----------
 2 files changed, 7 insertions(+), 20 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/entry64.S linux-2.6-patched/arch/s390/kernel/entry64.S
--- linux-2.6/arch/s390/kernel/entry64.S	2007-11-16 14:27:41.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/entry64.S	2007-11-16 14:27:42.000000000 +0100
@@ -623,15 +623,8 @@ io_preempt:
 io_resume_loop:
 	tm	__TI_flags+7(%r9),_TIF_NEED_RESCHED
 	jno	io_restore
-	larl	%r1,.Lc_pactive
-	mvc	__TI_precount(4,%r9),0(%r1)
-	TRACE_IRQS_ON
-	stosm	__SF_EMPTY(%r15),0x03	# reenable interrupts
-	brasl	%r14,schedule		# call schedule
-	stnsm	__SF_EMPTY(%r15),0xfc	# disable I/O and ext. interrupts
-	TRACE_IRQS_OFF
-	xc	__TI_precount(4,%r9),__TI_precount(%r9)
-	j	io_resume_loop
+	larl	%r14,io_resume_loop
+	jg	preempt_schedule_irq
 #endif
 
 #
@@ -1029,7 +1022,6 @@ cleanup_io_leave_insn:
  */
 		.align	4
 .Lconst:
-.Lc_pactive:	.long	PREEMPT_ACTIVE
 .Lnr_syscalls:	.long	NR_syscalls
 .L0x0130:	.short	0x130
 .L0x0140:	.short	0x140
diff -urpN linux-2.6/arch/s390/kernel/entry.S linux-2.6-patched/arch/s390/kernel/entry.S
--- linux-2.6/arch/s390/kernel/entry.S	2007-11-16 14:27:41.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/entry.S	2007-11-16 14:27:42.000000000 +0100
@@ -640,15 +640,9 @@ io_preempt:
 io_resume_loop:
 	tm	__TI_flags+3(%r9),_TIF_NEED_RESCHED
 	bno	BASED(io_restore)
-	mvc	__TI_precount(4,%r9),BASED(.Lc_pactive)
-	TRACE_IRQS_ON
-	stosm	__SF_EMPTY(%r15),0x03  # reenable interrupts
-	l	%r1,BASED(.Lschedule)
-	basr	%r14,%r1	       # call schedule
-	stnsm	__SF_EMPTY(%r15),0xfc  # disable I/O and ext. interrupts
-	TRACE_IRQS_OFF
-	xc	__TI_precount(4,%r9),__TI_precount(%r9)
-	b	BASED(io_resume_loop)
+	l	%r1,BASED(.Lpreempt_schedule_irq)
+	la	%r14,BASED(io_resume_loop)
+	br	%r1			# call schedule
 #endif
 
 #
@@ -1062,7 +1056,6 @@ cleanup_io_leave_insn:
 		.align	4
 .Lc_spsize:	.long	SP_SIZE
 .Lc_overhead:	.long	STACK_FRAME_OVERHEAD
-.Lc_pactive:	.long	PREEMPT_ACTIVE
 .Lnr_syscalls:	.long	NR_syscalls
 .L0x018:	.short	0x018
 .L0x020:	.short	0x020
@@ -1086,6 +1079,8 @@ cleanup_io_leave_insn:
 .Lexecve_tail:	.long	execve_tail
 .Ljump_table:	.long	pgm_check_table
 .Lschedule:	.long	schedule
+.Lpreempt_schedule_irq:
+		.long	preempt_schedule_irq
 .Ltrace:	.long	syscall_trace
 .Lschedtail:	.long	schedule_tail
 .Lsysc_table:	.long	sys_call_table

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
