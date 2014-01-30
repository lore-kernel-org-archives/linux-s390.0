From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PULL 8/8] KVM: async_pf: Exploit one reg interface for pfault
Date: Thu, 30 Jan 2014 13:53:49 +0100
Message-ID: <1391086429-43935-9-git-send-email-borntraeger@de.ibm.com>
References: <1391086429-43935-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1391086429-43935-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Alexander Graf <agraf@suse.de>, Dominik Dingel <dingel@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Dominik Dingel <dingel@linux.vnet.ibm.com>

To enable pfault after live migration we need to expose pfault_token,
pfault_select and pfault_compare, as one reg registers to userspace.

So that qemu is able to transfer this between the source and the target.

Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/uapi/asm/kvm.h |  3 +++
 arch/s390/kvm/kvm-s390.c         | 24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index ccfd0b1..cb4c1eb8 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -73,4 +73,7 @@ struct kvm_sync_regs {
 #define KVM_REG_S390_EPOCHDIFF	(KVM_REG_S390 | KVM_REG_SIZE_U64 | 0x2)
 #define KVM_REG_S390_CPU_TIMER  (KVM_REG_S390 | KVM_REG_SIZE_U64 | 0x3)
 #define KVM_REG_S390_CLOCK_COMP (KVM_REG_S390 | KVM_REG_SIZE_U64 | 0x4)
+#define KVM_REG_S390_PFTOKEN	(KVM_REG_S390 | KVM_REG_SIZE_U64 | 0x5)
+#define KVM_REG_S390_PFCOMPARE	(KVM_REG_S390 | KVM_REG_SIZE_U64 | 0x6)
+#define KVM_REG_S390_PFSELECT	(KVM_REG_S390 | KVM_REG_SIZE_U64 | 0x7)
 #endif
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index d8e9f04..a5da2cc 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -561,6 +561,18 @@ static int kvm_arch_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu,
 		r = put_user(vcpu->arch.sie_block->ckc,
 			     (u64 __user *)reg->addr);
 		break;
+	case KVM_REG_S390_PFTOKEN:
+		r = put_user(vcpu->arch.pfault_token,
+			     (u64 __user *)reg->addr);
+		break;
+	case KVM_REG_S390_PFCOMPARE:
+		r = put_user(vcpu->arch.pfault_compare,
+			     (u64 __user *)reg->addr);
+		break;
+	case KVM_REG_S390_PFSELECT:
+		r = put_user(vcpu->arch.pfault_select,
+			     (u64 __user *)reg->addr);
+		break;
 	default:
 		break;
 	}
@@ -590,6 +602,18 @@ static int kvm_arch_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu,
 		r = get_user(vcpu->arch.sie_block->ckc,
 			     (u64 __user *)reg->addr);
 		break;
+	case KVM_REG_S390_PFTOKEN:
+		r = get_user(vcpu->arch.pfault_token,
+			     (u64 __user *)reg->addr);
+		break;
+	case KVM_REG_S390_PFCOMPARE:
+		r = get_user(vcpu->arch.pfault_compare,
+			     (u64 __user *)reg->addr);
+		break;
+	case KVM_REG_S390_PFSELECT:
+		r = get_user(vcpu->arch.pfault_select,
+			     (u64 __user *)reg->addr);
+		break;
 	default:
 		break;
 	}
-- 
1.8.4.2
