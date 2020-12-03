Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgLCUyd (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 3 Dec 2020 15:54:33 -0500
Date: Thu, 3 Dec 2020 12:53:49 -0800
From: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 3/9] block: store a block_device pointer in struct bio
Message-ID: <20201203205349.GB3404013@dhcp-10-100-145-180.wdc.com>
References: <20201201165424.2030647-1-hch@lst.de>
 <20201201165424.2030647-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201165424.2030647-4-hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Coly Li <colyli@suse.de>, Song Liu <song@kernel.org>, dm-devel@redhat.com, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-s390@vger.kernel.org, linux-block@vger.kernel.org

On Tue, Dec 01, 2020 at 05:54:18PM +0100, Christoph Hellwig wrote:
> diff --git a/block/blk.h b/block/blk.h
> index 98f0b1ae264120..64dc8e5a3f44cb 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -99,8 +99,8 @@ static inline void blk_rq_bio_prep(struct request *rq, struct bio *bio,
>  	rq->bio = rq->biotail = bio;
>  	rq->ioprio = bio_prio(bio);
>  
> -	if (bio->bi_disk)
> -		rq->rq_disk = bio->bi_disk;
> +	if (bio->bi_bdev)
> +		rq->rq_disk = bio->bi_bdev->bd_disk;
>  }

Just fyi, this function has been relocated to include/linux/blk-mq.h
