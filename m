Return-Path: <linux-kernel-owner+w=401wt.eu-S1758028AbZFDQZm@vger.kernel.org>
Message-Id: <20090604161907.542105279@de.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
Date: Thu, 04 Jun 2009 18:19:20 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 33/38] pm: con3270 power management callbacks.
Content-Disposition: inline; filename=pm_3270.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Introduce the power management callbacks to the 3270 driver. On suspend
the current 3270 view is deactivated and for non-console 3270 device
the release callback is done. This disconnects the current tty /
fullscreen application from the 3270 device. On resume the current
view is reactivated, on the tty you get a fresh login.
If the system panics before the 3270 device has been resumed, the ccw
device for the 3270 console is reactivated with ccw_device_force_console.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 drivers/s390/char/con3270.c |   12 +++---
 drivers/s390/char/fs3270.c  |   16 +++++---
 drivers/s390/char/raw3270.c |   84 ++++++++++++++++++++++++++++++++++++++------
 drivers/s390/char/raw3270.h |   12 +++---
 4 files changed, 95 insertions(+), 29 deletions(-)

Index: linux-2.6/drivers/s390/char/raw3270.c
===================================================================
--- linux-2.6.orig/drivers/s390/char/raw3270.c
+++ linux-2.6/drivers/s390/char/raw3270.c
@@ -1,11 +1,10 @@
 /*
- *  drivers/s390/char/raw3270.c
- *    IBM/3270 Driver - core functions.
+ * IBM/3270 Driver - core functions.
  *
- *  Author(s):
- *    Original 3270 Code for 2.4 written by Richard Hitt (UTS Global)
- *    Rewritten for 2.5 by Martin Schwidefsky <schwidefsky@de.ibm.com>
- *	-- Copyright (C) 2003 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ * Author(s):
+ *   Original 3270 Code for 2.4 written by Richard Hitt (UTS Global)
+ *   Rewritten for 2.5 by Martin Schwidefsky <schwidefsky@de.ibm.com>
+ *     Copyright IBM Corp. 2003, 2009
  */
 
 #include <linux/bootmem.h>
