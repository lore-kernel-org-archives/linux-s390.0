Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23370 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728320AbgJGS4l (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Oct 2020 14:56:41 -0400
From: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v3 4/5] vfio-pci/zdev: Add zPCI capabilities to VFIO_DEVICE_GET_INFO
Date: Wed,  7 Oct 2020 14:56:23 -0400
Message-Id: <1602096984-13703-5-git-send-email-mjrosato@linux.ibm.com>
In-Reply-To: <1602096984-13703-1-git-send-email-mjrosato@linux.ibm.com>
References: <1602096984-13703-1-git-send-email-mjrosato@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: alex.williamson@redhat.com, cohuck@redhat.com, schnelle@linux.ibm.com
Cc: pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

Define a new configuration entry VFIO_PCI_ZDEV for VFIO/PCI.

When this s390-only feature is configured we add capabilities to the
VFIO_DEVICE_GET_INFO ioctl that describe features of the associated
zPCI device and its underlying hardware.

This patch is based on work previously done by Pierre Morel.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/vfio/pci/Kconfig            |  13 ++++
 drivers/vfio/pci/Makefile           |   1 +
 drivers/vfio/pci/vfio_pci.c         |  37 ++++++++++
 drivers/vfio/pci/vfio_pci_private.h |  12 +++
 drivers/vfio/pci/vfio_pci_zdev.c    | 143 ++++++++++++++++++++++++++++++++++++
 5 files changed, 206 insertions(+)
 create mode 100644 drivers/vfio/pci/vfio_pci_zdev.c

diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
index ac3c1dd..6adf37a 100644
--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -45,3 +45,16 @@ config VFIO_PCI_NVLINK2
 	depends on VFIO_PCI && PPC_POWERNV
 	help
 	  VFIO PCI support for P9 Witherspoon machine with NVIDIA V100 GPUs
+
+config VFIO_PCI_ZDEV
+	bool "VFIO PCI ZPCI device CLP support"
+	depends on VFIO_PCI && S390
+	default y
+	help
+	  Enabling this option exposes VFIO capabilities containing hardware
+	  configuration for zPCI devices. This enables userspace (e.g. QEMU)
+	  to supply proper configuration values instead of hard-coded defaults
+	  for zPCI devices passed through via VFIO on s390.
+
+	  Say Y here.
+
diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
index f027f8a..781e080 100644
--- a/drivers/vfio/pci/Makefile
+++ b/drivers/vfio/pci/Makefile
@@ -3,5 +3,6 @@
 vfio-pci-y := vfio_pci.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
 vfio-pci-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
 vfio-pci-$(CONFIG_VFIO_PCI_NVLINK2) += vfio_pci_nvlink2.o
