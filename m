Return-Path: <linux-kernel-owner+w=401wt.eu-S964972AbXLTP0J@vger.kernel.org>
Message-Id: <20071220152105.364996161@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:19:36 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 11/47] cio: Use dev_{g,s}et_drvdata().
Content-Disposition: inline; filename=110-cio-drvdata.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Also define helpers sch_{g,s}et_cdev() to make the intention more
clear.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/ccwgroup.c   |   14 +++++++-------
 drivers/s390/cio/device.c     |   36 ++++++++++++++++++------------------
 drivers/s390/cio/device_fsm.c |   26 +++++++++++++-------------
 drivers/s390/cio/io_sch.h     |    2 ++
 4 files changed, 40 insertions(+), 38 deletions(-)

Index: quilt-2.6/drivers/s390/cio/ccwgroup.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/ccwgroup.c
+++ quilt-2.6/drivers/s390/cio/ccwgroup.c
@@ -111,7 +111,7 @@ ccwgroup_release (struct device *dev)
 	gdev = to_ccwgroupdev(dev);
 
 	for (i = 0; i < gdev->count; i++) {
-		gdev->cdev[i]->dev.driver_data = NULL;
+		dev_set_drvdata(&gdev->cdev[i]->dev, NULL);
 		put_device(&gdev->cdev[i]->dev);
 	}
 	kfree(gdev);
@@ -196,11 +196,11 @@ int ccwgroup_create(struct device *root,
 			goto error;
 		}
 		/* Don't allow a device to belong to more than one group. */
-		if (gdev->cdev[i]->dev.driver_data) {
+		if (dev_get_drvdata(&gdev->cdev[i]->dev)) {
 			rc = -EINVAL;
 			goto error;
 		}
-		gdev->cdev[i]->dev.driver_data = gdev;
+		dev_set_drvdata(&gdev->cdev[i]->dev, gdev);
 	}
 
 	gdev->creator_id = creator_id;
