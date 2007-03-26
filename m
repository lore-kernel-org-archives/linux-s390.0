Return-Path: <linux-kernel-owner+w=401wt.eu-S1753180AbXCZUyk@vger.kernel.org>
Message-Id: <20070326205253.047933294@de.ibm.com>
References: <20070326205225.438154546@de.ibm.com>
Date: Mon, 26 Mar 2007 22:52:30 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [patch 5/6] zcrypt: Fix possible dead lock in AP bus module.
Content-Disposition: inline; filename=005-zcrypt-deadlock.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Ralph Wuerthner <rwuerthn@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ralph Wuerthner <rwuerthn@de.ibm.com>

If a AP device is unconfigured __ap_poll_all() will call
device_unregister() in software interrupt context which can cause
dead locks. To fix this the device will be only marked as unconfigured
and the device_unregister() call will be done later by either
ap_scan_bus() or ap_queue_message() in process context.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Ralph Wuerthner <rwuerthn@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/crypto/ap_bus.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

Index: linux-2.6/drivers/s390/crypto/ap_bus.c
===================================================================
--- linux-2.6.orig/drivers/s390/crypto/ap_bus.c
+++ linux-2.6/drivers/s390/crypto/ap_bus.c
@@ -757,10 +757,16 @@ static void ap_scan_bus(struct work_stru
 				      (void *)(unsigned long)qid,
 				      __ap_scan_bus);
 		rc = ap_query_queue(qid, &queue_depth, &device_type);
-		if (dev && rc) {
-			put_device(dev);
-			device_unregister(dev);
-			continue;
+		if (dev) {
+			ap_dev = to_ap_dev(dev);
+			spin_lock_bh(&ap_dev->lock);
+			if (rc || ap_dev->unregistered) {
+				spin_unlock_bh(&ap_dev->lock);
+				put_device(dev);
+				device_unregister(dev);
+				continue;
+			} else
+				spin_unlock_bh(&ap_dev->lock);
 		}
 		if (dev) {
 			put_device(dev);
@@ -994,7 +1000,7 @@ void ap_queue_message(struct ap_device *
 			ap_dev->unregistered = 1;
 	} else {
 		ap_dev->drv->receive(ap_dev, ap_msg, ERR_PTR(-ENODEV));
-		rc = 0;
+		rc = -ENODEV;
 	}
 	spin_unlock_bh(&ap_dev->lock);
 	if (rc == -ENODEV)
@@ -1044,18 +1050,12 @@ static void ap_poll_timeout(unsigned lon
  */
 static int __ap_poll_all(struct ap_device *ap_dev, unsigned long *flags)
 {
-	int rc;
-
 	spin_lock(&ap_dev->lock);
 	if (!ap_dev->unregistered) {
-		rc = ap_poll_queue(ap_dev, flags);
-		if (rc)
+		if (ap_poll_queue(ap_dev, flags))
 			ap_dev->unregistered = 1;
-	} else
-		rc = 0;
+	}
 	spin_unlock(&ap_dev->lock);
-	if (rc)
-		device_unregister(&ap_dev->device);
 	return 0;
 }
 

-- 
