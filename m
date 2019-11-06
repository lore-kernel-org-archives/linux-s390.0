Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:60394 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731914AbfKFPOv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Nov 2019 10:14:51 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4/5] block: fix bdev_disk_changed for non-partitioned devices
Date: Wed,  6 Nov 2019 16:14:38 +0100
Message-Id: <20191106151439.30056-5-hch@lst.de>
In-Reply-To: <20191106151439.30056-1-hch@lst.de>
References: <20191106151439.30056-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Cc: linux-block@vger.kernel.org, linux-s390@vger.kernel.org

We still have to set the capacity to 0 if invalidating or call
revalidate_disk if not even if the disk has no partitions.  Fix
that by merging rescan_partitions into bdev_disk_changed and just
stubbing out blk_add_partitions and blk_drop_partitions for
non-partitioned devices.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/ioctl.c             |  6 ++----
 block/partition-generic.c |  5 +++++
 fs/block_dev.c            | 27 ++++++++-------------------
 include/linux/genhd.h     |  1 +
 4 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 8a7e33ce2097..52380c337078 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -162,16 +162,14 @@ static int blkpg_ioctl(struct block_device *bdev, struct blkpg_ioctl_arg __user
  */
 int __blkdev_reread_part(struct block_device *bdev)
 {
-	struct gendisk *disk = bdev->bd_disk;
-
-	if (!disk_part_scan_enabled(disk) || bdev != bdev->bd_contains)
+	if (!disk_part_scan_enabled(bdev->bd_disk) || bdev != bdev->bd_contains)
 		return -EINVAL;
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
 	lockdep_assert_held(&bdev->bd_mutex);
 
-	return rescan_partitions(disk, bdev, false);
+	return bdev_disk_changed(bdev, false);
 }
 EXPORT_SYMBOL(__blkdev_reread_part);
 
diff --git a/block/partition-generic.c b/block/partition-generic.c
index 7a6e406ac490..387d7e3a6bc4 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -445,6 +445,8 @@ int blk_drop_partitions(struct gendisk *disk, struct block_device *bdev)
 	struct hd_struct *part;
 	int res;
 
+	if (!disk_part_scan_enabled(disk))
+		return 0;
 	if (bdev->bd_part_count || bdev->bd_super)
 		return -EBUSY;
 	res = invalidate_partition(disk, 0);
@@ -578,6 +580,9 @@ int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
 	struct parsed_partitions *state;
 	int ret = -EAGAIN, p, highest;
 
+	if (!disk_part_scan_enabled(disk))
+		return 0;
+
 	state = check_partition(disk, bdev);
 	if (!state)
 		return 0;
diff --git a/fs/block_dev.c b/fs/block_dev.c
index f0710085e1f1..ae16466a67f7 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1508,9 +1508,9 @@ EXPORT_SYMBOL(bd_set_size);
 
 static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part);
 
-static int rescan_partitions(struct gendisk *disk, struct block_device *bdev,
-		bool invalidate)
+int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 {
+	struct gendisk *disk = bdev->bd_disk;
 	int ret;
 
 rescan:
@@ -1526,30 +1526,19 @@ static int rescan_partitions(struct gendisk *disk, struct block_device *bdev,
 	check_disk_size_change(disk, bdev, !invalidate);
 	bdev->bd_invalidated = 0;
 
-	if (!get_capacity(disk)) {
+	if (get_capacity(disk)) {
+		ret = blk_add_partitions(disk, bdev);
+		if (ret == -EAGAIN)
+			goto rescan;
+	} else {
 		/*
 		 * Tell userspace that the media / partition table may have
 		 * changed.
 		 */
 		kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
-		return 0;
 	}
-	
-	ret = blk_add_partitions(disk, bdev);
-	if (ret == -EAGAIN)
-		goto rescan;
-	return ret;
-}
 
-
-static void bdev_disk_changed(struct block_device *bdev, bool invalidate)
-{
-	if (disk_part_scan_enabled(bdev->bd_disk)) {
-		rescan_partitions(bdev->bd_disk, bdev, invalidate);
-	} else {
-		check_disk_size_change(bdev->bd_disk, bdev, !invalidate);
-		bdev->bd_invalidated = 0;
-	}
+	return ret;
 }
 
 /*
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index f5cffbf63abf..8bb63027e4d6 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -621,6 +621,7 @@ extern void blk_invalidate_devt(dev_t devt);
 extern dev_t blk_lookup_devt(const char *name, int partno);
 extern char *disk_name (struct gendisk *hd, int partno, char *buf);
 
+int bdev_disk_changed(struct block_device *bdev, bool invalidate);
 int blk_add_partitions(struct gendisk *disk, struct block_device *bdev);
 int blk_drop_partitions(struct gendisk *disk, struct block_device *bdev);
 extern int disk_expand_part_tbl(struct gendisk *disk, int target);
-- 
2.20.1
