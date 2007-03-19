Return-Path: <linux-kernel-owner+w=401wt.eu-S933869AbXCSNBO@vger.kernel.org>
Date: Mon, 19 Mar 2007 14:01:23 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [S390] zcrypt: fix possible dead lock in AP bus module
Message-ID: <20070319130123.GA1292@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: rwuerthn@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ralph Wuerthner <rwuerthn@de.ibm.com>

[S390] zcrypt: fix possible dead lock in AP bus module

AP bus module uses bus_for_each_dev() in software interrupt context to
poll for completed requests which might cause dead locks. Solution: use
private AP device list for polling in software interrupt context.

Signed-off-by: Ralph Wuerthner <rwuerthn@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/crypto/ap_bus.c |   30 +++++++++++++++++++++++-------
 drivers/s390/crypto/ap_bus.h |    1 +
 2 files changed, 24 insertions(+), 7 deletions(-)

diff -urpN linux-2.6/drivers/s390/crypto/ap_bus.c linux-2.6-patched/drivers/s390/crypto/ap_bus.c
--- linux-2.6/drivers/s390/crypto/ap_bus.c	2007-03-19 13:09:04.000000000 +0100
+++ linux-2.6-patched/drivers/s390/crypto/ap_bus.c	2007-03-19 13:09:26.000000000 +0100
@@ -65,6 +65,8 @@ module_param_named(poll_thread, ap_threa
 MODULE_PARM_DESC(poll_thread, "Turn on/off poll thread, default is 1 (on).");
 
 static struct device *ap_root_device = NULL;
+static DEFINE_SPINLOCK(ap_device_lock);
+static LIST_HEAD(ap_device_list);
 
 /**
  * Workqueue & timer for bus rescan.
@@ -457,6 +459,9 @@ static int ap_device_probe(struct device
 	int rc;
 
 	ap_dev->drv = ap_drv;
+	spin_lock_bh(&ap_device_lock);
+	list_add(&ap_dev->list, &ap_device_list);
+	spin_unlock_bh(&ap_device_lock);
 	rc = ap_drv->probe ? ap_drv->probe(ap_dev) : -ENODEV;
 	return rc;
 }
@@ -497,6 +502,9 @@ static int ap_device_remove(struct devic
 	ap_flush_queue(ap_dev);
 	if (ap_drv->remove)
 		ap_drv->remove(ap_dev);
+	spin_lock_bh(&ap_device_lock);
+	list_del_init(&ap_dev->list);
+	spin_unlock_bh(&ap_device_lock);
 	return 0;
 }
 
@@ -772,6 +780,7 @@ static void ap_scan_bus(struct work_stru
 		spin_lock_init(&ap_dev->lock);
 		INIT_LIST_HEAD(&ap_dev->pendingq);
 		INIT_LIST_HEAD(&ap_dev->requestq);
+		INIT_LIST_HEAD(&ap_dev->list);
 		if (device_type == 0)
 			ap_probe_device_type(ap_dev);
 		else
@@ -1033,14 +1042,13 @@ static void ap_poll_timeout(unsigned lon
  * polling until bit 2^0 of the control flags is not set. If bit 2^1
  * of the control flags has been set arm the poll timer.
  */
-static int __ap_poll_all(struct device *dev, void *data)
+static int __ap_poll_all(struct ap_device *ap_dev, unsigned long *flags)
 {
-	struct ap_device *ap_dev = to_ap_dev(dev);
 	int rc;
 
 	spin_lock(&ap_dev->lock);
 	if (!ap_dev->unregistered) {
-		rc = ap_poll_queue(to_ap_dev(dev), (unsigned long *) data);
+		rc = ap_poll_queue(ap_dev, flags);
 		if (rc)
 			ap_dev->unregistered = 1;
 	} else
@@ -1054,10 +1062,15 @@ static int __ap_poll_all(struct device *
 static void ap_poll_all(unsigned long dummy)
 {
 	unsigned long flags;
+	struct ap_device *ap_dev;
 
 	do {
 		flags = 0;
-		bus_for_each_dev(&ap_bus_type, NULL, &flags, __ap_poll_all);
+		spin_lock(&ap_device_lock);
+		list_for_each_entry(ap_dev, &ap_device_list, list) {
+			__ap_poll_all(ap_dev, &flags);
+		}
+		spin_unlock(&ap_device_lock);
 	} while (flags & 1);
 	if (flags & 2)
 		ap_schedule_poll_timer();
@@ -1075,6 +1088,7 @@ static int ap_poll_thread(void *data)
 	DECLARE_WAITQUEUE(wait, current);
 	unsigned long flags;
 	int requests;
+	struct ap_device *ap_dev;
 
 	set_user_nice(current, 19);
 	while (1) {
@@ -1092,10 +1106,12 @@ static int ap_poll_thread(void *data)
 		set_current_state(TASK_RUNNING);
 		remove_wait_queue(&ap_poll_wait, &wait);
 
-		local_bh_disable();
 		flags = 0;
-		bus_for_each_dev(&ap_bus_type, NULL, &flags, __ap_poll_all);
-		local_bh_enable();
+		spin_lock_bh(&ap_device_lock);
+		list_for_each_entry(ap_dev, &ap_device_list, list) {
+			__ap_poll_all(ap_dev, &flags);
+		}
+		spin_unlock_bh(&ap_device_lock);
 	}
 	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&ap_poll_wait, &wait);
diff -urpN linux-2.6/drivers/s390/crypto/ap_bus.h linux-2.6-patched/drivers/s390/crypto/ap_bus.h
--- linux-2.6/drivers/s390/crypto/ap_bus.h	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6-patched/drivers/s390/crypto/ap_bus.h	2007-03-19 13:09:26.000000000 +0100
@@ -106,6 +106,7 @@ struct ap_device {
 	struct device device;
 	struct ap_driver *drv;		/* Pointer to AP device driver. */
 	spinlock_t lock;		/* Per device lock. */
+	struct list_head list;		/* private list of all AP devices. */
 
 	ap_qid_t qid;			/* AP queue id. */
 	int queue_depth;		/* AP queue depth.*/
