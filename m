From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [RFC PATCH 2/3] vfio: ccw: introduce channel path irq
Date: Thu, 11 Jan 2018 04:04:20 +0100
Message-ID: <20180111030421.31418-3-bjsdjshi@linux.vnet.ibm.com>
References: <20180111030421.31418-1-bjsdjshi@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180111030421.31418-1-bjsdjshi@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, bjsdjshi@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

This introduces a new irq for vfio-ccw to provide channel path
related event for userland.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 drivers/s390/cio/vfio_ccw_ops.c     | 29 +++++++++++++++++++++--------
 drivers/s390/cio/vfio_ccw_private.h |  2 ++
 include/uapi/linux/vfio.h           |  1 +
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 9528fce2e7d9..972cfc8834fc 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -275,17 +275,20 @@ static int vfio_ccw_mdev_get_region_info(struct vfio_region_info *info,
 
 static int vfio_ccw_mdev_get_irq_info(struct vfio_irq_info *info)
 {
-	if (info->index != VFIO_CCW_IO_IRQ_INDEX)
+	switch (info->index) {
+	case VFIO_CCW_IO_IRQ_INDEX:
+	case VFIO_CCW_CHP_IRQ_INDEX:
+		info->count = 1;
+		info->flags = VFIO_IRQ_INFO_EVENTFD;
+		return 0;
+	default:
 		return -EINVAL;
-
-	info->count = 1;
-	info->flags = VFIO_IRQ_INFO_EVENTFD;
-
-	return 0;
+	}
 }
 
 static int vfio_ccw_mdev_set_irqs(struct mdev_device *mdev,
 				  uint32_t flags,
+				  unsigned index,
 				  void __user *data)
 {
 	struct vfio_ccw_private *private;
@@ -295,7 +298,17 @@ static int vfio_ccw_mdev_set_irqs(struct mdev_device *mdev,
 		return -EINVAL;
 
 	private = dev_get_drvdata(mdev_parent_dev(mdev));
-	ctx = &private->io_trigger;
+
+	switch (index) {
+	case VFIO_CCW_IO_IRQ_INDEX:
+		ctx = &private->io_trigger;
+		break;
+	case VFIO_CCW_CHP_IRQ_INDEX:
+		ctx = &private->chp_trigger;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	switch (flags & VFIO_IRQ_SET_DATA_TYPE_MASK) {
 	case VFIO_IRQ_SET_DATA_NONE:
@@ -433,7 +446,7 @@ static ssize_t vfio_ccw_mdev_ioctl(struct mdev_device *mdev,
 			return ret;
 
 		data = (void __user *)(arg + minsz);
-		return vfio_ccw_mdev_set_irqs(mdev, hdr.flags, data);
+		return vfio_ccw_mdev_set_irqs(mdev, hdr.flags, hdr.index, data);
 	}
 	case VFIO_DEVICE_RESET:
 		return vfio_ccw_mdev_reset(mdev);
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index 460c8b90d834..da86f82dd7b9 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -33,6 +33,7 @@
  * @irb: irb info received from interrupt
  * @scsw: scsw info
  * @io_trigger: eventfd ctx for signaling userspace I/O results
+ * @chp_trigger: eventfd ctx for signaling userspace chp event
  * @io_work: work for deferral process of I/O handling
  */
 struct vfio_ccw_private {
@@ -50,6 +51,7 @@ struct vfio_ccw_private {
 	union scsw		scsw;
 
 	struct eventfd_ctx	*io_trigger;
+	struct eventfd_ctx	*chp_trigger;
 	struct work_struct	io_work;
 } __aligned(8);
 
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index c60244debf71..179a7492d53a 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -463,6 +463,7 @@ enum {
 
 enum {
 	VFIO_CCW_IO_IRQ_INDEX,
+	VFIO_CCW_CHP_IRQ_INDEX,
 	VFIO_CCW_NUM_IRQS
 };
 
-- 
2.13.5
