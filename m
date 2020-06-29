Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732493AbgF2Tkc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 29 Jun 2020 15:40:32 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 14/20] block: remove the NULL queue check in generic_make_request_checks
Date: Mon, 29 Jun 2020 21:39:41 +0200
Message-Id: <20200629193947.2705954-15-hch@lst.de>
In-Reply-To: <20200629193947.2705954-1-hch@lst.de>
References: <20200629193947.2705954-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org, drbd-dev@lists.linbit.com, linuxppc-dev@lists.ozlabs.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org, linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org

All registers disks must have a valid queue pointer, so don't bother to
log a warning for that case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 95dca74534ff73..37435d0d433564 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -973,22 +973,12 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 static noinline_for_stack bool
 generic_make_request_checks(struct bio *bio)
 {
-	struct request_queue *q;
+	struct request_queue *q = bio->bi_disk->queue;
 	int nr_sectors = bio_sectors(bio);
 	blk_status_t status = BLK_STS_IOERR;
-	char b[BDEVNAME_SIZE];
 
 	might_sleep();
 
-	q = bio->bi_disk->queue;
-	if (unlikely(!q)) {
-		printk(KERN_ERR
-		       "generic_make_request: Trying to access "
-			"nonexistent block-device %s (%Lu)\n",
-			bio_devname(bio, b), (long long)bio->bi_iter.bi_sector);
-		goto end_io;
-	}
-
 	/*
 	 * For a REQ_NOWAIT based request, return -EOPNOTSUPP
 	 * if queue is not a request based queue.
-- 
2.26.2
