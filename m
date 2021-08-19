Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404B0C4338F
	for <linux-s390@archiver.kernel.org>; Thu, 19 Aug 2021 15:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2198561157
	for <linux-s390@archiver.kernel.org>; Thu, 19 Aug 2021 15:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240559AbhHSPbM (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 19 Aug 2021 11:31:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20944 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240315AbhHSPbE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Aug 2021 11:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629387027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gYOHG6nrXJLL3qFyM+onzFAAsu5lYNgbscRFJOWcw1U=;
        b=QUqu5RH5SlIu2cPL36/MO5tKsOJE2EpJyHNrZrHfxfUOEWQP9TzVAM9qOVEwoAmQNVrGfC
        YX1KiQYL3fJ6N07371N2NEVnSQj12X8wcQrUAE8J75wvDnf4XwuuxPwaB2GqYWoTG61hmW
        QQEQDqqUgilRkYguEr6UBdam40WtGeA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-mpSJLYCoPYO9e41_CNr-fA-1; Thu, 19 Aug 2021 11:30:25 -0400
X-MC-Unique: mpSJLYCoPYO9e41_CNr-fA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 066089250D;
        Thu, 19 Aug 2021 15:30:23 +0000 (UTC)
Received: from localhost (unknown [10.39.192.140])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9853B60BF4;
        Thu, 19 Aug 2021 15:30:22 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, pasic@linux.vnet.ibm.com,
        jjherne@linux.ibm.com, jgg@nvidia.com, kwankhede@nvidia.com,
        david@redhat.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Subject: Re: [PATCH 0/2] s390/vfio-ap: do not open code locks for
 VFIO_GROUP_NOTIFY_SET_KVM notification
In-Reply-To: <20210818103908.31eb5848.alex.williamson@redhat.com>
Organization: Red Hat GmbH
References: <20210719193503.793910-1-akrowiak@linux.ibm.com>
 <3f45fe31-6666-ac87-3a98-dd942b5dfb3c@linux.ibm.com>
 <20210802155355.22b98789.pasic@linux.ibm.com>
 <6f37ef28-3cce-2f4f-3173-2c1e916900cc@linux.ibm.com>
 <6d64bd83-1519-6065-a4cd-9356c6be5d1a@de.ibm.com>
 <20210818103908.31eb5848.alex.williamson@redhat.com>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Thu, 19 Aug 2021 17:30:21 +0200
Message-ID: <8735r5sb8y.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Aug 18 2021, Alex Williamson <alex.williamson@redhat.com> wrote:

> On Wed, 18 Aug 2021 17:59:51 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>
>> On 02.08.21 18:32, Tony Krowiak wrote:
>> > 
>> > 
>> > On 8/2/21 9:53 AM, Halil Pasic wrote:  
>> >> On Mon, 2 Aug 2021 09:10:26 -0400
>> >> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>> >>  
>> >>> PING!
>> >>>
>> >>> This patch will pre-req version 17 of a patch series I have waiting in
>> >>> the wings,
>> >>> so I'd like to get this one merged ASAP. In particular, if a KVM
>> >>> maintainer can
>> >>> take a look at the comments concerning the taking of the kvm->lock
>> >>> before the
>> >>> matrix_mdev->lock it would be greatly appreciated. Those comments begin with
>> >>> Message ID <20210727004329.3bcc7d4f.pasic@linux.ibm.com> from Halil Pasic.  
>> >> As far as I'm concerned, we can move forward with this. Was this
>> >> supposed to go in via Alex's tree?  
>> > 
>> > I am not certain, Christian queued the previous patches related to
>> > this on:
>> > 
>> > 
>> > https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/log/?h=fixes
>> > 
>> > Jason G., since this will need to be integrated with your other patches,
>> > where should this be queued?  
>> 
>> 
>> This previous patch (s390/vfio-ap: clean up mdev resources when remove callback invoked) is
>> already in master.
>> Can you respin the series with all Acks and RBs?
>> 
>> Alex, can you then take these 2 patches via your tree? Thanks
>> 
>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> for this series.
>
>
> I see some review feedback that seems to suggest a new version would be
> posted:
>
> https://lore.kernel.org/linux-s390/0f03ab0b-2dfd-e1c1-fe43-be2a59030a71@linux.ibm.com/

Yeah, I thought so as well. But it also looks like something that could
be a fixup on top.

>
> I also see in this thread:
>
> https://lore.kernel.org/linux-s390/20210721164550.5402fe1c.pasic@linux.ibm.com/
>
> that Halil's concern's around open/close races are addressed by Jason's
> device_open/close series that's already in my next branch and he
> provided an Ack, but there's still the above question regarding the
> kvm->lock that was looking for a review from... I'm not sure, maybe
> Connie or Paolo.  Christian, is this specifically what you're ack'ing?

I'm also unsure about the kvm->lock thing. Is taking the lock buried
somewhere deep in the code that will ultimately trigger the release?
I would at least like a pointer.

>
> It can ultimately go in through my tree, but not being familiar with
> this code I'd hope for more closure.  Thanks,
>
> Alex

