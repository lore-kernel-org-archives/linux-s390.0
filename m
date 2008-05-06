Return-Path: <linux-kernel-owner+w=401wt.eu-S1765394AbYEFQDk@vger.kernel.org>
Message-Id: <20080506155111.188924467@de.ibm.com>
References: <20080506155027.974409738@de.ibm.com>
Date: Tue, 06 May 2008 17:50:29 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 2/8] s390-kvm: leave sie context on work. Removes preemption requirement
Content-Disposition: inline; filename=002-kvm-sie-exit.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Carsten Otte <cotte@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>

This patch fixes a bug with cpu bound guest on kvm-s390. Sometimes it
was impossible to deliver a signal to a spinning guest. We used 
preemption as a circumvention. The preemption notifiers called
vcpu_load, which checked for pending signals and triggered a host
intercept. But even with preemption, a sigkill was not delivered 
immediately. 

This patch changes the low level host interrupt handler to check for the
SIE  instruction, if TIF_WORK is set. In that case we change the
instruction pointer of the return PSW to rerun the vcpu_run loop. The kvm
code sees an intercept reason 0 if that happens. This patch adds accounting
for these types of intercept as well. 

The advantages:
- works with and without preemption
- signals are delivered immediately
- much better host latencies without preemption

Acked-by: Carsten Otte <cotte@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/entry64.S  |   30 +++++++++++++++++++++++++++++-
 arch/s390/kvm/Kconfig       |    1 -
 arch/s390/kvm/intercept.c   |    3 +++
 arch/s390/kvm/kvm-s390.c    |    5 +----
 include/asm-s390/kvm_host.h |    1 +
 5 files changed, 34 insertions(+), 6 deletions(-)

Index: quilt-2.6/arch/s390/kernel/entry64.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/entry64.S
+++ quilt-2.6/arch/s390/kernel/entry64.S
@@ -607,14 +607,37 @@ io_restore_trace_psw:
 #endif
 
 #
-# switch to kernel stack, then check TIF bits
+# There is work todo, we need to check if we return to userspace, then
+# check, if we are in SIE, if yes leave it
 #
 io_work:
 	tm	SP_PSW+1(%r15),0x01	# returning to user ?
 #ifndef CONFIG_PREEMPT
+#if defined(CONFIG_KVM) || defined(CONFIG_KVM_MODULE)
+	jnz	io_work_user		# yes -> no need to check for SIE
+	la	%r1, BASED(sie_opcode)	# we return to kernel here
+	lg	%r2, SP_PSW+8(%r15)
+	clc	0(2,%r1), 0(%r2)	# is current instruction = SIE?
+	jne	io_restore		# no-> return to kernel
+	lg	%r1, SP_PSW+8(%r15)	# yes-> add 4 bytes to leave SIE
+	aghi	%r1, 4
+	stg	%r1, SP_PSW+8(%r15)
+	j	io_restore		# return to kernel
+#else
 	jno	io_restore		# no-> skip resched & signal
+#endif
 #else
 	jnz	io_work_user		# yes -> do resched & signal
+#if defined(CONFIG_KVM) || defined(CONFIG_KVM_MODULE)
+	la	%r1, BASED(sie_opcode)
+	lg	%r2, SP_PSW+8(%r15)
+	clc	0(2,%r1), 0(%r2)	# is current instruction = SIE?
+	jne	0f			# no -> leave PSW alone
+	lg	%r1, SP_PSW+8(%r15)	# yes-> add 4 bytes to leave SIE
+	aghi	%r1, 4
+	stg	%r1, SP_PSW+8(%r15)
+0:
+#endif
 	# check for preemptive scheduling
 	icm	%r0,15,__TI_precount(%r9)
 	jnz	io_restore		# preemption is disabled
@@ -652,6 +675,11 @@ io_work_loop:
 	j	io_restore
 io_work_done:
 
+#if defined(CONFIG_KVM) || defined(CONFIG_KVM_MODULE)
+sie_opcode:
+	.long 0xb2140000
+#endif
+
 #
 # _TIF_MCCK_PENDING is set, call handler
 #
Index: quilt-2.6/arch/s390/kvm/intercept.c
===================================================================
--- quilt-2.6.orig/arch/s390/kvm/intercept.c
+++ quilt-2.6/arch/s390/kvm/intercept.c
@@ -105,6 +105,9 @@ static intercept_handler_t instruction_h
 static int handle_noop(struct kvm_vcpu *vcpu)
 {
 	switch (vcpu->arch.sie_block->icptcode) {
+	case 0x0:
+		vcpu->stat.exit_null++;
+		break;
 	case 0x10:
 		vcpu->stat.exit_external_request++;
 		break;
Index: quilt-2.6/arch/s390/kvm/Kconfig
===================================================================
--- quilt-2.6.orig/arch/s390/kvm/Kconfig
+++ quilt-2.6/arch/s390/kvm/Kconfig
@@ -22,7 +22,6 @@ config KVM
 	select PREEMPT_NOTIFIERS
 	select ANON_INODES
 	select S390_SWITCH_AMODE
-	select PREEMPT
 	---help---
 	  Support hosting paravirtualized guest machines using the SIE
 	  virtualization capability on the mainframe. This should work
Index: quilt-2.6/arch/s390/kvm/kvm-s390.c
===================================================================
--- quilt-2.6.orig/arch/s390/kvm/kvm-s390.c
+++ quilt-2.6/arch/s390/kvm/kvm-s390.c
@@ -31,6 +31,7 @@
 
 struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "userspace_handled", VCPU_STAT(exit_userspace) },
+	{ "exit_null", VCPU_STAT(exit_null) },
 	{ "exit_validity", VCPU_STAT(exit_validity) },
 	{ "exit_stop_request", VCPU_STAT(exit_stop_request) },
 	{ "exit_external_request", VCPU_STAT(exit_external_request) },
@@ -221,10 +222,6 @@ void kvm_arch_vcpu_load(struct kvm_vcpu 
 	vcpu->arch.guest_fpregs.fpc &= FPC_VALID_MASK;
 	restore_fp_regs(&vcpu->arch.guest_fpregs);
 	restore_access_regs(vcpu->arch.guest_acrs);
-
-	if (signal_pending(current))
-		atomic_set_mask(CPUSTAT_STOP_INT,
-			&vcpu->arch.sie_block->cpuflags);
 }
 
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
Index: quilt-2.6/include/asm-s390/kvm_host.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/kvm_host.h
+++ quilt-2.6/include/asm-s390/kvm_host.h
@@ -104,6 +104,7 @@ struct sie_block {
 
 struct kvm_vcpu_stat {
 	u32 exit_userspace;
+	u32 exit_null;
 	u32 exit_external_request;
 	u32 exit_external_interrupt;
 	u32 exit_stop_request;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
