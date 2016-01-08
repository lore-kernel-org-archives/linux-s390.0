From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/2] KVM: s390: implement the RI support of guest
Date: Fri,  8 Jan 2016 10:14:38 +0100
Message-ID: <1452244478-151381-3-git-send-email-borntraeger@de.ibm.com>
References: <1452244478-151381-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1452244478-151381-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Fan Zhang <zhangfan@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Fan Zhang <zhangfan@linux.vnet.ibm.com>

This patch adds runtime instrumentation support for KVM guest. We need to
setup a save area for the runtime instrumentation-controls control block(RICCB)
and implement the necessary interfaces to live migrate the guest settings.

We setup the sie control block in a way, that the runtime
instrumentation instructions of a guest are handled by hardware.

We also add a capability KVM_CAP_S390_RI to make this feature opt-in as
it needs migration support.

Signed-off-by: Fan Zhang <zhangfan@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  3 ++-
 arch/s390/include/uapi/asm/kvm.h |  3 +++
 arch/s390/kvm/kvm-s390.c         | 22 ++++++++++++++++++++++
 include/uapi/linux/kvm.h         |  1 +
 4 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index c831441..df0acff 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -217,7 +217,8 @@ struct kvm_s390_sie_block {
 	__u64	pp;			/* 0x01de */
 	__u8	reserved1e6[2];		/* 0x01e6 */
 	__u64	itdba;			/* 0x01e8 */
-	__u8	reserved1f0[16];	/* 0x01f0 */
+	__u64   riccbd;			/* 0x01f0 */
+	__u8    reserved1f8[8];		/* 0x01f8 */
 } __attribute__((packed));
 
 struct kvm_s390_itdb {
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index d2aea31..fe84bd5 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -153,6 +153,7 @@ struct kvm_guest_debug_arch {
 #define KVM_SYNC_ARCH0  (1UL << 4)
 #define KVM_SYNC_PFAULT (1UL << 5)
 #define KVM_SYNC_VRS    (1UL << 6)
+#define KVM_SYNC_RICCB  (1UL << 7)
 /* definition of registers in kvm_run */
 struct kvm_sync_regs {
 	__u64 prefix;	/* prefix register */
@@ -170,6 +171,8 @@ struct kvm_sync_regs {
 	__u64 vrs[32][2];	/* vector registers */
 	__u8  reserved[512];	/* for future vector expansion */
 	__u32 fpc;	/* only valid with vector registers */
+	__u8 padding[52];	/* riccb needs to be 64byte aligned */
+	__u8 riccb[64];		/* runtime instrumentation controls block */
 };
 
 #define KVM_REG_S390_TODPR	(KVM_REG_S390 | KVM_REG_SIZE_U32 | 0x1)
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 9f8eea3..5927c61 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -258,6 +258,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_S390_VECTOR_REGISTERS:
 		r = MACHINE_HAS_VX;
 		break;
+	case KVM_CAP_S390_RI:
+		r = test_facility(64);
+		break;
 	default:
 		r = 0;
 	}
@@ -358,6 +361,20 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
 		VM_EVENT(kvm, 3, "ENABLE: CAP_S390_VECTOR_REGISTERS %s",
 			 r ? "(not available)" : "(success)");
 		break;
+	case KVM_CAP_S390_RI:
+		r = -EINVAL;
+		mutex_lock(&kvm->lock);
+		if (atomic_read(&kvm->online_vcpus)) {
+			r = -EBUSY;
+		} else if (test_facility(64)) {
+			set_kvm_facility(kvm->arch.model.fac->mask, 64);
+			set_kvm_facility(kvm->arch.model.fac->list, 64);
+			r = 0;
+		}
+		mutex_unlock(&kvm->lock);
+		VM_EVENT(kvm, 3, "ENABLE: CAP_S390_RI %s",
+			 r ? "(not available)" : "(success)");
+		break;
 	case KVM_CAP_S390_USER_STSI:
 		VM_EVENT(kvm, 3, "%s", "ENABLE: CAP_S390_USER_STSI");
 		kvm->arch.user_stsi = 1;
@@ -1395,6 +1412,8 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 				    KVM_SYNC_CRS |
 				    KVM_SYNC_ARCH0 |
 				    KVM_SYNC_PFAULT;
+	if (test_kvm_facility(vcpu->kvm, 64))
+		vcpu->run->kvm_valid_regs |= KVM_SYNC_RICCB;
 	if (test_kvm_facility(vcpu->kvm, 129))
 		vcpu->run->kvm_valid_regs |= KVM_SYNC_VRS;
 
@@ -1578,10 +1597,13 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 		vcpu->arch.sie_block->eca |= 1;
 	if (sclp.has_sigpif)
 		vcpu->arch.sie_block->eca |= 0x10000000U;
+	if (test_kvm_facility(vcpu->kvm, 64))
+		vcpu->arch.sie_block->ecb3 |= 0x01;
 	if (test_kvm_facility(vcpu->kvm, 129)) {
 		vcpu->arch.sie_block->eca |= 0x00020000;
 		vcpu->arch.sie_block->ecd |= 0x20000000;
 	}
+	vcpu->arch.sie_block->riccbd = (unsigned long) &vcpu->run->s.regs.riccb;
 	vcpu->arch.sie_block->ictl |= ICTL_ISKE | ICTL_SSKE | ICTL_RRBE;
 
 	if (vcpu->kvm->arch.use_cmma) {
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 6e32f75..9da9051 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -849,6 +849,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_SPLIT_IRQCHIP 121
 #define KVM_CAP_IOEVENTFD_ANY_LENGTH 122
 #define KVM_CAP_HYPERV_SYNIC 123
+#define KVM_CAP_S390_RI 124
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.3.0
