From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [RFC 06/19] s390/zcrypt: register matrix device with VFIO mediated device framework
Date: Fri, 13 Oct 2017 13:38:51 -0400
Message-ID: <1507916344-3896-7-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Registers the matrix device created by the AP matrix bus with
the VFIO mediated device framework. Registering the matrix
device will create the sysfs structures needed to create
mediated matrix devices that can be configured with a matrix
of adapters, usage domains and control domains for a guest
machine.

Registering the matrix device with the VFIO mediated device
framework will create the following sysfs structures:

/sys/devices/ap_matrix
... [matrix]
...... [mdev_supported_types]
......... [ap_matrix-passthrough]
............ available_instances
............ create
............ device_api
............ [devices]
............ name

To create a mediated device for the AP matrix device, write a UUID
to the create file:

    uuidgen > create

A symbolic link to the mediated device's directory will be created in the
devices subdirectory named after the generated $uuid:

/sys/devices/ap_matrix
... [matrix]
...... [mdev_supported_types]
......... [ap_matrix-passthrough]
............ [devices]
............... [$uuid]

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 MAINTAINERS                                  |    1 +
 drivers/s390/crypto/Makefile                 |    2 +-
 drivers/s390/crypto/ap_matrix_bus.c          |    1 +
 drivers/s390/crypto/ap_matrix_bus.h          |    4 +
 drivers/s390/crypto/vfio_ap_matrix_drv.c     |    5 +
 drivers/s390/crypto/vfio_ap_matrix_ops.c     |  172 ++++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_matrix_private.h |    3 +
 include/uapi/linux/vfio.h                    |    1 +
 8 files changed, 188 insertions(+), 1 deletions(-)
 create mode 100644 drivers/s390/crypto/vfio_ap_matrix_ops.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 115965e..0c8855a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11720,6 +11720,7 @@ F:	drivers/s390/crypto/ap_matrix_bus.h
 F:	drivers/s390/crypto/ap_matrix_bus.c
 F:	drivers/s390/crypto/vfio_ap_matrix_drv.c
 F:	drivers/s390/crypto/vfio_ap_matrix_private.h
+F:	drivers/s390/crypto/vfio_ap_matrix_ops.c
 
 S390 ZFCP DRIVER
 M:	Steffen Maier <maier@linux.vnet.ibm.com>
diff --git a/drivers/s390/crypto/Makefile b/drivers/s390/crypto/Makefile
index 1983afa..b2545c8 100644
--- a/drivers/s390/crypto/Makefile
+++ b/drivers/s390/crypto/Makefile
@@ -16,5 +16,5 @@ pkey-objs := pkey_api.o
 obj-$(CONFIG_PKEY) += pkey.o
 
 # adjunct processor matrix
-vfio_ap_matrix-objs := vfio_ap_matrix_drv.o
+vfio_ap_matrix-objs := vfio_ap_matrix_drv.o vfio_ap_matrix_ops.o
 obj-$(CONFIG_VFIO_AP_MATRIX) += vfio_ap_matrix.o
diff --git a/drivers/s390/crypto/ap_matrix_bus.c b/drivers/s390/crypto/ap_matrix_bus.c
index 66bfa54..418c23b 100644
--- a/drivers/s390/crypto/ap_matrix_bus.c
+++ b/drivers/s390/crypto/ap_matrix_bus.c
@@ -61,6 +61,7 @@ static int ap_matrix_dev_create(void)
 	matrix->device.bus = &ap_matrix_bus_type;
 	matrix->device.parent = ap_matrix_root_device;
 	matrix->device.release = ap_matrix_dev_release;
