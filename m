Return-Path: <linux-kernel-owner+w=401wt.eu-S1756027AbYE2NER@vger.kernel.org>
Message-Id: <20080529125730.405854660@de.ibm.com>
References: <20080529125501.196123527@de.ibm.com>
Date: Thu, 29 May 2008 14:55:10 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 09/11] 3270: fix race with stack local wait_queue_head_t.
Content-Disposition: inline; filename=009-3270-waitqueue.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

A wait_event call with a stack local wait_queue_head_t structure that is
used to do the wake up for the wait_event is inherently racy. After the
wait_event finished the wake_up call might not have completed yet.
Remove the stack local wait_queue_head_t from raw3270_start_init and
use the global raw3270_wait_queue instead.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/raw3270.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

Index: quilt-2.6/drivers/s390/char/raw3270.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/raw3270.c
+++ quilt-2.6/drivers/s390/char/raw3270.c
@@ -549,7 +549,6 @@ raw3270_start_init(struct raw3270 *rp, s
 		   struct raw3270_request *rq)
 {
 	unsigned long flags;
-	wait_queue_head_t wq;
 	int rc;
 
 #ifdef CONFIG_TN3270_CONSOLE
@@ -566,20 +565,20 @@ raw3270_start_init(struct raw3270 *rp, s
 		return rq->rc;
 	}
 #endif
-	init_waitqueue_head(&wq);
 	rq->callback = raw3270_wake_init;
-	rq->callback_data = &wq;
+	rq->callback_data = &raw3270_wait_queue;
 	spin_lock_irqsave(get_ccwdev_lock(view->dev->cdev), flags);
 	rc = __raw3270_start(rp, view, rq);
 	spin_unlock_irqrestore(get_ccwdev_lock(view->dev->cdev), flags);
 	if (rc)
 		return rc;
 	/* Now wait for the completion. */
-	rc = wait_event_interruptible(wq, raw3270_request_final(rq));
+	rc = wait_event_interruptible(raw3270_wait_queue,
+				      raw3270_request_final(rq));
 	if (rc == -ERESTARTSYS) {	/* Interrupted by a signal. */
 		raw3270_halt_io(view->dev, rq);
 		/* No wait for the halt to complete. */
-		wait_event(wq, raw3270_request_final(rq));
+		wait_event(raw3270_wait_queue, raw3270_request_final(rq));
 		return -ERESTARTSYS;
 	}
 	return rq->rc;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
