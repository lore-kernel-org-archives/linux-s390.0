From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 7/8] s390/kvm: avoid automatic sie reentry
Date: Fri, 17 May 2013 14:41:37 +0200
Message-ID: <1368794498-2051-8-git-send-email-borntraeger@de.ibm.com>
References: <1368794498-2051-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1368794498-2051-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tossati <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Do not automatically restart the sie instruction in entry64.S after an
interrupt, return to the caller with a reason code instead. That allows
to deal with RCU and other conditions in C code.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kernel/entry64.S | 76 ++++++++++++++++++++--------------------------
 arch/s390/kvm/kvm-s390.c   |  4 ++-
 2 files changed, 36 insertions(+), 44 deletions(-)

diff --git a/arch/s390/kernel/entry64.S b/arch/s390/kernel/entry64.S
index c7daeef..51d99ac 100644
--- a/arch/s390/kernel/entry64.S
+++ b/arch/s390/kernel/entry64.S
@@ -47,7 +47,6 @@ _TIF_WORK_INT = (_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_NEED_RESCHED | \
 		 _TIF_MCCK_PENDING)
 _TIF_TRACE    = (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | _TIF_SECCOMP | \
 		 _TIF_SYSCALL_TRACEPOINT)
-_TIF_EXIT_SIE = (_TIF_SIGPENDING | _TIF_NEED_RESCHED | _TIF_MCCK_PENDING)
 
 #define BASED(name) name-system_call(%r13)
 
@@ -81,25 +80,27 @@ _TIF_EXIT_SIE = (_TIF_SIGPENDING | _TIF_NEED_RESCHED | _TIF_MCCK_PENDING)
 #endif
 	.endm
 
-	.macro	HANDLE_SIE_INTERCEPT scratch,pgmcheck
+	.macro	HANDLE_SIE_INTERCEPT scratch,reason
 #if defined(CONFIG_KVM) || defined(CONFIG_KVM_MODULE)
 	tmhh	%r8,0x0001		# interrupting from user ?
-	jnz	.+52
+	jnz	.+62
 	lgr	\scratch,%r9
-	slg	\scratch,BASED(.Lsie_loop)
-	clg	\scratch,BASED(.Lsie_length)
-	.if	\pgmcheck
+	slg	\scratch,BASED(.Lsie_critical)
+	clg	\scratch,BASED(.Lsie_critical_length)
+	.if	\reason==1
 	# Some program interrupts are suppressing (e.g. protection).
 	# We must also check the instruction after SIE in that case.
 	# do_protection_exception will rewind to rewind_pad
-	jh	.+32
+	jh	.+42
 	.else
-	jhe	.+32
+	jhe	.+42
 	.endif
-	lg	%r9,BASED(.Lsie_loop)
-	LPP	BASED(.Lhost_id)	# set host id
-	lg	%r14,__SF_EMPTY(%r15)	# get control block pointer
+	lg	%r14,__SF_EMPTY(%r15)		# get control block pointer
+	LPP	__SF_EMPTY+16(%r15)		# set host id
 	ni	__SIE_PROG0C+3(%r14),0xfe	# no longer in SIE
+	lctlg	%c1,%c1,__LC_USER_ASCE		# load primary asce
+	larl	%r9,sie_exit			# skip forward to sie_exit
+	mvi	__SF_EMPTY+31(%r15),\reason	# set exit reason
 #endif
 	.endm
 
@@ -452,7 +453,7 @@ ENTRY(io_int_handler)
 	lg	%r12,__LC_THREAD_INFO
 	larl	%r13,system_call
 	lmg	%r8,%r9,__LC_IO_OLD_PSW
-	HANDLE_SIE_INTERCEPT %r14,0
+	HANDLE_SIE_INTERCEPT %r14,2
 	SWITCH_ASYNC __LC_SAVE_AREA_ASYNC,__LC_ASYNC_STACK,STACK_SHIFT
 	tmhh	%r8,0x0001		# interrupting from user?
 	jz	io_skip
@@ -597,7 +598,7 @@ ENTRY(ext_int_handler)
 	lg	%r12,__LC_THREAD_INFO
 	larl	%r13,system_call
 	lmg	%r8,%r9,__LC_EXT_OLD_PSW
-	HANDLE_SIE_INTERCEPT %r14,0
+	HANDLE_SIE_INTERCEPT %r14,3
 	SWITCH_ASYNC __LC_SAVE_AREA_ASYNC,__LC_ASYNC_STACK,STACK_SHIFT
 	tmhh	%r8,0x0001		# interrupting from user ?
 	jz	ext_skip
@@ -645,7 +646,7 @@ ENTRY(mcck_int_handler)
 	lg	%r12,__LC_THREAD_INFO
 	larl	%r13,system_call
 	lmg	%r8,%r9,__LC_MCK_OLD_PSW
