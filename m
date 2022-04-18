Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00304C43217
	for <linux-s390@archiver.kernel.org>; Mon, 18 Apr 2022 04:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236542AbiDRE4U (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 18 Apr 2022 00:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbiDRE4S (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 18 Apr 2022 00:56:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C96E17ABF;
        Sun, 17 Apr 2022 21:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=koCagwvOxhN7Shu8/AJxKzZVAKuzrO1L5//iYnC02Iw=; b=AfuHTR/V7lcr3zFbVv43aXi0wl
        9BXiL1MXkRpqJBplwxZBu6BMXzKAwM3cLacngv6w9v/xu4r4wsZXJzUpjj8oykifbHGOdLOj9+cXd
        w57UeuYr1aXFL4KN5snqFZNRlx3/zg/as2hg/byKwuFPkRBWSqYCMgz6Nalf6bjYlUrYWYMFOg7lM
        VVtAyBmc/UB6YQDpwNy9RxJMNN3OFjU5UKmrw+vl4PuZd7vQ6hmG2jXje40n9Bl31/uUTw3g/iABO
        fgajCyxoKwPRp2bRxD9DHepUAQfpOnb0+QEai/a9nd+iaTwNGZ7XqT7mmOiN9r3r1T9l317vuoSmZ
        0Zs1vSZQ==;
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngJO6-00FYhe-Hq; Mon, 18 Apr 2022 04:53:23 +0000
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
Subject: [PATCH 02/11] nbd: don't set the discard_alignment queue limit
Date:   Mon, 18 Apr 2022 06:53:05 +0200
Message-Id: <20220418045314.360785-3-hch@lst.de>
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
Setting it to the discard granularity as done by nbd is mostly harmless
but also useless.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/nbd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 4729aef8c6462..102597a4277b9 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -333,7 +333,6 @@ static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
 
 	if (nbd->config->flags & NBD_FLAG_SEND_TRIM) {
 		nbd->disk->queue->limits.discard_granularity = blksize;
-		nbd->disk->queue->limits.discard_alignment = blksize;
 		blk_queue_max_discard_sectors(nbd->disk->queue, UINT_MAX);
 	}
 	blk_queue_logical_block_size(nbd->disk->queue, blksize);
@@ -1316,7 +1315,6 @@ static void nbd_config_put(struct nbd_device *nbd)
 
 		nbd->tag_set.timeout = 0;
 		nbd->disk->queue->limits.discard_granularity = 0;
-		nbd->disk->queue->limits.discard_alignment = 0;
 		blk_queue_max_discard_sectors(nbd->disk->queue, 0);
 
 		mutex_unlock(&nbd->config_lock);
@@ -1781,7 +1779,6 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, disk->queue);
 	disk->queue->limits.discard_granularity = 0;
-	disk->queue->limits.discard_alignment = 0;
 	blk_queue_max_discard_sectors(disk->queue, 0);
 	blk_queue_max_segment_size(disk->queue, UINT_MAX);
 	blk_queue_max_segments(disk->queue, USHRT_MAX);
-- 
2.30.2

