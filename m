Return-Path: <linux-kernel-owner+w=401wt.eu-S932378AbZBYPZA@vger.kernel.org>
Message-Id: <20090225150833.942681562@de.ibm.com>
References: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:06:46 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 24/46] cio: Use unbind/bind instead of unregister/register.
Content-Disposition: inline; filename=123-cio-dev-bind.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

The common I/O layer may encounter a situation where the
device number of a ccw device has changed or a device
driver doesn't want to keep a formerly disconnected device
becoming operational again. Instead of using device_del()/
device_add() as now, we can just unbind the driver from the
device and rebind it to get the desired effect (rebinding)
with less overhead.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device.c     |   27 +++++++--------------------
 drivers/s390/cio/device.h     |    2 +-
 drivers/s390/cio/device_fsm.c |    4 ++--
 3 files changed, 10 insertions(+), 23 deletions(-)

Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c
+++ quilt-2.6/drivers/s390/cio/device.c
@@ -681,35 +681,22 @@ get_orphaned_ccwdev_by_dev_id(struct cha
 	return dev ? to_ccwdev(dev) : NULL;
 }
 
-static void
-ccw_device_add_changed(struct work_struct *work)
-{
-	struct ccw_device_private *priv;
-	struct ccw_device *cdev;
-
-	priv = container_of(work, struct ccw_device_private, kick_work);
-	cdev = priv->cdev;
-	if (device_add(&cdev->dev)) {
-		put_device(&cdev->dev);
-		return;
-	}
-	set_bit(1, &cdev->private->registered);
-}
-
-void ccw_device_do_unreg_rereg(struct work_struct *work)
+void ccw_device_do_unbind_bind(struct work_struct *work)
 {
 	struct ccw_device_private *priv;
 	struct ccw_device *cdev;
 	struct subchannel *sch;
+	int ret;
 
 	priv = container_of(work, struct ccw_device_private, kick_work);
 	cdev = priv->cdev;
 	sch = to_subchannel(cdev->dev.parent);
 
-	ccw_device_unregister(cdev);
-	PREPARE_WORK(&cdev->private->kick_work,
-		     ccw_device_add_changed);
-	queue_work(ccw_device_work, &cdev->private->kick_work);
+	if (test_bit(1, &cdev->private->registered)) {
+		device_release_driver(&cdev->dev);
+		ret = device_attach(&cdev->dev);
+		WARN_ON(ret == -ENODEV);
+	}
 }
 
 static void
Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c
+++ quilt-2.6/drivers/s390/cio/device_fsm.c
@@ -194,7 +194,7 @@ ccw_device_handle_oper(struct ccw_device
 	    cdev->id.dev_type != cdev->private->senseid.dev_type ||
 	    cdev->id.dev_model != cdev->private->senseid.dev_model) {
 		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_do_unreg_rereg);
+			     ccw_device_do_unbind_bind);
 		queue_work(ccw_device_work, &cdev->private->kick_work);
 		return 0;
 	}
@@ -366,7 +366,7 @@ static void ccw_device_oper_notify(struc
 	}
 	/* Driver doesn't want device back. */
 	ccw_device_set_notoper(cdev);
-	PREPARE_WORK(&cdev->private->kick_work, ccw_device_do_unreg_rereg);
+	PREPARE_WORK(&cdev->private->kick_work, ccw_device_do_unbind_bind);
 	queue_work(ccw_device_work, &cdev->private->kick_work);
 }
 
Index: quilt-2.6/drivers/s390/cio/device.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.h
+++ quilt-2.6/drivers/s390/cio/device.h
@@ -80,7 +80,7 @@ void io_subchannel_init_config(struct su
 
 int ccw_device_cancel_halt_clear(struct ccw_device *);
 
-void ccw_device_do_unreg_rereg(struct work_struct *);
+void ccw_device_do_unbind_bind(struct work_struct *);
 void ccw_device_move_to_orphanage(struct work_struct *);
 int ccw_device_is_orphan(struct ccw_device *);
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
