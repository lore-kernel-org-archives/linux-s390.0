Return-Path: <linux-kernel-owner+w=401wt.eu-S1759661AbXEaPfp@vger.kernel.org>
Message-Id: <20070531153437.855226654@de.ibm.com>
References: <20070531142024.011160634@de.ibm.com>
Date: Thu, 31 May 2007 16:20:30 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 6/7] cio: Use device_schedule_callback() for removing disconnected devices.
Content-Disposition: inline; filename=006-cio-disc.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

We can't deregister disconnected and orphaned devices directly from
the online attribute's store method, but must take a detour.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device.c |   49 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 11 deletions(-)

Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c
+++ quilt-2.6/drivers/s390/cio/device.c
@@ -296,30 +296,57 @@ static void ccw_device_unregister(struct
 		device_del(&cdev->dev);
 }
 
+static void ccw_device_remove_orphan_cb(struct device *dev)
+{
+	struct ccw_device *cdev = to_ccwdev(dev);
+
+	ccw_device_unregister(cdev);
+	put_device(&cdev->dev);
+}
+
+static void ccw_device_remove_sch_cb(struct device *dev)
+{
+	struct subchannel *sch;
+
+	sch = to_subchannel(dev);
+	css_sch_device_unregister(sch);
+	/* Reset intparm to zeroes. */
+	sch->schib.pmcw.intparm = 0;
+	cio_modify(sch);
+	put_device(&sch->dev);
+}
+
 static void
 ccw_device_remove_disconnected(struct ccw_device *cdev)
 {
-	struct subchannel *sch;
 	unsigned long flags;
+	int rc;
+
 	/*
 	 * Forced offline in disconnected state means
 	 * 'throw away device'.
 	 */
 	if (ccw_device_is_orphan(cdev)) {
-		/* Deregister ccw device. */
+		/*
+		 * Deregister ccw device.
+		 * Unfortunately, we cannot do this directly from the
+		 * attribute method.
+		 */
 		spin_lock_irqsave(cdev->ccwlock, flags);
 		cdev->private->state = DEV_STATE_NOT_OPER;
 		spin_unlock_irqrestore(cdev->ccwlock, flags);
-		ccw_device_unregister(cdev);
-		put_device(&cdev->dev);
-		return ;
+		rc = device_schedule_callback(&cdev->dev,
+					      ccw_device_remove_orphan_cb);
+		if (rc)
+			dev_info(&cdev->dev, "Couldn't unregister orphan\n");
+		return;
 	}
-	sch = to_subchannel(cdev->dev.parent);
-	css_sch_device_unregister(sch);
-	/* Reset intparm to zeroes. */
-	sch->schib.pmcw.intparm = 0;
-	cio_modify(sch);
-	put_device(&sch->dev);
+	/* Deregister subchannel, which will kill the ccw device. */
+	rc = device_schedule_callback(cdev->dev.parent,
+				      ccw_device_remove_sch_cb);
+	if (rc)
+		dev_info(&cdev->dev,
+			 "Couldn't unregister disconnected device\n");
 }
 
 int

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
