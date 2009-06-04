Return-Path: <linux-kernel-owner+w=401wt.eu-S1759672AbZFDQ1w@vger.kernel.org>
Message-Id: <20090604161908.768328886@de.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
Date: Thu, 04 Jun 2009 18:19:25 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 38/38] pm: ap bus power management callbacks
Content-Disposition: inline; filename=pm_ap_bus.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Felix Beck <felix.beck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Felix Beck <felix.beck@de.ibm.com>

Signed-off-by: Felix Beck <felix.beck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 drivers/s390/crypto/ap_bus.c |   85 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/s390/crypto/ap_bus.c
===================================================================
--- linux-2.6.orig/drivers/s390/crypto/ap_bus.c
+++ linux-2.6/drivers/s390/crypto/ap_bus.c
@@ -54,6 +54,12 @@ static int ap_poll_thread_start(void);
 static void ap_poll_thread_stop(void);
 static void ap_request_timeout(unsigned long);
 static inline void ap_schedule_poll_timer(void);
+static int __ap_poll_device(struct ap_device *ap_dev, unsigned long *flags);
+static int ap_device_remove(struct device *dev);
+static int ap_device_probe(struct device *dev);
+static void ap_interrupt_handler(void *unused1, void *unused2);
+static void ap_reset(struct ap_device *ap_dev);
+static void ap_config_timeout(unsigned long ptr);
 
 /*
  * Module description.
@@ -101,6 +107,10 @@ static struct hrtimer ap_poll_timer;
  * If z/VM change to 1500000 nanoseconds to adjust to z/VM polling.*/
 static unsigned long long poll_timeout = 250000;
 
+/* Suspend flag */
+static int ap_suspend_flag;
+static struct bus_type ap_bus_type;
+
 /**
  * ap_using_interrupts() - Returns non-zero if interrupt support is
  * available.
@@ -617,10 +627,79 @@ static int ap_uevent (struct device *dev
 	return retval;
 }
 
+static int ap_bus_suspend(struct device *dev, pm_message_t state)
+{
+	struct ap_device *ap_dev = to_ap_dev(dev);
+	unsigned long flags;
+
+	if (!ap_suspend_flag) {
+		ap_suspend_flag = 1;
+
+		/* Disable scanning for devices, thus we do not want to scan
+		 * for them after removing.
+		 */
+		del_timer_sync(&ap_config_timer);
+		if (ap_work_queue != NULL) {
+			destroy_workqueue(ap_work_queue);
+			ap_work_queue = NULL;
+		}
+		tasklet_disable(&ap_tasklet);
+	}
+	/* Poll on the device until all requests are finished. */
+	do {
+		flags = 0;
+		__ap_poll_device(ap_dev, &flags);
+	} while ((flags & 1) || (flags & 2));
+
+	ap_device_remove(dev);
+	return 0;
+}
+
+static int ap_bus_resume(struct device *dev)
+{
+	int rc = 0;
+	struct ap_device *ap_dev = to_ap_dev(dev);
+
+	if (ap_suspend_flag) {
+		ap_suspend_flag = 0;
+		if (!ap_interrupts_available())
+			ap_interrupt_indicator = NULL;
+		ap_device_probe(dev);
+		ap_reset(ap_dev);
+		setup_timer(&ap_dev->timeout, ap_request_timeout,
+			    (unsigned long) ap_dev);
+		ap_scan_bus(NULL);
+		init_timer(&ap_config_timer);
+		ap_config_timer.function = ap_config_timeout;
+		ap_config_timer.data = 0;
+		ap_config_timer.expires = jiffies + ap_config_time * HZ;
+		add_timer(&ap_config_timer);
+		ap_work_queue = create_singlethread_workqueue("kapwork");
+		if (!ap_work_queue)
+			return -ENOMEM;
+		tasklet_enable(&ap_tasklet);
+		if (!ap_using_interrupts())
+			ap_schedule_poll_timer();
+		else
+			tasklet_schedule(&ap_tasklet);
+		if (ap_thread_flag)
+			rc = ap_poll_thread_start();
+	} else {
+		ap_device_probe(dev);
+		ap_reset(ap_dev);
+		setup_timer(&ap_dev->timeout, ap_request_timeout,
+			    (unsigned long) ap_dev);
+	}
+
+	return rc;
+}
+
 static struct bus_type ap_bus_type = {
 	.name = "ap",
 	.match = &ap_bus_match,
 	.uevent = &ap_uevent,
+	.suspend = ap_bus_suspend,
+	.resume = ap_bus_resume
 };
 
 static int ap_device_probe(struct device *dev)
@@ -1066,7 +1145,7 @@ ap_config_timeout(unsigned long ptr)
  */
 static inline void ap_schedule_poll_timer(void)
 {
-	if (ap_using_interrupts())
+	if (ap_using_interrupts() || ap_suspend_flag)
 		return;
 	if (hrtimer_is_queued(&ap_poll_timer))
 		return;
@@ -1384,6 +1463,8 @@ static int ap_poll_thread(void *data)
 
 	set_user_nice(current, 19);
 	while (1) {
+		if (ap_suspend_flag)
+			return 0;
 		if (need_resched()) {
 			schedule();
 			continue;
@@ -1414,7 +1495,7 @@ static int ap_poll_thread_start(void)
 {
 	int rc;
 
-	if (ap_using_interrupts())
+	if (ap_using_interrupts() || ap_suspend_flag)
 		return 0;
 	mutex_lock(&ap_poll_thread_mutex);
 	if (!ap_poll_kthread) {

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
