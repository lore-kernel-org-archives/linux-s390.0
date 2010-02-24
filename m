Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20100224084451.956294578@de.ibm.com>
Date: Wed, 24 Feb 2010 09:44:53 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 23/32] [PATCH] dasd: fix online/offline race
References: <20100224084430.193562869@de.ibm.com>
Content-Disposition: inline; filename=122-dasd-onoff-race.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Haberland <stefan.haberland@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Haberland <stefan.haberland@de.ibm.com>

Setting a DASD online and offline in quick succession may cause
a kernel panic or let the chhccwdev command wait forever. 
The Online process is split into two parts. After the first part
is finished the offline process may be called. This may result
in a situation where the second online processing part tries to
set the DASD offline as well.
Use a mutex to protect online and offline against each other.
Also correct some checking.

Signed-off-by: Stefan Haberland <stefan.haberland@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd.c       |   22 ++++++++++++++--------
 drivers/s390/block/dasd_genhd.c |    1 +
 drivers/s390/block/dasd_int.h   |    1 +
 3 files changed, 16 insertions(+), 8 deletions(-)

Index: quilt-2.6/drivers/s390/block/dasd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd.c	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/drivers/s390/block/dasd.c	2010-02-24 09:44:27.000000000 +0100
@@ -20,6 +20,7 @@
 #include <linux/buffer_head.h>
 #include <linux/hdreg.h>
 #include <linux/async.h>
+#include <linux/mutex.h>
 
 #include <asm/ccwdev.h>
 #include <asm/ebcdic.h>
@@ -112,6 +113,7 @@
 	INIT_WORK(&device->restore_device, do_restore_device);
 	device->state = DASD_STATE_NEW;
 	device->target = DASD_STATE_NEW;
+	mutex_init(&device->state_mutex);
 
 	return device;
 }
@@ -484,10 +486,8 @@
 	if (rc)
 		device->target = device->state;
 
-	if (device->state == device->target) {
+	if (device->state == device->target)
 		wake_up(&dasd_init_waitq);
-		dasd_put_device(device);
-	}
 
 	/* let user-space know that the device status changed */
 	kobject_uevent(&device->cdev->dev.kobj, KOBJ_CHANGE);
@@ -502,7 +502,9 @@
 static void do_kick_device(struct work_struct *work)
 {
 	struct dasd_device *device = container_of(work, struct dasd_device, kick_work);
+	mutex_lock(&device->state_mutex);
 	dasd_change_state(device);
+	mutex_unlock(&device->state_mutex);
 	dasd_schedule_device_bh(device);
 	dasd_put_device(device);
 }
@@ -539,18 +541,19 @@
 void dasd_set_target_state(struct dasd_device *device, int target)
 {
 	dasd_get_device(device);
+	mutex_lock(&device->state_mutex);
 	/* If we are in probeonly mode stop at DASD_STATE_READY. */
 	if (dasd_probeonly && target > DASD_STATE_READY)
 		target = DASD_STATE_READY;
 	if (device->target != target) {
-		if (device->state == target) {
+		if (device->state == target)
 			wake_up(&dasd_init_waitq);
-			dasd_put_device(device);
-		}
 		device->target = target;
 	}
 	if (device->state != device->target)
 		dasd_change_state(device);
+	mutex_unlock(&device->state_mutex);
+	dasd_put_device(device);
 }
 
 /*
@@ -1692,7 +1695,6 @@
 				cqr, rc);
 		} else {
 			cqr->stopclk = get_clock();
-			rc = 1;
 		}
 		break;
 	default: /* already finished or clear pending - do nothing */
@@ -2170,9 +2172,13 @@
 static int dasd_open(struct block_device *bdev, fmode_t mode)
 {
 	struct dasd_block *block = bdev->bd_disk->private_data;
-	struct dasd_device *base = block->base;
+	struct dasd_device *base;
 	int rc;
 
+	if (!block)
+		return -ENODEV;
+
+	base = block->base;
 	atomic_inc(&block->open_count);
 	if (test_bit(DASD_FLAG_OFFLINE, &base->flags)) {
 		rc = -ENODEV;
Index: quilt-2.6/drivers/s390/block/dasd_genhd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_genhd.c	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/drivers/s390/block/dasd_genhd.c	2010-02-24 09:44:27.000000000 +0100
@@ -88,6 +88,7 @@
 	if (block->gdp) {
 		del_gendisk(block->gdp);
 		block->gdp->queue = NULL;
+		block->gdp->private_data = NULL;
 		put_disk(block->gdp);
 		block->gdp = NULL;
 	}
Index: quilt-2.6/drivers/s390/block/dasd_int.h
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_int.h	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/drivers/s390/block/dasd_int.h	2010-02-24 09:44:27.000000000 +0100
@@ -368,6 +368,7 @@
 
 	/* Device state and target state. */
 	int state, target;
+	struct mutex state_mutex;
 	int stopped;		/* device (ccw_device_start) was stopped */
 
 	/* reference count. */
