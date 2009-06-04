Return-Path: <linux-kernel-owner+w=401wt.eu-S1760057AbZFDQ2w@vger.kernel.org>
Message-Id: <20090604161904.626534361@de.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
Date: Thu, 04 Jun 2009 18:19:08 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 21/38] pm: vmwatchdog power management callbacks.
Content-Disposition: inline; filename=pm_vmwatchdog.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

This patch implements suspend/hibernation for the vmwatchdog driver. The 
pm_notifier_callchain is used to get control on PM events. Since watchdog
operation and suspend cannot work together in a reliable fashion, the open
flag is also used to prevent suspend and open from happening at the same
time.
The watchdog can also be active with no open file descriptor. This patch
adds another flag which is only changed in vmwdt_keep_alive and
vmwdt_disable.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 drivers/s390/char/vmwatchdog.c |   81 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 76 insertions(+), 5 deletions(-)

Index: linux-2.6/drivers/s390/char/vmwatchdog.c
===================================================================
--- linux-2.6.orig/drivers/s390/char/vmwatchdog.c
+++ linux-2.6/drivers/s390/char/vmwatchdog.c
@@ -1,17 +1,23 @@
 /*
  * Watchdog implementation based on z/VM Watchdog Timer API
  *
+ * Copyright IBM Corp. 2004,2009
+ *
  * The user space watchdog daemon can use this driver as
  * /dev/vmwatchdog to have z/VM execute the specified CP
  * command when the timeout expires. The default command is
  * "IPL", which which cause an immediate reboot.
  */
+#define KMSG_COMPONENT "vmwatchdog"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/suspend.h>
 #include <linux/watchdog.h>
 #include <linux/smp_lock.h>
 
@@ -43,6 +49,9 @@ static unsigned int vmwdt_interval = 60;
 static unsigned long vmwdt_is_open;
 static int vmwdt_expect_close;
 
+#define VMWDT_OPEN	0	/* devnode is open or suspend in progress */
+#define VMWDT_RUNNING	1	/* The watchdog is armed */
+
 enum vmwdt_func {
 	/* function codes */
 	wdt_init   = 0,
@@ -92,6 +101,7 @@ static int vmwdt_keepalive(void)
 	EBC_TOUPPER(ebc_cmd, MAX_CMDLEN);
 
 	func = vmwdt_conceal ? (wdt_init | wdt_conceal) : wdt_init;
+	set_bit(VMWDT_RUNNING, &vmwdt_is_open);
 	ret = __diag288(func, vmwdt_interval, ebc_cmd, len);
 	WARN_ON(ret != 0);
 	kfree(ebc_cmd);
@@ -102,6 +112,7 @@ static int vmwdt_disable(void)
 {
 	int ret = __diag288(wdt_cancel, 0, "", 0);
 	WARN_ON(ret != 0);
+	clear_bit(VMWDT_RUNNING, &vmwdt_is_open);
 	return ret;
 }
 
@@ -123,13 +134,13 @@ static int vmwdt_open(struct inode *i, s
 {
 	int ret;
 	lock_kernel();
-	if (test_and_set_bit(0, &vmwdt_is_open)) {
+	if (test_and_set_bit(VMWDT_OPEN, &vmwdt_is_open)) {
 		unlock_kernel();
 		return -EBUSY;
 	}
 	ret = vmwdt_keepalive();
 	if (ret)
-		clear_bit(0, &vmwdt_is_open);
+		clear_bit(VMWDT_OPEN, &vmwdt_is_open);
 	unlock_kernel();
 	return ret ? ret : nonseekable_open(i, f);
 }
@@ -139,7 +150,7 @@ static int vmwdt_close(struct inode *i, 
 	if (vmwdt_expect_close == 42)
 		vmwdt_disable();
 	vmwdt_expect_close = 0;
-	clear_bit(0, &vmwdt_is_open);
+	clear_bit(VMWDT_OPEN, &vmwdt_is_open);
 	return 0;
 }
 
@@ -223,6 +234,57 @@ static ssize_t vmwdt_write(struct file *
 	return count;
 }
 
+static int vmwdt_resume(void)
+{
+	clear_bit(VMWDT_OPEN, &vmwdt_is_open);
+	return NOTIFY_DONE;
+}
+
+/*
+ * It makes no sense to go into suspend while the watchdog is running.
+ * Depending on the memory size, the watchdog might trigger, while we
+ * are still saving the memory.
+ * We reuse the open flag to ensure that suspend and watchdog open are
+ * exclusive operations
+ */
+static int vmwdt_suspend(void)
+{
+	if (test_and_set_bit(VMWDT_OPEN, &vmwdt_is_open)) {
+		pr_err("The watchdog is in use. "
+			"This prevents hibernation or suspend.\n");
+		return NOTIFY_BAD;
+	}
+	if (test_bit(VMWDT_RUNNING, &vmwdt_is_open)) {
+		clear_bit(VMWDT_OPEN, &vmwdt_is_open);
+		pr_err("The watchdog is running. "
+			"This prevents hibernation or suspend.\n");
+		return NOTIFY_BAD;
+	}
+	return NOTIFY_DONE;
+}
+
+/*
+ * This function is called for suspend and resume.
+ */
+static int vmwdt_power_event(struct notifier_block *this, unsigned long event,
+			     void *ptr)
+{
+	switch (event) {
+	case PM_POST_HIBERNATION:
+	case PM_POST_SUSPEND:
+		return vmwdt_resume();
+	case PM_HIBERNATION_PREPARE:
+	case PM_SUSPEND_PREPARE:
+		return vmwdt_suspend();
+	default:
+		return NOTIFY_DONE;
+	}
+}
+
+static struct notifier_block vmwdt_power_notifier = {
+	.notifier_call = vmwdt_power_event,
+};
+
 static const struct file_operations vmwdt_fops = {
 	.open    = &vmwdt_open,
 	.release = &vmwdt_close,
@@ -244,12 +306,21 @@ static int __init vmwdt_init(void)
 	ret = vmwdt_probe();
 	if (ret)
 		return ret;
-	return misc_register(&vmwdt_dev);
+	ret = register_pm_notifier(&vmwdt_power_notifier);
+	if (ret)
+		return ret;
+	ret = misc_register(&vmwdt_dev);
+	if (ret) {
+		unregister_pm_notifier(&vmwdt_power_notifier);
+		return ret;
+	}
+	return 0;
 }
 module_init(vmwdt_init);
 
 static void __exit vmwdt_exit(void)
 {
-	WARN_ON(misc_deregister(&vmwdt_dev) != 0);
+	unregister_pm_notifier(&vmwdt_power_notifier);
+	misc_deregister(&vmwdt_dev);
 }
 module_exit(vmwdt_exit);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
