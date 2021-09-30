Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BD1C433EF
	for <linux-s390@archiver.kernel.org>; Thu, 30 Sep 2021 11:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC23F615E0
	for <linux-s390@archiver.kernel.org>; Thu, 30 Sep 2021 11:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350503AbhI3Lc6 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 30 Sep 2021 07:32:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26272 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350447AbhI3Lc5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Sep 2021 07:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633001474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IBPiwjv88gBtXhEZKobvenYgzbrXuu/F7fjJxKqNYJ0=;
        b=PGh+F6XBrwGUq0og8q4V5cqACFnSysCoI8dahWkKGYisaJMrywGmcGhPlTDmzf32LxGof+
        obNF/kZl/Zz9VYCNTea0qz6LJ0FxdrMEmWw2Earbf12Ea+J6lP1FIdDhQphY0LkblTrNAd
        f3JAvoFGFDd0FmLzAWjwJo1Ht2AA1Ow=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-ipkYATPkPvGje-CQoPUkIQ-1; Thu, 30 Sep 2021 07:31:11 -0400
X-MC-Unique: ipkYATPkPvGje-CQoPUkIQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 004EE1084684;
        Thu, 30 Sep 2021 11:31:10 +0000 (UTC)
Received: from localhost (unknown [10.39.192.253])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A4C760C82;
        Thu, 30 Sep 2021 11:31:06 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, markver@us.ibm.com,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
In-Reply-To: <20210930130350.0cdc7c65.pasic@linux.ibm.com>
Organization: Red Hat GmbH
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <87r1d64dl4.fsf@redhat.com> <20210930130350.0cdc7c65.pasic@linux.ibm.com>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Thu, 30 Sep 2021 13:31:04 +0200
Message-ID: <87ilyi47wn.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Sep 30 2021, Halil Pasic <pasic@linux.ibm.com> wrote:

> On Thu, 30 Sep 2021 11:28:23 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
>
>> On Thu, Sep 30 2021, Halil Pasic <pasic@linux.ibm.com> wrote:
>> 
>> > This patch fixes a regression introduced by commit 82e89ea077b9
>> > ("virtio-blk: Add validation for block size in config space") and
>> > enables similar checks in verify() on big endian platforms.
>> >
>> > The problem with checking multi-byte config fields in the verify
>> > callback, on big endian platforms, and with a possibly transitional
>> > device is the following. The verify() callback is called between
>> > config->get_features() and virtio_finalize_features(). That we have a
>> > device that offered F_VERSION_1 then we have the following options
>> > either the device is transitional, and then it has to present the legacy
>> > interface, i.e. a big endian config space until F_VERSION_1 is
>> > negotiated, or we have a non-transitional device, which makes
>> > F_VERSION_1 mandatory, and only implements the non-legacy interface and
>> > thus presents a little endian config space. Because at this point we
>> > can't know if the device is transitional or non-transitional, we can't
>> > know do we need to byte swap or not.
>> >
>> > The virtio spec explicitly states that the driver MAY read config
>> > between reading and writing the features so saying that first accessing
>> > the config before feature negotiation is done is not an option. The
>> > specification ain't clear about setting the features multiple times
>> > before FEATURES_OK, so I guess that should be fine.
>> >
>> > I don't consider this patch super clean, but frankly I don't think we
>> > have a ton of options. Another option that may or man not be cleaner,
>> > but is also IMHO much uglier is to figure out whether the device is
>> > transitional by rejecting _F_VERSION_1, then resetting it and proceeding
>> > according tho what we have figured out, hoping that the characteristics
>> > of the device didn't change.
>> >
>> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
>> > Fixes: 82e89ea077b9 ("virtio-blk: Add validation for block size in config space")
>> > Reported-by: markver@us.ibm.com
>> > ---
>> >  drivers/virtio/virtio.c | 4 ++++
>> >  1 file changed, 4 insertions(+)
>> >
>> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>> > index 0a5b54034d4b..9dc3cfa17b1c 100644
>> > --- a/drivers/virtio/virtio.c
>> > +++ b/drivers/virtio/virtio.c
>> > @@ -249,6 +249,10 @@ static int virtio_dev_probe(struct device *_d)
>> >  		if (device_features & (1ULL << i))
>> >  			__virtio_set_bit(dev, i);
>> >  
>> > +	/* Write back features before validate to know endianness */
>> > +	if (device_features & (1ULL << VIRTIO_F_VERSION_1))
>> > +		dev->config->finalize_features(dev);  
>> 
>> This really looks like a mess :(
>> 
>> We end up calling ->finalize_features twice: once before ->validate, and
>> once after, that time with the complete song and dance. The first time,
>> we operate on one feature set; after validation, we operate on another,
>> and there might be interdependencies between the two (like a that a bit
>> is cleared because of another bit, which would not happen if validate
>> had a chance to clear that bit before).
>
> Basically the second set is a subset of the first set.

I don't think that's clear.

>
>> 
>> I'm not sure whether that is even a problem in the spec: while the
>> driver may read the config before finally accepting features
>
> I'm not sure I'm following you. Let me please qoute the specification:
> """
> 4. Read device feature bits, and write the subset of feature bits
> understood by the OS and driver to the device. During this step the driver MAY read (but MUST NOT write) the device-specific configuration fields to check that it can support the device before accepting it. 
> 5. Set the FEATURES_OK status bit. The driver MUST NOT accept new feature bits after this step. 
> """
> https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.html#x1-930001

Yes, exactly, it MAY read before accepting features. How does the device
know whether the config space is little-endian or not?

>
>> , it does
>> not really make sense to do so before a feature bit as basic as
>> VERSION_1 which determines the endianness has been negotiated. 
>
> Are you suggesting that ->verify() should be after
> virtio_finalize_features()?

No, that would defeat the entire purpose of verify. After
virtio_finalize_features(), we are done with feature negotiation.

> Wouldn't
> that mean that verify() can't reject feature bits? But that is the whole
> point of commit 82e89ea077b9 ("virtio-blk: Add validation for block size
> in config space"). Do you think that the commit in question is
> conceptually flawed? My understanding of the verify is, that it is supposed
> to fence features and feature bits we can't support, e.g. because of
> config space things, but I may be wrong.

No, that commit is not really flawed on its own, I think the whole
procedure may be problematic.

>
> The trouble is, feature bits are not negotiated one by one, but basically all
> at once. I suppose, I did the next best thing to first negotiating
> VERSION_1.

We probably need to special-case VERSION_1 to move at least forward;
i.e. proceed as if we accepted it when reading the config space.

The problem is that we do not know what the device assumes when we read
the config space prior to setting FEATURES_OK. It may assume
little-endian if it offered VERSION_1, or it may not. The spec does not
really say what happens before feature negotiation has finished.

>
>
>> For
>> VERSION_1, we can probably go ahead and just assume that we will accept
>> it if offered, but what about other (future) bits?
>
> I don't quite understand.

There might be other bits in the future that change how the config space
works. We cannot assume that any of those bits will be accepted if
offered; i.e. we need a special hack for VERSION_1.

>
> Anyway, how do you think we should solve this problem?

This is a mess. For starters, we need to think about if we should do
something in the spec, and if yes, what.. Then, we can probably think
about how to implement that properly.

As we have an error right now that is basically a regression, we
probably need a band-aid to keep going. Not sure if your patch is the
right approach, maybe we really need to special-case VERSION_1 (the
"assume we accepted it" hack mentioned above.) This will likely fix the
reported problem (I assume that is s390x on QEMU); do we know about
other VMMs? Any other big-endian architectures?

Anyone have any better suggestions?

