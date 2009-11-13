Return-Path: <linux-kernel-owner+w=401wt.eu-S1756708AbZKMPO4@vger.kernel.org>
Message-Id: <20091113150917.585541116@de.ibm.com>
Date: Fri, 13 Nov 2009 16:09:10 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 46/52] [PATCH] cio: fix quiesce state
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=145-cio-fix-quiesce-state.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Sebastian Ott <sebott@linux.vnet.ibm.com>

DEV_STATE_QUIESCE is used to stop all IO on a busy subchannel.
This patch fixes the following problems related to the QUIESCE
state:

* Fix a potential race condition which could occur when the
resulting state was DEV_STATE_OFFLINE.

* Add missing locking around cio_disable_subchannel,
ccw_device_cancel_halt_clear and the cdev's handler.

* Loop until we know for sure that the subchannel is disabled.

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device.c     |   35 +++++++++++++++++++----------------
 drivers/s390/cio/device_fsm.c |   17 ++++-------------
 2 files changed, 23 insertions(+), 29 deletions(-)

Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c	2009-11-13 16:08:22.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device.c	2009-11-13 16:08:22.000000000 +0100
@@ -1130,33 +1130,36 @@
 	return 0;
 }
 
-static void
-io_subchannel_shutdown(struct subchannel *sch)
+static void io_subchannel_shutdown(struct subchannel *sch)
 {
 	struct ccw_device *cdev;
 	int ret;
 
+	spin_lock_irq(sch->lock);
 	cdev = sch_get_cdev(sch);
-
 	if (cio_is_console(sch->schid))
-		return;
+		goto out_unlock;
 	if (!sch->schib.pmcw.ena)
-		/* Nothing to do. */
-		return;
+		goto out_unlock;
 	ret = cio_disable_subchannel(sch);
 	if (ret != -EBUSY)
-		/* Subchannel is disabled, we're done. */
-		return;
-	cdev->private->state = DEV_STATE_QUIESCE;
+		goto out_unlock;
 	if (cdev->handler)
-		cdev->handler(cdev, cdev->private->intparm,
-			      ERR_PTR(-EIO));
-	ret = ccw_device_cancel_halt_clear(cdev);
-	if (ret == -EBUSY) {
-		ccw_device_set_timeout(cdev, HZ/10);
-		wait_event(cdev->private->wait_q, dev_fsm_final_state(cdev));
+		cdev->handler(cdev, cdev->private->intparm, ERR_PTR(-EIO));
+	while (ret == -EBUSY) {
+		cdev->private->state = DEV_STATE_QUIESCE;
+		ret = ccw_device_cancel_halt_clear(cdev);
+		if (ret == -EBUSY) {
+			ccw_device_set_timeout(cdev, HZ/10);
+			spin_unlock_irq(sch->lock);
+			wait_event(cdev->private->wait_q,
+				   cdev->private->state != DEV_STATE_QUIESCE);
+			spin_lock_irq(sch->lock);
+		}
+		ret = cio_disable_subchannel(sch);
 	}
-	cio_disable_subchannel(sch);
+out_unlock:
+	spin_unlock_irq(sch->lock);
 }
 
 static int device_is_disconnected(struct ccw_device *cdev)
Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c	2009-11-13 16:08:21.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device_fsm.c	2009-11-13 16:08:22.000000000 +0100
@@ -911,10 +911,7 @@
 ccw_device_quiesce_done(struct ccw_device *cdev, enum dev_event dev_event)
 {
 	ccw_device_set_timeout(cdev, 0);
-	if (dev_event == DEV_EVENT_NOTOPER)
-		cdev->private->state = DEV_STATE_NOT_OPER;
-	else
-		cdev->private->state = DEV_STATE_OFFLINE;
+	cdev->private->state = DEV_STATE_NOT_OPER;
 	wake_up(&cdev->private->wait_q);
 }
 
@@ -924,17 +921,11 @@
 	int ret;
 
 	ret = ccw_device_cancel_halt_clear(cdev);
-	switch (ret) {
-	case 0:
-		cdev->private->state = DEV_STATE_OFFLINE;
-		wake_up(&cdev->private->wait_q);
-		break;
-	case -ENODEV:
+	if (ret == -EBUSY) {
+		ccw_device_set_timeout(cdev, HZ/10);
+	} else {
 		cdev->private->state = DEV_STATE_NOT_OPER;
 		wake_up(&cdev->private->wait_q);
-		break;
-	default:
-		ccw_device_set_timeout(cdev, HZ/10);
 	}
 }
 
