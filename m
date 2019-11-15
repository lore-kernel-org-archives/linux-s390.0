Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47856 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727089AbfKOKJR (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 Nov 2019 05:09:17 -0500
Subject: Re: [PATCH 7/7] block: move setting bd_invalidated from flush_disk to
 check_disk_change
References: <20191114143438.14681-1-hch@lst.de>
 <20191114143438.14681-8-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <118ce019-45ce-138c-afe2-5793c33ea0c9@suse.de>
Date: Fri, 15 Nov 2019 11:09:14 +0100
MIME-Version: 1.0
In-Reply-To: <20191114143438.14681-8-hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Cc: linux-block@vger.kernel.org, linux-s390@vger.kernel.org

On 11/14/19 3:34 PM, Christoph Hellwig wrote:
> The only other caller of flush_disk instantly clears the flag, so don't
> bother setting it there.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/block_dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index ee63c2732fa2..f60739b5a24f 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1403,7 +1403,6 @@ static void flush_disk(struct block_device *bdev, bool kill_dirty)
>  		       "resized disk %s\n",
>  		       bdev->bd_disk ? bdev->bd_disk->disk_name : "");
>  	}
> -	bdev->bd_invalidated = 1;
>  }
>  
>  /**
> @@ -1491,6 +1490,7 @@ int check_disk_change(struct block_device *bdev)
>  		return 0;
>  
>  	flush_disk(bdev, true);
> +	bdev->bd_invalidated = 1;
>  	if (bdops->revalidate_disk)
>  		bdops->revalidate_disk(bdev->bd_disk);
>  	return 1;
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      Teamlead Storage & Networking
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 247165 (AG München), GF: Felix Imendörffer
