Return-Path: <linux-kernel-owner+w=401wt.eu-S1758071AbYBIMFs@vger.kernel.org>
Message-Id: <20080209120309.506643477@de.ibm.com>
References: <20080209120157.885371603@de.ibm.com>
Date: Sat, 09 Feb 2008 13:02:03 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 06/11] qdio: avoid hang when establishing qdio queues
Content-Disposition: inline; filename=006-qdio-hang.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ursula Braun <braunu@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <braunu@de.ibm.com>

If qdio establish runs in parallel with a channel error,
ccw_device_start_timeout may not trigger the qdio_timeout_handler.
In this case neither QDIO_IRQ_STATE_ESTABLISHED nor
QDIO_IRQ_STATE_ERR is reached and the following wait_event hangs
forever.
Solution: do not make use of the timeout option with
ccw_device_start, but add a timeout to the following wait_event.

Signed-off-by: Ursula Braun <braunu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/qdio.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

Index: quilt-2.6/drivers/s390/cio/qdio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio.c
+++ quilt-2.6/drivers/s390/cio/qdio.c
@@ -3189,13 +3189,11 @@ qdio_establish(struct qdio_initialize *i
 	spin_lock_irqsave(get_ccwdev_lock(cdev),saveflags);
 
 	ccw_device_set_options_mask(cdev, 0);
-	result=ccw_device_start_timeout(cdev,&irq_ptr->ccw,
-					QDIO_DOING_ESTABLISH,0, 0,
-					QDIO_ESTABLISH_TIMEOUT);
+	result = ccw_device_start(cdev, &irq_ptr->ccw,
+				QDIO_DOING_ESTABLISH, 0, 0);
 	if (result) {
-		result2=ccw_device_start_timeout(cdev,&irq_ptr->ccw,
-						 QDIO_DOING_ESTABLISH,0,0,
-						 QDIO_ESTABLISH_TIMEOUT);
+		result2 = ccw_device_start(cdev, &irq_ptr->ccw,
+					QDIO_DOING_ESTABLISH, 0, 0);
 		sprintf(dbf_text,"eq:io%4x",result);
 		QDIO_DBF_TEXT2(1,setup,dbf_text);
 		if (result2) {
@@ -3219,10 +3217,10 @@ qdio_establish(struct qdio_initialize *i
 		return result;
 	}
 	
-	/* Timeout is cared for already by using ccw_device_start_timeout(). */
-	wait_event_interruptible(cdev->private->wait_q,
-		 irq_ptr->state == QDIO_IRQ_STATE_ESTABLISHED ||
-		 irq_ptr->state == QDIO_IRQ_STATE_ERR);
+	wait_event_interruptible_timeout(cdev->private->wait_q,
+		irq_ptr->state == QDIO_IRQ_STATE_ESTABLISHED ||
+		irq_ptr->state == QDIO_IRQ_STATE_ERR,
+		QDIO_ESTABLISH_TIMEOUT);
 
 	if (irq_ptr->state == QDIO_IRQ_STATE_ESTABLISHED)
 		result = 0;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
