Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E32C433EF
	for <linux-s390@archiver.kernel.org>; Thu,  7 Oct 2021 15:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74D4F61245
	for <linux-s390@archiver.kernel.org>; Thu,  7 Oct 2021 15:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241155AbhJGPeV (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 7 Oct 2021 11:34:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23049 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230060AbhJGPeU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 7 Oct 2021 11:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633620746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yNvi96S0n+2jvC4MnP0vGy5ty9dBkyyLjUTIOiS6II8=;
        b=FI2iEop/b7vTIczEFgK3aaQs1bUKGblbSbqW3arPb+w62IkoFYODctDVQUCOqt84O3FgES
        s83ruUI6t0zHIFL6VrZCPXa4HtcREQSELCythYADzdAqnnUeD1hB0caivEcqaHtlhEyhIj
        Huwm9F8NXQPhHiF6ONo8ftk59RcfBog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-9EoZIu35OqWAyFIIe8QSKQ-1; Thu, 07 Oct 2021 11:32:23 -0400
X-MC-Unique: 9EoZIu35OqWAyFIIe8QSKQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CCEFDF5B10;
        Thu,  7 Oct 2021 15:25:54 +0000 (UTC)
Received: from localhost (unknown [10.39.193.140])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AE3571E65D5;
        Thu,  7 Oct 2021 15:25:53 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        markver@us.ibm.com, qemu-devel@nongnu.org,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        stefanha@redhat.com, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 1/1] virtio: write back F_VERSION_1 before validate
In-Reply-To: <20211007163255.61d95513.pasic@linux.ibm.com>
Organization: Red Hat GmbH
References: <20211006142533.2735019-1-pasic@linux.ibm.com>
 <875yu9yruv.fsf@redhat.com> <20211007163255.61d95513.pasic@linux.ibm.com>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Thu, 07 Oct 2021 17:25:52 +0200
Message-ID: <8735pczwjj.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Oct 07 2021, Halil Pasic <pasic@linux.ibm.com> wrote:

> On Thu, 07 Oct 2021 13:52:24 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
>
>> On Wed, Oct 06 2021, Halil Pasic <pasic@linux.ibm.com> wrote:
>> 
>> > The virtio specification virtio-v1.1-cs01 states: Transitional devices
>> > MUST detect Legacy drivers by detecting that VIRTIO_F_VERSION_1 has not
>> > been acknowledged by the driver.  This is exactly what QEMU as of 6.1
>> > has done relying solely on VIRTIO_F_VERSION_1 for detecting that.
>> >
>> > However, the specification also says: driver MAY read (but MUST NOT
>> > write) the device-specific configuration fields to check that it can
>> > support the device before setting FEATURES_OK.  
>> 
>> Suggest to put the citations from the spec into quotes, so that they are
>> distinguishable from the rest of the text.
>
> For the record: I basically took Michael's description, the one which you
> said you prefer, with some minor changes.

Well I did look at what the text said, not the details in the formatting...

>
> This is one of the changes, which renders this a paraphrase and not a
> quote. Michael didn't use quotation marks so I was not sure it is was
> a word by word quote anyway. It was. But the spec depends on "During this
> step" which does not make any sense without the context. That is why I made
> the end of step explicit.

I still think that would be nicer while using some quotation marks, even
if you are just doing a partial quote.

In the first paragraph, however, we really should mark the quote
properly. It gave me a stop when I first read it.

>
> I think we are fine without quotation marks. Those who care can read the
> spec.
>
>> 
>> >
>> > In that case, any transitional device relying solely on
>> > VIRTIO_F_VERSION_1 for detecting legacy drivers will return data in
>> > legacy format.  In particular, this implies that it is in big endian
>> > format for big endian guests. This naturally confuses the driver which
>> > expects little endian in the modern mode.
>> >
>> > It is probably a good idea to amend the spec to clarify that
>> > VIRTIO_F_VERSION_1 can only be relied on after the feature negotiation
>> > is complete. However, we already have regression so let's try to address  
>> 
>> s/regression/a regression/
>> 
>
> Yes. Was like this in the original. Will change
>
>> > it.  
>> 
>> Maybe mention what the regression is?
>
> How about the following?
>
> The regressions affect the VIRTIO_NET_F_MTU feature of virtio-net and the
> VIRTIO_BLK_F_BLK_SIZE feature of virtio-blk for BE guests when virtio
> 1.0 is used on both sides. The latter renders virtio-blk unusable with
> DASD backing, because things simply don't work with the default.

Sounds good to me.

>
>> 
>> Also mention that we use this workaround for modern on BE only?
>
> We have that already, don't we. The sentence that starts with "In
> particular". The regression description should reinforce that
> sufficiently IMHO.

No strong opinion here. Anyone else?

>
>> 
>> >
>> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
>> > Fixes: 82e89ea077b9 ("virtio-blk: Add validation for block size in config space")
>> > Fixes: fe36cbe0671e ("virtio_net: clear MTU when out of range")
>> > Reported-by: markver@us.ibm.com
>> > ---
>> >  drivers/virtio/virtio.c | 10 ++++++++++
>> >  1 file changed, 10 insertions(+)
>> >
>> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>> > index 0a5b54034d4b..494cfecd3376 100644
>> > --- a/drivers/virtio/virtio.c
>> > +++ b/drivers/virtio/virtio.c
>> > @@ -239,6 +239,16 @@ static int virtio_dev_probe(struct device *_d)
>> >  		driver_features_legacy = driver_features;
>> >  	}
>> >  
>> > +	/*
>> > +	 * Some devices detect legacy solely via F_VERSION_1. Write
>> > +	 * F_VERSION_1 to force LE for these when needed.  
>> 
>> "...to force LE config space accesses before FEATURES_OK for these when
>> needed (BE)."
>> 
>> ?
>
> Can do, but I would rather omit the (BE) at the end. All the conditions
> are necessary:
> * have validate callback
> * device offered VERSION_1
> * virtio legacy is be
>

Ok, let's use that without the trailing BE.

>> 
>> > +	 */
>> > +	if (drv->validate && !virtio_legacy_is_little_endian()
>> > +			  && BIT_ULL(VIRTIO_F_VERSION_1) & device_features) {  
>> 
>> Nit: putting device_features first would read more naturally to me.
>> 
>
> Can do.
>
>> > +		dev->features = BIT_ULL(VIRTIO_F_VERSION_1);
>> > +		dev->config->finalize_features(dev);
>> > +	}
>> > +
>> >  	if (device_features & (1ULL << VIRTIO_F_VERSION_1))
>> >  		dev->features = driver_features & device_features;
>> >  	else  
>> 
>> Patch LGTM.
>> 
>> 
>
> Thanks for having a look. If you are fine with the proposed solution
> please tell me, so I can send out a v2.

No further comments other than what I wrote above, but maybe others have
comments as well?

