Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F53BC433EF
	for <linux-s390@archiver.kernel.org>; Mon, 18 Apr 2022 04:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbiDRE4R (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 18 Apr 2022 00:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiDRE4R (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 18 Apr 2022 00:56:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D67717AA1;
        Sun, 17 Apr 2022 21:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=tyZKBZElFW6HvHSlv9xeAjIG3dO7xKdX7mIPZUu3++o=; b=Fc1PLXWY+U61UCduGVVmNa4xRX
        W2DkcCfgMrkwb1FtowTBpkb1LuVkZ8TInpQDBRu63s01XGNymYAVBze9K7cuggrvtLVCsRIQvDof7
        ljUfhulALzTsFS4w+l71wYoV1q2Lm4YK8vgQZhkj/Np9aC0Yu9S1JLLXx3eykhjg6NsyORI3PutJm
        sTMvqTpRRhFFdcZ7EV5IvV6e5FER4KWu6+dJ4duc2TYsclYeI94eZYYw/+h90AObggztOx4giuutC
        Qw7muGk8qWXO7hVhEGAmI1WIrhzpj4Cevvqzf0Uppevy9o3pTO/Ek4OGE2kkDtP//trS4bSL7nhaU
        +mBAe6Vg==;
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngJO0-00FYhR-Fv; Mon, 18 Apr 2022 04:53:17 +0000
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
Subject: fix and cleanup discard_alignment handling
Date:   Mon, 18 Apr 2022 06:53:03 +0200
Message-Id: <20220418045314.360785-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi all,

the somewhat confusing name of the discard_alignment queue limit, that
really is an offset for the discard granularity mislead a lot of driver
authors to set it to an incorrect value.  This series tries to fix up
all these cases.

Diffstat:
 arch/um/drivers/ubd_kern.c         |    1 -
 drivers/block/loop.c               |    1 -
 drivers/block/nbd.c                |    3 ---
 drivers/block/null_blk/main.c      |    1 -
 drivers/block/rnbd/rnbd-srv-dev.h  |    2 +-
 drivers/block/virtio_blk.c         |    7 ++++---
 drivers/block/xen-blkback/xenbus.c |    4 ++--
 drivers/md/dm-zoned-target.c       |    2 +-
 drivers/md/raid5.c                 |    1 -
 drivers/nvme/host/core.c           |    1 -
 drivers/s390/block/dasd_fba.c      |    1 -
 11 files changed, 8 insertions(+), 16 deletions(-)
