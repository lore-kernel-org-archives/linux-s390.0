Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B07C4167D
	for <linux-s390@archiver.kernel.org>; Mon, 27 Sep 2021 22:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96EE460EB6
	for <linux-s390@archiver.kernel.org>; Mon, 27 Sep 2021 22:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238213AbhI0WFy (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237700AbhI0WF3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 27 Sep 2021 18:05:29 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E873C061237;
        Mon, 27 Sep 2021 15:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=1bxbk0s3lfDVOxUu9YL+DFpJGCsQmsW80G59PebYRqE=; b=JOIVwBerggyzrPmtHFxFn58ywH
        /AViPyNwCH3ThT1G85Hhg7E6By7AakeNVzBatgzAFyaXitKHn6L9JxZuguE5/fjWU8eKUoMjSDEGu
        i1fmqXlzw5xdqu/4EBS3X7DkjarTLked8IRqeDKpc4iIsahClMiV/QUkOYBQEzg0EwUaTtb4ndN7N
        or+EEDY4U3RfKdrWrZ0l/fe05F0DOuLUvKoKXD7/ouvhqdC9NrreSf8uf4m3zyUwweZmSMZ9CeB9K
        Ye+CQPia/s1sv5kknNr9S0+/K3w2B/NNglBPpnX4uJexsoFm7WdjSMbcxQJScV7ulYU3z5/Ed43UU
        lBaywaYQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUyhl-004Utw-O2; Mon, 27 Sep 2021 22:02:33 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, gregkh@linuxfoundation.org,
        chaitanya.kulkarni@wdc.com, atulgopinathan@gmail.com, hare@suse.de,
        maximlevitsky@gmail.com, oakad@yahoo.com, ulf.hansson@linaro.org,
        colin.king@canonical.com, shubhankarvk@gmail.com,
        baijiaju1990@gmail.com, trix@redhat.com,
        dongsheng.yang@easystack.cn, ceph-devel@vger.kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        sth@linux.ibm.com, hoeppner@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com, oberpar@linux.ibm.com,
        tj@kernel.org
Cc:     linux-s390@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 3/6] mtd: add add_disk() error handling
Date:   Mon, 27 Sep 2021 15:02:29 -0700
Message-Id: <20210927220232.1071926-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210927220232.1071926-1-mcgrof@kernel.org>
References: <20210927220232.1071926-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

We never checked for errors on add_disk() as this function
returned void. Now that this is fixed, use the shiny new
error handling.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/mtd/mtd_blkdevs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index b8ae1ec14e17..4eaba6f4ec68 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -384,7 +384,9 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
 	if (new->readonly)
 		set_disk_ro(gd, 1);
 
-	device_add_disk(&new->mtd->dev, gd, NULL);
+	ret = device_add_disk(&new->mtd->dev, gd, NULL);
+	if (ret)
+		goto out_cleanup_disk;
 
 	if (new->disk_attributes) {
 		ret = sysfs_create_group(&disk_to_dev(gd)->kobj,
@@ -393,6 +395,8 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
 	}
 	return 0;
 
+out_cleanup_disk:
+	blk_cleanup_disk(new->disk);
 out_free_tag_set:
 	blk_mq_free_tag_set(new->tag_set);
 out_kfree_tag_set:
-- 
2.30.2

