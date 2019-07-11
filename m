Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34906 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728855AbfGKUaj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 11 Jul 2019 16:30:39 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6BKQuug036681
        for <linux-s390@vger.kernel.org>; Thu, 11 Jul 2019 16:30:38 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tp90d7ekd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 11 Jul 2019 16:30:37 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <farman@linux.ibm.com>;
        Thu, 11 Jul 2019 21:30:37 +0100
Subject: Re: [PATCH v3 2/5] vfio-ccw: Fix memory leak and don't call cp_free
 in cp_init
References: <cover.1562854091.git.alifm@linux.ibm.com>
 <3173c4216f4555d9765eb6e4922534982bc820e4.1562854091.git.alifm@linux.ibm.com>
From: Eric Farman <farman@linux.ibm.com>
Date: Thu, 11 Jul 2019 16:30:33 -0400
MIME-Version: 1.0
In-Reply-To: <3173c4216f4555d9765eb6e4922534982bc820e4.1562854091.git.alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <acb17242-2743-3a6e-f9e3-d1b86b4f39c7@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>, cohuck@redhat.com, pasic@linux.ibm.com
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org



On 7/11/19 10:28 AM, Farhan Ali wrote:
> We don't set cp->initialized to true so calling cp_free
> will just return and not do anything.
> 
> Also fix a memory leak where we fail to free a ccwchain
> on an error.
> 
> Fixes: 812271b910 ("s390/cio: Squash cp_free() and cp_unpin_free()")
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Reviewed-by: Eric Farman <farman@linux.ibm.com>

> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index c969d48..f862d5d 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -421,7 +421,7 @@ static int ccwchain_loop_tic(struct ccwchain *chain,
>  static int ccwchain_handle_ccw(u32 cda, struct channel_program *cp)
>  {
>  	struct ccwchain *chain;
> -	int len;
> +	int len, ret;
>  
>  	/* Copy 2K (the most we support today) of possible CCWs */
>  	len = copy_from_iova(cp->mdev, cp->guest_cp, cda,
> @@ -448,7 +448,12 @@ static int ccwchain_handle_ccw(u32 cda, struct channel_program *cp)
>  	memcpy(chain->ch_ccw, cp->guest_cp, len * sizeof(struct ccw1));
>  
>  	/* Loop for tics on this new chain. */
> -	return ccwchain_loop_tic(chain, cp);
> +	ret = ccwchain_loop_tic(chain, cp);
> +
> +	if (ret)
> +		ccwchain_free(chain);
> +
> +	return ret;
>  }
>  
>  /* Loop for TICs. */
> @@ -642,8 +647,6 @@ int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
>  
>  	/* Build a ccwchain for the first CCW segment */
>  	ret = ccwchain_handle_ccw(orb->cmd.cpa, cp);
> -	if (ret)
> -		cp_free(cp);
>  
>  	if (!ret) {
>  		cp->initialized = true;
> 
