Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A68CC47083
	for <linux-s390@archiver.kernel.org>; Wed,  2 Jun 2021 07:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7C266138C
	for <linux-s390@archiver.kernel.org>; Wed,  2 Jun 2021 07:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhFBHvX (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 2 Jun 2021 03:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbhFBHvW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Jun 2021 03:51:22 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AA4C061756
        for <linux-s390@vger.kernel.org>; Wed,  2 Jun 2021 00:49:39 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id r11so1730470edt.13
        for <linux-s390@vger.kernel.org>; Wed, 02 Jun 2021 00:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IviQGHXbohDYlY4Kaxm/cxlbY44V3tAurEYksJ8dtbE=;
        b=jCNYXrovW1sUHaOT/+lw4PCDhP0eyRFf+ELw7YXWBCDBnLin+ptT9Qqbj9mRkWWaUg
         wGBYm/DlmYSjFuDFdCiAFeYUhwBx3bN1zWIfEq4U/R6NzUaRvMrhsPRnKTgM5MVFJVxB
         CmVxljvKTCN3ZyT1LwzUVWKZgE4x9cRuQaj0TjoJvUnlN68E3Mt+4zAfSoenpZB5Ofxb
         0XLwmhqFLm1lOHsISGA/CxlwAihZibid3kenEAmMklVKKOHOy1nSq3KrSTTjFuaKWHai
         u516kaTGPG4uhGM5WuZ/+lvOuzezIo89jko54Ak3T4r5ol1iQsDze8x0V5mTappbPtSr
         aaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IviQGHXbohDYlY4Kaxm/cxlbY44V3tAurEYksJ8dtbE=;
        b=J8F8nVm0ObBqEL2TAClcVVF1Rk82McogKnfQiVlk/GSDZVp/fYtAEmW12A+LvuFy1G
         WpdFIySQtOjBl+Fd+FfcxxUpGjKDbGBjV0XbpZ7QdRYXhzTmKCfiIU0BGhFGpg1ZuXM0
         8U2yx5cpegz18NeLRiP1uSptDOcVFqGHzlLrU0k5uE0/KqAqjoTAszNKLRvb/meyuOwG
         hoWt9qegdVl2KsuOvcXhfvaDJ1eb7fcYtOPL58S9pPjpqQ9OlsZ5O0YYvtpI8b37iMId
         GsNP79KAOvpFbR5fVA2aYatmen+Fo/GI2PPBwDwSZXJgv3soYbi8OT+dx67Xyhpd5SMl
         pqGA==
X-Gm-Message-State: AOAM530BYQqNe53gmigJ29rpTop5pTOFtLYYMDTlwS3SAYnS06dyND/r
        JkIlZMOWxQmZns3ynqwyHm7EYoI1QGABzdNeV5FhmQ==
X-Google-Smtp-Source: ABdhPJzRCVGimPnGT3qQlEAMsZsY3IxcZZF186UcWgTyI7ay8iWe4IlRIEG5WowCojeDoPju71hCmgBQ+xR7PgbbWL0=
X-Received: by 2002:aa7:c693:: with SMTP id n19mr33130385edq.35.1622620178044;
 Wed, 02 Jun 2021 00:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210602065345.355274-1-hch@lst.de> <20210602065345.355274-24-hch@lst.de>
In-Reply-To: <20210602065345.355274-24-hch@lst.de>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 2 Jun 2021 09:49:27 +0200
Message-ID: <CAMGffEn7aCmTOTsuzbSr=DwomFKfizkNhzsZnAONHBq1neW2Og@mail.gmail.com>
Subject: Re: [PATCH 23/30] rnbd: use blk_mq_alloc_disk and blk_cleanup_disk
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Justin Sanders <justin@coraid.com>,
        Denis Efremov <efremov@linux.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Tim Waugh <tim@cyberelk.net>,
        Geoff Levand <geoff@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-block <linux-block@vger.kernel.org>, nbd@other.debian.org,
        linuxppc-dev@lists.ozlabs.org,
        Ceph Development <ceph-devel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jun 2, 2021 at 8:55 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Use blk_mq_alloc_disk and blk_cleanup_disk to simplify the gendisk and
> request_queue allocation.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/rnbd/rnbd-clt.c | 35 ++++++++---------------------------
>  1 file changed, 8 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
> index c604a402cd5c..f4fa45d24c0b 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -1353,18 +1353,6 @@ static void rnbd_init_mq_hw_queues(struct rnbd_clt_dev *dev)
>         }
>  }
>
> -static int setup_mq_dev(struct rnbd_clt_dev *dev)
> -{
> -       dev->queue = blk_mq_init_queue(&dev->sess->tag_set);
> -       if (IS_ERR(dev->queue)) {
> -               rnbd_clt_err(dev, "Initializing multiqueue queue failed, err: %ld\n",
> -                             PTR_ERR(dev->queue));
> -               return PTR_ERR(dev->queue);
> -       }
> -       rnbd_init_mq_hw_queues(dev);
> -       return 0;
> -}
> -
>  static void setup_request_queue(struct rnbd_clt_dev *dev)
>  {
>         blk_queue_logical_block_size(dev->queue, dev->logical_block_size);
> @@ -1393,13 +1381,13 @@ static void setup_request_queue(struct rnbd_clt_dev *dev)
>         blk_queue_io_opt(dev->queue, dev->sess->max_io_size);
>         blk_queue_virt_boundary(dev->queue, SZ_4K - 1);
>         blk_queue_write_cache(dev->queue, dev->wc, dev->fua);
> -       dev->queue->queuedata = dev;
>  }
>
>  static void rnbd_clt_setup_gen_disk(struct rnbd_clt_dev *dev, int idx)
>  {
>         dev->gd->major          = rnbd_client_major;
>         dev->gd->first_minor    = idx << RNBD_PART_BITS;
> +       dev->gd->minors         = 1 << RNBD_PART_BITS;
>         dev->gd->fops           = &rnbd_client_ops;
>         dev->gd->queue          = dev->queue;
>         dev->gd->private_data   = dev;
> @@ -1426,24 +1414,18 @@ static void rnbd_clt_setup_gen_disk(struct rnbd_clt_dev *dev, int idx)
>
>  static int rnbd_client_setup_device(struct rnbd_clt_dev *dev)
>  {
> -       int err, idx = dev->clt_device_id;
> +       int idx = dev->clt_device_id;
>
>         dev->size = dev->nsectors * dev->logical_block_size;
>
> -       err = setup_mq_dev(dev);
> -       if (err)
> -               return err;
> +       dev->gd = blk_mq_alloc_disk(&dev->sess->tag_set, dev);
> +       if (IS_ERR(dev->gd))
> +               return PTR_ERR(dev->gd);
> +       dev->queue = dev->gd->queue;
> +       rnbd_init_mq_hw_queues(dev);
>
>         setup_request_queue(dev);
> -
> -       dev->gd = alloc_disk_node(1 << RNBD_PART_BITS,  NUMA_NO_NODE);
> -       if (!dev->gd) {
> -               blk_cleanup_queue(dev->queue);
> -               return -ENOMEM;
> -       }
> -
>         rnbd_clt_setup_gen_disk(dev, idx);
> -
>         return 0;
>  }
>
> @@ -1650,8 +1632,7 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
>  static void destroy_gen_disk(struct rnbd_clt_dev *dev)
>  {
>         del_gendisk(dev->gd);
> -       blk_cleanup_queue(dev->queue);
> -       put_disk(dev->gd);
> +       blk_cleanup_disk(dev->gd);
>  }
>
>  static void destroy_sysfs(struct rnbd_clt_dev *dev,
> --
> 2.30.2

Looks good to me, thx!
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
>