+	INIT_LIST_HEAD(&matrix->queues);
 
 	ret = device_register(&matrix->device);
 	if (ret) {
diff --git a/drivers/s390/crypto/ap_matrix_bus.h b/drivers/s390/crypto/ap_matrix_bus.h
index c2aff23..3eccc36 100644
--- a/drivers/s390/crypto/ap_matrix_bus.h
+++ b/drivers/s390/crypto/ap_matrix_bus.h
@@ -12,8 +12,12 @@
 
 #include <linux/device.h>
 
+#include "ap_bus.h"
+
 struct ap_matrix {
 	struct device device;
+	spinlock_t qlock;
+	struct list_head queues;
 };
 
 struct ap_matrix *ap_matrix_get_device(void);
diff --git a/drivers/s390/crypto/vfio_ap_matrix_drv.c b/drivers/s390/crypto/vfio_ap_matrix_drv.c
index 760ed56..664d2f7 100644
--- a/drivers/s390/crypto/vfio_ap_matrix_drv.c
+++ b/drivers/s390/crypto/vfio_ap_matrix_drv.c
@@ -90,11 +90,16 @@ int __init ap_matrix_init(void)
 	if (ret)
 		return ret;
 
+	ret = ap_matrix_mdev_register(vfio_ap_matrix_drv.ap_matrix);
+	if (ret)
+		ap_driver_unregister(&vfio_ap_matrix_drv.ap_drv);
+
 	return ret;
 }
 
 void __exit ap_matrix_exit(void)
 {
+	ap_matrix_mdev_unregister(vfio_ap_matrix_drv.ap_matrix);
 	ap_driver_unregister(&vfio_ap_matrix_drv.ap_drv);
 }
 
