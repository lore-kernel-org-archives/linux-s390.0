From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v3 05/14] s390: vfio-ap: base implementation of VFIO AP device driver
Date: Wed, 14 Mar 2018 14:25:45 -0400
Message-ID: <1521051954-25715-6-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Introduces a new AP device driver. This device driver
is built on the VFIO mediated device framework. The framework
provides sysfs interfaces that facilitate passthrough
access by guests to devices installed on the linux host.

The VFIO AP device driver will serve two purposes:

1. Provide the interfaces to reserve AP devices for exclusive
   use by KVM guests. This is accomplished by unbinding the
   devices to be reserved for guest usage from the default AP
   device driver and binding them to the VFIO AP device driver.

2. Implements the functions, callbacks and sysfs attribute
   interfaces required to create one or more VFIO mediated
   devices each of which will be used to configure the AP
   matrix for a guest and serve as a file descriptor
   for facilitating communication between QEMU and the
   VFIO AP device driver.

When the VFIO AP device driver is initialized:

* It registers with the AP bus for control of type 10 (CEX4
  and newer) AP queue devices. The probe and remove callbacks
  will be provided to support the binding/unbinding of
  AP queue devices to/from the VFIO AP device driver.

* Creates a /sys/devices/vfio-ap/matrix device to hold
  the APQNs of the AP devices bound to the VFIO
  AP device driver and serves as the parent of the
  mediated devices created for each guest.

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 MAINTAINERS                           |    2 +
 arch/s390/Kconfig                     |   11 +++
 drivers/s390/crypto/Makefile          |    4 +
 drivers/s390/crypto/vfio_ap_drv.c     |  135 +++++++++++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_private.h |   22 ++++++
 include/uapi/linux/vfio.h             |    2 +
 6 files changed, 176 insertions(+), 0 deletions(-)
 create mode 100644 drivers/s390/crypto/vfio_ap_drv.c
 create mode 100644 drivers/s390/crypto/vfio_ap_private.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 72742d5..f129253 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11884,6 +11884,8 @@ W:	http://www.ibm.com/developerworks/linux/linux390/
 S:	Supported
 F:	arch/s390/include/asm/kvm/kvm-ap.h
 F:	arch/s390/kvm/kvm-ap.c
+F:	drivers/s390/crypto/vfio_ap_drv.c
+F:	drivers/s390/crypto/vfio_ap_private.h
 
 S390 ZFCP DRIVER
 M:	Steffen Maier <maier@linux.vnet.ibm.com>
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index cbe1d97..58509db 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -771,6 +771,17 @@ config VFIO_CCW
 	  To compile this driver as a module, choose M here: the
 	  module will be called vfio_ccw.
 
+config VFIO_AP
+	def_tristate m
+	prompt "VFIO support for AP devices"
+	depends on ZCRYPT && VFIO_MDEV_DEVICE
+	help
+		This driver grants access to Adjunct Processor (AP) devices
+		via the VFIO mediated device interface.
+
+		To compile this driver as a module, choose M here: the module
+		will be called vfio_ap.
+
 endmenu
 
 menu "Dump support"
diff --git a/drivers/s390/crypto/Makefile b/drivers/s390/crypto/Makefile
index b59af54..48e466e 100644
--- a/drivers/s390/crypto/Makefile
+++ b/drivers/s390/crypto/Makefile
@@ -15,3 +15,7 @@ obj-$(CONFIG_ZCRYPT) += zcrypt_pcixcc.o zcrypt_cex2a.o zcrypt_cex4.o
 # pkey kernel module
 pkey-objs := pkey_api.o
 obj-$(CONFIG_PKEY) += pkey.o
