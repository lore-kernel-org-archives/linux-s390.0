Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390685AbgLAQzP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 1 Dec 2020 11:55:15 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/9] dcssblk: remove the end of device check in brd_do_bvec
Date: Tue,  1 Dec 2020 17:54:17 +0100
Message-Id: <20201201165424.2030647-3-hch@lst.de>
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
 drivers/s390/block/dcssblk.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 299e77ec2c4163..5c5cff3f237452 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -886,10 +886,6 @@ dcssblk_submit_bio(struct bio *bio)
 	    (bio->bi_iter.bi_size & 4095) != 0)
 		/* Request is not page-aligned. */
 		goto fail;
-	if (bio_end_sector(bio) > get_capacity(bio->bi_disk)) {
-		/* Request beyond end of DCSS segment. */
-		goto fail;
-	}
 	/* verify data transfer direction */
 	if (dev_info->is_shared) {
 		switch (dev_info->segment_type) {
-- 
2.29.2