diff --git a/drivers/s390/crypto/vfio_ap_matrix_ops.c b/drivers/s390/crypto/vfio_ap_matrix_ops.c
new file mode 100644
index 0000000..7d01f18
--- /dev/null
+++ b/drivers/s390/crypto/vfio_ap_matrix_ops.c
@@ -0,0 +1,172 @@
+/*
+ * Adjunct processor matrix VFIO device driver callbacks.
+ *
+ * Copyright IBM Corp. 2017
+ * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
+ *
+ */
+#include <asm/ap-config.h>
+#include <linux/string.h>
+#include <linux/vfio.h>
+#include <linux/mdev.h>
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/ctype.h>
+
+#include "vfio_ap_matrix_private.h"
+
+#define AP_MATRIX_MDEV_TYPE_HWVIRT "passthrough"
+#define AP_MATRIX_MDEV_NAME_HWVIRT "AP Matrix Passthrough Device"
+
+#define AP_MATRIX_MAX_AVAILABLE_INSTANCES	255
+
+struct ap_matrix_mdev {
+	struct mdev_device *mdev;
+	struct list_head node;
+};
+
+struct ap_matrix	*matrix;
+struct mutex		mdev_devices_lock;
+struct list_head	mdev_devices;
+int			available_instances;
+
+static struct ap_matrix_mdev *ap_matrix_mdev_find_by_uuid(uuid_le uuid)
+{
+	struct ap_matrix_mdev *matrix_mdev;
+
+	list_for_each_entry(matrix_mdev, &mdev_devices, node) {
+		if (uuid_le_cmp(mdev_uuid(matrix_mdev->mdev), uuid) == 0)
+			return matrix_mdev;
+	}
+
+	return NULL;
+}
+
+static int ap_matrix_mdev_create(struct kobject *kobj,
+				 struct mdev_device *mdev)
+{
+	struct ap_matrix_mdev *matrix_mdev;
+	uuid_le uuid;
+
+	if (available_instances == 0) {
+		pr_err("%s: Only %d mediated devices allowed for %s-%s device",
+		       VFIO_AP_MATRIX_MODULE_NAME,
+		       AP_MATRIX_MAX_AVAILABLE_INSTANCES,
+		       VFIO_AP_MATRIX_MODULE_NAME,
+		       AP_MATRIX_MDEV_TYPE_HWVIRT);
+		return -EPERM;
+	}
+
+	uuid = mdev_uuid(mdev);
+	matrix_mdev = ap_matrix_mdev_find_by_uuid(uuid);
+	if (matrix_mdev) {
+		pr_err("%s: Mediated device %pU already exists",
+		       VFIO_AP_MATRIX_MODULE_NAME, uuid.b);
+		return -EEXIST;
+	}
+
+	matrix_mdev = kzalloc(sizeof(*matrix_mdev), GFP_KERNEL);
+	if (!matrix_mdev)
+		return -ENOMEM;
+
+	mdev_set_drvdata(mdev, matrix_mdev);
+	mutex_lock(&mdev_devices_lock);
+	list_add_tail(&matrix_mdev->node, &mdev_devices);
+	mutex_unlock(&mdev_devices_lock);
+
+	return 0;
+}
+
+static int ap_matrix_mdev_remove(struct mdev_device *mdev)
+{
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	uuid_le uuid = mdev_uuid(mdev);
+
+	matrix_mdev = ap_matrix_mdev_find_by_uuid(uuid);
+
+	if (matrix_mdev) {
+		mutex_lock(&mdev_devices_lock);
+		list_del(&matrix_mdev->node);
+		mutex_unlock(&mdev_devices_lock);
+		mdev_set_drvdata(mdev, NULL);
+		kfree(matrix_mdev);
+		available_instances--;
+	}
+
+	return 0;
+}
+
+static ssize_t name_show(struct kobject *kobj, struct device *dev, char *buf)
+{
+	return sprintf(buf, "%s\n", AP_MATRIX_MDEV_NAME_HWVIRT);
+}
+
+MDEV_TYPE_ATTR_RO(name);
+
+static ssize_t available_instances_show(struct kobject *kobj,
+					struct device *dev, char *buf)
+{
+	return sprintf(buf, "%d\n", available_instances);
+}
+
+MDEV_TYPE_ATTR_RO(available_instances);
+
+static ssize_t device_api_show(struct kobject *kobj, struct device *dev,
+			       char *buf)
+{
+	return sprintf(buf, "%s\n", VFIO_DEVICE_API_AP_MATRIX_STRING);
+}
+
+MDEV_TYPE_ATTR_RO(device_api);
+
+static struct attribute *ap_matrix_mdev_type_attrs[] = {
+	&mdev_type_attr_name.attr,
+	&mdev_type_attr_device_api.attr,
+	&mdev_type_attr_available_instances.attr,
+	NULL,
+};
+
+static struct attribute_group ap_matrix_mdev_hwvirt_type_group = {
+	.name = AP_MATRIX_MDEV_TYPE_HWVIRT,
+	.attrs = ap_matrix_mdev_type_attrs,
+};
+
+static struct attribute_group *ap_matrix_mdev_type_groups[] = {
+	&ap_matrix_mdev_hwvirt_type_group,
+	NULL,
+};
+
+static const struct mdev_parent_ops vfio_ap_matrix_ops = {
+	.owner                  = THIS_MODULE,
+	.supported_type_groups  = ap_matrix_mdev_type_groups,
+	.create                 = ap_matrix_mdev_create,
+	.remove                 = ap_matrix_mdev_remove,
+};
+
+int ap_matrix_mdev_register(struct ap_matrix *ap_matrix)
+{
+	int ret;
+	struct device *dev = &ap_matrix->device;
+
+	ret = mdev_register_device(dev, &vfio_ap_matrix_ops);
+	if (ret)
+		return ret;
+
+	matrix = ap_matrix;
+	mutex_init(&mdev_devices_lock);
+	INIT_LIST_HEAD(&mdev_devices);
+	available_instances = AP_MATRIX_MAX_AVAILABLE_INSTANCES;
+
+	return 0;
+}
+
+void ap_matrix_mdev_unregister(struct ap_matrix *ap_matrix)
+{
+	struct device *dev;
+
+	if (ap_matrix == matrix) {
+		dev = &matrix->device;
+		available_instances--;
+		mdev_unregister_device(dev);
+	}
+}
diff --git a/drivers/s390/crypto/vfio_ap_matrix_private.h b/drivers/s390/crypto/vfio_ap_matrix_private.h
index 11c5e02..5c82bea 100644
--- a/drivers/s390/crypto/vfio_ap_matrix_private.h
+++ b/drivers/s390/crypto/vfio_ap_matrix_private.h
@@ -44,4 +44,7 @@ struct vfio_ap_queue {
 	return NULL;
 }
 
+extern int ap_matrix_mdev_register(struct ap_matrix *ap_matrix);
+extern void ap_matrix_mdev_unregister(struct ap_matrix *ap_matrix);
+
 #endif /* _VFIO_AP_PRIVATE_H_ */
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index ae46105..743456f 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -214,6 +214,7 @@ struct vfio_device_info {
 #define VFIO_DEVICE_API_PLATFORM_STRING		"vfio-platform"
 #define VFIO_DEVICE_API_AMBA_STRING		"vfio-amba"
 #define VFIO_DEVICE_API_CCW_STRING		"vfio-ccw"
+#define VFIO_DEVICE_API_AP_MATRIX_STRING	"vfio-ap-matrix"
 
 /**
  * VFIO_DEVICE_GET_REGION_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 8,
-- 
1.7.1
