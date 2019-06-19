Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6850 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726175AbfFSVNo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 Jun 2019 17:13:44 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5JLCflo037055
        for <linux-s390@vger.kernel.org>; Wed, 19 Jun 2019 17:13:43 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t7ty7cbnn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 19 Jun 2019 17:13:43 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <alifm@linux.ibm.com>;
        Wed, 19 Jun 2019 22:13:42 +0100
Subject: Re: [RFC PATCH v1 5/5] vfio-ccw: Remove copy_ccw_from_iova()
References: <20190618202352.39702-1-farman@linux.ibm.com>
 <20190618202352.39702-6-farman@linux.ibm.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Wed, 19 Jun 2019 17:13:39 -0400
MIME-Version: 1.0
In-Reply-To: <20190618202352.39702-6-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <98b91731-e503-03af-a7d6-5dcc9bcbf4ae@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org



On 06/18/2019 04:23 PM, Eric Farman wrote:
> Just to keep things tidy.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>   drivers/s390/cio/vfio_ccw_cp.c | 14 ++------------
>   1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index 9a8bf06281e0..9cddc1288059 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -228,17 +228,6 @@ static long copy_from_iova(struct device *mdev,
>   	return l;
>   }
>   
> -static long copy_ccw_from_iova(struct channel_program *cp,
> -			       struct ccw1 *to, u64 iova,
> -			       unsigned long len)
> -{
> -	int ret;
> -
> -	ret = copy_from_iova(cp->mdev, to, iova, len * sizeof(struct ccw1));
> -
> -	return ret;
> -}
> -
>   /*
>    * Helpers to operate ccwchain.
>    */
> @@ -435,7 +424,8 @@ static int ccwchain_handle_ccw(u32 cda, struct channel_program *cp)
>   	int len;
>   
>   	/* Copy 2K (the most we support today) of possible CCWs */
> -	len = copy_ccw_from_iova(cp, cp->guest_cp, cda, CCWCHAIN_LEN_MAX);
> +	len = copy_from_iova(cp->mdev, cp->guest_cp, cda,
> +			     CCWCHAIN_LEN_MAX * sizeof(struct ccw1));
>   	if (len)
>   		return len;
>   
> 

This patch probably could be squashed with patch 4. Not a big deal though.
