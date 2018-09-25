From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v11 04/26] s390: vfio-ap: base implementation of VFIO AP device driver
Date: Tue, 25 Sep 2018 19:16:19 -0400
Message-ID: <20180925231641.4954-5-akrowiak@linux.vnet.ibm.com>
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

Introduces a new AP device driver. This device driver
is built on the VFIO mediated device framework. The framework
provides sysfs interfaces that facilitate passthrough
access by guests to devices installed on the linux host.

The VFIO AP device driver will serve two purposes:

1. Provide the interfaces to reserve AP devices for exclusive
   use by KVM guests. This is accomplished by unbinding the
   devices to be reserved for guest usage from the zcrypt
   device driver and binding them to the VFIO AP device driver.

2. Implements the functions, callbacks and sysfs attribute
   interfaces required to create one or more VFIO mediated
   devices each of which will be used to configure the AP
   matrix for a guest and serve as a file descriptor
   for facilitating communication between QEMU and the
   VFIO AP device driver.

When the VFIO AP device driver is initialized:

* It registers with the AP bus for control of type 10 (CEX4
  and newer) AP queue devices. This limitation was imposed
  due to:

  1. A desire to keep the code as simple as possible;

  2. Some older models are no longer supported by the kernel
     and others are getting close to end of service.

  3. A lack of older systems on which to test older devices.

  The probe and remove callbacks will be provided to support
  the binding/unbinding of AP queue devices to/from the VFIO
  AP device driver.

* Creates a matrix device, /sys/devices/vfio_ap/matrix,
  to serve as the parent of the mediated devices created, one
  for each guest, and to hold the APQNs of the AP devices bound to
  the VFIO AP device driver.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Tested-by: Michael Mueller <mimu@linux.ibm.com>
Tested-by: Farhan Ali <alifm@linux.ibm.com>
---
 MAINTAINERS                           |  10 ++
 arch/s390/Kconfig                     |  11 ++
 drivers/iommu/Kconfig                 |   8 ++
 drivers/s390/crypto/Makefile          |   4 +
 drivers/s390/crypto/vfio_ap_drv.c     | 138 ++++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_private.h |  34 +++++++
 6 files changed, 205 insertions(+)
 create mode 100644 drivers/s390/crypto/vfio_ap_drv.c
 create mode 100644 drivers/s390/crypto/vfio_ap_private.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e993064637ca..45cd096c0600 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12668,6 +12668,16 @@ W:	http://www.ibm.com/developerworks/linux/linux390/
 S:	Supported
 F:	drivers/s390/crypto/
 
+S390 VFIO AP DRIVER
+M:	Tony Krowiak <akrowiak@linux.ibm.com>
+M:	Pierre Morel <pmorel@linux.ibm.com>
+M:	Halil Pasic <pasic@linux.ibm.com>
+L:	linux-s390@vger.kernel.org
+W:	http://www.ibm.com/developerworks/linux/linux390/
+S:	Supported
+F:	drivers/s390/crypto/vfio_ap_drv.c
+F:	drivers/s390/crypto/vfio_ap_private.h
+
 S390 ZFCP DRIVER
 M:	Steffen Maier <maier@linux.ibm.com>
 M:	Benjamin Block <bblock@linux.ibm.com>
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 9a9c7a6fe925..8cc8f25d9576 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -773,6 +773,17 @@ config VFIO_CCW
 	  To compile this driver as a module, choose M here: the
 	  module will be called vfio_ccw.
 
+config VFIO_AP
+	def_tristate n
+	prompt "VFIO support for AP devices"
+	depends on S390_AP_IOMMU && VFIO_MDEV_DEVICE && KVM
+	help
+		This driver grants access to Adjunct Processor (AP) devices
+		via the VFIO mediated device interface.
+
+		To compile this driver as a module, choose M here: the module
+		will be called vfio_ap.
+
 endmenu
 
 menu "Dump support"
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index c60395b7470f..83e6d993fca5 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -372,6 +372,14 @@ config S390_CCW_IOMMU
 	  Enables bits of IOMMU API required by VFIO. The iommu_ops
 	  is not implemented as it is not necessary for VFIO.
 
+config S390_AP_IOMMU
+	bool "S390 AP IOMMU Support"
+	depends on S390 && ZCRYPT
+	select IOMMU_API
+	help
+	  Enables bits of IOMMU API required by VFIO. The iommu_ops
+	  is not implemented as it is not necessary for VFIO.
+
 config MTK_IOMMU
 	bool "MTK IOMMU Support"
 	depends on ARM || ARM64
