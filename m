From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v3 3/6] vfio: ccw: Rework subchannel state on removing
Date: Wed, 28 Nov 2018 13:41:04 +0100
Message-ID: <1543408867-16465-4-git-send-email-pmorel@linux.ibm.com>
References: <1543408867-16465-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543408867-16465-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pasic@linux.vnet.ibm.com
Cc: cohuck@redhat.com, farman@linux.ibm.com, alifm@linux.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This patch can be squash with the previous and is separate
to ease review.

We continue to clarify the state changes.

NOT_OPER is set on unrecoverable error
bind (probe) set the state to STANDBY
open set the state to idle
release set the state back to STANDBY

All functions called during the normal state of the device
do not change the state but on errors.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c |  1 -
 drivers/s390/cio/vfio_ccw_ops.c | 25 ++++++++++---------------
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index d3527b6..1779b46 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -66,7 +66,6 @@ int vfio_ccw_sch_quiesce(struct subchannel *sch)
 		ret = cio_disable_subchannel(sch);
 	} while (ret == -EBUSY);
 out_unlock:
-	private->state = VFIO_CCW_STATE_NOT_OPER;
 	spin_unlock_irq(sch->lock);
 	return ret;
 }
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index cc7d46a..eb5b49d 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -35,11 +35,7 @@ static int vfio_ccw_mdev_reset(struct mdev_device *mdev)
 	if (ret)
 		return ret;
 
-	ret = cio_enable_subchannel(sch, (u32)(unsigned long)sch);
-	if (!ret)
-		private->state = VFIO_CCW_STATE_IDLE;
-
-	return ret;
+	return cio_enable_subchannel(sch, (u32)(unsigned long)sch);
 }
 
 static int vfio_ccw_mdev_notifier(struct notifier_block *nb,
@@ -117,7 +113,7 @@ static int vfio_ccw_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
 		return -EPERM;
 
 	private->mdev = mdev;
-	private->state = VFIO_CCW_STATE_NOT_OPER;
+	private->state = VFIO_CCW_STATE_STANDBY;
 
 	return 0;
 }
@@ -128,11 +124,11 @@ static int vfio_ccw_mdev_remove(struct mdev_device *mdev)
 		dev_get_drvdata(mdev_parent_dev(mdev));
 
 	if ((private->state != VFIO_CCW_STATE_NOT_OPER) &&
-	    (private->state != VFIO_CCW_STATE_STANDBY)) {
-		if (!vfio_ccw_mdev_reset(mdev))
-			private->state = VFIO_CCW_STATE_STANDBY;
-		/* The state will be NOT_OPER on error. */
-	}
+	    (private->state != VFIO_CCW_STATE_STANDBY))
+		return -EBUSY;
+
+	vfio_ccw_mdev_reset(mdev);
+	private->state = VFIO_CCW_STATE_NOT_OPER;
 
 	private->mdev = NULL;
 	atomic_inc(&private->avail);
@@ -164,7 +160,7 @@ static int vfio_ccw_mdev_open(struct mdev_device *mdev)
 	if (ret)
 		goto err_enable;
 
-	private->state = VFIO_CCW_STATE_STANDBY;
+	private->state = VFIO_CCW_STATE_IDLE;
 	spin_unlock_irq(sch->lock);
 	return 0;
 
@@ -184,6 +180,7 @@ static void vfio_ccw_mdev_release(struct mdev_device *mdev)
 		dev_get_drvdata(mdev_parent_dev(mdev));
 	int i;
 
+	private->state = VFIO_CCW_STATE_STANDBY;
 	vfio_ccw_sch_quiesce(private->sch);
 	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
 				 &private->nb);
@@ -256,10 +253,8 @@ static ssize_t vfio_ccw_mdev_write_io_region(struct vfio_ccw_private *private,
 		return -EFAULT;
 
 	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_IO_REQ);
-	if (region->ret_code != 0) {
-		private->state = VFIO_CCW_STATE_IDLE;
+	if (region->ret_code != 0)
 		return region->ret_code;
-	}
 
 	return count;
 
-- 
2.7.4
