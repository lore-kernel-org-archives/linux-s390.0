Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387806AbgK3SEB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 30 Nov 2020 13:04:01 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/5] block: remove the unused block_sleeprq tracepoint
Date: Mon, 30 Nov 2020 18:58:50 +0100
Message-Id: <20201130175854.982460-2-hch@lst.de>
In-Reply-To: <20201130175854.982460-1-hch@lst.de>
References: <20201130175854.982460-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org, linux-raid@vger.kernel.org, linux-s390@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/trace/events/block.h | 18 ------------------
 kernel/trace/blktrace.c      | 22 ----------------------
 2 files changed, 40 deletions(-)

diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 34d64ca306b1c7..76459cf750e14d 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -441,24 +441,6 @@ DEFINE_EVENT(block_get_rq, block_getrq,
 	TP_ARGS(q, bio, rw)
 );
 
-/**
- * block_sleeprq - waiting to get a free request entry in queue for block IO operation
- * @q: queue for operation
- * @bio: pending block IO operation (can be %NULL)
- * @rw: low bit indicates a read (%0) or a write (%1)
- *
- * In the case where a request struct cannot be provided for queue @q
- * the process needs to wait for an request struct to become
- * available.  This tracepoint event is generated each time the
- * process goes to sleep waiting for request struct become available.
- */
-DEFINE_EVENT(block_get_rq, block_sleeprq,
-
-	TP_PROTO(struct request_queue *q, struct bio *bio, int rw),
-
-	TP_ARGS(q, bio, rw)
-);
-
 /**
  * block_plug - keep operations requests in request queue
  * @q: request queue to plug
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index a482a37848bff7..ced589df304b57 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -959,25 +959,6 @@ static void blk_add_trace_getrq(void *ignore,
 	}
 }
 
-
-static void blk_add_trace_sleeprq(void *ignore,
-				  struct request_queue *q,
-				  struct bio *bio, int rw)
-{
-	if (bio)
-		blk_add_trace_bio(q, bio, BLK_TA_SLEEPRQ, 0);
-	else {
-		struct blk_trace *bt;
-
-		rcu_read_lock();
-		bt = rcu_dereference(q->blk_trace);
-		if (bt)
-			__blk_add_trace(bt, 0, 0, rw, 0, BLK_TA_SLEEPRQ,
-					0, 0, NULL, 0);
-		rcu_read_unlock();
-	}
-}
-
 static void blk_add_trace_plug(void *ignore, struct request_queue *q)
 {
 	struct blk_trace *bt;
@@ -1164,8 +1145,6 @@ static void blk_register_tracepoints(void)
 	WARN_ON(ret);
 	ret = register_trace_block_getrq(blk_add_trace_getrq, NULL);
 	WARN_ON(ret);
-	ret = register_trace_block_sleeprq(blk_add_trace_sleeprq, NULL);
-	WARN_ON(ret);
 	ret = register_trace_block_plug(blk_add_trace_plug, NULL);
 	WARN_ON(ret);
 	ret = register_trace_block_unplug(blk_add_trace_unplug, NULL);
@@ -1185,7 +1164,6 @@ static void blk_unregister_tracepoints(void)
 	unregister_trace_block_split(blk_add_trace_split, NULL);
 	unregister_trace_block_unplug(blk_add_trace_unplug, NULL);
 	unregister_trace_block_plug(blk_add_trace_plug, NULL);
-	unregister_trace_block_sleeprq(blk_add_trace_sleeprq, NULL);
 	unregister_trace_block_getrq(blk_add_trace_getrq, NULL);
 	unregister_trace_block_bio_queue(blk_add_trace_bio_queue, NULL);
 	unregister_trace_block_bio_frontmerge(blk_add_trace_bio_frontmerge, NULL);
-- 
2.29.2
