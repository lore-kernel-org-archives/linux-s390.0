From: Pierre Morel <pmorel@linux.ibm.com>
Date: Wed, 17 Oct 2018 09:18:42 +0000
Subject: [PATCH 4/5] vfio: ccw: Refactoring state changes
Message-Id: <1539767923-10539-5-git-send-email-pmorel@linux.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Currently, he state machine is hesitating between following the
state of the subchannel, the state of the subchannel device,
and the state of the mediated device.

The situation leads to unclear state changes
and we need to clarify the situation.

Let's let the guest take care of the subchannel
and let us keep track of the mediated device parent in the
mediated device driver.

probe() : -> NOT_OPERATIONAL
	We have a transtion to the NOT_OPERATIONAL state
	as soon as the device is bound and the private structure
	is allocated.
In NOT_OPERATIONAL:
	Nothing is done on the subchannel in this state

mdev_create() : -> STANDBY
in STANDBY:
	Nothing is done on the subchannel in this state
	Interruptions should not happen but are cleared if
	they happen.

mdev_open() : -> IDLE
	The subchannel is enabled
In IDLE:
	We expect I/O and accept interruptions.

fsm_io_request() : -> BUSY
	mdev_write() eventually calls fsm_io_request() which
	starts the IO
In BUSY:
	We refuse I/O and accept interruptions.

vfio_ccw_sch_io_todo() -> IDLE
	If we expected an interruption we process it.
	otherwise we clear it and ignore it.

      bind() unbind()
        |       ^
        v       |
      -------------
      | NOT_OPER  |<---- on Error
      -------------    |
        |       ^      |
     create() remove() |
        v       |      |
      -------------    |
      | STANDBY   |<--- release()
      -------------    |
        |       ^      |
      open() release() |
        v       |      |
      -------------    |
      |   IDLE    |<--- reset()
      -------------    |
        |       ^      |
      write()  irq()   |
        v       |      |
      -------------    |
      |   BUSY    |>----
      -------------

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c | 19 +++++++++++++++----
 drivers/s390/cio/vfio_ccw_ops.c | 19 +++++++++----------
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 1996353..b29a96f 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -63,7 +63,6 @@ int vfio_ccw_sch_quiesce(struct subchannel *sch)
 		ret = cio_disable_subchannel(sch);
 	} while (ret == -EBUSY);
 out_unlock:
-	private->state = VFIO_CCW_STATE_NOT_OPER;
 	spin_unlock_irq(sch->lock);
 	return ret;
 }
@@ -80,13 +79,15 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 		cp_update_scsw(&private->cp, &irb->scsw);
 		cp_free(&private->cp);
 	}
+	if (private->state != VFIO_CCW_STATE_BUSY)
+		return;
+
 	memcpy(private->io_region->irb_area, irb, sizeof(*irb));
 
 	if (private->io_trigger)
 		eventfd_signal(private->io_trigger, 1);
 
-	if (private->mdev)
-		private->state = VFIO_CCW_STATE_IDLE;
+	private->state = VFIO_CCW_STATE_IDLE;
 }
 
 /*
@@ -150,6 +151,7 @@ static int vfio_ccw_sch_remove(struct subchannel *sch)
 	struct vfio_ccw_private *private = dev_get_drvdata(&sch->dev);
 
 	vfio_ccw_sch_quiesce(sch);
+	private->state = VFIO_CCW_STATE_NOT_OPER;
 
 	vfio_ccw_mdev_unreg(sch);
 
@@ -163,7 +165,10 @@ static int vfio_ccw_sch_remove(struct subchannel *sch)
 
 static void vfio_ccw_sch_shutdown(struct subchannel *sch)
 {
+	struct vfio_ccw_private *private = dev_get_drvdata(&sch->dev);
+
 	vfio_ccw_sch_quiesce(sch);
+	private->state = VFIO_CCW_STATE_NOT_OPER;
 }
 
 /**
@@ -194,12 +199,18 @@ static int vfio_ccw_sch_event(struct subchannel *sch, int process)
 		rc = 0;
 		goto out_unlock;
 	}
-
+#if 0
+	/*
+	 * We must find a solution to report the change to the guest
+	 * until there I see no need to change the state of the SCH
+	 * here.
+	 */
 	private = dev_get_drvdata(&sch->dev);
 	if (private->state == VFIO_CCW_STATE_NOT_OPER) {
 		private->state = private->mdev ? VFIO_CCW_STATE_IDLE :
 				 VFIO_CCW_STATE_STANDBY;
 	}
+#endif
 	rc = 0;
 
 out_unlock:
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 87a8f8c..765afd7 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -36,6 +36,8 @@ static int vfio_ccw_mdev_reset(struct mdev_device *mdev)
 	ret = cio_enable_subchannel(sch, (u32)(unsigned long)sch);
 	if (!ret)
 		private->state = VFIO_CCW_STATE_IDLE;
+	else
+		private->state = VFIO_CCW_STATE_NOT_OPER;
 
 	return ret;
 }
@@ -111,14 +113,11 @@ static int vfio_ccw_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
 	struct vfio_ccw_private *private =
 		dev_get_drvdata(mdev_parent_dev(mdev));
 
-	if (private->state == VFIO_CCW_STATE_NOT_OPER)
-		return -ENODEV;
-
 	if (atomic_dec_if_positive(&private->avail) < 0)
 		return -EPERM;
 
 	private->mdev = mdev;
-	private->state = VFIO_CCW_STATE_IDLE;
+	private->state = VFIO_CCW_STATE_STANDBY;
 
 	return 0;
 }
@@ -129,11 +128,10 @@ static int vfio_ccw_mdev_remove(struct mdev_device *mdev)
 		dev_get_drvdata(mdev_parent_dev(mdev));
 
 	if ((private->state != VFIO_CCW_STATE_NOT_OPER) &&
-	    (private->state != VFIO_CCW_STATE_STANDBY)) {
-		if (!vfio_ccw_mdev_reset(mdev))
-			private->state = VFIO_CCW_STATE_STANDBY;
-		/* The state will be NOT_OPER on error. */
-	}
+	    (private->state != VFIO_CCW_STATE_STANDBY))
+		return -EPERM;
+
+	private->state = VFIO_CCW_STATE_NOT_OPER;
 
 	private->mdev = NULL;
 	atomic_inc(&private->avail);
@@ -160,7 +158,7 @@ static int vfio_ccw_mdev_open(struct mdev_device *mdev)
 	if (cio_enable_subchannel(sch, (u32)(unsigned long)sch))
 		goto error;
 
-	private->state = VFIO_CCW_STATE_STANDBY;
+	private->state = VFIO_CCW_STATE_IDLE;
 	spin_unlock_irq(sch->lock);
 	return 0;
 
@@ -177,6 +175,7 @@ static void vfio_ccw_mdev_release(struct mdev_device *mdev)
 		dev_get_drvdata(mdev_parent_dev(mdev));
 
 	vfio_ccw_sch_quiesce(private->sch);
+	private->state = VFIO_CCW_STATE_STANDBY;
 	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
 				 &private->nb);
 }
-- 
2.7.4
