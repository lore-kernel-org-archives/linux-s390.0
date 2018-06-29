From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v6 07/21] s390: vfio-ap: base implementation of VFIO AP device driver
Date: Fri, 29 Jun 2018 17:11:09 -0400
Message-ID: <1530306683-7270-8-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
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
  and newer) AP queue devices. This limitation was imposed
  due to:

  1. A lack of access to older systems needed to test the
     older AP device models;

  2. A desire to keep the code as simple as possible;

  3. Some older models are no longer supported by the kernel
     and others are getting close to end of service.

  The probe and remove callbacks will be provided to support
  the binding/unbinding of AP queue devices to/from the VFIO
  AP device driver.

* Creates a /sys/devices/vfio-ap/matrix device to hold
  the APQNs of the AP devices bound to the VFIO
  AP device driver and serves as the parent of the
  mediated devices created for each guest.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 MAINTAINERS                           |   10 +++
 arch/s390/Kconfig                     |   11 +++
 drivers/s390/crypto/Makefile          |    4 +
 drivers/s390/crypto/vfio_ap_drv.c     |  140 +++++++++++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_private.h |   29 +++++++
 include/uapi/linux/vfio.h             |    2 +
 samples/bpf/bpf_load.c                |   62 +++++++++++++++
 7 files changed, 258 insertions(+), 0 deletions(-)
 create mode 100644 drivers/s390/crypto/vfio_ap_drv.c
 create mode 100644 drivers/s390/crypto/vfio_ap_private.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e19ec6d..0515dae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12401,6 +12401,16 @@ W:	http://www.ibm.com/developerworks/linux/linux390/
 S:	Supported
 F:	drivers/s390/crypto/
 
+S390 VFIO AP DRIVER
+M:	Tony Krowiak <akrowiak@linux.vnet.ibm.com>
+M:	Christian Borntraeger <borntraeger@de.ibm.com>
+M:	Martin Schwidefsky <schwidefsky@de.ibm.com>
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
index baed397..1a534c6 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -778,6 +778,17 @@ config VFIO_CCW
 	  To compile this driver as a module, choose M here: the
 	  module will be called vfio_ccw.
 
+config VFIO_AP
+	def_tristate n
+	prompt "VFIO support for AP devices"
+	depends on ZCRYPT && VFIO_MDEV_DEVICE && KVM
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
index 0000000..93db312
--- /dev/null
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -0,0 +1,140 @@
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
+MODULE_DESCRIPTION("VFIO AP device driver, Copyright IBM Corp. 2017");
+MODULE_LICENSE("GPL v2");
+
+static struct device *vfio_ap_root_device;
+
+static struct ap_driver vfio_ap_drv;
+
+static struct ap_matrix_dev *matrix_dev;
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
+
+	vfio_ap_root_device = root_device_register(VFIO_AP_ROOT_NAME);
+
+	if (IS_ERR(vfio_ap_root_device)) {
+		ret = PTR_ERR(vfio_ap_root_device);
+		goto done;
+	}
+
+	matrix_dev = kzalloc(sizeof(*matrix_dev), GFP_KERNEL);
+	if (!matrix_dev) {
+		ret = -ENOMEM;
+		goto matrix_alloc_err;
+	}
+
+	matrix_dev->device.type = &vfio_ap_dev_type;
+	dev_set_name(&matrix_dev->device, "%s", VFIO_AP_DEV_NAME);
+	matrix_dev->device.parent = vfio_ap_root_device;
+	matrix_dev->device.release = vfio_ap_matrix_dev_release;
+	matrix_dev->device.driver = &vfio_ap_drv.driver;
+
+	ret = device_register(&matrix_dev->device);
+	if (ret)
+		goto matrix_reg_err;
+
+	goto done;
+
+matrix_reg_err:
+	put_device(&matrix_dev->device);
+
+matrix_alloc_err:
+	root_device_unregister(vfio_ap_root_device);
+
+done:
+	return ret;
+}
+
+static void vfio_ap_matrix_dev_destroy(struct ap_matrix_dev *matrix_dev)
+{
+	device_unregister(&matrix_dev->device);
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
+	vfio_ap_drv.remove = vfio_ap_queue_dev_remove;
+	vfio_ap_drv.ids = ap_queue_ids;
+
+	ret = ap_driver_register(&vfio_ap_drv, THIS_MODULE, VFIO_AP_DRV_NAME);
+	if (ret) {
+		vfio_ap_matrix_dev_destroy(matrix_dev);
+		return ret;
+	}
+
+	return 0;
+}
+
+void __exit vfio_ap_exit(void)
+{
+	ap_driver_unregister(&vfio_ap_drv);
+	vfio_ap_matrix_dev_destroy(matrix_dev);
+}
+
+module_init(vfio_ap_init);
+module_exit(vfio_ap_exit);
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
new file mode 100644
index 0000000..19c0b60
--- /dev/null
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Private data and functions for adjunct processor VFIO matrix driver.
+ *
+ * Copyright IBM Corp. 2018
+ * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
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
+struct ap_matrix_dev {
+	struct device device;
+};
+
+static inline struct ap_matrix_dev
+*to_ap_matrix_parent_dev(struct device *dev)
+{
+	return container_of(dev, struct ap_matrix_dev, device.parent);
+}
+
+#endif /* _VFIO_AP_PRIVATE_H_ */
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 1aa7b82..f378b98 100644
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
diff --git a/samples/bpf/bpf_load.c b/samples/bpf/bpf_load.c
index 89161c9..2a3fd39 100644
--- a/samples/bpf/bpf_load.c
+++ b/samples/bpf/bpf_load.c
@@ -243,6 +243,68 @@ static int load_and_attach(const char *event, struct bpf_insn *prog, int size)
 	return 0;
 }
 
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
 static int load_maps(struct bpf_map_data *maps, int nr_maps,
 		     fixup_map_cb fixup_map)
 {
-- 
1.7.1
