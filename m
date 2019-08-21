Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40650 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727558AbfHUPye (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 21 Aug 2019 11:54:34 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7LFrVmV058770
        for <linux-s390@vger.kernel.org>; Wed, 21 Aug 2019 11:54:33 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uh61thdyv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 21 Aug 2019 11:54:32 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <farman@linux.ibm.com>;
        Wed, 21 Aug 2019 16:54:32 +0100
Subject: Re: [PATCH RFC 1/1] vfio-ccw: add some logging
References: <20190816151505.9853-1-cohuck@redhat.com>
 <20190816151505.9853-2-cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Date: Wed, 21 Aug 2019 11:54:26 -0400
MIME-Version: 1.0
In-Reply-To: <20190816151505.9853-2-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <81414605-c676-6e7e-4ee8-8dbfe7ae0a76@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org



On 8/16/19 11:15 AM, Cornelia Huck wrote:
> Usually, the common I/O layer logs various things into the s390
> cio debug feature, which has been very helpful in the past when
> looking at crash dumps. As vfio-ccw devices unbind from the
> standard I/O subchannel driver, we lose some information there.
> 
> Let's introduce some vfio-ccw debug features and log some things
> there. (Unfortunately we cannot reuse the cio debug feature from
> a module.)

Boo :(

> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  drivers/s390/cio/vfio_ccw_drv.c     | 50 ++++++++++++++++++++++++++--
>  drivers/s390/cio/vfio_ccw_fsm.c     | 51 ++++++++++++++++++++++++++++-
>  drivers/s390/cio/vfio_ccw_ops.c     | 10 ++++++
>  drivers/s390/cio/vfio_ccw_private.h | 17 ++++++++++
>  4 files changed, 124 insertions(+), 4 deletions(-)
> 

...snip...

> diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
> index 49d9d3da0282..4a1e727c62d9 100644
> --- a/drivers/s390/cio/vfio_ccw_fsm.c
> +++ b/drivers/s390/cio/vfio_ccw_fsm.c

...snip...

> @@ -239,18 +258,32 @@ static void fsm_io_request(struct vfio_ccw_private *private,
>  		/* Don't try to build a cp if transport mode is specified. */
>  		if (orb->tm.b) {
>  			io_region->ret_code = -EOPNOTSUPP;
> +			VFIO_CCW_MSG_EVENT(2,
> +					   "%pUl (%x.%x.%04x): transport mode\n",
> +					   mdev_uuid(mdev), schid.cssid,
> +					   schid.ssid, schid.sch_no);
>  			errstr = "transport mode";
>  			goto err_out;
>  		}
>  		io_region->ret_code = cp_init(&private->cp, mdev_dev(mdev),
>  					      orb);
>  		if (io_region->ret_code) {
> +			VFIO_CCW_MSG_EVENT(2,
> +					   "%pUl (%x.%x.%04x): cp_init=%d\n",
> +					   mdev_uuid(mdev), schid.cssid,
> +					   schid.ssid, schid.sch_no,
> +					   io_region->ret_code);
>  			errstr = "cp init";
>  			goto err_out;
>  		}
>  
>  		io_region->ret_code = cp_prefetch(&private->cp);
>  		if (io_region->ret_code) {
> +			VFIO_CCW_MSG_EVENT(2,
> +					   "%pUl (%x.%x.%04x): cp_prefetch=%d\n",
> +					   mdev_uuid(mdev), schid.cssid,
> +					   schid.ssid, schid.sch_no,
> +					   io_region->ret_code);
>  			errstr = "cp prefetch";
>  			cp_free(&private->cp);
>  			goto err_out;
> @@ -259,23 +292,36 @@ static void fsm_io_request(struct vfio_ccw_private *private,
>  		/* Start channel program and wait for I/O interrupt. */
>  		io_region->ret_code = fsm_io_helper(private);
>  		if (io_region->ret_code) {
> +			VFIO_CCW_MSG_EVENT(2,
> +					   "%pUl (%x.%x.%04x): fsm_io_helper=%d\n",
> +					   mdev_uuid(mdev), schid.cssid,
> +					   schid.ssid, schid.sch_no,
> +					   io_region->ret_code);

I suppose these ones could be squashed into err_out, and use errstr as
substitution for the message text.  But this is fine.

>  			errstr = "cp fsm_io_helper";
>  			cp_free(&private->cp);
>  			goto err_out;
>  		}
>  		return;
>  	} else if (scsw->cmd.fctl & SCSW_FCTL_HALT_FUNC) {
> +		VFIO_CCW_MSG_EVENT(2,
> +				   "%pUl (%x.%x.%04x): halt on io_region\n",
> +				   mdev_uuid(mdev), schid.cssid,
> +				   schid.ssid, schid.sch_no);
>  		/* halt is handled via the async cmd region */
>  		io_region->ret_code = -EOPNOTSUPP;
>  		goto err_out;
>  	} else if (scsw->cmd.fctl & SCSW_FCTL_CLEAR_FUNC) {
> +		VFIO_CCW_MSG_EVENT(2,
> +				   "%pUl (%x.%x.%04x): clear on io_region\n",
> +				   mdev_uuid(mdev), schid.cssid,
> +				   schid.ssid, schid.sch_no);

The above idea would need errstr to be set to something other than
"request" here, which maybe isn't a bad thing anyway.  :)

>  		/* clear is handled via the async cmd region */
>  		io_region->ret_code = -EOPNOTSUPP;
>  		goto err_out;
>  	}
>  
>  err_out:
> -	trace_vfio_ccw_io_fctl(scsw->cmd.fctl, get_schid(private),
> +	trace_vfio_ccw_io_fctl(scsw->cmd.fctl, schid,
>  			       io_region->ret_code, errstr);
>  }
>  
> @@ -308,6 +354,9 @@ static void fsm_irq(struct vfio_ccw_private *private,
>  {
>  	struct irb *irb = this_cpu_ptr(&cio_irb);
>  
> +	VFIO_CCW_TRACE_EVENT(6, "IRQ");
> +	VFIO_CCW_TRACE_EVENT(6, dev_name(&private->sch->dev));
> +
>  	memcpy(&private->irb, irb, sizeof(*irb));
>  
>  	queue_work(vfio_ccw_work_q, &private->io_work);
> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
> index 5eb61116ca6f..f0d71ab77c50 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> @@ -124,6 +124,11 @@ static int vfio_ccw_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
>  	private->mdev = mdev;
>  	private->state = VFIO_CCW_STATE_IDLE;
>  
> +	VFIO_CCW_MSG_EVENT(2, "mdev %pUl, sch %x.%x.%04x: create\n",
> +			   mdev_uuid(mdev), private->sch->schid.cssid,
> +			   private->sch->schid.ssid,
> +			   private->sch->schid.sch_no);
> +
>  	return 0;
>  }
>  
> @@ -132,6 +137,11 @@ static int vfio_ccw_mdev_remove(struct mdev_device *mdev)
>  	struct vfio_ccw_private *private =
>  		dev_get_drvdata(mdev_parent_dev(mdev));
>  
> +	VFIO_CCW_MSG_EVENT(2, "mdev %pUl, sch %x.%x.%04x: remove\n",
> +			   mdev_uuid(mdev), private->sch->schid.cssid,
> +			   private->sch->schid.ssid,
> +			   private->sch->schid.sch_no);
> +
>  	if ((private->state != VFIO_CCW_STATE_NOT_OPER) &&
>  	    (private->state != VFIO_CCW_STATE_STANDBY)) {
>  		if (!vfio_ccw_sch_quiesce(private->sch))
> diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
> index f1092c3dc1b1..bbe9babf767b 100644
> --- a/drivers/s390/cio/vfio_ccw_private.h
> +++ b/drivers/s390/cio/vfio_ccw_private.h
> @@ -17,6 +17,7 @@
>  #include <linux/eventfd.h>
>  #include <linux/workqueue.h>
>  #include <linux/vfio_ccw.h>
> +#include <asm/debug.h>
>  
>  #include "css.h"
>  #include "vfio_ccw_cp.h"
> @@ -139,4 +140,20 @@ static inline void vfio_ccw_fsm_event(struct vfio_ccw_private *private,
>  
>  extern struct workqueue_struct *vfio_ccw_work_q;
>  
> +
> +/* s390 debug feature, similar to base cio */
> +extern debug_info_t *vfio_ccw_debug_msg_id;
> +extern debug_info_t *vfio_ccw_debug_trace_id;
> +
> +#define VFIO_CCW_TRACE_EVENT(imp, txt) \
> +		debug_text_event(vfio_ccw_debug_trace_id, imp, txt)
> +
> +#define VFIO_CCW_MSG_EVENT(imp, args...) \
> +		debug_sprintf_event(vfio_ccw_debug_msg_id, imp, ##args)
> +
> +static inline void VFIO_CCW_HEX_EVENT(int level, void *data, int length)
> +{
> +	debug_event(vfio_ccw_debug_trace_id, level, data, length);
> +}
> +
>  #endif
> 

This all looks pretty standard compared to the existing cio stuff, and
would be a good addition for vfio-ccw.

Reviewed-by: Eric Farman <farman@linux.ibm.com>
