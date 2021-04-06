Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0852BC433B4
	for <linux-s390@archiver.kernel.org>; Tue,  6 Apr 2021 06:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADB0161158
	for <linux-s390@archiver.kernel.org>; Tue,  6 Apr 2021 06:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbhDFGXT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 6 Apr 2021 02:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbhDFGXS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Apr 2021 02:23:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB96BC06174A;
        Mon,  5 Apr 2021 23:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=BWQZvJGx1yMk9mPcFSEWAbEcIL5nTc+mo7i5flqgF0k=; b=nX58f1v4qtinkOcD6oHqmxGZcG
        wsDmdjQJrHFAuxuF9EHh/w0DiDc8vm/gbOApFeuzkT1o367Q6JJlP98ExYFbo9CBF3Lg45Gp0I4qP
        OVFhkjA0b7yeekFWGclbeWGkK+woeNIO+lAb4eiIP1DE9/weFMaliCPIo7OyygXUd1sckM7oZbNH2
        HxLJc7EGXHZbWckKwewaW3iNGzjaduTPtihK5pbkCJkeFtgCGkNzBX5PFqF7fcUXfoqXDC0T3zcoq
        W4eGPOi9+bGBv5139TcsCwqMMyDaUpE0cXVxvbXAFKOmsdcc44IoC506Iiw42HVwXbwGCcAD52p8I
        vV7vdlxw==;
Received: from [2001:4bb8:188:4907:c664:b479:e725:f367] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lTf7D-007o8E-Es; Tue, 06 Apr 2021 06:23:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 01/11] dasd: use bdev_disk_changed instead of blk_drop_partitions
Date:   Tue,  6 Apr 2021 08:22:52 +0200
Message-Id: <20210406062303.811835-2-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210406062303.811835-1-hch@lst.de>
References: <20210406062303.811835-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Use the more general interface - the behavior is the same except
that now a change uevent is sent, which is the right thing to do
when the device becomes unusable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/core.c         | 4 ----
 drivers/s390/block/dasd_genhd.c | 3 +--
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 1a7558917c47d6..22a0dab17ed343 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -544,10 +544,6 @@ int blk_drop_partitions(struct block_device *bdev)
 
 	return 0;
 }
-#ifdef CONFIG_S390
-/* for historic reasons in the DASD driver */
-EXPORT_SYMBOL_GPL(blk_drop_partitions);
-#endif
 
 static bool blk_add_partition(struct gendisk *disk, struct block_device *bdev,
 		struct parsed_partitions *state, int p)
diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index a9698fba9b76ce..8d6587ec73e208 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -146,12 +146,11 @@ void dasd_destroy_partitions(struct dasd_block *block)
 	block->bdev = NULL;
 
 	mutex_lock(&bdev->bd_mutex);
-	blk_drop_partitions(bdev);
+	bdev_disk_changed(bdev, true);
 	mutex_unlock(&bdev->bd_mutex);
 
 	/* Matching blkdev_put to the blkdev_get in dasd_scan_partitions. */
 	blkdev_put(bdev, FMODE_READ);
-	set_capacity(block->gdp, 0);
 }
 
 int dasd_gendisk_init(void)
-- 
2.30.1

