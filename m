Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62492 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726218AbgJGJe2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Oct 2020 05:34:28 -0400
Subject: Re: [PATCH v4 2/2] s390/dasd: remove ioctl_by_bdev calls
References: <20200519142259.102279-1-sth@linux.ibm.com>
 <20200519142259.102279-3-sth@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <5c815b8a-7d77-5c69-9191-d09cc433f5ff@de.ibm.com>
Date: Wed, 7 Oct 2020 11:34:17 +0200
In-Reply-To: <20200519142259.102279-3-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>, hch@lst.de
Cc: axboe@kernel.dk, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, linux-kernel@vger.kernel.org


On 19.05.20 16:22, Stefan Haberland wrote:
> The IBM partition parser requires device type specific information only
> available to the DASD driver to correctly register partitions. The
> current approach of using ioctl_by_bdev with a fake user space pointer
> is discouraged.
> 
> Fix this by replacing IOCTL calls with direct in-kernel function calls.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
> Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
> Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>

FWIW, this broken the ibm-partition code for virtio-blk, when CONFIG_DASD=m.

> ---
>  MAINTAINERS                     |  1 +
>  block/partitions/ibm.c          | 24 +++++++++++++++++------
>  drivers/s390/block/dasd_ioctl.c | 34 +++++++++++++++++++++++++++++++++
>  include/linux/dasd_mod.h        |  9 +++++++++
>  4 files changed, 62 insertions(+), 6 deletions(-)
>  create mode 100644 include/linux/dasd_mod.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1608ef8ce8d3..37f700187d74 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14625,6 +14625,7 @@ S:	Supported
>  W:	http://www.ibm.com/developerworks/linux/linux390/
>  F:	block/partitions/ibm.c
>  F:	drivers/s390/block/dasd*
> +F:	include/linux/dasd_mod.h
>  
>  S390 IOMMU (PCI)
>  M:	Gerald Schaefer <gerald.schaefer@de.ibm.com>
> diff --git a/block/partitions/ibm.c b/block/partitions/ibm.c
> index 073faa6a69b8..d6e18df9c53c 100644
> --- a/block/partitions/ibm.c
> +++ b/block/partitions/ibm.c
> @@ -13,10 +13,11 @@
>  #include <asm/ebcdic.h>
>  #include <linux/uaccess.h>
>  #include <asm/vtoc.h>
> +#include <linux/module.h>
> +#include <linux/dasd_mod.h>
>  
>  #include "check.h"
>  
> -
>  union label_t {
>  	struct vtoc_volume_label_cdl vol;
>  	struct vtoc_volume_label_ldl lnx;
> @@ -288,7 +289,9 @@ static int find_cms1_partitions(struct parsed_partitions *state,
>   */
>  int ibm_partition(struct parsed_partitions *state)
>  {
> +	int (*fn)(struct gendisk *disk, dasd_information2_t *info);
>  	struct block_device *bdev = state->bdev;
> +	struct gendisk *disk = bdev->bd_disk;
>  	int blocksize, res;
>  	loff_t i_size, offset, size;
>  	dasd_information2_t *info;
> @@ -299,24 +302,31 @@ int ibm_partition(struct parsed_partitions *state)
>  	union label_t *label;
>  
>  	res = 0;
> +	if (!disk->fops->getgeo)
> +		goto out_exit;
> +	fn = symbol_get(dasd_biodasdinfo);
> +	if (!fn)
> +		goto out_exit;
>  	blocksize = bdev_logical_block_size(bdev);
>  	if (blocksize <= 0)
> -		goto out_exit;
> +		goto out_symbol;
>  	i_size = i_size_read(bdev->bd_inode);
>  	if (i_size == 0)
> -		goto out_exit;
> +		goto out_symbol;
>  	info = kmalloc(sizeof(dasd_information2_t), GFP_KERNEL);
>  	if (info == NULL)
> -		goto out_exit;
> +		goto out_symbol;
>  	geo = kmalloc(sizeof(struct hd_geometry), GFP_KERNEL);
>  	if (geo == NULL)
>  		goto out_nogeo;
>  	label = kmalloc(sizeof(union label_t), GFP_KERNEL);
>  	if (label == NULL)
>  		goto out_nolab;
> -	if (ioctl_by_bdev(bdev, HDIO_GETGEO, (unsigned long)geo) != 0)
> +	/* set start if not filled by getgeo function e.g. virtblk */
> +	geo->start = get_start_sect(bdev);
> +	if (disk->fops->getgeo(bdev, geo))
>  		goto out_freeall;
> -	if (ioctl_by_bdev(bdev, BIODASDINFO2, (unsigned long)info) != 0) {
> +	if (fn(disk, info)) {
>  		kfree(info);
>  		info = NULL;
>  	}
> @@ -359,6 +369,8 @@ int ibm_partition(struct parsed_partitions *state)
>  	kfree(geo);
>  out_nogeo:
>  	kfree(info);
> +out_symbol:
> +	symbol_put(dasd_biodasdinfo);
>  out_exit:
>  	return res;
>  }
> diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
> index 9b7782395c37..777734d1b4e5 100644
> --- a/drivers/s390/block/dasd_ioctl.c
> +++ b/drivers/s390/block/dasd_ioctl.c
> @@ -22,6 +22,7 @@
>  #include <asm/schid.h>
>  #include <asm/cmb.h>
>  #include <linux/uaccess.h>
> +#include <linux/dasd_mod.h>
>  
>  /* This is ugly... */
>  #define PRINTK_HEADER "dasd_ioctl:"
> @@ -664,3 +665,36 @@ int dasd_ioctl(struct block_device *bdev, fmode_t mode,
>  	dasd_put_device(base);
>  	return rc;
>  }
> +
> +
> +/**
> + * dasd_biodasdinfo() - fill out the dasd information structure
> + * @disk [in]: pointer to gendisk structure that references a DASD
> + * @info [out]: pointer to the dasd_information2_t structure
> + *
> + * Provide access to DASD specific information.
> + * The gendisk structure is checked if it belongs to the DASD driver by
> + * comparing the gendisk->fops pointer.
> + * If it does not belong to the DASD driver -EINVAL is returned.
> + * Otherwise the provided dasd_information2_t structure is filled out.
> + *
> + * Returns:
> + *   %0 on success and a negative error value on failure.
> + */
> +int dasd_biodasdinfo(struct gendisk *disk, struct dasd_information2_t *info)
> +{
> +	struct dasd_device *base;
> +	int error;
> +
> +	if (disk->fops != &dasd_device_operations)
> +		return -EINVAL;
> +
> +	base = dasd_device_from_gendisk(disk);
> +	if (!base)
> +		return -ENODEV;
> +	error = __dasd_ioctl_information(base->block, info);
> +	dasd_put_device(base);
> +	return error;
> +}
> +/* export that symbol_get in partition detection is possible */
> +EXPORT_SYMBOL_GPL(dasd_biodasdinfo);
> diff --git a/include/linux/dasd_mod.h b/include/linux/dasd_mod.h
> new file mode 100644
> index 000000000000..d39abad2ff6e
> --- /dev/null
> +++ b/include/linux/dasd_mod.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef DASD_MOD_H
> +#define DASD_MOD_H
> +
> +#include <asm/dasd.h>
> +
> +extern int dasd_biodasdinfo(struct gendisk *disk, dasd_information2_t *info);
> +
> +#endif
> 
