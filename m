Return-Path: <linux-kernel-owner+w=401wt.eu-S1756977AbZKMPNU@vger.kernel.org>
Message-Id: <20091113150914.652373699@de.ibm.com>
Date: Fri, 13 Nov 2009 16:08:54 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 30/52] [PATCH] cio: introduce ccw device todos
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=129-cio-ccwdev-todos.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Introduce a central mechanism for performing delayed ccw device work
to ensure that different types of work do not overwrite each other.
Prioritization ensures that the most important work is always
performed while less important tasks are either obsoleted or repeated
later.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device.c     |  203 ++++++++++++++++++++----------------------
 drivers/s390/cio/device.h     |    3 
 drivers/s390/cio/device_fsm.c |   28 +----
 drivers/s390/cio/io_sch.h     |   12 ++
 4 files changed, 119 insertions(+), 127 deletions(-)

Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c	2009-11-13 16:08:18.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device.c	2009-11-13 16:08:18.000000000 +0100
@@ -306,47 +306,6 @@
 	}
 }
 
-static void ccw_device_remove_orphan_cb(struct work_struct *work)
-{
-	struct ccw_device_private *priv;
-	struct ccw_device *cdev;
-
-	priv = container_of(work, struct ccw_device_private, kick_work);
-	cdev = priv->cdev;
-	ccw_device_unregister(cdev);
-	/* Release cdev reference for workqueue processing. */
-	put_device(&cdev->dev);
-}
-
-static void
-ccw_device_remove_disconnected(struct ccw_device *cdev)
-{
-	unsigned long flags;
-
-	/*
-	 * Forced offline in disconnected state means
-	 * 'throw away device'.
-	 */
-	if (ccw_device_is_orphan(cdev)) {
-		/*
-		 * Deregister ccw device.
-		 * Unfortunately, we cannot do this directly from the
-		 * attribute method.
-		 */
-		/* Get cdev reference for workqueue processing. */
-		if (!get_device(&cdev->dev))
-			return;
-		spin_lock_irqsave(cdev->ccwlock, flags);
-		cdev->private->state = DEV_STATE_NOT_OPER;
-		spin_unlock_irqrestore(cdev->ccwlock, flags);
-		PREPARE_WORK(&cdev->private->kick_work,
-				ccw_device_remove_orphan_cb);
-		queue_work(slow_path_wq, &cdev->private->kick_work);
-	} else
-		/* Deregister subchannel, which will kill the ccw device. */
-		ccw_device_schedule_sch_unregister(cdev);
-}
-
 /**
  * ccw_device_set_offline() - disable a ccw device for I/O
  * @cdev: target ccw device
@@ -494,9 +453,11 @@
 
 static int online_store_handle_offline(struct ccw_device *cdev)
 {
-	if (cdev->private->state == DEV_STATE_DISCONNECTED)
-		ccw_device_remove_disconnected(cdev);
-	else if (cdev->online && cdev->drv && cdev->drv->set_offline)
+	if (cdev->private->state == DEV_STATE_DISCONNECTED) {
+		spin_lock_irq(cdev->ccwlock);
+		ccw_device_sched_todo(cdev, CDEV_TODO_UNREG_EVAL);
+		spin_unlock_irq(cdev->ccwlock);
+	} else if (cdev->online && cdev->drv && cdev->drv->set_offline)
 		return ccw_device_set_offline(cdev);
 	return 0;
 }
@@ -690,17 +651,10 @@
 	return dev ? to_ccwdev(dev) : NULL;
 }
 
-void ccw_device_do_unbind_bind(struct work_struct *work)
+static void ccw_device_do_unbind_bind(struct ccw_device *cdev)
 {
-	struct ccw_device_private *priv;
-	struct ccw_device *cdev;
-	struct subchannel *sch;
 	int ret;
 
-	priv = container_of(work, struct ccw_device_private, kick_work);
-	cdev = priv->cdev;
-	sch = to_subchannel(cdev->dev.parent);
-
 	if (test_bit(1, &cdev->private->registered)) {
 		device_release_driver(&cdev->dev);
 		ret = device_attach(&cdev->dev);
@@ -735,6 +689,8 @@
 	return ERR_PTR(-ENOMEM);
 }
 
+static void ccw_device_todo(struct work_struct *work);
+
 static int io_subchannel_initialize_dev(struct subchannel *sch,
 					struct ccw_device *cdev)
 {
@@ -742,7 +698,7 @@
 	atomic_set(&cdev->private->onoff, 0);
 	cdev->dev.parent = &sch->dev;
 	cdev->dev.release = ccw_device_release;
-	INIT_WORK(&cdev->private->kick_work, NULL);
+	INIT_WORK(&cdev->private->todo_work, ccw_device_todo);
 	cdev->dev.groups = ccwdev_attr_groups;
 	/* Do first half of device_register. */
 	device_initialize(&cdev->dev);
