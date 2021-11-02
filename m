Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AFBC433F5
	for <linux-s390@archiver.kernel.org>; Tue,  2 Nov 2021 15:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C17E860F36
	for <linux-s390@archiver.kernel.org>; Tue,  2 Nov 2021 15:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbhKBPeM (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 2 Nov 2021 11:34:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49251 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234570AbhKBPeL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 2 Nov 2021 11:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635867096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Lmh4ns2ExMkOc2rPJm8i2jQVzVqY8ATR+dc8JvY8i0=;
        b=OwufO/gKCVDb/ker6AbDn9l5mBm1KnD1BE+EFwcPofASGrIwP2WK/uVm+uqJCYhGjQw2+B
        ZemI9vTDvCvgv0BsZF2O7oNDA6fmmFilZm90oyltp6Zsd7HNe+Mo9e8rcf+glzZMhtNhhy
        hM44FYRBpt9qHBy3UnbNqgw7CWNSMys=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-27WKfk-hMk2lFgUls5UTSw-1; Tue, 02 Nov 2021 11:31:32 -0400
X-MC-Unique: 27WKfk-hMk2lFgUls5UTSw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97AFE801107;
        Tue,  2 Nov 2021 15:31:31 +0000 (UTC)
Received: from localhost (unknown [10.39.193.139])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E16013ABD;
        Tue,  2 Nov 2021 15:31:31 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Vineeth Vijayan <vneethv@linux.ibm.com>, linux-s390@vger.kernel.org
Cc:     oberpar@linux.ibm.com, vneethv@linux.ibm.com
Subject: Re: [RFC v2 0/1]s390/cio: remove uevent suppress from cio driver
In-Reply-To: <20211027085059.544736-1-vneethv@linux.ibm.com>
Organization: Red Hat GmbH
References: <20211027085059.544736-1-vneethv@linux.ibm.com>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Tue, 02 Nov 2021 16:31:29 +0100
Message-ID: <87lf26bmlq.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Oct 27 2021, Vineeth Vijayan <vneethv@linux.ibm.com> wrote:

> This is the follow-up for the old RFC which i have posted here couple of
> months back. During the previous discussions on that RFC we concluded
> that removing the uevent-suppress from the CIO layer is the cleaner way
> of doing it and we should proceed. Reason for this RFC is, i want to
> convince myself that, i am not doing something wrong. I would like to
> bring up some of the tests i have done and the conclusion from those
> tests.
>
> The reason for introducing the delay in uevent generation was to avoid a
> uevent storm from those subchannels which does not have a valid device
> connected on this. I think for the new generation Z machines, this is
> not inconsequential. The bigger worry was, how this change is going to
> effect servers with lots of devices connected to them.
>
> For example, with this change, we are introducing a new uevent, which
> was previously suppressed. Below is the udevadm monitor report which
> shows the uevent generated when we define a new dasd device.
>
> $: vmcp def t3390 e002 1
> DASD E002 DEFINED
> KERNEL[53.083552] add      /devices/css0/0.0.13af (css)
> * KERNEL[53.083590] bind     /devices/css0/0.0.13af (css)
> KERNEL[53.086561] add      /devices/css0/0.0.13af/0.0.e002 (ccw)
> KERNEL[53.087136] bind     /devices/css0/0.0.13af/0.0.e002 (ccw)
>
> This new uvent on css (Which is highlighed with *), does not have a bigger
> impact on the machines. But, they are useless for those subchannels without
> a proper device associated with it.

Well, it's not exactly useless -- userspace gets notified that the
device has bound to a driver, which was an information that was
completely missing up to now for subchannels. The main issue is that the
subchannel will get deregistered again (or has that been changed? Sorry,
I've been out of the loop for too long...)

>
> We wanted to make sure that this new uevents are not giving bigger
> impacts on customer machines which would accommodate many more devices on
> an LPAR. One test to simulate this scenario was to define more than 5000
> dasd devices on a zVM and check the boot and initialization delay with and
> without this patch. This does not show any impact on the zVM with high
> number of devices.

I think the potentially problematic case is "lots of I/O subchannels
with no valid device", and I think you can't get that under z/VM (which
will not give you those subchannels in the first place), but only on LPAR.

>
> I dont see any specific impact on this patch as of now. But, if you
> think there is some more testing which are required before we push this
> patch, please do let me know.

I would probably also verify:
- non-I/O subchannels (IIRC you can't have CHSC subchannels under z/VM,
  don't know about EADM, so that would need to be done on an LPAR as
  well)
- interaction with driverctl (and maybe mdevctl) for vfio-ccw

But I think I also may be a bit out of touch here :)

>
>
> Vineeth Vijayan (1):
>   s390/cio: remove uevent suppress from css driver
>
>  drivers/s390/cio/chsc_sch.c     |  5 -----
>  drivers/s390/cio/css.c          | 19 -------------------
>  drivers/s390/cio/device.c       | 18 ------------------
>  drivers/s390/cio/eadm_sch.c     |  5 -----
>  drivers/s390/cio/vfio_ccw_drv.c |  5 -----
>  5 files changed, 52 deletions(-)

