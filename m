Return-Path: <linux-kernel-owner+w=401wt.eu-S1756934AbZKMPMH@vger.kernel.org>
Message-Id: <20091113150914.851763976@de.ibm.com>
Date: Fri, 13 Nov 2009 16:08:55 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 31/52] [PATCH] cio: inform user when online/offline processing fails
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=130-cio-warn-onoff-fail.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Print a warning message in case a ccw device enters boxed or
not operational state during online/offline processing.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c	2009-11-13 16:08:18.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device.c	2009-11-13 16:08:18.000000000 +0100
@@ -7,6 +7,10 @@
  *		 Cornelia Huck (cornelia.huck@de.ibm.com)
  *		 Martin Schwidefsky (schwidefsky@de.ibm.com)
  */
+
+#define KMSG_COMPONENT "cio"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
@@ -347,6 +351,14 @@
 	spin_unlock_irq(cdev->ccwlock);
 	wait_event(cdev->private->wait_q, (dev_fsm_final_state(cdev) ||
 		   cdev->private->state == DEV_STATE_DISCONNECTED));
+	/* Inform the user if set offline failed. */
+	if (cdev->private->state == DEV_STATE_BOXED) {
+		pr_warning("%s: The device entered boxed state while "
+			   "being set offline\n", dev_name(&cdev->dev));
+	} else if (cdev->private->state == DEV_STATE_NOT_OPER) {
+		pr_warning("%s: The device stopped operating while "
+			   "being set offline\n", dev_name(&cdev->dev));
+	}
 	/* Give up reference from ccw_device_set_online(). */
 	put_device(&cdev->dev);
 	return 0;
@@ -407,6 +419,16 @@
 	if ((cdev->private->state != DEV_STATE_ONLINE) &&
 	    (cdev->private->state != DEV_STATE_W4SENSE)) {
 		spin_unlock_irq(cdev->ccwlock);
+		/* Inform the user that set online failed. */
+		if (cdev->private->state == DEV_STATE_BOXED) {
+			pr_warning("%s: Setting the device online failed "
+				   "because it is boxed\n",
+				   dev_name(&cdev->dev));
+		} else if (cdev->private->state == DEV_STATE_NOT_OPER) {
+			pr_warning("%s: Setting the device online failed "
+				   "because it is not operational\n",
+				   dev_name(&cdev->dev));
+		}
 		/* Give up online reference since onlining failed. */
 		put_device(&cdev->dev);
 		return -ENODEV;