@@ -797,17 +753,12 @@
 /*
  * Register recognized device.
  */
-static void
-io_subchannel_register(struct work_struct *work)
+static void io_subchannel_register(struct ccw_device *cdev)
 {
-	struct ccw_device_private *priv;
-	struct ccw_device *cdev;
 	struct subchannel *sch;
 	int ret;
 	unsigned long flags;
 
-	priv = container_of(work, struct ccw_device_private, kick_work);
-	cdev = priv->cdev;
 	sch = to_subchannel(cdev->dev.parent);
 	/*
 	 * Check if subchannel is still registered. It may have become
@@ -859,41 +810,23 @@
 	cdev->private->flags.recog_done = 1;
 	wake_up(&cdev->private->wait_q);
 out_err:
-	/* Release reference for workqueue processing. */
-	put_device(&cdev->dev);
 	if (atomic_dec_and_test(&ccw_device_init_count))
 		wake_up(&ccw_device_init_wq);
 }
 
-static void ccw_device_call_sch_unregister(struct work_struct *work)
+static void ccw_device_call_sch_unregister(struct ccw_device *cdev)
 {
-	struct ccw_device_private *priv;
-	struct ccw_device *cdev;
 	struct subchannel *sch;
 
-	priv = container_of(work, struct ccw_device_private, kick_work);
-	cdev = priv->cdev;
 	/* Get subchannel reference for local processing. */
 	if (!get_device(cdev->dev.parent))
 		return;
 	sch = to_subchannel(cdev->dev.parent);
 	css_sch_device_unregister(sch);
-	/* Release cdev reference for workqueue processing.*/
-	put_device(&cdev->dev);
 	/* Release subchannel reference for local processing. */
 	put_device(&sch->dev);
 }
 
-void ccw_device_schedule_sch_unregister(struct ccw_device *cdev)
-{
-	/* Get cdev reference for workqueue processing. */
-	if (!get_device(&cdev->dev))
-		return;
-	PREPARE_WORK(&cdev->private->kick_work,
-		     ccw_device_call_sch_unregister);
-	queue_work(slow_path_wq, &cdev->private->kick_work);
-}
-
 /*
  * subchannel recognition done. Called from the state machine.
  */
@@ -909,7 +842,8 @@
 		/* Device did not respond in time. */
 	case DEV_STATE_NOT_OPER:
 		cdev->private->flags.recog_done = 1;
-		ccw_device_schedule_sch_unregister(cdev);
+		/* Remove device found not operational. */
+		ccw_device_sched_todo(cdev, CDEV_TODO_UNREG);
 		if (atomic_dec_and_test(&ccw_device_init_count))
 			wake_up(&ccw_device_init_wq);
 		break;
@@ -918,11 +852,7 @@
 		 * We can't register the device in interrupt context so
 		 * we schedule a work item.
 		 */
-		if (!get_device(&cdev->dev))
-			break;
-		PREPARE_WORK(&cdev->private->kick_work,
-			     io_subchannel_register);
-		queue_work(slow_path_wq, &cdev->private->kick_work);
+		ccw_device_sched_todo(cdev, CDEV_TODO_REGISTER);
 		break;
 	}
 }
