Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37972 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726866AbfKGJrn (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 7 Nov 2019 04:47:43 -0500
Subject: Re: [PATCH 2/5] block: merge invalidate_partitions into
 rescan_partitions
References: <20191106151439.30056-1-hch@lst.de>
 <20191106151439.30056-3-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <f95d65cb-f864-5cfe-1161-4f940a59f38e@suse.de>
Date: Thu, 7 Nov 2019 10:47:39 +0100
MIME-Version: 1.0
In-Reply-To: <20191106151439.30056-3-hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Cc: linux-block@vger.kernel.org, linux-s390@vger.kernel.org

On 11/6/19 4:14 PM, Christoph Hellwig wrote:
> A lot of the logic in invalidate_partitions and invalidate_partitions

... rescan_partitions and invalidate_partitions ...

> is shared.  Merge the two functions to simplify things.  There is
> a small behavior change in that we now send the keven change notice
> also if we were not invalidating but no partitions were found, which
> seems like the right thing to do.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/ioctl.c             |  2 +-
>  block/partition-generic.c | 38 ++++++++++++++------------------------
>  fs/block_dev.c            |  5 +----
>  include/linux/genhd.h     |  4 ++--
>  4 files changed, 18 insertions(+), 31 deletions(-)
> 
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 15a0eb80ada9..8a7e33ce2097 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -171,7 +171,7 @@ int __blkdev_reread_part(struct block_device *bdev)
>  
>  	lockdep_assert_held(&bdev->bd_mutex);
>  
> -	return rescan_partitions(disk, bdev);
> +	return rescan_partitions(disk, bdev, false);
>  }
>  EXPORT_SYMBOL(__blkdev_reread_part);
>  
> diff --git a/block/partition-generic.c b/block/partition-generic.c
> index f113be069b40..eae9daa8a523 100644
> --- a/block/partition-generic.c
> +++ b/block/partition-generic.c
> @@ -632,7 +632,8 @@ static int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
>  	return ret;
>  }
>  
> -int rescan_partitions(struct gendisk *disk, struct block_device *bdev)
> +int rescan_partitions(struct gendisk *disk, struct block_device *bdev,
> +		bool invalidate)
>  {
>  	int ret;
>  
> @@ -641,13 +642,22 @@ int rescan_partitions(struct gendisk *disk, struct block_device *bdev)
>  	if (ret)
>  		return ret;
>  
> -	if (disk->fops->revalidate_disk)
> +	if (invalidate)
> +		set_capacity(disk, 0);
> +	else if (disk->fops->revalidate_disk)
>  		disk->fops->revalidate_disk(disk);
> -	check_disk_size_change(disk, bdev, true);
> +
> +	check_disk_size_change(disk, bdev, !invalidate);
>  	bdev->bd_invalidated = 0;
>  
> -	if (!get_capacity(disk))
> +	if (!get_capacity(disk)) {
> +		/*
> +		 * Tell userspace that the media / partition table may have
> +		 * changed.
> +		 */
> +		kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
>  		return 0;
> +	}
>  	
I wonder; wouldn't we miss a true size change here?

check_disk_size_change() will issue a kernel message (but no usevent) if
we have a real disk size change; if we fail to revalidate the disk an
uevent is issued, but no kernel message.

Can't we combine both by making check_disk_size_change() a bool function
and drop the call to 'get_capacity()', seeing that it's done in
check_disk_size_change() anyway?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      Teamlead Storage & Networking
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 247165 (AG München), GF: Felix Imendörffer
