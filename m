Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CA6C43461
	for <linux-s390@archiver.kernel.org>; Tue,  6 Apr 2021 06:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A25C661158
	for <linux-s390@archiver.kernel.org>; Tue,  6 Apr 2021 06:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243967AbhDFGXa (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 6 Apr 2021 02:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243964AbhDFGXa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Apr 2021 02:23:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA307C06174A;
        Mon,  5 Apr 2021 23:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=qaur9OH9gVMvYjy2lOHkhtgSAHB7iB3pkpNLvfUXGBM=; b=uhcWB41P2V0WE+/5hQHD8RxW12
        UuZyfX58SQRV6CxApuXR467brZc9TGmkOEn84cPRsTh4q2VOZ8Kb+ITPEhOe4Hf/ajDJ8bu7zUkY1
        O68vQoGCE1WGroF4ZZtKBgUZ8O/ffKYVvyVUntDXBtC9tfbUBjqpIElv4g+SD8ajWj228cQ5rNRGs
        gt6nOEdcW5laPo4MhLrmel0xQKqHJrFtkAc9HcGyppq1g2McdlV/NqwwCjEBs968PciBoFCv+NXGN
        UR0r0cc+lCI+k5f8BIH/I3VSMDhpcNNR+rUWheyqhgR3224qxYDzJioBH9W/aG7CQO3vpOBTlXgLV
        /FY2bkNg==;
Received: from [2001:4bb8:188:4907:c664:b479:e725:f367] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lTf7Q-007o95-Ae; Tue, 06 Apr 2021 06:23:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 06/11] block: simplify partition removal
Date:   Tue,  6 Apr 2021 08:22:57 +0200
Message-Id: <20210406062303.811835-7-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210406062303.811835-1-hch@lst.de>
References: <20210406062303.811835-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Always look up the first available entry instead of the complicated
stateful traversal.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 9fbaec466b516d..927144d4e59d39 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -528,15 +528,17 @@ static bool disk_unlock_native_capacity(struct gendisk *disk)
 
 void blk_drop_partitions(struct gendisk *disk)
 {
-	struct disk_part_iter piter;
 	struct block_device *part;
+	unsigned long idx;
 
 	lockdep_assert_held(&disk->part0->bd_mutex);
 
-	disk_part_iter_init(&piter, disk, DISK_PITER_INCL_EMPTY);
-	while ((part = disk_part_iter_next(&piter)))
+	xa_for_each_start(&disk->part_tbl, idx, part, 1) {
+		if (!bdgrab(part))
+			continue;
 		delete_partition(part);
-	disk_part_iter_exit(&piter);
+		bdput(part);
+	}
 }
 
 static bool blk_add_partition(struct gendisk *disk, struct block_device *bdev,
-- 
2.30.1