@@ -1333,20 +1263,16 @@
 static int purge_fn(struct device *dev, void *data)
 {
 	struct ccw_device *cdev = to_ccwdev(dev);
-	struct ccw_device_private *priv = cdev->private;
-	int unreg;
+	struct ccw_dev_id *id = &cdev->private->dev_id;
 
 	spin_lock_irq(cdev->ccwlock);
-	unreg = is_blacklisted(priv->dev_id.ssid, priv->dev_id.devno) &&
-		(priv->state == DEV_STATE_OFFLINE);
+	if (is_blacklisted(id->ssid, id->devno) &&
+	    (cdev->private->state == DEV_STATE_OFFLINE)) {
+		CIO_MSG_EVENT(3, "ccw: purging 0.%x.%04x\n", id->ssid,
+			      id->devno);
+		ccw_device_sched_todo(cdev, CDEV_TODO_UNREG);
+	}
 	spin_unlock_irq(cdev->ccwlock);
-	if (!unreg)
-		goto out;
-	CIO_MSG_EVENT(3, "ccw: purging 0.%x.%04x\n", priv->dev_id.ssid,
-		      priv->dev_id.devno);
-	ccw_device_schedule_sch_unregister(cdev);
-
-out:
 	/* Abort loop in case of pending signal. */
 	if (signal_pending(current))
 		return -EINTR;
@@ -1456,12 +1382,14 @@
 		goto out_unlock;
 	if (work_pending(&sch->todo_work))
 		goto out_unlock;
+	cdev = sch_get_cdev(sch);
+	if (cdev && work_pending(&cdev->private->todo_work))
+		goto out_unlock;
 	action = sch_get_action(sch);
 	CIO_MSG_EVENT(2, "event: sch 0.%x.%04x, process=%d, action=%d\n",
 		      sch->schid.ssid, sch->schid.sch_no, process,
 		      action);
 	/* Perform immediate actions while holding the lock. */
-	cdev = sch_get_cdev(sch);
 	switch (action) {
 	case IO_SCH_REPROBE:
 		/* Trigger device recognition. */
@@ -1753,7 +1681,7 @@
 {
 	struct ccw_device *cdev = to_ccwdev(dev);
 
-	if (work_pending(&cdev->private->kick_work))
+	if (work_pending(&cdev->private->todo_work))
 		return -EAGAIN;
 	/* Fail while device is being set online/offline. */
 	if (atomic_read(&cdev->private->onoff))
@@ -1874,7 +1802,7 @@
 	cdev->private->state = DEV_STATE_BOXED;
 	if (ccw_device_notify(cdev, CIO_BOXED))
 		return 0;
-	ccw_device_schedule_sch_unregister(cdev);
+	ccw_device_sched_todo(cdev, CDEV_TODO_UNREG);
 	return -ENODEV;
 }
 
@@ -1883,7 +1811,7 @@
 	cdev->private->state = DEV_STATE_DISCONNECTED;
 	if (ccw_device_notify(cdev, CIO_GONE))
 		return 0;
-	ccw_device_schedule_sch_unregister(cdev);
+	ccw_device_sched_todo(cdev, CDEV_TODO_UNREG);
 	return -ENODEV;
 }
 
@@ -1928,9 +1856,7 @@
 	/* check if the device type has changed */
 	if (!ccw_device_test_sense_data(cdev)) {
 		ccw_device_update_sense_data(cdev);
-		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_do_unbind_bind);
-		queue_work(ccw_device_work, &cdev->private->kick_work);
+		ccw_device_sched_todo(cdev, CDEV_TODO_REBIND);
 		ret = -ENODEV;
 		goto out_unlock;
 	}
@@ -1974,7 +1900,7 @@
 	goto out_restore;
 
 out_unreg_unlock:
-	ccw_device_schedule_sch_unregister(cdev);
+	ccw_device_sched_todo(cdev, CDEV_TODO_UNREG_EVAL);
 	ret = -ENODEV;
 out_unlock:
 	spin_unlock_irq(sch->lock);
@@ -2039,6 +1965,77 @@
 	return sch->schid;
 }
 
