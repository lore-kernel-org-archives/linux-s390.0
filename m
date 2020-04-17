Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40474 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728969AbgDQCaJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Apr 2020 22:30:09 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03H2CCWB144101
        for <linux-s390@vger.kernel.org>; Thu, 16 Apr 2020 22:30:08 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30f3f4gace-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 16 Apr 2020 22:30:08 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <farman@linux.ibm.com>;
        Fri, 17 Apr 2020 03:29:37 +0100
From: Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v3 6/8] vfio-ccw: Refactor IRQ handlers
Date: Fri, 17 Apr 2020 04:29:59 +0200
In-Reply-To: <20200417023001.65006-1-farman@linux.ibm.com>
References: <20200417023001.65006-1-farman@linux.ibm.com>
Message-Id: <20200417023001.65006-7-farman@linux.ibm.com>
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
index edec0fb7ace8..f3033f8fc96d 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -391,17 +391,21 @@ static int vfio_ccw_mdev_get_region_info(struct vfio_region_info *info,
 
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
@@ -411,7 +415,14 @@ static int vfio_ccw_mdev_set_irqs(struct mdev_device *mdev,
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
@@ -583,7 +594,7 @@ static ssize_t vfio_ccw_mdev_ioctl(struct mdev_device *mdev,
 			return ret;
 
 		data = (void __user *)(arg + minsz);
-		return vfio_ccw_mdev_set_irqs(mdev, hdr.flags, data);
+		return vfio_ccw_mdev_set_irqs(mdev, hdr.flags, hdr.index, data);
 	}
 	case VFIO_DEVICE_RESET:
 		return vfio_ccw_mdev_reset(mdev);
-- 
2.17.1
