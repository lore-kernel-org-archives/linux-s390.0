Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0ACC433EF
	for <linux-s390@archiver.kernel.org>; Thu, 30 Sep 2021 11:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB31B613A9
	for <linux-s390@archiver.kernel.org>; Thu, 30 Sep 2021 11:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350330AbhI3LOL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 30 Sep 2021 07:14:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49876 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350299AbhI3LOL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Sep 2021 07:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633000348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mamYV94DvaSHcTpxY1jybCBi3DFQDGd0SIaH6v4W57c=;
        b=ePej418kHlo0VYsUXlCcCmVc+XsfGrewGGdYukXQBUEJyOr2xEN00DG3nSeTqyq6j7++yF
        w4QEI5szjf9yX/02FIXQOVQH8hlwxcekrXqI7G3ed6ffqCF50K0raINjrj6RXXxq1bWJWU
        Lb6F+mlFoFXWlRuo7RS4e+jF75qvlpE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-RE49zKSKP-CWtyWsHRQb-w-1; Thu, 30 Sep 2021 07:12:27 -0400
X-MC-Unique: RE49zKSKP-CWtyWsHRQb-w-1
Received: by mail-ed1-f72.google.com with SMTP id j26-20020a508a9a000000b003da84aaa5c5so5874524edj.11
        for <linux-s390@vger.kernel.org>; Thu, 30 Sep 2021 04:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mamYV94DvaSHcTpxY1jybCBi3DFQDGd0SIaH6v4W57c=;
        b=I1gmSqBYAUn3nCGC9BlY0ZYirdC5AgRPYzTziajAujatBpk0Vsy8P5sH9SahJ1Uo5r
         NIpbIiy/dne5vx/ET2OxMNy+meqICLt/6qN8v8/t4Mak2nTgPZjTt1QgJnjpVTk7tzTc
         eTTnpUMI4HvHGRUtPOHgpclxQ9U96eScISqGYtwsTFgojmTSSohLeg20MOM/XnT7oB/D
         ybEvnZ+Oy5Qsr9z4NjFuruNIuMsEBZCIRCK79IJqgjQMQ2aqTqIkoRFqDlhR+EiCZL4f
         EfG8wEhllRzJWGOS7vMsXAvC8cjOSljd7/I/eIaYmcyK+BdNP/py4yD9V5Qmv4zSW4VL
         HqRA==
X-Gm-Message-State: AOAM531yB1iut2vFLwvYqM0wlWBvjog/KMzY/uRx+NojgD4CA0mdYO55
        qDNCypHk3R+2kn+1NAcH/vkZYYSTcVeVZf4j8fWYC5hwgqvEZuvkBtAnuBOhHhu4g0JGG72m41n
        4ExgLsXWdAMiSdZY0SQygFQ==
X-Received: by 2002:a05:6402:b12:: with SMTP id bm18mr6097152edb.199.1633000345845;
        Thu, 30 Sep 2021 04:12:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtq8ej/t/V3JAgc3SlMjXpl9ktAa0aZIENmSOuBoeE8pGgLamCebSOneonGrTqyR1oxhTg6w==
X-Received: by 2002:a05:6402:b12:: with SMTP id bm18mr6097132edb.199.1633000345651;
        Thu, 30 Sep 2021 04:12:25 -0700 (PDT)
Received: from redhat.com ([2.55.134.220])
        by smtp.gmail.com with ESMTPSA id s17sm1300678edd.47.2021.09.30.04.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 04:12:24 -0700 (PDT)
Date:   Thu, 30 Sep 2021 07:12:21 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, markver@us.ibm.com,
        Cornelia Huck <cohuck@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20210930070444-mutt-send-email-mst@kernel.org>
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930012049.3780865-1-pasic@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Sep 30, 2021 at 03:20:49AM +0200, Halil Pasic wrote:
> This patch fixes a regression introduced by commit 82e89ea077b9
> ("virtio-blk: Add validation for block size in config space") and
> enables similar checks in verify() on big endian platforms.
> 
> The problem with checking multi-byte config fields in the verify
> callback, on big endian platforms, and with a possibly transitional
> device is the following. The verify() callback is called between
> config->get_features() and virtio_finalize_features(). That we have a
> device that offered F_VERSION_1 then we have the following options
> either the device is transitional, and then it has to present the legacy
> interface, i.e. a big endian config space until F_VERSION_1 is
> negotiated, or we have a non-transitional device, which makes
> F_VERSION_1 mandatory, and only implements the non-legacy interface and
> thus presents a little endian config space. Because at this point we
> can't know if the device is transitional or non-transitional, we can't
> know do we need to byte swap or not.

Hmm which transport does this refer to?
Distinguishing between legacy and modern drivers is transport
specific.  PCI presents
legacy and modern at separate addresses so distinguishing
between these two should be no trouble.
Channel i/o has versioning so same thing?

> The virtio spec explicitly states that the driver MAY read config
> between reading and writing the features so saying that first accessing
> the config before feature negotiation is done is not an option. The
> specification ain't clear about setting the features multiple times
> before FEATURES_OK, so I guess that should be fine.
> 
> I don't consider this patch super clean, but frankly I don't think we
> have a ton of options. Another option that may or man not be cleaner,
> but is also IMHO much uglier is to figure out whether the device is
> transitional by rejecting _F_VERSION_1, then resetting it and proceeding
> according tho what we have figured out, hoping that the characteristics
> of the device didn't change.

I am confused here. So is the problem at the device or at the driver level?
I suspect it's actually the host that has the issue, not
the guest?


> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Fixes: 82e89ea077b9 ("virtio-blk: Add validation for block size in config space")
> Reported-by: markver@us.ibm.com
> ---
>  drivers/virtio/virtio.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 0a5b54034d4b..9dc3cfa17b1c 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -249,6 +249,10 @@ static int virtio_dev_probe(struct device *_d)
>  		if (device_features & (1ULL << i))
>  			__virtio_set_bit(dev, i);
>  
> +	/* Write back features before validate to know endianness */
> +	if (device_features & (1ULL << VIRTIO_F_VERSION_1))
> +		dev->config->finalize_features(dev);
> +
>  	if (drv->validate) {
>  		err = drv->validate(dev);
>  		if (err)
> 
> base-commit: 02d5e016800d082058b3d3b7c3ede136cdc6ddcb
> -- 
> 2.25.1

