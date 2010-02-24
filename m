Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20100224084447.541610561@de.ibm.com>
Date: Wed, 24 Feb 2010 09:44:33 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 03/32] [PATCH] cio: consolidate workqueues
References: <20100224084430.193562869@de.ibm.com>
Content-Disposition: inline; filename=102-cio-consolidate-wq.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Sebastian Ott <sebott@linux.vnet.ibm.com>

We used to maintain 2 singlethreaded workqueues for synchronization
and to trigger work from interrupt context. Since our latest cio
changes we only use one of these workqueues. So get rid of the
unused workqueue, rename the remaining one to "cio_work_q" and move
its ownership to the channel subsystem driver.

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/css.c    |   26 ++++++++++++++++++--------
 drivers/s390/cio/css.h    |    2 +-
 drivers/s390/cio/device.c |   28 ++++++----------------------
 drivers/s390/cio/device.h |    1 -
 4 files changed, 25 insertions(+), 32 deletions(-)

Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/css.c	2010-02-24 09:44:23.000000000 +0100
@@ -232,7 +232,7 @@
 	if (!get_device(&sch->dev))
 		return;
 	sch->todo = todo;
-	if (!queue_work(slow_path_wq, &sch->todo_work)) {
+	if (!queue_work(cio_work_q, &sch->todo_work)) {
 		/* Already queued, release workqueue ref. */
 		put_device(&sch->dev);
 	}
@@ -543,7 +543,7 @@
 }
 
 static DECLARE_WORK(slow_path_work, css_slow_path_func);
-struct workqueue_struct *slow_path_wq;
+struct workqueue_struct *cio_work_q;
 
 void css_schedule_eval(struct subchannel_id schid)
 {
@@ -552,7 +552,7 @@
 	spin_lock_irqsave(&slow_subchannel_lock, flags);
 	idset_sch_add(slow_subchannel_set, schid);
 	atomic_set(&css_eval_scheduled, 1);
-	queue_work(slow_path_wq, &slow_path_work);
+	queue_work(cio_work_q, &slow_path_work);
 	spin_unlock_irqrestore(&slow_subchannel_lock, flags);
 }
 
@@ -563,7 +563,7 @@
 	spin_lock_irqsave(&slow_subchannel_lock, flags);
 	idset_fill(slow_subchannel_set);
 	atomic_set(&css_eval_scheduled, 1);
-	queue_work(slow_path_wq, &slow_path_work);
+	queue_work(cio_work_q, &slow_path_work);
 	spin_unlock_irqrestore(&slow_subchannel_lock, flags);
 }
 
@@ -594,14 +594,14 @@
 	spin_lock_irqsave(&slow_subchannel_lock, flags);
 	idset_add_set(slow_subchannel_set, unreg_set);
 	atomic_set(&css_eval_scheduled, 1);
-	queue_work(slow_path_wq, &slow_path_work);
+	queue_work(cio_work_q, &slow_path_work);
 	spin_unlock_irqrestore(&slow_subchannel_lock, flags);
 	idset_free(unreg_set);
 }
 
 void css_wait_for_slow_path(void)
 {
-	flush_workqueue(slow_path_wq);
+	flush_workqueue(cio_work_q);
 }
 
 /* Schedule reprobing of all unregistered subchannels. */
@@ -992,12 +992,21 @@
 	ret = css_bus_init();
 	if (ret)
 		return ret;
-
+	cio_work_q = create_singlethread_workqueue("cio");
+	if (!cio_work_q) {
+		ret = -ENOMEM;
+		goto out_bus;
+	}
 	ret = io_subchannel_init();
 	if (ret)
-		css_bus_cleanup();
+		goto out_wq;
 
 	return ret;
+out_wq:
+	destroy_workqueue(cio_work_q);
+out_bus:
+	css_bus_cleanup();
+	return ret;
 }
 subsys_initcall(channel_subsystem_init);
 
