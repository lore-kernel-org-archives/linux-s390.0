Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9056AC433EF
	for <linux-s390@archiver.kernel.org>; Mon, 25 Apr 2022 21:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245677AbiDYVLj (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 25 Apr 2022 17:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245685AbiDYVLh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 25 Apr 2022 17:11:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE276D943;
        Mon, 25 Apr 2022 14:08:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 286D96137F;
        Mon, 25 Apr 2022 21:08:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918D6C385BC;
        Mon, 25 Apr 2022 21:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650920910;
        bh=yN2FFsgqiwWmpQIWXC94b82E2wpYjQTq/CU/u3g3cjE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pdKHj+9jtFEKRxbFIKbp6BN5W0SKHdhPUGdQDXd7Xqx9vi4EpkMV1Y4FokX/IkPYa
         fcHGk/4On2XWYf3uADhfEsr+7LxnZ49Mj82N7KMHrZLd/dwLJ08US+RaehkUasA6/k
         ULzEmN8W11D5KZ+Cm4S93JoYXPgu2ne6zBKyDbG+PP7TNy6nKJUI/Prlkq4aTHvM+N
         eDTgN5VZZLATieGxC8vMqcHVTHdQIL63mmQQGdiCPeBj+cARAR4cnGnqJ35UI9ZFbn
         uSL8Ys/PCGOp1a6uCJDJdZhN6mhZ0J51T+/xZ6Bj+aFJUo7nkxoRQiwNXWKGnT6ByK
         ZiFdXEcFhWfZg==
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-2f7d7e3b5bfso49218707b3.5;
        Mon, 25 Apr 2022 14:08:30 -0700 (PDT)
X-Gm-Message-State: AOAM531k5AywOy2rlPyo61lLzMDJNpMwdIaNzA6gQfrAhnfZeXQrV3FJ
        wD5Xl7ifXOHzHfkIL5muoYW0N9nlGQYXiMiuqoQ=
X-Google-Smtp-Source: ABdhPJxgUnh58spmwdi5KGXzmrzAEx/WM60nf6Oi6YSWPgwfZEJsfaGjWIDBRUKlPyettQyT9R0PC00gVw9kzJ9ffYQ=
X-Received: by 2002:a0d:e343:0:b0:2f7:cefb:577b with SMTP id
 m64-20020a0de343000000b002f7cefb577bmr9909411ywe.472.1650920909604; Mon, 25
 Apr 2022 14:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220418045314.360785-1-hch@lst.de> <20220418045314.360785-7-hch@lst.de>
In-Reply-To: <20220418045314.360785-7-hch@lst.de>
From:   Song Liu <song@kernel.org>
Date:   Mon, 25 Apr 2022 14:08:18 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7fpiAqAf+U491dTH4mWORZQCxfyT6zWQwN=4r5WJ429Q@mail.gmail.com>
Message-ID: <CAPhsuW7fpiAqAf+U491dTH4mWORZQCxfyT6zWQwN=4r5WJ429Q@mail.gmail.com>
Subject: Re: [PATCH 06/11] raid5: don't set the discard_alignment queue limit
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
        Johannes Berg <johannes@sipsolutions.net>,
        Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-um@lists.infradead.org, linux-block@vger.kernel.org,
        nbd@other.debian.org, virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
        dm-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sun, Apr 17, 2022 at 9:53 PM Christoph Hellwig <hch@lst.de> wrote:
>
> The discard_alignment queue limit is named a bit misleading means the
> offset into the block device at which the discard granularity starts.
> Setting it to the discard granularity as done by raid5 is mostly
> harmless but also useless.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Song Liu <song@kernel.org>

> ---
>  drivers/md/raid5.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 59f91e392a2ae..39b0afdf40d0a 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -7749,7 +7749,6 @@ static int raid5_run(struct mddev *mddev)
>                  */
>                 stripe = stripe * PAGE_SIZE;
>                 stripe = roundup_pow_of_two(stripe);
> -               mddev->queue->limits.discard_alignment = stripe;
>                 mddev->queue->limits.discard_granularity = stripe;
>
>                 blk_queue_max_write_zeroes_sectors(mddev->queue, 0);
> --
> 2.30.2
>
