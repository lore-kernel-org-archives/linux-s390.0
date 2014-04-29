From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 5/6] KVM: s390: introduce kvm_s390_vcpu_{start,stop}
Date: Tue, 29 Apr 2014 15:36:47 +0200
Message-ID: <1398778608-3887-6-git-send-email-borntraeger@de.ibm.com>
References: <1398778608-3887-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1398778608-3887-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

This patch introduces two new functions to set/clear the CPUSTAT_STOPPED bit and
makes use of it at all applicable places. These functions prepare the additional
execution of code when starting/stopping a vcpu.

The CPUSTAT_STOPPED bit should not be touched outside of these functions.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/diag.c       |  2 +-
 arch/s390/kvm/intercept.c  |  3 +--
 arch/s390/kvm/interrupt.c  |  2 +-
 arch/s390/kvm/kvm-s390.c   | 16 ++++++++++++++--
 arch/s390/kvm/kvm-s390.h   |  2 ++
 arch/s390/kvm/trace-s390.h | 21 +++++++++++++++++++++
 6 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index 5521ace..004d385 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -176,7 +176,7 @@ static int __diag_ipl_functions(struct kvm_vcpu *vcpu)
 		return -EOPNOTSUPP;
 	}
 
-	atomic_set_mask(CPUSTAT_STOPPED, &vcpu->arch.sie_block->cpuflags);
+	kvm_s390_vcpu_stop(vcpu);
 	vcpu->run->s390_reset_flags |= KVM_S390_RESET_SUBSYSTEM;
 	vcpu->run->s390_reset_flags |= KVM_S390_RESET_IPL;
 	vcpu->run->s390_reset_flags |= KVM_S390_RESET_CPU_INIT;
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 54313fe..99e4b76 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -65,8 +65,7 @@ static int handle_stop(struct kvm_vcpu *vcpu)
 	trace_kvm_s390_stop_request(vcpu->arch.local_int.action_bits);
 
 	if (vcpu->arch.local_int.action_bits & ACTION_STOP_ON_STOP) {
-		atomic_set_mask(CPUSTAT_STOPPED,
-				&vcpu->arch.sie_block->cpuflags);
+		kvm_s390_vcpu_stop(vcpu);
 		vcpu->arch.local_int.action_bits &= ~ACTION_STOP_ON_STOP;
 		VCPU_EVENT(vcpu, 3, "%s", "cpu stopped");
 		rc = -EOPNOTSUPP;
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 077e473..d9526bb 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -413,7 +413,7 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 		rc |= read_guest_lc(vcpu, offsetof(struct _lowcore, restart_psw),
 				    &vcpu->arch.sie_block->gpsw,
 				    sizeof(psw_t));
-		atomic_clear_mask(CPUSTAT_STOPPED, &vcpu->arch.sie_block->cpuflags);
+		kvm_s390_vcpu_start(vcpu);
 		break;
 	case KVM_S390_PROGRAM_INT:
 		VCPU_EVENT(vcpu, 4, "interrupt: pgm check code:%x, ilc:%x",
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index b32c42c..6c972d2 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -592,7 +592,7 @@ static void kvm_s390_vcpu_initial_reset(struct kvm_vcpu *vcpu)
 	vcpu->arch.sie_block->pp = 0;
 	vcpu->arch.pfault_token = KVM_S390_PFAULT_TOKEN_INVALID;
 	kvm_clear_async_pf_completion_queue(vcpu);
-	atomic_set_mask(CPUSTAT_STOPPED, &vcpu->arch.sie_block->cpuflags);
+	kvm_s390_vcpu_stop(vcpu);
 	kvm_s390_clear_local_irqs(vcpu);
 }
 
@@ -1235,7 +1235,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 	if (vcpu->sigset_active)
 		sigprocmask(SIG_SETMASK, &vcpu->sigset, &sigsaved);
 
-	atomic_clear_mask(CPUSTAT_STOPPED, &vcpu->arch.sie_block->cpuflags);
+	kvm_s390_vcpu_start(vcpu);
 
 	switch (kvm_run->exit_reason) {
 	case KVM_EXIT_S390_SIEIC:
@@ -1362,6 +1362,18 @@ int kvm_s390_vcpu_store_status(struct kvm_vcpu *vcpu, unsigned long addr)
 	return kvm_s390_store_status_unloaded(vcpu, addr);
 }
 
+void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu)
+{
+	trace_kvm_s390_vcpu_start_stop(vcpu->vcpu_id, 1);
+	atomic_clear_mask(CPUSTAT_STOPPED, &vcpu->arch.sie_block->cpuflags);
+}
+
+void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
+{
+	trace_kvm_s390_vcpu_start_stop(vcpu->vcpu_id, 0);
+	atomic_set_mask(CPUSTAT_STOPPED, &vcpu->arch.sie_block->cpuflags);
+}
+
 static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 				     struct kvm_enable_cap *cap)
 {
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 9b5680d..c28423a 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -157,6 +157,8 @@ int kvm_s390_handle_sigp(struct kvm_vcpu *vcpu);
 /* implemented in kvm-s390.c */
 int kvm_s390_store_status_unloaded(struct kvm_vcpu *vcpu, unsigned long addr);
 int kvm_s390_vcpu_store_status(struct kvm_vcpu *vcpu, unsigned long addr);
+void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu);
+void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu);
 void s390_vcpu_block(struct kvm_vcpu *vcpu);
 void s390_vcpu_unblock(struct kvm_vcpu *vcpu);
 void exit_sie(struct kvm_vcpu *vcpu);
diff --git a/arch/s390/kvm/trace-s390.h b/arch/s390/kvm/trace-s390.h
index 13f30f5..34d4f8a 100644
--- a/arch/s390/kvm/trace-s390.h
+++ b/arch/s390/kvm/trace-s390.h
@@ -68,6 +68,27 @@ TRACE_EVENT(kvm_s390_destroy_vcpu,
 	);
 
 /*
+ * Trace point for start and stop of vpcus.
+ */
+TRACE_EVENT(kvm_s390_vcpu_start_stop,
+	    TP_PROTO(unsigned int id, int state),
+	    TP_ARGS(id, state),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int, id)
+		    __field(int, state)
+		    ),
+
+	    TP_fast_assign(
+		    __entry->id = id;
+		    __entry->state = state;
+		    ),
+
+	    TP_printk("%s cpu %d", __entry->state ? "starting" : "stopping",
+		      __entry->id)
+	);
+
+/*
  * Trace points for injection of interrupts, either per machine or
  * per vcpu.
  */
-- 
1.8.4.2
