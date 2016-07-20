From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/2] KVM: s390: allow user space to handle instr 0x0000
Date: Wed, 20 Jul 2016 14:39:59 +0200
Message-ID: <1469018400-8397-2-git-send-email-borntraeger@de.ibm.com>
References: <1469018400-8397-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1469018400-8397-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

We will use illegal instruction 0x0000 for handling 2 byte sw breakpoints
from user space. As it can be enabled dynamically via a capability,
let's move setting of ICTL_OPEREXC to the post creation step, so we avoid
any races when enabling that capability just while adding new cpus.

Acked-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/api.txt | 13 +++++++++++++
 arch/s390/include/asm/kvm_host.h  |  2 ++
 arch/s390/kvm/intercept.c         |  3 +++
 arch/s390/kvm/kvm-s390.c          | 26 ++++++++++++++++++++++++--
 include/uapi/linux/kvm.h          |  1 +
 5 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index c4d2fb0..299306d 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -3857,6 +3857,19 @@ as a broadcast even in x2APIC mode in order to support physical x2APIC
 without interrupt remapping.  This is undesirable in logical mode,
 where 0xff represents CPUs 0-7 in cluster 0.
 
+7.8 KVM_CAP_S390_USER_INSTR0
+
+Architectures: s390
+Parameters: none
+
+With this capability enabled, all illegal instructions 0x0000 (2 bytes) will
+be intercepted and forwarded to user space. User space can use this
+mechanism e.g. to realize 2-byte software breakpoints. The kernel will
+not inject an operating exception for these instructions, user space has
+to take care of that.
+
+This capability can be enabled dynamically even if VCPUs were already
+created and are running.
 
 8. Other capabilities.
 ----------------------
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 946fc86..183b017 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -43,6 +43,7 @@
 /* s390-specific vcpu->requests bit members */
 #define KVM_REQ_ENABLE_IBS         8
 #define KVM_REQ_DISABLE_IBS        9
+#define KVM_REQ_ICPT_OPEREXC       10
 
 #define SIGP_CTRL_C		0x80
 #define SIGP_CTRL_SCN_MASK	0x3f
@@ -666,6 +667,7 @@ struct kvm_arch{
 	int user_cpu_state_ctrl;
 	int user_sigp;
 	int user_stsi;
+	int user_instr0;
 	struct s390_io_adapter *adapters[MAX_S390_IO_ADAPTERS];
 	wait_queue_head_t ipte_wq;
 	int ipte_lock_count;
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 850be47..7a2f155 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -359,6 +359,9 @@ static int handle_operexc(struct kvm_vcpu *vcpu)
 	    test_kvm_facility(vcpu->kvm, 74))
 		return handle_sthyi(vcpu);
 
+	if (vcpu->arch.sie_block->ipa == 0 && vcpu->kvm->arch.user_instr0)
+		return -EOPNOTSUPP;
+
 	return kvm_s390_inject_program_int(vcpu, PGM_OPERATION);
 }
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index d42428c..63ac7c1 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -364,6 +364,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_S390_USER_STSI:
 	case KVM_CAP_S390_SKEYS:
 	case KVM_CAP_S390_IRQ_STATE:
+	case KVM_CAP_S390_USER_INSTR0:
 		r = 1;
 		break;
 	case KVM_CAP_S390_MEM_OP:
@@ -456,6 +457,16 @@ out:
 	return r;
 }
 
+static void icpt_operexc_on_all_vcpus(struct kvm *kvm)
+{
+	unsigned int i;
+	struct kvm_vcpu *vcpu;
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		kvm_s390_sync_request(KVM_REQ_ICPT_OPEREXC, vcpu);
+	}
+}
+
 static int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
 {
 	int r;
@@ -507,6 +518,12 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
 		kvm->arch.user_stsi = 1;
 		r = 0;
 		break;
+	case KVM_CAP_S390_USER_INSTR0:
+		VM_EVENT(kvm, 3, "%s", "ENABLE: CAP_S390_USER_INSTR0");
+		kvm->arch.user_instr0 = 1;
+		icpt_operexc_on_all_vcpus(kvm);
+		r = 0;
+		break;
 	default:
 		r = -EINVAL;
 		break;
@@ -1836,6 +1853,8 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 		vcpu->arch.gmap = vcpu->kvm->arch.gmap;
 		sca_add_vcpu(vcpu);
 	}
+	if (test_kvm_facility(vcpu->kvm, 74) || vcpu->kvm->arch.user_instr0)
+		vcpu->arch.sie_block->ictl |= ICTL_OPEREXC;
 	/* make vcpu_load load the right gmap on the first trigger */
 	vcpu->arch.enabled_gmap = vcpu->arch.gmap;
 }
@@ -1923,8 +1942,6 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 	}
 	vcpu->arch.sie_block->riccbd = (unsigned long) &vcpu->run->s.regs.riccb;
 	vcpu->arch.sie_block->ictl |= ICTL_ISKE | ICTL_SSKE | ICTL_RRBE;
-	if (test_kvm_facility(vcpu->kvm, 74))
-		vcpu->arch.sie_block->ictl |= ICTL_OPEREXC;
 
 	if (vcpu->kvm->arch.use_cmma) {
 		rc = kvm_s390_vcpu_setup_cmma(vcpu);
@@ -2369,6 +2386,11 @@ retry:
 		goto retry;
 	}
 
+	if (kvm_check_request(KVM_REQ_ICPT_OPEREXC, vcpu)) {
+		vcpu->arch.sie_block->ictl |= ICTL_OPEREXC;
+		goto retry;
+	}
+
 	/* nothing to do, just clear the request */
 	clear_bit(KVM_REQ_UNHALT, &vcpu->requests);
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 4f8030e..70941f4 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -867,6 +867,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_VCPU_ATTRIBUTES 127
 #define KVM_CAP_MAX_VCPU_ID 128
 #define KVM_CAP_X2APIC_API 129
+#define KVM_CAP_S390_USER_INSTR0 130
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.5.5
