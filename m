Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:53335 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727051AbgEHPxJ (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 8 May 2020 11:53:09 -0400
Date: Fri, 8 May 2020 17:53:06 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 2/3] block: add a s390-only biodasdinfo method
Message-ID: <20200508155306.GB4200@lst.de>
References: <20200508131455.55407-1-sth@linux.ibm.com> <20200508131455.55407-3-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508131455.55407-3-sth@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: hch@lst.de, axboe@kernel.dk, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, linux-kernel@vger.kernel.org, borntraeger@de.ibm.com

On Fri, May 08, 2020 at 03:14:54PM +0200, Stefan Haberland wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> The IBM partition parser needs to query the DASD driver for details that
> are very s390 specific.  Instead of using ioctl_by_bdev with a fake user
> space pointer just add a s390-specific method to get the information
> directly.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> [sth@linux.ibm.com: remove fop, add gendisk check, export funcion]
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>

The subject and changelog need updates for your changes.  I think you
should also claim authorship, even if a few bits are originally from me.
Probaby it would make sense to even just merge this into the next patch.

> index fa552f9f1666..6eac7b11c75b 100644
> --- a/drivers/s390/block/dasd_int.h
> +++ b/drivers/s390/block/dasd_int.h
> @@ -845,6 +845,7 @@ void dasd_destroy_partitions(struct dasd_block *);
>  
>  /* externals in dasd_ioctl.c */
>  int  dasd_ioctl(struct block_device *, fmode_t, unsigned int, unsigned long);
> +int dasd_biodasdinfo(struct gendisk *disk, struct dasd_information2_t *info);

I think this needs to go to a public include/linux/ header for the
partitioning code to share the prototype.

> +int dasd_biodasdinfo(struct gendisk *disk, struct dasd_information2_t *info)
> +{
> +	struct dasd_device *base;
> +	int error;
> +
> +	/*
> +	 * we might get called externaly, so check if the gendisk belongs
> +	 * to a DASD by checking the fops pointer
> +	 */
> +	if (disk->fops != &dasd_device_operations)
> +		return -EINVAL;

I think a function comment (e.g. kernel doc) explaining the use case and
this detail might be useful.
