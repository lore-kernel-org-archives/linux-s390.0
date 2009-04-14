Return-Path: <linux-kernel-owner+w=401wt.eu-S1756742AbZDNN40@vger.kernel.org>
Message-Id: <20090414135348.342129146@de.ibm.com>
References: <20090414135327.576111185@de.ibm.com>
Date: Tue, 14 Apr 2009 15:53:35 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 08/14] dasd: Use the new async framework for autoonlining.
Content-Disposition: inline; filename=008-dasd-auto-online.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Stefan Haberland <stefan.haberland@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

The dasd driver can automatically online detected dasds, which
especially important for finding the root device. Currently,
it will wait for each online operation to finish individually,
which may take long if many dasds need to be onlined. When using
the new async framework, these onlining operations can run in
parallel and presence of the root device is ensured by the fact
that prepare_namespace() waits for all async threads to finish.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Stefan Haberland <stefan.haberland@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd.c |   37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

Index: quilt-2.6/drivers/s390/block/dasd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd.c
+++ quilt-2.6/drivers/s390/block/dasd.c
@@ -20,6 +20,7 @@
 #include <linux/slab.h>
 #include <linux/buffer_head.h>
 #include <linux/hdreg.h>
+#include <linux/async.h>
 
 #include <asm/ccwdev.h>
 #include <asm/ebcdic.h>
@@ -480,8 +481,10 @@ static void dasd_change_state(struct das
         if (rc && rc != -EAGAIN)
                 device->target = device->state;
 
-	if (device->state == device->target)
+	if (device->state == device->target) {
 		wake_up(&dasd_init_waitq);
+		dasd_put_device(device);
+	}
 
 	/* let user-space know that the device status changed */
 	kobject_uevent(&device->cdev->dev.kobj, KOBJ_CHANGE);
@@ -513,12 +516,15 @@ void dasd_kick_device(struct dasd_device
  */
 void dasd_set_target_state(struct dasd_device *device, int target)
 {
+	dasd_get_device(device);
 	/* If we are in probeonly mode stop at DASD_STATE_READY. */
 	if (dasd_probeonly && target > DASD_STATE_READY)
 		target = DASD_STATE_READY;
 	if (device->target != target) {
-                if (device->state == target)
+		if (device->state == target) {
 			wake_up(&dasd_init_waitq);
+			dasd_put_device(device);
+		}
 		device->target = target;
 	}
 	if (device->state != device->target)
@@ -2148,6 +2154,22 @@ dasd_exit(void)
  * SECTION: common functions for ccw_driver use
  */
 
+static void dasd_generic_auto_online(void *data, async_cookie_t cookie)
+{
+	struct ccw_device *cdev = data;
+	int ret;
+
+	ret = ccw_device_set_online(cdev);
+	if (ret)
+		pr_warning("%s: Setting the DASD online failed with rc=%d\n",
+			   dev_name(&cdev->dev), ret);
+	else {
+		struct dasd_device *device = dasd_device_from_cdev(cdev);
+		wait_event(dasd_init_waitq, _wait_for_device(device));
+		dasd_put_device(device);
+	}
+}
+
 /*
  * Initial attempt at a probe function. this can be simplified once
  * the other detection code is gone.
@@ -2180,10 +2202,7 @@ int dasd_generic_probe(struct ccw_device
 	 */
 	if ((dasd_get_feature(cdev, DASD_FEATURE_INITIAL_ONLINE) > 0 ) ||
 	    (dasd_autodetect && dasd_busid_known(dev_name(&cdev->dev)) != 0))
-		ret = ccw_device_set_online(cdev);
-	if (ret)
-		pr_warning("%s: Setting the DASD online failed with rc=%d\n",
-		       dev_name(&cdev->dev), ret);
+		async_schedule(dasd_generic_auto_online, cdev);
 	return 0;
 }
 
@@ -2290,13 +2309,7 @@ int dasd_generic_set_online(struct ccw_d
 	} else
 		pr_debug("dasd_generic device %s found\n",
 				dev_name(&cdev->dev));
-
-	/* FIXME: we have to wait for the root device but we don't want
-	 * to wait for each single device but for all at once. */
-	wait_event(dasd_init_waitq, _wait_for_device(device));
-
 	dasd_put_device(device);
-
 	return rc;
 }
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
