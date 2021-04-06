Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F46C43460
	for <linux-s390@archiver.kernel.org>; Tue,  6 Apr 2021 06:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E009361158
	for <linux-s390@archiver.kernel.org>; Tue,  6 Apr 2021 06:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243971AbhDFGXh (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 6 Apr 2021 02:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243963AbhDFGXh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Apr 2021 02:23:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6BEC06174A;
        Mon,  5 Apr 2021 23:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=92EneDdE4OcoLq6A6aZkefr59JiGrN5mEu5hC8tv4p0=; b=3cYqbfRaY/bIQsnltvjslzb4u+
        abATXRpPqLoN1slrZnICyD6YPD7DT+gpWsCs6oGKs0FpSKod8/nGNBxrHzAa55+49qqAQ1XbY9eMI
        fqnpv7KriOkdNeQcw2PM/kvclifi0cn9SxOd7u0epGprjBa/Rfa7CLWicgE+ZMKL/U7ugVy4vA/Ua
        qe3HFtZCn57HeTmTfUEtrhE1zqbr3U7Qm7R9/WY+YnJTGymjfiahMPbqfzqN+ssztnITpBxi3X5rN
        qqrohr6y4ItIn+Z2Xuo7ueA6+JWCKrIzbs1XxRXcxMhgRa0QGG06/fTmYlfB6OuYzwlIW8QoUI4bE
        csEmU7Hg==;
Received: from [2001:4bb8:188:4907:c664:b479:e725:f367] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lTf7X-007o9h-Tw; Tue, 06 Apr 2021 06:23:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 09/11] block: simplify show_partition
Date:   Tue,  6 Apr 2021 08:23:00 +0200
Message-Id: <20210406062303.811835-10-hch@lst.de>
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
 block/genhd.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 409ff4710f9215..5726714ef82fcf 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -907,8 +907,8 @@ static void *show_partition_start(struct seq_file *seqf, loff_t *pos)
 static int show_partition(struct seq_file *seqf, void *v)
 {
 	struct gendisk *sgp = v;
-	struct disk_part_iter piter;
 	struct block_device *part;
+	unsigned long idx;
 	char buf[BDEVNAME_SIZE];
 
 	/* Don't show non-partitionable removeable devices or empty devices */
@@ -918,15 +918,16 @@ static int show_partition(struct seq_file *seqf, void *v)
 	if (sgp->flags & GENHD_FL_SUPPRESS_PARTITION_INFO)
 		return 0;
 
-	/* show the full disk and all non-0 size partitions of it */
-	disk_part_iter_init(&piter, sgp, DISK_PITER_INCL_PART0);
-	while ((part = disk_part_iter_next(&piter)))
+	rcu_read_lock();
+	xa_for_each(&sgp->part_tbl, idx, part) {
+		if (!bdev_nr_sectors(part))
+			continue;
 		seq_printf(seqf, "%4d  %7d %10llu %s\n",
 			   MAJOR(part->bd_dev), MINOR(part->bd_dev),
 			   bdev_nr_sectors(part) >> 1,
 			   disk_name(sgp, part->bd_partno, buf));
-	disk_part_iter_exit(&piter);
-
+	}
+	rcu_read_unlock();
 	return 0;
 }
 
-- 
2.30.1