+vfio-pci-$(CONFIG_VFIO_PCI_ZDEV) += vfio_pci_zdev.o
 
 obj-$(CONFIG_VFIO_PCI) += vfio-pci.o
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 1ab1f5c..208dea5 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -807,15 +807,25 @@ static long vfio_pci_ioctl(void *device_data,
 
 	if (cmd == VFIO_DEVICE_GET_INFO) {
 		struct vfio_device_info info;
+		struct vfio_info_cap caps = { .buf = NULL, .size = 0 };
+		unsigned long capsz;
 
 		minsz = offsetofend(struct vfio_device_info, num_irqs);
 
+		/* For backward compatibility, cannot require this */
+		capsz = offsetofend(struct vfio_iommu_type1_info, cap_offset);
+
 		if (copy_from_user(&info, (void __user *)arg, minsz))
 			return -EFAULT;
 
 		if (info.argsz < minsz)
 			return -EINVAL;
 
+		if (info.argsz >= capsz) {
+			minsz = capsz;
+			info.cap_offset = 0;
+		}
+
 		info.flags = VFIO_DEVICE_FLAGS_PCI;
 
 		if (vdev->reset_works)
@@ -824,6 +834,33 @@ static long vfio_pci_ioctl(void *device_data,
 		info.num_regions = VFIO_PCI_NUM_REGIONS + vdev->num_regions;
 		info.num_irqs = VFIO_PCI_NUM_IRQS;
 
+		if (IS_ENABLED(CONFIG_VFIO_PCI_ZDEV)) {
+			int ret = vfio_pci_info_zdev_add_caps(vdev, &caps);
+
+			if (ret && ret != -ENODEV) {
+				pci_warn(vdev->pdev, "Failed to setup zPCI info capabilities\n");
+				return ret;
+			}
+		}
+
+		if (caps.size) {
+			info.flags |= VFIO_DEVICE_FLAGS_CAPS;
+			if (info.argsz < sizeof(info) + caps.size) {
+				info.argsz = sizeof(info) + caps.size;
+			} else {
+				vfio_info_cap_shift(&caps, sizeof(info));
+				if (copy_to_user((void __user *)arg +
+						  sizeof(info), caps.buf,
+						  caps.size)) {
+					kfree(caps.buf);
+					return -EFAULT;
+				}
+				info.cap_offset = sizeof(info);
+			}
+
+			kfree(caps.buf);
+		}
+
 		return copy_to_user((void __user *)arg, &info, minsz) ?
 			-EFAULT : 0;
 
diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
index 61ca8ab..9d28484 100644
--- a/drivers/vfio/pci/vfio_pci_private.h
+++ b/drivers/vfio/pci/vfio_pci_private.h
@@ -213,4 +213,16 @@ static inline int vfio_pci_ibm_npu2_init(struct vfio_pci_device *vdev)
 	return -ENODEV;
 }
 #endif
+
+#ifdef CONFIG_VFIO_PCI_ZDEV
+extern int vfio_pci_info_zdev_add_caps(struct vfio_pci_device *vdev,
+				       struct vfio_info_cap *caps);
+#else
+static inline int vfio_pci_info_zdev_add_caps(struct vfio_pci_device *vdev,
+					      struct vfio_info_cap *caps);
+{
+	return -ENODEV;
+}
+#endif
+
 #endif /* VFIO_PCI_PRIVATE_H */
diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
new file mode 100644
index 0000000..2296856
--- /dev/null
+++ b/drivers/vfio/pci/vfio_pci_zdev.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * VFIO ZPCI devices support
+ *
+ * Copyright (C) IBM Corp. 2020.  All rights reserved.
+ *	Author(s): Pierre Morel <pmorel@linux.ibm.com>
+ *                 Matthew Rosato <mjrosato@linux.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <linux/io.h>
+#include <linux/pci.h>
+#include <linux/uaccess.h>
+#include <linux/vfio.h>
+#include <linux/vfio_zdev.h>
+#include <asm/pci_clp.h>
+#include <asm/pci_io.h>
+
+#include "vfio_pci_private.h"
+
+/*
+ * Add the Base PCI Function information to the device info region.
+ */
+static int zpci_base_cap(struct zpci_dev *zdev, struct vfio_pci_device *vdev,
+			 struct vfio_info_cap *caps)
+{
+	struct vfio_device_info_cap_zpci_base cap = {
+		.header.id = VFIO_DEVICE_INFO_CAP_ZPCI_BASE,
+		.header.version = 1,
+		.start_dma = zdev->start_dma,
+		.end_dma = zdev->end_dma,
+		.pchid = zdev->pchid,
+		.vfn = zdev->vfn,
+		.fmb_length = zdev->fmb_length,
+		.pft = zdev->pft,
+		.gid = zdev->pfgid
+	};
+
+	return vfio_info_add_capability(caps, &cap.header, sizeof(cap));
+}
+
+/*
+ * Add the Base PCI Function Group information to the device info region.
+ */
+static int zpci_group_cap(struct zpci_dev *zdev, struct vfio_pci_device *vdev,
+			  struct vfio_info_cap *caps)
+{
+	struct vfio_device_info_cap_zpci_group cap = {
+		.header.id = VFIO_DEVICE_INFO_CAP_ZPCI_GROUP,
+		.header.version = 1,
+		.dasm = zdev->dma_mask,
+		.msi_addr = zdev->msi_addr,
+		.flags = VFIO_DEVICE_INFO_ZPCI_FLAG_REFRESH,
+		.mui = zdev->fmb_update,
+		.noi = zdev->max_msi,
+		.maxstbl = ZPCI_MAX_WRITE_SIZE,
+		.version = zdev->version
+	};
+
+	return vfio_info_add_capability(caps, &cap.header, sizeof(cap));
+}
+
+/*
+ * Add the device utility string to the device info region.
+ */
+static int zpci_util_cap(struct zpci_dev *zdev, struct vfio_pci_device *vdev,
+			 struct vfio_info_cap *caps)
+{
+	struct vfio_device_info_cap_zpci_util *cap;
+	int cap_size = sizeof(*cap) + CLP_UTIL_STR_LEN;
+	int ret;
+
+	cap = kmalloc(cap_size, GFP_KERNEL);
+
+	cap->header.id = VFIO_DEVICE_INFO_CAP_ZPCI_UTIL;
+	cap->header.version = 1;
+	cap->size = CLP_UTIL_STR_LEN;
+	memcpy(cap->util_str, zdev->util_str, cap->size);
+
+	ret = vfio_info_add_capability(caps, &cap->header, cap_size);
+
+	kfree(cap);
+
+	return ret;
+}
+
+/*
+ * Add the function path string to the device info region.
+ */
+static int zpci_pfip_cap(struct zpci_dev *zdev, struct vfio_pci_device *vdev,
+			 struct vfio_info_cap *caps)
+{
+	struct vfio_device_info_cap_zpci_pfip *cap;
+	int cap_size = sizeof(*cap) + CLP_PFIP_NR_SEGMENTS;
+	int ret;
+
+	cap = kmalloc(cap_size, GFP_KERNEL);
+
+	cap->header.id = VFIO_DEVICE_INFO_CAP_ZPCI_PFIP;
+	cap->header.version = 1;
+	cap->size = CLP_PFIP_NR_SEGMENTS;
+	memcpy(cap->pfip, zdev->pfip, cap->size);
+
+	ret = vfio_info_add_capability(caps, &cap->header, cap_size);
+
+	kfree(cap);
+
+	return ret;
+}
+
+/*
+ * Add all supported capabilities to the VFIO_DEVICE_GET_INFO capability chain.
+ */
+int vfio_pci_info_zdev_add_caps(struct vfio_pci_device *vdev,
+				struct vfio_info_cap *caps)
+{
+	struct zpci_dev *zdev = to_zpci(vdev->pdev);
+	int ret;
+
+	if (!zdev)
+		return -ENODEV;
+
+	ret = zpci_base_cap(zdev, vdev, caps);
+	if (ret)
+		return ret;
+
+	ret = zpci_group_cap(zdev, vdev, caps);
+	if (ret)
+		return ret;
+
+	if (zdev->util_str_avail) {
+		ret = zpci_util_cap(zdev, vdev, caps);
+		if (ret)
+			return ret;
+	}
+
+	ret = zpci_pfip_cap(zdev, vdev, caps);
+
+	return ret;
+}
-- 
1.8.3.1