diff --git a/drivers/s390/crypto/Makefile b/drivers/s390/crypto/Makefile
index b59af548ed1c..48e466eb19cf 100644
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
index 000000000000..ea2ae03c896e
--- /dev/null
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * VFIO based AP device driver
+ *
+ * Copyright IBM Corp. 2018
+ *
+ * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
+ */
+
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include "vfio_ap_private.h"
+
+#define VFIO_AP_ROOT_NAME "vfio_ap"
+#define VFIO_AP_DEV_TYPE_NAME "ap_matrix"
+#define VFIO_AP_DEV_NAME "matrix"
+
+MODULE_AUTHOR("IBM Corporation");
+MODULE_DESCRIPTION("VFIO AP device driver, Copyright IBM Corp. 2018");
+MODULE_LICENSE("GPL v2");
+
+static struct ap_driver vfio_ap_drv;
+
+static struct device_type vfio_ap_dev_type = {
+	.name = VFIO_AP_DEV_TYPE_NAME,
+};
+
+struct ap_matrix_dev *matrix_dev;
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
+static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
+{
+	/* Nothing to do yet */
+}
+
+static void vfio_ap_matrix_dev_release(struct device *dev)
+{
+	struct ap_matrix_dev *matrix_dev = dev_get_drvdata(dev);
+
+	kfree(matrix_dev);
+}
+
+static int vfio_ap_matrix_dev_create(void)
+{
+	int ret;
+	struct device *root_device;
+
+	root_device = root_device_register(VFIO_AP_ROOT_NAME);
+	if (IS_ERR(root_device))
+		return PTR_ERR(root_device);
+
+	matrix_dev = kzalloc(sizeof(*matrix_dev), GFP_KERNEL);
+	if (!matrix_dev) {
+		ret = -ENOMEM;
+		goto matrix_alloc_err;
+	}
+
+	matrix_dev->device.type = &vfio_ap_dev_type;
+	dev_set_name(&matrix_dev->device, "%s", VFIO_AP_DEV_NAME);
+	matrix_dev->device.parent = root_device;
+	matrix_dev->device.release = vfio_ap_matrix_dev_release;
+	matrix_dev->device.driver = &vfio_ap_drv.driver;
+
+	ret = device_register(&matrix_dev->device);
+	if (ret)
+		goto matrix_reg_err;
+
+	return 0;
+
+matrix_reg_err:
+	put_device(&matrix_dev->device);
+matrix_alloc_err:
+	root_device_unregister(root_device);
+
+	return ret;
+}
+
+static void vfio_ap_matrix_dev_destroy(void)
+{
+	device_unregister(&matrix_dev->device);
+	root_device_unregister(matrix_dev->device.parent);
+}
+
+int __init vfio_ap_init(void)
+{
+	int ret;
+
+	/* If there are no AP instructions, there is nothing to pass through. */
+	if (!ap_instructions_available())
+		return -ENODEV;
+
+	ret = vfio_ap_matrix_dev_create();
+	if (ret)
+		return ret;
+
+	memset(&vfio_ap_drv, 0, sizeof(vfio_ap_drv));
+	vfio_ap_drv.probe = vfio_ap_queue_dev_probe;
+	vfio_ap_drv.remove = vfio_ap_queue_dev_remove;
+	vfio_ap_drv.ids = ap_queue_ids;
+
+	ret = ap_driver_register(&vfio_ap_drv, THIS_MODULE, VFIO_AP_DRV_NAME);
+	if (ret) {
+		vfio_ap_matrix_dev_destroy();
+		return ret;
+	}
+
+	return 0;
+}
+
+void __exit vfio_ap_exit(void)
+{
+	ap_driver_unregister(&vfio_ap_drv);
+	vfio_ap_matrix_dev_destroy();
+}
+
+module_init(vfio_ap_init);
+module_exit(vfio_ap_exit);
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
new file mode 100644
index 000000000000..6141420c8bb0
--- /dev/null
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Private data and functions for adjunct processor VFIO matrix driver.
+ *
+ * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
+ *
+ * Copyright IBM Corp. 2018
+ */
+
+#ifndef _VFIO_AP_PRIVATE_H_
+#define _VFIO_AP_PRIVATE_H_
+
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/mdev.h>
+#include <linux/delay.h>
+#include <linux/mutex.h>
+
+#include "ap_bus.h"
+
+#define VFIO_AP_MODULE_NAME "vfio_ap"
+#define VFIO_AP_DRV_NAME "vfio_ap"
+
+/**
+ * ap_matrix_dev - the AP matrix device structure
+ * @device:	generic device structure associated with the AP matrix device
+ */
+struct ap_matrix_dev {
+	struct device device;
+};
+
+extern struct ap_matrix_dev *matrix_dev;
+
+#endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.19.0.221.g150f307
