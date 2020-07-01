Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbgGAJAQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 1 Jul 2020 05:00:16 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 15/20] block: remove the nr_sectors variable in generic_make_request_checks
Date: Wed,  1 Jul 2020 10:59:42 +0200
Message-Id: <20200701085947.3354405-16-hch@lst.de>
In-Reply-To: <20200701085947.3354405-1-hch@lst.de>
References: <20200701085947.3354405-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org, drbd-dev@lists.linbit.com, linuxppc-dev@lists.ozlabs.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org, linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org

The variable is only used once, so just open code the bio_sector()
there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 37435d0d433564..28f60985dc75cc 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -974,7 +974,6 @@ static noinline_for_stack bool
 generic_make_request_checks(struct bio *bio)
 {
 	struct request_queue *q = bio->bi_disk->queue;
-	int nr_sectors = bio_sectors(bio);
 	blk_status_t status = BLK_STS_IOERR;
 
 	might_sleep();
@@ -1007,7 +1006,7 @@ generic_make_request_checks(struct bio *bio)
 	if (op_is_flush(bio->bi_opf) &&
 	    !test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
 		bio->bi_opf &= ~(REQ_PREFLUSH | REQ_FUA);
-		if (!nr_sectors) {
+		if (!bio_sectors(bio)) {
 			status = BLK_STS_OK;
 			goto end_io;
 		}
-- 
2.26.2
