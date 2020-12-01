Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389102AbgLAQzx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 1 Dec 2020 11:55:53 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 8/9] block: remove DISK_PITER_REVERSE
Date: Tue,  1 Dec 2020 17:54:23 +0100
Message-Id: <20201201165424.2030647-9-hch@lst.de>
In-Reply-To: <20201201165424.2030647-1-hch@lst.de>
References: <20201201165424.2030647-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>, Coly Li <colyli@suse.de>, Song Liu <song@kernel.org>, dm-devel@redhat.com, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-s390@vger.kernel.org, linux-block@vger.kernel.org

There is good reason to iterate backwards when deleting all partitions in
del_gendisk, just like we don't in blk_drop_partitions.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c         | 34 ++++------------------------------
 include/linux/genhd.h |  1 -
 2 files changed, 4 insertions(+), 31 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 65dba32df5474f..7730ddabebba92 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -182,24 +182,13 @@ static struct block_device *__disk_get_part(struct gendisk *disk, int partno)
 void disk_part_iter_init(struct disk_part_iter *piter, struct gendisk *disk,
 			  unsigned int flags)
 {
-	struct disk_part_tbl *ptbl;
-
-	rcu_read_lock();
-	ptbl = rcu_dereference(disk->part_tbl);
-
 	piter->disk = disk;
 	piter->part = NULL;
-
-	if (flags & DISK_PITER_REVERSE)
-		piter->idx = ptbl->len - 1;
-	else if (flags & (DISK_PITER_INCL_PART0 | DISK_PITER_INCL_EMPTY_PART0))
+	if (flags & (DISK_PITER_INCL_PART0 | DISK_PITER_INCL_EMPTY_PART0))
 		piter->idx = 0;
 	else
 		piter->idx = 1;
-
 	piter->flags = flags;
-
-	rcu_read_unlock();
 }
 
 /**
@@ -214,7 +203,6 @@ void disk_part_iter_init(struct disk_part_iter *piter, struct gendisk *disk,
 struct block_device *disk_part_iter_next(struct disk_part_iter *piter)
 {
 	struct disk_part_tbl *ptbl;
-	int inc, end;
 
 	/* put the last partition */
 	disk_part_iter_exit(piter);
@@ -223,21 +211,8 @@ struct block_device *disk_part_iter_next(struct disk_part_iter *piter)
 	rcu_read_lock();
 	ptbl = rcu_dereference(piter->disk->part_tbl);
 
-	/* determine iteration parameters */
-	if (piter->flags & DISK_PITER_REVERSE) {
-		inc = -1;
-		if (piter->flags & (DISK_PITER_INCL_PART0 |
-				    DISK_PITER_INCL_EMPTY_PART0))
-			end = -1;
-		else
-			end = 0;
-	} else {
-		inc = 1;
-		end = ptbl->len;
-	}
-
 	/* iterate to the next partition */
-	for (; piter->idx != end; piter->idx += inc) {
+	for (; piter->idx != ptbl->len; piter->idx += 1) {
 		struct block_device *part;
 
 		part = rcu_dereference(ptbl->part[piter->idx]);
@@ -252,7 +227,7 @@ struct block_device *disk_part_iter_next(struct disk_part_iter *piter)
 		piter->part = bdgrab(part);
 		if (!piter->part)
 			continue;
-		piter->idx += inc;
+		piter->idx += 1;
 		break;
 	}
 
@@ -776,8 +751,7 @@ void del_gendisk(struct gendisk *disk)
 	down_write(&bdev_lookup_sem);
 
 	/* invalidate stuff */
-	disk_part_iter_init(&piter, disk,
-			     DISK_PITER_INCL_EMPTY | DISK_PITER_REVERSE);
+	disk_part_iter_init(&piter, disk, DISK_PITER_INCL_EMPTY);
 	while ((part = disk_part_iter_next(&piter))) {
 		invalidate_partition(part);
 		delete_partition(part);
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 191f5e4ae4e93b..425956ac9315fa 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -217,7 +217,6 @@ void disk_uevent(struct gendisk *disk, enum kobject_action action);
 /*
  * Smarter partition iterator without context limits.
  */
-#define DISK_PITER_REVERSE	(1 << 0) /* iterate in the reverse direction */
 #define DISK_PITER_INCL_EMPTY	(1 << 1) /* include 0-sized parts */
 #define DISK_PITER_INCL_PART0	(1 << 2) /* include partition 0 */
 #define DISK_PITER_INCL_EMPTY_PART0 (1 << 3) /* include empty partition 0 */
-- 
2.29.2
