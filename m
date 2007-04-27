Return-Path: <linux-kernel-owner+w=401wt.eu-S1755912AbXD0OPv@vger.kernel.org>
Message-Id: <20070427140515.510114415@de.ibm.com>
References: <20070427140503.087958775@de.ibm.com>
Date: Fri, 27 Apr 2007 16:05:19 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 16/38] cio: Unregister ccw devices directly.
Content-Disposition: inline; filename=114-cio-unreg.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

We used to unregister ccw devices not directly from the I/O
subchannel remove function in order to avoid lifelocks on the
css bus semaphore. This semaphore is gone, and there is no reason
to not unregister the ccw device directly (it is even better since
it is more in keeping with the goal of immediate disconnect).

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device.c |   56 +++++++++-------------------------------------
 1 files changed, 12 insertions(+), 44 deletions(-)

Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c	2007-04-27 16:04:55.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/device.c	2007-04-27 16:04:56.000000000 +0200
@@ -290,16 +290,10 @@
 	return sch_is_pseudo_sch(to_subchannel(cdev->dev.parent));
 }
 
-static void ccw_device_unregister(struct work_struct *work)
+static void ccw_device_unregister(struct ccw_device *cdev)
 {
-	struct ccw_device_private *priv;
-	struct ccw_device *cdev;
-
-	priv = container_of(work, struct ccw_device_private, kick_work);
-	cdev = priv->cdev;
 	if (test_and_clear_bit(1, &cdev->private->registered))
-		device_unregister(&cdev->dev);
-	put_device(&cdev->dev);
+		device_del(&cdev->dev);
 }
 
 static void
@@ -316,11 +310,8 @@
 		spin_lock_irqsave(cdev->ccwlock, flags);
 		cdev->private->state = DEV_STATE_NOT_OPER;
 		spin_unlock_irqrestore(cdev->ccwlock, flags);
-		if (get_device(&cdev->dev)) {
-			PREPARE_WORK(&cdev->private->kick_work,
-				     ccw_device_unregister);
-			queue_work(ccw_device_work, &cdev->private->kick_work);
-		}
+		ccw_device_unregister(cdev);
+		put_device(&cdev->dev);
 		return ;
 	}
 	sch = to_subchannel(cdev->dev.parent);
@@ -555,17 +546,10 @@
 	.attrs = ccwdev_attrs,
 };
 
-static int
-device_add_files (struct device *dev)
-{
-	return sysfs_create_group(&dev->kobj, &ccwdev_attr_group);
-}
-
-static void
-device_remove_files(struct device *dev)
-{
-	sysfs_remove_group(&dev->kobj, &ccwdev_attr_group);
-}
+struct attribute_group *ccwdev_attr_groups[] = {
+	&ccwdev_attr_group,
+	NULL,
+};
 
 /* this is a simple abstraction for device_register that sets the
  * correct bus type and adds the bus specific files */
@@ -580,10 +564,6 @@
 		return ret;
 
 	set_bit(1, &cdev->private->registered);
-	if ((ret = device_add_files(dev))) {
-		if (test_and_clear_bit(1, &cdev->private->registered))
-			device_del(dev);
-	}
 	return ret;
 }
 
@@ -655,10 +635,6 @@
 		return;
 	}
 	set_bit(1, &cdev->private->registered);
-	if (device_add_files(&cdev->dev)) {
-		if (test_and_clear_bit(1, &cdev->private->registered))
-			device_unregister(&cdev->dev);
-	}
 }
 
 void ccw_device_do_unreg_rereg(struct work_struct *work)
@@ -671,9 +647,7 @@
 	cdev = priv->cdev;
 	sch = to_subchannel(cdev->dev.parent);
 
-	device_remove_files(&cdev->dev);
-	if (test_and_clear_bit(1, &cdev->private->registered))
-		device_del(&cdev->dev);
+	ccw_device_unregister(cdev);
 	PREPARE_WORK(&cdev->private->kick_work,
 		     ccw_device_add_changed);
 	queue_work(ccw_device_work, &cdev->private->kick_work);
@@ -712,6 +686,7 @@
 	cdev->dev.parent = &sch->dev;
 	cdev->dev.release = ccw_device_release;
 	INIT_LIST_HEAD(&cdev->private->kick_work.entry);
+	cdev->dev.groups = ccwdev_attr_groups;
 	/* Do first half of device_register. */
 	device_initialize(&cdev->dev);
 	if (!get_device(&sch->dev)) {
@@ -1141,15 +1116,8 @@
 	sch->dev.driver_data = NULL;
 	cdev->private->state = DEV_STATE_NOT_OPER;
 	spin_unlock_irqrestore(cdev->ccwlock, flags);
-	/*
-	 * Put unregistration on workqueue to avoid livelocks on the css bus
-	 * semaphore.
-	 */
-	if (get_device(&cdev->dev)) {
-		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_unregister);
-		queue_work(ccw_device_work, &cdev->private->kick_work);
-	}
+	ccw_device_unregister(cdev);
+	put_device(&cdev->dev);
 	return 0;
 }
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
