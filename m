Return-Path: <linux-kernel-owner+w=401wt.eu-S1758667AbZFDQWm@vger.kernel.org>
Message-Id: <20090604161904.863591040@de.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
Date: Thu, 04 Jun 2009 18:19:09 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 22/38] pm: appldata power management callbacks
Content-Disposition: inline; filename=pm_appldata.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Gerald Schaefer <gerald.schaefer@de.ibm.com>

Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/appldata/appldata_base.c |  119 +++++++++++++++++++++++++++++++++++--
 1 file changed, 115 insertions(+), 4 deletions(-)

Index: linux-2.6/arch/s390/appldata/appldata_base.c
===================================================================
--- linux-2.6.orig/arch/s390/appldata/appldata_base.c
+++ linux-2.6/arch/s390/appldata/appldata_base.c
@@ -5,7 +5,7 @@
  * Exports appldata_register_ops() and appldata_unregister_ops() for the
  * data gathering modules.
  *
- * Copyright IBM Corp. 2003, 2008
+ * Copyright IBM Corp. 2003, 2009
  *
  * Author: Gerald Schaefer <gerald.schaefer@de.ibm.com>
  */
@@ -26,6 +26,8 @@
 #include <linux/notifier.h>
 #include <linux/cpu.h>
 #include <linux/workqueue.h>
+#include <linux/suspend.h>
+#include <linux/platform_device.h>
 #include <asm/appldata.h>
 #include <asm/timer.h>
 #include <asm/uaccess.h>
@@ -41,6 +43,9 @@
 
 #define TOD_MICRO	0x01000			/* nr. of TOD clock units
 						   for 1 microsecond */
+
+static struct platform_device *appldata_pdev;
+
 /*
  * /proc entries (sysctl)
  */
@@ -86,6 +91,7 @@ static atomic_t appldata_expire_count = 
 static DEFINE_SPINLOCK(appldata_timer_lock);
 static int appldata_interval = APPLDATA_CPU_INTERVAL;
 static int appldata_timer_active;
+static int appldata_timer_suspended = 0;
 
 /*
  * Work queue
@@ -475,6 +481,93 @@ void appldata_unregister_ops(struct appl
 /********************** module-ops management <END> **************************/
 
 
+/**************************** suspend / resume *******************************/
+static int appldata_freeze(struct device *dev)
+{
+	struct appldata_ops *ops;
+	int rc;
+	struct list_head *lh;
+
+	get_online_cpus();
+	spin_lock(&appldata_timer_lock);
+	if (appldata_timer_active) {
+		__appldata_vtimer_setup(APPLDATA_DEL_TIMER);
+		appldata_timer_suspended = 1;
+	}
+	spin_unlock(&appldata_timer_lock);
+	put_online_cpus();
+
+	mutex_lock(&appldata_ops_mutex);
+	list_for_each(lh, &appldata_ops_list) {
+		ops = list_entry(lh, struct appldata_ops, list);
+		if (ops->active == 1) {
+			rc = appldata_diag(ops->record_nr, APPLDATA_STOP_REC,
+					(unsigned long) ops->data, ops->size,
+					ops->mod_lvl);
+			if (rc != 0)
+				pr_err("Stopping the data collection for %s "
+				       "failed with rc=%d\n", ops->name, rc);
+		}
+	}
+	mutex_unlock(&appldata_ops_mutex);
+	return 0;
+}
+
+static int appldata_restore(struct device *dev)
+{
+	struct appldata_ops *ops;
+	int rc;
+	struct list_head *lh;
+
+	get_online_cpus();
+	spin_lock(&appldata_timer_lock);
+	if (appldata_timer_suspended) {
+		__appldata_vtimer_setup(APPLDATA_ADD_TIMER);
+		appldata_timer_suspended = 0;
+	}
+	spin_unlock(&appldata_timer_lock);
+	put_online_cpus();
+
+	mutex_lock(&appldata_ops_mutex);
+	list_for_each(lh, &appldata_ops_list) {
+		ops = list_entry(lh, struct appldata_ops, list);
+		if (ops->active == 1) {
+			ops->callback(ops->data);	// init record
+			rc = appldata_diag(ops->record_nr,
+					APPLDATA_START_INTERVAL_REC,
+					(unsigned long) ops->data, ops->size,
+					ops->mod_lvl);
+			if (rc != 0) {
+				pr_err("Starting the data collection for %s "
+				       "failed with rc=%d\n", ops->name, rc);
+			}
+		}
+	}
+	mutex_unlock(&appldata_ops_mutex);
+	return 0;
+}
+
+static int appldata_thaw(struct device *dev)
+{
+	return appldata_restore(dev);
+}
+
+static struct dev_pm_ops appldata_pm_ops = {
+	.freeze		= appldata_freeze,
+	.thaw		= appldata_thaw,
+	.restore	= appldata_restore,
+};
+
+static struct platform_driver appldata_pdrv = {
+	.driver = {
+		.name	= "appldata",
+		.owner	= THIS_MODULE,
+		.pm	= &appldata_pm_ops,
+	},
+};
+/************************* suspend / resume <END> ****************************/
+
+
 /******************************* init / exit *********************************/
 
 static void __cpuinit appldata_online_cpu(int cpu)
@@ -531,11 +624,23 @@ static struct notifier_block __cpuinitda
  */
 static int __init appldata_init(void)
 {
-	int i;
+	int i, rc;
 
+	rc = platform_driver_register(&appldata_pdrv);
+	if (rc)
+		return rc;
+
+	appldata_pdev = platform_device_register_simple("appldata", -1, NULL,
+							0);
+	if (IS_ERR(appldata_pdev)) {
+		rc = PTR_ERR(appldata_pdev);
+		goto out_driver;
+	}
 	appldata_wq = create_singlethread_workqueue("appldata");
-	if (!appldata_wq)
-		return -ENOMEM;
+	if (!appldata_wq) {
+		rc = -ENOMEM;
+		goto out_device;
+	}
 
 	get_online_cpus();
 	for_each_online_cpu(i)
@@ -547,6 +652,12 @@ static int __init appldata_init(void)
 
 	appldata_sysctl_header = register_sysctl_table(appldata_dir_table);
 	return 0;
+
+out_device:
+	platform_device_unregister(appldata_pdev);
+out_driver:
+	platform_driver_unregister(&appldata_pdrv);
+	return rc;
 }
 
 __initcall(appldata_init);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
