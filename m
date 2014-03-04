From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PULL 1/8] KVM: s390: Provide access to program parameter
Date: Tue,  4 Mar 2014 12:27:11 +0100
Message-ID: <1393932438-58848-2-git-send-email-borntraeger@de.ibm.com>
References: <1393932438-58848-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1393932438-58848-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heinz Graalfs <graalfs@linux.vnet.ibm.com>, Thomas Huth <thuth@linux.vnet.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

commit d208c79d63e06457eef077af770d23dc4cde4d43 (KVM: s390: Enable
the LPP facility for guests) enabled the LPP instruction for guests.
We should expose the program parameter as a pseudo register for
migration/reset etc. Lets also reset this value on initial CPU
reset.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 4 +++-
 arch/s390/include/uapi/asm/kvm.h | 1 +
 arch/s390/kvm/kvm-s390.c         | 9 +++++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 2c69ba2..062b78c 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -107,7 +107,9 @@ struct kvm_s390_sie_block {
 	__u64	gbea;			/* 0x0180 */
 	__u8	reserved188[24];	/* 0x0188 */
 	__u32	fac;			/* 0x01a0 */
-	__u8	reserved1a4[68];	/* 0x01a4 */
+	__u8	reserved1a4[58];	/* 0x01a4 */
+	__u64	pp;			/* 0x01de */
+	__u8	reserved1e6[2];		/* 0x01e6 */
 	__u64	itdba;			/* 0x01e8 */
 	__u8	reserved1f0[16];	/* 0x01f0 */
 } __attribute__((packed));
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index cb4c1eb8..7663244 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -76,4 +76,5 @@ struct kvm_sync_regs {
 #define KVM_REG_S390_PFTOKEN	(KVM_REG_S390 | KVM_REG_SIZE_U64 | 0x5)
 #define KVM_REG_S390_PFCOMPARE	(KVM_REG_S390 | KVM_REG_SIZE_U64 | 0x6)
 #define KVM_REG_S390_PFSELECT	(KVM_REG_S390 | KVM_REG_SIZE_U64 | 0x7)
+#define KVM_REG_S390_PP		(KVM_REG_S390 | KVM_REG_SIZE_U64 | 0x8)
 #endif
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 18959bb..0262936 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -386,6 +386,7 @@ static void kvm_s390_vcpu_initial_reset(struct kvm_vcpu *vcpu)
 	vcpu->arch.guest_fpregs.fpc = 0;
 	asm volatile("lfpc %0" : : "Q" (vcpu->arch.guest_fpregs.fpc));
 	vcpu->arch.sie_block->gbea = 1;
+	vcpu->arch.sie_block->pp = 0;
 	vcpu->arch.pfault_token = KVM_S390_PFAULT_TOKEN_INVALID;
 	kvm_clear_async_pf_completion_queue(vcpu);
 	atomic_set_mask(CPUSTAT_STOPPED, &vcpu->arch.sie_block->cpuflags);
@@ -571,6 +572,10 @@ static int kvm_arch_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu,
 		r = put_user(vcpu->arch.pfault_select,
 			     (u64 __user *)reg->addr);
 		break;
+	case KVM_REG_S390_PP:
+		r = put_user(vcpu->arch.sie_block->pp,
+			     (u64 __user *)reg->addr);
+		break;
 	default:
 		break;
 	}
@@ -612,6 +617,10 @@ static int kvm_arch_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu,
 		r = get_user(vcpu->arch.pfault_select,
 			     (u64 __user *)reg->addr);
 		break;
+	case KVM_REG_S390_PP:
+		r = get_user(vcpu->arch.sie_block->pp,
+			     (u64 __user *)reg->addr);
+		break;
 	default:
 		break;
 	}
-- 
1.8.4.2
