Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgKKQNJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 11 Nov 2020 11:13:09 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E44DC0617A6
        for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2020 08:13:08 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id y9so2481952ilb.0
        for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2020 08:13:07 -0800 (PST)
Subject: Re: block ioctl cleanups v2
References: <20201103100018.683694-1-hch@lst.de>
 <20201111075802.GB23010@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <92a7c6e5-fe8b-e291-0dce-ecd727262a2e@kernel.dk>
Date: Wed, 11 Nov 2020 09:13:05 -0700
MIME-Version: 1.0
In-Reply-To: <20201111075802.GB23010@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Ilya Dryomov <idryomov@gmail.com>, Song Liu <song@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-block@vger.kernel.org, ceph-devel@vger.kernel.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org

On 11/11/20 12:58 AM, Christoph Hellwig wrote:
> Jens, can you take a look and possibly pick this series up?

Looks good to me - but what is the final resolution on the BLKROSET
propagation?

-- 
Jens Axboe
