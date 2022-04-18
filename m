Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FDBC4332F
	for <linux-s390@archiver.kernel.org>; Mon, 18 Apr 2022 04:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236576AbiDRE47 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 18 Apr 2022 00:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236577AbiDRE4x (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 18 Apr 2022 00:56:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E7917E23;
        Sun, 17 Apr 2022 21:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FtH/TzYq8qAlMP8iMYBlGWDgAyvZ+dC0QKeXw0CO9iY=; b=BUsTo3zH0HXFlc2PINU8GKGh7x
        xOheprcMV4SR/Bv+uFwxwEEXQNbDYNV0dXmpOloJvszTTFIFrVWaZxvzBY3RFcl0N0jCpn4vw3nb4
        mTGNcSlargn2+/9oPzLzWJrWP+vix6g0SW/61Ow0uZFQlb8WOgevrVuktiq9QO8aHLzYorKaOwQBQ
        CfxG3eR2YUokj3T01RV5d+uhBYCjSMPbPfvUkXoiOxJvCqf7RvI027xldIPQkqonm5kkPHmkKj1CY
        TNHlrnSp6mhzujyAzSdQ8dHMYyS7hxSExdUVN15TaHiISjHO2rUQKK97SneL+jfBatao0hyUgCdvx
        1/5nIEmg==;
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngJOW-00FYuM-S5; Mon, 18 Apr 2022 04:53:49 +0000
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
Subject: [PATCH 11/11] xen-blkback: use bdev_discard_alignment
Date:   Mon, 18 Apr 2022 06:53:14 +0200
Message-Id: <20220418045314.360785-12-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220418045314.360785-1-hch@lst.de>
References: <20220418045314.360785-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Use bdev_discard_alignment to calculate the correct discard alignment
offset even for partitions instead of just looking at the queue limit.

Also switch to use bdev_discard_granularity to get rid of the last direct
queue reference in xen_blkbk_discard.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/xen-blkback/xenbus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index b21bffc9c50bc..04c90cb8955f6 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -583,14 +583,14 @@ static void xen_blkbk_discard(struct xenbus_transaction xbt, struct backend_info
 	if (bdev_max_discard_sectors(bdev)) {
 		err = xenbus_printf(xbt, dev->nodename,
 			"discard-granularity", "%u",
-			q->limits.discard_granularity);
+			bdev_discard_granularity(bdev));
 		if (err) {
 			dev_warn(&dev->dev, "writing discard-granularity (%d)", err);
 			return;
 		}
 		err = xenbus_printf(xbt, dev->nodename,
 			"discard-alignment", "%u",
-			q->limits.discard_alignment);
+			bdev_discard_alignment(bdev));
 		if (err) {
 			dev_warn(&dev->dev, "writing discard-alignment (%d)", err);
 			return;
-- 
2.30.2

