Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21210 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728935AbgHFQfp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 6 Aug 2020 12:35:45 -0400
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v1 1/1] s390: virtio-ccw: PV needs VIRTIO I/O device protection
Date: Thu,  6 Aug 2020 16:23:02 +0200
Message-Id: <1596723782-12798-2-git-send-email-pmorel@linux.ibm.com>
In-Reply-To: <1596723782-12798-1-git-send-email-pmorel@linux.ibm.com>
References: <1596723782-12798-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org

If protected virtualization is active on s390, the virtio queues are
not accessible to the host, unless VIRTIO_F_IOMMU_PLATFORM has been
negotiated. Use ccw_transport_features() to fail feature negociation
and consequently probe if that's not the case, preventing a host
error on access attempt.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/virtio/virtio_ccw.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 5730572b52cd..cc8d8064c6c4 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -803,11 +803,23 @@ static u64 virtio_ccw_get_features(struct virtio_device *vdev)
 	return rc;
 }
 
-static void ccw_transport_features(struct virtio_device *vdev)
+static int ccw_transport_features(struct virtio_device *vdev)
 {
-	/*
-	 * Currently nothing to do here.
-	 */
+	if (!is_prot_virt_guest())
+		return 0;
+
+	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+		dev_warn(&vdev->dev,
+			 "device must provide VIRTIO_F_VERSION_1\n");
+		return -ENODEV;
+	}
+
+	if (!virtio_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM)) {
+		dev_warn(&vdev->dev,
+			 "device must provide VIRTIO_F_IOMMU_PLATFORM\n");
+		return -ENODEV;
+	}
+	return 0;
 }
 
 static int virtio_ccw_finalize_features(struct virtio_device *vdev)
@@ -837,7 +849,9 @@ static int virtio_ccw_finalize_features(struct virtio_device *vdev)
 	vring_transport_features(vdev);
 
 	/* Give virtio_ccw a chance to accept features. */
-	ccw_transport_features(vdev);
+	ret = ccw_transport_features(vdev);
+	if (ret)
+		goto out_free;
 
 	features->index = 0;
 	features->features = cpu_to_le32((u32)vdev->features);
-- 
2.25.1