@@ -1020,6 +1029,7 @@
 	css_schedule_eval_all();
 	/* Wait for the evaluation of subchannels to finish. */
 	wait_event(css_eval_wq, atomic_read(&css_eval_scheduled) == 0);
+	flush_workqueue(cio_work_q);
 	/* Wait for the subchannel type specific initialization to finish */
 	return bus_for_each_drv(&css_bus_type, NULL, NULL, css_settle);
 }
Index: quilt-2.6/drivers/s390/cio/css.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.h	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/css.h	2010-02-24 09:44:23.000000000 +0100
@@ -151,7 +151,7 @@
 struct schib;
 int css_sch_is_valid(struct schib *);
 
-extern struct workqueue_struct *slow_path_wq;
+extern struct workqueue_struct *cio_work_q;
 void css_wait_for_slow_path(void);
 void css_sched_sch_todo(struct subchannel *sch, enum sch_todo todo);
 #endif
Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device.c	2010-02-24 09:44:23.000000000 +0100
@@ -136,7 +136,6 @@
 static int io_subchannel_chp_event(struct subchannel *, struct chp_link *,
 				   int);
 static void recovery_func(unsigned long data);
-struct workqueue_struct *ccw_device_work;
 wait_queue_head_t ccw_device_init_wq;
 atomic_t ccw_device_init_count;
 
@@ -163,7 +162,7 @@
 {
 	wait_event(ccw_device_init_wq,
 		   atomic_read(&ccw_device_init_count) == 0);
-	flush_workqueue(ccw_device_work);
+	flush_workqueue(cio_work_q);
 }
 
 static struct css_driver io_subchannel_driver = {
@@ -188,27 +187,13 @@
 	atomic_set(&ccw_device_init_count, 0);
 	setup_timer(&recovery_timer, recovery_func, 0);
 
-	ccw_device_work = create_singlethread_workqueue("cio");
-	if (!ccw_device_work)
-		return -ENOMEM;
-	slow_path_wq = create_singlethread_workqueue("kslowcrw");
-	if (!slow_path_wq) {
-		ret = -ENOMEM;
-		goto out_err;
-	}
-	if ((ret = bus_register (&ccw_bus_type)))
-		goto out_err;
-
+	ret = bus_register(&ccw_bus_type);
+	if (ret)
+		return ret;
 	ret = css_driver_register(&io_subchannel_driver);
 	if (ret)
-		goto out_err;
+		bus_unregister(&ccw_bus_type);
 
-	return 0;
-out_err:
-	if (ccw_device_work)
-		destroy_workqueue(ccw_device_work);
-	if (slow_path_wq)
-		destroy_workqueue(slow_path_wq);
 	return ret;
 }
 
@@ -2028,7 +2013,7 @@
 	/* Get workqueue ref. */
 	if (!get_device(&cdev->dev))
 		return;
-	if (!queue_work(slow_path_wq, &cdev->private->todo_work)) {
+	if (!queue_work(cio_work_q, &cdev->private->todo_work)) {
 		/* Already queued, release workqueue ref. */
 		put_device(&cdev->dev);
 	}
@@ -2041,5 +2026,4 @@
 EXPORT_SYMBOL(ccw_driver_unregister);
 EXPORT_SYMBOL(get_ccwdev_by_busid);
 EXPORT_SYMBOL(ccw_bus_type);
-EXPORT_SYMBOL(ccw_device_work);
 EXPORT_SYMBOL_GPL(ccw_device_get_subchannel_id);
Index: quilt-2.6/drivers/s390/cio/device.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.h	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device.h	2010-02-24 09:44:23.000000000 +0100
@@ -71,7 +71,6 @@
 		cdev->private->state == DEV_STATE_BOXED);
 }
 
-extern struct workqueue_struct *ccw_device_work;
 extern wait_queue_head_t ccw_device_init_wq;
 extern atomic_t ccw_device_init_count;
 int __init io_subchannel_init(void);
