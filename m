Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480E2C433B4
	for <linux-s390@archiver.kernel.org>; Tue,  6 Apr 2021 06:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FC8061165
	for <linux-s390@archiver.kernel.org>; Tue,  6 Apr 2021 06:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243962AbhDFGX1 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 6 Apr 2021 02:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243961AbhDFGX1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Apr 2021 02:23:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF30C06174A;
        Mon,  5 Apr 2021 23:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=m9LVG6cJPUJmdlttZ9XhQ31y6gyH7qsigKorgO2UxpI=; b=2SQ1oBOfE23jy2gz2Ye1oqxLrf
        k9Tk2xcQVShiCaXSJRf8+kL07hCz0bv0gY0O4XBBAwBwXGNVRjY5b0GqY6lk4fWHvjlquNwdTzYTe
        J2N/pHUHJpLvBMQwhm8F+ulcc6zSeuKZBbkV6PEH+S+x8+xL86a/CJbgJ4Jlr9zpsiHzx16MYVham
        lEXIEn/SDhe7XSYjZuL4l4q9wesGvlCTfBP13lyphpxg9g5RRJQyJn6JztIKbmF1KhkPaJZJ0T9hD
        CbuH4RvX5ekEcdZdlyYnaQ2vLifMSiBF/3ZmzTS1sF9E79igFZxVuoYB7wzNJv2lOpEqdOFmLWvG2
        BWqHudlg==;
Received: from [2001:4bb8:188:4907:c664:b479:e725:f367] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lTf7N-007o8t-OE; Tue, 06 Apr 2021 06:23:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 05/11] block: take bd_mutex around delete_partitions in del_gendisk
Date:   Tue,  6 Apr 2021 08:22:56 +0200
Message-Id: <20210406062303.811835-6-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210406062303.811835-1-hch@lst.de>
References: <20210406062303.811835-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

There is nothing preventing an ioctl from trying do delete partition
concurrenly with del_gendisk, so take open_mutex to serialize against
that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c           | 4 ++++
 block/partitions/core.c | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 8303ec67fd7099..e3f3c2321773f9 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -680,7 +680,11 @@ void del_gendisk(struct gendisk *disk)
 	 * disk is marked as dead (GENHD_FL_UP cleared).
 	 */
 	down_write(&bdev_lookup_sem);
+
+	mutex_lock(&disk->part0->bd_mutex);
 	blk_drop_partitions(disk);
+	mutex_unlock(&disk->part0->bd_mutex);
+
 	fsync_bdev(disk->part0);
 	__invalidate_device(disk->part0, true);
 
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 536f7c5bb0b6d2..9fbaec466b516d 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -531,6 +531,8 @@ void blk_drop_partitions(struct gendisk *disk)
 	struct disk_part_iter piter;
 	struct block_device *part;
 
+	lockdep_assert_held(&disk->part0->bd_mutex);
+
 	disk_part_iter_init(&piter, disk, DISK_PITER_INCL_EMPTY);
 	while ((part = disk_part_iter_next(&piter)))
 		delete_partition(part);
-- 
2.30.1

