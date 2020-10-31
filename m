Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbgJaO64 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 31 Oct 2020 10:58:56 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C06C061A48
        for <linux-s390@vger.kernel.org>; Sat, 31 Oct 2020 07:58:55 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 13so7539811pfy.4
        for <linux-s390@vger.kernel.org>; Sat, 31 Oct 2020 07:58:55 -0700 (PDT)
Subject: Re: [PATCH 02/11] mtip32xx: return -ENOTTY for all unhanled ioctls
References: <20201031085810.450489-1-hch@lst.de>
 <20201031085810.450489-3-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f128e8bb-7ce4-b8f4-80cb-1afab503887c@kernel.dk>
Date: Sat, 31 Oct 2020 08:58:52 -0600
MIME-Version: 1.0
In-Reply-To: <20201031085810.450489-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Ilya Dryomov <idryomov@gmail.com>, Song Liu <song@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-block@vger.kernel.org, ceph-devel@vger.kernel.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org

On 10/31/20 2:58 AM, Christoph Hellwig wrote:
> -ENOTTY is the convention for "driver does not support this ioctl".
> Use it properly in mtip32xx instead of the bogys -EINVAL.

While that's certainly true, there is a risk in making a change like this
years after the fact. Not that I expect there are any mtip32xx users
left at this point, but...

-- 
Jens Axboe
