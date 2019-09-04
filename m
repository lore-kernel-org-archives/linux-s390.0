Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10116 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729798AbfIDN7M (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 4 Sep 2019 09:59:12 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x84Dx6ce106146
        for <linux-s390@vger.kernel.org>; Wed, 4 Sep 2019 09:59:11 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2utdruaj76-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 04 Sep 2019 09:59:08 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 4 Sep 2019 14:58:07 +0100
Subject: Re: [PATCH -next] vfio-ccw: fix error return code in
 vfio_ccw_sch_init()
References: <20190904083315.105600-1-weiyongjun1@huawei.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 4 Sep 2019 15:58:03 +0200
MIME-Version: 1.0
In-Reply-To: <20190904083315.105600-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <1ceef8c5-f5c1-79e5-7442-beb38b94f6f6@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Wei Yongjun <weiyongjun1@huawei.com>, Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, kernel-janitors@vger.kernel.org



On 04.09.19 10:33, Wei Yongjun wrote:
> Fix to return negative error code -ENOMEM from the memory alloc failed
> error handling case instead of 0, as done elsewhere in this function.
> 
> Fixes: 60e05d1cf087 ("vfio-ccw: add some logging")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

thanks applied to s390 tree. 

> ---
>  drivers/s390/cio/vfio_ccw_drv.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> index 45e792f6afd0..e401a3d0aa57 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -317,15 +317,19 @@ static int __init vfio_ccw_sch_init(void)
>  					sizeof(struct ccw_io_region), 0,
>  					SLAB_ACCOUNT, 0,
>  					sizeof(struct ccw_io_region), NULL);
> -	if (!vfio_ccw_io_region)
> +	if (!vfio_ccw_io_region) {
> +		ret = -ENOMEM;
>  		goto out_err;
> +	}
>  
>  	vfio_ccw_cmd_region = kmem_cache_create_usercopy("vfio_ccw_cmd_region",
>  					sizeof(struct ccw_cmd_region), 0,
>  					SLAB_ACCOUNT, 0,
>  					sizeof(struct ccw_cmd_region), NULL);
> -	if (!vfio_ccw_cmd_region)
> +	if (!vfio_ccw_cmd_region) {
> +		ret = -ENOMEM;
>  		goto out_err;
> +	}
>  
>  	isc_register(VFIO_CCW_ISC);
>  	ret = css_driver_register(&vfio_ccw_sch_driver);
> 
> 
> 
