Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D65C43460
	for <linux-s390@archiver.kernel.org>; Tue,  6 Apr 2021 06:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 569DA61158
	for <linux-s390@archiver.kernel.org>; Tue,  6 Apr 2021 06:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243960AbhDFGXY (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 6 Apr 2021 02:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243962AbhDFGXY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Apr 2021 02:23:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D555C06174A;
        Mon,  5 Apr 2021 23:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=pENTUb125jZ/5l7/9JUqbPO9XD4KaeKX+AMlhyYVjnA=; b=A1HjIepAipa857z4QKz4X5Jx+V
        B/CGHo9xvWvKM7tEKyadHoOV9rgaMnYEsyY0r8E6oyz/z6hE4W5CXzxJR6HxkDT8B/anpSXjFlAV+
        3g8euwwiwLj083LUuTPW6CKTbYSGegxDAuVsllF01gdV40ke7UcSqLiItHPb83MsxVpLyJQoritvm
        MxInjHg+dN4vBsNxs1abSTzQGYQEDWR1oBq6r/JTWj171Zu0p3RGazwTQ3KHabUZNVex7N1FQpYCK
        MikfjxSNtwBfAKiijiMfBD3+oycaEPRF8LJBYuAu+lJtYkNpAoKRrw6yu+QWUzBKRIG015GOODtc0
        6v9XGBbQ==;
Received: from [2001:4bb8:188:4907:c664:b479:e725:f367] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lTf7L-007o8k-5o; Tue, 06 Apr 2021 06:23:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 04/11] block: refactor blk_drop_partitions
Date:   Tue,  6 Apr 2021 08:22:55 +0200
Message-Id: <20210406062303.811835-5-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210406062303.811835-1-hch@lst.de>
References: <20210406062303.811835-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Move the busy check and disk-wide sync into the only caller, so that
the remainder can be shared with del_gendisk.  Also pass the gendisk
instead of the bdev as that is all that is needed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk.h             |  1 -
 block/genhd.c           | 11 +----------
 block/partitions/core.c | 14 +++-----------
 fs/block_dev.c          |  8 +++++---
 include/linux/genhd.h   |  2 +-
 5 files changed, 10 insertions(+), 26 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 3b53e44b967e4e..900cb246d5f384 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -346,7 +346,6 @@ char *disk_name(struct gendisk *hd, int partno, char *buf);
 #define ADDPART_FLAG_NONE	0
 #define ADDPART_FLAG_RAID	1
 #define ADDPART_FLAG_WHOLEDISK	2
-void delete_partition(struct block_device *part);
 int bdev_add_partition(struct block_device *bdev, int partno,
 		sector_t start, sector_t length);
 int bdev_del_partition(struct block_device *bdev, int partno);
diff --git a/block/genhd.c b/block/genhd.c
index 15f99da4543f6d..8303ec67fd7099 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -667,9 +667,6 @@ EXPORT_SYMBOL(device_add_disk_no_queue_reg);
  */
 void del_gendisk(struct gendisk *disk)
 {
-	struct disk_part_iter piter;
-	struct block_device *part;
-
 	might_sleep();
 
 	if (WARN_ON_ONCE(!disk->queue))
@@ -683,13 +680,7 @@ void del_gendisk(struct gendisk *disk)
 	 * disk is marked as dead (GENHD_FL_UP cleared).
 	 */
 	down_write(&bdev_lookup_sem);
-
-	/* invalidate stuff */
-	disk_part_iter_init(&piter, disk, DISK_PITER_INCL_EMPTY);
-	while ((part = disk_part_iter_next(&piter)))
-		delete_partition(part);
-	disk_part_iter_exit(&piter);
-
+	blk_drop_partitions(disk);
 	fsync_bdev(disk->part0);
 	__invalidate_device(disk->part0, true);
 
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 8c173529294081..536f7c5bb0b6d2 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -285,7 +285,7 @@ struct device_type part_type = {
  * Must be called either with bd_mutex held, before a disk can be opened or
  * after all disk users are gone.
  */
-void delete_partition(struct block_device *part)
+static void delete_partition(struct block_device *part)
 {
 	fsync_bdev(part);
 	__invalidate_device(part, true);
@@ -526,23 +526,15 @@ static bool disk_unlock_native_capacity(struct gendisk *disk)
 	}
 }
 
-int blk_drop_partitions(struct block_device *bdev)
+void blk_drop_partitions(struct gendisk *disk)
 {
 	struct disk_part_iter piter;
 	struct block_device *part;
 
-	if (bdev->bd_part_count)
-		return -EBUSY;
-
-	sync_blockdev(bdev);
-	invalidate_bdev(bdev);
-
-	disk_part_iter_init(&piter, bdev->bd_disk, DISK_PITER_INCL_EMPTY);
+	disk_part_iter_init(&piter, disk, DISK_PITER_INCL_EMPTY);
 	while ((part = disk_part_iter_next(&piter)))
 		delete_partition(part);
 	disk_part_iter_exit(&piter);
-
-	return 0;
 }
 
 static bool blk_add_partition(struct gendisk *disk, struct block_device *bdev,
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 92ed7d5df67744..594a1bee9dd9ac 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1243,9 +1243,11 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 	clear_bit(GD_NEED_PART_SCAN, &bdev->bd_disk->state);
 
 rescan:
-	ret = blk_drop_partitions(bdev);
-	if (ret)
-		return ret;
+	if (bdev->bd_part_count)
+		return -EBUSY;
+	sync_blockdev(bdev);
+	invalidate_bdev(bdev);
+	blk_drop_partitions(disk);
 
 	/*
 	 * Historically we only set the capacity to zero for devices that
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index f364619092cca0..16178a935c4041 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -273,7 +273,7 @@ static inline sector_t get_capacity(struct gendisk *disk)
 
 int bdev_disk_changed(struct block_device *bdev, bool invalidate);
 int blk_add_partitions(struct gendisk *disk, struct block_device *bdev);
-int blk_drop_partitions(struct block_device *bdev);
+void blk_drop_partitions(struct gendisk *disk);
 
 extern struct gendisk *__alloc_disk_node(int minors, int node_id);
 extern void put_disk(struct gendisk *disk);
-- 
2.30.1

