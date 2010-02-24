Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20100224084448.189096407@de.ibm.com>
Date: Wed, 24 Feb 2010 09:44:36 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 06/32] [PATCH] cio: make wait_events interruptible
References: <20100224084430.193562869@de.ibm.com>
Content-Disposition: inline; filename=105-cio-wait-interruptible.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Sebastian Ott <sebott@linux.vnet.ibm.com>

Make the potentially long blocking wait_event's used by the cio
settle mechanism interruptible.

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/css.c    |   18 ++++++++++++------
 drivers/s390/cio/css.h    |    2 +-
 drivers/s390/cio/device.c |   11 ++++++++---
 3 files changed, 21 insertions(+), 10 deletions(-)

Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c	2010-02-24 09:44:23.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/css.c	2010-02-24 09:44:23.000000000 +0100
@@ -1016,19 +1016,22 @@
 	struct css_driver *cssdrv = to_cssdriver(drv);
 
 	if (cssdrv->settle)
-		cssdrv->settle();
+		return cssdrv->settle();
 	return 0;
 }
 
-static inline void css_complete_work(void)
+static inline int css_complete_work(void)
 {
 	int ret;
 
 	/* Wait for the evaluation of subchannels to finish. */
-	wait_event(css_eval_wq, atomic_read(&css_eval_scheduled) == 0);
+	ret = wait_event_interruptible(css_eval_wq,
+				       atomic_read(&css_eval_scheduled) == 0);
+	if (ret)
+		return -EINTR;
 	flush_workqueue(cio_work_q);
 	/* Wait for the subchannel type specific initialization to finish */
-	ret = bus_for_each_drv(&css_bus_type, NULL, NULL, css_settle);
+	return bus_for_each_drv(&css_bus_type, NULL, NULL, css_settle);
 }
 
 
@@ -1049,10 +1052,13 @@
 static ssize_t cio_settle_write(struct file *file, const char __user *buf,
 				size_t count, loff_t *ppos)
 {
+	int ret;
+
 	/* Handle pending CRW's. */
 	crw_wait_for_channel_report();
-	css_complete_work();
-	return count;
+	ret = css_complete_work();
+
+	return ret ? ret : count;
 }
 
 static const struct file_operations cio_settle_proc_fops = {
Index: quilt-2.6/drivers/s390/cio/css.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.h	2010-02-24 09:44:23.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/css.h	2010-02-24 09:44:23.000000000 +0100
@@ -95,7 +95,7 @@
 	int (*freeze)(struct subchannel *);
 	int (*thaw) (struct subchannel *);
 	int (*restore)(struct subchannel *);
-	void (*settle)(void);
+	int (*settle)(void);
 	const char *name;
 };
 
Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c	2010-02-24 09:44:23.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device.c	2010-02-24 09:44:23.000000000 +0100
@@ -158,11 +158,16 @@
 	return 0;
 }
 
-static void io_subchannel_settle(void)
+static int io_subchannel_settle(void)
 {
-	wait_event(ccw_device_init_wq,
-		   atomic_read(&ccw_device_init_count) == 0);
+	int ret;
+
+	ret = wait_event_interruptible(ccw_device_init_wq,
+				atomic_read(&ccw_device_init_count) == 0);
+	if (ret)
+		return -EINTR;
 	flush_workqueue(cio_work_q);
+	return 0;
 }
 
 static struct css_driver io_subchannel_driver = {
