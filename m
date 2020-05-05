Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61054 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728642AbgEEM1w (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 May 2020 08:27:52 -0400
From: Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v4 5/8] vfio-ccw: Refactor IRQ handlers
Date: Tue,  5 May 2020 14:27:42 +0200
Message-Id: <20200505122745.53208-6-farman@linux.ibm.com>
In-Reply-To: <20200505122745.53208-1-farman@linux.ibm.com>
References: <20200505122745.53208-1-farman@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>

To simplify future expansion.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---

Notes:
    v1->v2:
     - Add Conny's r-b

 drivers/s390/cio/vfio_ccw_ops.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 22988d67b6bb..c3a74ab7bb86 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -387,17 +387,21 @@ static int vfio_ccw_mdev_get_region_info(struct vfio_region_info *info,
 
 static int vfio_ccw_mdev_get_irq_info(struct vfio_irq_info *info)
 {
-	if (info->index != VFIO_CCW_IO_IRQ_INDEX)
+	switch (info->index) {
+	case VFIO_CCW_IO_IRQ_INDEX:
+		info->count = 1;
+		info->flags = VFIO_IRQ_INFO_EVENTFD;
+		break;
+	default:
 		return -EINVAL;
-
-	info->count = 1;
-	info->flags = VFIO_IRQ_INFO_EVENTFD;
+	}
 
 	return 0;
 }
 
 static int vfio_ccw_mdev_set_irqs(struct mdev_device *mdev,
 				  uint32_t flags,
+				  uint32_t index,
 				  void __user *data)
 {
 	struct vfio_ccw_private *private;
@@ -407,7 +411,14 @@ static int vfio_ccw_mdev_set_irqs(struct mdev_device *mdev,
 		return -EINVAL;
 
 	private = dev_get_drvdata(mdev_parent_dev(mdev));
-	ctx = &private->io_trigger;
+
+	switch (index) {
+	case VFIO_CCW_IO_IRQ_INDEX:
+		ctx = &private->io_trigger;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	switch (flags & VFIO_IRQ_SET_DATA_TYPE_MASK) {
 	case VFIO_IRQ_SET_DATA_NONE:
@@ -579,7 +590,7 @@ static ssize_t vfio_ccw_mdev_ioctl(struct mdev_device *mdev,
 			return ret;
 
 		data = (void __user *)(arg + minsz);
-		return vfio_ccw_mdev_set_irqs(mdev, hdr.flags, data);
+		return vfio_ccw_mdev_set_irqs(mdev, hdr.flags, hdr.index, data);
 	}
 	case VFIO_DEVICE_RESET:
 		return vfio_ccw_mdev_reset(mdev);
-- 
2.17.1
