From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 5/5] KVM: s390: implement KVM_(S|G)ET_MP_STATE for user space state control
Date: Tue, 15 Jul 2014 15:27:55 +0200
Message-ID: <1405430875-40722-6-git-send-email-borntraeger@de.ibm.com>
References: <1405430875-40722-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1405430875-40722-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

This patch
- adds s390 specific MP states to linux headers and documents them
- implements the KVM_{SET,GET}_MP_STATE ioctls
- enables KVM_CAP_MP_STATE
- allows user space to control the VCPU state on s390.

If user space sets the VCPU state using the ioctl KVM_SET_MP_STATE, we can disable
manual changing of the VCPU state and trust user space to do the right thing.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/api.txt | 10 ++++++++--
 arch/s390/include/asm/kvm_host.h  |  1 +
 arch/s390/kvm/diag.c              |  3 ++-
 arch/s390/kvm/intercept.c         |  3 ++-
 arch/s390/kvm/kvm-s390.c          | 37 +++++++++++++++++++++++++++++++++----
 arch/s390/kvm/kvm-s390.h          |  6 ++++++
 include/uapi/linux/kvm.h          |  4 ++++
 7 files changed, 56 insertions(+), 8 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 904c61c..a41465b 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -974,7 +974,7 @@ for vm-wide capabilities.
 4.38 KVM_GET_MP_STATE
 
 Capability: KVM_CAP_MP_STATE
-Architectures: x86, ia64
+Architectures: x86, ia64, s390
 Type: vcpu ioctl
 Parameters: struct kvm_mp_state (out)
 Returns: 0 on success; -1 on error
@@ -998,6 +998,12 @@ Possible values are:
                                  is waiting for an interrupt [x86, ia64]
  - KVM_MP_STATE_SIPI_RECEIVED:   the vcpu has just received a SIPI (vector
                                  accessible via KVM_GET_VCPU_EVENTS) [x86, ia64]
+ - KVM_MP_STATE_STOPPED:         the vcpu is stopped [s390]
+ - KVM_MP_STATE_CHECK_STOP:      the vcpu is in a special error state [s390]
+ - KVM_MP_STATE_OPERATING:       the vcpu is operating (running or halted)
+                                 [s390]
+ - KVM_MP_STATE_LOAD:            the vcpu is in a special load/startup state
+                                 [s390]
 
 On x86 and ia64, this ioctl is only useful after KVM_CREATE_IRQCHIP. Without an
 in-kernel irqchip, the multiprocessing state must be maintained by userspace on
@@ -1007,7 +1013,7 @@ these architectures.
 4.39 KVM_SET_MP_STATE
 
 Capability: KVM_CAP_MP_STATE
-Architectures: x86, ia64
+Architectures: x86, ia64, s390
 Type: vcpu ioctl
 Parameters: struct kvm_mp_state (in)
 Returns: 0 on success; -1 on error
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 4181d7b..c2ba020 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -418,6 +418,7 @@ struct kvm_arch{
 	int css_support;
 	int use_irqchip;
 	int use_cmma;
+	int user_cpu_state_ctrl;
 	struct s390_io_adapter *adapters[MAX_S390_IO_ADAPTERS];
 	wait_queue_head_t ipte_wq;
 	spinlock_t start_stop_lock;
diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index 0161675..59bd8f9 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -176,7 +176,8 @@ static int __diag_ipl_functions(struct kvm_vcpu *vcpu)
 		return -EOPNOTSUPP;
 	}
 
-	kvm_s390_vcpu_stop(vcpu);
+	if (!kvm_s390_user_cpu_state_ctrl(vcpu->kvm))
+		kvm_s390_vcpu_stop(vcpu);
 	vcpu->run->s390_reset_flags |= KVM_S390_RESET_SUBSYSTEM;
 	vcpu->run->s390_reset_flags |= KVM_S390_RESET_IPL;
 	vcpu->run->s390_reset_flags |= KVM_S390_RESET_CPU_INIT;
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index ac6b325..eaf4629 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -73,7 +73,8 @@ static int handle_stop(struct kvm_vcpu *vcpu)
 			return rc;
 	}
 
