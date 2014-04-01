From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC] KVM: s390: Add S390 configuration and control kvm device
Date: Tue,  1 Apr 2014 16:47:42 +0200
Message-ID: <1396363663-50450-2-git-send-email-borntraeger@de.ibm.com>
References: <1396363663-50450-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1396363663-50450-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Alexander Graf <agraf@suse.de>, Michael Mueller <mimu@linux.vnet.ibm.com>, Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>

Add KVM_DEV_TYPE_S390_CONFIG kvm device that contains
configuration and control attributes of particular vm.
The device is created by KVM_CREATE_DEVICE ioctl.
The attributes may be retrieved and stored by calling
KVM_GET_DEVICE_ATTR and KVM_SET_DEVICE_ATTR ioctls.

Signed-off-by: Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/devices/s390_config.txt |  13 +++
 arch/s390/include/asm/kvm_host.h                  |   6 +
 arch/s390/include/uapi/asm/kvm.h                  |  11 ++
 arch/s390/kvm/Makefile                            |   2 +-
 arch/s390/kvm/config.c                            | 133 ++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.c                          |   7 ++
 arch/s390/kvm/kvm-s390.h                          |   4 +
 arch/s390/kvm/priv.c                              |   6 +-
 include/linux/kvm_host.h                          |   1 +
 include/uapi/linux/kvm.h                          |   1 +
 virt/kvm/kvm_main.c                               |   3 +
 11 files changed, 185 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/virtual/kvm/devices/s390_config.txt
 create mode 100644 arch/s390/kvm/config.c

