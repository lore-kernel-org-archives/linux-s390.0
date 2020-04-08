Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:40682 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729275AbgDHToy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Apr 2020 15:44:54 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 05/10] block: remove the disk argument from blk_drop_partitions
Date: Wed,  8 Apr 2020 21:44:34 +0200
Message-Id: <20200408194439.1580699-6-hch@lst.de>
In-Reply-To: <20200408194439.1580699-1-hch@lst.de>
References: <20200408194439.1580699-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-block@vger.kernel.org, linux-s390@vger.kernel.org

The gendisk can be trivially deducted from the block_device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/core.c | 10 +++++-----
 fs/block_dev.c          |  2 +-
 include/linux/genhd.h   |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index f10968b601be..e0ff8a49279f 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -603,23 +603,23 @@ static bool disk_unlock_native_capacity(struct gendisk *disk)
 	}
 }
 
-int blk_drop_partitions(struct gendisk *disk, struct block_device *bdev)
+int blk_drop_partitions(struct block_device *bdev)
 {
 	struct disk_part_iter piter;
 	struct hd_struct *part;
 	int res;
 
-	if (!disk_part_scan_enabled(disk))
+	if (!disk_part_scan_enabled(bdev->bd_disk))
 		return 0;
 	if (bdev->bd_part_count || bdev->bd_openers)
 		return -EBUSY;
-	res = invalidate_partition(disk, 0);
+	res = invalidate_partition(bdev->bd_disk, 0);
 	if (res)
 		return res;
 
-	disk_part_iter_init(&piter, disk, DISK_PITER_INCL_EMPTY);
+	disk_part_iter_init(&piter, bdev->bd_disk, DISK_PITER_INCL_EMPTY);
 	while ((part = disk_part_iter_next(&piter)))
-		delete_partition(disk, part);
+		delete_partition(bdev->bd_disk, part);
 	disk_part_iter_exit(&piter);
 
 	return 0;
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 52b6f646cdbd..9c8de54fa0c9 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1517,7 +1517,7 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 	lockdep_assert_held(&bdev->bd_mutex);
 
 rescan:
-	ret = blk_drop_partitions(disk, bdev);
+	ret = blk_drop_partitions(bdev);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 9b3fffdf4011..058d895544c7 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -339,7 +339,7 @@ extern dev_t blk_lookup_devt(const char *name, int partno);
 
 int bdev_disk_changed(struct block_device *bdev, bool invalidate);
 int blk_add_partitions(struct gendisk *disk, struct block_device *bdev);
-int blk_drop_partitions(struct gendisk *disk, struct block_device *bdev);
+int blk_drop_partitions(struct block_device *bdev);
 extern void printk_all_partitions(void);
 
 extern struct gendisk *__alloc_disk_node(int minors, int node_id);
-- 
2.25.1
