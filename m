Return-Path: <linux-kernel-owner+w=401wt.eu-S1758872AbZFDQXj@vger.kernel.org>
Message-Id: <20090604161905.355196091@de.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
Date: Thu, 04 Jun 2009 18:19:11 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 24/38] pm: vmlogrdr power management callbacks
Content-Disposition: inline; filename=pm_vmlogrdr.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Weinhuber <wein@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Weinhuber <wein@de.ibm.com>

Signed-off-by: Stefan Weinhuber <wein@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 drivers/s390/char/vmlogrdr.c |   27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/s390/char/vmlogrdr.c
===================================================================
--- linux-2.6.orig/drivers/s390/char/vmlogrdr.c
+++ linux-2.6/drivers/s390/char/vmlogrdr.c
@@ -3,7 +3,7 @@
  *	character device driver for reading z/VM system service records
  *
  *
- *	Copyright 2004 IBM Corporation
+ *	Copyright IBM Corp. 2004, 2009
  *	character device driver for reading z/VM system service records,
  *	Version 1.0
  *	Author(s): Xenia Tkatschow <xenia@us.ibm.com>
@@ -660,6 +660,29 @@ static struct attribute *vmlogrdr_attrs[
 	NULL,
 };
 
+static int vmlogrdr_pm_prepare(struct device *dev)
+{
+	int rc;
+	struct vmlogrdr_priv_t *priv = dev->driver_data;
+
+	rc = 0;
+	if (priv) {
+		spin_lock_bh(&priv->priv_lock);
+		if (priv->dev_in_use)
+			rc = -EBUSY;
+		spin_unlock_bh(&priv->priv_lock);
+	}
+	if (rc)
+		pr_err("vmlogrdr: device %s is busy. Refuse to suspend.\n",
+		       dev_name(dev));
+	return rc;
+}
+
+
+static struct dev_pm_ops vmlogrdr_pm_ops = {
+	.prepare = vmlogrdr_pm_prepare,
+};
+
 static struct attribute_group vmlogrdr_attr_group = {
 	.attrs = vmlogrdr_attrs,
 };
@@ -668,6 +691,7 @@ static struct class *vmlogrdr_class;
 static struct device_driver vmlogrdr_driver = {
 	.name = "vmlogrdr",
 	.bus  = &iucv_bus,
+	.pm = &vmlogrdr_pm_ops,
 };
 
 
@@ -729,6 +753,7 @@ static int vmlogrdr_register_device(stru
 		dev->bus = &iucv_bus;
 		dev->parent = iucv_root;
 		dev->driver = &vmlogrdr_driver;
+		dev->driver_data = priv;
 		/*
 		 * The release function could be called after the
 		 * module has been unloaded. It's _only_ task is to

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
