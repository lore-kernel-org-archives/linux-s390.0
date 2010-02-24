Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20100224084453.900936661@de.ibm.com>
Date: Wed, 24 Feb 2010 09:45:02 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 32/32] [PATCH] cio: trigger subchannel event at resume time
References: <20100224084430.193562869@de.ibm.com>
Content-Disposition: inline; filename=131-cio-subchannel-event.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Sebastian Ott <sebott@linux.vnet.ibm.com>

ccw_device_pm_restore: trigger subchannel event to better handle
changes to the subchannel device.

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/css.c    |    2 
 drivers/s390/cio/css.h    |    1 
 drivers/s390/cio/device.c |  111 +++++++++++++++++++++++++---------------------
 3 files changed, 63 insertions(+), 51 deletions(-)

Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c	2010-02-24 09:44:23.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/css.c	2010-02-24 09:44:29.000000000 +0100
@@ -1020,7 +1020,7 @@
 	return 0;
 }
 
-static inline int css_complete_work(void)
+int css_complete_work(void)
 {
 	int ret;
 
Index: quilt-2.6/drivers/s390/cio/css.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.h	2010-02-24 09:44:23.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/css.h	2010-02-24 09:44:29.000000000 +0100
@@ -146,6 +146,7 @@
 /* Helper functions to build lists for the slow path. */
 void css_schedule_eval(struct subchannel_id schid);
 void css_schedule_eval_all(void);
+int css_complete_work(void);
 
 int sch_is_pseudo_sch(struct subchannel *);
 struct schib;
Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c	2010-02-24 09:44:26.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device.c	2010-02-24 09:44:29.000000000 +0100
@@ -1400,6 +1400,12 @@
 		rc = 0;
 		goto out_unlock;
 	case IO_SCH_VERIFY:
+		if (cdev->private->flags.resuming == 1) {
+			if (cio_enable_subchannel(sch, (u32)(addr_t)sch)) {
+				ccw_device_set_notoper(cdev);
+				break;
+			}
+		}
 		/* Trigger path verification. */
 		io_subchannel_verify(sch);
 		rc = 0;
@@ -1438,7 +1444,8 @@
 		break;
 	case IO_SCH_UNREG_ATTACH:
 		/* Unregister ccw device. */
-		ccw_device_unregister(cdev);
+		if (!cdev->private->flags.resuming)
+			ccw_device_unregister(cdev);
 		break;
 	default:
 		break;
@@ -1447,7 +1454,8 @@
 	switch (action) {
 	case IO_SCH_ORPH_UNREG:
 	case IO_SCH_UNREG:
-		css_sch_device_unregister(sch);
+		if (!cdev || !cdev->private->flags.resuming)
+			css_sch_device_unregister(sch);
 		break;
 	case IO_SCH_ORPH_ATTACH:
 	case IO_SCH_UNREG_ATTACH:
@@ -1769,20 +1777,36 @@
 {
 	struct subchannel *sch = to_subchannel(cdev->dev.parent);
 
-	if (cio_is_console(sch->schid))
-		goto out;
+	spin_lock_irq(sch->lock);
+	if (cio_is_console(sch->schid)) {
+		cio_enable_subchannel(sch, (u32)(addr_t)sch);
+		goto out_unlock;
+	}
 	/*
 	 * While we were sleeping, devices may have gone or become
 	 * available again. Kick re-detection.
 	 */
-	spin_lock_irq(sch->lock);
 	cdev->private->flags.resuming = 1;
+	css_schedule_eval(sch->schid);
+	spin_unlock_irq(sch->lock);
+	css_complete_work();
+
+	/* cdev may have been moved to a different subchannel. */
+	sch = to_subchannel(cdev->dev.parent);
+	spin_lock_irq(sch->lock);
+	if (cdev->private->state != DEV_STATE_ONLINE &&
+	    cdev->private->state != DEV_STATE_OFFLINE)
+		goto out_unlock;
+
 	ccw_device_recognition(cdev);
 	spin_unlock_irq(sch->lock);
 	wait_event(cdev->private->wait_q, dev_fsm_final_state(cdev) ||
 		   cdev->private->state == DEV_STATE_DISCONNECTED);
-out:
+	spin_lock_irq(sch->lock);
+
+out_unlock:
 	cdev->private->flags.resuming = 0;
+	spin_unlock_irq(sch->lock);
 }
 
 static int resume_handle_boxed(struct ccw_device *cdev)
@@ -1806,40 +1830,31 @@
 static int ccw_device_pm_restore(struct device *dev)
 {
 	struct ccw_device *cdev = to_ccwdev(dev);
-	struct subchannel *sch = to_subchannel(cdev->dev.parent);
-	int ret = 0, cm_enabled;
+	struct subchannel *sch;
+	int ret = 0;
 
 	__ccw_device_pm_restore(cdev);
+	sch = to_subchannel(cdev->dev.parent);
 	spin_lock_irq(sch->lock);
-	if (cio_is_console(sch->schid)) {
-		cio_enable_subchannel(sch, (u32)(addr_t)sch);
-		spin_unlock_irq(sch->lock);
+	if (cio_is_console(sch->schid))
 		goto out_restore;
-	}
-	cdev->private->flags.donotify = 0;
+
 	/* check recognition results */
 	switch (cdev->private->state) {
 	case DEV_STATE_OFFLINE:
+	case DEV_STATE_ONLINE:
+		cdev->private->flags.donotify = 0;
 		break;
 	case DEV_STATE_BOXED:
 		ret = resume_handle_boxed(cdev);
-		spin_unlock_irq(sch->lock);
 		if (ret)
-			goto out;
+			goto out_unlock;
 		goto out_restore;
-	case DEV_STATE_DISCONNECTED:
-		goto out_disc_unlock;
 	default:
-		goto out_unreg_unlock;
-	}
-	/* check if the device id has changed */
-	if (sch->schib.pmcw.dev != cdev->private->dev_id.devno) {
-		CIO_MSG_EVENT(0, "resume: sch 0.%x.%04x: failed (devno "
-			      "changed from %04x to %04x)\n",
-			      sch->schid.ssid, sch->schid.sch_no,
-			      cdev->private->dev_id.devno,
-			      sch->schib.pmcw.dev);
-		goto out_unreg_unlock;
+		ret = resume_handle_disc(cdev);
+		if (ret)
+			goto out_unlock;
+		goto out_restore;
 	}
 	/* check if the device type has changed */
 	if (!ccw_device_test_sense_data(cdev)) {
@@ -1848,24 +1863,30 @@
 		ret = -ENODEV;
 		goto out_unlock;
 	}
-	if (!cdev->online) {
-		ret = 0;
+	if (!cdev->online)
 		goto out_unlock;
-	}
-	ret = ccw_device_online(cdev);
-	if (ret)
-		goto out_disc_unlock;
 
-	cm_enabled = cdev->private->cmb != NULL;
+	if (ccw_device_online(cdev)) {
+		ret = resume_handle_disc(cdev);
+		if (ret)
+			goto out_unlock;
+		goto out_restore;
+	}
 	spin_unlock_irq(sch->lock);
-
 	wait_event(cdev->private->wait_q, dev_fsm_final_state(cdev));
-	if (cdev->private->state != DEV_STATE_ONLINE) {
-		spin_lock_irq(sch->lock);
-		goto out_disc_unlock;
+	spin_lock_irq(sch->lock);
+
+	if (ccw_device_notify(cdev, CIO_OPER) == NOTIFY_BAD) {
+		ccw_device_sched_todo(cdev, CDEV_TODO_UNREG);
+		ret = -ENODEV;
+		goto out_unlock;
 	}
-	if (cm_enabled) {
+
+	/* reenable cmf, if needed */
+	if (cdev->private->cmb) {
+		spin_unlock_irq(sch->lock);
 		ret = ccw_set_cmf(cdev, 1);
+		spin_lock_irq(sch->lock);
 		if (ret) {
 			CIO_MSG_EVENT(2, "resume: cdev 0.%x.%04x: cmf failed "
 				      "(rc=%d)\n", cdev->private->dev_id.ssid,
@@ -1875,21 +1896,11 @@
 	}
 
 out_restore:
+	spin_unlock_irq(sch->lock);
 	if (cdev->online && cdev->drv && cdev->drv->restore)
 		ret = cdev->drv->restore(cdev);
-out:
 	return ret;
 
-out_disc_unlock:
-	ret = resume_handle_disc(cdev);
-	spin_unlock_irq(sch->lock);
-	if (ret)
-		return ret;
-	goto out_restore;
-
-out_unreg_unlock:
-	ccw_device_sched_todo(cdev, CDEV_TODO_UNREG_EVAL);
-	ret = -ENODEV;
 out_unlock:
 	spin_unlock_irq(sch->lock);
 	return ret;
