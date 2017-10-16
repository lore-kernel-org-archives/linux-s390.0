Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 16 Oct 2017 16:43:25 -0700
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] s390/cio: Convert timers to use timer_setup()
Message-ID: <20171016234325.GA102019@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

In preparation for unconditionally passing the struct timer_list
pointer to all timer callbacks, switch to using the new timer_setup()
and from_timer() to pass the timer pointer explicitly.

Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/s390/cio/device.c     |  8 ++++----
 drivers/s390/cio/device.h     |  2 ++
 drivers/s390/cio/device_fsm.c | 10 ++++------
 drivers/s390/cio/eadm_sch.c   |  9 ++++-----
 4 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index e5c32f4b5287..318d8269f5de 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -142,7 +142,7 @@ static void io_subchannel_shutdown(struct subchannel *);
 static int io_subchannel_sch_event(struct subchannel *, int);
 static int io_subchannel_chp_event(struct subchannel *, struct chp_link *,
 				   int);
-static void recovery_func(unsigned long data);
+static void recovery_func(struct timer_list *unused);
 
 static struct css_device_id io_subchannel_ids[] = {
 	{ .match_flags = 0x1, .type = SUBCHANNEL_TYPE_IO, },
@@ -194,7 +194,7 @@ int __init io_subchannel_init(void)
 {
 	int ret;
 
-	setup_timer(&recovery_timer, recovery_func, 0);
+	timer_setup(&recovery_timer, recovery_func, 0);
 	ret = bus_register(&ccw_bus_type);
 	if (ret)
 		return ret;
@@ -726,7 +726,7 @@ static int io_subchannel_initialize_dev(struct subchannel *sch,
 	INIT_WORK(&priv->todo_work, ccw_device_todo);
 	INIT_LIST_HEAD(&priv->cmb_list);
 	init_waitqueue_head(&priv->wait_q);
-	init_timer(&priv->timer);
+	timer_setup(&priv->timer, ccw_device_timeout, 0);
 
 	atomic_set(&priv->onoff, 0);
 	cdev->ccwlock = sch->lock;
@@ -1271,7 +1271,7 @@ static void recovery_work_func(struct work_struct *unused)
 
 static DECLARE_WORK(recovery_work, recovery_work_func);
 
-static void recovery_func(unsigned long data)
+static void recovery_func(struct timer_list *unused)
 {
 	/*
 	 * We can't do our recovery in softirq context and it's not
diff --git a/drivers/s390/cio/device.h b/drivers/s390/cio/device.h
index 69cb70f080a5..fef982ce082e 100644
--- a/drivers/s390/cio/device.h
+++ b/drivers/s390/cio/device.h
@@ -3,6 +3,7 @@
 
 #include <asm/ccwdev.h>
 #include <linux/atomic.h>
+#include <linux/timer.h>
 #include <linux/wait.h>
 #include <linux/notifier.h>
 #include <linux/kernel_stat.h>
@@ -133,6 +134,7 @@ int ccw_device_notify(struct ccw_device *, int);
 void ccw_device_set_disconnected(struct ccw_device *cdev);
 void ccw_device_set_notoper(struct ccw_device *cdev);
 
+void ccw_device_timeout(struct timer_list *t);
 void ccw_device_set_timeout(struct ccw_device *, int);
 void ccw_device_schedule_recovery(void);
 
diff --git a/drivers/s390/cio/device_fsm.c b/drivers/s390/cio/device_fsm.c
index f98ea674c3d8..dd7d79d30edc 100644
--- a/drivers/s390/cio/device_fsm.c
+++ b/drivers/s390/cio/device_fsm.c
@@ -91,12 +91,12 @@ static void ccw_timeout_log(struct ccw_device *cdev)
 /*
  * Timeout function. It just triggers a DEV_EVENT_TIMEOUT.
  */
-static void
-ccw_device_timeout(unsigned long data)
+void
+ccw_device_timeout(struct timer_list *t)
 {
-	struct ccw_device *cdev;
+	struct ccw_device_private *priv = from_timer(priv, t, timer);
+	struct ccw_device *cdev = priv->cdev;
 
-	cdev = (struct ccw_device *) data;
 	spin_lock_irq(cdev->ccwlock);
 	if (timeout_log_enabled)
 		ccw_timeout_log(cdev);
@@ -118,8 +118,6 @@ ccw_device_set_timeout(struct ccw_device *cdev, int expires)
 		if (mod_timer(&cdev->private->timer, jiffies + expires))
 			return;
 	}
-	cdev->private->timer.function = ccw_device_timeout;
-	cdev->private->timer.data = (unsigned long) cdev;
 	cdev->private->timer.expires = jiffies + expires;
 	add_timer(&cdev->private->timer);
 }
diff --git a/drivers/s390/cio/eadm_sch.c b/drivers/s390/cio/eadm_sch.c
index 0f11f3bcac82..dbd309d957e0 100644
--- a/drivers/s390/cio/eadm_sch.c
+++ b/drivers/s390/cio/eadm_sch.c
@@ -100,9 +100,10 @@ static int eadm_subchannel_clear(struct subchannel *sch)
 	return 0;
 }
 
-static void eadm_subchannel_timeout(unsigned long data)
+static void eadm_subchannel_timeout(struct timer_list *t)
 {
-	struct subchannel *sch = (struct subchannel *) data;
+	struct eadm_private *private = from_timer(private, t, timer);
+	struct subchannel *sch = private->sch;
 
 	spin_lock_irq(sch->lock);
 	EADM_LOG(1, "timeout");
@@ -124,8 +125,6 @@ static void eadm_subchannel_set_timeout(struct subchannel *sch, int expires)
 		if (mod_timer(&private->timer, jiffies + expires))
 			return;
 	}
-	private->timer.function = eadm_subchannel_timeout;
-	private->timer.data = (unsigned long) sch;
 	private->timer.expires = jiffies + expires;
 	add_timer(&private->timer);
 }
@@ -230,7 +229,7 @@ static int eadm_subchannel_probe(struct subchannel *sch)
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&private->head);
-	init_timer(&private->timer);
+	timer_setup(&private->timer, eadm_subchannel_timeout, 0);
 
 	spin_lock_irq(sch->lock);
 	set_eadm_private(sch, private);
-- 
2.7.4


-- 
Kees Cook
Pixel Security
