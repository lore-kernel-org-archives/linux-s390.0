Return-Path: <linux-kernel-owner+w=401wt.eu-S1765879AbYEFQGt@vger.kernel.org>
Message-Id: <20080506155110.930436689@de.ibm.com>
References: <20080506155027.974409738@de.ibm.com>
Date: Tue, 06 May 2008 17:50:28 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 1/8] s390: Optimize user and work TIF check
Content-Disposition: inline; filename=001-kvm-tif-check.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

On return from syscall or interrupt, we have to check if we return to
userspace (likely) and if there is work todo (less likely) to decide
if we handle the work. We can optimize this check: we first check for 
the less likely work case and then check for userspace.

This patch is also a preparation for an additional patch, that fixes a bug
in KVM dealing with cpu bound guests.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/entry.S   |   29 ++++++++++++++---------------
 arch/s390/kernel/entry64.S |   29 ++++++++++++++---------------
 2 files changed, 28 insertions(+), 30 deletions(-)

Index: quilt-2.6/arch/s390/kernel/entry64.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/entry64.S
+++ quilt-2.6/arch/s390/kernel/entry64.S
@@ -271,8 +271,6 @@ sysc_noemu:
 	stg	%r2,SP_R2(%r15) # store return value (change R2 on stack)
 
 sysc_return:
-	tm	SP_PSW+1(%r15),0x01	# returning to user ?
-	jno	sysc_restore
 	tm	__TI_flags+7(%r9),_TIF_WORK_SVC
 	jnz	sysc_work	# there is work to do (signals etc.)
 sysc_restore:
@@ -304,6 +302,8 @@ sysc_work_loop:
 # One of the work bits is on. Find out which one.
 #
 sysc_work:
+	tm	SP_PSW+1(%r15),0x01	# returning to user ?
+	jno	sysc_restore
 	tm	__TI_flags+7(%r9),_TIF_MCCK_PENDING
 	jo	sysc_mcck_pending
 	tm	__TI_flags+7(%r9),_TIF_NEED_RESCHED
@@ -585,12 +585,6 @@ io_no_vtime:
 	la	%r2,SP_PTREGS(%r15)	# address of register-save area
 	brasl	%r14,do_IRQ		# call standard irq handler
 io_return:
-	tm	SP_PSW+1(%r15),0x01	# returning to user ?
-#ifdef CONFIG_PREEMPT
-	jno	io_preempt		# no -> check for preemptive scheduling
-#else
-	jno	io_restore		# no-> skip resched & signal
-#endif
 	tm	__TI_flags+7(%r9),_TIF_WORK_INT
 	jnz	io_work 		# there is work to do (signals etc.)
 io_restore:
@@ -612,10 +606,18 @@ io_restore_trace_psw:
 	.quad	0, io_restore_trace
 #endif
 
-#ifdef CONFIG_PREEMPT
-io_preempt:
+#
+# switch to kernel stack, then check TIF bits
+#
+io_work:
+	tm	SP_PSW+1(%r15),0x01	# returning to user ?
+#ifndef CONFIG_PREEMPT
+	jno	io_restore		# no-> skip resched & signal
+#else
+	jnz	io_work_user		# yes -> do resched & signal
+	# check for preemptive scheduling
 	icm	%r0,15,__TI_precount(%r9)
-	jnz	io_restore
+	jnz	io_restore		# preemption is disabled
 	# switch to kernel stack
 	lg	%r1,SP_R15(%r15)
 	aghi	%r1,-SP_SIZE
@@ -629,10 +631,7 @@ io_resume_loop:
 	jg	preempt_schedule_irq
 #endif
 
-#
-# switch to kernel stack, then check TIF bits
-#
-io_work:
+io_work_user:
 	lg	%r1,__LC_KERNEL_STACK
 	aghi	%r1,-SP_SIZE
 	mvc	SP_PTREGS(__PT_SIZE,%r1),SP_PTREGS(%r15)
Index: quilt-2.6/arch/s390/kernel/entry.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/entry.S
+++ quilt-2.6/arch/s390/kernel/entry.S
@@ -279,8 +279,6 @@ sysc_do_restart:
 	st	%r2,SP_R2(%r15)   # store return value (change R2 on stack)
 
 sysc_return:
-	tm	SP_PSW+1(%r15),0x01	# returning to user ?
-	bno	BASED(sysc_restore)
 	tm	__TI_flags+3(%r9),_TIF_WORK_SVC
 	bnz	BASED(sysc_work)  # there is work to do (signals etc.)
 sysc_restore:
@@ -312,6 +310,8 @@ sysc_work_loop:
 # One of the work bits is on. Find out which one.
 #
 sysc_work:
+	tm	SP_PSW+1(%r15),0x01	# returning to user ?
+	bno	BASED(sysc_restore)
 	tm	__TI_flags+3(%r9),_TIF_MCCK_PENDING
 	bo	BASED(sysc_mcck_pending)
 	tm	__TI_flags+3(%r9),_TIF_NEED_RESCHED
@@ -602,12 +602,6 @@ io_no_vtime:
 	la	%r2,SP_PTREGS(%r15)	# address of register-save area
 	basr	%r14,%r1		# branch to standard irq handler
 io_return:
-	tm	SP_PSW+1(%r15),0x01	# returning to user ?
-#ifdef CONFIG_PREEMPT
-	bno	BASED(io_preempt)	# no -> check for preemptive scheduling
-#else
-	bno	BASED(io_restore)	# no-> skip resched & signal
-#endif
 	tm	__TI_flags+3(%r9),_TIF_WORK_INT
 	bnz	BASED(io_work)		# there is work to do (signals etc.)
 io_restore:
@@ -629,10 +623,18 @@ io_restore_trace_psw:
 	.long	0, io_restore_trace + 0x80000000
 #endif
 
-#ifdef CONFIG_PREEMPT
-io_preempt:
+#
+# switch to kernel stack, then check the TIF bits
+#
+io_work:
+	tm	SP_PSW+1(%r15),0x01	# returning to user ?
+#ifndef CONFIG_PREEMPT
+	bno	BASED(io_restore)	# no-> skip resched & signal
+#else
+	bnz	BASED(io_work_user)	# no -> check for preemptive scheduling
+	# check for preemptive scheduling
 	icm	%r0,15,__TI_precount(%r9)
-	bnz	BASED(io_restore)
+	bnz	BASED(io_restore)	# preemption disabled
 	l	%r1,SP_R15(%r15)
 	s	%r1,BASED(.Lc_spsize)
 	mvc	SP_PTREGS(__PT_SIZE,%r1),SP_PTREGS(%r15)
@@ -646,10 +648,7 @@ io_resume_loop:
 	br	%r1			# call schedule
 #endif
 
-#
-# switch to kernel stack, then check the TIF bits
-#
-io_work:
+io_work_user:
 	l	%r1,__LC_KERNEL_STACK
 	s	%r1,BASED(.Lc_spsize)
 	mvc	SP_PTREGS(__PT_SIZE,%r1),SP_PTREGS(%r15)

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
