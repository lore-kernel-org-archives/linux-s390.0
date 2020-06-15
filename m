Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30254 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728326AbgFOMjf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 15 Jun 2020 08:39:35 -0400
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v2 1/1] s390: virtio: let arch accept devices without IOMMU feature
Date: Mon, 15 Jun 2020 14:39:24 +0200
Message-Id: <1592224764-1258-2-git-send-email-pmorel@linux.ibm.com>
In-Reply-To: <1592224764-1258-1-git-send-email-pmorel@linux.ibm.com>
References: <1592224764-1258-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org

An architecture protecting the guest memory against unauthorized host
access may want to enforce VIRTIO I/O device protection through the
use of VIRTIO_F_IOMMU_PLATFORM.

Let's give a chance to the architecture to accept or not devices
without VIRTIO_F_IOMMU_PLATFORM.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 arch/s390/mm/init.c     | 6 ++++++
 drivers/virtio/virtio.c | 9 +++++++++
 include/linux/virtio.h  | 2 ++
 3 files changed, 17 insertions(+)

diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 87b2d024e75a..3f04ad09650f 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -46,6 +46,7 @@
 #include <asm/kasan.h>
 #include <asm/dma-mapping.h>
 #include <asm/uv.h>
+#include <linux/virtio.h>
 
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __section(.bss..swapper_pg_dir);
 
@@ -162,6 +163,11 @@ bool force_dma_unencrypted(struct device *dev)
 	return is_prot_virt_guest();
 }
 
+int arch_needs_iommu_platform(struct virtio_device *dev) 
+{
+	return is_prot_virt_guest();
+}
+
 /* protected virtualization */
 static void pv_init(void)
 {
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index a977e32a88f2..30091089bee8 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -167,6 +167,11 @@ void virtio_add_status(struct virtio_device *dev, unsigned int status)
 }
 EXPORT_SYMBOL_GPL(virtio_add_status);
 
+int __weak arch_needs_iommu_platform(struct virtio_device *dev)
+{
+	return 0;
+}
+
 int virtio_finalize_features(struct virtio_device *dev)
 {
 	int ret = dev->config->finalize_features(dev);
@@ -179,6 +184,10 @@ int virtio_finalize_features(struct virtio_device *dev)
 	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1))
 		return 0;
 
+	if (arch_needs_iommu_platform(dev) &&
+		!virtio_has_feature(dev, VIRTIO_F_IOMMU_PLATFORM))
+		return -EIO;
+
 	virtio_add_status(dev, VIRTIO_CONFIG_S_FEATURES_OK);
 	status = dev->config->get_status(dev);
 	if (!(status & VIRTIO_CONFIG_S_FEATURES_OK)) {
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index a493eac08393..2c46b310c38c 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -195,4 +195,6 @@ void unregister_virtio_driver(struct virtio_driver *drv);
 #define module_virtio_driver(__virtio_driver) \
 	module_driver(__virtio_driver, register_virtio_driver, \
 			unregister_virtio_driver)
+
+int arch_needs_iommu_platform(struct virtio_device *dev);
 #endif /* _LINUX_VIRTIO_H */
-- 
2.25.1
