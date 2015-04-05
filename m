Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ming Lei <ming.lei@canonical.com>
Subject: [PATCH 5/6] block: dasd_genhd: convert to blkdev_reread_part
Date: Sun,  5 Apr 2015 15:24:47 +0800
Message-Id: <1428218688-4092-6-git-send-email-ming.lei@canonical.com>
In-Reply-To: <1428218688-4092-1-git-send-email-ming.lei@canonical.com>
References: <1428218688-4092-1-git-send-email-ming.lei@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jarod Wilson <jarod@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, nbd-general@lists.sourceforge.net, Stefan Haberland <stefan.haberland@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Fabian Frederick <fabf@skynet.be>, linux-s390@vger.kernel.org, Ming Lei <ming.lei@canonical.com>
List-ID: <linux-s390.vger.kernel.org>

Also remove the obsolete comment.

Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 drivers/s390/block/dasd_genhd.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index 90f39f7..2af4619 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -116,14 +116,11 @@ int dasd_scan_partitions(struct dasd_block *block)
 			      rc);
 		return -ENODEV;
 	}
-	/*
-	 * See fs/partition/check.c:register_disk,rescan_partitions
-	 * Can't call rescan_partitions directly. Use ioctl.
-	 */
-	rc = ioctl_by_bdev(bdev, BLKRRPART, 0);
+
+	rc = blkdev_reread_part(bdev);
 	while (rc == -EBUSY && retry > 0) {
 		schedule();
-		rc = ioctl_by_bdev(bdev, BLKRRPART, 0);
+		rc = blkdev_reread_part(bdev);
 		retry--;
 		DBF_DEV_EVENT(DBF_ERR, block->base,
 			      "scan partitions error, retry %d rc %d",
-- 
1.7.9.5
