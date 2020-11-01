Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgKAQp0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 1 Nov 2020 11:45:26 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F2AC061A49
        for <linux-s390@vger.kernel.org>; Sun,  1 Nov 2020 08:45:25 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 72so2253251pfv.7
        for <linux-s390@vger.kernel.org>; Sun, 01 Nov 2020 08:45:25 -0800 (PST)
Subject: Re: [PATCH 02/11] mtip32xx: return -ENOTTY for all unhanled ioctls
References: <20201031085810.450489-1-hch@lst.de>
 <20201031085810.450489-3-hch@lst.de>
 <f128e8bb-7ce4-b8f4-80cb-1afab503887c@kernel.dk>
 <20201101102735.GA26447@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <842f4d23-b8c2-8ade-caf3-50b7cb9542cb@kernel.dk>
Date: Sun, 1 Nov 2020 09:45:21 -0700
MIME-Version: 1.0
In-Reply-To: <20201101102735.GA26447@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Ilya Dryomov <idryomov@gmail.com>, Song Liu <song@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-block@vger.kernel.org, ceph-devel@vger.kernel.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org

On 11/1/20 3:27 AM, Christoph Hellwig wrote:
> On Sat, Oct 31, 2020 at 08:58:52AM -0600, Jens Axboe wrote:
>> On 10/31/20 2:58 AM, Christoph Hellwig wrote:
>>> -ENOTTY is the convention for "driver does not support this ioctl".
>>> Use it properly in mtip32xx instead of the bogys -EINVAL.
>>
>> While that's certainly true, there is a risk in making a change like this
>> years after the fact. Not that I expect there are any mtip32xx users
>> left at this point, but...
> 
> -ENOTTY is what most drivers return.  That being said we can keep the
> old behavior, so if you prepfer that I can respin to do that.

Yeah I know that -ENOTTY is what they all should use (and most of course
does), just saying that this change carries some risk. Given that
mtip32xx can probably be retired in the not-too-distant future, I say we
just keep the -EINVAL here.

-- 
Jens Axboe
