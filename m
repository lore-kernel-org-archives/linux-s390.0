From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 15/21] KVM: s390: forward most SIGP orders to user space
Date: Thu, 15 Jan 2015 14:43:28 +0100
Message-ID: <1421329414-76826-16-git-send-email-borntraeger@de.ibm.com>
References: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Most SIGP orders are handled partially in kernel and partially in
user space. In order to:
- Get a correct SIGP SET PREFIX handler that informs user space
- Avoid race conditions between concurrently executed SIGP orders
- Serialize SIGP orders per VCPU

We need to handle all "slow" SIGP orders in user space. The remaining
ones to be handled completely in kernel are:
- SENSE
- SENSE RUNNING
- EXTERNAL CALL
- EMERGENCY SIGNAL
- CONDITIONAL EMERGENCY SIGNAL
According to the PoP, they have to be fast. They can be executed
without conflicting to the actions of other pending/concurrently
executing orders (e.g. STOP vs. START).

This patch introduces a new capability that will - when enabled -
forward all but the mentioned SIGP orders to user space. The
instruction counters in the kernel are still updated.

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/api.txt | 20 ++++++++++++++++
 arch/s390/include/asm/kvm_host.h  |  1 +
 arch/s390/kvm/kvm-s390.c          |  5 ++++
 arch/s390/kvm/sigp.c              | 49 +++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h          |  1 +
 5 files changed, 76 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 3ca6e0e..df19837 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -3225,3 +3225,23 @@ userspace from doing that.
 If the hcall number specified is not one that has an in-kernel
 implementation, the KVM_ENABLE_CAP ioctl will fail with an EINVAL
 error.
+
+7.2 KVM_CAP_S390_USER_SIGP
+
+Architectures: s390
+Parameters: none
+
+This capability controls which SIGP orders will be handled completely in user
+space. With this capability enabled, all fast orders will be handled completely
+in the kernel:
+- SENSE
+- SENSE RUNNING
+- EXTERNAL CALL
+- EMERGENCY SIGNAL
+- CONDITIONAL EMERGENCY SIGNAL
+
+All other orders will be handled completely in user space.
+
+Only privileged operation exceptions will be checked for in the kernel (or even
+in the hardware prior to interception). If this capability is not enabled, the
+old way of handling SIGP orders is used (partially in kernel and user space).
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index b617052..a2dcd0e 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -521,6 +521,7 @@ struct kvm_arch{
 	int use_irqchip;
 	int use_cmma;
 	int user_cpu_state_ctrl;
+	int user_sigp;
 	struct s390_io_adapter *adapters[MAX_S390_IO_ADAPTERS];
 	wait_queue_head_t ipte_wq;
 	int ipte_lock_count;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index bfb2b99..3677b8c 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -166,6 +166,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_S390_IRQCHIP:
 	case KVM_CAP_VM_ATTRIBUTES:
 	case KVM_CAP_MP_STATE:
+	case KVM_CAP_S390_USER_SIGP:
 		r = 1;
 		break;
 	case KVM_CAP_NR_VCPUS:
@@ -254,6 +255,10 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
 		kvm->arch.use_irqchip = 1;
 		r = 0;
 		break;
+	case KVM_CAP_S390_USER_SIGP:
+		kvm->arch.user_sigp = 1;
+		r = 0;
+		break;
 	default:
 		r = -EINVAL;
 		break;
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index 1524be9..23b1e86 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -371,6 +371,53 @@ static int handle_sigp_dst(struct kvm_vcpu *vcpu, u8 order_code,
 	return rc;
 }
 
+static int handle_sigp_order_in_user_space(struct kvm_vcpu *vcpu, u8 order_code)
+{
+	if (!vcpu->kvm->arch.user_sigp)
+		return 0;
+
+	switch (order_code) {
+	case SIGP_SENSE:
+	case SIGP_EXTERNAL_CALL:
+	case SIGP_EMERGENCY_SIGNAL:
+	case SIGP_COND_EMERGENCY_SIGNAL:
+	case SIGP_SENSE_RUNNING:
+		return 0;
+	/* update counters as we're directly dropping to user space */
+	case SIGP_STOP:
+		vcpu->stat.instruction_sigp_stop++;
+		break;
+	case SIGP_STOP_AND_STORE_STATUS:
+		vcpu->stat.instruction_sigp_stop_store_status++;
+		break;
+	case SIGP_STORE_STATUS_AT_ADDRESS:
+		vcpu->stat.instruction_sigp_store_status++;
+		break;
+	case SIGP_SET_PREFIX:
+		vcpu->stat.instruction_sigp_prefix++;
+		break;
+	case SIGP_START:
+		vcpu->stat.instruction_sigp_start++;
+		break;
+	case SIGP_RESTART:
+		vcpu->stat.instruction_sigp_restart++;
+		break;
+	case SIGP_INITIAL_CPU_RESET:
+		vcpu->stat.instruction_sigp_init_cpu_reset++;
+		break;
+	case SIGP_CPU_RESET:
+		vcpu->stat.instruction_sigp_cpu_reset++;
+		break;
+	default:
+		vcpu->stat.instruction_sigp_unknown++;
+	}
+
+	VCPU_EVENT(vcpu, 4, "sigp order %u: completely handled in user space",
+		   order_code);
+
+	return 1;
+}
+
 int kvm_s390_handle_sigp(struct kvm_vcpu *vcpu)
 {
 	int r1 = (vcpu->arch.sie_block->ipa & 0x00f0) >> 4;
@@ -385,6 +432,8 @@ int kvm_s390_handle_sigp(struct kvm_vcpu *vcpu)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
 	order_code = kvm_s390_get_base_disp_rs(vcpu);
+	if (handle_sigp_order_in_user_space(vcpu, order_code))
+		return -EOPNOTSUPP;
 
 	if (r1 % 2)
 		parameter = vcpu->run->s.regs.gprs[r1];
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index adc24a3..37f71c3 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -759,6 +759,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_PPC_FIXUP_HCALL 103
 #define KVM_CAP_PPC_ENABLE_HCALL 104
 #define KVM_CAP_CHECK_EXTENSION_VM 105
+#define KVM_CAP_S390_USER_SIGP 106
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
1.9.3
