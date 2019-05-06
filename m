Return-Path: <SRS0=l9rD=TG=vger.kernel.org=kvm-owner@kernel.org>
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v1 1/2] vfio-ccw: Set subchannel state STANDBY on open
Date: Mon,  6 May 2019 15:11:09 +0200
In-Reply-To: <1557148270-19901-1-git-send-email-pmorel@linux.ibm.com>
References: <1557148270-19901-1-git-send-email-pmorel@linux.ibm.com>
Message-Id: <1557148270-19901-2-git-send-email-pmorel@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: cohuck@redhat.com
Cc: pasic@linux.vnet.ibm.com, farman@linux.ibm.com, alifm@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

When no guest is associated with the mediated device,
i.e. the mediated device is not opened, the state of
the mediated device is VFIO_CCW_STATE_NOT_OPER.

The subchannel enablement and the according setting to the
VFIO_CCW_STATE_STANDBY state should only be done when all
parts of the VFIO mediated device have been initialized
i.e. after the mediated device has been successfully opened.

Let's stay in VFIO_CCW_STATE_NOT_OPER until the mediated
device has been opened.

When the mediated device is closed, disable the sub channel
by calling vfio_ccw_sch_quiesce() no reset needs to be done
the mediated devce will be enable on next open.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c | 10 +---------
 drivers/s390/cio/vfio_ccw_ops.c | 36 ++++++++++++++++++------------------
 2 files changed, 19 insertions(+), 27 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index ee8767f..a95b6c7 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -143,26 +143,18 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 	dev_set_drvdata(&sch->dev, private);
 	mutex_init(&private->io_mutex);
 
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
 	if (private->cmd_region)
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 5eb6111..497419c 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -115,14 +115,10 @@ static int vfio_ccw_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
 	struct vfio_ccw_private *private =
 		dev_get_drvdata(mdev_parent_dev(mdev));
 
-	if (private->state == VFIO_CCW_STATE_NOT_OPER)
-		return -ENODEV;
-
 	if (atomic_dec_if_positive(&private->avail) < 0)
 		return -EPERM;
 
 	private->mdev = mdev;
-	private->state = VFIO_CCW_STATE_IDLE;
 
 	return 0;
 }
@@ -132,12 +128,7 @@ static int vfio_ccw_mdev_remove(struct mdev_device *mdev)
 	struct vfio_ccw_private *private =
 		dev_get_drvdata(mdev_parent_dev(mdev));
 
-	if ((private->state != VFIO_CCW_STATE_NOT_OPER) &&
-	    (private->state != VFIO_CCW_STATE_STANDBY)) {
-		if (!vfio_ccw_sch_quiesce(private->sch))
-			private->state = VFIO_CCW_STATE_STANDBY;
-		/* The state will be NOT_OPER on error. */
-	}
+	vfio_ccw_sch_quiesce(private->sch);
 
 	cp_free(&private->cp);
 	private->mdev = NULL;
@@ -151,6 +142,7 @@ static int vfio_ccw_mdev_open(struct mdev_device *mdev)
 	struct vfio_ccw_private *private =
 		dev_get_drvdata(mdev_parent_dev(mdev));
 	unsigned long events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
+	struct subchannel *sch = private->sch;
 	int ret;
 
 	private->nb.notifier_call = vfio_ccw_mdev_notifier;
@@ -165,6 +157,20 @@ static int vfio_ccw_mdev_open(struct mdev_device *mdev)
 		vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
 					 &private->nb);
 	return ret;
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
@@ -173,20 +179,14 @@ static void vfio_ccw_mdev_release(struct mdev_device *mdev)
 		dev_get_drvdata(mdev_parent_dev(mdev));
 	int i;
 
-	if ((private->state != VFIO_CCW_STATE_NOT_OPER) &&
-	    (private->state != VFIO_CCW_STATE_STANDBY)) {
-		if (!vfio_ccw_mdev_reset(mdev))
-			private->state = VFIO_CCW_STATE_STANDBY;
-		/* The state will be NOT_OPER on error. */
-	}
-
-	cp_free(&private->cp);
+	vfio_ccw_sch_quiesce(private->sch);
 	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
 				 &private->nb);
 
 	for (i = 0; i < private->num_regions; i++)
 		private->region[i].ops->release(private, &private->region[i]);
 
+	cp_free(&private->cp);
 	private->num_regions = 0;
 	kfree(private->region);
 	private->region = NULL;
-- 
2.7.4
