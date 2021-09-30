Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B8BC433F5
	for <linux-s390@archiver.kernel.org>; Thu, 30 Sep 2021 11:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E79B361390
	for <linux-s390@archiver.kernel.org>; Thu, 30 Sep 2021 11:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350524AbhI3Li1 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 30 Sep 2021 07:38:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42820 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350523AbhI3Li0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Sep 2021 07:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633001804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d2DkrjLmS5cuqV/GQI0XL4Bc/b2l6NbJQU00lS8/LDs=;
        b=huSqlDqoBY/kEMmnnh60Y/WtQFQ5nyxF2vqP3WK9o43G9PXBakFULcN9klLAPTtuOuypxd
        ons+soomaztVQA+Msv4ZgeMPJRdwGgg00AVqb/LNCxc8/efxsHdQ6DNhmQfhLq2Nqi99C0
        eQsaKkgeW8s5EJRO4/xLhtqOgYe5YmE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-VovEpZTwO3q3Hwz5eSJVSw-1; Thu, 30 Sep 2021 07:36:41 -0400
X-MC-Unique: VovEpZTwO3q3Hwz5eSJVSw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0CD51006AA4;
        Thu, 30 Sep 2021 11:36:39 +0000 (UTC)
Received: from localhost (unknown [10.39.192.253])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 410C719729;
        Thu, 30 Sep 2021 11:36:29 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, markver@us.ibm.com,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
In-Reply-To: <20210930070444-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <20210930070444-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Thu, 30 Sep 2021 13:36:27 +0200
Message-ID: <87fstm47no.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Sep 30 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Sep 30, 2021 at 03:20:49AM +0200, Halil Pasic wrote:
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
> Hmm which transport does this refer to?
> Distinguishing between legacy and modern drivers is transport
> specific.  PCI presents
> legacy and modern at separate addresses so distinguishing
> between these two should be no trouble.

Hm, what about transitional devices?

> Channel i/o has versioning so same thing?

It can turn off VERSION_1, but not legacy. (I had hacked up a patchset
to potentially disable legacy some time ago, but did not have any
resources to follow up on this.)

>
>> The virtio spec explicitly states that the driver MAY read config
>> between reading and writing the features so saying that first accessing
>> the config before feature negotiation is done is not an option. The
>> specification ain't clear about setting the features multiple times
>> before FEATURES_OK, so I guess that should be fine.
>> 
>> I don't consider this patch super clean, but frankly I don't think we
>> have a ton of options. Another option that may or man not be cleaner,
>> but is also IMHO much uglier is to figure out whether the device is
>> transitional by rejecting _F_VERSION_1, then resetting it and proceeding
>> according tho what we have figured out, hoping that the characteristics
>> of the device didn't change.
>
> I am confused here. So is the problem at the device or at the driver level?
> I suspect it's actually the host that has the issue, not
> the guest?

From my perspective the problem is that the version of the device
remains in limbo as long as the features have not yet been finalized,
which means that the endianness of the config space remains in limbo as
well. Both device and driver might come to different conclusions.

>
>
>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
>> Fixes: 82e89ea077b9 ("virtio-blk: Add validation for block size in config space")
>> Reported-by: markver@us.ibm.com
>> ---
>>  drivers/virtio/virtio.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>> 
>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>> index 0a5b54034d4b..9dc3cfa17b1c 100644
>> --- a/drivers/virtio/virtio.c
>> +++ b/drivers/virtio/virtio.c
>> @@ -249,6 +249,10 @@ static int virtio_dev_probe(struct device *_d)
>>  		if (device_features & (1ULL << i))
>>  			__virtio_set_bit(dev, i);
>>  
>> +	/* Write back features before validate to know endianness */
>> +	if (device_features & (1ULL << VIRTIO_F_VERSION_1))
>> +		dev->config->finalize_features(dev);
>> +
>>  	if (drv->validate) {
>>  		err = drv->validate(dev);
>>  		if (err)
>> 
>> base-commit: 02d5e016800d082058b3d3b7c3ede136cdc6ddcb
>> -- 
>> 2.25.1

