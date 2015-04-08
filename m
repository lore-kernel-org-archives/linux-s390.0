Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jarod Wilson <jarod@redhat.com>
Subject: [PATCH 7/7] s390/block/dasd: remove obsolete while -EBUSY loop
Date: Wed,  8 Apr 2015 02:23:46 -0400
Message-Id: <1428474226-27386-8-git-send-email-jarod@redhat.com>
In-Reply-To: <1428474226-27386-1-git-send-email-jarod@redhat.com>
References: <1428218688-4092-1-git-send-email-ming.lei@canonical.com>
 <1428474226-27386-1-git-send-email-jarod@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Jarod Wilson <jarod@redhat.com>, Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Markus Pargmann <mpa@pengutronix.de>, Stefan Weinhuber <wein@de.ibm.com>, Stefan Haberland <stefan.haberland@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Fabian Frederick <fabf@skynet.be>, Ming Lei <ming.lei@canonical.com>, David Herrmann <dh.herrmann@gmail.com>, Mike Galbraith <bitbucket@online.de>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, nbd-general@lists.sourceforge.net, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

With the mutex_trylock bit gone from blkdev_reread_part(), the retry logic
in dasd_scan_partitions() shouldn't be necessary.

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
Signed-off-by: Jarod Wilson <jarod@redhat.com>
---
 drivers/s390/block/dasd_genhd.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index 8026585..783d826 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -99,9 +99,8 @@ void dasd_gendisk_free(struct dasd_block *block)
 int dasd_scan_partitions(struct dasd_block *block)
 {
 	struct block_device *bdev;
-	int retry, rc;
+	int rc;
 
-	retry = 5;
 	bdev = bdget_disk(block->gdp, 0);
 	if (!bdev) {
 		DBF_DEV_EVENT(DBF_ERR, block->base, "%s",
@@ -118,14 +117,8 @@ int dasd_scan_partitions(struct dasd_block *block)
 	}
 
 	rc = blkdev_reread_part(bdev);
-	while (rc == -EBUSY && retry > 0) {
-		schedule();
-		rc = blkdev_reread_part(bdev);
-		retry--;
-		DBF_DEV_EVENT(DBF_ERR, block->base,
-			      "scan partitions error, retry %d rc %d",
-			      retry, rc);
-	}
+	DBF_DEV_EVENT(DBF_ERR, block->base,
+		      "scan partitions error, rc %d", rc);
 
 	/*
 	 * Since the matching blkdev_put call to the blkdev_get in
-- 
1.8.3.1
