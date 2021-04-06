Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1488C433B4
	for <linux-s390@archiver.kernel.org>; Tue,  6 Apr 2021 06:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6CB9610CC
	for <linux-s390@archiver.kernel.org>; Tue,  6 Apr 2021 06:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243972AbhDFGXk (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 6 Apr 2021 02:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237744AbhDFGXj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Apr 2021 02:23:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6708DC06174A;
        Mon,  5 Apr 2021 23:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=DEl5LfCFZqEVWzPW5v0ME6GD6QWnwSH1wHQj1zl2214=; b=n2DYlHRnisx7Dw7jc2IbzecNq5
        +961Ef+lMTju7wQr+/GFzmreETAltPRNRthdhY34VGUWOTebljBhaAMNMPOvjv2dYMkMO79RduHk9
        M0t9Uee3ZYkmsh3m8h9W56OWTryvPeIh6D+neaqf6mY9CCj2Qcbse6EeoB7K6tcb6Ik8fBSbymVQ0
        p+G4SBp0mTj4bhEP7MqZVUKKL741dZSR7TWwjzRTl5V2D16QFrBN17FUrAl6tW9oVz+hQv2wGnV0x
        dddQ9T+8A62PgTRqzgwoiYP4p+kjU/wjiTsa0W34ojKYoJ+tR3aUfcu9FET/8yp7QU9Xs+i8HAT/0
        liuBHXlA==;
Received: from [2001:4bb8:188:4907:c664:b479:e725:f367] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lTf7a-007o9q-GU; Tue, 06 Apr 2021 06:23:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 10/11] block: simplify diskstats_show
Date:   Tue,  6 Apr 2021 08:23:01 +0200
Message-Id: <20210406062303.811835-11-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210406062303.811835-1-hch@lst.de>
References: <20210406062303.811835-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Just use xa_for_each to iterate over the partitions as there is no need
to grab a reference to each partition.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 5726714ef82fcf..cbfe1ff19360b3 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1236,11 +1236,11 @@ const struct device_type disk_type = {
 static int diskstats_show(struct seq_file *seqf, void *v)
 {
 	struct gendisk *gp = v;
-	struct disk_part_iter piter;
 	struct block_device *hd;
 	char buf[BDEVNAME_SIZE];
 	unsigned int inflight;
 	struct disk_stats stat;
+	unsigned long idx;
 
 	/*
 	if (&disk_to_dev(gp)->kobj.entry == block_class.devices.next)
@@ -1250,8 +1250,10 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 				"\n\n");
 	*/
 
-	disk_part_iter_init(&piter, gp, DISK_PITER_INCL_EMPTY_PART0);
-	while ((hd = disk_part_iter_next(&piter))) {
+	rcu_read_lock();
+	xa_for_each(&gp->part_tbl, idx, hd) {
+		if (bdev_is_partition(hd) && !bdev_nr_sectors(hd))
+			continue;
 		part_stat_read_all(hd, &stat);
 		if (queue_is_mq(gp->queue))
 			inflight = blk_mq_in_flight(gp->queue, hd);
@@ -1294,7 +1296,7 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 						 NSEC_PER_MSEC)
 			);
 	}
-	disk_part_iter_exit(&piter);
+	rcu_read_unlock();
 
 	return 0;
 }
-- 
2.30.1

