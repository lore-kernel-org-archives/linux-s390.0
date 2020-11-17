Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6588 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726720AbgKQDVr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 16 Nov 2020 22:21:47 -0500
From: Eric Farman <farman@linux.ibm.com>
Subject: [RFC PATCH 2/2] vfio-ccw: Wire in the request callback
Date: Tue, 17 Nov 2020 04:21:39 +0100
Message-Id: <20201117032139.50988-3-farman@linux.ibm.com>
In-Reply-To: <20201117032139.50988-1-farman@linux.ibm.com>
References: <20201117032139.50988-1-farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Eric Farman <farman@linux.ibm.com>

The device is being unplugged, so pass the request to userspace to
ask for a graceful cleanup. This should free up the thread that
would otherwise loop waiting for the device to be fully released.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_ops.c     | 26 ++++++++++++++++++++++++++
 drivers/s390/cio/vfio_ccw_private.h |  4 ++++
 include/uapi/linux/vfio.h           |  1 +
 3 files changed, 31 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 8b3ed5b45277..68106be4ba7a 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -394,6 +394,7 @@ static int vfio_ccw_mdev_get_irq_info(struct vfio_irq_info *info)
 	switch (info->index) {
 	case VFIO_CCW_IO_IRQ_INDEX:
 	case VFIO_CCW_CRW_IRQ_INDEX:
+	case VFIO_CCW_REQ_IRQ_INDEX:
 		info->count = 1;
 		info->flags = VFIO_IRQ_INFO_EVENTFD;
 		break;
@@ -424,6 +425,9 @@ static int vfio_ccw_mdev_set_irqs(struct mdev_device *mdev,
 	case VFIO_CCW_CRW_IRQ_INDEX:
 		ctx = &private->crw_trigger;
 		break;
+	case VFIO_CCW_REQ_IRQ_INDEX:
+		ctx = &private->req_trigger;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -607,6 +611,27 @@ static ssize_t vfio_ccw_mdev_ioctl(struct mdev_device *mdev,
 	}
 }
 
+/* Request removal of the device*/
+static void vfio_ccw_mdev_request(struct mdev_device *mdev, unsigned int count)
+{
+	struct vfio_ccw_private *private = dev_get_drvdata(mdev_parent_dev(mdev));
+
+	if (!private)
+		return;
+
+	if (private->req_trigger) {
+		if (!(count % 10))
+			dev_notice_ratelimited(mdev_dev(private->mdev),
+					       "Relaying device request to user (#%u)\n",
+					       count);
+
+		eventfd_signal(private->req_trigger, 1);
+	} else if (count == 0) {
+		dev_notice(mdev_dev(private->mdev),
+			   "No device request channel registered, blocked until released by user\n");
+	}
+}
+
 static const struct mdev_parent_ops vfio_ccw_mdev_ops = {
 	.owner			= THIS_MODULE,
 	.supported_type_groups  = mdev_type_groups,
@@ -617,6 +642,7 @@ static const struct mdev_parent_ops vfio_ccw_mdev_ops = {
 	.read			= vfio_ccw_mdev_read,
 	.write			= vfio_ccw_mdev_write,
 	.ioctl			= vfio_ccw_mdev_ioctl,
+	.request		= vfio_ccw_mdev_request,
 };
 
 int vfio_ccw_mdev_reg(struct subchannel *sch)
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index 8723156b29ea..b2c762eb42b9 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -84,7 +84,10 @@ struct vfio_ccw_crw {
  * @irb: irb info received from interrupt
  * @scsw: scsw info
  * @io_trigger: eventfd ctx for signaling userspace I/O results
+ * @crw_trigger: eventfd ctx for signaling userspace CRW information
+ * @req_trigger: eventfd ctx for signaling userspace to return device
  * @io_work: work for deferral process of I/O handling
+ * @crw_work: work for deferral process of CRW handling
  */
 struct vfio_ccw_private {
 	struct subchannel	*sch;
@@ -108,6 +111,7 @@ struct vfio_ccw_private {
 
 	struct eventfd_ctx	*io_trigger;
 	struct eventfd_ctx	*crw_trigger;
+	struct eventfd_ctx	*req_trigger;
 	struct work_struct	io_work;
 	struct work_struct	crw_work;
 } __aligned(8);
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 2f313a238a8f..d1812777139f 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -820,6 +820,7 @@ enum {
 enum {
 	VFIO_CCW_IO_IRQ_INDEX,
 	VFIO_CCW_CRW_IRQ_INDEX,
+	VFIO_CCW_REQ_IRQ_INDEX,
 	VFIO_CCW_NUM_IRQS
 };
 
-- 
2.17.1
