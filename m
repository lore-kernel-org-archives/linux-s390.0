Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:38578 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfKNOe5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 14 Nov 2019 09:34:57 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 6/7] block: move clearing bd_invalidated into check_disk_size_change
Date: Thu, 14 Nov 2019 15:34:37 +0100
Message-Id: <20191114143438.14681-7-hch@lst.de>
In-Reply-To: <20191114143438.14681-1-hch@lst.de>
References: <20191114143438.14681-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Cc: linux-block@vger.kernel.org, linux-s390@vger.kernel.org

Both callers of check_disk_size_change clear bd_invalidate directly
after the call, so move the clearing into check_disk_size_change
itself.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9558a2f064b1..ee63c2732fa2 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1433,6 +1433,7 @@ static void check_disk_size_change(struct gendisk *disk,
 		if (bdev_size > disk_size)
 			flush_disk(bdev, false);
 	}
+	bdev->bd_invalidated = 0;
 }
 
 /**
@@ -1462,7 +1463,6 @@ int revalidate_disk(struct gendisk *disk)
 
 		mutex_lock(&bdev->bd_mutex);
 		check_disk_size_change(disk, bdev, ret == 0);
-		bdev->bd_invalidated = 0;
 		mutex_unlock(&bdev->bd_mutex);
 		bdput(bdev);
 	}
@@ -1526,7 +1526,6 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 		disk->fops->revalidate_disk(disk);
 
 	check_disk_size_change(disk, bdev, !invalidate);
-	bdev->bd_invalidated = 0;
 
 	if (get_capacity(disk)) {
 		ret = blk_add_partitions(disk, bdev);
-- 
2.20.1
