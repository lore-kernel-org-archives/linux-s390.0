Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E60C433FE
	for <linux-s390@archiver.kernel.org>; Wed, 13 Oct 2021 10:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28E0461077
	for <linux-s390@archiver.kernel.org>; Wed, 13 Oct 2021 10:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhJMKMX (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 13 Oct 2021 06:12:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42306 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239243AbhJMKMW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Oct 2021 06:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634119819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XIV6EWlf8IYh7mOxA5NB+uuQJyLxn6kGVxkuMI5GYog=;
        b=iQLa+6uAvnLGlZINaELwQ7zd8mTWkUfT2NNCvV+vVhHqni8a2Ma5xs2hACUhHEFcGON3uL
        DTq7/19T8avrd7GLYn7j6bpeTNjIre1uUqymzLUuTSIWwqKY4R3fbypw1OVPquN35BkCWH
        H1afNCstB4OJBdLwiN0pd5Lr0yCELBg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-k7DXdC5POJqM3DvlERQJXA-1; Wed, 13 Oct 2021 06:10:15 -0400
X-MC-Unique: k7DXdC5POJqM3DvlERQJXA-1
Received: by mail-wr1-f71.google.com with SMTP id l6-20020adfa386000000b00160c4c1866eso1582776wrb.4
        for <linux-s390@vger.kernel.org>; Wed, 13 Oct 2021 03:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XIV6EWlf8IYh7mOxA5NB+uuQJyLxn6kGVxkuMI5GYog=;
        b=k4dXS8Msbjr5YBy6XTbW5KK+HulPKm2XyKa8wLN12yk4sWKO9RkTSIAcXDeZfXpRyo
         qXaRT9p+HoNNqUl6BbaJLkBxwjVsaVDGSmZdzTpxcKHUEssNIKGbvAX1B4g0Tpf/QLUR
         kwLpJ62rb557BL3QySw+xbL4n/ktmnWiL0A3oGBVOL7KEKSy1rguId0oxHZHWEXS4+I1
         En5MilknGOfwnaun/dDSY6Fmj1i5BEJDIf76yN5Nu4BJx34WGxPBMGxu6RKPfVPQE/9p
         yJsqTvSekN7qzJ0+c7OCByh+a/z3CJLjovnFUKtbtTHOQO8P98aX9vnIflcyj1fQp5Nm
         2QKw==
X-Gm-Message-State: AOAM530MqkjOYAiUgXKHjl0H26Bv/FEQznZAiSjBSSYBUkxFskfPxPiI
        hgL7mT+kbtju7FNJs9VDqf6Z2g70IKZ8cpNDrb+kAPLoT+uzgRCuqyZGrfYtieM9rvx/8w2hVc7
        gp3Ouf9+8Ax1uayMQ01n7iQ==
X-Received: by 2002:a5d:6c65:: with SMTP id r5mr38598492wrz.26.1634119814023;
        Wed, 13 Oct 2021 03:10:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdzEUsRMSd5Z6w3cXq4dmtWNY5MNbht2wMdWdZK2XnSLKoIDFYiOilvxVG3omeTmm8H874VQ==
X-Received: by 2002:a5d:6c65:: with SMTP id r5mr38598465wrz.26.1634119813789;
        Wed, 13 Oct 2021 03:10:13 -0700 (PDT)
Received: from redhat.com ([2.55.30.112])
        by smtp.gmail.com with ESMTPSA id p25sm4782688wma.2.2021.10.13.03.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 03:10:13 -0700 (PDT)
Date:   Wed, 13 Oct 2021 06:10:09 -0400
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
Subject: Re: [PATCH v3 1/1] virtio: write back F_VERSION_1 before validate
Message-ID: <20211013060923-mutt-send-email-mst@kernel.org>
References: <20211011053921.1198936-1-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011053921.1198936-1-pasic@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Oct 11, 2021 at 07:39:21AM +0200, Halil Pasic wrote:
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
> is complete. Before validate callback existed, config space was only
> read after FEATURES_OK. However, we already have two regressions, so
> let's address this here as well.
> 
> The regressions affect the VIRTIO_NET_F_MTU feature of virtio-net and
> the VIRTIO_BLK_F_BLK_SIZE feature of virtio-blk for BE guests when
> virtio 1.0 is used on both sides. The latter renders virtio-blk unusable
> with DASD backing, because things simply don't work with the default.
> See Fixes tags for relevant commits.
> 
> For QEMU, we can work around the issue by writing out the feature bits
> with VIRTIO_F_VERSION_1 bit set.  We (ab)use the finalize_features
> config op for this. This isn't enough to address all vhost devices since
> these do not get the features until FEATURES_OK, however it looks like
> the affected devices actually never handled the endianness for legacy
> mode correctly, so at least that's not a regression.
> 
> No devices except virtio net and virtio blk seem to be affected.
> 
> Long term the right thing to do is to fix the hypervisors.
> 
> Cc: <stable@vger.kernel.org> #v4.11
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Fixes: 82e89ea077b9 ("virtio-blk: Add validation for block size in config space")
> Fixes: fe36cbe0671e ("virtio_net: clear MTU when out of range")
> Reported-by: markver@us.ibm.com
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

OK this looks good! How about a QEMU patch to make it spec compliant on
BE?

> ---
> 
> @Connie: I made some more commit message changes to accommodate Michael's
> requests. I just assumed these will work or you as well and kept your
> r-b. Please shout at me if it needs to be dropped :)
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

