Return-Path: <linux-kernel-owner+w=401wt.eu-S1754534AbYJAI53@vger.kernel.org>
Message-Id: <20081001084125.761931444@de.ibm.com>
References: <20081001083317.782967473@de.ibm.com>
Date: Wed, 01 Oct 2008 10:33:19 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 02/21] cio: move device unregistration to dedicated work queue
Content-Disposition: inline; filename=101-cio-unreg-work.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Use dedicated slow path work queue when unregistering a device due to
a user action. This ensures serialialization of other register/
unregister requests.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device.c |   56 ++++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 31 deletions(-)

Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c
+++ quilt-2.6/drivers/s390/cio/device.c
@@ -296,36 +296,33 @@ static void ccw_device_unregister(struct
 		device_del(&cdev->dev);
 }
 
-static void ccw_device_remove_orphan_cb(struct device *dev)
+static void ccw_device_remove_orphan_cb(struct work_struct *work)
 {
-	struct ccw_device *cdev = to_ccwdev(dev);
+	struct ccw_device_private *priv;
+	struct ccw_device *cdev;
 
+	priv = container_of(work, struct ccw_device_private, kick_work);
+	cdev = priv->cdev;
 	ccw_device_unregister(cdev);
 	put_device(&cdev->dev);
+	/* Release cdev reference for workqueue processing. */
+	put_device(&cdev->dev);
 }
 
-static void ccw_device_remove_sch_cb(struct device *dev)
-{
-	struct subchannel *sch;
-
-	sch = to_subchannel(dev);
-	css_sch_device_unregister(sch);
-	/* Reset intparm to zeroes. */
-	sch->schib.pmcw.intparm = 0;
-	cio_modify(sch);
-	put_device(&sch->dev);
-}
+static void ccw_device_call_sch_unregister(struct work_struct *work);
 
 static void
 ccw_device_remove_disconnected(struct ccw_device *cdev)
 {
 	unsigned long flags;
-	int rc;
 
 	/*
 	 * Forced offline in disconnected state means
 	 * 'throw away device'.
 	 */
+	/* Get cdev reference for workqueue processing. */
+	if (!get_device(&cdev->dev))
+		return;
 	if (ccw_device_is_orphan(cdev)) {
 		/*
 		 * Deregister ccw device.
@@ -335,23 +332,13 @@ ccw_device_remove_disconnected(struct cc
 		spin_lock_irqsave(cdev->ccwlock, flags);
 		cdev->private->state = DEV_STATE_NOT_OPER;
 		spin_unlock_irqrestore(cdev->ccwlock, flags);
-		rc = device_schedule_callback(&cdev->dev,
-					      ccw_device_remove_orphan_cb);
-		if (rc)
-			CIO_MSG_EVENT(0, "Couldn't unregister orphan "
-				      "0.%x.%04x\n",
-				      cdev->private->dev_id.ssid,
-				      cdev->private->dev_id.devno);
-		return;
-	}
-	/* Deregister subchannel, which will kill the ccw device. */
-	rc = device_schedule_callback(cdev->dev.parent,
-				      ccw_device_remove_sch_cb);
-	if (rc)
-		CIO_MSG_EVENT(0, "Couldn't unregister disconnected device "
-			      "0.%x.%04x\n",
-			      cdev->private->dev_id.ssid,
-			      cdev->private->dev_id.devno);
+		PREPARE_WORK(&cdev->private->kick_work,
+				ccw_device_remove_orphan_cb);
+	} else
+		/* Deregister subchannel, which will kill the ccw device. */
+		PREPARE_WORK(&cdev->private->kick_work,
+				ccw_device_call_sch_unregister);
+	queue_work(slow_path_wq, &cdev->private->kick_work);
 }
 
 /**
@@ -970,12 +957,17 @@ static void ccw_device_call_sch_unregist
 
 	priv = container_of(work, struct ccw_device_private, kick_work);
 	cdev = priv->cdev;
+	/* Get subchannel reference for local processing. */
+	if (!get_device(cdev->dev.parent))
+		return;
 	sch = to_subchannel(cdev->dev.parent);
 	css_sch_device_unregister(sch);
 	/* Reset intparm to zeroes. */
 	sch->schib.pmcw.intparm = 0;
 	cio_modify(sch);
+	/* Release cdev reference for workqueue processing.*/
 	put_device(&cdev->dev);
+	/* Release subchannel reference for local processing. */
 	put_device(&sch->dev);
 }
 
@@ -1001,6 +993,8 @@ io_subchannel_recog_done(struct ccw_devi
 		PREPARE_WORK(&cdev->private->kick_work,
 			     ccw_device_call_sch_unregister);
 		queue_work(slow_path_wq, &cdev->private->kick_work);
+		/* Release subchannel reference for asynchronous recognition. */
+		put_device(&sch->dev);
 		if (atomic_dec_and_test(&ccw_device_init_count))
 			wake_up(&ccw_device_init_wq);
 		break;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
