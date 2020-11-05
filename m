Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16442 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726801AbgKEU6A (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 Nov 2020 15:58:00 -0500
Date: Thu, 5 Nov 2020 21:56:47 +0100
From: Stefan Haberland <sth@linux.ibm.com>
Subject: Re: [PATCH 06/10] dasd: implement ->set_read_only to hook into
 BLKROSET processing
Message-ID: <20201105205634.GA78869@imap.linux.ibm.com>
References: <20201103100018.683694-1-hch@lst.de>
 <20201103100018.683694-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103100018.683694-7-hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Ilya Dryomov <idryomov@gmail.com>, Song Liu <song@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-block@vger.kernel.org, ceph-devel@vger.kernel.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org

Christoph Hellwig <hch@lst.de> schrieb am Tue, 03. Nov 11:00:
> Implement the ->set_read_only method instead of parsing the actual
> ioctl command.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/s390/block/dasd.c       |  1 +
>  drivers/s390/block/dasd_int.h   |  3 ++-
>  drivers/s390/block/dasd_ioctl.c | 27 +++++++++------------------
>  3 files changed, 12 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
> index eb17fea8075c6f..db24e04ee9781e 100644
> --- a/drivers/s390/block/dasd.c
> +++ b/drivers/s390/block/dasd.c
> @@ -3394,6 +3394,7 @@ dasd_device_operations = {
>  	.ioctl		= dasd_ioctl,
>  	.compat_ioctl	= dasd_ioctl,
>  	.getgeo		= dasd_getgeo,
> +	.set_read_only	= dasd_set_read_only,
>  };
>  
>  /*******************************************************************************
> diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
> index fa552f9f166671..c59a0d63b506e6 100644
> --- a/drivers/s390/block/dasd_int.h
> +++ b/drivers/s390/block/dasd_int.h
> @@ -844,7 +844,8 @@ int dasd_scan_partitions(struct dasd_block *);
>  void dasd_destroy_partitions(struct dasd_block *);
>  
>  /* externals in dasd_ioctl.c */
> -int  dasd_ioctl(struct block_device *, fmode_t, unsigned int, unsigned long);
> +int dasd_ioctl(struct block_device *, fmode_t, unsigned int, unsigned long);
> +int dasd_set_read_only(struct block_device *bdev, bool ro);
>  
>  /* externals in dasd_proc.c */
>  int dasd_proc_init(void);
> diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
> index cb6427fb9f3d16..3359559517bfcf 100644
> --- a/drivers/s390/block/dasd_ioctl.c
> +++ b/drivers/s390/block/dasd_ioctl.c
> @@ -532,28 +532,22 @@ static int dasd_ioctl_information(struct dasd_block *block, void __user *argp,
>  /*
>   * Set read only
>   */
> -static int
> -dasd_ioctl_set_ro(struct block_device *bdev, void __user *argp)
> +int dasd_set_read_only(struct block_device *bdev, bool ro)
>  {
>  	struct dasd_device *base;
> -	int intval, rc;
> +	int rc;
>  
> -	if (!capable(CAP_SYS_ADMIN))
> -		return -EACCES;
> +	/* do not manipulate hardware state for partitions */
>  	if (bdev_is_partition(bdev))
> -		// ro setting is not allowed for partitions
> -		return -EINVAL;
> -	if (get_user(intval, (int __user *)argp))
> -		return -EFAULT;
> +		return 0;
> +
>  	base = dasd_device_from_gendisk(bdev->bd_disk);
>  	if (!base)
>  		return -ENODEV;
> -	if (!intval && test_bit(DASD_FLAG_DEVICE_RO, &base->flags)) {
> -		dasd_put_device(base);
> -		return -EROFS;
> -	}
> -	set_disk_ro(bdev->bd_disk, intval);


While testing this patch I just noticed that when I set a device readonly this is
not going to be passed on to the partitions on this device any longer.

This is caused by the removed call to set_disk_ro().

Is this intentional or was this removed by accident?

> -	rc = dasd_set_feature(base->cdev, DASD_FEATURE_READONLY, intval);
> +	if (!ro && test_bit(DASD_FLAG_DEVICE_RO, &base->flags))
> +		rc = -EROFS;
> +	else
> +		rc = dasd_set_feature(base->cdev, DASD_FEATURE_READONLY, ro);
>  	dasd_put_device(base);
>  	return rc;
>  }
> @@ -633,9 +627,6 @@ int dasd_ioctl(struct block_device *bdev, fmode_t mode,
>  	case BIODASDPRRST:
>  		rc = dasd_ioctl_reset_profile(block);
>  		break;
> -	case BLKROSET:
> -		rc = dasd_ioctl_set_ro(bdev, argp);
> -		break;
>  	case DASDAPIVER:
>  		rc = dasd_ioctl_api_version(argp);
>  		break;
> -- 
> 2.28.0
> 
