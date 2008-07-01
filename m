Return-Path: <linux-kernel-owner+w=401wt.eu-S1757415AbYGAMyy@vger.kernel.org>
Message-Id: <20080701125000.522100111@de.ibm.com>
References: <20080701124809.319736054@de.ibm.com>
Date: Tue, 01 Jul 2008 14:48:21 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 12/14] ap: Use high-resolution timer for polling
Content-Disposition: inline; filename=131-ap-hrtimer.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Felix Beck <felix.beck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Felix Beck <felix.beck@de.ibm.com>

The ap poll mechanism is converted to use a high-resolution timer for
polling. This allows more specific polling. With this a new sysfs
attribute is introduced to specify the polling rate in nanoseconds.

Signed-off-by: Felix Beck <felix.beck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/crypto/ap_bus.c |   63 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 10 deletions(-)

Index: quilt-2.6/drivers/s390/crypto/ap_bus.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/ap_bus.c
+++ quilt-2.6/drivers/s390/crypto/ap_bus.c
@@ -34,13 +34,15 @@
 #include <linux/mutex.h>
 #include <asm/s390_rdev.h>
 #include <asm/reset.h>
+#include <linux/hrtimer.h>
+#include <linux/ktime.h>
 
 #include "ap_bus.h"
 
 /* Some prototypes. */
 static void ap_scan_bus(struct work_struct *);
 static void ap_poll_all(unsigned long);
-static void ap_poll_timeout(unsigned long);
+static enum hrtimer_restart ap_poll_timeout(struct hrtimer *);
 static int ap_poll_thread_start(void);
 static void ap_poll_thread_stop(void);
 static void ap_request_timeout(unsigned long);
@@ -80,12 +82,15 @@ static DECLARE_WORK(ap_config_work, ap_s
 /*
  * Tasklet & timer for AP request polling.
  */
-static struct timer_list ap_poll_timer = TIMER_INITIALIZER(ap_poll_timeout,0,0);
 static DECLARE_TASKLET(ap_tasklet, ap_poll_all, 0);
 static atomic_t ap_poll_requests = ATOMIC_INIT(0);
 static DECLARE_WAIT_QUEUE_HEAD(ap_poll_wait);
 static struct task_struct *ap_poll_kthread = NULL;
 static DEFINE_MUTEX(ap_poll_thread_mutex);
+static struct hrtimer ap_poll_timer;
+/* In LPAR poll with 4kHz frequency. Poll every 250000 nanoseconds.
+ * If z/VM change to 1500000 nanoseconds to adjust to z/VM polling.*/
+static unsigned long long poll_timeout = 250000;
 
 /**
  * ap_intructions_available() - Test if AP instructions are available.
@@ -636,11 +641,39 @@ static ssize_t ap_poll_thread_store(stru
 
 static BUS_ATTR(poll_thread, 0644, ap_poll_thread_show, ap_poll_thread_store);
 
+static ssize_t poll_timeout_show(struct bus_type *bus, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%llu\n", poll_timeout);
+}
+
+static ssize_t poll_timeout_store(struct bus_type *bus, const char *buf,
+				  size_t count)
+{
+	unsigned long long time;
+	ktime_t hr_time;
+
+	/* 120 seconds = maximum poll interval */
+	if (sscanf(buf, "%llu\n", &time) != 1 || time < 1 || time > 120000000000)
+		return -EINVAL;
+	poll_timeout = time;
+	hr_time = ktime_set(0, poll_timeout);
+
+	if (!hrtimer_is_queued(&ap_poll_timer) ||
+	    !hrtimer_forward(&ap_poll_timer, ap_poll_timer.expires, hr_time)) {
+		ap_poll_timer.expires = hr_time;
+		hrtimer_start(&ap_poll_timer, hr_time, HRTIMER_MODE_ABS);
+	}
+	return count;
+}
+
+static BUS_ATTR(poll_timeout, 0644, poll_timeout_show, poll_timeout_store);
+
 static struct bus_attribute *const ap_bus_attrs[] = {
 	&bus_attr_ap_domain,
 	&bus_attr_config_time,
 	&bus_attr_poll_thread,
-	NULL
+	&bus_attr_poll_timeout,
+	NULL,
 };
 
 /**
@@ -895,9 +928,10 @@ ap_config_timeout(unsigned long ptr)
  */
 static inline void ap_schedule_poll_timer(void)
 {
-	if (timer_pending(&ap_poll_timer))
+	if (hrtimer_is_queued(&ap_poll_timer))
 		return;
-	mod_timer(&ap_poll_timer, jiffies + AP_POLL_TIME);
+	hrtimer_start(&ap_poll_timer, ktime_set(0, poll_timeout),
+		      HRTIMER_MODE_ABS);
 }
 
 /**
@@ -1115,13 +1149,14 @@ EXPORT_SYMBOL(ap_cancel_message);
 
 /**
  * ap_poll_timeout(): AP receive polling for finished AP requests.
- * @unused: Unused variable.
+ * @unused: Unused pointer.
  *
- * Schedules the AP tasklet.
+ * Schedules the AP tasklet using a high resolution timer.
  */
-static void ap_poll_timeout(unsigned long unused)
+static enum hrtimer_restart ap_poll_timeout(struct hrtimer *unused)
 {
 	tasklet_schedule(&ap_tasklet);
+	return HRTIMER_NORESTART;
 }
 
 /**
@@ -1344,6 +1379,14 @@ int __init ap_module_init(void)
 	ap_config_timer.expires = jiffies + ap_config_time * HZ;
 	add_timer(&ap_config_timer);
 
+	/* Setup the high resultion poll timer.
+	 * If we are running under z/VM adjust polling to z/VM polling rate.
+	 */
+	if (MACHINE_IS_VM)
+		poll_timeout = 1500000;
+	hrtimer_init(&ap_poll_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+	ap_poll_timer.function = ap_poll_timeout;
+
 	/* Start the low priority AP bus poll thread. */
 	if (ap_thread_flag) {
 		rc = ap_poll_thread_start();
@@ -1355,7 +1398,7 @@ int __init ap_module_init(void)
 
 out_work:
 	del_timer_sync(&ap_config_timer);
-	del_timer_sync(&ap_poll_timer);
+	hrtimer_cancel(&ap_poll_timer);
 	destroy_workqueue(ap_work_queue);
 out_root:
 	s390_root_dev_unregister(ap_root_device);
@@ -1386,7 +1429,7 @@ void ap_module_exit(void)
 	ap_reset_domain();
 	ap_poll_thread_stop();
 	del_timer_sync(&ap_config_timer);
-	del_timer_sync(&ap_poll_timer);
+	hrtimer_cancel(&ap_poll_timer);
 	destroy_workqueue(ap_work_queue);
 	tasklet_kill(&ap_tasklet);
 	s390_root_dev_unregister(ap_root_device);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
