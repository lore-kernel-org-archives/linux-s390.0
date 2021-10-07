Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3706C433F5
	for <linux-s390@archiver.kernel.org>; Thu,  7 Oct 2021 11:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD6C561130
	for <linux-s390@archiver.kernel.org>; Thu,  7 Oct 2021 11:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhJGLzN (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 7 Oct 2021 07:55:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59052 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241136AbhJGLzI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 7 Oct 2021 07:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633607594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AZvF8lHSRTx5C1gxLkoYVX71Yos23PQLi8wLibZ0710=;
        b=RRNO7UaWRln5krpU8DC7iMldqpMlM+58xdAVjMNZ0sx9YE6f+HKbYNIcM0XCkYPD1Cp0bK
        /svtFwpTgnu3XI99rJvwgD9wssytxPW7Glh6IRtuK+ggh69ezreEwoZ7KAzmwyMGKcdN8/
        gERj3+v88ez60x4M7ZRQ+EtOeE8MYsQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-f60KTsS4N0205Zinm8Nj0g-1; Thu, 07 Oct 2021 07:52:49 -0400
X-MC-Unique: f60KTsS4N0205Zinm8Nj0g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 985AB100CC84;
        Thu,  7 Oct 2021 11:52:47 +0000 (UTC)
Received: from localhost (unknown [10.39.193.140])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F47D4EC7D;
        Thu,  7 Oct 2021 11:52:26 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Halil Pasic <pasic@linux.ibm.com>, markver@us.ibm.com,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, stefanha@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        qemu-devel@nongnu.org
Subject: Re: [PATCH 1/1] virtio: write back F_VERSION_1 before validate
In-Reply-To: <20211006142533.2735019-1-pasic@linux.ibm.com>
Organization: Red Hat GmbH
References: <20211006142533.2735019-1-pasic@linux.ibm.com>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Thu, 07 Oct 2021 13:52:24 +0200
Message-ID: <875yu9yruv.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Oct 06 2021, Halil Pasic <pasic@linux.ibm.com> wrote:

> The virtio specification virtio-v1.1-cs01 states: Transitional devices
> MUST detect Legacy drivers by detecting that VIRTIO_F_VERSION_1 has not
> been acknowledged by the driver.  This is exactly what QEMU as of 6.1
> has done relying solely on VIRTIO_F_VERSION_1 for detecting that.
>
> However, the specification also says: driver MAY read (but MUST NOT
> write) the device-specific configuration fields to check that it can
> support the device before setting FEATURES_OK.

Suggest to put the citations from the spec into quotes, so that they are
distinguishable from the rest of the text.

>
> In that case, any transitional device relying solely on
> VIRTIO_F_VERSION_1 for detecting legacy drivers will return data in
> legacy format.  In particular, this implies that it is in big endian
> format for big endian guests. This naturally confuses the driver which
> expects little endian in the modern mode.
>
> It is probably a good idea to amend the spec to clarify that
> VIRTIO_F_VERSION_1 can only be relied on after the feature negotiation
> is complete. However, we already have regression so let's try to address

s/regression/a regression/

> it.

Maybe mention what the regression is?

Also mention that we use this workaround for modern on BE only?

>
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Fixes: 82e89ea077b9 ("virtio-blk: Add validation for block size in config space")
> Fixes: fe36cbe0671e ("virtio_net: clear MTU when out of range")
> Reported-by: markver@us.ibm.com
> ---
>  drivers/virtio/virtio.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 0a5b54034d4b..494cfecd3376 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -239,6 +239,16 @@ static int virtio_dev_probe(struct device *_d)
>  		driver_features_legacy = driver_features;
>  	}
>  
> +	/*
> +	 * Some devices detect legacy solely via F_VERSION_1. Write
> +	 * F_VERSION_1 to force LE for these when needed.

"...to force LE config space accesses before FEATURES_OK for these when
needed (BE)."

?

> +	 */
> +	if (drv->validate && !virtio_legacy_is_little_endian()
> +			  && BIT_ULL(VIRTIO_F_VERSION_1) & device_features) {

Nit: putting device_features first would read more naturally to me.

> +		dev->features = BIT_ULL(VIRTIO_F_VERSION_1);
> +		dev->config->finalize_features(dev);
> +	}
> +
>  	if (device_features & (1ULL << VIRTIO_F_VERSION_1))
>  		dev->features = driver_features & device_features;
>  	else

Patch LGTM.

