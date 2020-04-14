Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:59830 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390793AbgDNH3d (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Apr 2020 03:29:33 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 09/10] block: mark invalidate_partition static
Date: Tue, 14 Apr 2020 09:29:01 +0200
Message-Id: <20200414072902.324936-10-hch@lst.de>
In-Reply-To: <20200414072902.324936-1-hch@lst.de>
References: <20200414072902.324936-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-block@vger.kernel.org, linux-s390@vger.kernel.org, Johannes Thumshirn <johannes.thumshirn@wdc.com>

invalidate_partition is only used in genhd.c, so mark it static.  Also
drop the return value given that is is always ignored.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/genhd.c      | 27 +++++++++++++--------------
 include/linux/fs.h |  1 -
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 1cc50ad5b191..980a4609d4a5 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -878,6 +878,19 @@ void device_add_disk_no_queue_reg(struct device *parent, struct gendisk *disk)
 }
 EXPORT_SYMBOL(device_add_disk_no_queue_reg);
 
+static void invalidate_partition(struct gendisk *disk, int partno)
+{
+	struct block_device *bdev;
+
+	bdev = bdget_disk(disk, partno);
+	if (!bdev)
+		return;
+
+	fsync_bdev(bdev);
+	__invalidate_device(bdev, true);
+	bdput(bdev);
+}
+
 void del_gendisk(struct gendisk *disk)
 {
 	struct disk_part_iter piter;
@@ -1806,20 +1819,6 @@ int bdev_read_only(struct block_device *bdev)
 
 EXPORT_SYMBOL(bdev_read_only);
 
-int invalidate_partition(struct gendisk *disk, int partno)
-{
-	int res = 0;
-	struct block_device *bdev = bdget_disk(disk, partno);
-	if (bdev) {
-		fsync_bdev(bdev);
-		res = __invalidate_device(bdev, true);
-		bdput(bdev);
-	}
-	return res;
-}
-
-EXPORT_SYMBOL(invalidate_partition);
-
 /*
  * Disk events - monitor disk events like media change and eject request.
  */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4f6f59b4f22a..2b4e9f86b151 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2723,7 +2723,6 @@ extern bool is_bad_inode(struct inode *);
 extern int revalidate_disk(struct gendisk *);
 extern int check_disk_change(struct block_device *);
 extern int __invalidate_device(struct block_device *, bool);
-extern int invalidate_partition(struct gendisk *, int);
 #endif
 unsigned long invalidate_mapping_pages(struct address_space *mapping,
 					pgoff_t start, pgoff_t end);
-- 
2.25.1
