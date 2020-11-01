Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgKAQqY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 1 Nov 2020 11:46:24 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFFBC0617A6
        for <linux-s390@vger.kernel.org>; Sun,  1 Nov 2020 08:46:24 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id e7so8922955pfn.12
        for <linux-s390@vger.kernel.org>; Sun, 01 Nov 2020 08:46:24 -0800 (PST)
Subject: Re: block ioctl cleanups
References: <20201031085810.450489-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <877901e6-6cdb-42e9-3b32-cb8b93bfff4e@kernel.dk>
Date: Sun, 1 Nov 2020 09:46:21 -0700
MIME-Version: 1.0
In-Reply-To: <20201031085810.450489-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Ilya Dryomov <idryomov@gmail.com>, Song Liu <song@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-block@vger.kernel.org, ceph-devel@vger.kernel.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org

On 10/31/20 2:57 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series has a bunch of cleanups for the block layer ioctl code.
> 
> Diffstat:
>  block/genhd.c                     |    7 ----
>  block/ioctl.c                     |   62 ++++++--------------------------------
>  drivers/block/loop.c              |    2 -
>  drivers/block/mtip32xx/mtip32xx.c |   11 +-----
>  drivers/block/pktcdvd.c           |    6 ++-
>  drivers/block/rbd.c               |   41 ++-----------------------
>  drivers/md/bcache/request.c       |    5 +--
>  drivers/md/dm.c                   |    5 ++-
>  drivers/md/md.c                   |   62 +++++++++++++++++++-------------------
>  drivers/mtd/mtd_blkdevs.c         |   28 -----------------
>  drivers/s390/block/dasd.c         |    1 
>  drivers/s390/block/dasd_int.h     |    3 +
>  drivers/s390/block/dasd_ioctl.c   |   27 +++++-----------
>  include/linux/blkdev.h            |    3 -
>  include/linux/genhd.h             |    1 
>  15 files changed, 73 insertions(+), 191 deletions(-)

Series looks good to me, apart from the mentioned mtip32xx change. If you
repost this, can you look through commit messages and titles for typos,
I spotted quite a few. If not I'll do it when applying.

-- 
Jens Axboe