+
+# adjunct processor matrix
+vfio_ap-objs := vfio_ap_drv.o
+obj-$(CONFIG_VFIO_AP) += vfio_ap.o
diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
new file mode 100644
index 0000000..459e595
--- /dev/null
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -0,0 +1,135 @@
+/*
+ * VFIO based AP device driver
+ *
+ * Copyright IBM Corp. 2017
+ *
+ * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
+ */
+
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/slab.h>
+
+#include "vfio_ap_private.h"
+
+#define VFIO_AP_ROOT_NAME "vfio_ap"
+#define VFIO_AP_DEV_TYPE_NAME "ap_matrix"
+#define VFIO_AP_DEV_NAME "matrix"
+
+MODULE_AUTHOR("IBM Corporation");
+MODULE_DESCRIPTION("VFIO AP device driver, Copyright IBM Corp. 2017");
+MODULE_LICENSE("GPL v2");
+
+static struct device *vfio_ap_root_device;
+
+static struct ap_driver vfio_ap_drv;
+
+static struct ap_matrix *ap_matrix;
+
+static struct device_type vfio_ap_dev_type = {
+	.name = VFIO_AP_DEV_TYPE_NAME,
+};
+
+/* Only type 10 adapters (CEX4 and later) are supported
+ * by the AP matrix device driver
+ */
+static struct ap_device_id ap_queue_ids[] = {
+	{ .dev_type = AP_DEVICE_TYPE_CEX4,
+	  .match_flags = AP_DEVICE_ID_MATCH_QUEUE_TYPE },
+	{ .dev_type = AP_DEVICE_TYPE_CEX5,
+	  .match_flags = AP_DEVICE_ID_MATCH_QUEUE_TYPE },
+	{ .dev_type = AP_DEVICE_TYPE_CEX6,
+	  .match_flags = AP_DEVICE_ID_MATCH_QUEUE_TYPE },
+	{ /* end of sibling */ },
+};
+
+MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
+
+static int vfio_ap_queue_dev_probe(struct ap_device *apdev)
+{
+	return 0;
+}
+
+static void vfio_ap_matrix_dev_release(struct device *dev)
+{
+	struct ap_matrix *ap_matrix = dev_get_drvdata(dev);
+
+	kfree(ap_matrix);
+}
+
+static int vfio_ap_matrix_dev_create(void)
+{
+	int ret;
+
+	vfio_ap_root_device = root_device_register(VFIO_AP_ROOT_NAME);
+
+	ret = IS_ERR(vfio_ap_root_device);
+	if (ret) {
+		ret = PTR_ERR(vfio_ap_root_device);
+		goto done;
+	}
+
+	ap_matrix = kzalloc(sizeof(*ap_matrix), GFP_KERNEL);
+	if (!ap_matrix) {
+		ret = -ENOMEM;
+		goto matrix_alloc_err;
+	}
+
+	ap_matrix->device.type = &vfio_ap_dev_type;
+	dev_set_name(&ap_matrix->device, "%s", VFIO_AP_DEV_NAME);
+	ap_matrix->device.parent = vfio_ap_root_device;
+	ap_matrix->device.release = vfio_ap_matrix_dev_release;
+	ap_matrix->device.driver = &vfio_ap_drv.driver;
+
+	ret = device_register(&ap_matrix->device);
+	if (ret)
+		goto matrix_reg_err;
+
+	goto done;
+
+matrix_reg_err:
+	put_device(&ap_matrix->device);
+	kfree(ap_matrix);
+
+matrix_alloc_err:
+	root_device_unregister(vfio_ap_root_device);
+
+done:
+	return ret;
+}
+
+static void vfio_ap_matrix_dev_destroy(struct ap_matrix *ap_matrix)
+{
+	device_unregister(&ap_matrix->device);
+	root_device_unregister(vfio_ap_root_device);
+}
+
+int __init vfio_ap_init(void)
+{
+	int ret;
+
+	ret = vfio_ap_matrix_dev_create();
+	if (ret)
+		return ret;
+
+	memset(&vfio_ap_drv, 0, sizeof(vfio_ap_drv));
+	vfio_ap_drv.probe = vfio_ap_queue_dev_probe;
+	vfio_ap_drv.ids = ap_queue_ids;
+
+	ret = ap_driver_register(&vfio_ap_drv, THIS_MODULE, VFIO_AP_DRV_NAME);
+	if (ret) {
+		vfio_ap_matrix_dev_destroy(ap_matrix);
+		return ret;
+	}
+
+	return 0;
+}
+
+void __exit vfio_ap_exit(void)
+{
+	ap_driver_unregister(&vfio_ap_drv);
+	vfio_ap_matrix_dev_destroy(ap_matrix);
+}
+
+module_init(vfio_ap_init);
+module_exit(vfio_ap_exit);
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
new file mode 100644
index 0000000..21f3697
--- /dev/null
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -0,0 +1,22 @@
+/*
+ * Private data and functions for adjunct processor VFIO matrix driver.
+ *
+ * Copyright IBM Corp. 2017
+ * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
+ */
+
+#ifndef _VFIO_AP_PRIVATE_H_
+#define _VFIO_AP_PRIVATE_H_
+
+#include <linux/types.h>
+
+#include "ap_bus.h"
+
+#define VFIO_AP_MODULE_NAME "vfio_ap"
+#define VFIO_AP_DRV_NAME "vfio_ap"
+
+struct ap_matrix {
+	struct device device;
+};
+
+#endif /* _VFIO_AP_PRIVATE_H_ */
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index e3301db..cf2a5e9 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -200,6 +200,7 @@ struct vfio_device_info {
 #define VFIO_DEVICE_FLAGS_PLATFORM (1 << 2)	/* vfio-platform device */
 #define VFIO_DEVICE_FLAGS_AMBA  (1 << 3)	/* vfio-amba device */
 #define VFIO_DEVICE_FLAGS_CCW	(1 << 4)	/* vfio-ccw device */
+#define VFIO_DEVICE_FLAGS_AP	(1 << 5)	/* vfio-ap device */
 	__u32	num_regions;	/* Max region index + 1 */
 	__u32	num_irqs;	/* Max IRQ index + 1 */
 };
@@ -215,6 +216,7 @@ struct vfio_device_info {
 #define VFIO_DEVICE_API_PLATFORM_STRING		"vfio-platform"
 #define VFIO_DEVICE_API_AMBA_STRING		"vfio-amba"
 #define VFIO_DEVICE_API_CCW_STRING		"vfio-ccw"
+#define VFIO_DEVICE_API_AP_STRING		"vfio-ap"
 
 /**
  * VFIO_DEVICE_GET_REGION_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 8,
-- 
1.7.1
