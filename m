Return-Path: <linux-kernel-owner+w=401wt.eu-S1755727AbYE2NE4@vger.kernel.org>
Message-Id: <20080529125730.133176277@de.ibm.com>
References: <20080529125501.196123527@de.ibm.com>
Date: Thu, 29 May 2008 14:55:09 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 08/11] dasd: use a generic wait_queue for sleep_on
Content-Disposition: inline; filename=008-dasd-waitqueue.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Stefan Haberland <stefan.haberland@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Haberland <stefan.haberland@de.ibm.com>

Use a generic wait_queue to prevent the wait_queue in dasd_sleep_on_ 
functions from being referenced by callback_data while it does not
exist any more.

Signed-off-by: Stefan Haberland  <stefan.haberland@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd.c |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

Index: quilt-2.6/drivers/s390/block/dasd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd.c
+++ quilt-2.6/drivers/s390/block/dasd.c
@@ -63,6 +63,7 @@ static void dasd_return_cqr_cb(struct da
  */
 static wait_queue_head_t dasd_init_waitq;
 static wait_queue_head_t dasd_flush_wq;
+static wait_queue_head_t generic_waitq;
 
 /*
  * Allocate memory for a new device structure.
@@ -1151,11 +1152,15 @@ static void __dasd_device_process_final_
 	struct list_head *l, *n;
 	struct dasd_ccw_req *cqr;
 	struct dasd_block *block;
+	void (*callback)(struct dasd_ccw_req *, void *data);
+	void *callback_data;
 
 	list_for_each_safe(l, n, final_queue) {
 		cqr = list_entry(l, struct dasd_ccw_req, devlist);
 		list_del_init(&cqr->devlist);
 		block = cqr->block;
+		callback = cqr->callback;
+		callback_data = cqr->callback_data;
 		if (block)
 			spin_lock_bh(&block->queue_lock);
 		switch (cqr->status) {
@@ -1176,7 +1181,7 @@ static void __dasd_device_process_final_
 			BUG();
 		}
 		if (cqr->callback != NULL)
-			(cqr->callback)(cqr, cqr->callback_data);
+			(callback)(cqr, callback_data);
 		if (block)
 			spin_unlock_bh(&block->queue_lock);
 	}
@@ -1406,17 +1411,15 @@ static inline int _wait_for_wakeup(struc
  */
 int dasd_sleep_on(struct dasd_ccw_req *cqr)
 {
-	wait_queue_head_t wait_q;
 	struct dasd_device *device;
 	int rc;
 
 	device = cqr->startdev;
 
-	init_waitqueue_head (&wait_q);
 	cqr->callback = dasd_wakeup_cb;
-	cqr->callback_data = (void *) &wait_q;
+	cqr->callback_data = (void *) &generic_waitq;
 	dasd_add_request_tail(cqr);
-	wait_event(wait_q, _wait_for_wakeup(cqr));
+	wait_event(generic_waitq, _wait_for_wakeup(cqr));
 
 	/* Request status is either done or failed. */
 	rc = (cqr->status == DASD_CQR_DONE) ? 0 : -EIO;
@@ -1429,20 +1432,18 @@ int dasd_sleep_on(struct dasd_ccw_req *c
  */
 int dasd_sleep_on_interruptible(struct dasd_ccw_req *cqr)
 {
-	wait_queue_head_t wait_q;
 	struct dasd_device *device;
 	int rc;
 
 	device = cqr->startdev;
-	init_waitqueue_head (&wait_q);
 	cqr->callback = dasd_wakeup_cb;
-	cqr->callback_data = (void *) &wait_q;
+	cqr->callback_data = (void *) &generic_waitq;
 	dasd_add_request_tail(cqr);
-	rc = wait_event_interruptible(wait_q, _wait_for_wakeup(cqr));
+	rc = wait_event_interruptible(generic_waitq, _wait_for_wakeup(cqr));
 	if (rc == -ERESTARTSYS) {
 		dasd_cancel_req(cqr);
 		/* wait (non-interruptible) for final status */
-		wait_event(wait_q, _wait_for_wakeup(cqr));
+		wait_event(generic_waitq, _wait_for_wakeup(cqr));
 	}
 	rc = (cqr->status == DASD_CQR_DONE) ? 0 : -EIO;
 	return rc;
@@ -1466,7 +1467,6 @@ static inline int _dasd_term_running_cqr
 
 int dasd_sleep_on_immediatly(struct dasd_ccw_req *cqr)
 {
-	wait_queue_head_t wait_q;
 	struct dasd_device *device;
 	int rc;
 
@@ -1478,9 +1478,8 @@ int dasd_sleep_on_immediatly(struct dasd
 		return rc;
 	}
 
-	init_waitqueue_head (&wait_q);
 	cqr->callback = dasd_wakeup_cb;
-	cqr->callback_data = (void *) &wait_q;
+	cqr->callback_data = (void *) &generic_waitq;
 	cqr->status = DASD_CQR_QUEUED;
 	list_add(&cqr->devlist, &device->ccw_queue);
 
@@ -1489,7 +1488,7 @@ int dasd_sleep_on_immediatly(struct dasd
 
 	spin_unlock_irq(get_ccwdev_lock(device->cdev));
 
-	wait_event(wait_q, _wait_for_wakeup(cqr));
+	wait_event(generic_waitq, _wait_for_wakeup(cqr));
 
 	/* Request status is either done or failed. */
 	rc = (cqr->status == DASD_CQR_DONE) ? 0 : -EIO;
@@ -2430,6 +2429,7 @@ static int __init dasd_init(void)
 
 	init_waitqueue_head(&dasd_init_waitq);
 	init_waitqueue_head(&dasd_flush_wq);
+	init_waitqueue_head(&generic_waitq);
 
 	/* register 'common' DASD debug area, used for all DBF_XXX calls */
 	dasd_debug_area = debug_register("dasd", 1, 1, 8 * sizeof(long));

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
