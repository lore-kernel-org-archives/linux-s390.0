Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:60388 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfKFPOt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Nov 2019 10:14:49 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/5] block: move rescan_partitions to fs/block_dev.c
Date: Wed,  6 Nov 2019 16:14:37 +0100
Message-Id: <20191106151439.30056-4-hch@lst.de>
In-Reply-To: <20191106151439.30056-1-hch@lst.de>
References: <20191106151439.30056-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Cc: linux-block@vger.kernel.org, linux-s390@vger.kernel.org

Large parts of rescan_partitions aren't about partitions, and
moving it to block_dev.c will allow for some further cleanups by
merging it into its only caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partition-generic.c | 37 ++-----------------------------------
 fs/block_dev.c            | 38 ++++++++++++++++++++++++++++++++++++--
 include/linux/fs.h        |  2 --
 include/linux/genhd.h     |  4 ++--
 4 files changed, 40 insertions(+), 41 deletions(-)

diff --git a/block/partition-generic.c b/block/partition-generic.c
index eae9daa8a523..7a6e406ac490 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -439,7 +439,7 @@ static bool disk_unlock_native_capacity(struct gendisk *disk)
 	}
 }
 
-static int drop_partitions(struct gendisk *disk, struct block_device *bdev)
+int blk_drop_partitions(struct gendisk *disk, struct block_device *bdev)
 {
 	struct disk_part_iter piter;
 	struct hd_struct *part;
@@ -573,7 +573,7 @@ static bool blk_add_partition(struct gendisk *disk, struct block_device *bdev,
 	return true;
 }
 
-static int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
+int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
 {
 	struct parsed_partitions *state;
 	int ret = -EAGAIN, p, highest;
@@ -632,39 +632,6 @@ static int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
 	return ret;
 }
 
-int rescan_partitions(struct gendisk *disk, struct block_device *bdev,
-		bool invalidate)
-{
-	int ret;
-
-rescan:
-	ret = drop_partitions(disk, bdev);
-	if (ret)
-		return ret;
-
-	if (invalidate)
-		set_capacity(disk, 0);
-	else if (disk->fops->revalidate_disk)
-		disk->fops->revalidate_disk(disk);
-
-	check_disk_size_change(disk, bdev, !invalidate);
-	bdev->bd_invalidated = 0;
-
-	if (!get_capacity(disk)) {
-		/*
-		 * Tell userspace that the media / partition table may have
-		 * changed.
-		 */
-		kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
-		return 0;
-	}
-	
-	ret = blk_add_partitions(disk, bdev);
-	if (ret == -EAGAIN)
-		goto rescan;
-	return ret;
-}
-
 unsigned char *read_dev_sector(struct block_device *bdev, sector_t n, Sector *p)
 {
 	struct address_space *mapping = bdev->bd_inode->i_mapping;
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 0af62b76d031..f0710085e1f1 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1416,8 +1416,8 @@ static void flush_disk(struct block_device *bdev, bool kill_dirty)
  * and adjusts it if it differs. When shrinking the bdev size, its all caches
  * are freed.
  */
-void check_disk_size_change(struct gendisk *disk, struct block_device *bdev,
-		bool verbose)
+static void check_disk_size_change(struct gendisk *disk,
+		struct block_device *bdev, bool verbose)
 {
 	loff_t disk_size, bdev_size;
 
@@ -1508,6 +1508,40 @@ EXPORT_SYMBOL(bd_set_size);
 
 static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part);
 
+static int rescan_partitions(struct gendisk *disk, struct block_device *bdev,
+		bool invalidate)
+{
+	int ret;
+
+rescan:
+	ret = blk_drop_partitions(disk, bdev);
+	if (ret)
+		return ret;
+
+	if (invalidate)
+		set_capacity(disk, 0);
+	else if (disk->fops->revalidate_disk)
+		disk->fops->revalidate_disk(disk);
+
+	check_disk_size_change(disk, bdev, !invalidate);
+	bdev->bd_invalidated = 0;
+
+	if (!get_capacity(disk)) {
+		/*
+		 * Tell userspace that the media / partition table may have
+		 * changed.
+		 */
+		kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
+		return 0;
+	}
+	
+	ret = blk_add_partitions(disk, bdev);
+	if (ret == -EAGAIN)
+		goto rescan;
+	return ret;
+}
+
+
 static void bdev_disk_changed(struct block_device *bdev, bool invalidate)
 {
 	if (disk_part_scan_enabled(bdev->bd_disk)) {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e0d909d35763..d233dd661df7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2703,8 +2703,6 @@ extern void make_bad_inode(struct inode *);
 extern bool is_bad_inode(struct inode *);
 
 #ifdef CONFIG_BLOCK
-extern void check_disk_size_change(struct gendisk *disk,
-		struct block_device *bdev, bool verbose);
 extern int revalidate_disk(struct gendisk *);
 extern int check_disk_change(struct block_device *);
 extern int __invalidate_device(struct block_device *, bool);
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index fd7774e64f0b..f5cffbf63abf 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -621,9 +621,9 @@ extern void blk_invalidate_devt(dev_t devt);
 extern dev_t blk_lookup_devt(const char *name, int partno);
 extern char *disk_name (struct gendisk *hd, int partno, char *buf);
 
+int blk_add_partitions(struct gendisk *disk, struct block_device *bdev);
+int blk_drop_partitions(struct gendisk *disk, struct block_device *bdev);
 extern int disk_expand_part_tbl(struct gendisk *disk, int target);
-int rescan_partitions(struct gendisk *disk, struct block_device *bdev,
-		bool invalidate);
 extern struct hd_struct * __must_check add_partition(struct gendisk *disk,
 						     int partno, sector_t start,
 						     sector_t len, int flags,
-- 
2.20.1
