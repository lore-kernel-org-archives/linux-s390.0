Return-Path: <linux-kernel-owner+w=401wt.eu-S1757026AbZKMPNc@vger.kernel.org>
Message-Id: <20091113150915.032308301@de.ibm.com>
Date: Fri, 13 Nov 2009 16:08:56 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 32/52] [PATCH] cio: handle error during device recognition consistently
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=131-cio-error-reporting.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Remove the return code from ccw_device_recognition and handle
recognition errors through the existing callback
ccw_device_recog_done to reduce cleanup code duplication.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device.c     |   57 +++++-------------------------------------
 drivers/s390/cio/device.h     |    2 -
 drivers/s390/cio/device_fsm.c |   20 ++++----------
 3 files changed, 15 insertions(+), 64 deletions(-)

Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c	2009-11-13 16:08:18.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device.c	2009-11-13 16:08:18.000000000 +0100
@@ -486,18 +486,9 @@
 
 static int online_store_recog_and_online(struct ccw_device *cdev)
 {
-	int ret;
-
 	/* Do device recognition, if needed. */
 	if (cdev->private->state == DEV_STATE_BOXED) {
-		ret = ccw_device_recognition(cdev);
-		if (ret) {
-			CIO_MSG_EVENT(0, "Couldn't start recognition "
-				      "for device 0.%x.%04x (ret=%d)\n",
-				      cdev->private->dev_id.ssid,
-				      cdev->private->dev_id.devno, ret);
-			return ret;
-		}
+		ccw_device_recognition(cdev);
 		wait_event(cdev->private->wait_q,
 			   cdev->private->flags.recog_done);
 		if (cdev->private->state != DEV_STATE_OFFLINE)
@@ -746,7 +737,7 @@
 	return cdev;
 }
 
-static int io_subchannel_recog(struct ccw_device *, struct subchannel *);
+static void io_subchannel_recog(struct ccw_device *, struct subchannel *);
 
 static void sch_create_and_recog_new_device(struct subchannel *sch)
 {
@@ -760,16 +751,7 @@
 		return;
 	}
 	/* Start recognition for the new ccw device. */
-	if (io_subchannel_recog(cdev, sch)) {
-		spin_lock_irq(sch->lock);
-		sch_set_cdev(sch, NULL);
-		spin_unlock_irq(sch->lock);
-		css_sch_device_unregister(sch);
-		/* Put reference from io_subchannel_create_ccwdev(). */
-		put_device(&sch->dev);
-		/* Give up initial reference. */
-		put_device(&cdev->dev);
-	}
+	io_subchannel_recog(cdev, sch);
 }
 
 /*
@@ -879,10 +861,8 @@
 	}
 }
 
-static int
-io_subchannel_recog(struct ccw_device *cdev, struct subchannel *sch)
+static void io_subchannel_recog(struct ccw_device *cdev, struct subchannel *sch)
 {
-	int rc;
 	struct ccw_device_private *priv;
 
 	cdev->ccwlock = sch->lock;
@@ -903,13 +883,8 @@
 	/* Start async. device sensing. */
 	spin_lock_irq(sch->lock);
 	sch_set_cdev(sch, cdev);
-	rc = ccw_device_recognition(cdev);
+	ccw_device_recognition(cdev);
 	spin_unlock_irq(sch->lock);
-	if (rc) {
-		if (atomic_dec_and_test(&ccw_device_init_count))
-			wake_up(&ccw_device_init_wq);
-	}
-	return rc;
 }
 
 static int ccw_device_move_to_sch(struct ccw_device *cdev,
@@ -1528,10 +1503,7 @@
 	sch->driver = &io_subchannel_driver;
 	/* Initialize the ccw_device structure. */
 	cdev->dev.parent= &sch->dev;
-	rc = io_subchannel_recog(cdev, sch);
-	if (rc)
-		return rc;
-
+	io_subchannel_recog(cdev, sch);
 	/* Now wait for the async. recognition to come to an end. */
 	spin_lock_irq(cdev->ccwlock);
 	while (!dev_fsm_final_state(cdev))
@@ -1547,7 +1519,7 @@
 	rc = 0;
 out_unlock:
 	spin_unlock_irq(cdev->ccwlock);
-	return 0;
+	return rc;
 }
 
 struct ccw_device *
@@ -1789,7 +1761,6 @@
 static void __ccw_device_pm_restore(struct ccw_device *cdev)
 {
 	struct subchannel *sch = to_subchannel(cdev->dev.parent);
-	int ret;
 
 	if (cio_is_console(sch->schid))
 		goto out;
@@ -1799,22 +1770,10 @@
 	 */
 	spin_lock_irq(sch->lock);
 	cdev->private->flags.resuming = 1;
-	ret = ccw_device_recognition(cdev);
+	ccw_device_recognition(cdev);
 	spin_unlock_irq(sch->lock);
-	if (ret) {
-		CIO_MSG_EVENT(0, "Couldn't start recognition for device "
-			      "0.%x.%04x (ret=%d)\n",
-			      cdev->private->dev_id.ssid,
-			      cdev->private->dev_id.devno, ret);
-		spin_lock_irq(sch->lock);
-		cdev->private->state = DEV_STATE_DISCONNECTED;
-		spin_unlock_irq(sch->lock);
-		/* notify driver after the resume cb */
-		goto out;
-	}
 	wait_event(cdev->private->wait_q, dev_fsm_final_state(cdev) ||
 		   cdev->private->state == DEV_STATE_DISCONNECTED);
-
 out:
 	cdev->private->flags.resuming = 0;
 }
Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c	2009-11-13 16:08:18.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device_fsm.c	2009-11-13 16:08:18.000000000 +0100
@@ -498,20 +498,9 @@
 /*
  * Start device recognition.
  */
-int
-ccw_device_recognition(struct ccw_device *cdev)
+void ccw_device_recognition(struct ccw_device *cdev)
 {
-	struct subchannel *sch;
-	int ret;
-
-	sch = to_subchannel(cdev->dev.parent);
-	ret = cio_enable_subchannel(sch, (u32)(addr_t)sch);
-	if (ret != 0)
-		/* Couldn't enable the subchannel for i/o. Sick device. */
-		return ret;
-
-	/* After 60s the device recognition is considered to have failed. */
-	ccw_device_set_timeout(cdev, 60*HZ);
+	struct subchannel *sch = to_subchannel(cdev->dev.parent);
 
 	/*
 	 * We used to start here with a sense pgid to find out whether a device
@@ -523,8 +512,11 @@
 	 */
 	cdev->private->flags.recog_done = 0;
 	cdev->private->state = DEV_STATE_SENSE_ID;
+	if (cio_enable_subchannel(sch, (u32) (addr_t) sch)) {
+		ccw_device_recog_done(cdev, DEV_STATE_NOT_OPER);
+		return;
+	}
 	ccw_device_sense_id_start(cdev);
-	return 0;
 }
 
 /*
Index: quilt-2.6/drivers/s390/cio/device.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.h	2009-11-13 16:08:18.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device.h	2009-11-13 16:08:18.000000000 +0100
@@ -83,7 +83,7 @@
 
 int ccw_device_is_orphan(struct ccw_device *);
 
-int ccw_device_recognition(struct ccw_device *);
+void ccw_device_recognition(struct ccw_device *);
 int ccw_device_online(struct ccw_device *);
 int ccw_device_offline(struct ccw_device *);
 void ccw_device_update_sense_data(struct ccw_device *);
