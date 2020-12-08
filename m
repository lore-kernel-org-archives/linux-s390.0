Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbgLHOQ3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Dec 2020 09:16:29 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF38CC061794
        for <linux-s390@vger.kernel.org>; Tue,  8 Dec 2020 06:15:43 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id i9so17071431ioo.2
        for <linux-s390@vger.kernel.org>; Tue, 08 Dec 2020 06:15:43 -0800 (PST)
Subject: Re: store a pointer to the block_device in struct bio (again)
References: <20201201165424.2030647-1-hch@lst.de>
 <920899710c9e8dcce16e561c6d832e4e9c03cd73.camel@redhat.com>
 <20201208110403.GA22179@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <cc95b9eb-6278-4b0d-6cf9-19c35714bfe7@kernel.dk>
Date: Tue, 8 Dec 2020 07:15:43 -0700
MIME-Version: 1.0
In-Reply-To: <20201208110403.GA22179@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Qian Cai <qcai@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Coly Li <colyli@suse.de>, Song Liu <song@kernel.org>, dm-devel@redhat.com, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-s390@vger.kernel.org, linux-block@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>

On 12/8/20 4:04 AM, Christoph Hellwig wrote:
> Hi Qian,
> 
> can you send me details of your device mapper setup, e.g. which targets
> are used, are they used on top of whole device or partitions.  Do you
> use partitions on top of the dm devices?  Are any other stacking devices
> involved?

Don't think this needs anything fancy at all - I know Pavel got his
test box corrupted, and mine did as well. Looks like it pretty much
affected everyone that got unlucky enough to try it, not great...

Mine is just ext4 root on nvme.

-- 
Jens Axboe
