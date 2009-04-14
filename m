Return-Path: <linux-kernel-owner+w=401wt.eu-S1756728AbZDNN4n@vger.kernel.org>
Message-Id: <20090414135348.073429877@de.ibm.com>
References: <20090414135327.576111185@de.ibm.com>
Date: Tue, 14 Apr 2009 15:53:34 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 07/14] qdio: remove dead timeout handler
Content-Disposition: inline; filename=007-qdio-timeout-handler.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Glauber <jang@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jan Glauber <jang@linux.vnet.ibm.com>

The QDIO ccw devices are started by ccw_device_start so no timeout
can occur for the interrupt handler. Remove the dead code.

In case of an I/O error set the device state to error and wake up
a possibly running qdio_shutdown waiter.

Signed-off-by: Jan Glauber <jang@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/qdio_main.c |   43 ++-----------------------------------------
 1 file changed, 2 insertions(+), 41 deletions(-)

Index: quilt-2.6/drivers/s390/cio/qdio_main.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio_main.c
+++ quilt-2.6/drivers/s390/cio/qdio_main.c
@@ -881,42 +881,6 @@ no_handler:
 	qdio_set_state(irq_ptr, QDIO_IRQ_STATE_STOPPED);
 }
 
-static void qdio_call_shutdown(struct work_struct *work)
-{
-	struct ccw_device_private *priv;
-	struct ccw_device *cdev;
-
-	priv = container_of(work, struct ccw_device_private, kick_work);
-	cdev = priv->cdev;
-	qdio_shutdown(cdev, QDIO_FLAG_CLEANUP_USING_CLEAR);
-	put_device(&cdev->dev);
-}
-
-static void qdio_int_error(struct ccw_device *cdev)
-{
-	struct qdio_irq *irq_ptr = cdev->private->qdio_data;
-
-	switch (irq_ptr->state) {
-	case QDIO_IRQ_STATE_INACTIVE:
-	case QDIO_IRQ_STATE_CLEANUP:
-		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ERR);
-		break;
-	case QDIO_IRQ_STATE_ESTABLISHED:
-	case QDIO_IRQ_STATE_ACTIVE:
-		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_STOPPED);
-		if (get_device(&cdev->dev)) {
-			/* Can't call shutdown from interrupt context. */
-			PREPARE_WORK(&cdev->private->kick_work,
-				     qdio_call_shutdown);
-			queue_work(ccw_device_work, &cdev->private->kick_work);
-		}
-		break;
-	default:
-		WARN_ON(1);
-	}
-	wake_up(&cdev->private->wait_q);
-}
-
 static int qdio_establish_check_errors(struct ccw_device *cdev, int cstat,
 				       int dstat)
 {
@@ -973,10 +937,8 @@ void qdio_int_handler(struct ccw_device 
 		switch (PTR_ERR(irb)) {
 		case -EIO:
 			DBF_ERROR("%4x IO error", irq_ptr->schid.sch_no);
-			return;
-		case -ETIMEDOUT:
-			DBF_ERROR("%4x IO timeout", irq_ptr->schid.sch_no);
-			qdio_int_error(cdev);
+			qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ERR);
+			wake_up(&cdev->private->wait_q);
 			return;
 		default:
 			WARN_ON(1);
@@ -1001,7 +963,6 @@ void qdio_int_handler(struct ccw_device 
 	case QDIO_IRQ_STATE_ACTIVE:
 		if (cstat & SCHN_STAT_PCI) {
 			qdio_int_handler_pci(irq_ptr);
-			/* no state change so no need to wake up wait_q */
 			return;
 		}
 		if ((cstat & ~SCHN_STAT_PCI) || dstat) {

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