@@ -61,6 +60,7 @@ struct raw3270 {
 #define RAW3270_FLAGS_ATTN	2	/* Device sent an ATTN interrupt */
 #define RAW3270_FLAGS_READY	4	/* Device is useable by views */
 #define RAW3270_FLAGS_CONSOLE	8	/* Device is the console. */
+#define RAW3270_FLAGS_FROZEN	16      /* set if 3270 is frozen for suspend */
 
 /* Semaphore to protect global data of raw3270 (devices, views, etc). */
 static DEFINE_MUTEX(raw3270_mutex);
@@ -306,7 +306,8 @@ raw3270_start(struct raw3270_view *view,
 
 	spin_lock_irqsave(get_ccwdev_lock(view->dev->cdev), flags);
 	rp = view->dev;
-	if (!rp || rp->view != view)
+	if (!rp || rp->view != view ||
+	    test_bit(RAW3270_FLAGS_FROZEN, &rp->flags))
 		rc = -EACCES;
 	else if (!test_bit(RAW3270_FLAGS_READY, &rp->flags))
 		rc = -ENODEV;
@@ -323,7 +324,8 @@ raw3270_start_locked(struct raw3270_view
 	int rc;
 
 	rp = view->dev;
-	if (!rp || rp->view != view)
+	if (!rp || rp->view != view ||
+	    test_bit(RAW3270_FLAGS_FROZEN, &rp->flags))
 		rc = -EACCES;
 	else if (!test_bit(RAW3270_FLAGS_READY, &rp->flags))
 		rc = -ENODEV;
@@ -764,7 +766,8 @@ raw3270_reset(struct raw3270_view *view)
 	int rc;
 
 	rp = view->dev;
-	if (!rp || rp->view != view)
+	if (!rp || rp->view != view ||
+	    test_bit(RAW3270_FLAGS_FROZEN, &rp->flags))
 		rc = -EACCES;
 	else if (!test_bit(RAW3270_FLAGS_READY, &rp->flags))
 		rc = -ENODEV;
@@ -922,6 +925,8 @@ raw3270_activate_view(struct raw3270_vie
 		rc = 0;
 	else if (!test_bit(RAW3270_FLAGS_READY, &rp->flags))
 		rc = -ENODEV;
+	else if (test_bit(RAW3270_FLAGS_FROZEN, &rp->flags))
+		rc = -EACCES;
 	else {
 		oldview = NULL;
 		if (rp->view) {
@@ -969,7 +974,8 @@ raw3270_deactivate_view(struct raw3270_v
 		list_del_init(&view->list);
 		list_add_tail(&view->list, &rp->view_list);
 		/* Try to activate another view. */
-		if (test_bit(RAW3270_FLAGS_READY, &rp->flags)) {
+		if (test_bit(RAW3270_FLAGS_READY, &rp->flags) &&
+		    !test_bit(RAW3270_FLAGS_FROZEN, &rp->flags)) {
 			list_for_each_entry(view, &rp->view_list, list) {
 				rp->view = view;
 				if (view->fn->activate(view) == 0)
@@ -1068,7 +1074,8 @@ raw3270_del_view(struct raw3270_view *vi
 		rp->view = NULL;
 	}
 	list_del_init(&view->list);
-	if (!rp->view && test_bit(RAW3270_FLAGS_READY, &rp->flags)) {
+	if (!rp->view && test_bit(RAW3270_FLAGS_READY, &rp->flags) &&
+	    !test_bit(RAW3270_FLAGS_FROZEN, &rp->flags)) {
 		/* Try to activate another view. */
 		list_for_each_entry(nv, &rp->view_list, list) {
 			if (nv->fn->activate(nv) == 0) {
@@ -1337,6 +1344,58 @@ raw3270_set_offline (struct ccw_device *
 	return 0;
 }
 
+static int raw3270_pm_stop(struct ccw_device *cdev)
+{
+	struct raw3270 *rp;
+	struct raw3270_view *view;
+	unsigned long flags;
+
+	rp = cdev->dev.driver_data;
+	if (!rp)
+		return 0;
+	spin_lock_irqsave(get_ccwdev_lock(rp->cdev), flags);
+	if (rp->view)
+		rp->view->fn->deactivate(rp->view);
+	if (!test_bit(RAW3270_FLAGS_CONSOLE, &rp->flags)) {
+		/*
+		 * Release tty and fullscreen for all non-console
+		 * devices.
+		 */
+		list_for_each_entry(view, &rp->view_list, list) {
+			if (view->fn->release)
+				view->fn->release(view);
+		}
+	}
+	set_bit(RAW3270_FLAGS_FROZEN, &rp->flags);
+	spin_unlock_irqrestore(get_ccwdev_lock(rp->cdev), flags);
+	return 0;
+}
+
+static int raw3270_pm_start(struct ccw_device *cdev)
+{
+	struct raw3270 *rp;
+	unsigned long flags;
+
+	rp = cdev->dev.driver_data;
+	if (!rp)
+		return 0;
+	spin_lock_irqsave(get_ccwdev_lock(rp->cdev), flags);
+	clear_bit(RAW3270_FLAGS_FROZEN, &rp->flags);
+	if (rp->view)
+		rp->view->fn->activate(rp->view);
+	spin_unlock_irqrestore(get_ccwdev_lock(rp->cdev), flags);
+	return 0;
+}
+
+void raw3270_pm_unfreeze(struct raw3270_view *view)
+{
+	struct raw3270 *rp;
+
+	rp = view->dev;
+	if (rp && test_bit(RAW3270_FLAGS_FROZEN, &rp->flags))
+		ccw_device_force_console();
+}
+
 static struct ccw_device_id raw3270_id[] = {
 	{ CCW_DEVICE(0x3270, 0) },
 	{ CCW_DEVICE(0x3271, 0) },
@@ -1360,6 +1419,9 @@ static struct ccw_driver raw3270_ccw_dri
 	.remove		= &raw3270_remove,
 	.set_online	= &raw3270_set_online,
 	.set_offline	= &raw3270_set_offline,
+	.freeze		= &raw3270_pm_stop,
+	.thaw		= &raw3270_pm_start,
+	.restore	= &raw3270_pm_start,
 };
 
 static int
Index: linux-2.6/drivers/s390/char/con3270.c
===================================================================
--- linux-2.6.orig/drivers/s390/char/con3270.c
+++ linux-2.6/drivers/s390/char/con3270.c
@@ -1,11 +1,10 @@
 /*
- *  drivers/s390/char/con3270.c
- *    IBM/3270 Driver - console view.
+ * IBM/3270 Driver - console view.
  *
- *  Author(s):
- *    Original 3270 Code for 2.4 written by Richard Hitt (UTS Global)
- *    Rewritten for 2.5 by Martin Schwidefsky <schwidefsky@de.ibm.com>
- *	-- Copyright (C) 2003 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ * Author(s):
+ *   Original 3270 Code for 2.4 written by Richard Hitt (UTS Global)
+ *   Rewritten for 2.5 by Martin Schwidefsky <schwidefsky@de.ibm.com>
+ *     Copyright IBM Corp. 2003, 2009
  */
 
 #include <linux/bootmem.h>
@@ -530,6 +529,7 @@ con3270_flush(void)
 	cp = condev;
 	if (!cp->view.dev)
 		return;
+	raw3270_pm_unfreeze(&cp->view);
 	spin_lock_irqsave(&cp->view.lock, flags);
 	con3270_wait_write(cp);
 	cp->nr_up = 0;
Index: linux-2.6/drivers/s390/char/fs3270.c
===================================================================
--- linux-2.6.orig/drivers/s390/char/fs3270.c
+++ linux-2.6/drivers/s390/char/fs3270.c
@@ -1,11 +1,10 @@
 /*
- *  drivers/s390/char/fs3270.c
- *    IBM/3270 Driver - fullscreen driver.
+ * IBM/3270 Driver - fullscreen driver.
  *
- *  Author(s):
- *    Original 3270 Code for 2.4 written by Richard Hitt (UTS Global)
- *    Rewritten for 2.5/2.6 by Martin Schwidefsky <schwidefsky@de.ibm.com>
- *	-- Copyright (C) 2003 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ * Author(s):
+ *   Original 3270 Code for 2.4 written by Richard Hitt (UTS Global)
+ *   Rewritten for 2.5/2.6 by Martin Schwidefsky <schwidefsky@de.ibm.com>
+ *     Copyright IBM Corp. 2003, 2009
  */
 
 #include <linux/bootmem.h>
@@ -399,6 +398,11 @@ fs3270_free_view(struct raw3270_view *vi
 static void
 fs3270_release(struct raw3270_view *view)
 {
+	struct fs3270 *fp;
+
+	fp = (struct fs3270 *) view;
+	if (fp->fs_pid)
+		kill_pid(fp->fs_pid, SIGHUP, 1);
 }
 
 /* View to a 3270 device. Can be console, tty or fullscreen. */
Index: linux-2.6/drivers/s390/char/raw3270.h
===================================================================
--- linux-2.6.orig/drivers/s390/char/raw3270.h
+++ linux-2.6/drivers/s390/char/raw3270.h
@@ -1,11 +1,10 @@
 /*
- *  drivers/s390/char/raw3270.h
- *    IBM/3270 Driver
+ * IBM/3270 Driver
  *
- *  Author(s):
- *    Original 3270 Code for 2.4 written by Richard Hitt (UTS Global)
- *    Rewritten for 2.5 by Martin Schwidefsky <schwidefsky@de.ibm.com>
- *	-- Copyright (C) 2003 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ * Author(s):
+ *   Original 3270 Code for 2.4 written by Richard Hitt (UTS Global)
+ *   Rewritten for 2.5 by Martin Schwidefsky <schwidefsky@de.ibm.com>
+ *     Copyright IBM Corp. 2003, 2009
  */
 
 #include <asm/idals.h>
@@ -195,6 +194,7 @@ void raw3270_wait_cons_dev(struct raw327
 /* Notifier for device addition/removal */
 int raw3270_register_notifier(void (*notifier)(int, int));
 void raw3270_unregister_notifier(void (*notifier)(int, int));
+void raw3270_pm_unfreeze(struct raw3270_view *);
 
 /*
  * Little memory allocator for string objects. 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
