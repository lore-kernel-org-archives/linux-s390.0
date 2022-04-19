Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7700C433FE
	for <linux-s390@archiver.kernel.org>; Tue, 19 Apr 2022 04:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345242AbiDSE5B (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 19 Apr 2022 00:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348361AbiDSE4v (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 19 Apr 2022 00:56:51 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9FB33A2B
        for <linux-s390@vger.kernel.org>; Mon, 18 Apr 2022 21:51:49 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id w19so27320654lfu.11
        for <linux-s390@vger.kernel.org>; Mon, 18 Apr 2022 21:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BI9yKDogyA9J1nIp2A5DqA5VrUzX8xmulCW+rbuq8PY=;
        b=SJ+jl8otuJP8V2SgmRrkKx5N5mzchzJWNs3wHGu/KEMaBtHJMlOSyPwEwTYRCJOsK0
         +ub417XW+OB47SmEbjExHhWdvjVWNP6f4maHx7wpcQ/meMLPTDZio2MhC3cJJ+CFcG7A
         WyaAXMErjpaI/XL4ZkxN4ZoByVo51Plmy8MlzTn6CKA4kPvTL6QPTM/FElDnmxz/4bAo
         dNPevLcXfcZa94Hc/QRZN/ahpyGhXVxqtHvMswx1d+ioXM8CH8EB0Ocsp4CDYa7mfCxx
         3EMIYtoYuS9+fNRK0znetQsYbQBpHaSNFwuzb6Pw3NmrbbAzHjf8OVLAsic0niCU/6Hj
         1cWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BI9yKDogyA9J1nIp2A5DqA5VrUzX8xmulCW+rbuq8PY=;
        b=b1I1N3JVLc5zioh/ZzSMh+t/Lf2Q3qUlCCAox/9bs4ImY37bXuxeZXUKvcqHAuF9eF
         F6bUapHcr+UL+iOsOCoda2V258Fk+7+OxM7gwgOnAMXqmdCL2pPDckQao1jZO+CJyU+f
         Itb/5YnHBvtpM0/ScF0IcHWT0vjFuZchoB2q8Pyq6A3RwZy0cemTKzo2Ae7l+FMAF4/5
         duMXIQ5onM2qeWrDYeaJMpa62/SNqxnDKcyMV+vTi1n5fPtTX1ajR/wNz8BcgSl2i6kZ
         3KGF7EDX3zr+32HCouRsvZIns9HW0QdXNZZYytKY+lHvXI1Dv26yUt9FBATX7+L5EjIl
         oi9w==
X-Gm-Message-State: AOAM530Refx7Upg9byYBxMU4cP2asP8Ph9Ro3zpwp8nkjB9z757yP0+u
        S5VZCYHWWAgbrxuXFcMqFqhypWZMzI5dTh2/e4CpZA==
X-Google-Smtp-Source: ABdhPJyLR4ZusRr2xSa6FgTHa9kgMMN14+gTuhXJUl7advlAotvmYnqJxqDiVIivr0X1ZGDx839mhVaChBp2powMkIg=
X-Received: by 2002:a05:6512:10c5:b0:471:a703:bca4 with SMTP id
 k5-20020a05651210c500b00471a703bca4mr1289967lfg.581.1650343907228; Mon, 18
 Apr 2022 21:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220418045314.360785-1-hch@lst.de> <20220418045314.360785-11-hch@lst.de>
In-Reply-To: <20220418045314.360785-11-hch@lst.de>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 19 Apr 2022 06:51:12 +0200
Message-ID: <CAMGffEnxwHE_QgN2OS93BHe6U+XdYc_R5OmSROmF5F-HXK_E4A@mail.gmail.com>
Subject: Re: [PATCH 10/11] rnbd-srv: use bdev_discard_alignment
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
        Johannes Berg <johannes@sipsolutions.net>,
        Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
        Mike Snitzer <snitzer@kernel.org>, Song Liu <song@kernel.org>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-um@lists.infradead.org, linux-block@vger.kernel.org,
        nbd@other.debian.org, virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-raid@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
        dm-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Apr 18, 2022 at 6:53 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Use bdev_discard_alignment to calculate the correct discard alignment
> offset even for partitions instead of just looking at the queue limit.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Thx!
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/block/rnbd/rnbd-srv-dev.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/rnbd/rnbd-srv-dev.h b/drivers/block/rnbd/rnbd-srv-dev.h
> index d080a0de59225..4309e52524691 100644
> --- a/drivers/block/rnbd/rnbd-srv-dev.h
> +++ b/drivers/block/rnbd/rnbd-srv-dev.h
> @@ -59,7 +59,7 @@ static inline int rnbd_dev_get_discard_granularity(const struct rnbd_dev *dev)
>
>  static inline int rnbd_dev_get_discard_alignment(const struct rnbd_dev *dev)
>  {
> -       return bdev_get_queue(dev->bdev)->limits.discard_alignment;
> +       return bdev_discard_alignment(dev->bdev);
>  }
>
>  #endif /* RNBD_SRV_DEV_H */
> --
> 2.30.2
>
