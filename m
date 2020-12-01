Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728700AbgLAQzM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 1 Dec 2020 11:55:12 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/9] brd: remove the end of device check in brd_do_bvec
Date: Tue,  1 Dec 2020 17:54:16 +0100
Message-Id: <20201201165424.2030647-2-hch@lst.de>
In-Reply-To: <20201201165424.2030647-1-hch@lst.de>
References: <20201201165424.2030647-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>, Coly Li <colyli@suse.de>, Song Liu <song@kernel.org>, dm-devel@redhat.com, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-s390@vger.kernel.org, linux-block@vger.kernel.org

The block layer already checks for this conditions in bio_check_eod
before calling the driver.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/brd.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index c43a6ab4b1f39f..c7c8214190795c 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -285,14 +285,10 @@ static int brd_do_bvec(struct brd_device *brd, struct page *page,
 static blk_qc_t brd_submit_bio(struct bio *bio)
 {
 	struct brd_device *brd = bio->bi_disk->private_data;
+	sector_t sector = bio->bi_iter.bi_sector;
 	struct bio_vec bvec;
-	sector_t sector;
 	struct bvec_iter iter;
 
-	sector = bio->bi_iter.bi_sector;
-	if (bio_end_sector(bio) > get_capacity(bio->bi_disk))
-		goto io_error;
-
 	bio_for_each_segment(bvec, bio, iter) {
 		unsigned int len = bvec.bv_len;
 		int err;
-- 
2.29.2
