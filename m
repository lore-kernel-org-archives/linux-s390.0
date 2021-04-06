Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B18FC433B4
	for <linux-s390@archiver.kernel.org>; Tue,  6 Apr 2021 06:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27F8061205
	for <linux-s390@archiver.kernel.org>; Tue,  6 Apr 2021 06:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243973AbhDFGXm (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 6 Apr 2021 02:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237578AbhDFGXm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Apr 2021 02:23:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94249C06174A;
        Mon,  5 Apr 2021 23:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=RAajxzsZbgFDmz+U6PJWPSdLyTtFePXrDy8oE97nt8o=; b=0PpefCbAlrTSKJo37dbov/xpCt
        rIbaB6DTZOceRat2zfw6q8LzwL1TTnpU1vmCNkCbRqQi/vHj+/xNbgFGEm/9ICPy/Z964QTo59L3f
        4L6ppfBLmhJ0pfldT7Df3/qDEIvM4bzJvMhJotq/MDuN1IfWg2uRaph9HRAChTslzpVtm1iFZXiq4
        ALYcNw8ZTica6a6ewnpFwJScEH9bc6HI9+lTfkwHqeorjg0iNnnwIYxrv3ubfFa4qvtBLpW7vQy9R
        XT5uBpglGy4TsEkLNqzr8jM0VZ4AqDPgW9aE0OE/c5Qi2fQo5bYW5AjO43+MfsRBIJj7jDxJuCO99
        YoH7itfw==;
Received: from [2001:4bb8:188:4907:c664:b479:e725:f367] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lTf7d-007oA2-5E; Tue, 06 Apr 2021 06:23:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 11/11] block: remove disk_part_iter
Date:   Tue,  6 Apr 2021 08:23:02 +0200
Message-Id: <20210406062303.811835-12-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210406062303.811835-1-hch@lst.de>
References: <20210406062303.811835-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Just open code the xa_for_each in the remaining user.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c         | 92 ++++++-------------------------------------
 include/linux/genhd.h | 19 ---------
 2 files changed, 13 insertions(+), 98 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index cbfe1ff19360b3..39ca97b0edc612 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -161,81 +161,6 @@ static void part_in_flight_rw(struct block_device *part,
 		inflight[1] = 0;
 }
 
-/**
- * disk_part_iter_init - initialize partition iterator
- * @piter: iterator to initialize
- * @disk: disk to iterate over
- * @flags: DISK_PITER_* flags
- *
- * Initialize @piter so that it iterates over partitions of @disk.
- *
- * CONTEXT:
- * Don't care.
- */
-void disk_part_iter_init(struct disk_part_iter *piter, struct gendisk *disk,
-			  unsigned int flags)
-{
-	piter->disk = disk;
-	piter->part = NULL;
-	if (flags & (DISK_PITER_INCL_PART0 | DISK_PITER_INCL_EMPTY_PART0))
-		piter->idx = 0;
-	else
-		piter->idx = 1;
-	piter->flags = flags;
-}
-
-/**
- * disk_part_iter_next - proceed iterator to the next partition and return it
- * @piter: iterator of interest
- *
- * Proceed @piter to the next partition and return it.
- *
- * CONTEXT:
- * Don't care.
- */
-struct block_device *disk_part_iter_next(struct disk_part_iter *piter)
-{
-	struct block_device *part;
-	unsigned long idx;
-
-	/* put the last partition */
-	disk_part_iter_exit(piter);
-
-	rcu_read_lock();
-	xa_for_each_start(&piter->disk->part_tbl, idx, part, piter->idx) {
-		if (!bdev_nr_sectors(part) &&
-		    !(piter->flags & DISK_PITER_INCL_EMPTY) &&
-		    !(piter->flags & DISK_PITER_INCL_EMPTY_PART0 &&
-		      piter->idx == 0))
-			continue;
-
-		piter->part = bdgrab(part);
-		if (!piter->part)
-			continue;
-		piter->idx = idx + 1;
-		break;
-	}
-	rcu_read_unlock();
-
-	return piter->part;
-}
-
-/**
- * disk_part_iter_exit - finish up partition iteration
- * @piter: iter of interest
- *
- * Called when iteration is over.  Cleans up @piter.
- *
- * CONTEXT:
- * Don't care.
- */
-void disk_part_iter_exit(struct disk_part_iter *piter)
-{
-	if (piter->part)
-		bdput(piter->part);
-	piter->part = NULL;
-}
-
 /*
  * Can be deleted altogether. Later.
  *
@@ -472,13 +397,22 @@ static char *bdevt_str(dev_t devt, char *buf)
 
 void disk_uevent(struct gendisk *disk, enum kobject_action action)
 {
-	struct disk_part_iter piter;
 	struct block_device *part;
+	unsigned long idx;
+
+	rcu_read_lock();
+	xa_for_each(&disk->part_tbl, idx, part) {
+		if (bdev_is_partition(part) && !bdev_nr_sectors(part))
+			continue;
+		if (!bdgrab(part))
+			continue;
 
-	disk_part_iter_init(&piter, disk, DISK_PITER_INCL_EMPTY_PART0);
-	while ((part = disk_part_iter_next(&piter)))
+		rcu_read_unlock();
 		kobject_uevent(bdev_kobj(part), action);
-	disk_part_iter_exit(&piter);
+		bdput(part);
+		rcu_read_lock();
+	}
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(disk_uevent);
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 16178a935c4041..7e9660ea967d59 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -204,25 +204,6 @@ static inline dev_t disk_devt(struct gendisk *disk)
 
 void disk_uevent(struct gendisk *disk, enum kobject_action action);
 
-/*
- * Smarter partition iterator without context limits.
- */
-#define DISK_PITER_INCL_EMPTY	(1 << 1) /* include 0-sized parts */
-#define DISK_PITER_INCL_PART0	(1 << 2) /* include partition 0 */
-#define DISK_PITER_INCL_EMPTY_PART0 (1 << 3) /* include empty partition 0 */
-
-struct disk_part_iter {
-	struct gendisk		*disk;
-	struct block_device	*part;
-	unsigned long		idx;
-	unsigned int		flags;
-};
-
-extern void disk_part_iter_init(struct disk_part_iter *piter,
-				 struct gendisk *disk, unsigned int flags);
-struct block_device *disk_part_iter_next(struct disk_part_iter *piter);
-extern void disk_part_iter_exit(struct disk_part_iter *piter);
-
 /* block/genhd.c */
 extern void device_add_disk(struct device *parent, struct gendisk *disk,
 			    const struct attribute_group **groups);
-- 
2.30.1

