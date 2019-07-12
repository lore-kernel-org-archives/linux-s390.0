Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1540 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727557AbfGLNYA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 12 Jul 2019 09:24:00 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6CDDNR6047360
        for <linux-s390@vger.kernel.org>; Fri, 12 Jul 2019 09:23:57 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tps3cd3ke-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 12 Jul 2019 09:23:57 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <farman@linux.ibm.com>;
        Fri, 12 Jul 2019 14:23:56 +0100
Subject: Re: [PATCH v3 4/5] vfio-ccw: Don't call cp_free if we are processing
 a channel program
References: <cover.1562854091.git.alifm@linux.ibm.com>
 <62e87bf67b38dc8d5760586e7c96d400db854ebe.1562854091.git.alifm@linux.ibm.com>
From: Eric Farman <farman@linux.ibm.com>
Date: Fri, 12 Jul 2019 09:19:38 -0400
MIME-Version: 1.0
In-Reply-To: <62e87bf67b38dc8d5760586e7c96d400db854ebe.1562854091.git.alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <32c1c941-2971-f956-c532-b606336ea74b@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>, cohuck@redhat.com, pasic@linux.ibm.com
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org



On 7/11/19 10:28 AM, Farhan Ali wrote:
> There is a small window where it's possible that we could be working
> on an interrupt (queued in the workqueue) and setting up a channel
> program (i.e allocating memory, pinning pages, translating address).
> This can lead to allocating and freeing the channel program at the
> same time and can cause memory corruption.
> 
> Let's not call cp_free if we are currently processing a channel program.
> The only way we know for sure that we don't have a thread setting
> up a channel program is when the state is set to VFIO_CCW_STATE_CP_PENDING.>
> Fixes: d5afd5d135c8 ("vfio-ccw: add handling for async channel instructions")
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

I think this seems like a reasonable fix.

Reviewed-by: Eric Farman <farman@linux.ibm.com>

> ---
>  drivers/s390/cio/vfio_ccw_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> index 4e3a903..0357165 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -92,7 +92,7 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
>  		     (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT));
>  	if (scsw_is_solicited(&irb->scsw)) {
>  		cp_update_scsw(&private->cp, &irb->scsw);
> -		if (is_final)
> +		if (is_final && private->state == VFIO_CCW_STATE_CP_PENDING)
>  			cp_free(&private->cp);
>  	}
>  	mutex_lock(&private->io_mutex);
> 
