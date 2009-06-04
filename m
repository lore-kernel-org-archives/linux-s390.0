Return-Path: <linux-kernel-owner+w=401wt.eu-S1758973AbZFDQXv@vger.kernel.org>
Message-Id: <20090604161908.288290620@de.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
Date: Thu, 04 Jun 2009 18:19:23 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 36/38] pm: monreader power management callbacks.
Content-Disposition: inline; filename=pm_monreader.patch
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
 drivers/s390/char/monreader.c |  140 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 128 insertions(+), 12 deletions(-)

Index: linux-2.6/drivers/s390/char/monreader.c
===================================================================
--- linux-2.6.orig/drivers/s390/char/monreader.c
+++ linux-2.6/drivers/s390/char/monreader.c
@@ -1,10 +1,9 @@
 /*
- * drivers/s390/char/monreader.c
- *
  * Character device driver for reading z/VM *MONITOR service records.
  *
- *   Copyright IBM Corp. 2004, 2008
- *   Author: Gerald Schaefer <gerald.schaefer@de.ibm.com>
+ * Copyright IBM Corp. 2004, 2009
+ *
+ * Author: Gerald Schaefer <gerald.schaefer@de.ibm.com>
  */
 
 #define KMSG_COMPONENT "monreader"
@@ -22,6 +21,7 @@
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/poll.h>
+#include <linux/device.h>
 #include <net/iucv/iucv.h>
 #include <asm/uaccess.h>
 #include <asm/ebcdic.h>
@@ -78,6 +78,7 @@ static u8 user_data_sever[16] = {
 	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
 };
 
+static struct device *monreader_device;
 
 /******************************************************************************
  *                             helper functions                               *
@@ -319,11 +320,12 @@ static int mon_open(struct inode *inode,
 		goto out_path;
 	}
 	filp->private_data = monpriv;
+	monreader_device->driver_data = monpriv;
 	unlock_kernel();
 	return nonseekable_open(inode, filp);
 
 out_path:
-	kfree(monpriv->path);
+	iucv_path_free(monpriv->path);
 out_priv:
 	mon_free_mem(monpriv);
 out_use:
@@ -341,10 +343,13 @@ static int mon_close(struct inode *inode
 	/*
 	 * Close IUCV connection and unregister
 	 */
-	rc = iucv_path_sever(monpriv->path, user_data_sever);
-	if (rc)
-		pr_warning("Disconnecting the z/VM *MONITOR system service "
-			   "failed with rc=%i\n", rc);
+	if (monpriv->path) {
+		rc = iucv_path_sever(monpriv->path, user_data_sever);
+		if (rc)
+			pr_warning("Disconnecting the z/VM *MONITOR system "
+				   "service failed with rc=%i\n", rc);
+		iucv_path_free(monpriv->path);
+	}
 
 	atomic_set(&monpriv->iucv_severed, 0);
 	atomic_set(&monpriv->iucv_connected, 0);
@@ -452,6 +457,94 @@ static struct miscdevice mon_dev = {
 	.minor      = MISC_DYNAMIC_MINOR,
 };
 
