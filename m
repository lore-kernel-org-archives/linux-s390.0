Return-Path: <linux-kernel-owner+w=401wt.eu-S1759486AbZFDQZy@vger.kernel.org>
Message-Id: <20090604161905.120654825@de.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
Date: Thu, 04 Jun 2009 18:19:10 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 23/38] pm: vmur driver power management callbacks
Content-Disposition: inline; filename=pm_vmur.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Frank Munzert <munzert@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Frank Munzert <munzert@de.ibm.com>

Signed-off-by: Frank Munzert <munzert@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 drivers/s390/char/vmur.c |   26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/s390/char/vmur.c
===================================================================
--- linux-2.6.orig/drivers/s390/char/vmur.c
+++ linux-2.6/drivers/s390/char/vmur.c
@@ -2,7 +2,7 @@
  * Linux driver for System z and s390 unit record devices
  * (z/VM virtual punch, reader, printer)
  *
- * Copyright IBM Corp. 2001, 2007
+ * Copyright IBM Corp. 2001, 2009
  * Authors: Malcolm Beattie <beattiem@uk.ibm.com>
  *	    Michael Holzheu <holzheu@de.ibm.com>
  *	    Frank Munzert <munzert@de.ibm.com>
@@ -60,6 +60,7 @@ static int ur_probe(struct ccw_device *c
 static void ur_remove(struct ccw_device *cdev);
 static int ur_set_online(struct ccw_device *cdev);
 static int ur_set_offline(struct ccw_device *cdev);
+static int ur_pm_suspend(struct ccw_device *cdev);
 
 static struct ccw_driver ur_driver = {
 	.name		= "vmur",
@@ -69,6 +70,7 @@ static struct ccw_driver ur_driver = {
 	.remove		= ur_remove,
 	.set_online	= ur_set_online,
 	.set_offline	= ur_set_offline,
+	.freeze		= ur_pm_suspend,
 };
 
 static DEFINE_MUTEX(vmur_mutex);
@@ -158,6 +160,28 @@ static void urdev_put(struct urdev *urd)
 }
 
 /*
+ * State and contents of ur devices can be changed by class D users issuing
+ * CP commands such as PURGE or TRANSFER, while the Linux guest is suspended.
+ * Also the Linux guest might be logged off, which causes all active spool
+ * files to be closed.
+ * So we cannot guarantee that spool files are still the same when the Linux
+ * guest is resumed. In order to avoid unpredictable results at resume time
+ * we simply refuse to suspend if a ur device node is open.
+ */
+static int ur_pm_suspend(struct ccw_device *cdev)
+{
+	struct urdev *urd = cdev->dev.driver_data;
+
+	TRACE("ur_pm_suspend: cdev=%p\n", cdev);
+	if (urd->open_flag) {
+		pr_err("Unit record device %s is busy, %s refusing to "
+		       "suspend.\n", dev_name(&cdev->dev), ur_banner);
+		return -EBUSY;
+	}
+	return 0;
+}
+
+/*
  * Low-level functions to do I/O to a ur device.
  *     alloc_chan_prog
  *     free_chan_prog

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
