Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2FCC43217
	for <linux-s390@archiver.kernel.org>; Wed,  3 Nov 2021 15:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9654961076
	for <linux-s390@archiver.kernel.org>; Wed,  3 Nov 2021 15:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhKCPno (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 3 Nov 2021 11:43:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45527 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229587AbhKCPno (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 3 Nov 2021 11:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635954067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tdy1X7nuoKpQSSmekhiR/fE1Lp4ym5mIRts+r6TWKnQ=;
        b=dVuYZtA327fWuPw4g33jD+cCW43LIZJV72WIygVYYyWqYo3aseetWn9FqT8fb2dowmm+HH
        kxOvhIW/4CExVSOf93xyH02+ANfdsGq7JCltlFVRe0jyXqiWzlw86ALVKlWGL/F7uuVkh0
        jNw3v8Y+4a3JLVA+j+36j31o6/BLLrE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-E3ibxboeNC61erK14SPP_A-1; Wed, 03 Nov 2021 11:41:04 -0400
X-MC-Unique: E3ibxboeNC61erK14SPP_A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA27C1235A83;
        Wed,  3 Nov 2021 15:41:02 +0000 (UTC)
Received: from localhost (unknown [10.39.192.240])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FCD15F4F7;
        Wed,  3 Nov 2021 15:41:02 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Vineeth Vijayan <vneethv@linux.ibm.com>, linux-s390@vger.kernel.org
Cc:     oberpar@linux.ibm.com, Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [RFC v2 0/1]s390/cio: remove uevent suppress from cio driver
In-Reply-To: <3ab690456a523951ad59c17ac71e6b294ff12d98.camel@linux.ibm.com>
Organization: Red Hat GmbH
References: <20211027085059.544736-1-vneethv@linux.ibm.com>
 <87lf26bmlq.fsf@redhat.com>
 <3ab690456a523951ad59c17ac71e6b294ff12d98.camel@linux.ibm.com>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Wed, 03 Nov 2021 16:41:00 +0100
Message-ID: <87a6ilb62b.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Nov 03 2021, Vineeth Vijayan <vneethv@linux.ibm.com> wrote:

>> > I think the potentially problematic case is "lots of I/O subchannels
>> with no valid device", and I think you can't get that under z/VM (which
>> will not give you those subchannels in the first place), but only on LPAR.
> Yes. But, this is in case of actual device. I just defined around 5k virtual
> dasd devices on zVM and did not enable them. i.e those subchannels are not
> blacklisted anymore, but they does not have an operational device. 
>
> other than zVM, other than testing this patch on different available LPARs,
> we tried to mimic the device availability with a custom test-kernel.
> Basically, modified the subchannel initialization code and inform the subchannel
> about the presence of a device, which then later fails during SNSID.
> It is a horrid way to test it, but i think it could simulate some LPARs with
> more than 1000 non-operational devices connected on it.

OK, that should be a way to figure out how userspace deals with the
extra uevents.

>
> ...snip...
>
>> - non-I/O subchannels (IIRC you can't have CHSC subchannels under z/VM,
>>   don't know about EADM, so that would need to be done on an LPAR as
>>   well)
> Thanks. Most of my tests were on IO-subchannel. I shall try few tests on CHSC
> and EADM.
>
>> - interaction with driverctl (and maybe mdevctl) for vfio-ccw
> I have done couple of tests with driverctl. Also, i was wondering if vfio-ccw
> can make use of 'dev_busid' sysfs-interface under each subchannels while writing
> the rules. This is totally different topic, which i do not want to mix up in
> this thread.

Oh, did not know about that interface.

<looks>
Doesn't the code need to check for 'w' for message subchannels, though?

'dev_busid' looks like a good fit for udev rules; maybe driverctl needs
special-casing? Or does it belong into mdevctl? cc:ing vfio-ccw
maintainers for awareness :)

