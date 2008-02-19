Return-Path: <linux-kernel-owner+w=401wt.eu-S1759975AbYBSOrM@vger.kernel.org>
Message-Id: <20080219144503.894881790@de.ibm.com>
References: <20080219144047.587547541@de.ibm.com>
Date: Tue, 19 Feb 2008 15:40:52 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 05/13] dasd: fix locking in __dasd_device_process_final_queue
Content-Disposition: inline; filename=005-dasd-locking.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Stefan Weinhuber <wein@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Weinhuber <wein@de.ibm.com>

After setting the status of the cqr and releasing the lock for the
block cqr queue, we call the cqr callback function, which will usually
just trigger the dasd_block_tasklet. But when the tasklet is already
running the cqr might be processed before we invoke the callback
function. In rare cases the callback pointer may already be invalid
by the time we want to call it, which will result in a panic.
Solution: Call the callback function first and then release the lock.

Signed-off-by: Stefan Weinhuber <wein@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Index: quilt-2.6/drivers/s390/block/dasd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd.c
+++ quilt-2.6/drivers/s390/block/dasd.c
@@ -1149,12 +1149,14 @@ static void __dasd_device_process_final_
 {
 	struct list_head *l, *n;
 	struct dasd_ccw_req *cqr;
+	struct dasd_block *block;
 
 	list_for_each_safe(l, n, final_queue) {
 		cqr = list_entry(l, struct dasd_ccw_req, devlist);
 		list_del_init(&cqr->devlist);
-		if (cqr->block)
-			spin_lock_bh(&cqr->block->queue_lock);
+		block = cqr->block;
+		if (block)
+			spin_lock_bh(&block->queue_lock);
 		switch (cqr->status) {
 		case DASD_CQR_SUCCESS:
 			cqr->status = DASD_CQR_DONE;
@@ -1172,15 +1174,13 @@ static void __dasd_device_process_final_
 				    cqr, cqr->status);
 			BUG();
 		}
-		if (cqr->block)
-			spin_unlock_bh(&cqr->block->queue_lock);
 		if (cqr->callback != NULL)
 			(cqr->callback)(cqr, cqr->callback_data);
+		if (block)
+			spin_unlock_bh(&block->queue_lock);
 	}
 }
 
-
-
 /*
  * Take a look at the first request on the ccw queue and check
  * if it reached its expire time. If so, terminate the IO.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
