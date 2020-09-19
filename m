Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH 3/4] vfio-pci/zdev: define the vfio_zdev header
Date: Sat, 19 Sep 2020 11:28:37 -0400
Message-Id: <1600529318-8996-4-git-send-email-mjrosato@linux.ibm.com>
In-Reply-To: <1600529318-8996-1-git-send-email-mjrosato@linux.ibm.com>
References: <1600529318-8996-1-git-send-email-mjrosato@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: alex.williamson@redhat.com, cohuck@redhat.com, schnelle@linux.ibm.com
Cc: pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

We define a new device region in vfio.h to be able to get the ZPCI CLP
information by reading this region from userspace.

We create a new file, vfio_zdev.h to define the structure of the new
region defined in vfio.h

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 include/uapi/linux/vfio.h      |   5 ++
 include/uapi/linux/vfio_zdev.h | 116 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)
 create mode 100644 include/uapi/linux/vfio_zdev.h

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 9204705..65eb367 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -326,6 +326,11 @@ struct vfio_region_info_cap_type {
  * to do TLB invalidation on a GPU.
  */
 #define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
+/*
+ * IBM zPCI specific hardware feature information for a devcie.  The contents
+ * of this region are mapped by struct vfio_region_zpci_info.
+ */
+#define VFIO_REGION_SUBTYPE_IBM_ZPCI_CLP	(2)
 
 /* sub-types for VFIO_REGION_TYPE_GFX */
 #define VFIO_REGION_SUBTYPE_GFX_EDID            (1)
diff --git a/include/uapi/linux/vfio_zdev.h b/include/uapi/linux/vfio_zdev.h
new file mode 100644
index 0000000..c9e4891
--- /dev/null
+++ b/include/uapi/linux/vfio_zdev.h
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Region definition for ZPCI devices
+ *
+ * Copyright IBM Corp. 2020
+ *
+ * Author(s): Pierre Morel <pmorel@linux.ibm.com>
+ *            Matthew Rosato <mjrosato@linux.ibm.com>
+ */
+
+#ifndef _VFIO_ZDEV_H_
+#define _VFIO_ZDEV_H_
+
+#include <linux/types.h>
+
+/**
+ * struct vfio_region_zpci_info - ZPCI information
+ *
+ * This region provides zPCI specific hardware feature information for a
+ * device.
+ *
+ * The ZPCI information structure is presented as a chain of CLP features
+ * defined below. argsz provides the size of the entire region, and offset
+ * provides the location of the first CLP feature in the chain.
+ *
+ */
+struct vfio_region_zpci_info {
+	__u32 argsz;		/* Size of entire payload */
+	__u32 offset;		/* Location of first entry */
+} __packed;
+
+/**
+ * struct vfio_region_zpci_info_hdr - ZPCI header information
+ *
+ * This structure is included at the top of each CLP feature to define what
+ * type of CLP feature is presented / the structure version. The next value
+ * defines the offset of the next CLP feature, and is an offset from the very
+ * beginning of the region (vfio_region_zpci_info).
+ *
+ * Each CLP feature must have it's own unique 'id'.
+ */
+struct vfio_region_zpci_info_hdr {
+	__u16 id;		/* Identifies the CLP type */
+	__u16	version;	/* version of the CLP data */
+	__u32 next;		/* Offset of next entry */
+} __packed;
+
+/**
+ * struct vfio_region_zpci_info_qpci - Initial Query PCI information
+ *
+ * This region provides an initial set of data from the Query PCI Function
+ * CLP.
+ */
+#define VFIO_REGION_ZPCI_INFO_QPCI	1
+
+struct vfio_region_zpci_info_qpci {
+	struct vfio_region_zpci_info_hdr hdr;
+	__u64 start_dma;	/* Start of available DMA addresses */
+	__u64 end_dma;		/* End of available DMA addresses */
+	__u16 pchid;		/* Physical Channel ID */
+	__u16 vfn;		/* Virtual function number */
+	__u16 fmb_length;	/* Measurement Block Length (in bytes) */
+	__u8 pft;		/* PCI Function Type */
+	__u8 gid;		/* PCI function group ID */
+} __packed;
+
+
+/**
+ * struct vfio_region_zpci_info_qpcifg - Initial Query PCI Function Group info
+ *
+ * This region provides an initial set of data from the Query PCI Function
+ * Group CLP.
+ */
+#define VFIO_REGION_ZPCI_INFO_QPCIFG	2
+
+struct vfio_region_zpci_info_qpcifg {
+	struct vfio_region_zpci_info_hdr hdr;
+	__u64 dasm;		/* DMA Address space mask */
+	__u64 msi_addr;		/* MSI address */
+	__u64 flags;
+#define VFIO_PCI_ZDEV_FLAGS_REFRESH 1 /* Use program-specified TLB refresh */
+	__u16 mui;		/* Measurement Block Update Interval */
+	__u16 noi;		/* Maximum number of MSIs */
+	__u16 maxstbl;		/* Maximum Store Block Length */
+	__u8 version;		/* Supported PCI Version */
+} __packed;
+
+/**
+ * struct vfio_region_zpci_info_util - Utility String
+ *
+ * This region provides the utility string for the associated device, which is
+ * a device identifier string.
+ */
+#define VFIO_REGION_ZPCI_INFO_UTIL	3
+
+struct vfio_region_zpci_info_util {
+	struct vfio_region_zpci_info_hdr hdr;
+	__u32 size;
+	__u8 util_str[];
+} __packed;
+
+/**
+ * struct vfio_region_zpci_info_pfip - PCI Function Path
+ *
+ * This region provides the PCI function path string, which is an identifier
+ * that describes the internal hardware path of the device.
+ */
+#define VFIO_REGION_ZPCI_INFO_PFIP	4
+
+struct vfio_region_zpci_info_pfip {
+struct vfio_region_zpci_info_hdr hdr;
+	__u32 size;
+	__u8 pfip[];
+} __packed;
+
+#endif
-- 
1.8.3.1
