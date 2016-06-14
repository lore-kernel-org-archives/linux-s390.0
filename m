From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 09/52] KVM: s390: interface to query and configure cpu features
Date: Tue, 14 Jun 2016 20:56:46 +0200
Message-ID: <201606141857.u5EIs1u1001884@mx0a-001b2d01.pphosted.com>
References: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

For now, we only have an interface to query and configure facilities
indicated via STFL(E). However, we also have features indicated via
SCLP, that have to be indicated to the guest by user space and usually
require KVM support.

This patch allows user space to query and configure available cpu features
for the guest.

Please note that disabling a feature doesn't necessarily mean that it is
completely disabled (e.g. ESOP is mostly handled by the SIE). We will try
our best to disable it.

Most features (e.g. SCLP) can't directly be forwarded, as most of them need
in addition to hardware support, support in KVM. As we later on want to
turn these features in KVM explicitly on/off (to simulate different
behavior), we have to filter all features provided by the hardware and
make them configurable.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/devices/vm.txt | 27 ++++++++++++++
 arch/s390/include/asm/kvm_host.h         |  2 +
 arch/s390/include/uapi/asm/kvm.h         |  8 ++++
 arch/s390/kvm/kvm-s390.c                 | 63 ++++++++++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.h                 |  6 +++
 5 files changed, 106 insertions(+)

diff --git a/Documentation/virtual/kvm/devices/vm.txt b/Documentation/virtual/kvm/devices/vm.txt
index a9ea877..0ed6808 100644
--- a/Documentation/virtual/kvm/devices/vm.txt
+++ b/Documentation/virtual/kvm/devices/vm.txt
@@ -85,6 +85,33 @@ Returns:    -EBUSY in case 1 or more vcpus are already activated (only in write
 	    -ENOMEM if not enough memory is available to process the ioctl
 	    0 in case of success
 
+2.3. ATTRIBUTE: KVM_S390_VM_CPU_MACHINE_FEAT (r/o)
+
+Allows user space to retrieve available cpu features. A feature is available if
+provided by the hardware and supported by kvm. In theory, cpu features could
+even be completely emulated by kvm.
+
+struct kvm_s390_vm_cpu_feat {
+        __u64 feat[16]; # Bitmap (1 = feature available), MSB 0 bit numbering
+};
+
+Parameters: address of a buffer to load the feature list from.
+Returns:    -EFAULT if the given address is not accessible from kernel space.
+	    0 in case of success.
+
+2.4. ATTRIBUTE: KVM_S390_VM_CPU_PROCESSOR_FEAT (r/w)
+
+Allows user space to retrieve or change enabled cpu features for all VCPUs of a
+VM. Features that are not available cannot be enabled.
+
+See 2.3. for a description of the parameter struct.
+
+Parameters: address of a buffer to store/load the feature list from.
+Returns:    -EFAULT if the given address is not accessible from kernel space.
+	    -EINVAL if a cpu feature that is not available is to be enabled.
+	    -EBUSY if at least one VCPU has already been defined.
+	    0 in case of success.
+
 3. GROUP: KVM_S390_VM_TOD
 Architectures: s390
 
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index bcc20dc..b2a83a0 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -658,6 +658,8 @@ struct kvm_arch{
 	struct kvm_s390_cpu_model model;
 	struct kvm_s390_crypto crypto;
 	u64 epoch;
+	/* subset of available cpu features enabled by user space */
+	DECLARE_BITMAP(cpu_feat, KVM_S390_VM_CPU_FEAT_NR_BITS);
 };
 
 #define KVM_HVA_ERR_BAD		(-1UL)
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index 3b8e99e..a8559f2 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -93,6 +93,14 @@ struct kvm_s390_vm_cpu_machine {
 	__u64 fac_list[256];
 };
 
+#define KVM_S390_VM_CPU_PROCESSOR_FEAT	2
+#define KVM_S390_VM_CPU_MACHINE_FEAT	3
+
+#define KVM_S390_VM_CPU_FEAT_NR_BITS	1024
+struct kvm_s390_vm_cpu_feat {
+	__u64 feat[16];
+};
+
 /* kvm attributes for crypto */
 #define KVM_S390_VM_CRYPTO_ENABLE_AES_KW	0
 #define KVM_S390_VM_CRYPTO_ENABLE_DEA_KW	1
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 44297ff..6960468 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/timer.h>
 #include <linux/vmalloc.h>
+#include <linux/bitmap.h>
 #include <asm/asm-offsets.h>
 #include <asm/lowcore.h>
 #include <asm/etr.h>
@@ -132,6 +133,9 @@ unsigned long kvm_s390_fac_list_mask_size(void)
 	return ARRAY_SIZE(kvm_s390_fac_list_mask);
 }
 
