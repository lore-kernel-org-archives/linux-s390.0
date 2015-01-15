From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 21/21] KVM: s390/cpacf: Enable/disable protected key functions for kvm guest
Date: Thu, 15 Jan 2015 14:43:34 +0100
Message-ID: <1421329414-76826-22-git-send-email-borntraeger@de.ibm.com>
References: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>

Created new KVM device attributes for indicating whether the AES and
DES/TDES protected key functions are available for programs running
on the KVM guest.  The attributes are used to set up the controls in
the guest SIE block that specify whether programs running on the
guest will be given access to the protected key functions available
on the s390 hardware.

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
[split MSA4/protected key into two patches]
---
 arch/s390/include/asm/kvm_host.h | 10 ++++--
 arch/s390/include/uapi/asm/kvm.h |  7 ++++
 arch/s390/kvm/kvm-s390.c         | 75 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 8e22aa0..d1ecc7f 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -134,7 +134,9 @@ struct kvm_s390_sie_block {
 	__u8	reserved60;		/* 0x0060 */
 	__u8	ecb;			/* 0x0061 */
 	__u8    ecb2;                   /* 0x0062 */
-	__u8    reserved63[1];          /* 0x0063 */
+#define ECB3_AES 0x04
+#define ECB3_DEA 0x08
+	__u8    ecb3;			/* 0x0063 */
 	__u32	scaol;			/* 0x0064 */
 	__u8	reserved68[4];		/* 0x0068 */
 	__u32	todpr;			/* 0x006c */
@@ -505,10 +507,14 @@ struct s390_io_adapter {
 struct kvm_s390_crypto {
 	struct kvm_s390_crypto_cb *crycb;
 	__u32 crycbd;
+	__u8 aes_kw;
+	__u8 dea_kw;
 };
 
 struct kvm_s390_crypto_cb {
-	__u8    reserved00[128];                /* 0x0000 */
+	__u8    reserved00[72];                 /* 0x0000 */
+	__u8    dea_wrapping_key_mask[24];      /* 0x0048 */
+	__u8    aes_wrapping_key_mask[32];      /* 0x0060 */
 };
 
 struct kvm_arch{
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index 6c2efec..968a1cc 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -58,6 +58,7 @@ struct kvm_s390_io_adapter_req {
 /* kvm attr_group  on vm fd */
 #define KVM_S390_VM_MEM_CTRL		0
 #define KVM_S390_VM_TOD			1
+#define KVM_S390_VM_CRYPTO		2
 
 /* kvm attributes for mem_ctrl */
 #define KVM_S390_VM_MEM_ENABLE_CMMA	0
@@ -68,6 +69,12 @@ struct kvm_s390_io_adapter_req {
 #define KVM_S390_VM_TOD_LOW		0
 #define KVM_S390_VM_TOD_HIGH		1
 
+/* kvm attributes for crypto */
+#define KVM_S390_VM_CRYPTO_ENABLE_AES_KW	0
+#define KVM_S390_VM_CRYPTO_ENABLE_DEA_KW	1
+#define KVM_S390_VM_CRYPTO_DISABLE_AES_KW	2
+#define KVM_S390_VM_CRYPTO_DISABLE_DEA_KW	3
+
 /* for KVM_GET_REGS and KVM_SET_REGS */
 struct kvm_regs {
 	/* general purpose regs for s390 */
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 9cf899e..b2371c0 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -22,6 +22,7 @@
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
 #include <linux/module.h>
+#include <linux/random.h>
 #include <linux/slab.h>
 #include <linux/timer.h>
 #include <asm/asm-offsets.h>
@@ -342,6 +343,53 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 	return ret;
 }
 
+static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu);
+
+static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
+{
+	struct kvm_vcpu *vcpu;
+	int i;
+
+	if (!test_vfacility(76))
+		return -EINVAL;
+
+	mutex_lock(&kvm->lock);
+	switch (attr->attr) {
+	case KVM_S390_VM_CRYPTO_ENABLE_AES_KW:
+		get_random_bytes(
+			kvm->arch.crypto.crycb->aes_wrapping_key_mask,
+			sizeof(kvm->arch.crypto.crycb->aes_wrapping_key_mask));
+		kvm->arch.crypto.aes_kw = 1;
+		break;
+	case KVM_S390_VM_CRYPTO_ENABLE_DEA_KW:
+		get_random_bytes(
+			kvm->arch.crypto.crycb->dea_wrapping_key_mask,
+			sizeof(kvm->arch.crypto.crycb->dea_wrapping_key_mask));
+		kvm->arch.crypto.dea_kw = 1;
+		break;
+	case KVM_S390_VM_CRYPTO_DISABLE_AES_KW:
+		kvm->arch.crypto.aes_kw = 0;
+		memset(kvm->arch.crypto.crycb->aes_wrapping_key_mask, 0,
+			sizeof(kvm->arch.crypto.crycb->aes_wrapping_key_mask));
+		break;
+	case KVM_S390_VM_CRYPTO_DISABLE_DEA_KW:
+		kvm->arch.crypto.dea_kw = 0;
+		memset(kvm->arch.crypto.crycb->dea_wrapping_key_mask, 0,
+			sizeof(kvm->arch.crypto.crycb->dea_wrapping_key_mask));
+		break;
+	default:
+		mutex_unlock(&kvm->lock);
+		return -ENXIO;
+	}
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		kvm_s390_vcpu_crypto_setup(vcpu);
+		exit_sie(vcpu);
+	}
+	mutex_unlock(&kvm->lock);
+	return 0;
+}
+
 static int kvm_s390_set_tod_high(struct kvm *kvm, struct kvm_device_attr *attr)
 {
 	u8 gtod_high;
@@ -460,6 +508,9 @@ static int kvm_s390_vm_set_attr(struct kvm *kvm, struct kvm_device_attr *attr)
 	case KVM_S390_VM_TOD:
 		ret = kvm_s390_set_tod(kvm, attr);
 		break;
+	case KVM_S390_VM_CRYPTO:
+		ret = kvm_s390_vm_set_crypto(kvm, attr);
+		break;
 	default:
 		ret = -ENXIO;
 		break;
@@ -515,6 +566,19 @@ static int kvm_s390_vm_has_attr(struct kvm *kvm, struct kvm_device_attr *attr)
 			break;
 		}
 		break;
+	case KVM_S390_VM_CRYPTO:
+		switch (attr->attr) {
+		case KVM_S390_VM_CRYPTO_ENABLE_AES_KW:
+		case KVM_S390_VM_CRYPTO_ENABLE_DEA_KW:
+		case KVM_S390_VM_CRYPTO_DISABLE_AES_KW:
+		case KVM_S390_VM_CRYPTO_DISABLE_DEA_KW:
+			ret = 0;
+			break;
+		default:
+			ret = -ENXIO;
+			break;
+		}
+		break;
 	default:
 		ret = -ENXIO;
 		break;
@@ -602,6 +666,10 @@ static int kvm_s390_crypto_init(struct kvm *kvm)
 	kvm->arch.crypto.crycbd = (__u32) (unsigned long) kvm->arch.crypto.crycb |
 				  CRYCB_FORMAT1;
 
+	/* Disable AES/DEA protected key functions by default */
+	kvm->arch.crypto.aes_kw = 0;
+	kvm->arch.crypto.dea_kw = 0;
+
 	return 0;
 }
 
@@ -823,6 +891,13 @@ static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
 	if (!test_vfacility(76))
 		return;
 
+	vcpu->arch.sie_block->ecb3 &= ~(ECB3_AES | ECB3_DEA);
+
+	if (vcpu->kvm->arch.crypto.aes_kw)
+		vcpu->arch.sie_block->ecb3 |= ECB3_AES;
+	if (vcpu->kvm->arch.crypto.dea_kw)
+		vcpu->arch.sie_block->ecb3 |= ECB3_DEA;
+
 	vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
 }
 
-- 
1.9.3
