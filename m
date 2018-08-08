From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v8 09/22] s390: vfio-ap: register matrix device with VFIO mdev framework
Date: Wed,  8 Aug 2018 10:44:19 -0400
Message-ID: <1533739472-7172-10-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Tony Krowiak <akrowiak@linux.ibm.com>

Registers the matrix device created by the VFIO AP device
driver with the VFIO mediated device framework.
Registering the matrix device will create the sysfs
structures needed to create mediated matrix devices
each of which will be used to configure the AP matrix
for a guest and connect it to the VFIO AP device driver.

Registering the matrix device with the VFIO mediated device
framework will create the following sysfs structures:

/sys/devices/virtual/misc/vfio_ap/
...... [mdev_supported_types]
......... [vfio_ap-passthrough]
............ create

To create a mediated device for the AP matrix device, write a UUID
to the create file:

	uuidgen > create

A symbolic link to the mediated device's directory will be created in the
devices subdirectory named after the generated $uuid:

/sys/devices/virtual/misc/vfio_ap/
...... [mdev_supported_types]
......... [vfio_ap-passthrough]
............ [devices]
............... [$uuid]

A symbolic link to the mediated device will also be created
in the vfio_ap matrix's directory:

/sys/devices/virtual/misc/vfio_ap/[$uuid]

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Tested-by: Michael Mueller <mimu@linux.ibm.com>
Tested-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 MAINTAINERS                           |    1 +
 drivers/s390/crypto/Makefile          |    2 +-
 drivers/s390/crypto/vfio_ap_drv.c     |   22 ++++++
 drivers/s390/crypto/vfio_ap_ops.c     |  125 +++++++++++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_private.h |   49 +++++++++++++
 include/uapi/linux/vfio.h             |    1 +
 6 files changed, 199 insertions(+), 1 deletions(-)
 create mode 100644 drivers/s390/crypto/vfio_ap_ops.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e0792a..3597910 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12427,6 +12427,7 @@ W:	http://www.ibm.com/developerworks/linux/linux390/
 S:	Supported
 F:	drivers/s390/crypto/vfio_ap_drv.c
 F:	drivers/s390/crypto/vfio_ap_private.h
+F:	drivers/s390/crypto/vfio_ap_ops.c
 
 S390 ZFCP DRIVER
 M:	Steffen Maier <maier@linux.ibm.com>
diff --git a/drivers/s390/crypto/Makefile b/drivers/s390/crypto/Makefile
index 48e466e..8d36b05 100644
--- a/drivers/s390/crypto/Makefile
+++ b/drivers/s390/crypto/Makefile
@@ -17,5 +17,5 @@ pkey-objs := pkey_api.o
 obj-$(CONFIG_PKEY) += pkey.o
 
 # adjunct processor matrix
-vfio_ap-objs := vfio_ap_drv.o
+vfio_ap-objs := vfio_ap_drv.o vfio_ap_ops.o
 obj-$(CONFIG_VFIO_AP) += vfio_ap.o
diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index d7e39ad..6a827f3 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -12,6 +12,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <asm/zcrypt.h>
 #include "vfio_ap_private.h"
 
 #define VFIO_AP_ROOT_NAME "vfio_ap"
@@ -68,6 +69,18 @@ static int vfio_ap_matrix_dev_create(void)
 {
 	int ret;
 
+	mutex_init(&matrix_dev.lock);
+	INIT_LIST_HEAD(&matrix_dev.mdev_list);
+
+	/* Test if PQAP(QCI) instruction is available */
+	if (test_facility(12)) {
+		ret = ap_qci(&matrix_dev.info);
+		if (ret)
+			return ret;
+	}
+
+	atomic_set(&matrix_dev.available_instances, MAX_ZDEV_ENTRIES_EXT);
+
 	ret = misc_register(&matrix_dev.misc_dev);
 	if (ret)
 		return ret;
@@ -102,11 +115,20 @@ int __init vfio_ap_init(void)
 		return ret;
 	}
 
