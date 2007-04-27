Return-Path: <linux-kernel-owner+w=401wt.eu-S1755956AbXD0OPo@vger.kernel.org>
Message-Id: <20070427140515.044378349@de.ibm.com>
References: <20070427140503.087958775@de.ibm.com>
Date: Fri, 27 Apr 2007 16:05:17 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 14/38] cio: ccwgroup register vs. unregister.
Content-Disposition: inline; filename=112-cio-ccwgroup.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Introduce a mutex for struct ccwgroup to prevent simuntaneous
register/unregister on the same ccwgroup device.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/ccwgroup.c |   33 ++++++++++++++++++---------------
 include/asm-s390/ccwgroup.h |    1 +
 2 files changed, 19 insertions(+), 15 deletions(-)

Index: quilt-2.6/drivers/s390/cio/ccwgroup.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/ccwgroup.c	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/ccwgroup.c	2007-04-27 16:04:55.000000000 +0200
@@ -75,8 +75,10 @@
 {
 	struct ccwgroup_device *gdev = to_ccwgroupdev(dev);
 
+	mutex_lock(&gdev->reg_mutex);
 	__ccwgroup_remove_symlinks(gdev);
 	device_unregister(dev);
+	mutex_unlock(&gdev->reg_mutex);
 }
 
 static ssize_t
@@ -173,7 +175,8 @@
 		return -ENOMEM;
 
 	atomic_set(&gdev->onoff, 0);
-
+	mutex_init(&gdev->reg_mutex);
+	mutex_lock(&gdev->reg_mutex);
 	for (i = 0; i < argc; i++) {
 		gdev->cdev[i] = get_ccwdev_by_busid(cdrv, argv[i]);
 
@@ -183,12 +186,12 @@
 		    || gdev->cdev[i]->id.driver_info !=
 		    gdev->cdev[0]->id.driver_info) {
 			rc = -EINVAL;
-			goto free_dev;
+			goto error;
 		}
 		/* Don't allow a device to belong to more than one group. */
 		if (gdev->cdev[i]->dev.driver_data) {
 			rc = -EINVAL;
-			goto free_dev;
+			goto error;
 		}
 		gdev->cdev[i]->dev.driver_data = gdev;
 	}
@@ -203,9 +206,8 @@
 			gdev->cdev[0]->dev.bus_id);
 
 	rc = device_register(&gdev->dev);
-	
 	if (rc)
-		goto free_dev;
+		goto error;
 	get_device(&gdev->dev);
 	rc = device_create_file(&gdev->dev, &dev_attr_ungroup);
 
@@ -216,6 +218,7 @@
 
 	rc = __ccwgroup_create_symlinks(gdev);
 	if (!rc) {
+		mutex_unlock(&gdev->reg_mutex);
 		put_device(&gdev->dev);
 		return 0;
 	}
@@ -224,19 +227,12 @@
 error:
 	for (i = 0; i < argc; i++)
 		if (gdev->cdev[i]) {
-			put_device(&gdev->cdev[i]->dev);
-			gdev->cdev[i]->dev.driver_data = NULL;
-		}
-	put_device(&gdev->dev);
-	return rc;
-free_dev:
-	for (i = 0; i < argc; i++)
-		if (gdev->cdev[i]) {
 			if (gdev->cdev[i]->dev.driver_data == gdev)
 				gdev->cdev[i]->dev.driver_data = NULL;
 			put_device(&gdev->cdev[i]->dev);
 		}
-	kfree(gdev);
+	mutex_unlock(&gdev->reg_mutex);
+	put_device(&gdev->dev);
 	return rc;
 }
 
@@ -422,8 +418,12 @@
 	get_driver(&cdriver->driver);
 	while ((dev = driver_find_device(&cdriver->driver, NULL, NULL,
 					 __ccwgroup_match_all))) {
-		__ccwgroup_remove_symlinks(to_ccwgroupdev(dev));
+		struct ccwgroup_device *gdev = to_ccwgroupdev(dev);
+
+		mutex_lock(&gdev->reg_mutex);
+		__ccwgroup_remove_symlinks(gdev);
 		device_unregister(dev);
+		mutex_unlock(&gdev->reg_mutex);
 		put_device(dev);
 	}
 	put_driver(&cdriver->driver);
@@ -444,8 +444,10 @@
 	if (cdev->dev.driver_data) {
 		gdev = (struct ccwgroup_device *)cdev->dev.driver_data;
 		if (get_device(&gdev->dev)) {
+			mutex_lock(&gdev->reg_mutex);
 			if (device_is_registered(&gdev->dev))
 				return gdev;
+			mutex_unlock(&gdev->reg_mutex);
 			put_device(&gdev->dev);
 		}
 		return NULL;
@@ -465,6 +467,7 @@
 	if (gdev) {
 		__ccwgroup_remove_symlinks(gdev);
 		device_unregister(&gdev->dev);
+		mutex_unlock(&gdev->reg_mutex);
 		put_device(&gdev->dev);
 	}
 }
Index: quilt-2.6/include/asm-s390/ccwgroup.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/ccwgroup.h	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/include/asm-s390/ccwgroup.h	2007-04-27 16:04:55.000000000 +0200
@@ -11,6 +11,7 @@
 		CCWGROUP_ONLINE,
 	} state;
 	atomic_t onoff;
+	struct mutex reg_mutex;
 	unsigned int count;		/* number of attached slave devices */
 	struct device	dev;		/* master device		    */
 	struct ccw_device *cdev[0];	/* variable number, allocate as needed */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
