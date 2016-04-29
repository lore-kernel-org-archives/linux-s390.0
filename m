From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [PATCH RFC 3/8] vfio: ccw: basic implementation for vfio_ccw driver
Date: Fri, 29 Apr 2016 14:11:50 +0200
Message-ID: <1461931915-22397-4-git-send-email-bjsdjshi@linux.vnet.ibm.com>
References: <1461931915-22397-1-git-send-email-bjsdjshi@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1461931915-22397-1-git-send-email-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com
List-ID: <linux-s390.vger.kernel.org>

Add a basic vfio_ccw driver, which depends on the VFIO No-IOMMU
support.

Add a new config option:
  Device Drivers
  --> VFIO Non-Privileged userspace driver framework
    --> VFIO No-IOMMU support
      --> VFIO support for ccw devices

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 arch/s390/include/asm/irq.h |   1 +
 arch/s390/kernel/irq.c      |   1 +
 drivers/vfio/Kconfig        |   1 +
 drivers/vfio/Makefile       |   1 +
 drivers/vfio/ccw/Kconfig    |   7 ++
 drivers/vfio/ccw/Makefile   |   2 +
 drivers/vfio/ccw/vfio_ccw.c | 160 ++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 173 insertions(+)
 create mode 100644 drivers/vfio/ccw/Kconfig
 create mode 100644 drivers/vfio/ccw/Makefile
 create mode 100644 drivers/vfio/ccw/vfio_ccw.c

diff --git a/arch/s390/include/asm/irq.h b/arch/s390/include/asm/irq.h
index f97b055..5ec272a 100644
--- a/arch/s390/include/asm/irq.h
+++ b/arch/s390/include/asm/irq.h
@@ -66,6 +66,7 @@ enum interruption_class {
 	IRQIO_VAI,
 	NMI_NMI,
 	CPU_RST,
+	IRQIO_VFC,
 	NR_ARCH_IRQS
 };
 
diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index c373a1d..706002a 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -88,6 +88,7 @@ static const struct irq_class irqclass_sub_desc[] = {
 	{.irq = IRQIO_VAI,  .name = "VAI", .desc = "[I/O] Virtual I/O Devices AI"},
 	{.irq = NMI_NMI,    .name = "NMI", .desc = "[NMI] Machine Check"},
 	{.irq = CPU_RST,    .name = "RST", .desc = "[CPU] CPU Restart"},
+	{.irq = IRQIO_VFC,  .name = "VFC", .desc = "[I/O] VFIO CCW Devices"},
 };
 
 void __init init_IRQ(void)
diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
index da6e2ce..f1d414c 100644
--- a/drivers/vfio/Kconfig
+++ b/drivers/vfio/Kconfig
@@ -46,6 +46,7 @@ menuconfig VFIO_NOIOMMU
 
 	  If you don't know what to do here, say N.
 
+source "drivers/vfio/ccw/Kconfig"
 source "drivers/vfio/pci/Kconfig"
 source "drivers/vfio/platform/Kconfig"
 source "virt/lib/Kconfig"
diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile
index 7b8a31f..2b39593 100644
--- a/drivers/vfio/Makefile
+++ b/drivers/vfio/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_VFIO_IOMMU_SPAPR_TCE) += vfio_iommu_spapr_tce.o
 obj-$(CONFIG_VFIO_SPAPR_EEH) += vfio_spapr_eeh.o
 obj-$(CONFIG_VFIO_PCI) += pci/
 obj-$(CONFIG_VFIO_PLATFORM) += platform/