@@ -234,8 +234,8 @@ int ccwgroup_create(struct device *root,
 error:
 	for (i = 0; i < argc; i++)
 		if (gdev->cdev[i]) {
-			if (gdev->cdev[i]->dev.driver_data == gdev)
-				gdev->cdev[i]->dev.driver_data = NULL;
+			if (dev_get_drvdata(&gdev->cdev[i]->dev) == gdev)
+				dev_set_drvdata(&gdev->cdev[i]->dev, NULL);
 			put_device(&gdev->cdev[i]->dev);
 		}
 	mutex_unlock(&gdev->reg_mutex);
@@ -463,8 +463,8 @@ __ccwgroup_get_gdev_by_cdev(struct ccw_d
 {
 	struct ccwgroup_device *gdev;
 
-	if (cdev->dev.driver_data) {
-		gdev = (struct ccwgroup_device *)cdev->dev.driver_data;
+	gdev = dev_get_drvdata(&cdev->dev);
+	if (gdev) {
 		if (get_device(&gdev->dev)) {
 			mutex_lock(&gdev->reg_mutex);
 			if (device_is_registered(&gdev->dev))
Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c
+++ quilt-2.6/drivers/s390/cio/device.c
@@ -773,7 +773,7 @@ static void sch_attach_device(struct sub
 {
 	css_update_ssd_info(sch);
 	spin_lock_irq(sch->lock);
-	sch->dev.driver_data = cdev;
+	sch_set_cdev(sch, cdev);
 	cdev->private->schid = sch->schid;
 	cdev->ccwlock = sch->lock;
 	device_trigger_reprobe(sch);
@@ -795,7 +795,7 @@ static void sch_attach_disconnected_devi
 		put_device(&other_sch->dev);
 		return;
 	}
-	other_sch->dev.driver_data = NULL;
+	sch_set_cdev(other_sch, NULL);
 	/* No need to keep a subchannel without ccw device around. */
 	css_sch_device_unregister(other_sch);
 	put_device(&other_sch->dev);
@@ -831,12 +831,12 @@ static void sch_create_and_recog_new_dev
 		return;
 	}
 	spin_lock_irq(sch->lock);
-	sch->dev.driver_data = cdev;
+	sch_set_cdev(sch, cdev);
 	spin_unlock_irq(sch->lock);
 	/* Start recognition for the new ccw device. */
 	if (io_subchannel_recog(cdev, sch)) {
 		spin_lock_irq(sch->lock);
-		sch->dev.driver_data = NULL;
+		sch_set_cdev(sch, NULL);
 		spin_unlock_irq(sch->lock);
 		if (cdev->dev.release)
 			cdev->dev.release(&cdev->dev);
@@ -940,7 +940,7 @@ io_subchannel_register(struct work_struc
 			      cdev->private->dev_id.devno, ret);
 		put_device(&cdev->dev);
 		spin_lock_irqsave(sch->lock, flags);
-		sch->dev.driver_data = NULL;
+		sch_set_cdev(sch, NULL);
 		spin_unlock_irqrestore(sch->lock, flags);
 		kfree (cdev->private);
 		kfree (cdev);
@@ -1022,7 +1022,7 @@ io_subchannel_recog(struct ccw_device *c
 	int rc;
 	struct ccw_device_private *priv;
 
-	sch->dev.driver_data = cdev;
+	sch_set_cdev(sch, cdev);
 	sch->driver = &io_subchannel_driver;
 	cdev->ccwlock = sch->lock;
 
@@ -1082,7 +1082,7 @@ static void ccw_device_move_to_sch(struc
 	}
 	if (former_parent) {
 		spin_lock_irq(former_parent->lock);
-		former_parent->dev.driver_data = NULL;
+		sch_set_cdev(former_parent, NULL);
 		spin_unlock_irq(former_parent->lock);
 		css_sch_device_unregister(former_parent);
 		/* Reset intparm to zeroes. */
@@ -1100,7 +1100,7 @@ static void io_subchannel_irq(struct sub
 {
 	struct ccw_device *cdev;
 
-	cdev = sch->dev.driver_data;
+	cdev = sch_get_cdev(sch);
 
 	CIO_TRACE_EVENT(3, "IRQ");
 	CIO_TRACE_EVENT(3, sch->dev.bus_id);
@@ -1116,13 +1116,13 @@ io_subchannel_probe (struct subchannel *
 	unsigned long flags;
 	struct ccw_dev_id dev_id;
 
-	if (sch->dev.driver_data) {
+	cdev = sch_get_cdev(sch);
+	if (cdev) {
 		/*
 		 * This subchannel already has an associated ccw_device.
 		 * Register it and exit. This happens for all early
 		 * device, e.g. the console.
 		 */
-		cdev = sch->dev.driver_data;
 		cdev->dev.groups = ccwdev_attr_groups;
 		device_initialize(&cdev->dev);
 		ccw_device_register(cdev);
@@ -1173,7 +1173,7 @@ io_subchannel_probe (struct subchannel *
 	rc = io_subchannel_recog(cdev, sch);
 	if (rc) {
 		spin_lock_irqsave(sch->lock, flags);
-		sch->dev.driver_data = NULL;
+		sch_set_cdev(sch, NULL);
 		spin_unlock_irqrestore(sch->lock, flags);
 		if (cdev->dev.release)
 			cdev->dev.release(&cdev->dev);
@@ -1189,12 +1189,12 @@ io_subchannel_remove (struct subchannel 
 	struct ccw_device *cdev;
 	unsigned long flags;
 
-	if (!sch->dev.driver_data)
+	cdev = sch_get_cdev(sch);
+	if (!cdev)
 		return 0;
-	cdev = sch->dev.driver_data;
 	/* Set ccw device to not operational and drop reference. */
 	spin_lock_irqsave(cdev->ccwlock, flags);
-	sch->dev.driver_data = NULL;
+	sch_set_cdev(sch, NULL);
 	cdev->private->state = DEV_STATE_NOT_OPER;
 	spin_unlock_irqrestore(cdev->ccwlock, flags);
 	ccw_device_unregister(cdev);
@@ -1207,7 +1207,7 @@ static int io_subchannel_notify(struct s
 {
 	struct ccw_device *cdev;
 
-	cdev = sch->dev.driver_data;
+	cdev = sch_get_cdev(sch);
 	if (!cdev)
 		return 0;
 	if (!cdev->drv)
@@ -1221,7 +1221,7 @@ static void io_subchannel_verify(struct 
 {
 	struct ccw_device *cdev;
 
-	cdev = sch->dev.driver_data;
+	cdev = sch_get_cdev(sch);
 	if (cdev)
 		dev_fsm_event(cdev, DEV_EVENT_VERIFY);
 }
@@ -1230,7 +1230,7 @@ static void io_subchannel_ioterm(struct 
 {
 	struct ccw_device *cdev;
 
-	cdev = sch->dev.driver_data;
+	cdev = sch_get_cdev(sch);
 	if (!cdev)
 		return;
 	/* Internal I/O will be retried by the interrupt handler. */
@@ -1248,7 +1248,7 @@ io_subchannel_shutdown(struct subchannel
 	struct ccw_device *cdev;
 	int ret;
 
-	cdev = sch->dev.driver_data;
+	cdev = sch_get_cdev(sch);
 
 	if (cio_is_console(sch->schid))
 		return;
Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c
+++ quilt-2.6/drivers/s390/cio/device_fsm.c
@@ -32,9 +32,9 @@ device_is_online(struct subchannel *sch)
 {
 	struct ccw_device *cdev;
 
-	if (!sch->dev.driver_data)
+	cdev = sch_get_cdev(sch);
+	if (!cdev)
 		return 0;
-	cdev = sch->dev.driver_data;
 	return (cdev->private->state == DEV_STATE_ONLINE);
 }
 
@@ -43,9 +43,9 @@ device_is_disconnected(struct subchannel
 {
 	struct ccw_device *cdev;
 
-	if (!sch->dev.driver_data)
+	cdev = sch_get_cdev(sch);
+	if (!cdev)
 		return 0;
-	cdev = sch->dev.driver_data;
 	return (cdev->private->state == DEV_STATE_DISCONNECTED ||
 		cdev->private->state == DEV_STATE_DISCONNECTED_SENSE_ID);
 }
@@ -55,9 +55,9 @@ device_set_disconnected(struct subchanne
 {
 	struct ccw_device *cdev;
 
-	if (!sch->dev.driver_data)
+	cdev = sch_get_cdev(sch);
+	if (!cdev)
 		return;
-	cdev = sch->dev.driver_data;
 	ccw_device_set_timeout(cdev, 0);
 	cdev->private->flags.fake_irb = 0;
 	cdev->private->state = DEV_STATE_DISCONNECTED;
@@ -67,7 +67,7 @@ void device_set_intretry(struct subchann
 {
 	struct ccw_device *cdev;
 
-	cdev = sch->dev.driver_data;
+	cdev = sch_get_cdev(sch);
 	if (!cdev)
 		return;
 	cdev->private->flags.intretry = 1;
@@ -77,7 +77,7 @@ int device_trigger_verify(struct subchan
 {
 	struct ccw_device *cdev;
 
-	cdev = sch->dev.driver_data;
+	cdev = sch_get_cdev(sch);
 	if (!cdev || !cdev->online)
 		return -EINVAL;
 	dev_fsm_event(cdev, DEV_EVENT_VERIFY);
@@ -175,9 +175,9 @@ device_kill_pending_timer(struct subchan
 {
 	struct ccw_device *cdev;
 
-	if (!sch->dev.driver_data)
+	cdev = sch_get_cdev(sch);
+	if (!cdev)
 		return;
-	cdev = sch->dev.driver_data;
 	ccw_device_set_timeout(cdev, 0);
 }
 
@@ -992,7 +992,7 @@ void device_kill_io(struct subchannel *s
 	int ret;
 	struct ccw_device *cdev;
 
-	cdev = sch->dev.driver_data;
+	cdev = sch_get_cdev(sch);
 	ret = ccw_device_cancel_halt_clear(cdev);
 	if (ret == -EBUSY) {
 		ccw_device_set_timeout(cdev, 3*HZ);
@@ -1062,9 +1062,9 @@ device_trigger_reprobe(struct subchannel
 {
 	struct ccw_device *cdev;
 
-	if (!sch->dev.driver_data)
+	cdev = sch_get_cdev(sch);
+	if (!cdev)
 		return;
-	cdev = sch->dev.driver_data;
 	if (cdev->private->state != DEV_STATE_DISCONNECTED)
 		return;
 
Index: quilt-2.6/drivers/s390/cio/io_sch.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/io_sch.h
+++ quilt-2.6/drivers/s390/cio/io_sch.h
@@ -34,6 +34,8 @@ struct io_subchannel_private {
 } __attribute__ ((aligned(8)));
 
 #define to_io_private(n) ((struct io_subchannel_private *)n->private)
+#define sch_get_cdev(n) (dev_get_drvdata(&n->dev))
+#define sch_set_cdev(n, c) (dev_set_drvdata(&n->dev, c))
 
 #define MAX_CIWS 8
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
