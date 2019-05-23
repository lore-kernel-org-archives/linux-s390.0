Return-Path: <SRS0=0NiW=TX=vger.kernel.org=kvm-owner@kernel.org>
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v3 2/3] vfio: zpci: defining the VFIO headers
Date: Thu, 23 May 2019 14:25:25 +0200
In-Reply-To: <1558614326-24711-1-git-send-email-pmorel@linux.ibm.com>
References: <1558614326-24711-1-git-send-email-pmorel@linux.ibm.com>
Message-Id: <1558614326-24711-3-git-send-email-pmorel@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: sebott@linux.vnet.ibm.com
Cc: gerald.schaefer@de.ibm.com, pasic@linux.vnet.ibm.com, borntraeger@de.ibm.com, walling@linux.ibm.com, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, joro@8bytes.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, kvm@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, robin.murphy@arm.com
List-ID: <linux-s390.vger.kernel.org>

We define a new device region in vfio.h to be able to
get the ZPCI CLP information by reading this region from
userland.

We create a new file, vfio_zdev.h to define the structure
of the new region we defined in vfio.h

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 include/uapi/linux/vfio.h      |  4 ++++
 include/uapi/linux/vfio_zdev.h | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 include/uapi/linux/vfio_zdev.h

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 8f10748..56595b8 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -306,6 +306,10 @@ struct vfio_region_info_cap_type {
 #define VFIO_REGION_TYPE_GFX                    (1)
 #define VFIO_REGION_SUBTYPE_GFX_EDID            (1)
 
+/* IBM Subtypes */
+#define VFIO_REGION_TYPE_IBM_ZDEV		(1)
+#define VFIO_REGION_SUBTYPE_ZDEV_CLP		(1)
+
 /**
  * struct vfio_region_gfx_edid - EDID region layout.
  *
diff --git a/include/uapi/linux/vfio_zdev.h b/include/uapi/linux/vfio_zdev.h
new file mode 100644
index 0000000..84b1a82
--- /dev/null
+++ b/include/uapi/linux/vfio_zdev.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Region definition for ZPCI devices
+ *
+ * Copyright IBM Corp. 2019
+ *
+ * Author(s): Pierre Morel <pmorel@linux.ibm.com>
+ */
+
+#ifndef _VFIO_ZDEV_H_
+#define _VFIO_ZDEV_H_
+
+#include <linux/types.h>
+
+/**
+ * struct vfio_region_zpci_info - ZPCI information.
+ *
+ */
+struct vfio_region_zpci_info {
+	__u64 dasm;
+	__u64 start_dma;
+	__u64 end_dma;
+	__u64 msi_addr;
+	__u64 flags;
+	__u16 pchid;
+	__u16 mui;
+	__u16 noi;
+	__u8 gid;
+	__u8 version;
+#define VFIO_PCI_ZDEV_FLAGS_REFRESH 1
+	__u8 util_str[CLP_UTIL_STR_LEN];
+} __packed;
+
+#endif
-- 
2.7.4
