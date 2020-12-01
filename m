Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387673AbgLAQzw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 1 Dec 2020 11:55:52 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 6/9] blk-mq: use ->bi_bdev for I/O accounting
Date: Tue,  1 Dec 2020 17:54:21 +0100
Message-Id: <20201201165424.2030647-7-hch@lst.de>
In-Reply-To: <20201201165424.2030647-1-hch@lst.de>
References: <20201201165424.2030647-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>, Coly Li <colyli@suse.de>, Song Liu <song@kernel.org>, dm-devel@redhat.com, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-s390@vger.kernel.org, linux-block@vger.kernel.org

Remove the reverse map from a sector to a partition for I/O accounting by
simply using ->bi_bdev.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c |  6 +++++-
 block/blk.h      |  2 --
 block/genhd.c    | 48 ------------------------------------------------
 3 files changed, 5 insertions(+), 51 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d53cc887e1b8ea..ad041e903b0a8f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1296,7 +1296,11 @@ void blk_account_io_start(struct request *rq)
 	if (!blk_do_io_stat(rq))
 		return;
 
-	rq->part = disk_map_sector_rcu(rq->rq_disk, blk_rq_pos(rq));
+	/* passthrough requests can hold bios that do not have ->bi_bdev set */
+	if (rq->bio && rq->bio->bi_bdev)
+		rq->part = rq->bio->bi_bdev;
+	else
+		rq->part = rq->rq_disk->part0;
 
 	part_stat_lock();
 	update_io_ticks(rq->part, jiffies, false);
diff --git a/block/blk.h b/block/blk.h
index 64dc8e5a3f44cb..f93a6af04adbd1 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -346,8 +346,6 @@ void blk_queue_free_zone_bitmaps(struct request_queue *q);
 static inline void blk_queue_free_zone_bitmaps(struct request_queue *q) {}
 #endif
 
-struct block_device *disk_map_sector_rcu(struct gendisk *disk, sector_t sector);
-
 int blk_alloc_devt(struct block_device *part, dev_t *devt);
 void blk_free_devt(dev_t devt);
 char *disk_name(struct gendisk *hd, int partno, char *buf);
diff --git a/block/genhd.c b/block/genhd.c
index 57c709a9f90267..3b9cd766d95228 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -280,54 +280,6 @@ void disk_part_iter_exit(struct disk_part_iter *piter)
 }
 EXPORT_SYMBOL_GPL(disk_part_iter_exit);
 
-static inline int sector_in_part(struct block_device *part, sector_t sector)
-{
-	return part->bd_start_sect <= sector &&
-		sector < part->bd_start_sect + bdev_nr_sectors(part);
-}
-
-/**
- * disk_map_sector_rcu - map sector to partition
- * @disk: gendisk of interest
- * @sector: sector to map
- *
- * Find out which partition @sector maps to on @disk.  This is
- * primarily used for stats accounting.
- *
- * CONTEXT:
- * RCU read locked.
- *
- * RETURNS:
- * Found partition on success, part0 is returned if no partition matches
- * or the matched partition is being deleted.
- */
-struct block_device *disk_map_sector_rcu(struct gendisk *disk, sector_t sector)
-{
-	struct disk_part_tbl *ptbl;
-	struct block_device *part;
-	int i;
-
-	rcu_read_lock();
-	ptbl = rcu_dereference(disk->part_tbl);
-
-	part = rcu_dereference(ptbl->last_lookup);
-	if (part && sector_in_part(part, sector))
-		goto out_unlock;
-
-	for (i = 1; i < ptbl->len; i++) {
-		part = rcu_dereference(ptbl->part[i]);
-		if (part && sector_in_part(part, sector)) {
-			rcu_assign_pointer(ptbl->last_lookup, part);
-			goto out_unlock;
-		}
-	}
-
-	part = disk->part0;
-out_unlock:
-	rcu_read_unlock();
-	return part;
-}
-
 /**
  * disk_has_partitions
  * @disk: gendisk of interest
-- 
2.29.2
