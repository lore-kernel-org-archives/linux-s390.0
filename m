Return-Path: <linux-kernel-owner+w=401wt.eu-S1758046AbZFDQ3I@vger.kernel.org>
Message-Id: <20090604161907.309544026@de.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
Date: Thu, 04 Jun 2009 18:19:19 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 32/38] pm: smsgiucv power management callbacks.
Content-Disposition: inline; filename=pm_smsgiucv.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Create dummy iucv-device to get control when the system is suspended
and resumed. Server the smsg iucv path on suspend, reestablish the
path on resume.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 drivers/s390/net/smsgiucv.c |   63 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/s390/net/smsgiucv.c
===================================================================
--- linux-2.6.orig/drivers/s390/net/smsgiucv.c
+++ linux-2.6/drivers/s390/net/smsgiucv.c
@@ -1,7 +1,8 @@
 /*
  * IUCV special message driver
  *
- * Copyright 2003 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ * Copyright IBM Corp. 2003, 2009
+ *
  * Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
  *
  * This program is free software; you can redistribute it and/or modify
@@ -40,6 +41,8 @@ MODULE_AUTHOR
 MODULE_DESCRIPTION ("Linux for S/390 IUCV special message driver");
 
 static struct iucv_path *smsg_path;
+/* dummy device used as trigger for PM functions */
+static struct device *smsg_dev;
 
 static DEFINE_SPINLOCK(smsg_list_lock);
 static LIST_HEAD(smsg_list);
@@ -132,14 +135,51 @@ void smsg_unregister_callback(char *pref
 	kfree(cb);
 }
 
+static int smsg_pm_freeze(struct device *dev)
+{
+#ifdef CONFIG_PM_DEBUG
+	printk(KERN_WARNING "smsg_pm_freeze\n");
+#endif
+	if (smsg_path)
+		iucv_path_sever(smsg_path, NULL);
+	return 0;
+}
+
+static int smsg_pm_restore_thaw(struct device *dev)
+{
+	int rc;
+
+#ifdef CONFIG_PM_DEBUG
+	printk(KERN_WARNING "smsg_pm_restore_thaw\n");
+#endif
+	if (smsg_path) {
+		memset(smsg_path, 0, sizeof(*smsg_path));
+		smsg_path->msglim = 255;
+		smsg_path->flags = 0;
+		rc = iucv_path_connect(smsg_path, &smsg_handler, "*MSG    ",
+				       NULL, NULL, NULL);
+		printk(KERN_ERR "iucv_path_connect returned with rc %i\n", rc);
+	}
+	return 0;
+}
+
+static struct dev_pm_ops smsg_pm_ops = {
+	.freeze = smsg_pm_freeze,
+	.thaw = smsg_pm_restore_thaw,
+	.restore = smsg_pm_restore_thaw,
+};
+
 static struct device_driver smsg_driver = {
+	.owner = THIS_MODULE,
 	.name = "SMSGIUCV",
 	.bus  = &iucv_bus,
+	.pm = &smsg_pm_ops,
 };
 
 static void __exit smsg_exit(void)
 {
 	cpcmd("SET SMSG IUCV", NULL, 0, NULL);
+	device_unregister(smsg_dev);
 	iucv_unregister(&smsg_handler, 1);
 	driver_unregister(&smsg_driver);
 }
@@ -166,12 +206,29 @@ static int __init smsg_init(void)
 	rc = iucv_path_connect(smsg_path, &smsg_handler, "*MSG    ",
 			       NULL, NULL, NULL);
 	if (rc)
-		goto out_free;
+		goto out_free_path;
+	smsg_dev = kzalloc(sizeof(struct device), GFP_KERNEL);
+	if (!smsg_dev) {
+		rc = -ENOMEM;
+		goto out_free_path;
+	}
+	dev_set_name(smsg_dev, "smsg_iucv");
+	smsg_dev->bus = &iucv_bus;
+	smsg_dev->parent = iucv_root;
+	smsg_dev->release = (void (*)(struct device *))kfree;
+	smsg_dev->driver = &smsg_driver;
+	rc = device_register(smsg_dev);
+	if (rc)
+		goto out_free_dev;
+
 	cpcmd("SET SMSG IUCV", NULL, 0, NULL);
 	return 0;
 
-out_free:
+out_free_dev:
+	kfree(smsg_dev);
+out_free_path:
 	iucv_path_free(smsg_path);
+	smsg_path = NULL;
 out_register:
 	iucv_unregister(&smsg_handler, 1);
 out_driver:

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
