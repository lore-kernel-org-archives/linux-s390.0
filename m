Return-Path: <SRS0=60ZI=TR=vger.kernel.org=kvm-owner@kernel.org>
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v2 2/4] vfio: vfio_iommu_type1: Define VFIO_IOMMU_INFO_CAPABILITIES
Date: Fri, 17 May 2019 18:16:48 +0200
In-Reply-To: <1558109810-18683-1-git-send-email-pmorel@linux.ibm.com>
References: <1558109810-18683-1-git-send-email-pmorel@linux.ibm.com>
Message-Id: <1558109810-18683-3-git-send-email-pmorel@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: sebott@linux.vnet.ibm.com
Cc: gerald.schaefer@de.ibm.com, pasic@linux.vnet.ibm.com, borntraeger@de.ibm.com, walling@linux.ibm.com, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, joro@8bytes.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, kvm@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, robin.murphy@arm.com
List-ID: <linux-s390.vger.kernel.org>

We add a capabilities functionality to VFIO_IOMMU_GET_INFO.

This will allow the VFIO_IOMMU_GET_INFO ioctl to retrieve IOMMU
specific information.

we define a new flag VFIO_IOMMU_INFO_CAPABILITIES in the
vfio_iommu_type1_info structure and two Z-PCI specific
capabilities:
VFIO_IOMMU_INFO_CAP_QFN: to query Z-PCI function information
VFIO_IOMMU_INFO_CAP_QGRP: to query for Z-PCI group information
and we define the associated information structures.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 include/uapi/linux/vfio.h | 67 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 8f10748..aed0e72 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -715,6 +715,73 @@ struct vfio_iommu_type1_info {
 	__u32	flags;
 #define VFIO_IOMMU_INFO_PGSIZES (1 << 0)	/* supported page sizes info */
 	__u64	iova_pgsizes;		/* Bitmap of supported page sizes */
+#define VFIO_IOMMU_INFO_CAPABILITIES (1 << 1)  /* support capabilities info */
+	__u64   cap_offset;     /* Offset within info struct of first cap */
+};
+
+/*
+ * The VFIO IOMMU INFO  PCI function capability allows to retrieve
+ * Z-PCI function specific data needed by the VFIO user to provide
+ * them to the guest function's driver.
+ *
+ * The structures below define version 1 of this capability.
+ */
+#define VFIO_IOMMU_INFO_CAP_QFN		1
+
+struct vfio_iommu_pci_function {
+	__u32 ignored;
+	__u32 format;		/* Structure format */
+	__u64 reserved1;
+	__u16 vfn;		/* Virtual function number */
+	__u8 u;			/* utility string presence */
+	__u8 gid;		/* Function group */
+	__u32 fid;		/* Function identifier */
+	__u8 bar_size[6];	/* Bar size */
+	__u16 pchid;		/* Physical channel ID */
+	__u32 bar[6];		/* PCI Bar address */
+	__u64 reserved2;
+	__u64 sdma;		/* Start available DMA */
+	__u64 edma;		/* End available DMA */
+	__u32 reserved3[11];
+	__u32 uid;		/* User's identifier */
+	__u8 util_str[64];	/* Adapter specific utility string */
+};
+
+struct vfio_iommu_type1_info_pcifn {
+	struct vfio_info_cap_header header;
+	struct vfio_iommu_pci_function response;
+};
+
+/*
+ * The VFIO IOMMU INFO PCI function group capability allows to retrieve
+ * information, specific to a group of Z-PCI functions, needed by
+ * the VFIO user to provide them to the guest function's driver.
+ *
+ * The structures below define version 1 of this capability.
+ */
+#define VFIO_IOMMU_INFO_CAP_QGRP	2
+
+struct vfio_iommu_pci_function_group {
+	__u32 ignored;
+	__u32 format;		/* Structure format */
+	__u64 reserved1;
+	__u16 noi;		/* Maximum number of interruptions */
+	__u8 version;		/* Version */
+	__u8 flags;		/* Flags */
+#define VFIO_IOMMU_ZPCI_REFRESH	0x01
+#define VFIO_IOMMU_ZPCI_FRAME	0x02
+	__u16 maxstbl;		/* Maximum store-block length */
+	__u16 mui;		/* Measurement block update interval */
+	__u64 reserved3;
+	__u64 dasm;		/* DMA Address space mask */
+	__u64 msia;		/* MSI Address */
+	__u64 reserved4;
+	__u64 reserved5;
+};
+
+struct vfio_iommu_type1_info_pcifg {
+	struct vfio_info_cap_header header;
+	struct vfio_iommu_pci_function_group response;
 };
 
 #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
-- 
2.7.4
