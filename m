From: Pierre Morel <pmorel@linux.ibm.com>
Date: Wed, 17 Oct 2018 09:18:41 +0000
Subject: [PATCH 3/5] vfio: ccw: Set subchannel state STANDBY on open
Message-Id: <1539767923-10539-4-git-send-email-pmorel@linux.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The subchannel enablement and the according setting to the
VFIO_CCW_STATE_STANDBY state should only be done when all
parts of the VFIO mediated device have been initialized
i.e. after the mediated device has been successfully opened.

Let's stay in VFIO_CCW_STATE_NOT_OPER until the mediated
device has been opened.

When the mediated device is closed,  disable the sub channel
by calling vfio_ccw_sch_quiesce().

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c | 10 +---------
 drivers/s390/cio/vfio_ccw_ops.c | 23 +++++++++++++++++++++--
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 33fd53f..1996353 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -126,26 +126,18 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 	private->sch = sch;
 	dev_set_drvdata(&sch->dev, private);
 
-	spin_lock_irq(sch->lock);
 	private->state = VFIO_CCW_STATE_NOT_OPER;
 	sch->isc = VFIO_CCW_ISC;
-	ret = cio_enable_subchannel(sch, (u32)(unsigned long)sch);
-	spin_unlock_irq(sch->lock);
-	if (ret)
-		goto out_free;
 
 	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
 	atomic_set(&private->avail, 1);
-	private->state = VFIO_CCW_STATE_STANDBY;
 
 	ret = vfio_ccw_mdev_reg(sch);
 	if (ret)
-		goto out_disable;
+		goto out_free;
 
 	return 0;
 
-out_disable:
-	cio_disable_subchannel(sch);
 out_free:
 	dev_set_drvdata(&sch->dev, NULL);
 	kmem_cache_free(vfio_ccw_io_region, private->io_region);
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index f673e10..87a8f8c 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -146,11 +146,29 @@ static int vfio_ccw_mdev_open(struct mdev_device *mdev)
 	struct vfio_ccw_private *private =
 		dev_get_drvdata(mdev_parent_dev(mdev));
 	unsigned long events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
+	struct subchannel *sch = private->sch;
+	int ret;
 
 	private->nb.notifier_call = vfio_ccw_mdev_notifier;
 
-	return vfio_register_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
-				      &events, &private->nb);
+	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
+				     &events, &private->nb);
+	if (ret)
+		return ret;
+
+	spin_lock_irq(private->sch->lock);
+	if (cio_enable_subchannel(sch, (u32)(unsigned long)sch))
+		goto error;
+
+	private->state = VFIO_CCW_STATE_STANDBY;
+	spin_unlock_irq(sch->lock);
+	return 0;
+
+error:
+	spin_unlock_irq(sch->lock);
+	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
+				 &private->nb);
+	return -EFAULT;
 }
 
 static void vfio_ccw_mdev_release(struct mdev_device *mdev)
@@ -158,6 +176,7 @@ static void vfio_ccw_mdev_release(struct mdev_device *mdev)
 	struct vfio_ccw_private *private =
 		dev_get_drvdata(mdev_parent_dev(mdev));
 
+	vfio_ccw_sch_quiesce(private->sch);
 	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
 				 &private->nb);
 }
-- 
2.7.4
