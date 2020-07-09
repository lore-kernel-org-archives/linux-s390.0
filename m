Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41962 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726456AbgGIIjf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Jul 2020 04:39:35 -0400
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v5 1/2] virtio: let arch validate VIRTIO features
Date: Thu,  9 Jul 2020 10:39:18 +0200
Message-Id: <1594283959-13742-2-git-send-email-pmorel@linux.ibm.com>
In-Reply-To: <1594283959-13742-1-git-send-email-pmorel@linux.ibm.com>
References: <1594283959-13742-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com

An architecture may need to validate the VIRTIO devices features
based on architecture specifics.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/virtio/virtio.c       | 19 +++++++++++++++++++
 include/linux/virtio_config.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index a977e32a88f2..c4e14d46a5b6 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -167,6 +167,21 @@ void virtio_add_status(struct virtio_device *dev, unsigned int status)
 }
 EXPORT_SYMBOL_GPL(virtio_add_status);
 
+/*
+ * arch_validate_virtio_features - provide arch specific hook when finalizing
+ *				   features for VIRTIO device dev
+ * @dev: the VIRTIO device being added
+ *
+ * Permits the platform to handle architecture-specific requirements when
+ * device features are finalized. This is the default implementation.
+ * Architecture implementations can override this.
+ */
+
+int __weak arch_validate_virtio_features(struct virtio_device *dev)
+{
+	return 0;
+}
+
 int virtio_finalize_features(struct virtio_device *dev)
 {
 	int ret = dev->config->finalize_features(dev);
@@ -176,6 +191,10 @@ int virtio_finalize_features(struct virtio_device *dev)
 	if (ret)
 		return ret;
 
+	ret = arch_validate_virtio_features(dev);
+	if (ret)
+		return ret;
+
 	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1))
 		return 0;
 
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index bb4cc4910750..3f4117adf311 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -459,4 +459,5 @@ static inline void virtio_cwrite64(struct virtio_device *vdev,
 		_r;							\
 	})
 
+int arch_validate_virtio_features(struct virtio_device *dev);
 #endif /* _LINUX_VIRTIO_CONFIG_H */
-- 
2.25.1
