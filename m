Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67FBC43219
	for <linux-s390@archiver.kernel.org>; Mon, 18 Apr 2022 04:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbiDRE41 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 18 Apr 2022 00:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236547AbiDRE4W (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 18 Apr 2022 00:56:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4908C17ABA;
        Sun, 17 Apr 2022 21:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=jJDfNJ+noyJ0aQwSxPjfuM0bukOLXIlZdKOCCRo7UC0=; b=xuIkX7BaO7YLYo2xtforYUeJSz
        D4ZkceNgWZcqsdA4kKDR70kSEQCNujP+EuBqv6qBw0ZF92W/0/cEfjWOan0nETRKihTYr6lzIZlZl
        bBcwq/JHARHxWpbiEMaI9y7fhWsSop569zSNCbdEUmCgnceKeTdNHmdubHo2T02f4jZnDeMuy9YEp
        gX5Gk0YQFUdeh+lTgVE6905xov9XyUfA8uV/rEBVxEimHbnB03TXVy+Q+6Z3Gp8bR9szIE8Cp8Ndy
        rknbV4gm7RVldjeoTzmK+sn63+wAUNv9Myo89P/eXTHdhfPYO+SAS69EJRqWmwD6yqU/r8IFcrYqq
        /61rhfuw==;
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngJOE-00FYjt-Uc; Mon, 18 Apr 2022 04:53:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Richard Weinberger <richard@nod.at>,
        Johannes Berg <johannes@sipsolutions.net>,
        Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Mike Snitzer <snitzer@kernel.org>, Song Liu <song@kernel.org>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-um@lists.infradead.org, linux-block@vger.kernel.org,
        nbd@other.debian.org, virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-raid@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
        dm-devel@redhat.com
Subject: [PATCH 05/11] dm-zoned: don't set the discard_alignment queue limit
Date:   Mon, 18 Apr 2022 06:53:08 +0200
Message-Id: <20220418045314.360785-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220418045314.360785-1-hch@lst.de>
References: <20220418045314.360785-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The discard_alignment queue limit is named a bit misleading means the
offset into the block device at which the discard granularity starts.
Setting it to the discard granularity as done by dm-zoned is mostly
harmless but also useless.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm-zoned-target.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
index cac295cc8840e..0ec5d8b9b1a4e 100644
--- a/drivers/md/dm-zoned-target.c
+++ b/drivers/md/dm-zoned-target.c
@@ -1001,7 +1001,7 @@ static void dmz_io_hints(struct dm_target *ti, struct queue_limits *limits)
 	blk_limits_io_min(limits, DMZ_BLOCK_SIZE);
 	blk_limits_io_opt(limits, DMZ_BLOCK_SIZE);
 
-	limits->discard_alignment = DMZ_BLOCK_SIZE;
+	limits->discard_alignment = 0;
 	limits->discard_granularity = DMZ_BLOCK_SIZE;
 	limits->max_discard_sectors = chunk_sectors;
 	limits->max_hw_discard_sectors = chunk_sectors;
-- 
2.30.2

