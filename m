Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389361AbgLCQWd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 3 Dec 2020 11:22:33 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/5] block: remove the request_queue argument to the block_split tracepoint
Date: Thu,  3 Dec 2020 17:21:37 +0100
Message-Id: <20201203162139.2110977-4-hch@lst.de>
In-Reply-To: <20201203162139.2110977-1-hch@lst.de>
References: <20201203162139.2110977-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>, dm-devel@redhat.com, linux-block@vger.kernel.org, linux-raid@vger.kernel.org, linux-s390@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>, Hannes Reinecke <hare@suse.de>

The request_queue can trivially be derived from the bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-merge.c            |  2 +-
 drivers/md/dm.c              |  2 +-
 include/trace/events/block.h | 14 ++++++--------
 kernel/trace/blktrace.c      |  5 ++---
 4 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 1a46d5bbd399e3..4071daa88a5eaf 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -338,7 +338,7 @@ void __blk_queue_split(struct bio **bio, unsigned int *nr_segs)
 		split->bi_opf |= REQ_NOMERGE;
 
 		bio_chain(split, *bio);
-		trace_block_split(q, split, (*bio)->bi_iter.bi_sector);
+		trace_block_split(split, (*bio)->bi_iter.bi_sector);
 		submit_bio_noacct(*bio);
 		*bio = split;
 	}
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index ed7e836efbcdbc..9a5bd90779c7c4 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1612,7 +1612,7 @@ static blk_qc_t __split_and_process_bio(struct mapped_device *md,
 				part_stat_unlock();
 
 				bio_chain(b, bio);
-				trace_block_split(md->queue, b, bio->bi_iter.bi_sector);
+				trace_block_split(b, bio->bi_iter.bi_sector);
 				ret = submit_bio_noacct(bio);
 				break;
 			}
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 506c29dc7c76fd..b415e4cba84304 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -411,21 +411,19 @@ DEFINE_EVENT(block_unplug, block_unplug,
 
 /**
  * block_split - split a single bio struct into two bio structs
- * @q: queue containing the bio
  * @bio: block operation being split
  * @new_sector: The starting sector for the new bio
  *
- * The bio request @bio in request queue @q needs to be split into two
- * bio requests. The newly created @bio request starts at
- * @new_sector. This split may be required due to hardware limitation
- * such as operation crossing device boundaries in a RAID system.
+ * The bio request @bio needs to be split into two bio requests.  The newly
+ * created @bio request starts at @new_sector. This split may be required due to
+ * hardware limitations such as operation crossing device boundaries in a RAID
+ * system.
  */
 TRACE_EVENT(block_split,
 
-	TP_PROTO(struct request_queue *q, struct bio *bio,
-		 unsigned int new_sector),
+	TP_PROTO(struct bio *bio, unsigned int new_sector),
 
-	TP_ARGS(q, bio, new_sector),
+	TP_ARGS(bio, new_sector),
 
 	TP_STRUCT__entry(
 		__field( dev_t,		dev				)
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 7ab88e00c15765..3ca6d62114f461 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -970,10 +970,9 @@ static void blk_add_trace_unplug(void *ignore, struct request_queue *q,
 	rcu_read_unlock();
 }
 
-static void blk_add_trace_split(void *ignore,
-				struct request_queue *q, struct bio *bio,
-				unsigned int pdu)
+static void blk_add_trace_split(void *ignore, struct bio *bio, unsigned int pdu)
 {
+	struct request_queue *q = bio->bi_disk->queue;
 	struct blk_trace *bt;
 
 	rcu_read_lock();
-- 
2.29.2
