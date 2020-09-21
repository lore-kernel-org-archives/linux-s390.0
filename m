Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgIUHUQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 21 Sep 2020 03:20:16 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 08/14] dasd: cleanup dasd_scan_partitions
Date: Mon, 21 Sep 2020 09:19:52 +0200
Message-Id: <20200921071958.307589-9-hch@lst.de>
In-Reply-To: <20200921071958.307589-1-hch@lst.de>
References: <20200921071958.307589-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Josef Bacik <josef@toxicpanda.com>, Minchan Kim <minchan@kernel.org>, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, Joseph Qi <joseph.qi@linux.alibaba.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, nbd@other.debian.org, linux-ide@vger.kernel.org, linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org, ocfs2-devel@oss.oracle.com, linux-pm@vger.kernel.org, linux-mm@kvack.org, linux-block@vger.kernel.org

Use blkdev_get_by_dev instead of bdget_disk + blkdev_get.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/s390/block/dasd_genhd.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index af5b0ecb8f8923..a9698fba9b76ce 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -101,18 +101,11 @@ int dasd_scan_partitions(struct dasd_block *block)
 	struct block_device *bdev;
 	int rc;
 
-	bdev = bdget_disk(block->gdp, 0);
-	if (!bdev) {
-		DBF_DEV_EVENT(DBF_ERR, block->base, "%s",
-			      "scan partitions error, bdget returned NULL");
-		return -ENODEV;
-	}
-
-	rc = blkdev_get(bdev, FMODE_READ, NULL);
-	if (rc < 0) {
+	bdev = blkdev_get_by_dev(disk_devt(block->gdp), FMODE_READ, NULL);
+	if (IS_ERR(bdev)) {
 		DBF_DEV_EVENT(DBF_ERR, block->base,
-			      "scan partitions error, blkdev_get returned %d",
-			      rc);
+			      "scan partitions error, blkdev_get returned %ld",
+			      PTR_ERR(bdev));
 		return -ENODEV;
 	}
 
-- 
2.28.0
