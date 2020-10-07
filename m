Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8012 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728260AbgJGMYC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Oct 2020 08:24:02 -0400
Subject: Re: [PATCH v4 2/2] s390/dasd: remove ioctl_by_bdev calls
References: <20200519142259.102279-1-sth@linux.ibm.com>
 <20200519142259.102279-3-sth@linux.ibm.com>
 <5c815b8a-7d77-5c69-9191-d09cc433f5ff@de.ibm.com>
 <20201007103936.GA24327@lst.de>
 <ca1bad1e-6d4b-7e86-4a98-b9ba12e2bef2@de.ibm.com>
 <20201007120005.GA29788@lst.de>
 <e1e4afa1-faa2-aa19-a973-ee1286288802@de.ibm.com>
 <20201007121403.GA30795@lst.de>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <57c35578-fb46-92f0-c1b8-9a3ee1a9e7ae@de.ibm.com>
Date: Wed, 7 Oct 2020 14:23:52 +0200
MIME-Version: 1.0
In-Reply-To: <20201007121403.GA30795@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Stefan Haberland <sth@linux.ibm.com>, axboe@kernel.dk, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, linux-kernel@vger.kernel.org



On 07.10.20 14:14, Christoph Hellwig wrote:
> On Wed, Oct 07, 2020 at 02:09:18PM +0200, Christian Borntraeger wrote:
>> Unfortunately not. On insmodding virtio_blk I do get:
> 
> Yeah, the symbol_put needs to be conditional as well.  New version below:

Yes, this works.
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
> 
