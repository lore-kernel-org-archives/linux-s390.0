Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47044 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728830AbgDQK3S (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 17 Apr 2020 06:29:18 -0400
Date: Fri, 17 Apr 2020 12:29:07 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 2/8] vfio-ccw: Register a chp_event callback for
 vfio-ccw
Message-ID: <20200417122907.034c8508.cohuck@redhat.com>
In-Reply-To: <20200417023001.65006-3-farman@linux.ibm.com>
References: <20200417023001.65006-1-farman@linux.ibm.com>
        <20200417023001.65006-3-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>

On Fri, 17 Apr 2020 04:29:55 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> From: Farhan Ali <alifm@linux.ibm.com>
> 
> Register the chp_event callback to receive channel path related
> events for the subchannels managed by vfio-ccw.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
> 
> Notes:
>     v2->v3:
>      - Add a call to cio_cancel_halt_clear() for CHP_VARY_OFF [CH]
>     
>     v1->v2:
>      - Move s390dbf before cio_update_schib() call [CH]
>     
>     v0->v1: [EF]
>      - Add s390dbf trace
> 
>  drivers/s390/cio/vfio_ccw_drv.c | 45 +++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> index 8715c1c2f1e1..e48967c475e7 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -19,6 +19,7 @@
>  
>  #include <asm/isc.h>
>  
> +#include "chp.h"
>  #include "ioasm.h"
>  #include "css.h"
>  #include "vfio_ccw_private.h"
> @@ -262,6 +263,49 @@ static int vfio_ccw_sch_event(struct subchannel *sch, int process)
>  	return rc;
>  }
>  
> +static int vfio_ccw_chp_event(struct subchannel *sch,
> +			      struct chp_link *link, int event)
> +{
> +	struct vfio_ccw_private *private = dev_get_drvdata(&sch->dev);
> +	int mask = chp_ssd_get_mask(&sch->ssd_info, link);
> +	int retry = 255;
> +
> +	if (!private || !mask)
> +		return 0;
> +
> +	VFIO_CCW_MSG_EVENT(2, "%pUl (%x.%x.%04x): mask=0x%x event=%d\n",
> +			   mdev_uuid(private->mdev), sch->schid.cssid,
> +			   sch->schid.ssid, sch->schid.sch_no,
> +			   mask, event);
> +
> +	if (cio_update_schib(sch))
> +		return -ENODEV;
> +
> +	switch (event) {
> +	case CHP_VARY_OFF:
> +		/* Path logically turned off */
> +		sch->opm &= ~mask;
> +		sch->lpm &= ~mask;
> +		cio_cancel_halt_clear(sch, &retry);
> +		break;
> +	case CHP_OFFLINE:
> +		/* Path is gone */
> +		cio_cancel_halt_clear(sch, &retry);

Looking at this again: While calling the same function for both
CHP_VARY_OFF and CHP_OFFLINE is the right thing to do,
cio_cancel_halt_clear() is probably not that function. I don't think we
want to terminate an I/O that does not use the affected path.

Looking at what the normal I/O subchannel driver does, it first checks
for the lpum and does not do anything if the affected path does not
show up there. Following down the git history rabbit hole, that basic
check (surviving several reworks) precedes the first git import, so
there's unfortunately no patch description explaining that. Looking at
the PoP, I cannot find a whole lot of details... I think some of the
path-handling stuff is explained in non-public documentation, and
whoever wrote the original code (probably me) relied on the information
there.

tl;dr: We probably should check the lpum here as well.

> +		break;
> +	case CHP_VARY_ON:
> +		/* Path logically turned on */
> +		sch->opm |= mask;
> +		sch->lpm |= mask;
> +		break;
> +	case CHP_ONLINE:
> +		/* Path became available */
> +		sch->lpm |= mask & sch->opm;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
>  static struct css_device_id vfio_ccw_sch_ids[] = {
>  	{ .match_flags = 0x1, .type = SUBCHANNEL_TYPE_IO, },
>  	{ /* end of list */ },
> @@ -279,6 +323,7 @@ static struct css_driver vfio_ccw_sch_driver = {
>  	.remove = vfio_ccw_sch_remove,
>  	.shutdown = vfio_ccw_sch_shutdown,
>  	.sch_event = vfio_ccw_sch_event,
> +	.chp_event = vfio_ccw_chp_event,
>  };
>  
>  static int __init vfio_ccw_debug_init(void)