+obj-$(CONFIG_VFIO_CCW) += ccw/
diff --git a/drivers/vfio/ccw/Kconfig b/drivers/vfio/ccw/Kconfig
new file mode 100644
index 0000000..6281152
--- /dev/null
+++ b/drivers/vfio/ccw/Kconfig
@@ -0,0 +1,7 @@
+config VFIO_CCW
+	tristate "VFIO support for CCW devices"
+	depends on VFIO_NOIOMMU && CCW
+	help
+	  VFIO support for CCW bus driver. Note that this is just
+	  the base driver; you'll also need a userspace program
+	  to provide a device configuration and channel programs.
diff --git a/drivers/vfio/ccw/Makefile b/drivers/vfio/ccw/Makefile
new file mode 100644
index 0000000..ea14ca9
--- /dev/null
+++ b/drivers/vfio/ccw/Makefile
@@ -0,0 +1,2 @@
+vfio-ccw-y := vfio_ccw.o
+obj-$(CONFIG_VFIO_CCW) += vfio-ccw.o
diff --git a/drivers/vfio/ccw/vfio_ccw.c b/drivers/vfio/ccw/vfio_ccw.c
new file mode 100644
index 0000000..8b0acae
--- /dev/null
+++ b/drivers/vfio/ccw/vfio_ccw.c
@@ -0,0 +1,160 @@
+/*
+ * vfio based ccw device driver
+ *
+ * Copyright IBM Corp. 2016
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License (version 2 only)
+ * as published by the Free Software Foundation.
+ *
+ * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
+ *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/iommu.h>
+#include <linux/vfio.h>
+#include <asm/ccwdev.h>
+#include <asm/cio.h>
+
+/**
+ * struct vfio_ccw_device
+ * @cdev: ccw device
+ * @going_away: if an offline procedure was already ongoing
+ */
+struct vfio_ccw_device {
+	struct ccw_device	*cdev;
+	bool			going_away;
+};
+
+enum vfio_ccw_device_type {
+	vfio_dasd_eckd,
+};
+
+struct ccw_device_id vfio_ccw_ids[] = {
+	{ CCW_DEVICE_DEVTYPE(0x3990, 0, 0x3390, 0),
+	  .driver_info = vfio_dasd_eckd},
+	{ /* End of list. */ },
+};
+MODULE_DEVICE_TABLE(ccw, vfio_ccw_ids);
+
+/*
+ * vfio callbacks
+ */
+static int vfio_ccw_open(void *device_data)
+{
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
+	return 0;
+}
+
+static void vfio_ccw_release(void *device_data)
+{
+	module_put(THIS_MODULE);
+}
+
+static long vfio_ccw_ioctl(void *device_data, unsigned int cmd,
+			   unsigned long arg)
+{
+	return -ENOTTY;
+}
+
+static const struct vfio_device_ops vfio_ccw_ops = {
+	.name		= "vfio_ccw",
+	.open		= vfio_ccw_open,
+	.release	= vfio_ccw_release,
+	.ioctl		= vfio_ccw_ioctl,
+};
+
+static int vfio_ccw_probe(struct ccw_device *cdev)
+{
+	struct iommu_group *group = vfio_iommu_group_get(&cdev->dev);
+
+	if (!group)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int vfio_ccw_set_offline(struct ccw_device *cdev)
+{
+	struct vfio_device *device = vfio_device_get_from_dev(&cdev->dev);
+	struct vfio_ccw_device *vdev;
+
+	if (!device)
+		return 0;
+
+	vdev = vfio_device_data(device);
+	vfio_device_put(device);
+	if (!vdev || vdev->going_away)
+		return 0;
+
+	vdev->going_away = true;
+	vfio_del_group_dev(&cdev->dev);
+	kfree(vdev);
+
+	return 0;
+}
+
+void vfio_ccw_remove(struct ccw_device *cdev)
+{
+	if (cdev && cdev->online)
+		vfio_ccw_set_offline(cdev);
+
+	vfio_iommu_group_put(cdev->dev.iommu_group, &cdev->dev);
+}
+
+static int vfio_ccw_set_online(struct ccw_device *cdev)
+{
+	struct vfio_ccw_device *vdev;
+	int ret;
+
+	vdev = kzalloc(sizeof(*vdev), GFP_KERNEL);
+	if (!vdev)
+		return -ENOMEM;
+
+	vdev->cdev = cdev;
+
+	ret = vfio_add_group_dev(&cdev->dev, &vfio_ccw_ops, vdev);
+	if (ret)
+		kfree(vdev);
+
+	return ret;
+}
+
+static int vfio_ccw_notify(struct ccw_device *cdev, int event)
+{
+	/* LATER: We probably need to handle device/path state changes. */
+	return 0;
+}
+
+static struct ccw_driver vfio_ccw_driver = {
+	.driver = {
+		.name	= "vfio_ccw",
+		.owner	= THIS_MODULE,
+	},
+	.ids	     = vfio_ccw_ids,
+	.probe	     = vfio_ccw_probe,
+	.remove      = vfio_ccw_remove,
+	.set_offline = vfio_ccw_set_offline,
+	.set_online  = vfio_ccw_set_online,
+	.notify      = vfio_ccw_notify,
+	.int_class   = IRQIO_VFC,
+};
+
+static int __init vfio_ccw_init(void)
+{
+	return ccw_driver_register(&vfio_ccw_driver);
+}
+
+static void __exit vfio_ccw_cleanup(void)
+{
+	ccw_driver_unregister(&vfio_ccw_driver);
+}
+
+module_init(vfio_ccw_init);
+module_exit(vfio_ccw_cleanup);
+
+MODULE_LICENSE("GPL v2");
-- 
2.6.6
