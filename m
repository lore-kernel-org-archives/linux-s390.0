Return-Path: <linux-kernel-owner+w=401wt.eu-S1755263AbYK0Kev@vger.kernel.org>
Message-Id: <20081127103130.192052605@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:30:29 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 09/60] ap: Minor code beautification.
Content-Disposition: inline; filename=108-ap-cleanup.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Maaser <cmaaser@de.ibm.com>, Felix Beck <beckf@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Maaser <cmaaser@de.ibm.com>

Changed some symbol names for a better and clearer code.

Signed-off-by: Christian Maaser <cmaaser@de.ibm.com>
Signed-off-by: Felix Beck <beckf@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/crypto/ap_bus.c |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

Index: quilt-2.6/drivers/s390/crypto/ap_bus.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/ap_bus.c
+++ quilt-2.6/drivers/s390/crypto/ap_bus.c
@@ -74,7 +74,7 @@ module_param_named(poll_thread, ap_threa
 MODULE_PARM_DESC(poll_thread, "Turn on/off poll thread, default is 0 (off).");
 
 static struct device *ap_root_device = NULL;
-static DEFINE_SPINLOCK(ap_device_lock);
+static DEFINE_SPINLOCK(ap_device_list_lock);
 static LIST_HEAD(ap_device_list);
 
 /*
@@ -518,16 +518,16 @@ static ssize_t ap_hwtype_show(struct dev
 	struct ap_device *ap_dev = to_ap_dev(dev);
 	return snprintf(buf, PAGE_SIZE, "%d\n", ap_dev->device_type);
 }
-static DEVICE_ATTR(hwtype, 0444, ap_hwtype_show, NULL);
 
+static DEVICE_ATTR(hwtype, 0444, ap_hwtype_show, NULL);
 static ssize_t ap_depth_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
 	struct ap_device *ap_dev = to_ap_dev(dev);
 	return snprintf(buf, PAGE_SIZE, "%d\n", ap_dev->queue_depth);
 }
-static DEVICE_ATTR(depth, 0444, ap_depth_show, NULL);
 
+static DEVICE_ATTR(depth, 0444, ap_depth_show, NULL);
 static ssize_t ap_request_count_show(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
@@ -630,9 +630,9 @@ static int ap_device_probe(struct device
 	ap_dev->drv = ap_drv;
 	rc = ap_drv->probe ? ap_drv->probe(ap_dev) : -ENODEV;
 	if (!rc) {
-		spin_lock_bh(&ap_device_lock);
+		spin_lock_bh(&ap_device_list_lock);
 		list_add(&ap_dev->list, &ap_device_list);
-		spin_unlock_bh(&ap_device_lock);
+		spin_unlock_bh(&ap_device_list_lock);
 	}
 	return rc;
 }
@@ -674,9 +674,9 @@ static int ap_device_remove(struct devic
 
 	ap_flush_queue(ap_dev);
 	del_timer_sync(&ap_dev->timeout);
-	spin_lock_bh(&ap_device_lock);
+	spin_lock_bh(&ap_device_list_lock);
 	list_del_init(&ap_dev->list);
-	spin_unlock_bh(&ap_device_lock);
+	spin_unlock_bh(&ap_device_list_lock);
 	if (ap_drv->remove)
 		ap_drv->remove(ap_dev);
 	spin_lock_bh(&ap_dev->lock);
@@ -1319,7 +1319,7 @@ static void ap_reset(struct ap_device *a
 		ap_dev->unregistered = 1;
 }
 
-static int __ap_poll_all(struct ap_device *ap_dev, unsigned long *flags)
+static int __ap_poll_device(struct ap_device *ap_dev, unsigned long *flags)
 {
 	spin_lock(&ap_dev->lock);
 	if (!ap_dev->unregistered) {
@@ -1353,11 +1353,11 @@ static void ap_poll_all(unsigned long du
 		xchg((u8 *)ap_interrupt_indicator, 0);
 	do {
 		flags = 0;
-		spin_lock(&ap_device_lock);
+		spin_lock(&ap_device_list_lock);
 		list_for_each_entry(ap_dev, &ap_device_list, list) {
-			__ap_poll_all(ap_dev, &flags);
+			__ap_poll_device(ap_dev, &flags);
 		}
-		spin_unlock(&ap_device_lock);
+		spin_unlock(&ap_device_list_lock);
 	} while (flags & 1);
 	if (flags & 2)
 		ap_schedule_poll_timer();
@@ -1397,11 +1397,11 @@ static int ap_poll_thread(void *data)
 		remove_wait_queue(&ap_poll_wait, &wait);
 
 		flags = 0;
-		spin_lock_bh(&ap_device_lock);
+		spin_lock_bh(&ap_device_list_lock);
 		list_for_each_entry(ap_dev, &ap_device_list, list) {
-			__ap_poll_all(ap_dev, &flags);
+			__ap_poll_device(ap_dev, &flags);
 		}
-		spin_unlock_bh(&ap_device_lock);
+		spin_unlock_bh(&ap_device_list_lock);
 	}
 	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&ap_poll_wait, &wait);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