+	ret = vfio_ap_mdev_register();
+	if (ret) {
+		ap_driver_unregister(&vfio_ap_drv);
+		vfio_ap_matrix_dev_destroy();
+
+		return ret;
+	}
+
 	return 0;
 }
 
 void __exit vfio_ap_exit(void)
 {
+	vfio_ap_mdev_unregister();
 	ap_driver_unregister(&vfio_ap_drv);
 	vfio_ap_matrix_dev_destroy();
 }
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
new file mode 100644
index 0000000..2d2b6fe
--- /dev/null
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Adjunct processor matrix VFIO device driver callbacks.
+ *
+ * Copyright IBM Corp. 2018
+ *
+ * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
+ *	      Halil Pasic <pasic@linux.ibm.com>
+ *	      Pierre Morel <pmorel@linux.ibm.com>
+ */
+#include <linux/string.h>
+#include <linux/vfio.h>
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/ctype.h>
+
+#include "vfio_ap_private.h"
+
+#define VFIO_AP_MDEV_TYPE_HWVIRT "passthrough"
+#define VFIO_AP_MDEV_NAME_HWVIRT "VFIO AP Passthrough Device"
+
+static void vfio_ap_matrix_init(struct ap_config_info *info,
+				struct ap_matrix *matrix)
+{
+	matrix->apm_max = info->apxa ? info->Na : 63;
+	matrix->aqm_max = info->apxa ? info->Nd : 15;
+	matrix->adm_max = info->apxa ? info->Nd : 15;
+}
+
+static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
+{
+	struct ap_matrix_mdev *matrix_mdev;
+
+	matrix_mdev = kzalloc(sizeof(*matrix_mdev), GFP_KERNEL);
+	if (!matrix_mdev)
+		return -ENOMEM;
+
+	matrix_mdev->name = dev_name(mdev_dev(mdev));
+	vfio_ap_matrix_init(&matrix_dev.info, &matrix_mdev->matrix);
+	mdev_set_drvdata(mdev, matrix_mdev);
+
+	if (atomic_dec_if_positive(&matrix_dev.available_instances) < 0) {
+		kfree(matrix_mdev);
+		return -EPERM;
+	}
+
+	mutex_lock(&matrix_dev.lock);
+	list_add(&matrix_mdev->list, &matrix_dev.mdev_list);
+	mutex_unlock(&matrix_dev.lock);
+
+	return 0;
+}
+
+static int vfio_ap_mdev_remove(struct mdev_device *mdev)
+{
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+
+	mutex_lock(&matrix_dev.lock);
+	list_del(&matrix_mdev->list);
+	mutex_unlock(&matrix_dev.lock);
+	kfree(matrix_mdev);
+	mdev_set_drvdata(mdev, NULL);
+	atomic_inc(&matrix_dev.available_instances);
+
+	return 0;
+}
+
+static ssize_t name_show(struct kobject *kobj, struct device *dev, char *buf)
+{
+	return sprintf(buf, "%s\n", VFIO_AP_MDEV_NAME_HWVIRT);
+}
+
+MDEV_TYPE_ATTR_RO(name);
+
+static ssize_t available_instances_show(struct kobject *kobj,
+					struct device *dev, char *buf)
+{
+	return sprintf(buf, "%d\n",
+		       atomic_read(&matrix_dev.available_instances));
+}
+
+MDEV_TYPE_ATTR_RO(available_instances);
+
+static ssize_t device_api_show(struct kobject *kobj, struct device *dev,
+			       char *buf)
+{
+	return sprintf(buf, "%s\n", VFIO_DEVICE_API_AP_STRING);
+}
+
+MDEV_TYPE_ATTR_RO(device_api);
+
+static struct attribute *vfio_ap_mdev_type_attrs[] = {
+	&mdev_type_attr_name.attr,
+	&mdev_type_attr_device_api.attr,
+	&mdev_type_attr_available_instances.attr,
+	NULL,
+};
+
+static struct attribute_group vfio_ap_mdev_hwvirt_type_group = {
+	.name = VFIO_AP_MDEV_TYPE_HWVIRT,
+	.attrs = vfio_ap_mdev_type_attrs,
+};
+
+static struct attribute_group *vfio_ap_mdev_type_groups[] = {
+	&vfio_ap_mdev_hwvirt_type_group,
+	NULL,
+};
+
+static const struct mdev_parent_ops vfio_ap_matrix_ops = {
+	.owner			= THIS_MODULE,
+	.supported_type_groups	= vfio_ap_mdev_type_groups,
+	.create			= vfio_ap_mdev_create,
+	.remove			= vfio_ap_mdev_remove,
+};
+
+int vfio_ap_mdev_register(void)
+{
+	return mdev_register_device(to_device(&matrix_dev),
+				    &vfio_ap_matrix_ops);
+}
+
+void vfio_ap_mdev_unregister(void)
+{
+	mdev_unregister_device(to_device(&matrix_dev));
+}
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 02c878c..1724258 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -3,6 +3,9 @@
  * Private data and functions for adjunct processor VFIO matrix driver.
  *
  * Copyright IBM Corp. 2018
