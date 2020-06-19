Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24047 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731794AbgFSLkP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 19 Jun 2020 07:40:15 -0400
Date: Fri, 19 Jun 2020 13:40:05 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH v3 3/3] vfio-ccw: Check workqueue before doing START
Message-ID: <20200619134005.512fc54f.cohuck@redhat.com>
In-Reply-To: <20200616195053.99253-4-farman@linux.ibm.com>
References: <20200616195053.99253-1-farman@linux.ibm.com>
        <20200616195053.99253-4-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Jared Rossi <jrossi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Tue, 16 Jun 2020 21:50:53 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> When an interrupt is received via the IRQ, the bulk of the work is
> stacked on a workqueue for later processing. Which means that concurrent
> START or a HALT/CLEAR operation (via the async_region) will race with
> this process and require some serialization.
> 
> Once we have all our locks acquired, let's just look to see if we're
> in a window where the process has been started from the IRQ, but not
> yet picked up by vfio-ccw to clean up an I/O. If there is, mark the
> request as BUSY so it can be redriven after we have a chance to breathe.

This change looks reasonable to me. It would be even better if we could
send off I/O requests at any time; but if signaling to retry saves us
from some hairy code elsewhere, it is a good idea to do so.

> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_fsm.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
> index f0952192480e..9dc5b4d549b3 100644
> --- a/drivers/s390/cio/vfio_ccw_fsm.c
> +++ b/drivers/s390/cio/vfio_ccw_fsm.c
> @@ -28,6 +28,11 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
>  
>  	spin_lock_irqsave(sch->lock, flags);
>  
> +	if (work_pending(&private->io_work)) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
>  	orb = cp_get_orb(&private->cp, (u32)(addr_t)sch, sch->lpm);
>  	if (!orb) {
>  		ret = -EIO;
