Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgJaJAm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 31 Oct 2020 05:00:42 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: block ioctl cleanups
Date: Sat, 31 Oct 2020 09:57:59 +0100
Message-Id: <20201031085810.450489-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ilya Dryomov <idryomov@gmail.com>, Song Liu <song@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-block@vger.kernel.org, ceph-devel@vger.kernel.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org

Hi Jens,

this series has a bunch of cleanups for the block layer ioctl code.

Diffstat:
 block/genhd.c                     |    7 ----
 block/ioctl.c                     |   62 ++++++--------------------------------
 drivers/block/loop.c              |    2 -
 drivers/block/mtip32xx/mtip32xx.c |   11 +-----
 drivers/block/pktcdvd.c           |    6 ++-
 drivers/block/rbd.c               |   41 ++-----------------------
 drivers/md/bcache/request.c       |    5 +--
 drivers/md/dm.c                   |    5 ++-
 drivers/md/md.c                   |   62 +++++++++++++++++++-------------------
 drivers/mtd/mtd_blkdevs.c         |   28 -----------------
 drivers/s390/block/dasd.c         |    1 
 drivers/s390/block/dasd_int.h     |    3 +
 drivers/s390/block/dasd_ioctl.c   |   27 +++++-----------
 include/linux/blkdev.h            |    3 -
 include/linux/genhd.h             |    1 
 15 files changed, 73 insertions(+), 191 deletions(-)
