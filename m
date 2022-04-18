Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9C3C4332F
	for <linux-s390@archiver.kernel.org>; Mon, 18 Apr 2022 04:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbiDRE4b (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 18 Apr 2022 00:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236552AbiDRE40 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 18 Apr 2022 00:56:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A992317AA1;
        Sun, 17 Apr 2022 21:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=5rcnJ83GrgSSabCav/BawazCovpIiEvHei2b2gmullQ=; b=CjJhpozaz3ZvUqlOlRhUG6HF0e
        L1k08qBdI7FjLxrC+2SHHoNWrKKNNyMlTyF4yTi95nmPu6QjzipSWH9TvaHMjTe8XoTWpzOf49Xwn
        /jTNmyPXW291lu9ai/kVpUcGZy0BEma/a+v71WBQptYeQK53Oa4G3wRCg1iH80jgNCDh+UkonCJTi
        b2hNWpI0YPpjBR+0L2Bg82wVndKnPmP8XXH33hc/RLegnrrgdomyqC3ANZRjwyzqph4yUIcfGGV1b
        13e7GSLfhf8SaHCAofITijpch9zJ9GPiLs40aqk7qM6e7KoHhSnPrPVcNE2jwVOMrxC25OuZ8i44W
        kFZNgihA==;
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngJOI-00FYkg-0o; Mon, 18 Apr 2022 04:53:34 +0000
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
Subject: [PATCH 06/11] raid5: don't set the discard_alignment queue limit
Date:   Mon, 18 Apr 2022 06:53:09 +0200
Message-Id: <20220418045314.360785-7-hch@lst.de>
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
Setting it to the discard granularity as done by raid5 is mostly
harmless but also useless.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/raid5.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 59f91e392a2ae..39b0afdf40d0a 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7749,7 +7749,6 @@ static int raid5_run(struct mddev *mddev)
 		 */
 		stripe = stripe * PAGE_SIZE;
 		stripe = roundup_pow_of_two(stripe);
-		mddev->queue->limits.discard_alignment = stripe;
 		mddev->queue->limits.discard_granularity = stripe;
 
 		blk_queue_max_write_zeroes_sectors(mddev->queue, 0);
-- 
2.30.2

