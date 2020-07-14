Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgGNUM3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Jul 2020 16:12:29 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF795C061794
        for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2020 13:12:29 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id p205so10141169iod.8
        for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2020 13:12:29 -0700 (PDT)
Subject: Re: [PATCH 1/2] s390/dasd: fix inability to use DASD with DIAG driver
References: <20200714200327.40927-1-sth@linux.ibm.com>
 <20200714200327.40927-2-sth@linux.ibm.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c368fa07-4a7d-3eae-6143-a2db298c204e@kernel.dk>
Date: Tue, 14 Jul 2020 14:12:27 -0600
MIME-Version: 1.0
In-Reply-To: <20200714200327.40927-2-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

On 7/14/20 2:03 PM, Stefan Haberland wrote:
> During initialization of the DASD DIAG driver a request is issued
> that has a bio structure that resides on the stack. With virtually
> mapped kernel stacks this bio address might be in virtual storage
> which is unsuitable for usage with the diag250 call.
> In this case the device can not be set online using the DIAG
> discipline and fails with -EOPNOTSUP.
> In the system journal the following error message is presented:
> 
> dasd: X.X.XXXX Setting the DASD online with discipline DIAG failed
> with rc=-95
> 
> Fix by allocating the bio structure instead of having it on the stack.
> 
> Fixes: ce3dc447493f ("s390: add support for virtually mapped kernel stacks")
> Cc: stable@vger.kernel.org #4.20
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
> Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> ---
>  drivers/s390/block/dasd_diag.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/s390/block/dasd_diag.c b/drivers/s390/block/dasd_diag.c
> index facb588d09e4..069d6b39cacf 100644
> --- a/drivers/s390/block/dasd_diag.c
> +++ b/drivers/s390/block/dasd_diag.c
> @@ -319,7 +319,7 @@ dasd_diag_check_device(struct dasd_device *device)
>  	struct dasd_diag_characteristics *rdc_data;
>  	struct vtoc_cms_label *label;
>  	struct dasd_block *block;
> -	struct dasd_diag_bio bio;
> +	struct dasd_diag_bio *bio;
>  	unsigned int sb, bsize;
>  	blocknum_t end_block;
>  	int rc;
> @@ -395,29 +395,36 @@ dasd_diag_check_device(struct dasd_device *device)
>  		rc = -ENOMEM;
>  		goto out;
>  	}
> +	bio = kzalloc(sizeof(*bio), GFP_KERNEL);
> +	if (bio == NULL)  {
> +		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
> +			      "No memory to allocate initialization bio");
> +		rc = -ENOMEM;
> +		goto out_label;
> +	}

Just curious, any reason this isn't just using bio_alloc()?

-- 
Jens Axboe
