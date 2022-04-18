Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EF4C433F5
	for <linux-s390@archiver.kernel.org>; Mon, 18 Apr 2022 04:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbiDRE4e (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 18 Apr 2022 00:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236559AbiDRE43 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 18 Apr 2022 00:56:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7473F17ABF;
        Sun, 17 Apr 2022 21:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Nwnahs8dGCrFyGqh76Osy38QIfFTcrX+bg/5w9K9Oig=; b=JeF0YY6h1iSEXtKIJVRU4DnakB
        iSag4ipYDNufx4HIec1J7pwr04yj7IlNVOtLFyn04Wv2YpFZQhlvsu33m0GRmsb3PkylahgmTcFWG
        A4k1DZepK4PC3rtyMOIt75ceY450AzbeQqmXxm+KLwXIuNpy9wB3M0Uxbj7eFeRU7NZgOrm9qsdNf
        A83iEm2C44aUr+gvbqtQjawIInyHUcvlGHqsANM4j5nbfMhu01wcMFNv2L5KV+vzWfSNOxp+gx01K
        hklzOClX07D/J1uBkeOOPeQzaPTilIo4n7FSI/fYdOVYYmtE3o12kxKv1emVZBbh+e6QSqMnFkRxM
        x9QqhNaQ==;
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngJOO-00FYn5-24; Mon, 18 Apr 2022 04:53:40 +0000
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
Subject: [PATCH 08/11] loop: remove a spurious clear of discard_alignment
Date:   Mon, 18 Apr 2022 06:53:11 +0200
Message-Id: <20220418045314.360785-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220418045314.360785-1-hch@lst.de>
References: <20220418045314.360785-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The loop driver never sets a discard_alignment, so it also doens't need
to clear it to zero.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 976cf987b3920..61b642b966a08 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -789,7 +789,6 @@ static void loop_config_discard(struct loop_device *lo)
 		blk_queue_max_discard_sectors(q, 0);
 		blk_queue_max_write_zeroes_sectors(q, 0);
 	}
-	q->limits.discard_alignment = 0;
 }
 
 struct loop_worker {
-- 
2.30.2

