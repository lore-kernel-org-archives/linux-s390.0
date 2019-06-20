Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42116 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726098AbfFTU10 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 20 Jun 2019 16:27:26 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5KKMJ7F118576
        for <linux-s390@vger.kernel.org>; Thu, 20 Jun 2019 16:27:24 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t8fwbu29q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 20 Jun 2019 16:27:24 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <farman@linux.ibm.com>;
        Thu, 20 Jun 2019 21:27:23 +0100
Subject: Re: [RFC v1 1/1] vfio-ccw: Don't call cp_free if we are processing a
 channel program
References: <cover.1561055076.git.alifm@linux.ibm.com>
 <46dc0cbdcb8a414d70b7807fceb1cca6229408d5.1561055076.git.alifm@linux.ibm.com>
From: Eric Farman <farman@linux.ibm.com>
Date: Thu, 20 Jun 2019 16:27:19 -0400
MIME-Version: 1.0
In-Reply-To: <46dc0cbdcb8a414d70b7807fceb1cca6229408d5.1561055076.git.alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <638804dc-53c0-ff2f-d123-13c257ad593f@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>, cohuck@redhat.com
Cc: pasic@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org



On 6/20/19 3:40 PM, Farhan Ali wrote:
> There is a small window where it's possible that an interrupt can
> arrive and can call cp_free, while we are still processing a channel
> program (i.e allocating memory, pinnging pages, translating

s/pinnging/pinning/

> addresses etc). This can lead to allocating and freeing at the same
> time and can cause memory corruption.
> 
> Let's not call cp_free if we are currently processing a channel program.

The check around this cp_free() call is for a solicited interrupt, so
it's presumably in response to a SSCH we issued.  But if we're still
processing a CP, then we hadn't issued the SSCH to the hardware yet.  So
what is this interrupt for?  Do the contents of irb.cpa provide any
clues, perhaps if it's in the current cp or for someone else?

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

As I alluded earlier, do we know this irb is for this cp?  If no, what
does this function end up putting in the scsw?

> -		if (is_final)
> +		if (is_final && private->state != VFIO_CCW_STATE_CP_PROCESSING)

In looking at how we set this state, and how we exit it, I see we do:

if SSCH got CC0, CP_PROCESSING -> CP_PENDING
if SSCH got !CC0, CP_PROCESSING -> IDLE

While the first scenario happens immediately after the SSCH instruction,
I guess it could be just tiny enough, like the io_trigger FSM patch I
sent a few weeks ago.

Meanwhile, the latter happens way after we return from the jump table.
So that scenario leaves considerable time for such an interrupt to
occur, though I don't understand why it would if we got a CC(1-3) on the
SSCH.

And anyway, the return from fsm_io_helper() in that case will also call
cp_free().  So why does the cp->initialized check provide protection
from a double-free in that direction, but not here?  I'm confused.

>  			cp_free(&private->cp);
>  	}
>  	mutex_lock(&private->io_mutex);
> 