+ *
+ * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
+ *	      Halil Pasic <pasic@linux.ibm.com>
  */
 
 #ifndef _VFIO_AP_PRIVATE_H_
@@ -10,6 +13,10 @@
 
 #include <linux/types.h>
 #include <linux/miscdevice.h>
+#include <linux/device.h>
+#include <linux/mdev.h>
+#include <linux/delay.h>
+#include <linux/mutex.h>
 
 #include "ap_bus.h"
 
@@ -18,13 +25,55 @@
 
 struct ap_matrix_dev {
 	struct miscdevice misc_dev;
+	atomic_t available_instances;
+	struct ap_config_info info;
+	struct list_head mdev_list;
+	struct mutex lock;
 };
 
+/**
+ * Locking strategy: take the matrix_dev.lock mutex each time we fiddle
+ * with state managed by the vfio_ap driver (be it using the
+ * mdev_list or be it reading or writing the state of a single
+ * ap_matrix_mdev device). It's quite coarse but we don't expect
+ * much contention.
+ */
 extern struct ap_matrix_dev matrix_dev;
 
+/**
+ * The AP matrix is comprised of three bit masks identifying the adapters,
+ * queues (domains) and control domains that belong to an AP matrix. The bits in
+ * each mask, from least significant to most significant bit, correspond to IDs
+ * 0 to 255. When a bit is set, the corresponding ID belongs to the matrix.
+ *
+ * @apm_max: max adapter number in @apm
+ * @apm identifies the AP adapters in the matrix
+ * @aqm_max: max domain number in @aqm
+ * @aqm identifies the AP queues (domains) in the matrix
+ * @adm_max: max domain number in @adm
+ * @adm identifies the AP control domains in the matrix
+ */
+struct ap_matrix {
+	unsigned long apm_max;
+	DECLARE_BITMAP(apm, 256);
+	unsigned long aqm_max;
+	DECLARE_BITMAP(aqm, 256);
+	unsigned long adm_max;
+	DECLARE_BITMAP(adm, 256);
+};
+
+struct ap_matrix_mdev {
+	const char *name;
+	struct list_head list;
+	struct ap_matrix matrix;
+};
+
 static inline struct device *to_device(struct ap_matrix_dev *matrix_dev)
 {
 	return matrix_dev->misc_dev.this_device;
 }
 
+extern int vfio_ap_mdev_register(void);
+extern void vfio_ap_mdev_unregister(void);
+
 #endif /* _VFIO_AP_PRIVATE_H_ */
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 1aa7b82..bfbe2be 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -215,6 +215,7 @@ struct vfio_device_info {
 #define VFIO_DEVICE_API_PLATFORM_STRING		"vfio-platform"
 #define VFIO_DEVICE_API_AMBA_STRING		"vfio-amba"
 #define VFIO_DEVICE_API_CCW_STRING		"vfio-ccw"
+#define VFIO_DEVICE_API_AP_STRING		"vfio-ap"
 
 /**
  * VFIO_DEVICE_GET_REGION_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 8,
-- 
1.7.1
