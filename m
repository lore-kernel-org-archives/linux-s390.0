From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v3 06/14] s390: vfio-ap: register matrix device with VFIO mdev framework
Date: Wed, 14 Mar 2018 14:25:46 -0400
Message-ID: <1521051954-25715-7-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Registers the matrix device created by the VFIO AP device
driver with the VFIO mediated device framework.
Registering the matrix device will create the sysfs
structures needed to create mediated matrix devices
each of which will be used to configure the AP matrix
for a guest and connect it to the VFIO AP device driver.

Registering the matrix device with the VFIO mediated device
framework will create the following sysfs structures:

/sys/devices/vfio_ap
... [matrix]
...... [mdev_supported_types]
......... [vfio_ap-passthrough]
............ create

To create a mediated device for the AP matrix device, write a UUID
to the create file:

	uuidgen > create

A symbolic link to the mediated device's directory will be created in the
devices subdirectory named after the generated $uuid:

/sys/devices/vfio_ap
... [matrix]
...... [mdev_supported_types]
......... [vfio_ap-passthrough]
............ [devices]
............... [$uuid]

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 MAINTAINERS                           |    1 +
 drivers/s390/crypto/Makefile          |    2 +-
 drivers/s390/crypto/vfio_ap_drv.c     |    9 +++
 drivers/s390/crypto/vfio_ap_ops.c     |  105 +++++++++++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_private.h |   18 ++++++
 5 files changed, 134 insertions(+), 1 deletions(-)
 create mode 100644 drivers/s390/crypto/vfio_ap_ops.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f129253..2af3815 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11886,6 +11886,7 @@ F:	arch/s390/include/asm/kvm/kvm-ap.h
 F:	arch/s390/kvm/kvm-ap.c
 F:	drivers/s390/crypto/vfio_ap_drv.c
 F:	drivers/s390/crypto/vfio_ap_private.h
+F:	drivers/s390/crypto/vfio_ap_ops.c
 
 S390 ZFCP DRIVER
 M:	Steffen Maier <maier@linux.vnet.ibm.com>
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
index 459e595..b138cb0 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -122,11 +122,20 @@ int __init vfio_ap_init(void)
 		return ret;
 	}
 
+	ret = vfio_ap_mdev_register(ap_matrix);
+	if (ret) {
+		ap_driver_unregister(&vfio_ap_drv);
+		vfio_ap_matrix_dev_destroy(ap_matrix);
+
+		return ret;
+	}
+
 	return 0;
 }
 
 void __exit vfio_ap_exit(void)
 {
+	vfio_ap_mdev_unregister(ap_matrix);
 	ap_driver_unregister(&vfio_ap_drv);
 	vfio_ap_matrix_dev_destroy(ap_matrix);
 }
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
new file mode 100644
index 0000000..4292a5e
--- /dev/null
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -0,0 +1,105 @@
+/*
+ * Adjunct processor matrix VFIO device driver callbacks.
+ *
+ * Copyright IBM Corp. 2017
+ * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
+ *
+ */
+#include <linux/string.h>
+#include <linux/vfio.h>
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/ctype.h>
+
+#include "vfio_ap_private.h"
+
+#define VFOP_AP_MDEV_TYPE_HWVIRT "passthrough"
+#define VFIO_AP_MDEV_NAME_HWVIRT "VFIO AP Passthrough Device"
+
+static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
+{
+	struct ap_matrix *ap_matrix = to_ap_matrix(mdev_parent_dev(mdev));
+
+	ap_matrix->available_instances--;
+
+	return 0;
+}
+
+static int vfio_ap_mdev_remove(struct mdev_device *mdev)
+{
+	struct ap_matrix *ap_matrix = to_ap_matrix(mdev_parent_dev(mdev));
+
+	ap_matrix->available_instances++;
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
+	struct ap_matrix *ap_matrix;
+
+	ap_matrix = to_ap_matrix(dev);
+
+	return sprintf(buf, "%d\n", ap_matrix->available_instances);
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
+	.name = VFOP_AP_MDEV_TYPE_HWVIRT,
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
+int vfio_ap_mdev_register(struct ap_matrix *ap_matrix)
+{
+	int ret;
+
+	ret = mdev_register_device(&ap_matrix->device, &vfio_ap_matrix_ops);
+	if (ret)
+		return ret;
+
+	ap_matrix->available_instances = AP_MATRIX_MAX_AVAILABLE_INSTANCES;
+
+	return 0;
+}
+
+void vfio_ap_mdev_unregister(struct ap_matrix *ap_matrix)
+{
+	ap_matrix->available_instances--;
+	mdev_unregister_device(&ap_matrix->device);
+}
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 21f3697..f11e5e1 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -9,14 +9,32 @@
 #define _VFIO_AP_PRIVATE_H_
 
 #include <linux/types.h>
+#include <linux/device.h>
+#include <linux/mdev.h>
 
 #include "ap_bus.h"
 
 #define VFIO_AP_MODULE_NAME "vfio_ap"
 #define VFIO_AP_DRV_NAME "vfio_ap"
+#define VFIO_AP_MATRIX_MODULE_NAME "vfio_ap_matrix"
+/**
+ * There must be one mediated matrix device per guest. If every APQN is assigned
+ * to a guest, then the maximum number of guests with a unique APQN assigned
+ * would be 255 adapters x 255 domains = 72351 guests.
+ */
+#define AP_MATRIX_MAX_AVAILABLE_INSTANCES 72351
 
 struct ap_matrix {
 	struct device device;
+	int available_instances;
 };
 
+static inline struct ap_matrix *to_ap_matrix(struct device *dev)
+{
+	return container_of(dev, struct ap_matrix, device);
+}
+
+extern int vfio_ap_mdev_register(struct ap_matrix *ap_matrix);
+extern void vfio_ap_mdev_unregister(struct ap_matrix *ap_matrix);
+
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
1.7.1
