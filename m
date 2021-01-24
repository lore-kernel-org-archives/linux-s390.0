Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbhAXKGo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 24 Jan 2021 05:06:44 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 05/10] block: do not reassig ->bi_bdev when partition remapping
Date: Sun, 24 Jan 2021 11:02:36 +0100
Message-Id: <20210124100241.1167849-6-hch@lst.de>
In-Reply-To: <20210124100241.1167849-1-hch@lst.de>
References: <20210124100241.1167849-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>, Coly Li <colyli@suse.de>, Song Liu <song@kernel.org>, dm-devel@redhat.com, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-s390@vger.kernel.org, linux-block@vger.kernel.org

There is no good reason to reassign ->bi_bdev when remapping the
partition-relative block number to the device wide one, as all the
information required by the drivers comes from the gendisk anyway.

Keeping the original ->bi_bdev alive will allow to greatly simplify
the partition-away I/O accounting.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-core.c          | 5 +++--
 include/linux/bio.h       | 2 ++
 include/linux/blk_types.h | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 64f69022de9627..1c1b97a82caa2e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -752,7 +752,7 @@ static int blk_partition_remap(struct bio *bio)
 				      bio->bi_iter.bi_sector -
 				      p->bd_start_sect);
 	}
-	bio->bi_bdev = bdev_whole(p);
+	bio_set_flag(bio, BIO_REMAPPED);
 	return 0;
 }
 
@@ -817,7 +817,8 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 		goto end_io;
 	if (unlikely(bio_check_eod(bio)))
 		goto end_io;
-	if (bio->bi_bdev->bd_partno && unlikely(blk_partition_remap(bio)))
+	if (bio->bi_bdev->bd_partno && !bio_flagged(bio, BIO_REMAPPED) &&
+	    unlikely(blk_partition_remap(bio)))
 		goto end_io;
 
 	/*
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 12af7aa5db3778..2f1155eabaff29 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -485,6 +485,7 @@ extern const char *bio_devname(struct bio *bio, char *buffer);
 
 #define bio_set_dev(bio, bdev) 				\
 do {							\
+	bio_clear_flag(bio, BIO_REMAPPED);		\
 	if ((bio)->bi_bdev != (bdev))			\
 		bio_clear_flag(bio, BIO_THROTTLED);	\
 	(bio)->bi_bdev = (bdev);			\
@@ -493,6 +494,7 @@ do {							\
 
 #define bio_copy_dev(dst, src)			\
 do {						\
+	bio_clear_flag(dst, BIO_REMAPPED);		\
 	(dst)->bi_bdev = (src)->bi_bdev;	\
 	bio_clone_blkg_association(dst, src);	\
 } while (0)
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 8ebd8be3e05082..1bc6f6a01070fc 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -303,6 +303,7 @@ enum {
 				 * of this bio. */
 	BIO_CGROUP_ACCT,	/* has been accounted to a cgroup */
 	BIO_TRACKED,		/* set if bio goes through the rq_qos path */
+	BIO_REMAPPED,
 	BIO_FLAG_LAST
 };
 
-- 
2.29.2
