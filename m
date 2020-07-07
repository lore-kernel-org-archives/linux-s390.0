Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36976 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726467AbgGGIo7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Jul 2020 04:44:59 -0400
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v4 2/2] s390: virtio: PV needs VIRTIO I/O device protection
Date: Tue,  7 Jul 2020 10:44:37 +0200
Message-Id: <1594111477-15401-3-git-send-email-pmorel@linux.ibm.com>
In-Reply-To: <1594111477-15401-1-git-send-email-pmorel@linux.ibm.com>
References: <1594111477-15401-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com

S390, protecting the guest memory against unauthorized host access
needs to enforce VIRTIO I/O device protection through the use of
VIRTIO_F_VERSION_1 and VIRTIO_F_IOMMU_PLATFORM.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 arch/s390/kernel/uv.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index c296e5c8dbf9..106330f6eda1 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -14,6 +14,7 @@
 #include <linux/memblock.h>
 #include <linux/pagemap.h>
 #include <linux/swap.h>
+#include <linux/virtio_config.h>
 #include <asm/facility.h>
 #include <asm/sections.h>
 #include <asm/uv.h>
@@ -413,3 +414,27 @@ static int __init uv_info_init(void)
 }
 device_initcall(uv_info_init);
 #endif
+
+/*
+ * arch_validate_virtio_iommu_platform
+ * @dev: the VIRTIO device being added
+ *
+ * Return value: returns -ENODEV if any features of the
+ *               device breaks the protected virtualization
+ *               0 otherwise.
+ */
+int arch_validate_virtio_features(struct virtio_device *dev)
+{
+	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1)) {
+		dev_warn(&dev->dev, "device must provide VIRTIO_F_VERSION_1\n");
+		return is_prot_virt_guest() ? -ENODEV : 0;
+	}
+
+	if (!virtio_has_feature(dev, VIRTIO_F_IOMMU_PLATFORM)) {
+		dev_warn(&dev->dev,
+			 "device must provide VIRTIO_F_IOMMU_PLATFORM\n");
+		return is_prot_virt_guest() ? -ENODEV : 0;
+	}
+
+	return 0;
+}
-- 
2.25.1
