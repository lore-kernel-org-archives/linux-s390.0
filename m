Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:40820 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbgDHTo7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Apr 2020 15:44:59 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 07/10] block: don't call invalidate_partition from blk_drop_partitions
Date: Wed,  8 Apr 2020 21:44:36 +0200
Message-Id: <20200408194439.1580699-8-hch@lst.de>
In-Reply-To: <20200408194439.1580699-1-hch@lst.de>
References: <20200408194439.1580699-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-block@vger.kernel.org, linux-s390@vger.kernel.org

Given that the device must not be busy, most of the calls from
invalidate_partition that are related to file system metadata are
guranteed to not happen.  Just open code the calls to sync_blockdev
and invalidate_bdev instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 8a41c25022ab..3fe383adb42a 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -607,15 +607,14 @@ int blk_drop_partitions(struct block_device *bdev)
 {
 	struct disk_part_iter piter;
 	struct hd_struct *part;
-	int res;
 
 	if (!disk_part_scan_enabled(bdev->bd_disk))
 		return 0;
 	if (bdev->bd_part_count || bdev->bd_openers)
 		return -EBUSY;
-	res = invalidate_partition(bdev->bd_disk, 0);
-	if (res)
-		return res;
+
+	sync_blockdev(bdev);
+	invalidate_bdev(bdev);
 
 	disk_part_iter_init(&piter, bdev->bd_disk, DISK_PITER_INCL_EMPTY);
 	while ((part = disk_part_iter_next(&piter)))
-- 
2.25.1
