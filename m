From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 4/9] KVM: S390: add new group for flic
Date: Wed, 28 Jun 2017 19:30:39 +0200
Message-ID: <1498671044-81240-5-git-send-email-borntraeger@de.ibm.com>
References: <1498671044-81240-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1498671044-81240-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>

In some cases, userspace needs to get or set all ais states for example
migration. So we introduce a new group KVM_DEV_FLIC_AISM_ALL to provide
interfaces to get or set the adapter-interruption-suppression mode for
all ISCs. The corresponding documentation is updated.

Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/devices/s390_flic.txt | 15 ++++++++
 arch/s390/include/uapi/asm/kvm.h                |  6 ++++
 arch/s390/kvm/interrupt.c                       | 48 +++++++++++++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/Documentation/virtual/kvm/devices/s390_flic.txt b/Documentation/virtual/kvm/devices/s390_flic.txt
index c2518ce..2f1cbf1 100644
--- a/Documentation/virtual/kvm/devices/s390_flic.txt
+++ b/Documentation/virtual/kvm/devices/s390_flic.txt
@@ -16,6 +16,7 @@ FLIC provides support to
 - register and modify adapter interrupt sources (KVM_DEV_FLIC_ADAPTER_*)
 - modify AIS (adapter-interruption-suppression) mode state (KVM_DEV_FLIC_AISM)
 - inject adapter interrupts on a specified adapter (KVM_DEV_FLIC_AIRQ_INJECT)
+- get/set all AIS mode states (KVM_DEV_FLIC_AISM_ALL)
 
 Groups:
   KVM_DEV_FLIC_ENQUEUE
@@ -136,6 +137,20 @@ struct kvm_s390_ais_req {
     an isc according to the adapter-interruption-suppression mode on condition
     that the AIS capability is enabled.
 
+  KVM_DEV_FLIC_AISM_ALL
+    Gets or sets the adapter-interruption-suppression mode for all ISCs. Takes
+    a kvm_s390_ais_all describing:
+
+struct kvm_s390_ais_all {
+       __u8 simm; /* Single-Interruption-Mode mask */
+       __u8 nimm; /* No-Interruption-Mode mask *
+};
+
+    simm contains Single-Interruption-Mode mask for all ISCs, nimm contains
+    No-Interruption-Mode mask for all ISCs. Each bit in simm and nimm corresponds
+    to an ISC (MSB0 bit 0 to ISC 0 and so on). The combination of simm bit and
+    nimm bit presents AIS mode for a ISC.
+
 Note: The KVM_SET_DEVICE_ATTR/KVM_GET_DEVICE_ATTR device ioctls executed on
 FLIC with an unknown group or attribute gives the error code EINVAL (instead of
 ENXIO, as specified in the API documentation). It is not possible to conclude
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index d6879a9..69d09c3 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -28,6 +28,7 @@
 #define KVM_DEV_FLIC_CLEAR_IO_IRQ	8
 #define KVM_DEV_FLIC_AISM		9
 #define KVM_DEV_FLIC_AIRQ_INJECT	10
+#define KVM_DEV_FLIC_AISM_ALL		11
 /*
  * We can have up to 4*64k pending subchannels + 8 adapter interrupts,
  * as well as up  to ASYNC_PF_PER_VCPU*KVM_MAX_VCPUS pfault done interrupts.
@@ -53,6 +54,11 @@ struct kvm_s390_ais_req {
 	__u16 mode;
 };
 
+struct kvm_s390_ais_all {
+	__u8 simm;
+	__u8 nimm;
+};
+
 #define KVM_S390_IO_ADAPTER_MASK 1
 #define KVM_S390_IO_ADAPTER_MAP 2
 #define KVM_S390_IO_ADAPTER_UNMAP 3
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index caf15c8a..72f3aaf 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1876,6 +1876,28 @@ static int get_all_floating_irqs(struct kvm *kvm, u8 __user *usrbuf, u64 len)
 	return ret < 0 ? ret : n;
 }
 
+static int flic_ais_mode_get_all(struct kvm *kvm, struct kvm_device_attr *attr)
+{
+	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
+	struct kvm_s390_ais_all ais;
+
+	if (attr->attr < sizeof(ais))
+		return -EINVAL;
+
+	if (!test_kvm_facility(kvm, 72))
+		return -ENOTSUPP;
+
+	mutex_lock(&fi->ais_lock);
+	ais.simm = fi->simm;
+	ais.nimm = fi->nimm;
+	mutex_unlock(&fi->ais_lock);
+
+	if (copy_to_user((void __user *)attr->addr, &ais, sizeof(ais)))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int flic_get_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 {
 	int r;
@@ -1885,6 +1907,9 @@ static int flic_get_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 		r = get_all_floating_irqs(dev->kvm, (u8 __user *) attr->addr,
 					  attr->attr);
 		break;
+	case KVM_DEV_FLIC_AISM_ALL:
+		r = flic_ais_mode_get_all(dev->kvm, attr);
+		break;
 	default:
 		r = -EINVAL;
 	}
@@ -2235,6 +2260,25 @@ static int flic_inject_airq(struct kvm *kvm, struct kvm_device_attr *attr)
 	return kvm_s390_inject_airq(kvm, adapter);
 }
 
+static int flic_ais_mode_set_all(struct kvm *kvm, struct kvm_device_attr *attr)
+{
+	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
+	struct kvm_s390_ais_all ais;
+
+	if (!test_kvm_facility(kvm, 72))
+		return -ENOTSUPP;
+
+	if (copy_from_user(&ais, (void __user *)attr->addr, sizeof(ais)))
+		return -EFAULT;
+
+	mutex_lock(&fi->ais_lock);
+	fi->simm = ais.simm;
+	fi->nimm = ais.nimm;
+	mutex_unlock(&fi->ais_lock);
+
+	return 0;
+}
+
 static int flic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 {
 	int r = 0;
@@ -2277,6 +2321,9 @@ static int flic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 	case KVM_DEV_FLIC_AIRQ_INJECT:
 		r = flic_inject_airq(dev->kvm, attr);
 		break;
+	case KVM_DEV_FLIC_AISM_ALL:
+		r = flic_ais_mode_set_all(dev->kvm, attr);
+		break;
 	default:
 		r = -EINVAL;
 	}
@@ -2298,6 +2345,7 @@ static int flic_has_attr(struct kvm_device *dev,
 	case KVM_DEV_FLIC_CLEAR_IO_IRQ:
 	case KVM_DEV_FLIC_AISM:
 	case KVM_DEV_FLIC_AIRQ_INJECT:
+	case KVM_DEV_FLIC_AISM_ALL:
 		return 0;
 	}
 	return -ENXIO;
-- 
2.7.4
