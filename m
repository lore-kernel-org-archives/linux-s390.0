Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:40882 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbgDHTpC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Apr 2020 15:45:02 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 08/10] block: simplify block device syncing in bdev_del_partition
Date: Wed,  8 Apr 2020 21:44:37 +0200
Message-Id: <20200408194439.1580699-9-hch@lst.de>
In-Reply-To: <20200408194439.1580699-1-hch@lst.de>
References: <20200408194439.1580699-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-block@vger.kernel.org, linux-s390@vger.kernel.org

We just checked a little above that the block device for the partition
im busy.  That implies no file system is mounted, and thus the only
thing in fsync_bdev that actually is used is sync_blockdev.  Just call
sync_blockdev directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 3fe383adb42a..9c402edee4a4 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -531,7 +531,7 @@ int bdev_del_partition(struct block_device *bdev, int partno)
 	if (bdevp->bd_openers)
 		goto out_unlock;
 
-	fsync_bdev(bdevp);
+	sync_blockdev(bdevp);
 	invalidate_bdev(bdevp);
 
 	mutex_lock_nested(&bdev->bd_mutex, 1);
-- 
2.25.1
