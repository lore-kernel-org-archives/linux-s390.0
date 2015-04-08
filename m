Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jarod Wilson <jarod@redhat.com>
Subject: [PATCH 5/7] block: dasd_genhd: convert to blkdev_reread_part
Date: Wed,  8 Apr 2015 02:23:44 -0400
Message-Id: <1428474226-27386-6-git-send-email-jarod@redhat.com>
In-Reply-To: <1428474226-27386-1-git-send-email-jarod@redhat.com>
References: <1428218688-4092-1-git-send-email-ming.lei@canonical.com>
 <1428474226-27386-1-git-send-email-jarod@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Ming Lei <ming.lei@canonical.com>, Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Markus Pargmann <mpa@pengutronix.de>, Stefan Weinhuber <wein@de.ibm.com>, Stefan Haberland <stefan.haberland@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Fabian Frederick <fabf@skynet.be>, David Herrmann <dh.herrmann@gmail.com>, Mike Galbraith <bitbucket@online.de>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, nbd-general@lists.sourceforge.net, linux-s390@vger.kernel.org, Jarod Wilson <jarod@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ming Lei <ming.lei@canonical.com>

Also remove the obsolete comment.

CC: Christoph Hellwig <hch@infradead.org>
CC: Jens Axboe <axboe@kernel.dk>
CC: Tejun Heo <tj@kernel.org>
CC: Alexander Viro <viro@zeniv.linux.org.uk>
CC: Markus Pargmann <mpa@pengutronix.de>
CC: Stefan Weinhuber <wein@de.ibm.com>
CC: Stefan Haberland <stefan.haberland@de.ibm.com>
CC: Sebastian Ott <sebott@linux.vnet.ibm.com>
CC: Fabian Frederick <fabf@skynet.be>
CC: Ming Lei <ming.lei@canonical.com>
CC: David Herrmann <dh.herrmann@gmail.com>
CC: Mike Galbraith <bitbucket@online.de>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: nbd-general@lists.sourceforge.net
CC: linux-s390@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@canonical.com>
Signed-off-by: Jarod Wilson <jarod@redhat.com>
---
 drivers/s390/block/dasd_genhd.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index 90f39f7..8026585 100644
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
@@ -138,7 +135,7 @@ int dasd_scan_partitions(struct dasd_block *block)
 	 * dasd_generic_set_offline). As long as the partition
 	 * detection is running no offline should be allowed. That
 	 * is why the assignment to device->bdev is done AFTER
-	 * the BLKRRPART ioctl.
+	 * the blkdev_reread_part() call.
 	 */
 	block->bdev = bdev;
 	return 0;
-- 
1.8.3.1
