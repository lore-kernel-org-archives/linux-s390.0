Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbhAXKGW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 24 Jan 2021 05:06:22 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 04/10] block: simplify submit_bio_checks a bit
Date: Sun, 24 Jan 2021 11:02:35 +0100
Message-Id: <20210124100241.1167849-5-hch@lst.de>
In-Reply-To: <20210124100241.1167849-1-hch@lst.de>
References: <20210124100241.1167849-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>, Coly Li <colyli@suse.de>, Song Liu <song@kernel.org>, dm-devel@redhat.com, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-s390@vger.kernel.org, linux-block@vger.kernel.org

Merge a few checks for whole devices vs partitions to streamline the
sanity checks.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-core.c | 39 ++++++++++++++-------------------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index a3a54cd86c9c00..64f69022de9627 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -692,9 +692,9 @@ static inline bool should_fail_request(struct block_device *part,
 
 #endif /* CONFIG_FAIL_MAKE_REQUEST */
 
-static inline bool bio_check_ro(struct bio *bio, struct block_device *part)
+static inline bool bio_check_ro(struct bio *bio)
 {
-	if (op_is_write(bio_op(bio)) && bdev_read_only(part)) {
+	if (op_is_write(bio_op(bio)) && bdev_read_only(bio->bi_bdev)) {
 		char b[BDEVNAME_SIZE];
 
 		if (op_is_flush(bio->bi_opf) && !bio_sectors(bio))
@@ -702,7 +702,7 @@ static inline bool bio_check_ro(struct bio *bio, struct block_device *part)
 
 		WARN_ONCE(1,
 		       "Trying to write to read-only block-device %s (partno %d)\n",
-			bio_devname(bio, b), part->bd_partno);
+			bio_devname(bio, b), bio->bi_bdev->bd_partno);
 		/* Older lvm-tools actually trigger this */
 		return false;
 	}
@@ -723,8 +723,9 @@ ALLOW_ERROR_INJECTION(should_fail_bio, ERRNO);
  * This may well happen - the kernel calls bread() without checking the size of
  * the device, e.g., when mounting a file system.
  */
-static inline int bio_check_eod(struct bio *bio, sector_t maxsector)
+static inline int bio_check_eod(struct bio *bio)
 {
+	sector_t maxsector = bdev_nr_sectors(bio->bi_bdev);
 	unsigned int nr_sectors = bio_sectors(bio);
 
 	if (nr_sectors && maxsector &&
@@ -739,28 +740,20 @@ static inline int bio_check_eod(struct bio *bio, sector_t maxsector)
 /*
  * Remap block n of partition p to block n+start(p) of the disk.
  */
-static inline int blk_partition_remap(struct bio *bio)
+static int blk_partition_remap(struct bio *bio)
 {
 	struct block_device *p = bio->bi_bdev;
-	int ret = -EIO;
 
 	if (unlikely(should_fail_request(p, bio->bi_iter.bi_size)))
-		goto out;
-	if (unlikely(bio_check_ro(bio, p)))
-		goto out;
-
+		return -EIO;
 	if (bio_sectors(bio)) {
-		if (bio_check_eod(bio, bdev_nr_sectors(p)))
-			goto out;
 		bio->bi_iter.bi_sector += p->bd_start_sect;
 		trace_block_bio_remap(bio, p->bd_dev,
 				      bio->bi_iter.bi_sector -
 				      p->bd_start_sect);
 	}
 	bio->bi_bdev = bdev_whole(p);
-	ret = 0;
-out:
-	return ret;
+	return 0;
 }
 
 /*
@@ -820,16 +813,12 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 
 	if (should_fail_bio(bio))
 		goto end_io;
-
-	if (bio->bi_bdev->bd_partno) {
-		if (unlikely(blk_partition_remap(bio)))
-			goto end_io;
-	} else {
-		if (unlikely(bio_check_ro(bio, bdev_whole(bdev))))
-			goto end_io;
-		if (unlikely(bio_check_eod(bio, get_capacity(bdev->bd_disk))))
-			goto end_io;
-	}
+	if (unlikely(bio_check_ro(bio)))
+		goto end_io;
+	if (unlikely(bio_check_eod(bio)))
+		goto end_io;
+	if (bio->bi_bdev->bd_partno && unlikely(blk_partition_remap(bio)))
+		goto end_io;
 
 	/*
 	 * Filter flush bio's early so that bio based drivers without flush
-- 
2.29.2
