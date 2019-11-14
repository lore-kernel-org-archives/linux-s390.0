Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43670 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726139AbfKNNNk (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 08:13:40 -0500
Date: Thu, 14 Nov 2019 14:13:32 +0100
From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 1/5] block: refactor rescan_partitions
Message-ID: <20191114131332.GF28486@quack2.suse.cz>
References: <20191106151439.30056-1-hch@lst.de>
 <20191106151439.30056-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106151439.30056-2-hch@lst.de>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org, linux-s390@vger.kernel.org

On Wed 06-11-19 16:14:35, Christoph Hellwig wrote:
> Split out a helper that adds one single partition, and another one
> calling that dealing with the parsed_partitions state.  This makes
> it much more obvious how we clean up all state and start again when
> using the rescan label.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/partition-generic.c | 176 +++++++++++++++++++++-----------------
>  1 file changed, 96 insertions(+), 80 deletions(-)
> 
> diff --git a/block/partition-generic.c b/block/partition-generic.c
> index aee643ce13d1..f113be069b40 100644
> --- a/block/partition-generic.c
> +++ b/block/partition-generic.c
> @@ -509,26 +509,77 @@ static bool part_zone_aligned(struct gendisk *disk,
>  	return true;
>  }
>  
> -int rescan_partitions(struct gendisk *disk, struct block_device *bdev)
> +static bool blk_add_partition(struct gendisk *disk, struct block_device *bdev,
> +		struct parsed_partitions *state, int p)
>  {
> -	struct parsed_partitions *state = NULL;
> +	sector_t size = state->parts[p].size;
> +	sector_t from = state->parts[p].from;
>  	struct hd_struct *part;
> -	int p, highest, res;
> -rescan:
> -	if (state && !IS_ERR(state)) {
> -		free_partitions(state);
> -		state = NULL;
> +
> +	if (!size)
> +		return true;
> +
> +	if (from >= get_capacity(disk)) {
> +		printk(KERN_WARNING
> +		       "%s: p%d start %llu is beyond EOD, ",
> +		       disk->disk_name, p, (unsigned long long) from);
> +		if (disk_unlock_native_capacity(disk))
> +			return false;
> +		return true;
>  	}
>  
> -	res = drop_partitions(disk, bdev);
> -	if (res)
> -		return res;
> +	if (from + size > get_capacity(disk)) {
> +		printk(KERN_WARNING
> +		       "%s: p%d size %llu extends beyond EOD, ",
> +		       disk->disk_name, p, (unsigned long long) size);
>  
> -	if (disk->fops->revalidate_disk)
> -		disk->fops->revalidate_disk(disk);
> -	check_disk_size_change(disk, bdev, true);
> -	bdev->bd_invalidated = 0;
> -	if (!get_capacity(disk) || !(state = check_partition(disk, bdev)))
> +		if (disk_unlock_native_capacity(disk))
> +			return false;
> +
> +		/*
> +		 * We can not ignore partitions of broken tables created by for
> +		 * example camera firmware, but we limit them to the end of the
> +		 * disk to avoid creating invalid block devices.
> +		 */
> +		size = get_capacity(disk) - from;
> +	}
> +
> +	/*
> +	 * On a zoned block device, partitions should be aligned on the device
> +	 * zone size (i.e. zone boundary crossing not allowed).  Otherwise,
> +	 * resetting the write pointer of the last zone of one partition may
> +	 * impact the following partition.
> +	 */
> +	if (bdev_is_zoned(bdev) && !part_zone_aligned(disk, bdev, from, size)) {
> +		printk(KERN_WARNING
> +		       "%s: p%d start %llu+%llu is not zone aligned\n",
> +		       disk->disk_name, p, (unsigned long long) from,
> +		       (unsigned long long) size);
> +		return true;
> +	}
> +
> +	part = add_partition(disk, p, from, size, state->parts[p].flags,
> +			     &state->parts[p].info);
> +	if (IS_ERR(part)) {
> +		printk(KERN_ERR " %s: p%d could not be added: %ld\n",
> +		       disk->disk_name, p, -PTR_ERR(part));
> +		return true;
> +	}
> +
> +#ifdef CONFIG_BLK_DEV_MD
> +	if (state->parts[p].flags & ADDPART_FLAG_RAID)
> +		md_autodetect_dev(part_to_dev(part)->devt);
> +#endif
> +	return true;
> +}
> +
> +static int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
> +{
> +	struct parsed_partitions *state;
> +	int ret = -EAGAIN, p, highest;
> +
> +	state = check_partition(disk, bdev);
> +	if (!state)
>  		return 0;
>  	if (IS_ERR(state)) {
>  		/*
> @@ -540,7 +591,7 @@ int rescan_partitions(struct gendisk *disk, struct block_device *bdev)
>  			printk(KERN_WARNING "%s: partition table beyond EOD, ",
>  			       disk->disk_name);
>  			if (disk_unlock_native_capacity(disk))
> -				goto rescan;
> +				return -EAGAIN;
>  		}
>  		return -EIO;
>  	}
> @@ -554,7 +605,7 @@ int rescan_partitions(struct gendisk *disk, struct block_device *bdev)
>  		       "%s: partition table partially beyond EOD, ",
>  		       disk->disk_name);
>  		if (disk_unlock_native_capacity(disk))
> -			goto rescan;
> +			goto out_free_state;
>  	}
>  
>  	/* tell userspace that the media / partition table may have changed */
> @@ -571,72 +622,37 @@ int rescan_partitions(struct gendisk *disk, struct block_device *bdev)
>  	disk_expand_part_tbl(disk, highest);
>  
>  	/* add partitions */
> -	for (p = 1; p < state->limit; p++) {
> -		sector_t size, from;
> -
> -		size = state->parts[p].size;
> -		if (!size)
> -			continue;
> -
> -		from = state->parts[p].from;
> -		if (from >= get_capacity(disk)) {
> -			printk(KERN_WARNING
> -			       "%s: p%d start %llu is beyond EOD, ",
> -			       disk->disk_name, p, (unsigned long long) from);
> -			if (disk_unlock_native_capacity(disk))
> -				goto rescan;
> -			continue;
> -		}
> +	for (p = 1; p < state->limit; p++)
> +		if (!blk_add_partition(disk, bdev, state, p))
> +			goto out_free_state;
>  
> -		if (from + size > get_capacity(disk)) {
> -			printk(KERN_WARNING
> -			       "%s: p%d size %llu extends beyond EOD, ",
> -			       disk->disk_name, p, (unsigned long long) size);
> -
> -			if (disk_unlock_native_capacity(disk)) {
> -				/* free state and restart */
> -				goto rescan;
> -			} else {
> -				/*
> -				 * we can not ignore partitions of broken tables
> -				 * created by for example camera firmware, but
> -				 * we limit them to the end of the disk to avoid
> -				 * creating invalid block devices
> -				 */
> -				size = get_capacity(disk) - from;
> -			}
> -		}
> +	ret = 0;
> +out_free_state:
> +	free_partitions(state);
> +	return ret;
> +}
>  
> -		/*
> -		 * On a zoned block device, partitions should be aligned on the
> -		 * device zone size (i.e. zone boundary crossing not allowed).
> -		 * Otherwise, resetting the write pointer of the last zone of
> -		 * one partition may impact the following partition.
> -		 */
> -		if (bdev_is_zoned(bdev) &&
> -		    !part_zone_aligned(disk, bdev, from, size)) {
> -			printk(KERN_WARNING
> -			       "%s: p%d start %llu+%llu is not zone aligned\n",
> -			       disk->disk_name, p, (unsigned long long) from,
> -			       (unsigned long long) size);
> -			continue;
> -		}
> +int rescan_partitions(struct gendisk *disk, struct block_device *bdev)
> +{
> +	int ret;
>  
> -		part = add_partition(disk, p, from, size,
> -				     state->parts[p].flags,
> -				     &state->parts[p].info);
> -		if (IS_ERR(part)) {
> -			printk(KERN_ERR " %s: p%d could not be added: %ld\n",
> -			       disk->disk_name, p, -PTR_ERR(part));
> -			continue;
> -		}
> -#ifdef CONFIG_BLK_DEV_MD
> -		if (state->parts[p].flags & ADDPART_FLAG_RAID)
> -			md_autodetect_dev(part_to_dev(part)->devt);
> -#endif
> -	}
> -	free_partitions(state);
> -	return 0;
> +rescan:
> +	ret = drop_partitions(disk, bdev);
> +	if (ret)
> +		return ret;
> +
> +	if (disk->fops->revalidate_disk)
> +		disk->fops->revalidate_disk(disk);
> +	check_disk_size_change(disk, bdev, true);
> +	bdev->bd_invalidated = 0;
> +
> +	if (!get_capacity(disk))
> +		return 0;
> +	
> +	ret = blk_add_partitions(disk, bdev);
> +	if (ret == -EAGAIN)
> +		goto rescan;
> +	return ret;
>  }
>  
>  int invalidate_partitions(struct gendisk *disk, struct block_device *bdev)
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