+
+/******************************************************************************
+ *                              suspend / resume                              *
+ *****************************************************************************/
+static int monreader_freeze(struct device *dev)
+{
+	struct mon_private *monpriv = dev->driver_data;
+	int rc;
+
+	if (!monpriv)
+		return 0;
+	if (monpriv->path) {
+		rc = iucv_path_sever(monpriv->path, user_data_sever);
+		if (rc)
+			pr_warning("Disconnecting the z/VM *MONITOR system "
+				   "service failed with rc=%i\n", rc);
+		iucv_path_free(monpriv->path);
+	}
+	atomic_set(&monpriv->iucv_severed, 0);
+	atomic_set(&monpriv->iucv_connected, 0);
+	atomic_set(&monpriv->read_ready, 0);
+	atomic_set(&monpriv->msglim_count, 0);
+	monpriv->write_index  = 0;
+	monpriv->read_index   = 0;
+	monpriv->path = NULL;
+	return 0;
+}
+
+static int monreader_thaw(struct device *dev)
+{
+	struct mon_private *monpriv = dev->driver_data;
+	int rc;
+
+	if (!monpriv)
+		return 0;
+	rc = -ENOMEM;
+	monpriv->path = iucv_path_alloc(MON_MSGLIM, IUCV_IPRMDATA, GFP_KERNEL);
+	if (!monpriv->path)
+		goto out;
+	rc = iucv_path_connect(monpriv->path, &monreader_iucv_handler,
+			       MON_SERVICE, NULL, user_data_connect, monpriv);
+	if (rc) {
+		pr_err("Connecting to the z/VM *MONITOR system service "
+		       "failed with rc=%i\n", rc);
+		goto out_path;
+	}
+	wait_event(mon_conn_wait_queue,
+		   atomic_read(&monpriv->iucv_connected) ||
+		   atomic_read(&monpriv->iucv_severed));
+	if (atomic_read(&monpriv->iucv_severed))
+		goto out_path;
+	return 0;
+out_path:
+	rc = -EIO;
+	iucv_path_free(monpriv->path);
+	monpriv->path = NULL;
+out:
+	atomic_set(&monpriv->iucv_severed, 1);
+	return rc;
+}
+
+static int monreader_restore(struct device *dev)
+{
+	int rc;
+
+	segment_unload(mon_dcss_name);
+	rc = segment_load(mon_dcss_name, SEGMENT_SHARED,
+			  &mon_dcss_start, &mon_dcss_end);
+	if (rc < 0) {
+		segment_warning(rc, mon_dcss_name);
+		panic("fatal monreader resume error: no monitor dcss\n");
+	}
+	return monreader_thaw(dev);
+}
+
+static struct dev_pm_ops monreader_pm_ops = {
+	.freeze  = monreader_freeze,
+	.thaw    = monreader_thaw,
+	.restore = monreader_restore,
+};
+
+static struct device_driver monreader_driver = {
+	.name = "monreader",
+	.bus  = &iucv_bus,
+	.pm   = &monreader_pm_ops,
+};
+
+
 /******************************************************************************
  *                              module init/exit                              *
  *****************************************************************************/
@@ -475,16 +568,33 @@ static int __init mon_init(void)
 		return rc;
 	}
 
+	rc = driver_register(&monreader_driver);
+	if (rc)
+		goto out_iucv;
+	monreader_device = kzalloc(sizeof(struct device), GFP_KERNEL);
+	if (!monreader_device)
+		goto out_driver;
+	dev_set_name(monreader_device, "monreader-dev");
+	monreader_device->bus = &iucv_bus;
+	monreader_device->parent = iucv_root;
+	monreader_device->driver = &monreader_driver;
+	monreader_device->release = (void (*)(struct device *))kfree;
+	rc = device_register(monreader_device);
+	if (rc) {
+		kfree(monreader_device);
+		goto out_driver;
+	}
+
 	rc = segment_type(mon_dcss_name);
 	if (rc < 0) {
 		segment_warning(rc, mon_dcss_name);
-		goto out_iucv;
+		goto out_device;
 	}
 	if (rc != SEG_TYPE_SC) {
 		pr_err("The specified *MONITOR DCSS %s does not have the "
 		       "required type SC\n", mon_dcss_name);
 		rc = -EINVAL;
-		goto out_iucv;
+		goto out_device;
 	}
 
 	rc = segment_load(mon_dcss_name, SEGMENT_SHARED,
@@ -492,7 +602,7 @@ static int __init mon_init(void)
 	if (rc < 0) {
 		segment_warning(rc, mon_dcss_name);
 		rc = -EINVAL;
-		goto out_iucv;
+		goto out_device;
 	}
 	dcss_mkname(mon_dcss_name, &user_data_connect[8]);
 
@@ -503,6 +613,10 @@ static int __init mon_init(void)
 
 out:
 	segment_unload(mon_dcss_name);
+out_device:
+	device_unregister(monreader_device);
+out_driver:
+	driver_unregister(&monreader_driver);
 out_iucv:
 	iucv_unregister(&monreader_iucv_handler, 1);
 	return rc;
@@ -512,6 +626,8 @@ static void __exit mon_exit(void)
 {
 	segment_unload(mon_dcss_name);
 	WARN_ON(misc_deregister(&mon_dev) != 0);
+	device_unregister(monreader_device);
+	driver_unregister(&monreader_driver);
 	iucv_unregister(&monreader_iucv_handler, 1);
 	return;
 }

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
