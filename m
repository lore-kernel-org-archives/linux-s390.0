Return-Path: <linux-kernel-owner+w=401wt.eu-S1756178AbYE2NEj@vger.kernel.org>
Message-Id: <20080529125730.645201695@de.ibm.com>
References: <20080529125501.196123527@de.ibm.com>
Date: Thu, 29 May 2008 14:55:11 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 10/11] tape: fix race with stack local wait_queue_head_t.
Content-Disposition: inline; filename=010-tape-waitqueue.diff
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
Replace the stack local wait_queue_head_t in tape_do_io and
tape_do_io_interruptible with a per device wait queue.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/tape.h      |    3 +++
 drivers/s390/char/tape_core.c |   16 +++++++---------
 2 files changed, 10 insertions(+), 9 deletions(-)

Index: quilt-2.6/drivers/s390/char/tape_core.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/tape_core.c
+++ quilt-2.6/drivers/s390/char/tape_core.c
@@ -449,6 +449,7 @@ tape_alloc_device(void)
 	INIT_LIST_HEAD(&device->req_queue);
 	INIT_LIST_HEAD(&device->node);
 	init_waitqueue_head(&device->state_change_wq);
+	init_waitqueue_head(&device->wait_queue);
 	device->tape_state = TS_INIT;
 	device->medium_state = MS_UNKNOWN;
 	*device->modeset_byte = 0;
@@ -954,21 +955,19 @@ __tape_wake_up(struct tape_request *requ
 int
 tape_do_io(struct tape_device *device, struct tape_request *request)
 {
-	wait_queue_head_t wq;
 	int rc;
 
-	init_waitqueue_head(&wq);
 	spin_lock_irq(get_ccwdev_lock(device->cdev));
 	/* Setup callback */
 	request->callback = __tape_wake_up;
-	request->callback_data = &wq;
+	request->callback_data = &device->wait_queue;
 	/* Add request to request queue and try to start it. */
 	rc = __tape_start_request(device, request);
 	spin_unlock_irq(get_ccwdev_lock(device->cdev));
 	if (rc)
 		return rc;
 	/* Request added to the queue. Wait for its completion. */
-	wait_event(wq, (request->callback == NULL));
+	wait_event(device->wait_queue, (request->callback == NULL));
 	/* Get rc from request */
 	return request->rc;
 }
@@ -989,20 +988,19 @@ int
 tape_do_io_interruptible(struct tape_device *device,
 			 struct tape_request *request)
 {
-	wait_queue_head_t wq;
 	int rc;
 
-	init_waitqueue_head(&wq);
 	spin_lock_irq(get_ccwdev_lock(device->cdev));
 	/* Setup callback */
 	request->callback = __tape_wake_up_interruptible;
-	request->callback_data = &wq;
+	request->callback_data = &device->wait_queue;
 	rc = __tape_start_request(device, request);
 	spin_unlock_irq(get_ccwdev_lock(device->cdev));
 	if (rc)
 		return rc;
 	/* Request added to the queue. Wait for its completion. */
-	rc = wait_event_interruptible(wq, (request->callback == NULL));
+	rc = wait_event_interruptible(device->wait_queue,
+				      (request->callback == NULL));
 	if (rc != -ERESTARTSYS)
 		/* Request finished normally. */
 		return request->rc;
@@ -1015,7 +1013,7 @@ tape_do_io_interruptible(struct tape_dev
 		/* Wait for the interrupt that acknowledges the halt. */
 		do {
 			rc = wait_event_interruptible(
-				wq,
+				device->wait_queue,
 				(request->callback == NULL)
 			);
 		} while (rc == -ERESTARTSYS);
Index: quilt-2.6/drivers/s390/char/tape.h
===================================================================
--- quilt-2.6.orig/drivers/s390/char/tape.h
+++ quilt-2.6/drivers/s390/char/tape.h
@@ -231,6 +231,9 @@ struct tape_device {
 	/* Request queue. */
 	struct list_head		req_queue;
 
+	/* Request wait queue. */
+	wait_queue_head_t		wait_queue;
+
 	/* Each tape device has (currently) two minor numbers. */
 	int				first_minor;
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
