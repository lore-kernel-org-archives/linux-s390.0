Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D7FC433B4
	for <linux-s390@archiver.kernel.org>; Tue,  6 Apr 2021 06:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B33EE61158
	for <linux-s390@archiver.kernel.org>; Tue,  6 Apr 2021 06:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243959AbhDFGXY (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 6 Apr 2021 02:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243960AbhDFGXW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Apr 2021 02:23:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6A1C061756;
        Mon,  5 Apr 2021 23:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=5KuPL7QFdB1G9qDrNyRxDo5HHyZo1MJRGQGSY9fZDyg=; b=w/nKgZKh1VgX1MP9qE1gsJlNRB
        tUO+5d7VPbbm1grZmyuP1WxDz7Fud9Fn5FaHPPqmQFR4htKuPwaTqethapAXqaEZWZSfG+cMvaOQm
        FN1/GIcO711XL++ZoE8hhX3SXlh6z5myT53uBijZHZkEyh03YMyXnJUJHLQ9LMxPsd7SkLxbXbDid
        5zx4rKseTXFdfD8UWcJQSeqIg5jKA+cI0REKrUGESRIoDomPUTrMmELSEGWFNcONC8JEQFA9EFazs
        NEzJN1Ia+IVBe0Wyv3hSWxmxI755nuN27czMnNp+6BNWcp9pLS88aH4c2dIo8ge8QCHarVrAMvjIF
        WA6gtMoA==;
Received: from [2001:4bb8:188:4907:c664:b479:e725:f367] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lTf7I-007o8Y-Kg; Tue, 06 Apr 2021 06:23:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 03/11] block: move more syncing and invalidation to delete_partition
Date:   Tue,  6 Apr 2021 08:22:54 +0200
Message-Id: <20210406062303.811835-4-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210406062303.811835-1-hch@lst.de>
References: <20210406062303.811835-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Move the calls to fsync_bdev and __invalidate_device from del_gendisk to
delete_partition.  For the other two callers that check that there are
no openers for the delete partitions(s) the callouts are a no-op as no
file system can be mounted, but this keeps all the cleanup in one
place.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c           | 5 +----
 block/partitions/core.c | 6 +++---
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 9b121b1f79982f..15f99da4543f6d 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -686,11 +686,8 @@ void del_gendisk(struct gendisk *disk)
 
 	/* invalidate stuff */
 	disk_part_iter_init(&piter, disk, DISK_PITER_INCL_EMPTY);
-	while ((part = disk_part_iter_next(&piter))) {
-		fsync_bdev(part);
-		__invalidate_device(part, true);
+	while ((part = disk_part_iter_next(&piter)))
 		delete_partition(part);
-	}
 	disk_part_iter_exit(&piter);
 
 	fsync_bdev(disk->part0);
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 22a0dab17ed343..8c173529294081 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -287,6 +287,9 @@ struct device_type part_type = {
  */
 void delete_partition(struct block_device *part)
 {
+	fsync_bdev(part);
+	__invalidate_device(part, true);
+
 	xa_erase(&part->bd_disk->part_tbl, part->bd_partno);
 	kobject_put(part->bd_holder_dir);
 	device_del(&part->bd_device);
@@ -468,9 +471,6 @@ int bdev_del_partition(struct block_device *bdev, int partno)
 	if (part->bd_openers)
 		goto out_unlock;
 
-	sync_blockdev(part);
-	invalidate_bdev(part);
-
 	delete_partition(part);
 	ret = 0;
 out_unlock:
-- 
2.30.1

