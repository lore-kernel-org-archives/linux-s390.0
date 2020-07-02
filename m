Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55826 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730125AbgGBOrS (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 2 Jul 2020 10:47:18 -0400
Subject: Re: [PATCH 09/20] bcache: stop setting ->queuedata
References: <20200701085947.3354405-1-hch@lst.de>
 <20200701085947.3354405-10-hch@lst.de>
From: Coly Li <colyli@suse.de>
Message-ID: <67f92716-202d-5436-4a79-32f0942dc680@suse.de>
Date: Thu, 2 Jul 2020 22:47:08 +0800
MIME-Version: 1.0
In-Reply-To: <20200701085947.3354405-10-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org, drbd-dev@lists.linbit.com, linuxppc-dev@lists.ozlabs.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org, linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org

On 2020/7/1 16:59, Christoph Hellwig wrote:
> Nothing in bcache actually uses the ->queuedata field.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Coly Li <colyli@suse.de>

> ---
>  drivers/md/bcache/super.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index 2014016f9a60d3..21aa168113d30b 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -876,7 +876,6 @@ static int bcache_device_init(struct bcache_device *d, unsigned int block_size,
>  		return -ENOMEM;
>  
>  	d->disk->queue			= q;
> -	q->queuedata			= d;
>  	q->backing_dev_info->congested_data = d;
>  	q->limits.max_hw_sectors	= UINT_MAX;
>  	q->limits.max_sectors		= UINT_MAX;
> 
