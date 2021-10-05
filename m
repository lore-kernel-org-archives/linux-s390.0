Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8C7C433F5
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 10:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0837D61054
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 10:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbhJEKJG (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 5 Oct 2021 06:09:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60255 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232723AbhJEKJG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Oct 2021 06:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633428435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OYae2yiwAMbmoddnDd/+N8S6CedyqQgF0pFGpEEhW0A=;
        b=KUOQrtzv2IZDr0uWBaHRwkCmCgtdaVRlk/xQul7LP/iQxTd8JV+3fLok9AtWZ2guSUB9Rj
        2veB79FVEmvT1zwu7E3Qp1TO6WhcU/j+2jtm3nEAA4XNORHpUEDYTsEgix9kFDpcBIhwvC
        BYIedDzq8shDkMaT9tarooqFTn56lwk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-5A82fE3ZNgWIVGUPDym7lQ-1; Tue, 05 Oct 2021 06:07:14 -0400
X-MC-Unique: 5A82fE3ZNgWIVGUPDym7lQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67F3491271;
        Tue,  5 Oct 2021 10:07:12 +0000 (UTC)
Received: from localhost (unknown [10.39.192.167])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EEA3219D9D;
        Tue,  5 Oct 2021 10:06:59 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, markver@us.ibm.com,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, stefanha@redhat.com,
        qemu-devel@nongnu.org,
        Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
In-Reply-To: <20211004040937-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <87r1d64dl4.fsf@redhat.com> <20210930130350.0cdc7c65.pasic@linux.ibm.com>
 <87ilyi47wn.fsf@redhat.com> <20211001162213.18d7375e.pasic@linux.ibm.com>
 <87v92g3h9l.fsf@redhat.com>
 <20211002082128-mutt-send-email-mst@kernel.org>
 <20211004042323.730c6a5e.pasic@linux.ibm.com>
 <20211004040937-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Tue, 05 Oct 2021 12:06:57 +0200
Message-ID: <87o88323b2.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Oct 04, 2021 at 04:23:23AM +0200, Halil Pasic wrote:
>> --------------------------8<---------------------
>> 
>> From: Halil Pasic <pasic@linux.ibm.com>
>> Date: Thu, 30 Sep 2021 02:38:47 +0200
>> Subject: [PATCH] virtio: write back feature VERSION_1 before verify
>> 
>> This patch fixes a regression introduced by commit 82e89ea077b9
>> ("virtio-blk: Add validation for block size in config space") and
>> enables similar checks in verify() on big endian platforms.
>> 
>> The problem with checking multi-byte config fields in the verify
>> callback, on big endian platforms, and with a possibly transitional
>> device is the following. The verify() callback is called between
>> config->get_features() and virtio_finalize_features(). That we have a
>> device that offered F_VERSION_1 then we have the following options
>> either the device is transitional, and then it has to present the legacy
>> interface, i.e. a big endian config space until F_VERSION_1 is
>> negotiated, or we have a non-transitional device, which makes
>> F_VERSION_1 mandatory, and only implements the non-legacy interface and
>> thus presents a little endian config space. Because at this point we
>> can't know if the device is transitional or non-transitional, we can't
>> know do we need to byte swap or not.
>
> Well we established that we can know. Here's an alternative explanation:
>
> 	The virtio specification virtio-v1.1-cs01 states:
>
> 	Transitional devices MUST detect Legacy drivers by detecting that
> 	VIRTIO_F_VERSION_1 has not been acknowledged by the driver.
> 	This is exactly what QEMU as of 6.1 has done relying solely
> 	on VIRTIO_F_VERSION_1 for detecting that.
>
> 	However, the specification also says:
> 	driver MAY read (but MUST NOT write) the device-specific
> 	configuration fields to check that it can support the device before
> 	accepting it.
>
> 	In that case, any device relying solely on VIRTIO_F_VERSION_1
> 	for detecting legacy drivers will return data in legacy format.
> 	In particular, this implies that it is in big endian format
> 	for big endian guests. This naturally confuses the driver
> 	which expects little endian in the modern mode.
>
> 	It is probably a good idea to amend the spec to clarify that
> 	VIRTIO_F_VERSION_1 can only be relied on after the feature negotiation
> 	is complete. However, we already have regression so let's
> 	try to address it.

I prefer that explanation.

>
>
>> 
>> The virtio spec explicitly states that the driver MAY read config
>> between reading and writing the features so saying that first accessing
>> the config before feature negotiation is done is not an option. The
>> specification ain't clear about setting the features multiple times
>> before FEATURES_OK, so I guess that should be fine to set F_VERSION_1
>> since at this point we already know that we are about to negotiate
>> F_VERSION_1.
>> 
>> I don't consider this patch super clean, but frankly I don't think we
>> have a ton of options. Another option that may or man not be cleaner,
>> but is also IMHO much uglier is to figure out whether the device is
>> transitional by rejecting _F_VERSION_1, then resetting it and proceeding
>> according tho what we have figured out, hoping that the characteristics
>> of the device didn't change.
>
> An empty line before tags.
>
>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
>> Fixes: 82e89ea077b9 ("virtio-blk: Add validation for block size in config space")
>> Reported-by: markver@us.ibm.com
>
> Let's add more commits that are affected. E.g. virtio-net with MTU
> feature bit set is affected too.
>
> So let's add Fixes tag for:
> commit 14de9d114a82a564b94388c95af79a701dc93134
> Author: Aaron Conole <aconole@redhat.com>
> Date:   Fri Jun 3 16:57:12 2016 -0400
>
>     virtio-net: Add initial MTU advice feature
>     
> I think that's all, but pls double check me.

I could not find anything else after a quick check.

>
>
>> ---
>>  drivers/virtio/virtio.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>> 
>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>> index 0a5b54034d4b..2b9358f2e22a 100644
>> --- a/drivers/virtio/virtio.c
>> +++ b/drivers/virtio/virtio.c
>> @@ -239,6 +239,12 @@ static int virtio_dev_probe(struct device *_d)
>>  		driver_features_legacy = driver_features;
>>  	}
>>  
>> +	/* Write F_VERSION_1 feature to pin down endianness */
>> +	if (device_features & (1ULL << VIRTIO_F_VERSION_1) & driver_features) {
>> +		dev->features = (1ULL << VIRTIO_F_VERSION_1);
>> +		dev->config->finalize_features(dev);
>> +	}
>> +
>>  	if (device_features & (1ULL << VIRTIO_F_VERSION_1))
>>  		dev->features = driver_features & device_features;
>>  	else
>> -- 
>> 2.31.1

I think we should go with this just to fix the nasty regression for now.

