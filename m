Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45810 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbfFDGDl (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 4 Jun 2019 02:03:41 -0400
Date: Tue, 4 Jun 2019 08:03:36 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v1 1/1] vfio-ccw: Destroy kmem cache region on module
 exit
Message-ID: <20190604080336.3b56c6d2.cohuck@redhat.com>
In-Reply-To: <c0f39039d28af39ea2939391bf005e3495d890fd.1559576250.git.alifm@linux.ibm.com>
References: <cover.1559576250.git.alifm@linux.ibm.com>
        <c0f39039d28af39ea2939391bf005e3495d890fd.1559576250.git.alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, farman@linux.ibm.com, pasic@linux.ibm.com

On Mon,  3 Jun 2019 11:42:47 -0400
Farhan Ali <alifm@linux.ibm.com> wrote:

> Free the vfio_ccw_cmd_region on module exit.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
> 
> I guess I missed this earlier while reviewing, but should'nt 
> we destroy the vfio_ccw_cmd_region on module exit, as well?
> 
>  drivers/s390/cio/vfio_ccw_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> index 66a66ac..9cee9f2 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -299,6 +299,7 @@ static void __exit vfio_ccw_sch_exit(void)
>  	css_driver_unregister(&vfio_ccw_sch_driver);
>  	isc_unregister(VFIO_CCW_ISC);
>  	kmem_cache_destroy(vfio_ccw_io_region);
> +	kmem_cache_destroy(vfio_ccw_cmd_region);
>  	destroy_workqueue(vfio_ccw_work_q);
>  }
>  module_init(vfio_ccw_sch_init);

Yes, you're right. Will queue when the pull req has been processed.
