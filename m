From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v3 04/14] KVM: s390: device attribute to set AP interpretive execution
Date: Wed, 14 Mar 2018 14:25:44 -0400
Message-ID: <1521051954-25715-5-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

The VFIO AP device model exploits interpretive execution of AP
instructions (APIE) to provide guests passthrough access to AP
devices. This patch introduces a new device attribute in the
KVM_S390_VM_CRYPTO device attribute group to set APIE from
the VFIO AP device defined on the guest.

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |    1 +
 arch/s390/include/uapi/asm/kvm.h |    1 +
 arch/s390/kvm/kvm-s390.c         |   19 +++++++++++++++++++
 3 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 98957c2..bbac5a1 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -699,6 +699,7 @@ struct kvm_s390_crypto {
 	__u32 crycbd;
 	__u8 aes_kw;
 	__u8 dea_kw;
+	__u8 apie;
 };
 
 #define APCB0_MASK_SIZE 1
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index a580dec..fdcbeb9 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -161,6 +161,7 @@ struct kvm_s390_vm_cpu_subfunc {
 #define KVM_S390_VM_CRYPTO_ENABLE_DEA_KW	1
 #define KVM_S390_VM_CRYPTO_DISABLE_AES_KW	2
 #define KVM_S390_VM_CRYPTO_DISABLE_DEA_KW	3
+#define KVM_S390_VM_CRYPTO_INTERPRET_AP		4
 
 /* kvm attributes for migration mode */
 #define KVM_S390_VM_MIGRATION_STOP	0
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index a60c45b..bc46b67 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -815,6 +815,19 @@ static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
 			sizeof(kvm->arch.crypto.crycb->dea_wrapping_key_mask));
 		VM_EVENT(kvm, 3, "%s", "DISABLE: DEA keywrapping support");
 		break;
+	case KVM_S390_VM_CRYPTO_INTERPRET_AP:
+		if (attr->addr) {
+			if (!test_kvm_cpu_feat(kvm, KVM_S390_VM_CPU_FEAT_AP))
+				return -EOPNOTSUPP;
+			kvm->arch.crypto.apie = 1;
+			VM_EVENT(kvm, 3, "%s",
+				 "ENABLE: AP interpretive execution");
+		} else {
+			kvm->arch.crypto.apie = 0;
+			VM_EVENT(kvm, 3, "%s",
+				 "DISABLE: AP interpretive execution");
+		}
+		break;
 	default:
 		mutex_unlock(&kvm->lock);
 		return -ENXIO;
@@ -1453,6 +1466,7 @@ static int kvm_s390_vm_has_attr(struct kvm *kvm, struct kvm_device_attr *attr)
 		case KVM_S390_VM_CRYPTO_ENABLE_DEA_KW:
 		case KVM_S390_VM_CRYPTO_DISABLE_AES_KW:
 		case KVM_S390_VM_CRYPTO_DISABLE_DEA_KW:
+		case KVM_S390_VM_CRYPTO_INTERPRET_AP:
 			ret = 0;
 			break;
 		default:
@@ -2409,6 +2423,11 @@ static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
 
+	if (vcpu->kvm->arch.crypto.apie)
+		vcpu->arch.sie_block->eca |= ECA_APIE;
+	else
+		vcpu->arch.sie_block->eca &= ~ECA_APIE;
+
 	if (!test_kvm_facility(vcpu->kvm, 76))
 		return;
 
-- 
1.7.1
