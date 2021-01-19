Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61966 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729548AbhASUDY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 19 Jan 2021 15:03:24 -0500
From: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH 2/4] vfio-pci/zdev: Pass the relaxed alignment flag
Date: Tue, 19 Jan 2021 15:02:28 -0500
Message-Id: <1611086550-32765-3-git-send-email-mjrosato@linux.ibm.com>
In-Reply-To: <1611086550-32765-1-git-send-email-mjrosato@linux.ibm.com>
References: <1611086550-32765-1-git-send-email-mjrosato@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: alex.williamson@redhat.com, cohuck@redhat.com, schnelle@linux.ibm.com
Cc: pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

Use an additional bit of the VFIO_DEVICE_INFO_CAP_ZPCI_GROUP flags
field to pass whether or not the associated device supports relaxed
length and alignment for some I/O operations.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Acked-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/vfio/pci/vfio_pci_zdev.c | 2 ++
 include/uapi/linux/vfio_zdev.h   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
index 2296856..57e19ff 100644
--- a/drivers/vfio/pci/vfio_pci_zdev.c
+++ b/drivers/vfio/pci/vfio_pci_zdev.c
@@ -60,6 +60,8 @@ static int zpci_group_cap(struct zpci_dev *zdev, struct vfio_pci_device *vdev,
 		.version = zdev->version
 	};
 
+	if (zdev->relaxed_align)
+		cap.flags |= VFIO_DEVICE_INFO_ZPCI_FLAG_RELAXED;
 	return vfio_info_add_capability(caps, &cap.header, sizeof(cap));
 }
 
diff --git a/include/uapi/linux/vfio_zdev.h b/include/uapi/linux/vfio_zdev.h
index b430939..b0b6596 100644
--- a/include/uapi/linux/vfio_zdev.h
+++ b/include/uapi/linux/vfio_zdev.h
@@ -43,6 +43,7 @@ struct vfio_device_info_cap_zpci_group {
 	__u64 msi_addr;		/* MSI address */
 	__u64 flags;
 #define VFIO_DEVICE_INFO_ZPCI_FLAG_REFRESH 1 /* Program-specified TLB refresh */
+#define VFIO_DEVICE_INFO_ZPCI_FLAG_RELAXED 2 /* Relaxed Length and Alignment */
 	__u16 mui;		/* Measurement Block Update Interval */
 	__u16 noi;		/* Maximum number of MSIs */
 	__u16 maxstbl;		/* Maximum Store Block Length */
-- 
1.8.3.1
