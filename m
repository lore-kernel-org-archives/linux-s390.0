Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6A0C43460
	for <linux-s390@archiver.kernel.org>; Tue,  6 Apr 2021 06:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C681610CC
	for <linux-s390@archiver.kernel.org>; Tue,  6 Apr 2021 06:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243957AbhDFGXT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 6 Apr 2021 02:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbhDFGXT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Apr 2021 02:23:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F08C061756;
        Mon,  5 Apr 2021 23:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ZxjdBIJx6yQo+qKhL3VUdZ6oPF/3/o8xHTNwsshG60g=; b=fVgtC5wOcOe5iFSGFVq7dDDbCP
        kbfq4I4byAvPictYLamZDXZL5iiK16gm/woV9mnpUUsIDaFiSev3gTiYpHwHsVQH1bUm6n60NAGbL
        50o8WAp8vr/2VL+CvpuerbPY1phdxyqi0kwALsGGrob+0Bq2YcE5xGbzDDi4vsXQklfuNHvAFhDf7
        bNs3C6IT05URTxWe+l4bVsT7Do+UlT03LJtCzjYjo42VLeKvNBpwy/JNApEHGPHIwt0ksUg6NKjCo
        iUPoAF20y50rPuQJQWs89Fm1j/0YLDN1EiwChnhqDfVBa1s/L3CKyLOWm6UkmvccSWxc7fti19Rme
        hNBLnGKA==;
Received: from [2001:4bb8:188:4907:c664:b479:e725:f367] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lTf7G-007o8Q-2v; Tue, 06 Apr 2021 06:23:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 02/11] block: remove invalidate_partition
Date:   Tue,  6 Apr 2021 08:22:53 +0200
Message-Id: <20210406062303.811835-3-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210406062303.811835-1-hch@lst.de>
References: <20210406062303.811835-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

invalidate_partition has two callers, one of which already performs
the remove_inode_hash just after the call.  Just open code the
function in the two callsites.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 8c8f543572e64e..9b121b1f79982f 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -646,18 +646,6 @@ void device_add_disk_no_queue_reg(struct device *parent, struct gendisk *disk)
 }
 EXPORT_SYMBOL(device_add_disk_no_queue_reg);
 
-static void invalidate_partition(struct block_device *bdev)
-{
-	fsync_bdev(bdev);
-	__invalidate_device(bdev, true);
-
-	/*
-	 * Unhash the bdev inode for this device so that it can't be looked
-	 * up any more even if openers still hold references to it.
-	 */
-	remove_inode_hash(bdev->bd_inode);
-}
-
 /**
  * del_gendisk - remove the gendisk
  * @disk: the struct gendisk to remove
@@ -699,12 +687,21 @@ void del_gendisk(struct gendisk *disk)
 	/* invalidate stuff */
 	disk_part_iter_init(&piter, disk, DISK_PITER_INCL_EMPTY);
 	while ((part = disk_part_iter_next(&piter))) {
-		invalidate_partition(part);
+		fsync_bdev(part);
+		__invalidate_device(part, true);
 		delete_partition(part);
 	}
 	disk_part_iter_exit(&piter);
 
-	invalidate_partition(disk->part0);
+	fsync_bdev(disk->part0);
+	__invalidate_device(disk->part0, true);
+
+	/*
+	 * Unhash the bdev inode for this device so that it can't be looked
+	 * up any more even if openers still hold references to it.
+	 */
+	remove_inode_hash(disk->part0->bd_inode);
+
 	set_capacity(disk, 0);
 	disk->flags &= ~GENHD_FL_UP;
 	up_write(&bdev_lookup_sem);
-- 
2.30.1

