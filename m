Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbgIUHUR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 21 Sep 2020 03:20:17 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 14/14] block: mark blkdev_get static
Date: Mon, 21 Sep 2020 09:19:58 +0200
Message-Id: <20200921071958.307589-15-hch@lst.de>
In-Reply-To: <20200921071958.307589-1-hch@lst.de>
References: <20200921071958.307589-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Josef Bacik <josef@toxicpanda.com>, Minchan Kim <minchan@kernel.org>, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, Joseph Qi <joseph.qi@linux.alibaba.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, nbd@other.debian.org, linux-ide@vger.kernel.org, linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org, ocfs2-devel@oss.oracle.com, linux-pm@vger.kernel.org, linux-mm@kvack.org, linux-block@vger.kernel.org

There are no users outside the core block code left now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c         | 3 +--
 include/linux/blkdev.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 2898d69be6b3e4..6b9d19ffa5af7b 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1616,7 +1616,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
  * RETURNS:
  * 0 on success, -errno on failure.
  */
-int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder)
+static int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder)
 {
 	int ret, perm = 0;
 
@@ -1637,7 +1637,6 @@ int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder)
 	bdput(bdev);
 	return ret;
 }
-EXPORT_SYMBOL(blkdev_get);
 
 /**
  * blkdev_get_by_path - open a block device by name
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5bd96fbab9b4c8..14117995091224 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1975,7 +1975,6 @@ void blkdev_show(struct seq_file *seqf, off_t offset);
 #define BLKDEV_MAJOR_MAX	0
 #endif
 
-int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder);
 struct block_device *blkdev_get_by_path(const char *path, fmode_t mode,
 		void *holder);
 struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder);
-- 
2.28.0