-	HANDLE_SIE_INTERCEPT %r14,0
+	HANDLE_SIE_INTERCEPT %r14,4
 	tm	__LC_MCCK_CODE,0x80	# system damage?
 	jo	mcck_panic		# yes -> rest of mcck code invalid
 	lghi	%r14,__LC_CPU_TIMER_SAVE_AREA
@@ -939,19 +940,8 @@ ENTRY(sie64a)
 	stmg	%r6,%r14,__SF_GPRS(%r15)	# save kernel registers
 	stg	%r2,__SF_EMPTY(%r15)		# save control block pointer
 	stg	%r3,__SF_EMPTY+8(%r15)		# save guest register save area
-	xc	__SF_EMPTY+16(8,%r15),__SF_EMPTY+16(%r15) # host id == 0
+	xc	__SF_EMPTY+16(16,%r15),__SF_EMPTY+16(%r15) # host id & reason
 	lmg	%r0,%r13,0(%r3)			# load guest gprs 0-13
-# some program checks are suppressing. C code (e.g. do_protection_exception)
-# will rewind the PSW by the ILC, which is 4 bytes in case of SIE. Other
-# instructions in the sie_loop should not cause program interrupts. So
-# lets use a nop (47 00 00 00) as a landing pad.
-# See also HANDLE_SIE_INTERCEPT
-rewind_pad:
-	nop	0
-sie_loop:
-	lg	%r14,__LC_THREAD_INFO		# pointer thread_info struct
-	tm	__TI_flags+7(%r14),_TIF_EXIT_SIE
-	jnz	sie_exit
 	lg	%r14,__LC_GMAP			# get gmap pointer
 	ltgr	%r14,%r14
 	jz	sie_gmap
@@ -966,33 +956,33 @@ sie_gmap:
 sie_done:
 	LPP	__SF_EMPTY+16(%r15)		# set host id
 	ni	__SIE_PROG0C+3(%r14),0xfe	# no longer in SIE
-	lg	%r14,__LC_THREAD_INFO		# pointer thread_info struct
-sie_exit:
 	lctlg	%c1,%c1,__LC_USER_ASCE		# load primary asce
+# some program checks are suppressing. C code (e.g. do_protection_exception)
+# will rewind the PSW by the ILC, which is 4 bytes in case of SIE. Other
+# instructions beween sie64a and sie_done should not cause program
+# interrupts. So lets use a nop (47 00 00 00) as a landing pad.
+# See also HANDLE_SIE_INTERCEPT
+rewind_pad:
+	nop	0
+sie_exit:
 	lg	%r14,__SF_EMPTY+8(%r15)		# load guest register save area
 	stmg	%r0,%r13,0(%r14)		# save guest gprs 0-13
 	lmg	%r6,%r14,__SF_GPRS(%r15)	# restore kernel registers
-	lghi	%r2,0
+	lg	%r2,__SF_EMPTY+24(%r15)		# return exit reason code
 	br	%r14
 sie_fault:
-	lctlg	%c1,%c1,__LC_USER_ASCE		# load primary asce
-	lg	%r14,__LC_THREAD_INFO		# pointer thread_info struct
-	lg	%r14,__SF_EMPTY+8(%r15)		# load guest register save area
-	stmg	%r0,%r13,0(%r14)		# save guest gprs 0-13
-	lmg	%r6,%r14,__SF_GPRS(%r15)	# restore kernel registers
-	lghi	%r2,-EFAULT
-	br	%r14
+	lghi	%r14,-EFAULT
+	stg	%r14,__SF_EMPTY+24(%r15)	# set exit reason code
+	j	sie_exit
 
 	.align	8
-.Lsie_loop:
-	.quad	sie_loop
-.Lsie_length:
-	.quad	sie_done - sie_loop
-.Lhost_id:
-	.quad	0
+.Lsie_critical:
+	.quad	sie_gmap
+.Lsie_critical_length:
+	.quad	sie_done - sie_gmap
 
 	EX_TABLE(rewind_pad,sie_fault)
-	EX_TABLE(sie_loop,sie_fault)
+	EX_TABLE(sie_exit,sie_fault)
 #endif
 
 		.section .rodata, "a"
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 08227c1..93444c4 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -707,7 +707,9 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
 	trace_kvm_s390_sie_enter(vcpu,
 				 atomic_read(&vcpu->arch.sie_block->cpuflags));
 	rc = sie64a(vcpu->arch.sie_block, vcpu->run->s.regs.gprs);
-	if (rc) {
+	if (rc > 0)
+		rc = 0;
+	if (rc < 0) {
 		if (kvm_is_ucontrol(vcpu->kvm)) {
 			rc = SIE_INTERCEPT_UCONTROL;
 		} else {
-- 
1.8.1.4
