From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [PATCH RFC v2 10/15] vfio: ccw: realize VFIO_DEVICE_RESET ioctl
Date: Thu, 12 Jan 2017 08:19:42 +0100
Message-ID: <20170112071947.98071-11-bjsdjshi@linux.vnet.ibm.com>
References: <20170112071947.98071-1-bjsdjshi@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170112071947.98071-1-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Introduce VFIO_DEVICE_RESET ioctl for vfio-ccw to make it possible
to hot-reset the device.

We try to achieve a reset by first disabling the subchannel and
then enabling it again: this should clear all state at the subchannel.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 drivers/s390/cio/vfio_ccw_ops.c | 42 +++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 5c60cda..b702735 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -19,6 +19,31 @@
 #define MAX_INSTANCES	1
 static int available_instances = MAX_INSTANCES;
 
+static int vfio_ccw_mdev_reset(struct mdev_device *mdev)
+{
+	struct vfio_ccw_private *private = dev_get_drvdata(mdev->dev.parent);
+	struct subchannel *sch;
+	int ret;
+
+	if (!private)
+		return -ENODEV;
+
+	sch = private->sch;
+	/*
+	 * TODO:
+	 * In the cureent stage, some things like "no I/O running" and "no
+	 * interrupt pending" are clear, but we are not sure what other state
+	 * we need to care about.
+	 * There are still a lot more instructions need to be handled. We
+	 * should come back here later.
+	 */
+	ret = vfio_ccw_sch_quiesce(sch);
+	if (ret)
+		return ret;
+
+	return cio_enable_subchannel(sch, (u32)(unsigned long)sch);
+}
+
 static int vfio_ccw_mdev_notifier(struct notifier_block *nb,
 				  unsigned long action,
 				  void *data)
@@ -35,15 +60,11 @@ static int vfio_ccw_mdev_notifier(struct notifier_block *nb,
 	 */
 	if (action == VFIO_IOMMU_NOTIFY_DMA_UNMAP) {
 		struct vfio_iommu_type1_dma_unmap *unmap = data;
-		struct subchannel *sch = private->sch;
 
 		if (!cp_iova_pinned(&private->cp, unmap->iova))
 			return NOTIFY_OK;
 
-		if (vfio_ccw_sch_quiesce(sch))
-			return NOTIFY_BAD;
-
-		if (cio_enable_subchannel(sch, (u32)(unsigned long)sch))
+		if (vfio_ccw_mdev_reset(private->mdev))
 			return NOTIFY_BAD;
 
 		cp_free(&private->cp);
@@ -107,14 +128,9 @@ static int vfio_ccw_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
 static int vfio_ccw_mdev_remove(struct mdev_device *mdev)
 {
 	struct vfio_ccw_private *private = dev_get_drvdata(mdev->parent->dev);
-	struct subchannel *sch;
 	int ret;
 
-	sch = private->sch;
-	ret = vfio_ccw_sch_quiesce(sch);
-	if (ret)
-		return ret;
-	ret = cio_enable_subchannel(sch, (u32)(unsigned long)sch);
+	ret = vfio_ccw_mdev_reset(mdev);
 	if (ret)
 		return ret;
 
@@ -193,7 +209,7 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
 static int vfio_ccw_mdev_get_device_info(struct mdev_device *mdev,
 					 struct vfio_device_info *info)
 {
-	info->flags = VFIO_DEVICE_FLAGS_CCW;
+	info->flags = VFIO_DEVICE_FLAGS_CCW | VFIO_DEVICE_FLAGS_RESET;
 	info->num_regions = VFIO_CCW_NUM_REGIONS;
 	info->num_irqs = 0;
 
@@ -265,6 +281,8 @@ static ssize_t vfio_ccw_mdev_ioctl(struct mdev_device *mdev,
 
 		return copy_to_user((void __user *)arg, &info, minsz);
 	}
+	case VFIO_DEVICE_RESET:
+		return vfio_ccw_mdev_reset(mdev);
 	default:
 		return -ENOTTY;
 	}
-- 
2.8.4