+/* available cpu features supported by kvm */
+static DECLARE_BITMAP(kvm_s390_available_cpu_feat, KVM_S390_VM_CPU_FEAT_NR_BITS);
+
 static struct gmap_notifier gmap_notifier;
 debug_info_t *kvm_s390_dbf;
 
@@ -677,6 +681,29 @@ out:
 	return ret;
 }
 
+static int kvm_s390_set_processor_feat(struct kvm *kvm,
+				       struct kvm_device_attr *attr)
+{
+	struct kvm_s390_vm_cpu_feat data;
+	int ret = -EBUSY;
+
+	if (copy_from_user(&data, (void __user *)attr->addr, sizeof(data)))
+		return -EFAULT;
+	if (!bitmap_subset((unsigned long *) data.feat,
+			   kvm_s390_available_cpu_feat,
+			   KVM_S390_VM_CPU_FEAT_NR_BITS))
+		return -EINVAL;
+
+	mutex_lock(&kvm->lock);
+	if (!atomic_read(&kvm->online_vcpus)) {
+		bitmap_copy(kvm->arch.cpu_feat, (unsigned long *) data.feat,
+			    KVM_S390_VM_CPU_FEAT_NR_BITS);
+		ret = 0;
+	}
+	mutex_unlock(&kvm->lock);
+	return ret;
+}
+
 static int kvm_s390_set_cpu_model(struct kvm *kvm, struct kvm_device_attr *attr)
 {
 	int ret = -ENXIO;
@@ -685,6 +712,9 @@ static int kvm_s390_set_cpu_model(struct kvm *kvm, struct kvm_device_attr *attr)
 	case KVM_S390_VM_CPU_PROCESSOR:
 		ret = kvm_s390_set_processor(kvm, attr);
 		break;
+	case KVM_S390_VM_CPU_PROCESSOR_FEAT:
+		ret = kvm_s390_set_processor_feat(kvm, attr);
+		break;
 	}
 	return ret;
 }
@@ -733,6 +763,31 @@ out:
 	return ret;
 }
 
+static int kvm_s390_get_processor_feat(struct kvm *kvm,
+				       struct kvm_device_attr *attr)
+{
+	struct kvm_s390_vm_cpu_feat data;
+
+	bitmap_copy((unsigned long *) data.feat, kvm->arch.cpu_feat,
+		    KVM_S390_VM_CPU_FEAT_NR_BITS);
+	if (copy_to_user((void __user *)attr->addr, &data, sizeof(data)))
+		return -EFAULT;
+	return 0;
+}
+
+static int kvm_s390_get_machine_feat(struct kvm *kvm,
+				     struct kvm_device_attr *attr)
+{
+	struct kvm_s390_vm_cpu_feat data;
+
+	bitmap_copy((unsigned long *) data.feat,
+		    kvm_s390_available_cpu_feat,
+		    KVM_S390_VM_CPU_FEAT_NR_BITS);
+	if (copy_to_user((void __user *)attr->addr, &data, sizeof(data)))
+		return -EFAULT;
+	return 0;
+}
+
 static int kvm_s390_get_cpu_model(struct kvm *kvm, struct kvm_device_attr *attr)
 {
 	int ret = -ENXIO;
@@ -744,6 +799,12 @@ static int kvm_s390_get_cpu_model(struct kvm *kvm, struct kvm_device_attr *attr)
 	case KVM_S390_VM_CPU_MACHINE:
 		ret = kvm_s390_get_machine(kvm, attr);
 		break;
+	case KVM_S390_VM_CPU_PROCESSOR_FEAT:
+		ret = kvm_s390_get_processor_feat(kvm, attr);
+		break;
+	case KVM_S390_VM_CPU_MACHINE_FEAT:
+		ret = kvm_s390_get_machine_feat(kvm, attr);
+		break;
 	}
 	return ret;
 }
@@ -827,6 +888,8 @@ static int kvm_s390_vm_has_attr(struct kvm *kvm, struct kvm_device_attr *attr)
 		switch (attr->attr) {
 		case KVM_S390_VM_CPU_PROCESSOR:
 		case KVM_S390_VM_CPU_MACHINE:
+		case KVM_S390_VM_CPU_PROCESSOR_FEAT:
+		case KVM_S390_VM_CPU_MACHINE_FEAT:
 			ret = 0;
 			break;
 		default:
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index c5ec4d3..52aa47e 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -175,6 +175,12 @@ static inline int set_kvm_facility(u64 *fac_list, unsigned long nr)
 	return 0;
 }
 
+static inline int test_kvm_cpu_feat(struct kvm *kvm, unsigned long nr)
+{
+	WARN_ON_ONCE(nr >= KVM_S390_VM_CPU_FEAT_NR_BITS);
+	return test_bit_inv(nr, kvm->arch.cpu_feat);
+}
+
 /* are cpu states controlled by user space */
 static inline int kvm_s390_user_cpu_state_ctrl(struct kvm *kvm)
 {
-- 
2.5.5