+static void ccw_device_todo(struct work_struct *work)
+{
+	struct ccw_device_private *priv;
+	struct ccw_device *cdev;
+	struct subchannel *sch;
+	enum cdev_todo todo;
+
+	priv = container_of(work, struct ccw_device_private, todo_work);
+	cdev = priv->cdev;
+	sch = to_subchannel(cdev->dev.parent);
+	/* Find out todo. */
+	spin_lock_irq(cdev->ccwlock);
+	todo = priv->todo;
+	priv->todo = CDEV_TODO_NOTHING;
+	CIO_MSG_EVENT(4, "cdev_todo: cdev=0.%x.%04x todo=%d\n",
+		      priv->dev_id.ssid, priv->dev_id.devno, todo);
+	spin_unlock_irq(cdev->ccwlock);
+	/* Perform todo. */
+	switch (todo) {
+	case CDEV_TODO_ENABLE_CMF:
+		cmf_reenable(cdev);
+		break;
+	case CDEV_TODO_REBIND:
+		ccw_device_do_unbind_bind(cdev);
+		break;
+	case CDEV_TODO_REGISTER:
+		io_subchannel_register(cdev);
+		break;
+	case CDEV_TODO_UNREG_EVAL:
+		if (!sch_is_pseudo_sch(sch))
+			css_schedule_eval(sch->schid);
+		/* fall-through */
+	case CDEV_TODO_UNREG:
+		if (sch_is_pseudo_sch(sch))
+			ccw_device_unregister(cdev);
+		else
+			ccw_device_call_sch_unregister(cdev);
+		break;
+	default:
+		break;
+	}
+	/* Release workqueue ref. */
+	put_device(&cdev->dev);
+}
+
+/**
+ * ccw_device_sched_todo - schedule ccw device operation
+ * @cdev: ccw device
+ * @todo: todo
+ *
+ * Schedule the operation identified by @todo to be performed on the slow path
+ * workqueue. Do nothing if another operation with higher priority is already
+ * scheduled. Needs to be called with ccwdev lock held.
+ */
+void ccw_device_sched_todo(struct ccw_device *cdev, enum cdev_todo todo)
+{
+	CIO_MSG_EVENT(4, "cdev_todo: sched cdev=0.%x.%04x todo=%d\n",
+		      cdev->private->dev_id.ssid, cdev->private->dev_id.devno,
+		      todo);
+	if (cdev->private->todo >= todo)
+		return;
+	cdev->private->todo = todo;
+	/* Get workqueue ref. */
+	if (!get_device(&cdev->dev))
+		return;
+	if (!queue_work(slow_path_wq, &cdev->private->todo_work)) {
+		/* Already queued, release workqueue ref. */
+		put_device(&cdev->dev);
+	}
+}
+
 MODULE_LICENSE("GPL");
 EXPORT_SYMBOL(ccw_device_set_online);
 EXPORT_SYMBOL(ccw_device_set_offline);
Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c	2009-11-13 16:08:18.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device_fsm.c	2009-11-13 16:08:18.000000000 +0100
@@ -289,9 +289,7 @@
 			wake_up(&cdev->private->wait_q);
 		} else {
 			ccw_device_update_sense_data(cdev);
-			PREPARE_WORK(&cdev->private->kick_work,
-				     ccw_device_do_unbind_bind);
-			queue_work(ccw_device_work, &cdev->private->kick_work);
+			ccw_device_sched_todo(cdev, CDEV_TODO_REBIND);
 		}
 		return;
 	case DEV_STATE_BOXED:
@@ -343,28 +341,16 @@
 	return cdev->drv->notify ? cdev->drv->notify(cdev, event) : 0;
 }
 
