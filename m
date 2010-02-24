Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20100224084447.741174357@de.ibm.com>
Date: Wed, 24 Feb 2010 09:44:34 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 04/32] [PATCH] cio: introduce cio_settle
References: <20100224084430.193562869@de.ibm.com>
Content-Disposition: inline; filename=103-cio-cio_settle.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Sebastian Ott <sebott@linux.vnet.ibm.com>

This patch introduces a proc file cio_settle. A write request to
this file is blocked until all queued cio actions are handled.

This will allow userspace to wait for pending work affecting
device availability after changing cio_ignore or the hardware
configuration.

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 Documentation/s390/CommonIO |    6 +++++
 drivers/s390/cio/css.c      |   47 +++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 48 insertions(+), 5 deletions(-)

Index: quilt-2.6/Documentation/s390/CommonIO
===================================================================
--- quilt-2.6.orig/Documentation/s390/CommonIO	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/Documentation/s390/CommonIO	2010-02-24 09:44:23.000000000 +0100
@@ -87,6 +87,12 @@
   compatibility, by the device number in hexadecimal (0xabcd or abcd). Device
   numbers given as 0xabcd will be interpreted as 0.0.abcd.
 
+* /proc/cio_settle
+
+  A write request to this file is blocked until all queued cio actions are
+  handled. This will allow userspace to wait for pending work affecting
+  device availability after changing cio_ignore or the hardware configuration.
+
 * For some of the information present in the /proc filesystem in 2.4 (namely,
   /proc/subchannels and /proc/chpids), see driver-model.txt.
   Information formerly in /proc/irq_count is now in /proc/interrupts.
Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c	2010-02-24 09:44:23.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/css.c	2010-02-24 09:44:23.000000000 +0100
@@ -18,6 +18,7 @@
 #include <linux/list.h>
 #include <linux/reboot.h>
 #include <linux/suspend.h>
+#include <linux/proc_fs.h>
 #include <asm/isc.h>
 #include <asm/crw.h>
 
@@ -1019,6 +1020,18 @@
 	return 0;
 }
 
+static inline void css_complete_work(void)
+{
+	int ret;
+
+	/* Wait for the evaluation of subchannels to finish. */
+	wait_event(css_eval_wq, atomic_read(&css_eval_scheduled) == 0);
+	flush_workqueue(cio_work_q);
+	/* Wait for the subchannel type specific initialization to finish */
+	ret = bus_for_each_drv(&css_bus_type, NULL, NULL, css_settle);
+}
+
+
 /*
  * Wait for the initialization of devices to finish, to make sure we are
  * done with our setup if the search for the root device starts.
@@ -1027,14 +1040,38 @@
 {
 	/* Start initial subchannel evaluation. */
 	css_schedule_eval_all();
-	/* Wait for the evaluation of subchannels to finish. */
-	wait_event(css_eval_wq, atomic_read(&css_eval_scheduled) == 0);
-	flush_workqueue(cio_work_q);
-	/* Wait for the subchannel type specific initialization to finish */
-	return bus_for_each_drv(&css_bus_type, NULL, NULL, css_settle);
+	css_complete_work();
+	return 0;
 }
 subsys_initcall_sync(channel_subsystem_init_sync);
 
+#ifdef CONFIG_PROC_FS
+static ssize_t cio_settle_write(struct file *file, const char __user *buf,
+				size_t count, loff_t *ppos)
+{
+	/* Handle pending CRW's. */
+	crw_wait_for_channel_report();
+	css_complete_work();
+	return count;
+}
+
+static const struct file_operations cio_settle_proc_fops = {
+	.write = cio_settle_write,
+};
+
+static int __init cio_settle_init(void)
+{
+	struct proc_dir_entry *entry;
+
+	entry = proc_create("cio_settle", S_IWUSR, NULL,
+			    &cio_settle_proc_fops);
+	if (!entry)
+		return -ENOMEM;
+	return 0;
+}
+device_initcall(cio_settle_init);
+#endif /*CONFIG_PROC_FS*/
+
 int sch_is_pseudo_sch(struct subchannel *sch)
 {
 	return sch == to_css(sch->dev.parent)->pseudo_subchannel;
