Return-Path: <linux-kernel-owner+w=401wt.eu-S1756991AbZKMPMT@vger.kernel.org>
Message-Id: <20091113150914.465313678@de.ibm.com>
Date: Fri, 13 Nov 2009 16:08:53 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 29/52] [PATCH] cio: introduce subchannel todos
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=128-cio-subchannel-todos.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Ensure that current and future users of sch->work do not overwrite
each other by introducing a single mechanism for delayed subchannel
work.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/cio.h    |    8 ++++++-
 drivers/s390/cio/css.c    |   48 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/s390/cio/css.h    |    3 ++
 drivers/s390/cio/device.c |   23 ++++------------------
 4 files changed, 63 insertions(+), 19 deletions(-)

Index: quilt-2.6/drivers/s390/cio/cio.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.h	2009-11-13 15:48:33.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/cio.h	2009-11-13 16:08:18.000000000 +0100
@@ -68,6 +68,11 @@
 	__u8 mda[4];		 /* model dependent area */
 } __attribute__ ((packed,aligned(4)));
 
+enum sch_todo {
+	SCH_TODO_NOTHING,
+	SCH_TODO_UNREG,
+};
+
 /* subchannel data structure used by I/O subroutines */
 struct subchannel {
 	struct subchannel_id schid;
@@ -95,7 +100,8 @@
 	struct device dev;	/* entry in device tree */
 	struct css_driver *driver;
 	void *private; /* private per subchannel type data */
-	struct work_struct work;
+	enum sch_todo todo;
+	struct work_struct todo_work;
 	struct schib_config config;
 } __attribute__ ((aligned(8)));
 
Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c	2009-11-13 16:08:18.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/css.c	2009-11-13 16:08:18.000000000 +0100
@@ -133,6 +133,8 @@
 	return rc;
 }
 
+static void css_sch_todo(struct work_struct *work);
+
 static struct subchannel *
 css_alloc_subchannel(struct subchannel_id schid)
 {
@@ -147,6 +149,7 @@
 		kfree(sch);
 		return ERR_PTR(ret);
 	}
+	INIT_WORK(&sch->todo_work, css_sch_todo);
 	return sch;
 }
 
@@ -190,6 +193,51 @@
 }
 EXPORT_SYMBOL_GPL(css_sch_device_unregister);
 
+static void css_sch_todo(struct work_struct *work)
+{
+	struct subchannel *sch;
+	enum sch_todo todo;
+
+	sch = container_of(work, struct subchannel, todo_work);
+	/* Find out todo. */
+	spin_lock_irq(sch->lock);
+	todo = sch->todo;
+	CIO_MSG_EVENT(4, "sch_todo: sch=0.%x.%04x, todo=%d\n", sch->schid.ssid,
+		      sch->schid.sch_no, todo);
+	sch->todo = SCH_TODO_NOTHING;
+	spin_unlock_irq(sch->lock);
+	/* Perform todo. */
+	if (todo == SCH_TODO_UNREG)
+		css_sch_device_unregister(sch);
+	/* Release workqueue ref. */
+	put_device(&sch->dev);
+}
+
+/**
+ * css_sched_sch_todo - schedule a subchannel operation
+ * @sch: subchannel
+ * @todo: todo
+ *
+ * Schedule the operation identified by @todo to be performed on the slow path
+ * workqueue. Do nothing if another operation with higher priority is already
+ * scheduled. Needs to be called with subchannel lock held.
+ */
+void css_sched_sch_todo(struct subchannel *sch, enum sch_todo todo)
+{
+	CIO_MSG_EVENT(4, "sch_todo: sched sch=0.%x.%04x todo=%d\n",
+		      sch->schid.ssid, sch->schid.sch_no, todo);
+	if (sch->todo >= todo)
+		return;
+	/* Get workqueue ref. */
+	if (!get_device(&sch->dev))
+		return;
+	sch->todo = todo;
+	if (!queue_work(slow_path_wq, &sch->todo_work)) {
+		/* Already queued, release workqueue ref. */
+		put_device(&sch->dev);
+	}
+}
+
 static void ssd_from_pmcw(struct chsc_ssd_info *ssd, struct pmcw *pmcw)
 {
 	int i;
Index: quilt-2.6/drivers/s390/cio/css.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.h	2009-11-13 15:48:33.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/css.h	2009-11-13 16:08:18.000000000 +0100
@@ -11,6 +11,8 @@
 #include <asm/chpid.h>
 #include <asm/schid.h>
 
+#include "cio.h"
+
 /*
  * path grouping stuff
  */
@@ -151,4 +153,5 @@
 
 extern struct workqueue_struct *slow_path_wq;
 void css_wait_for_slow_path(void);
+void css_sched_sch_todo(struct subchannel *sch, enum sch_todo todo);
 #endif
Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c	2009-11-13 16:08:18.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device.c	2009-11-13 16:08:18.000000000 +0100
@@ -1051,23 +1051,6 @@
 	io_subchannel_init_config(sch);
 }
 
-static void io_subchannel_do_unreg(struct work_struct *work)
-{
-	struct subchannel *sch;
-
-	sch = container_of(work, struct subchannel, work);
-	css_sch_device_unregister(sch);
-	put_device(&sch->dev);
-}
-
-/* Schedule unregister if we have no cdev. */
-static void io_subchannel_schedule_removal(struct subchannel *sch)
-{
-	get_device(&sch->dev);
-	INIT_WORK(&sch->work, io_subchannel_do_unreg);
-	queue_work(slow_path_wq, &sch->work);
-}
-
 /*
  * Note: We always return 0 so that we bind to the device even on error.
  * This is needed so that our remove function is called on unregister.
@@ -1124,7 +1107,9 @@
 	return 0;
 
 out_schedule:
-	io_subchannel_schedule_removal(sch);
+	spin_lock_irq(sch->lock);
+	css_sched_sch_todo(sch, SCH_TODO_UNREG);
+	spin_unlock_irq(sch->lock);
 	return 0;
 }
 
@@ -1469,6 +1454,8 @@
 	spin_lock_irqsave(sch->lock, flags);
 	if (!device_is_registered(&sch->dev))
 		goto out_unlock;
+	if (work_pending(&sch->todo_work))
+		goto out_unlock;
 	action = sch_get_action(sch);
 	CIO_MSG_EVENT(2, "event: sch 0.%x.%04x, process=%d, action=%d\n",
 		      sch->schid.ssid, sch->schid.sch_no, process,
