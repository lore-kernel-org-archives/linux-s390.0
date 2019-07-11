Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9268 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728405AbfGKUab (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 11 Jul 2019 16:30:31 -0400
Subject: Re: [PATCH v3 1/5] vfio-ccw: Fix misleading comment when setting
 orb.cmd.c64
References: <cover.1562854091.git.alifm@linux.ibm.com>
 <f68636106aef0faeb6ce9712584d102d1b315ff8.1562854091.git.alifm@linux.ibm.com>
From: Eric Farman <farman@linux.ibm.com>
Message-ID: <831c9495-78b7-b03c-1942-d16236d1e518@linux.ibm.com>
Date: Thu, 11 Jul 2019 16:30:26 -0400
MIME-Version: 1.0
In-Reply-To: <f68636106aef0faeb6ce9712584d102d1b315ff8.1562854091.git.alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>, cohuck@redhat.com, pasic@linux.ibm.com
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org



On 7/11/19 10:28 AM, Farhan Ali wrote:
> The comment is misleading because it tells us that
> we should set orb.cmd.c64 before calling ccwchain_calc_length,
> otherwise the function ccwchain_calc_length would return an
> error. This is not completely accurate.
> 
> We want to allow an orb without cmd.c64, and this is fine
> as long as the channel program does not use IDALs. But we do
> want to reject any channel program that uses IDALs and does
> not set the flag, which is what we do in ccwchain_calc_length.
> 
> After we have done the ccw processing, we need to set cmd.c64,
> as we use IDALs for all translated channel programs.
> 
> Also for better code readability let's move the setting of
> cmd.c64 within the non error path.
> 

Per Conny in v2:

Fixes: fb9e7880af35 ("vfio: ccw: push down unsupported IDA check")

> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Reviewed-by: Eric Farman <farman@linux.ibm.com>

> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index d6a8dff..c969d48 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -645,14 +645,15 @@ int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
>  	if (ret)
>  		cp_free(cp);
>  
> -	/* It is safe to force: if not set but idals used
> -	 * ccwchain_calc_length returns an error.
> -	 */
> -	cp->orb.cmd.c64 = 1;
> -
> -	if (!ret)
> +	if (!ret) {
>  		cp->initialized = true;
>  
> +		/* It is safe to force: if it was not set but idals used
> +		 * ccwchain_calc_length would have returned an error.
> +		 */
> +		cp->orb.cmd.c64 = 1;
> +	}
> +
>  	return ret;
>  }
>  
> 
