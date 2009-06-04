Return-Path: <linux-kernel-owner+w=401wt.eu-S1759835AbZFDQ12@vger.kernel.org>
Message-Id: <20090604161908.056908485@de.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
Date: Thu, 04 Jun 2009 18:19:22 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 35/38] pm: monwriter power management callbacks.
Content-Disposition: inline; filename=pm_monwriter.patch
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
 drivers/s390/char/monwriter.c |   98 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 92 insertions(+), 6 deletions(-)

Index: linux-2.6/drivers/s390/char/monwriter.c
===================================================================
--- linux-2.6.orig/drivers/s390/char/monwriter.c
+++ linux-2.6/drivers/s390/char/monwriter.c
@@ -1,9 +1,7 @@
 /*
- * drivers/s390/char/monwriter.c
- *
  * Character device driver for writing z/VM *MONITOR service records.
  *
- * Copyright (C) IBM Corp. 2006
+ * Copyright IBM Corp. 2006, 2009
  *
  * Author(s): Melissa Howland <Melissa.Howland@us.ibm.com>
  */
@@ -22,6 +20,7 @@
 #include <linux/ctype.h>
 #include <linux/poll.h>
 #include <linux/mutex.h>
+#include <linux/platform_device.h>
 #include <asm/uaccess.h>
 #include <asm/ebcdic.h>
 #include <asm/io.h>
@@ -40,7 +39,10 @@ struct mon_buf {
 	char *data;
 };
 
+static LIST_HEAD(mon_priv_list);
+
 struct mon_private {
+	struct list_head priv_list;
 	struct list_head list;
 	struct monwrite_hdr hdr;
 	size_t hdr_to_read;
@@ -188,6 +190,7 @@ static int monwrite_open(struct inode *i
 	monpriv->hdr_to_read = sizeof(monpriv->hdr);
 	mutex_init(&monpriv->thread_mutex);
 	filp->private_data = monpriv;
+	list_add_tail(&monpriv->priv_list, &mon_priv_list);
 	unlock_kernel();
 	return nonseekable_open(inode, filp);
 }
@@ -206,6 +209,7 @@ static int monwrite_close(struct inode *
 		kfree(entry->data);
 		kfree(entry);
 	}
+	list_del(&monpriv->priv_list);
 	kfree(monpriv);
 	return 0;
 }
@@ -281,20 +285,102 @@ static struct miscdevice mon_dev = {
 };
 
 /*
+ * suspend/resume
+ */
+
+static int monwriter_freeze(struct device *dev)
+{
+	struct mon_private *monpriv;
+	struct mon_buf *monbuf;
+
+	list_for_each_entry(monpriv, &mon_priv_list, priv_list) {
+		list_for_each_entry(monbuf, &monpriv->list, list) {
+			if (monbuf->hdr.mon_function != MONWRITE_GEN_EVENT)
+				monwrite_diag(&monbuf->hdr, monbuf->data,
+					      APPLDATA_STOP_REC);
+		}
+	}
+	return 0;
+}
+
+static int monwriter_restore(struct device *dev)
+{
+	struct mon_private *monpriv;
+	struct mon_buf *monbuf;
+
+	list_for_each_entry(monpriv, &mon_priv_list, priv_list) {
+		list_for_each_entry(monbuf, &monpriv->list, list) {
+			if (monbuf->hdr.mon_function == MONWRITE_START_INTERVAL)
+				monwrite_diag(&monbuf->hdr, monbuf->data,
+					      APPLDATA_START_INTERVAL_REC);
+			if (monbuf->hdr.mon_function == MONWRITE_START_CONFIG)
+				monwrite_diag(&monbuf->hdr, monbuf->data,
+					      APPLDATA_START_CONFIG_REC);
+		}
+	}
+	return 0;
+}
+
+static int monwriter_thaw(struct device *dev)
+{
+	return monwriter_restore(dev);
+}
+
+static struct dev_pm_ops monwriter_pm_ops = {
+	.freeze		= monwriter_freeze,
+	.thaw		= monwriter_thaw,
+	.restore	= monwriter_restore,
+};
+
+static struct platform_driver monwriter_pdrv = {
+	.driver = {
+		.name	= "monwriter",
+		.owner	= THIS_MODULE,
+		.pm	= &monwriter_pm_ops,
+	},
+};
+
+static struct platform_device *monwriter_pdev;
+
+/*
  * module init/exit
  */
 
 static int __init mon_init(void)
 {
-	if (MACHINE_IS_VM)
-		return misc_register(&mon_dev);
-	else
+	int rc;
+
+	if (!MACHINE_IS_VM)
 		return -ENODEV;
+
+	rc = platform_driver_register(&monwriter_pdrv);
+	if (rc)
+		return rc;
+
+	monwriter_pdev = platform_device_register_simple("monwriter", -1, NULL,
+							0);
+	if (IS_ERR(monwriter_pdev)) {
+		rc = PTR_ERR(monwriter_pdev);
+		goto out_driver;
+	}
+
+	rc = misc_register(&mon_dev);
+	if (rc)
+		goto out_device;
+	return 0;
+
+out_device:
+	platform_device_unregister(monwriter_pdev);
+out_driver:
+	platform_driver_unregister(&monwriter_pdrv);
+	return rc;
 }
 
 static void __exit mon_exit(void)
 {
 	WARN_ON(misc_deregister(&mon_dev) != 0);
+	platform_device_unregister(monwriter_pdev);
+	platform_driver_unregister(&monwriter_pdrv);
 }
 
 module_init(mon_init);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