-	kvm_s390_vcpu_stop(vcpu);
+	if (!kvm_s390_user_cpu_state_ctrl(vcpu->kvm))
+		kvm_s390_vcpu_stop(vcpu);
 	return -EOPNOTSUPP;
 }
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 3428953..fdf88f7 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -167,6 +167,7 @@ int kvm_dev_ioctl_check_extension(long ext)
 	case KVM_CAP_DEVICE_CTRL:
 	case KVM_CAP_ENABLE_CAP_VM:
 	case KVM_CAP_VM_ATTRIBUTES:
+	case KVM_CAP_MP_STATE:
 		r = 1;
 		break;
 	case KVM_CAP_NR_VCPUS:
@@ -595,7 +596,8 @@ static void kvm_s390_vcpu_initial_reset(struct kvm_vcpu *vcpu)
 	vcpu->arch.sie_block->pp = 0;
 	vcpu->arch.pfault_token = KVM_S390_PFAULT_TOKEN_INVALID;
 	kvm_clear_async_pf_completion_queue(vcpu);
-	kvm_s390_vcpu_stop(vcpu);
+	if (!kvm_s390_user_cpu_state_ctrl(vcpu->kvm))
+		kvm_s390_vcpu_stop(vcpu);
 	kvm_s390_clear_local_irqs(vcpu);
 }
 
@@ -980,13 +982,34 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 				    struct kvm_mp_state *mp_state)
 {
-	return -EINVAL; /* not implemented yet */
+	/* CHECK_STOP and LOAD are not supported yet */
+	return is_vcpu_stopped(vcpu) ? KVM_MP_STATE_STOPPED :
+				       KVM_MP_STATE_OPERATING;
 }
 
 int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 				    struct kvm_mp_state *mp_state)
 {
-	return -EINVAL; /* not implemented yet */
+	int rc = 0;
+
+	/* user space knows about this interface - let it control the state */
+	vcpu->kvm->arch.user_cpu_state_ctrl = 1;
+
+	switch (mp_state->mp_state) {
+	case KVM_MP_STATE_STOPPED:
+		kvm_s390_vcpu_stop(vcpu);
+		break;
+	case KVM_MP_STATE_OPERATING:
+		kvm_s390_vcpu_start(vcpu);
+		break;
+	case KVM_MP_STATE_LOAD:
+	case KVM_MP_STATE_CHECK_STOP:
+		/* fall through - CHECK_STOP and LOAD are not supported yet */
+	default:
+		rc = -ENXIO;
+	}
+
+	return rc;
 }
 
 bool kvm_s390_cmma_enabled(struct kvm *kvm)
@@ -1284,7 +1307,13 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 	if (vcpu->sigset_active)
 		sigprocmask(SIG_SETMASK, &vcpu->sigset, &sigsaved);
 
-	kvm_s390_vcpu_start(vcpu);
+	if (!kvm_s390_user_cpu_state_ctrl(vcpu->kvm)) {
+		kvm_s390_vcpu_start(vcpu);
+	} else if (is_vcpu_stopped(vcpu)) {
+		pr_err_ratelimited("kvm-s390: can't run stopped vcpu %d\n",
+				   vcpu->vcpu_id);
+		return -EINVAL;
+	}
 
 	switch (kvm_run->exit_reason) {
 	case KVM_EXIT_S390_SIEIC:
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 77ed846..33a0e4b 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -129,6 +129,12 @@ static inline void kvm_s390_set_psw_cc(struct kvm_vcpu *vcpu, unsigned long cc)
 	vcpu->arch.sie_block->gpsw.mask |= cc << 44;
 }
 
+/* are cpu states controlled by user space */
+static inline int kvm_s390_user_cpu_state_ctrl(struct kvm *kvm)
+{
+	return kvm->arch.user_cpu_state_ctrl != 0;
+}
+
 int kvm_s390_handle_wait(struct kvm_vcpu *vcpu);
 enum hrtimer_restart kvm_s390_idle_wakeup(struct hrtimer *timer);
 void kvm_s390_tasklet(unsigned long parm);
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 37d4ec6..9b744af 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -407,6 +407,10 @@ struct kvm_vapic_addr {
 #define KVM_MP_STATE_INIT_RECEIVED     2
 #define KVM_MP_STATE_HALTED            3
 #define KVM_MP_STATE_SIPI_RECEIVED     4
+#define KVM_MP_STATE_STOPPED           5
+#define KVM_MP_STATE_CHECK_STOP        6
+#define KVM_MP_STATE_OPERATING         7
+#define KVM_MP_STATE_LOAD              8
 
 struct kvm_mp_state {
 	__u32 mp_state;
-- 
1.8.4.2
