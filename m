Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15948 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728383AbgJGNOU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Oct 2020 09:14:20 -0400
Subject: Re: [PATCH] partitions/ibm: fix non-DASD devices
References: <20201007124009.1438269-1-hch@lst.de>
From: Stefan Haberland <sth@linux.ibm.com>
Message-ID: <60f3e36f-5c78-186b-870b-0b919bc22073@linux.ibm.com>
Date: Wed, 7 Oct 2020 15:14:11 +0200
MIME-Version: 1.0
In-Reply-To: <20201007124009.1438269-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>

thanks for the quick fix

Reviewed-by: Stefan Haberland <sth@linux.ibm.com>


Am 07.10.20 um 14:40 schrieb Christoph Hellwig:
> Don't error out if the dasd_biodasdinfo symbol is not available.
>
> Fixes: 26d7e28e3820 ("s390/dasd: remove ioctl_by_bdev calls")
> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  block/partitions/ibm.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/block/partitions/ibm.c b/block/partitions/ibm.c
> index d6e18df9c53c6d..4b044e620d3534 100644
> --- a/block/partitions/ibm.c
> +++ b/block/partitions/ibm.c
> @@ -305,8 +305,6 @@ int ibm_partition(struct parsed_partitions *state)
>  	if (!disk->fops->getgeo)
>  		goto out_exit;
>  	fn = symbol_get(dasd_biodasdinfo);
> -	if (!fn)
> -		goto out_exit;
>  	blocksize = bdev_logical_block_size(bdev);
>  	if (blocksize <= 0)
>  		goto out_symbol;
> @@ -326,7 +324,7 @@ int ibm_partition(struct parsed_partitions *state)
>  	geo->start = get_start_sect(bdev);
>  	if (disk->fops->getgeo(bdev, geo))
>  		goto out_freeall;
> -	if (fn(disk, info)) {
> +	if (!fn || fn(disk, info)) {
>  		kfree(info);
>  		info = NULL;
>  	}
> @@ -370,7 +368,8 @@ int ibm_partition(struct parsed_partitions *state)
>  out_nogeo:
>  	kfree(info);
>  out_symbol:
> -	symbol_put(dasd_biodasdinfo);
> +	if (fn)
> +		symbol_put(dasd_biodasdinfo);
>  out_exit:
>  	return res;
>  }
