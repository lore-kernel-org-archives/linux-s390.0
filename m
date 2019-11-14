Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:38588 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfKNOe7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 14 Nov 2019 09:34:59 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 7/7] block: move setting bd_invalidated from flush_disk to check_disk_change
Date: Thu, 14 Nov 2019 15:34:38 +0100
Message-Id: <20191114143438.14681-8-hch@lst.de>
In-Reply-To: <20191114143438.14681-1-hch@lst.de>
References: <20191114143438.14681-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Cc: linux-block@vger.kernel.org, linux-s390@vger.kernel.org

The only other caller of flush_disk instantly clears the flag, so don't
bother setting it there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index ee63c2732fa2..f60739b5a24f 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1403,7 +1403,6 @@ static void flush_disk(struct block_device *bdev, bool kill_dirty)
 		       "resized disk %s\n",
 		       bdev->bd_disk ? bdev->bd_disk->disk_name : "");
 	}
-	bdev->bd_invalidated = 1;
 }
 
 /**
@@ -1491,6 +1490,7 @@ int check_disk_change(struct block_device *bdev)
 		return 0;
 
 	flush_disk(bdev, true);
+	bdev->bd_invalidated = 1;
 	if (bdops->revalidate_disk)
 		bdops->revalidate_disk(bdev->bd_disk);
 	return 1;
-- 
2.20.1
