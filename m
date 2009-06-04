Return-Path: <linux-kernel-owner+w=401wt.eu-S1758731AbZFDQWx@vger.kernel.org>
Message-Id: <20090604161905.585166832@de.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
Date: Thu, 04 Jun 2009 18:19:12 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 25/38] pm: tape power management callbacks
Content-Disposition: inline; filename=pm_tape.patch
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
 drivers/s390/char/tape.h      |    3 +-
 drivers/s390/char/tape_34xx.c |    3 +-
 drivers/s390/char/tape_3590.c |    3 +-
 drivers/s390/char/tape_core.c |   52 +++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 57 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/s390/char/tape.h
===================================================================
--- linux-2.6.orig/drivers/s390/char/tape.h
+++ linux-2.6/drivers/s390/char/tape.h
@@ -3,7 +3,7 @@
  *    tape device driver for 3480/3490E/3590 tapes.
  *
  *  S390 and zSeries version
- *    Copyright IBM Corp. 2001,2006
+ *    Copyright IBM Corp. 2001, 2009
  *    Author(s): Carsten Otte <cotte@de.ibm.com>
  *		 Tuan Ngo-Anh <ngoanh@de.ibm.com>
  *		 Martin Schwidefsky <schwidefsky@de.ibm.com>
@@ -286,6 +286,7 @@ extern void tape_state_set(struct tape_d
 
 extern int tape_generic_online(struct tape_device *, struct tape_discipline *);
 extern int tape_generic_offline(struct ccw_device *);
+extern int tape_generic_pm_suspend(struct ccw_device *);
 
 /* Externals from tape_devmap.c */
 extern int tape_generic_probe(struct ccw_device *);
Index: linux-2.6/drivers/s390/char/tape_34xx.c
===================================================================
--- linux-2.6.orig/drivers/s390/char/tape_34xx.c
+++ linux-2.6/drivers/s390/char/tape_34xx.c
@@ -2,7 +2,7 @@
  *  drivers/s390/char/tape_34xx.c
  *    tape device discipline for 3480/3490 tapes.
  *
- *    Copyright (C) IBM Corp. 2001,2006
+ *    Copyright IBM Corp. 2001, 2009
  *    Author(s): Carsten Otte <cotte@de.ibm.com>
  *		 Tuan Ngo-Anh <ngoanh@de.ibm.com>
  *		 Martin Schwidefsky <schwidefsky@de.ibm.com>
@@ -1302,6 +1302,7 @@ static struct ccw_driver tape_34xx_drive
 	.remove = tape_generic_remove,
 	.set_online = tape_34xx_online,
 	.set_offline = tape_generic_offline,
+	.freeze = tape_generic_pm_suspend,
 };
 
 static int
Index: linux-2.6/drivers/s390/char/tape_3590.c
===================================================================
--- linux-2.6.orig/drivers/s390/char/tape_3590.c
+++ linux-2.6/drivers/s390/char/tape_3590.c
@@ -2,7 +2,7 @@
  *  drivers/s390/char/tape_3590.c
  *    tape device discipline for 3590 tapes.
  *
- *    Copyright IBM Corp. 2001,2006
+ *    Copyright IBM Corp. 2001, 2009
  *    Author(s): Stefan Bader <shbader@de.ibm.com>
  *		 Michael Holzheu <holzheu@de.ibm.com>
  *		 Martin Schwidefsky <schwidefsky@de.ibm.com>
@@ -1715,6 +1715,7 @@ static struct ccw_driver tape_3590_drive
 	.remove = tape_generic_remove,
 	.set_offline = tape_generic_offline,
 	.set_online = tape_3590_online,
+	.freeze = tape_generic_pm_suspend,
 };
 
 /*
Index: linux-2.6/drivers/s390/char/tape_core.c
===================================================================
--- linux-2.6.orig/drivers/s390/char/tape_core.c
+++ linux-2.6/drivers/s390/char/tape_core.c
@@ -3,7 +3,7 @@
  *    basic function of the tape device driver
  *
  *  S390 and zSeries version
- *    Copyright IBM Corp. 2001,2006
+ *    Copyright IBM Corp. 2001, 2009
  *    Author(s): Carsten Otte <cotte@de.ibm.com>
  *		 Michael Holzheu <holzheu@de.ibm.com>
  *		 Tuan Ngo-Anh <ngoanh@de.ibm.com>
@@ -380,6 +380,55 @@ tape_cleanup_device(struct tape_device *
 }
 
 /*
+ * Suspend device.
+ *
+ * Called by the common I/O layer if the drive should be suspended on user
+ * request. We refuse to suspend if the device is loaded or in use for the
+ * following reason:
+ * While the Linux guest is suspended, it might be logged off which causes
+ * devices to be detached. Tape devices are automatically rewound and unloaded
+ * during DETACH processing (unless the tape device was attached with the
+ * NOASSIGN or MULTIUSER option). After rewind/unload, there is no way to
+ * resume the original state of the tape device, since we would need to
+ * manually re-load the cartridge which was active at suspend time.
+ */
+int tape_generic_pm_suspend(struct ccw_device *cdev)
+{
+	struct tape_device *device;
+
+	device = cdev->dev.driver_data;
+	if (!device) {
+		return -ENODEV;
+	}
+
+	DBF_LH(3, "(%08x): tape_generic_pm_suspend(%p)\n",
+		device->cdev_id, device);
+
+	if (device->medium_state != MS_UNLOADED) {
+		pr_err("A cartridge is loaded in tape device %s, "
+		       "refusing to suspend\n", dev_name(&cdev->dev));
+		return -EBUSY;
+	}
+
+	spin_lock_irq(get_ccwdev_lock(device->cdev));
+	switch (device->tape_state) {
+		case TS_INIT:
+		case TS_NOT_OPER:
+		case TS_UNUSED:
+			spin_unlock_irq(get_ccwdev_lock(device->cdev));
+			break;
+		default:
+			pr_err("Tape device %s is busy, refusing to "
+			       "suspend\n", dev_name(&cdev->dev));
+			spin_unlock_irq(get_ccwdev_lock(device->cdev));
+			return -EBUSY;
+	}
+
+	DBF_LH(3, "(%08x): Drive suspended.\n", device->cdev_id);
+	return 0;
+}
+
+/*
  * Set device offline.
  *
  * Called by the common I/O layer if the drive should set offline on user
@@ -1273,6 +1322,7 @@ EXPORT_SYMBOL(tape_generic_remove);
 EXPORT_SYMBOL(tape_generic_probe);
 EXPORT_SYMBOL(tape_generic_online);
 EXPORT_SYMBOL(tape_generic_offline);
+EXPORT_SYMBOL(tape_generic_pm_suspend);
 EXPORT_SYMBOL(tape_put_device);
 EXPORT_SYMBOL(tape_get_device_reference);
 EXPORT_SYMBOL(tape_state_verbose);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
