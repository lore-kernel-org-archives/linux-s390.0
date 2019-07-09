Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58916 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfGIKQS (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 9 Jul 2019 06:16:18 -0400
Date: Tue, 9 Jul 2019 12:16:13 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC v2 4/5] vfio-ccw: Don't call cp_free if we are processing
 a channel program
Message-ID: <20190709121613.6a3554fa.cohuck@redhat.com>
In-Reply-To: <1405df8415d3bff446c22753d0e9b91ff246eb0f.1562616169.git.alifm@linux.ibm.com>
References: <cover.1562616169.git.alifm@linux.ibm.com>
        <1405df8415d3bff446c22753d0e9b91ff246eb0f.1562616169.git.alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: farman@linux.ibm.com, pasic@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Mon,  8 Jul 2019 16:10:37 -0400
Farhan Ali <alifm@linux.ibm.com> wrote:

> There is a small window where it's possible that we could be working
> on an interrupt (queued in the workqueue) and setting up a channel
> program (i.e allocating memory, pinning pages, translating address).
> This can lead to allocating and freeing the channel program at the
> same time and can cause memory corruption.
> 
> Let's not call cp_free if we are currently processing a channel program.
> The only way we know for sure that we don't have a thread setting
> up a channel program is when the state is set to VFIO_CCW_STATE_CP_PENDING.

Can we pinpoint a commit that introduced this bug, or has it been there
since the beginning?

> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
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

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
