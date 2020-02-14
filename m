Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31778 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729156AbgBNML6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 14 Feb 2020 07:11:58 -0500
Date: Fri, 14 Feb 2020 13:11:47 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH v2 2/9] vfio-ccw: Register a chp_event callback for
 vfio-ccw
Message-ID: <20200214131147.0a98dd7d.cohuck@redhat.com>
In-Reply-To: <20200206213825.11444-3-farman@linux.ibm.com>
References: <20200206213825.11444-1-farman@linux.ibm.com>
        <20200206213825.11444-3-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Thu,  6 Feb 2020 22:38:18 +0100
Eric Farman <farman@linux.ibm.com> wrote:

> From: Farhan Ali <alifm@linux.ibm.com>
> 
> Register the chp_event callback to receive channel path related
> events for the subchannels managed by vfio-ccw.

I'm wondering how useful this patch would be on its own.

> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
> 
> Notes:
>     v1->v2:
>      - Move s390dbf before cio_update_schib() call [CH]
>     
>     v0->v1: [EF]
>      - Add s390dbf trace
> 
>  drivers/s390/cio/vfio_ccw_drv.c | 44 +++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
(...)
> @@ -257,6 +258,48 @@ static int vfio_ccw_sch_event(struct subchannel *sch, int process)
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
> +		break;
> +	case CHP_OFFLINE:
> +		/* Path is gone */
> +		cio_cancel_halt_clear(sch, &retry);

Any reason you do this only for CHP_OFFLINE and not for CHP_VARY_OFF?

> +		break;
> +	case CHP_VARY_ON:
> +		/* Path logically turned on */
> +		sch->opm |= mask;
> +		sch->lpm |= mask;
> +		break;
> +	case CHP_ONLINE:
> +		/* Path became available */
> +		sch->lpm |= mask & sch->opm;

If I'm not mistaken, this patch introduces the first usage of sch->opm
in the vfio-ccw code. Are we missing something? Or am I missing
something? :)

> +		break;
> +	}
> +
> +	return 0;
> +}
> +
>  static struct css_device_id vfio_ccw_sch_ids[] = {
>  	{ .match_flags = 0x1, .type = SUBCHANNEL_TYPE_IO, },
>  	{ /* end of list */ },
(...)
