From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/3] kvm: s390: Per-vm kvm device controls
Date: Thu, 10 Apr 2014 13:16:42 +0200
Message-ID: <1397128604-50161-2-git-send-email-borntraeger@de.ibm.com>
References: <1397128604-50161-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1397128604-50161-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Dominik Dingel <dingel@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Dominik Dingel <dingel@linux.vnet.ibm.com>

We sometimes need to get/set attributes specific to a virtual machine
and so need something else than ONE_REG.

Let's copy the KVM_DEVICE approach, and define the respective ioctls
for the vm file descriptor.

Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/api.txt        |  8 ++---
 Documentation/virtual/kvm/devices/vm.txt |  6 ++++
 arch/s390/kvm/kvm-s390.c                 | 54 ++++++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h                 |  1 +
 4 files changed, 65 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/virtual/kvm/devices/vm.txt

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index c24211d..f69731a 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2314,8 +2314,8 @@ struct kvm_create_device {
 
 4.80 KVM_SET_DEVICE_ATTR/KVM_GET_DEVICE_ATTR
 
-Capability: KVM_CAP_DEVICE_CTRL
-Type: device ioctl
+Capability: KVM_CAP_DEVICE_CTRL, KVM_CAP_VM_ATTRIBUTES for vm device
+Type: device ioctl, vm ioctl
 Parameters: struct kvm_device_attr
 Returns: 0 on success, -1 on error
 Errors:
@@ -2340,8 +2340,8 @@ struct kvm_device_attr {
 
 4.81 KVM_HAS_DEVICE_ATTR
 
-Capability: KVM_CAP_DEVICE_CTRL
-Type: device ioctl
+Capability: KVM_CAP_DEVICE_CTRL, KVM_CAP_VM_ATTRIBUTES for vm device
+Type: device ioctl, vm ioctl
 Parameters: struct kvm_device_attr
 Returns: 0 on success, -1 on error
 Errors:
diff --git a/Documentation/virtual/kvm/devices/vm.txt b/Documentation/virtual/kvm/devices/vm.txt
new file mode 100644
index 0000000..4fe1532
--- /dev/null
+++ b/Documentation/virtual/kvm/devices/vm.txt
@@ -0,0 +1,6 @@
+Generic vm interface
+====================================
+
+The interface handles per-vm attributes, such as CMMA status on s390 and is
+similar in way to ONE_REG, but targeting the whole vm instead of one vcpu
+alone. It is available with KVM_CAP_VM_ATTRIBUTES.
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 346a347..c335a2e 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -162,6 +162,7 @@ int kvm_dev_ioctl_check_extension(long ext)
 	case KVM_CAP_IOEVENTFD:
 	case KVM_CAP_DEVICE_CTRL:
 	case KVM_CAP_ENABLE_CAP_VM:
+	case KVM_CAP_VM_ATTRIBUTES:
 		r = 1;
 		break;
 	case KVM_CAP_NR_VCPUS:
@@ -257,11 +258,43 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
 	return r;
 }
 
+static int kvm_s390_vm_set_attr(struct kvm *kvm, struct kvm_device_attr *attr)
+{
+	int ret;
+
+	switch (attr->group) {
+	default:
+		ret = -ENXIO;
+		break;
+	}
+
+	return ret;
+}
+
+static int kvm_s390_vm_get_attr(struct kvm *kvm, struct kvm_device_attr *attr)
+{
+	return -ENXIO;
+}
+
+static int kvm_s390_vm_has_attr(struct kvm *kvm, struct kvm_device_attr *attr)
+{
+	int ret;
+
+	switch (attr->group) {
+	default:
+		ret = -ENXIO;
+		break;
+	}
+
+	return ret;
+}
+
 long kvm_arch_vm_ioctl(struct file *filp,
 		       unsigned int ioctl, unsigned long arg)
 {
 	struct kvm *kvm = filp->private_data;
 	void __user *argp = (void __user *)arg;
+	struct kvm_device_attr attr;
 	int r;
 
 	switch (ioctl) {
@@ -294,6 +327,27 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		}
 		break;
 	}
+	case KVM_SET_DEVICE_ATTR: {
+		r = -EFAULT;
+		if (copy_from_user(&attr, (void __user *)arg, sizeof(attr)))
+			break;
+		r = kvm_s390_vm_set_attr(kvm, &attr);
+		break;
+	}
+	case KVM_GET_DEVICE_ATTR: {
+		r = -EFAULT;
+		if (copy_from_user(&attr, (void __user *)arg, sizeof(attr)))
+			break;
+		r = kvm_s390_vm_get_attr(kvm, &attr);
+		break;
+	}
+	case KVM_HAS_DEVICE_ATTR: {
+		r = -EFAULT;
+		if (copy_from_user(&attr, (void __user *)arg, sizeof(attr)))
+			break;
+		r = kvm_s390_vm_has_attr(kvm, &attr);
+		break;
+	}
 	default:
 		r = -ENOTTY;
 	}
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index a8f4ee5..90acfe4 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -743,6 +743,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_IOAPIC_POLARITY_IGNORED 97
 #define KVM_CAP_ENABLE_CAP_VM 98
 #define KVM_CAP_S390_IRQCHIP 99
+#define KVM_CAP_VM_ATTRIBUTES 100
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
1.8.4.2