-static void cmf_reenable_delayed(struct work_struct *work)
-{
-	struct ccw_device_private *priv;
-	struct ccw_device *cdev;
-
-	priv = container_of(work, struct ccw_device_private, kick_work);
-	cdev = priv->cdev;
-	cmf_reenable(cdev);
-}
-
 static void ccw_device_oper_notify(struct ccw_device *cdev)
 {
 	if (ccw_device_notify(cdev, CIO_OPER)) {
 		/* Reenable channel measurements, if needed. */
-		PREPARE_WORK(&cdev->private->kick_work, cmf_reenable_delayed);
-		queue_work(ccw_device_work, &cdev->private->kick_work);
+		ccw_device_sched_todo(cdev, CDEV_TODO_ENABLE_CMF);
 		return;
 	}
 	/* Driver doesn't want device back. */
 	ccw_device_set_notoper(cdev);
-	PREPARE_WORK(&cdev->private->kick_work, ccw_device_do_unbind_bind);
-	queue_work(ccw_device_work, &cdev->private->kick_work);
+	ccw_device_sched_todo(cdev, CDEV_TODO_REBIND);
 }
 
 /*
@@ -392,14 +378,14 @@
 		CIO_MSG_EVENT(0, "Boxed device %04x on subchannel %04x\n",
 			      cdev->private->dev_id.devno, sch->schid.sch_no);
 		if (cdev->online && !ccw_device_notify(cdev, CIO_BOXED))
-			ccw_device_schedule_sch_unregister(cdev);
+			ccw_device_sched_todo(cdev, CDEV_TODO_UNREG);
 		cdev->private->flags.donotify = 0;
 		break;
 	case DEV_STATE_NOT_OPER:
 		CIO_MSG_EVENT(0, "Device %04x gone on subchannel %04x\n",
 			      cdev->private->dev_id.devno, sch->schid.sch_no);
 		if (!ccw_device_notify(cdev, CIO_GONE))
-			ccw_device_schedule_sch_unregister(cdev);
+			ccw_device_sched_todo(cdev, CDEV_TODO_UNREG);
 		else
 			ccw_device_set_disconnected(cdev);
 		cdev->private->flags.donotify = 0;
@@ -409,7 +395,7 @@
 			      "%04x\n", cdev->private->dev_id.devno,
 			      sch->schid.sch_no);
 		if (!ccw_device_notify(cdev, CIO_NO_PATH))
-			ccw_device_schedule_sch_unregister(cdev);
+			ccw_device_sched_todo(cdev, CDEV_TODO_UNREG);
 		else
 			ccw_device_set_disconnected(cdev);
 		cdev->private->flags.donotify = 0;
@@ -751,7 +737,7 @@
 				       enum dev_event dev_event)
 {
 	if (!ccw_device_notify(cdev, CIO_GONE))
-		ccw_device_schedule_sch_unregister(cdev);
+		ccw_device_sched_todo(cdev, CDEV_TODO_UNREG);
 	else
 		ccw_device_set_disconnected(cdev);
 }
Index: quilt-2.6/drivers/s390/cio/device.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.h	2009-11-13 15:48:33.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device.h	2009-11-13 16:08:18.000000000 +0100
@@ -81,8 +81,6 @@
 
 int ccw_device_cancel_halt_clear(struct ccw_device *);
 
-void ccw_device_do_unbind_bind(struct work_struct *);
-void ccw_device_move_to_orphanage(struct work_struct *);
 int ccw_device_is_orphan(struct ccw_device *);
 
 int ccw_device_recognition(struct ccw_device *);
@@ -92,6 +90,7 @@
 int ccw_device_test_sense_data(struct ccw_device *);
 void ccw_device_schedule_sch_unregister(struct ccw_device *);
 int ccw_purge_blacklisted(void);
+void ccw_device_sched_todo(struct ccw_device *cdev, enum cdev_todo todo);
 
 /* Function prototypes for device status and basic sense stuff. */
 void ccw_device_accumulate_irb(struct ccw_device *, struct irb *);
Index: quilt-2.6/drivers/s390/cio/io_sch.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/io_sch.h	2009-11-13 15:48:33.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/io_sch.h	2009-11-13 16:08:18.000000000 +0100
@@ -82,6 +82,15 @@
 	struct ciw ciw[MAX_CIWS];	/* variable # of CIWs */
 }  __attribute__ ((packed, aligned(4)));
 
+enum cdev_todo {
+	CDEV_TODO_NOTHING,
+	CDEV_TODO_ENABLE_CMF,
+	CDEV_TODO_REBIND,
+	CDEV_TODO_REGISTER,
+	CDEV_TODO_UNREG,
+	CDEV_TODO_UNREG_EVAL,
+};
+
 struct ccw_device_private {
 	struct ccw_device *cdev;
 	struct subchannel *sch;
@@ -115,7 +124,8 @@
 	struct senseid senseid;	/* SenseID info */
 	struct pgid pgid[8];	/* path group IDs per chpid*/
 	struct ccw1 iccws[2];	/* ccws for SNID/SID/SPGID commands */
-	struct work_struct kick_work;
+	struct work_struct todo_work;
+	enum cdev_todo todo;
 	wait_queue_head_t wait_q;
 	struct timer_list timer;
 	void *cmb;			/* measurement information */
