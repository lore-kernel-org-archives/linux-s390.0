From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PULL 2/8] KVM: s390: expose gbea register to userspace
Date: Tue,  4 Mar 2014 12:27:12 +0100
Message-ID: <1393932438-58848-3-git-send-email-borntraeger@de.ibm.com>
References: <1393932438-58848-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1393932438-58848-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heinz Graalfs <graalfs@linux.vnet.ibm.com>, Thomas Huth <thuth@linux.vnet.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

For migration/reset we want to expose the guest breaking event
address register to userspace. Lets use ONE_REG for that purpose.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
---
 arch/s390/include/uapi/asm/kvm.h | 1 +
 arch/s390/kvm/kvm-s390.c         | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index 7663244..2f0ade2 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -77,4 +77,5 @@ struct kvm_sync_regs {
 #define KVM_REG_S390_PFCOMPARE	(KVM_REG_S390 | KVM_REG_SIZE_U64 | 0x6)
 #define KVM_REG_S390_PFSELECT	(KVM_REG_S390 | KVM_REG_SIZE_U64 | 0x7)
 #define KVM_REG_S390_PP		(KVM_REG_S390 | KVM_REG_SIZE_U64 | 0x8)
+#define KVM_REG_S390_GBEA	(KVM_REG_S390 | KVM_REG_SIZE_U64 | 0x9)
 #endif
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 0262936..a3e4c07 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -576,6 +576,10 @@ static int kvm_arch_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu,
 		r = put_user(vcpu->arch.sie_block->pp,
 			     (u64 __user *)reg->addr);
 		break;
+	case KVM_REG_S390_GBEA:
+		r = put_user(vcpu->arch.sie_block->gbea,
+			     (u64 __user *)reg->addr);
+		break;
 	default:
 		break;
 	}
@@ -621,6 +625,10 @@ static int kvm_arch_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu,
 		r = get_user(vcpu->arch.sie_block->pp,
 			     (u64 __user *)reg->addr);
 		break;
+	case KVM_REG_S390_GBEA:
+		r = get_user(vcpu->arch.sie_block->gbea,
+			     (u64 __user *)reg->addr);
+		break;
 	default:
 		break;
 	}
-- 
1.8.4.2
