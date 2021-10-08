Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B080EC433EF
	for <linux-s390@archiver.kernel.org>; Fri,  8 Oct 2021 13:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9625661037
	for <linux-s390@archiver.kernel.org>; Fri,  8 Oct 2021 13:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242285AbhJHNHY (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 8 Oct 2021 09:07:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43850 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242399AbhJHNHV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 8 Oct 2021 09:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633698324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uVQFfb3vAI1ijnE0WV4b+1ZIo0UnTqYUbSmbQDcQl2M=;
        b=FUYCXp8hVa7g2rVhBToq6abVu04FuZ44PlRkGb7rL5k79rMhM6+PMTVas3l/k7YmZuEIxm
        EgEH7Ettnr25pl8xRH8J3S2KHp5Sdk9UmgI0kt8YWTsWcPK7T2nD2YkqyDr/fx/za+rbhD
        GrsEZ81pK1PVjZZ+zpsKIUB7jAlhBTs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-Rd8bqZCtOMCj5mo2klntoQ-1; Fri, 08 Oct 2021 09:05:09 -0400
X-MC-Unique: Rd8bqZCtOMCj5mo2klntoQ-1
Received: by mail-ed1-f69.google.com with SMTP id d11-20020a50cd4b000000b003da63711a8aso9083932edj.20
        for <linux-s390@vger.kernel.org>; Fri, 08 Oct 2021 06:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uVQFfb3vAI1ijnE0WV4b+1ZIo0UnTqYUbSmbQDcQl2M=;
        b=st5vkWOlKYCkcQfS/yXgNjwoch8fjR4xwaFhUHL3wNbUgeDJTTihBRrfJQcppajt65
         Ln7Z9wDI5UG/vjgCB93j5ciABFYh7QEWzCMNTCfKtyb+uXkhQTEb+3dHbpsJhWR3PZcd
         VAMYJfmebAcbkK6snFoN3GW5rPBVQurPwPdKKwajSlUC8de2k/xQgSL38/JyNZ4yR8Si
         OYWklcX6LqakfWuT9K0HR6a6HCPZFA9vKGARS83Rd2HLh3QS8tSbZ1sUBqo26rDgBpTY
         lOe3gduTORg95VgVkpHGY15aLSNhtAQKiqFP07i7F3u5pZLRo5Jz03FU+UP2wDzeWc81
         Hu+g==
X-Gm-Message-State: AOAM533ZHeQIV2v9xSK2zHzXyk79SkYAKehtWdFQHSmxZUeaHC3RK6Th
        zzc0hepygmxUSqRDfrvoNB4t5zvo0yMTJrMfZY16B/FU4mgeCQNID0UyZn5ixMk7qn3uSN1wOG4
        +yINdT2a64cQB0aprusdBIg==
X-Received: by 2002:a17:906:368c:: with SMTP id a12mr4208927ejc.143.1633698308454;
        Fri, 08 Oct 2021 06:05:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlxA2f9rNxTHQq8IKY2BJh4lL9hMx84StuoKNUlOgnyNlZwYvMbH6zVdMCXYXCN5WHfEx88w==
X-Received: by 2002:a17:906:368c:: with SMTP id a12mr4208897ejc.143.1633698308147;
        Fri, 08 Oct 2021 06:05:08 -0700 (PDT)
Received: from redhat.com ([2.55.132.170])
        by smtp.gmail.com with ESMTPSA id c10sm898413eje.37.2021.10.08.06.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 06:05:07 -0700 (PDT)
Date:   Fri, 8 Oct 2021 09:05:03 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        markver@us.ibm.com, Cornelia Huck <cohuck@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, stefanha@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/1] virtio: write back F_VERSION_1 before validate
Message-ID: <20211008085839-mutt-send-email-mst@kernel.org>
References: <20211008123422.1415577-1-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008123422.1415577-1-pasic@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Oct 08, 2021 at 02:34:22PM +0200, Halil Pasic wrote:
> The virtio specification virtio-v1.1-cs01 states: "Transitional devices
> MUST detect Legacy drivers by detecting that VIRTIO_F_VERSION_1 has not
> been acknowledged by the driver."  This is exactly what QEMU as of 6.1
> has done relying solely on VIRTIO_F_VERSION_1 for detecting that.
> 
> However, the specification also says: "... the driver MAY read (but MUST
> NOT write) the device-specific configuration fields to check that it can
> support the device ..." before setting FEATURES_OK.
> 
> In that case, any transitional device relying solely on
> VIRTIO_F_VERSION_1 for detecting legacy drivers will return data in
> legacy format.  In particular, this implies that it is in big endian
> format for big endian guests. This naturally confuses the driver which
> expects little endian in the modern mode.
> 
> It is probably a good idea to amend the spec to clarify that
> VIRTIO_F_VERSION_1 can only be relied on after the feature negotiation
> is complete. However, we already have a regression so let's try to address

actually, regressions. and we can add 
"since originally before validate callback existed
config space was only read after
FEATURES_OK. See Fixes tags for relevant commits"

> it.
> 
> The regressions affect the VIRTIO_NET_F_MTU feature of virtio-net and
> the VIRTIO_BLK_F_BLK_SIZE feature of virtio-blk for BE guests when
> virtio 1.0 is used on both sides. The latter renders virtio-blk unusable
> with DASD backing, because things simply don't work with the default.

Let's add a work around description now:


For QEMU, we can work around the issue by writing out the features
register with VIRTIO_F_VERSION_1 bit set.  We (ab) use the
finalize_features config op for this. It's not enough to address vhost
user and vhost block devices since these do not get the features until
FEATURES_OK, however it looks like these two actually never handled the
endian-ness for legacy mode correctly, so at least that's not a
regression.

No devices except virtio net and virtio blk seem to be affected.

Long term the right thing to do is to fix the hypervisors.


> 
> Cc: <stable@vger.kernel.org> #v4.11
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Fixes: 82e89ea077b9 ("virtio-blk: Add validation for block size in config space")
> Fixes: fe36cbe0671e ("virtio_net: clear MTU when out of range")
> Reported-by: markver@us.ibm.com
> ---
>  drivers/virtio/virtio.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 0a5b54034d4b..236081afe9a2 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -239,6 +239,17 @@ static int virtio_dev_probe(struct device *_d)
>  		driver_features_legacy = driver_features;
>  	}
>  
> +	/*
> +	 * Some devices detect legacy solely via F_VERSION_1. Write
> +	 * F_VERSION_1 to force LE config space accesses before FEATURES_OK for
> +	 * these when needed.
> +	 */
> +	if (drv->validate && !virtio_legacy_is_little_endian()
> +			  && device_features & BIT_ULL(VIRTIO_F_VERSION_1)) {
> +		dev->features = BIT_ULL(VIRTIO_F_VERSION_1);
> +		dev->config->finalize_features(dev);
> +	}
> +
>  	if (device_features & (1ULL << VIRTIO_F_VERSION_1))
>  		dev->features = driver_features & device_features;
>  	else
> 
> base-commit: 60a9483534ed0d99090a2ee1d4bb0b8179195f51
> -- 
> 2.25.1

