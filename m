From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v11 24/26] KVM: s390: device attrs to enable/disable AP interpretation
Date: Tue, 25 Sep 2018 19:16:39 -0400
Message-ID: <20180925231641.4954-25-akrowiak@linux.vnet.ibm.com>
References: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Tony Krowiak <akrowiak@linux.ibm.com>

Introduces two new VM crypto device attributes (KVM_S390_VM_CRYPTO)
to enable or disable AP instruction interpretation from userspace
via the KVM_SET_DEVICE_ATTR ioctl:

* The KVM_S390_VM_CRYPTO_ENABLE_APIE attribute enables hardware
  interpretation of AP instructions executed on the guest.

* The KVM_S390_VM_CRYPTO_DISABLE_APIE attribute disables hardware
  interpretation of AP instructions executed on the guest. In this
  case the instructions will be intercepted and pass through to
  the guest.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 arch/s390/include/uapi/asm/kvm.h |  2 ++
 arch/s390/kvm/kvm-s390.c         | 31 ++++++++++++++++++++++++++++---
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index 9a50f02b9894..16511d97e8dc 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -160,6 +160,8 @@ struct kvm_s390_vm_cpu_subfunc {
 #define KVM_S390_VM_CRYPTO_ENABLE_DEA_KW	1
 #define KVM_S390_VM_CRYPTO_DISABLE_AES_KW	2
 #define KVM_S390_VM_CRYPTO_DISABLE_DEA_KW	3
+#define KVM_S390_VM_CRYPTO_ENABLE_APIE		4
+#define KVM_S390_VM_CRYPTO_DISABLE_APIE		5
 
 /* kvm attributes for migration mode */
 #define KVM_S390_VM_MIGRATION_STOP	0
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index c94ef2d0dbe4..81fd82f7626d 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -856,12 +856,11 @@ void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm)
 
 static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
 {
-	if (!test_kvm_facility(kvm, 76))
-		return -EINVAL;
-
 	mutex_lock(&kvm->lock);
 	switch (attr->attr) {
 	case KVM_S390_VM_CRYPTO_ENABLE_AES_KW:
+		if (!test_kvm_facility(kvm, 76))
+			return -EINVAL;
 		get_random_bytes(
 			kvm->arch.crypto.crycb->aes_wrapping_key_mask,
 			sizeof(kvm->arch.crypto.crycb->aes_wrapping_key_mask));
@@ -869,6 +868,8 @@ static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
 		VM_EVENT(kvm, 3, "%s", "ENABLE: AES keywrapping support");
 		break;
 	case KVM_S390_VM_CRYPTO_ENABLE_DEA_KW:
+		if (!test_kvm_facility(kvm, 76))
+			return -EINVAL;
 		get_random_bytes(
 			kvm->arch.crypto.crycb->dea_wrapping_key_mask,
 			sizeof(kvm->arch.crypto.crycb->dea_wrapping_key_mask));
@@ -876,17 +877,35 @@ static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
 		VM_EVENT(kvm, 3, "%s", "ENABLE: DEA keywrapping support");
 		break;
 	case KVM_S390_VM_CRYPTO_DISABLE_AES_KW:
+		if (!test_kvm_facility(kvm, 76))
+			return -EINVAL;
 		kvm->arch.crypto.aes_kw = 0;
 		memset(kvm->arch.crypto.crycb->aes_wrapping_key_mask, 0,
 			sizeof(kvm->arch.crypto.crycb->aes_wrapping_key_mask));
 		VM_EVENT(kvm, 3, "%s", "DISABLE: AES keywrapping support");
 		break;
 	case KVM_S390_VM_CRYPTO_DISABLE_DEA_KW:
+		if (!test_kvm_facility(kvm, 76))
+			return -EINVAL;
 		kvm->arch.crypto.dea_kw = 0;
 		memset(kvm->arch.crypto.crycb->dea_wrapping_key_mask, 0,
 			sizeof(kvm->arch.crypto.crycb->dea_wrapping_key_mask));
 		VM_EVENT(kvm, 3, "%s", "DISABLE: DEA keywrapping support");
 		break;
+	case KVM_S390_VM_CRYPTO_ENABLE_APIE:
+		if (!ap_instructions_available()) {
+			mutex_unlock(&kvm->lock);
+			return -EOPNOTSUPP;
+		}
+		kvm->arch.crypto.apie = 1;
+		break;
+	case KVM_S390_VM_CRYPTO_DISABLE_APIE:
+		if (!ap_instructions_available()) {
+			mutex_unlock(&kvm->lock);
+			return -EOPNOTSUPP;
+		}
+		kvm->arch.crypto.apie = 0;
+		break;
 	default:
 		mutex_unlock(&kvm->lock);
 		return -ENXIO;
@@ -1495,6 +1514,10 @@ static int kvm_s390_vm_has_attr(struct kvm *kvm, struct kvm_device_attr *attr)
 		case KVM_S390_VM_CRYPTO_DISABLE_DEA_KW:
 			ret = 0;
 			break;
+		case KVM_S390_VM_CRYPTO_ENABLE_APIE:
+		case KVM_S390_VM_CRYPTO_DISABLE_APIE:
+			ret = ap_instructions_available() ? 0 : -ENXIO;
+			break;
 		default:
 			ret = -ENXIO;
 			break;
@@ -2062,6 +2085,7 @@ static u64 kvm_s390_get_initial_cpuid(void)
 static void kvm_s390_crypto_init(struct kvm *kvm)
 {
 	kvm->arch.crypto.crycb = &kvm->arch.sie_page2->crycb;
+	kvm->arch.crypto.apie = 0;
 	kvm_s390_set_crycb_format(kvm);
 
 	if (!test_kvm_facility(kvm, 76))
@@ -2601,6 +2625,7 @@ static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
 
 	vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
 	vcpu->arch.sie_block->ecb3 &= ~(ECB3_AES | ECB3_DEA);
+	vcpu->arch.sie_block->eca &= ~ECA_APIE;
 
 	if (vcpu->kvm->arch.crypto.apie)
 		vcpu->arch.sie_block->eca |= ECA_APIE;
-- 
2.19.0.221.g150f307
