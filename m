Return-Path: <linux-kernel-owner+w=401wt.eu-S1756523AbZKMPKo@vger.kernel.org>
Message-Id: <20091113150917.146610745@de.ibm.com>
Date: Fri, 13 Nov 2009 16:09:08 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 44/52] [PATCH] cio: remove registered flag from ccw_device_private
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=143-cio-rm-registered-flag.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Sebastian Ott <sebott@linux.vnet.ibm.com>

We used to maintain a "registered" flag in our ccw_device_private
structure. This patch removes the "registered" flag and converts
all users of it to device_is_registered which has the exact same
meaning.

Note: The usage the atomic operation test_and_clear_bit is replaced
by the non-atomic if (device_is_registered()) device_del(). This
will not do harm, since we serialize calls to ccw_device_unregister
with a single-threaded workqueue.

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device.c |   11 +++--------
 drivers/s390/cio/io_sch.h |    1 -
 2 files changed, 3 insertions(+), 9 deletions(-)

Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c	2009-11-13 16:08:20.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device.c	2009-11-13 16:08:21.000000000 +0100
@@ -303,7 +303,7 @@
 
 static void ccw_device_unregister(struct ccw_device *cdev)
 {
-	if (test_and_clear_bit(1, &cdev->private->registered)) {
+	if (device_is_registered(&cdev->dev)) {
 		device_del(&cdev->dev);
 		/* Release reference from device_initialize(). */
 		put_device(&cdev->dev);
@@ -640,12 +640,7 @@
 			   cdev->private->dev_id.devno);
 	if (ret)
 		return ret;
-	ret = device_add(dev);
-	if (ret)
-		return ret;
-
-	set_bit(1, &cdev->private->registered);
-	return ret;
+	return device_add(dev);
 }
 
 static int match_dev_id(struct device *dev, void *data)
@@ -669,7 +664,7 @@
 {
 	int ret;
 
-	if (test_bit(1, &cdev->private->registered)) {
+	if (device_is_registered(&cdev->dev)) {
 		device_release_driver(&cdev->dev);
 		ret = device_attach(&cdev->dev);
 		WARN_ON(ret == -ENODEV);
Index: quilt-2.6/drivers/s390/cio/io_sch.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/io_sch.h	2009-11-13 16:08:21.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/io_sch.h	2009-11-13 16:08:21.000000000 +0100
@@ -145,7 +145,6 @@
 	struct subchannel *sch;
 	int state;		/* device state */
 	atomic_t onoff;
-	unsigned long registered;
 	struct ccw_dev_id dev_id;	/* device id */
 	struct subchannel_id schid;	/* subchannel number */
 	struct ccw_request req;		/* internal I/O request */
