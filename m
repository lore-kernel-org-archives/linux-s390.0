Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20100224084453.481566618@de.ibm.com>
Date: Wed, 24 Feb 2010 09:45:00 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 30/32] [PATCH] dasd: fix refcounting.
References: <20100224084430.193562869@de.ibm.com>
Content-Disposition: inline; filename=129-dasd-refcounting.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Haberland <stefan.haberland@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Haberland <stefan.haberland@de.ibm.com>

The function dasd_device_from_cdev returns a reference to the dasd 
device and increases the refcount by one. If an exception occurs, 
the refcount was not decreased in all cases 
e.g. in dasd_discipline_show.
Prevent the offline processing from hang by correcting two functions
to decrease the refcount even if an error occured.

Signed-off-by: Stefan Haberland <stefan.haberland@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd.c        |   24 +++++++++++++++---------
 drivers/s390/block/dasd_devmap.c |   13 ++++++++++---
 2 files changed, 25 insertions(+), 12 deletions(-)

Index: quilt-2.6/drivers/s390/block/dasd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd.c	2010-02-24 09:44:27.000000000 +0100
+++ quilt-2.6/drivers/s390/block/dasd.c	2010-02-24 09:44:29.000000000 +0100
@@ -1003,12 +1003,20 @@
 		return;
 	}
 
-	device = (struct dasd_device *) cqr->startdev;
-	if (device == NULL ||
-	    device != dasd_device_from_cdev_locked(cdev) ||
-	    strncmp(device->discipline->ebcname, (char *) &cqr->magic, 4)) {
+	device = dasd_device_from_cdev_locked(cdev);
+	if (IS_ERR(device)) {
+		DBF_EVENT_DEVID(DBF_DEBUG, cdev, "%s",
+				"unable to get device from cdev");
+		return;
+	}
+
+	if (!cqr->startdev ||
+	    device != cqr->startdev ||
+	    strncmp(cqr->startdev->discipline->ebcname,
+		    (char *) &cqr->magic, 4)) {
 		DBF_EVENT_DEVID(DBF_DEBUG, cdev, "%s",
 				"invalid device in request");
+		dasd_put_device(device);
 		return;
 	}
 
@@ -2291,11 +2299,6 @@
 	if (ret)
 		pr_warning("%s: Setting the DASD online failed with rc=%d\n",
 			   dev_name(&cdev->dev), ret);
-	else {
-		struct dasd_device *device = dasd_device_from_cdev(cdev);
-		wait_event(dasd_init_waitq, _wait_for_device(device));
-		dasd_put_device(device);
-	}
 }
 
 /*
@@ -2430,6 +2433,9 @@
 	} else
 		pr_debug("dasd_generic device %s found\n",
 				dev_name(&cdev->dev));
+
+	wait_event(dasd_init_waitq, _wait_for_device(device));
+
 	dasd_put_device(device);
 	return rc;
 }
Index: quilt-2.6/drivers/s390/block/dasd_devmap.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_devmap.c	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/drivers/s390/block/dasd_devmap.c	2010-02-24 09:44:29.000000000 +0100
@@ -874,12 +874,19 @@
 	ssize_t len;
 
 	device = dasd_device_from_cdev(to_ccwdev(dev));
-	if (!IS_ERR(device) && device->discipline) {
+	if (IS_ERR(device))
+		goto out;
+	else if (!device->discipline) {
+		dasd_put_device(device);
+		goto out;
+	} else {
 		len = snprintf(buf, PAGE_SIZE, "%s\n",
 			       device->discipline->name);
 		dasd_put_device(device);
-	} else
-		len = snprintf(buf, PAGE_SIZE, "none\n");
+		return len;
+	}
+out:
+	len = snprintf(buf, PAGE_SIZE, "none\n");
 	return len;
 }
 
