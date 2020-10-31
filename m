Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from smtp.hosts.co.uk ([85.233.160.19]:64548 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgKAAfM (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 31 Oct 2020 20:35:12 -0400
Subject: Re: [PATCH 01/11] mtd_blkdevs: don't override BLKFLSBUF
References: <20201031085810.450489-1-hch@lst.de>
 <20201031085810.450489-2-hch@lst.de>
From: antlists <antlists@youngman.org.uk>
Message-ID: <5170a536-09c1-28a7-c2fb-5381598194db@youngman.org.uk>
Date: Sat, 31 Oct 2020 23:11:14 +0000
MIME-Version: 1.0
In-Reply-To: <20201031085810.450489-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Ilya Dryomov <idryomov@gmail.com>, Song Liu <song@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-block@vger.kernel.org, ceph-devel@vger.kernel.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org

On 31/10/2020 08:58, Christoph Hellwig wrote:
> BLKFLSBUF does not actually send a flush command to the device, but
> teard down buffer cache structures.  Remove the mtd_blkdevs
   ^^^^^  ?tears?

> implementation and just use the default semantics instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Cheers,
Wol
