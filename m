Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43832 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732367AbfFMN6h (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 13 Jun 2019 09:58:37 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5DDrgZ0107809
        for <linux-s390@vger.kernel.org>; Thu, 13 Jun 2019 09:58:36 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t3q91sxuy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 13 Jun 2019 09:58:35 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 13 Jun 2019 14:58:34 +0100
Date: Thu, 13 Jun 2019 15:58:27 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PULL 1/1] vfio-ccw: Destroy kmem cache region on module exit
References: <20190612101645.9439-1-cohuck@redhat.com>
 <20190612101645.9439-2-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612101645.9439-2-cohuck@redhat.com>
Message-Id: <20190613135827.GA30929@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Wed, Jun 12, 2019 at 12:16:45PM +0200, Cornelia Huck wrote:
> From: Farhan Ali <alifm@linux.ibm.com>
> 
> Free the vfio_ccw_cmd_region on module exit.
> 
> Fixes: d5afd5d135c8 ("vfio-ccw: add handling for async channel instructions")
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> Message-Id: <c0f39039d28af39ea2939391bf005e3495d890fd.1559576250.git.alifm@linux.ibm.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  drivers/s390/cio/vfio_ccw_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> index 66a66ac1f3d1..9cee9f20d310 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -299,6 +299,7 @@ static void __exit vfio_ccw_sch_exit(void)
>  	css_driver_unregister(&vfio_ccw_sch_driver);
>  	isc_unregister(VFIO_CCW_ISC);
>  	kmem_cache_destroy(vfio_ccw_io_region);
> +	kmem_cache_destroy(vfio_ccw_cmd_region);
>  	destroy_workqueue(vfio_ccw_work_q);

Applied to 'fixes' branch. Thanks!
