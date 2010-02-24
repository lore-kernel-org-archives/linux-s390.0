Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20100224084451.020049415@de.ibm.com>
Date: Wed, 24 Feb 2010 09:44:49 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 19/32] [PATCH] ccw_device_notify: improve return codes
References: <20100224084430.193562869@de.ibm.com>
Content-Disposition: inline; filename=118-cio-improve-rc-codes.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Sebastian Ott <sebott@linux.vnet.ibm.com>

Callers of ccw_device_notify could not distinguish between a driver
who has no notifier registered and a driver who doesn't want to keep
a device after a certain event. Change this by adding proper return
codes.

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device.c     |   10 +++++-----
 drivers/s390/cio/device.h     |    2 +-
 drivers/s390/cio/device_fsm.c |   39 +++++++++++++++++++++++++++++++--------
 3 files changed, 37 insertions(+), 14 deletions(-)

Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c	2010-02-24 09:44:23.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device.c	2010-02-24 09:44:26.000000000 +0100
@@ -1338,7 +1338,7 @@
 		/* Not operational. */
 		if (!cdev)
 			return IO_SCH_UNREG;
-		if (!ccw_device_notify(cdev, CIO_GONE))
+		if (ccw_device_notify(cdev, CIO_GONE) != NOTIFY_OK)
 			return IO_SCH_UNREG;
 		return IO_SCH_ORPH_UNREG;
 	}
@@ -1346,12 +1346,12 @@
 	if (!cdev)
 		return IO_SCH_ATTACH;
 	if (sch->schib.pmcw.dev != cdev->private->dev_id.devno) {
-		if (!ccw_device_notify(cdev, CIO_GONE))
+		if (ccw_device_notify(cdev, CIO_GONE) != NOTIFY_OK)
 			return IO_SCH_UNREG_ATTACH;
 		return IO_SCH_ORPH_ATTACH;
 	}
 	if ((sch->schib.pmcw.pam & sch->opm) == 0) {
-		if (!ccw_device_notify(cdev, CIO_NO_PATH))
+		if (ccw_device_notify(cdev, CIO_NO_PATH) != NOTIFY_OK)
 			return IO_SCH_UNREG;
 		return IO_SCH_DISC;
 	}
@@ -1788,7 +1788,7 @@
 static int resume_handle_boxed(struct ccw_device *cdev)
 {
 	cdev->private->state = DEV_STATE_BOXED;
-	if (ccw_device_notify(cdev, CIO_BOXED))
+	if (ccw_device_notify(cdev, CIO_BOXED) == NOTIFY_OK)
 		return 0;
 	ccw_device_sched_todo(cdev, CDEV_TODO_UNREG);
 	return -ENODEV;
@@ -1797,7 +1797,7 @@
 static int resume_handle_disc(struct ccw_device *cdev)
 {
 	cdev->private->state = DEV_STATE_DISCONNECTED;
-	if (ccw_device_notify(cdev, CIO_GONE))
+	if (ccw_device_notify(cdev, CIO_GONE) == NOTIFY_OK)
 		return 0;
 	ccw_device_sched_todo(cdev, CDEV_TODO_UNREG);
 	return -ENODEV;
Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device_fsm.c	2010-02-24 09:44:26.000000000 +0100
@@ -313,21 +313,43 @@
 	}
 }
 
+/**
+  * ccw_device_notify() - inform the device's driver about an event
+  * @cdev: device for which an event occured
+  * @event: event that occurred
+  *
+  * Returns:
+  *   -%EINVAL if the device is offline or has no driver.
+  *   -%EOPNOTSUPP if the device's driver has no notifier registered.
+  *   %NOTIFY_OK if the driver wants to keep the device.
+  *   %NOTIFY_BAD if the driver doesn't want to keep the device.
+  */
 int ccw_device_notify(struct ccw_device *cdev, int event)
 {
+	int ret = -EINVAL;
+
 	if (!cdev->drv)
-		return 0;
+		goto out;
 	if (!cdev->online)
-		return 0;
+		goto out;
 	CIO_MSG_EVENT(2, "notify called for 0.%x.%04x, event=%d\n",
 		      cdev->private->dev_id.ssid, cdev->private->dev_id.devno,
 		      event);
-	return cdev->drv->notify ? cdev->drv->notify(cdev, event) : 0;
+	if (!cdev->drv->notify) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+	if (cdev->drv->notify(cdev, event))
+		ret = NOTIFY_OK;
+	else
+		ret = NOTIFY_BAD;
+out:
+	return ret;
 }
 
 static void ccw_device_oper_notify(struct ccw_device *cdev)
 {
-	if (ccw_device_notify(cdev, CIO_OPER)) {
+	if (ccw_device_notify(cdev, CIO_OPER) == NOTIFY_OK) {
 		/* Reenable channel measurements, if needed. */
 		ccw_device_sched_todo(cdev, CDEV_TODO_ENABLE_CMF);
 		return;
@@ -361,14 +383,15 @@
 	case DEV_STATE_BOXED:
 		CIO_MSG_EVENT(0, "Boxed device %04x on subchannel %04x\n",
 			      cdev->private->dev_id.devno, sch->schid.sch_no);
-		if (cdev->online && !ccw_device_notify(cdev, CIO_BOXED))
+		if (cdev->online &&
+		    ccw_device_notify(cdev, CIO_BOXED) != NOTIFY_OK)
 			ccw_device_sched_todo(cdev, CDEV_TODO_UNREG);
 		cdev->private->flags.donotify = 0;
 		break;
 	case DEV_STATE_NOT_OPER:
 		CIO_MSG_EVENT(0, "Device %04x gone on subchannel %04x\n",
 			      cdev->private->dev_id.devno, sch->schid.sch_no);
-		if (!ccw_device_notify(cdev, CIO_GONE))
+		if (ccw_device_notify(cdev, CIO_GONE) != NOTIFY_OK)
 			ccw_device_sched_todo(cdev, CDEV_TODO_UNREG);
 		else
 			ccw_device_set_disconnected(cdev);
@@ -378,7 +401,7 @@
 		CIO_MSG_EVENT(0, "Disconnected device %04x on subchannel "
 			      "%04x\n", cdev->private->dev_id.devno,
 			      sch->schid.sch_no);
-		if (!ccw_device_notify(cdev, CIO_NO_PATH))
+		if (ccw_device_notify(cdev, CIO_NO_PATH) != NOTIFY_OK)
 			ccw_device_sched_todo(cdev, CDEV_TODO_UNREG);
 		else
 			ccw_device_set_disconnected(cdev);
@@ -586,7 +609,7 @@
 static void ccw_device_generic_notoper(struct ccw_device *cdev,
 				       enum dev_event dev_event)
 {
-	if (!ccw_device_notify(cdev, CIO_GONE))
+	if (ccw_device_notify(cdev, CIO_GONE) != NOTIFY_OK)
 		ccw_device_sched_todo(cdev, CDEV_TODO_UNREG);
 	else
 		ccw_device_set_disconnected(cdev);
Index: quilt-2.6/drivers/s390/cio/device.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.h	2010-02-24 09:44:23.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device.h	2010-02-24 09:44:26.000000000 +0100
@@ -4,7 +4,7 @@
 #include <asm/ccwdev.h>
 #include <asm/atomic.h>
 #include <linux/wait.h>
-
+#include <linux/notifier.h>
 #include "io_sch.h"
 
 /*
