Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B927BC433F5
	for <linux-s390@archiver.kernel.org>; Thu, 30 Sep 2021 09:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97AEC61880
	for <linux-s390@archiver.kernel.org>; Thu, 30 Sep 2021 09:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349401AbhI3Ja1 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 30 Sep 2021 05:30:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51321 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349404AbhI3JaZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Sep 2021 05:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632994123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=erwNcHC5pZk/HIPbuHvdtR1FQdHg+yCvajhjxRWVl2c=;
        b=XtBcd5b+tLPmRQl9XQ7s3hp/lWdOjqyyr4MB2zQJEc3c5SVE7npf0bO8ebLxwBMhrZJ+bn
        SGaYovoU3NQBccV9vkzleEfLGl/byMzq21bhIcZT+102dt0QxZdM02VtderOH59Nl3V5pC
        cB2QZMGQLZq3PSHwU20ap+I46CutQgY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-pE8b_A_zOw6Vv86nMLe66Q-1; Thu, 30 Sep 2021 05:28:39 -0400
X-MC-Unique: pE8b_A_zOw6Vv86nMLe66Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 142AD835DE2;
        Thu, 30 Sep 2021 09:28:38 +0000 (UTC)
Received: from localhost (unknown [10.39.192.253])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E5C61865D;
        Thu, 30 Sep 2021 09:28:24 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Halil Pasic <pasic@linux.ibm.com>, markver@us.ibm.com,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
In-Reply-To: <20210930012049.3780865-1-pasic@linux.ibm.com>
Organization: Red Hat GmbH
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Thu, 30 Sep 2021 11:28:23 +0200
Message-ID: <87r1d64dl4.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Sep 30 2021, Halil Pasic <pasic@linux.ibm.com> wrote:

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
>
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
>
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

This really looks like a mess :(

We end up calling ->finalize_features twice: once before ->validate, and
once after, that time with the complete song and dance. The first time,
we operate on one feature set; after validation, we operate on another,
and there might be interdependencies between the two (like a that a bit
is cleared because of another bit, which would not happen if validate
had a chance to clear that bit before).

I'm not sure whether that is even a problem in the spec: while the
driver may read the config before finally accepting features, it does
not really make sense to do so before a feature bit as basic as
VERSION_1 which determines the endianness has been negotiated. For
VERSION_1, we can probably go ahead and just assume that we will accept
it if offered, but what about other (future) bits?

> +
>  	if (drv->validate) {
>  		err = drv->validate(dev);
>  		if (err)

