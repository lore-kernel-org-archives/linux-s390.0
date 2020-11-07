Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39124 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbgKGH20 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 7 Nov 2020 02:28:26 -0500
Subject: Re: [PATCH, RFC 11/10] block: propagate BLKROSET to all partitions
References: <20201106140817.GA23557@lst.de>
From: Coly Li <colyli@suse.de>
Message-ID: <a2add52e-715b-f82a-d6a0-b285f0f5acde@suse.de>
Date: Sat, 7 Nov 2020 15:28:15 +0800
MIME-Version: 1.0
In-Reply-To: <20201106140817.GA23557@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Ilya Dryomov <idryomov@gmail.com>, Song Liu <song@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-block@vger.kernel.org, ceph-devel@vger.kernel.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org, martin.petersen@oracle.com

On 2020/11/6 22:08, Christoph Hellwig wrote:
> 
> When setting the whole device read-only (or clearing the read-only
> state), also update the policy for all partitions.  The s390 dasd
> driver has awlways been doing this and it makes a lot of sense.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Coly Li <colyli@suse.de>

Thanks.


Coly Li

> ---
>  block/ioctl.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 6b785181344fe1..22f394d118c302 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -354,7 +354,10 @@ static int blkdev_roset(struct block_device *bdev, fmode_t mode,
>  		if (ret)
>  			return ret;
>  	}
> -	bdev->bd_part->policy = n;
> +	if (bdev_is_partition(bdev))
> +		bdev->bd_part->policy = n;
> +	else
> +		set_disk_ro(bdev->bd_disk, n);
>  	return 0;
>  }
>  
> 
