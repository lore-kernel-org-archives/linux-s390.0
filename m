Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:59784 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390783AbgDNH3Z (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Apr 2020 03:29:25 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 06/10] dasd: use blk_drop_partitions instead of badly reimplementing it
Date: Tue, 14 Apr 2020 09:28:58 +0200
Message-Id: <20200414072902.324936-7-hch@lst.de>
In-Reply-To: <20200414072902.324936-1-hch@lst.de>
References: <20200414072902.324936-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-block@vger.kernel.org, linux-s390@vger.kernel.org

Use the blk_drop_partitions function instead of messing around with
ioctls that get kernel pointers.  For this blk_drop_partitions needs
to be exported, which it normally shouldn't - make an exception for
s390 only.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/core.c         |  4 ++++
 drivers/s390/block/dasd_genhd.c | 20 ++++----------------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index deccc3fbcd37..8c5295ca8ea6 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -624,6 +624,10 @@ int blk_drop_partitions(struct block_device *bdev)
 
 	return 0;
 }
+#ifdef CONFIG_S390
+/* for historic reasons in the DASD driver */
+EXPORT_SYMBOL_GPL(blk_drop_partitions);
+#endif
 
 static bool blk_add_partition(struct gendisk *disk, struct block_device *bdev,
 		struct parsed_partitions *state, int p)
diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index 7d079154f849..af5b0ecb8f89 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -143,9 +143,6 @@ int dasd_scan_partitions(struct dasd_block *block)
  */
 void dasd_destroy_partitions(struct dasd_block *block)
 {
-	/* The two structs have 168/176 byte on 31/64 bit. */
-	struct blkpg_partition bpart;
-	struct blkpg_ioctl_arg barg;
 	struct block_device *bdev;
 
 	/*
@@ -155,19 +152,10 @@ void dasd_destroy_partitions(struct dasd_block *block)
 	bdev = block->bdev;
 	block->bdev = NULL;
 
-	/*
-	 * See fs/partition/check.c:delete_partition
-	 * Can't call delete_partitions directly. Use ioctl.
-	 * The ioctl also does locking and invalidation.
-	 */
-	memset(&bpart, 0, sizeof(struct blkpg_partition));
-	memset(&barg, 0, sizeof(struct blkpg_ioctl_arg));
-	barg.data = (void __force __user *) &bpart;
-	barg.op = BLKPG_DEL_PARTITION;
-	for (bpart.pno = block->gdp->minors - 1; bpart.pno > 0; bpart.pno--)
-		ioctl_by_bdev(bdev, BLKPG, (unsigned long) &barg);
-
-	invalidate_partition(block->gdp, 0);
+	mutex_lock(&bdev->bd_mutex);
+	blk_drop_partitions(bdev);
+	mutex_unlock(&bdev->bd_mutex);
+
 	/* Matching blkdev_put to the blkdev_get in dasd_scan_partitions. */
 	blkdev_put(bdev, FMODE_READ);
 	set_capacity(block->gdp, 0);
-- 
2.25.1
