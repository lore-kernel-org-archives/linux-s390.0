Return-Path: <linux-kernel-owner+w=401wt.eu-S1755723AbZHNL0h@vger.kernel.org>
Message-Id: <20090814112614.182858276@de.ibm.com>
References: <20090814112517.982007860@de.ibm.com>
Date: Fri, 14 Aug 2009 13:25:24 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 07/34] cio: ensure to hold a reference for deferred deregistration
Content-Disposition: inline; filename=106-cio-deferred-deregistration.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Sebastian Ott <sebott@linux.vnet.ibm.com>

Ensure to always hold an extra device reference for scheduling a
subchannel deregistration, by moving the get_device to
ccw_device_schedule_sch_unregister. This fixes an use after free
error in ccw_device_call_sch_unregister where put_device was called
on an already freed device structure.

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c
+++ quilt-2.6/drivers/s390/cio/device.c
@@ -333,15 +333,15 @@ ccw_device_remove_disconnected(struct cc
 	 * Forced offline in disconnected state means
 	 * 'throw away device'.
 	 */
-	/* Get cdev reference for workqueue processing. */
-	if (!get_device(&cdev->dev))
-		return;
 	if (ccw_device_is_orphan(cdev)) {
 		/*
 		 * Deregister ccw device.
 		 * Unfortunately, we cannot do this directly from the
 		 * attribute method.
 		 */
+		/* Get cdev reference for workqueue processing. */
+		if (!get_device(&cdev->dev))
+			return;
 		spin_lock_irqsave(cdev->ccwlock, flags);
 		cdev->private->state = DEV_STATE_NOT_OPER;
 		spin_unlock_irqrestore(cdev->ccwlock, flags);
@@ -1032,6 +1032,9 @@ static void ccw_device_call_sch_unregist
 
 void ccw_device_schedule_sch_unregister(struct ccw_device *cdev)
 {
+	/* Get cdev reference for workqueue processing. */
+	if (!get_device(&cdev->dev))
+		return;
 	PREPARE_WORK(&cdev->private->kick_work,
 		     ccw_device_call_sch_unregister);
 	queue_work(slow_path_wq, &cdev->private->kick_work);
@@ -1052,9 +1055,6 @@ io_subchannel_recog_done(struct ccw_devi
 		/* Device did not respond in time. */
 	case DEV_STATE_NOT_OPER:
 		cdev->private->flags.recog_done = 1;
-		/* Remove device found not operational. */
-		if (!get_device(&cdev->dev))
-			break;
 		ccw_device_schedule_sch_unregister(cdev);
 		if (atomic_dec_and_test(&ccw_device_init_count))
 			wake_up(&ccw_device_init_wq);
@@ -1565,8 +1565,6 @@ static int purge_fn(struct device *dev, 
 	spin_unlock_irq(cdev->ccwlock);
 	if (!unreg)
 		goto out;
-	if (!get_device(&cdev->dev))
-		goto out;
 	CIO_MSG_EVENT(3, "ccw: purging 0.%x.%04x\n", priv->dev_id.ssid,
 		      priv->dev_id.devno);
 	ccw_device_schedule_sch_unregister(cdev);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
