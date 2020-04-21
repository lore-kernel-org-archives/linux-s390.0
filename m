Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32961 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726403AbgDUMGw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Apr 2020 08:06:52 -0400
Date: Tue, 21 Apr 2020 14:06:40 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 7/8] vfio-ccw: Wire up the CRW irq and CRW region
Message-ID: <20200421140640.6f46e8c3.cohuck@redhat.com>
In-Reply-To: <20200417023001.65006-8-farman@linux.ibm.com>
References: <20200417023001.65006-1-farman@linux.ibm.com>
        <20200417023001.65006-8-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>

On Fri, 17 Apr 2020 04:30:00 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> From: Farhan Ali <alifm@linux.ibm.com>
> 
> Use an IRQ to notify userspace that there is a CRW
> pending in the region, related to path-availability
> changes on the passthrough subchannel.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
> 
> Notes:
>     v2->v3:
>      - Refactor vfio_ccw_alloc_crw() to accept rsc, erc, and rsid fields
>        of a CRW as input [CH]
>      - Copy the right amount of CRWs to the crw_region [EF]
>      - Use sizeof(target) for the memcpy, rather than sizeof(source) [EF]
>      - Ensure the CRW region is empty if no CRW is present [EF/CH]
>      - Refactor how data goes from private-to-region-to-user [CH]
>      - Reduce the number of CRWs from two to one [CH]
>      - s/vc_crw/crw/ [EF]
>     
>     v1->v2:
>      - Remove extraneous 0x0 in crw.rsid assignment [CH]
>      - Refactor the building/queueing of a crw into its own routine [EF]
>     
>     v0->v1: [EF]
>      - Place the non-refactoring changes from the previous patch here
>      - Clean up checkpatch (whitespace) errors
>      - s/chp_crw/crw/
>      - Move acquire/release of io_mutex in vfio_ccw_crw_region_read()
>        into patch that introduces that region
>      - Remove duplicate include from vfio_ccw_drv.c
>      - Reorder include in vfio_ccw_private.h
> 
>  drivers/s390/cio/vfio_ccw_chp.c     | 19 +++++++++++
>  drivers/s390/cio/vfio_ccw_drv.c     | 49 +++++++++++++++++++++++++++++
>  drivers/s390/cio/vfio_ccw_ops.c     |  4 +++
>  drivers/s390/cio/vfio_ccw_private.h |  9 ++++++
>  include/uapi/linux/vfio.h           |  1 +
>  5 files changed, 82 insertions(+)
> 

(...)

> +static void vfio_ccw_alloc_crw(struct vfio_ccw_private *private,

Maybe vfio_ccw_queue_crw()? You do a bit more than allocating, and I
think allocating is already implied.

> +			       unsigned int rsc,
> +			       unsigned int erc,
> +			       unsigned int rsid)
> +{
> +	struct vfio_ccw_crw *crw;
> +
> +	/*
> +	 * If unable to allocate a CRW, just drop the event and
> +	 * carry on.  The guest will either see a later one or
> +	 * learn when it issues its own store subchannel.
> +	 */
> +	crw = kzalloc(sizeof(*crw), GFP_ATOMIC);
> +	if (!crw)
> +		return;

I suppose that's quite unlikely anyway, given how small the structure
is.

> +
> +	/*
> +	 * Build the CRW based on the inputs given to us.
> +	 */
> +	crw->crw.rsc = rsc;
> +	crw->crw.erc = erc;
> +	crw->crw.rsid = rsid;

We probably can add a chaining flag later, should we ever need it, as
this is an internal function anyway.

> +
> +	list_add_tail(&crw->next, &private->crw);
> +	queue_work(vfio_ccw_work_q, &private->crw_work);
> +}
> +
>  static int vfio_ccw_chp_event(struct subchannel *sch,
>  			      struct chp_link *link, int event)
>  {
> @@ -309,6 +354,8 @@ static int vfio_ccw_chp_event(struct subchannel *sch,
>  	case CHP_OFFLINE:
>  		/* Path is gone */
>  		cio_cancel_halt_clear(sch, &retry);
> +		vfio_ccw_alloc_crw(private, CRW_RSC_CPATH, CRW_ERC_PERRN,
> +				   (link->chpid.cssid << 8) | link->chpid.id);

Not sure that cssid stuff is correct: The QEMU code generating crws for
chpids chains a second crw for the cssid (if MCSS-E has been enabled by
the guest). The Linux kernel does not enable MCSS-E, so it will always
have a cssid of 0; but I'm wondering if we could conceivably put a
vfio-ccw device into a non-default css in the guest? Not terribly
useful (as Linux does not enable MCSS-E), but allowed, I think.

>  		break;
>  	case CHP_VARY_ON:
>  		/* Path logically turned on */
> @@ -318,6 +365,8 @@ static int vfio_ccw_chp_event(struct subchannel *sch,
>  	case CHP_ONLINE:
>  		/* Path became available */
>  		sch->lpm |= mask & sch->opm;
> +		vfio_ccw_alloc_crw(private, CRW_RSC_CPATH, CRW_ERC_INIT,
> +				   (link->chpid.cssid << 8) | link->chpid.id);
>  		break;
>  	}
>  

(...)
