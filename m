Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E8FC8302B
	for <linux-s390@archiver.kernel.org>; Thu,  2 Sep 2021 17:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02907610FF
	for <linux-s390@archiver.kernel.org>; Thu,  2 Sep 2021 17:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346829AbhIBRms (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 2 Sep 2021 13:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347007AbhIBRmT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 2 Sep 2021 13:42:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF550C061575;
        Thu,  2 Sep 2021 10:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ilbb48sqogj6iNrSuGXApVFyW8HytSyePznS4TNJN14=; b=WlDDGhUm2tP51IZDetaBHp0k69
        /ROQQWCQ1zJ4q0H7IO1cOBypaAIBW9SxhYayHD0rItVOO9aEKHgyigbZpIbu0QMRmyOe2jAzPb7TL
        zLSPoE/dYdBu7Ng3A5Ana6zbunqkTrT7fdiVgIFmQKSs+cDA1xdsGKkvX9+qNEp0h0DY179ebqfEW
        dRPUx4GD7ZbFeCKktPP34GcUbzVyze9rU3csI66I3x52b+be6IbpWEYzaRQbHr1wcFVh/YMsC4d2z
        iM10GEFD+gzzIpbV84sZBGYPUDibUf8KOqZoCox9eYK6VzGdJugR+1MiDm+MrgFDN79y050zKGOB+
        rYtIGjBQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLqi2-00A9FM-5Z; Thu, 02 Sep 2021 17:41:06 +0000
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
Subject: [PATCH 6/9] s390/block/dasd_genhd: add error handling support for add_disk()
Date:   Thu,  2 Sep 2021 10:41:02 -0700
Message-Id: <20210902174105.2418771-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210902174105.2418771-1-mcgrof@kernel.org>
References: <20210902174105.2418771-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

We never checked for errors on add_disk() as this function
returned void. Now that this is fixed, use the shiny new
error handling.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/s390/block/dasd_genhd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index fa966e0db6ca..ba07022283bc 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -33,7 +33,7 @@ int dasd_gendisk_alloc(struct dasd_block *block)
 {
 	struct gendisk *gdp;
 	struct dasd_device *base;
-	int len;
+	int len, rc;
 
 	/* Make sure the minor for this device exists. */
 	base = block->base;
@@ -79,7 +79,11 @@ int dasd_gendisk_alloc(struct dasd_block *block)
 	dasd_add_link_to_gendisk(gdp, base);
 	block->gdp = gdp;
 	set_capacity(block->gdp, 0);
-	device_add_disk(&base->cdev->dev, block->gdp, NULL);
+
+	rc = device_add_disk(&base->cdev->dev, block->gdp, NULL);
+	if (rc)
+		return rc;
+
 	return 0;
 }
 
-- 
2.30.2