diff --git a/Documentation/virtual/kvm/devices/s390_config.txt b/Documentation/virtual/kvm/devices/s390_config.txt
new file mode 100644
index 0000000..f9bc251
--- /dev/null
+++ b/Documentation/virtual/kvm/devices/s390_config.txt
@@ -0,0 +1,13 @@
+S390 Config Device
+==================
+
+The s390 config device is used for storage and retrieval of various kinds
+of configuration related information which should be shared between kvm
+and userspace.
+
+Groups:
+KVM_DEV_CONFIG_GROUP
+
+Attributes for KVM_DEV_CONFIG_GROUP:
+KVM_DEV_CONFIG_NAME - The name for this vm instance. A string of at
+			   most 128 characters.
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 154b600..da93b6e 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -277,6 +277,11 @@ struct s390_io_adapter {
 #define MAX_S390_IO_ADAPTERS ((MAX_ISC + 1) * 8)
 #define MAX_S390_ADAPTER_MAPS 256
 
+struct kvm_s390_config {
+	struct mutex lock;
+	struct kvm_s390_attr_name name;
+};
+
 struct kvm_arch{
 	struct sca_block *sca;
 	debug_info_t *dbf;
@@ -286,6 +291,7 @@ struct kvm_arch{
 	int css_support;
 	int use_irqchip;
 	struct s390_io_adapter *adapters[MAX_S390_IO_ADAPTERS];
+	struct kvm_s390_config *cfg;
 };
 
 #define KVM_HVA_ERR_BAD		(-1UL)
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index c003c6a..d53dd45 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -79,6 +79,17 @@ struct kvm_debug_exit_arch {
 struct kvm_guest_debug_arch {
 };
 
+
+
+/* config device specific GROUPS */
+
+#define KVM_DEV_CONFIG_GROUP		0
+#define KVM_DEV_CONFIG_NAME		0
+
+struct kvm_s390_attr_name {
+	char name[128];
+};
+
 #define KVM_SYNC_PREFIX (1UL << 0)
 #define KVM_SYNC_GPRS   (1UL << 1)
 #define KVM_SYNC_ACRS   (1UL << 2)
diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
index d3adb37..79f130b 100644
--- a/arch/s390/kvm/Makefile
+++ b/arch/s390/kvm/Makefile
@@ -11,5 +11,5 @@ common-objs = $(KVM)/kvm_main.o $(KVM)/eventfd.o  $(KVM)/async_pf.o $(KVM)/irqch
 
 ccflags-y := -Ivirt/kvm -Iarch/s390/kvm
 
-kvm-objs := $(common-objs) kvm-s390.o intercept.o interrupt.o priv.o sigp.o diag.o
+kvm-objs := $(common-objs) kvm-s390.o intercept.o interrupt.o priv.o sigp.o diag.o config.o
 obj-$(CONFIG_KVM) += kvm.o
diff --git a/arch/s390/kvm/config.c b/arch/s390/kvm/config.c
new file mode 100644
index 0000000..f887116
--- /dev/null
+++ b/arch/s390/kvm/config.c
@@ -0,0 +1,133 @@
+/*
+ * handling CONFIG kvm device
+ *
+ * Copyright IBM Corp. 2014
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License (version 2 only)
+ * as published by the Free Software Foundation.
+ *
+ *    Author(s): Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>
+ *               Christian Borntraeger <borntraeger@de.ibm.com>
+ */
+#include <linux/kvm.h>
+#include <linux/kvm_host.h>
+#include <asm/uaccess.h>
+#include "kvm-s390.h"
+
+static const struct kvm_s390_config config_defaults = {
+	.name = { "KVMguest" },
+};
+
+/*
+ * This is called from architecture code, since we access config even if
+ * userspace does not create a config device.
+ */
+struct kvm_s390_config *kvm_s390_config_init(void)
+{
+	struct kvm_s390_config *config;
+
+	config = kmalloc(sizeof(struct kvm_s390_config), GFP_KERNEL);
+	if (config) {
+		memcpy(config, &config_defaults, sizeof(*config));
+		mutex_init(&config->lock);
+	}
+
+	return config;
+}
+
+void kvm_s390_config_free(struct kvm_s390_config *config)
+{
+	kfree(config);
+}
+
+/*
+ * kvm accesses the config datastructure even if userspace did not create a
+ * config kvm device. So we only do kvm device related cleanups in the
+ * create and destroy callbacks.
+ */
+static int config_create(struct kvm_device *dev, u32 attr)
+{
+	return 0;
+}
+
+static void config_destroy(struct kvm_device *dev)
+{
+	kfree(dev);
+}
+
+static int config_set(struct kvm_device *dev, struct kvm_device_attr *attr)
+{
+	struct kvm_s390_config *config = dev->kvm->arch.cfg;
+	int ret;
+
+	switch (attr->attr) {
+	case KVM_DEV_CONFIG_NAME:
+		mutex_lock(&config->lock);
+		ret = copy_from_user(&config->name, (void __user *) attr->addr,
+				     sizeof(config->name));
+		mutex_unlock(&config->lock);
+		return ret;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int config_get(struct kvm_device *dev, struct kvm_device_attr *attr)
+{
+	struct kvm_s390_config *config = dev->kvm->arch.cfg;
+	int ret;
+
+	switch (attr->attr) {
+	case KVM_DEV_CONFIG_NAME:
+		mutex_lock(&config->lock);
+		ret = copy_to_user((void __user *) attr->addr, &config->name,
+				   sizeof(config->name));
+		mutex_unlock(&config->lock);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int config_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
+{
+	switch (attr->group) {
+	case KVM_DEV_CONFIG_GROUP:
+		return config_set(dev, attr);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int config_get_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
+{
+	switch (attr->group) {
+	case KVM_DEV_CONFIG_GROUP:
+		return config_get(dev, attr);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int config_has_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
+{
+	switch (attr->group) {
+	case KVM_DEV_CONFIG_GROUP:
+		switch (attr->attr) {
+		case KVM_DEV_CONFIG_NAME:
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+
+struct kvm_device_ops kvm_s390_config_ops = {
+	.name = "kvm_s390_config",
+	.create = config_create,
+	.destroy = config_destroy,
+	.get_attr = config_get_attr,
+	.set_attr = config_set_attr,
+	.has_attr = config_has_attr,
+};
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index b3ecb8f..4504015 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -307,8 +307,14 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	kvm->arch.css_support = 0;
 	kvm->arch.use_irqchip = 0;
+	kvm->arch.cfg = kvm_s390_config_init();
+	if (!kvm->arch.cfg)
+		goto out_gmap;
 
 	return 0;
+out_gmap:
+	if (!kvm_is_ucontrol(kvm))
+		gmap_free(kvm->arch.gmap);
 out_nogmap:
 	debug_unregister(kvm->arch.dbf);
 out_nodbf:
@@ -371,6 +377,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	if (!kvm_is_ucontrol(kvm))
 		gmap_free(kvm->arch.gmap);
 	kvm_s390_destroy_adapters(kvm);
+	kvm_s390_config_free(kvm->arch.cfg);
 }
 
 /* Section: vcpu related */
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 3c1e227..50185a3 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -168,4 +168,8 @@ int kvm_cpu_has_interrupt(struct kvm_vcpu *vcpu);
 int psw_extint_disabled(struct kvm_vcpu *vcpu);
 void kvm_s390_destroy_adapters(struct kvm *kvm);
 
+/* implemented in config.c */
+struct kvm_s390_config *kvm_s390_config_init(void);
+void kvm_s390_config_free(struct kvm_s390_config *config);
+
 #endif
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 476e9e2..4e5fba5 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/kvm.h>
+#include <linux/kvm_host.h>
 #include <linux/gfp.h>
 #include <linux/errno.h>
 #include <linux/compat.h>
@@ -414,7 +415,10 @@ static void handle_stsi_3_2_2(struct kvm_vcpu *vcpu, struct sysinfo_3_2_2 *mem)
 	mem->vm[0].cpus_standby = 0;
 	mem->vm[0].cpus_reserved = 0;
 	mem->vm[0].caf = 1000;
-	memcpy(mem->vm[0].name, "KVMguest", 8);
+
+	mutex_lock(&vcpu->kvm->arch.cfg->lock);
+	memcpy(mem->vm[0].name, &vcpu->kvm->arch.cfg->name, 8);
+	mutex_unlock(&vcpu->kvm->arch.cfg->lock);
 	ASCEBC(mem->vm[0].name, 8);
 	memcpy(mem->vm[0].cpi, "KVM/Linux       ", 16);
 	ASCEBC(mem->vm[0].cpi, 16);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 7d21cf9..5c5c39c 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1080,6 +1080,7 @@ extern struct kvm_device_ops kvm_xics_ops;
 extern struct kvm_device_ops kvm_vfio_ops;
 extern struct kvm_device_ops kvm_arm_vgic_v2_ops;
 extern struct kvm_device_ops kvm_flic_ops;
+extern struct kvm_device_ops kvm_s390_config_ops;
 
 #ifdef CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index a8f4ee5..d0e738f 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -934,6 +934,7 @@ struct kvm_device_attr {
 #define   KVM_DEV_VFIO_GROUP_DEL			2
 #define KVM_DEV_TYPE_ARM_VGIC_V2	5
 #define KVM_DEV_TYPE_FLIC		6
+#define KVM_DEV_TYPE_S390_CONFIG	7
 
 /*
  * ioctls for VM fds
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 5fd4cf8..a9f909a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2285,6 +2285,9 @@ static int kvm_ioctl_create_device(struct kvm *kvm,
 	case KVM_DEV_TYPE_FLIC:
 		ops = &kvm_flic_ops;
 		break;
+	case KVM_DEV_TYPE_S390_CONFIG:
+		ops = &kvm_s390_config_ops;
+		break;
 #endif
 	default:
 		return -ENODEV;
-- 
1.8.4.2
