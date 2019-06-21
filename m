Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63302 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725985AbfFUOAv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Jun 2019 10:00:51 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5LE0Vdf015471
        for <linux-s390@vger.kernel.org>; Fri, 21 Jun 2019 10:00:50 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t8xamphuk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 21 Jun 2019 10:00:46 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Fri, 21 Jun 2019 15:00:39 +0100
Date: Fri, 21 Jun 2019 16:00:32 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC v1 1/1] vfio-ccw: Don't call cp_free if we are processing
 a channel program
In-Reply-To: <46dc0cbdcb8a414d70b7807fceb1cca6229408d5.1561055076.git.alifm@linux.ibm.com>
References: <cover.1561055076.git.alifm@linux.ibm.com>
        <46dc0cbdcb8a414d70b7807fceb1cca6229408d5.1561055076.git.alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Message-Id: <20190621160032.1bd0c15f.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: cohuck@redhat.com, farman@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Thu, 20 Jun 2019 17:07:09 -0400
Farhan Ali <alifm@linux.ibm.com> wrote:

> There is a small window where it's possible that an interrupt can
> arrive and can call cp_free, while we are still processing a channel
> program (i.e allocating memory, pinnging pages, translating
> addresses etc). This can lead to allocating and freeing at the same
> time and can cause memory corruption.
> 
> Let's not call cp_free if we are currently processing a channel program.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
> 
> I have been running my test overnight with this patch and I haven't
> seen the stack traces that I mentioned about earlier. I would like
> to get some reviews on this and also if this is the right thing to
> do?
> 
> Thanks
> Farhan
> 
>  drivers/s390/cio/vfio_ccw_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> index 66a66ac..61ece3f 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -88,7 +88,7 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
>  		     (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT));
>  	if (scsw_is_solicited(&irb->scsw)) {
>  		cp_update_scsw(&private->cp, &irb->scsw);
> -		if (is_final)
> +		if (is_final && private->state != VFIO_CCW_STATE_CP_PROCESSING)

How is access to private->state correctly synchronized? And don't we
expect private->state == VFIO_CCW_STATE_CP_PENDING in case the cp was
submitted successfully with a ssch() and is done now (one way or the
other)?

Does this have something to do with 71189f2 "vfio-ccw: make it safe to
access channel programs" (Cornelia Huck, 2019-01-21)?

Regards,
Halil

>  			cp_free(&private->cp);
>  	}
>  	mutex_lock(&private->io_mutex);
