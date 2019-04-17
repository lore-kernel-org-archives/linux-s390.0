Return-Path: <SRS0=rjjQ=ST=vger.kernel.org=kvm-owner@kernel.org>
Date: Wed, 17 Apr 2019 17:13:11 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] vfio-ccw: Prevent quiesce function going into an
 infinite loop
In-Reply-To: <b7daaf7d-72e9-7e59-890c-620a4733b93d@linux.ibm.com>
References: <cover.1555449329.git.alifm@linux.ibm.com>
        <4d5a4b98ab1b41ac6131b5c36de18b76c5d66898.1555449329.git.alifm@linux.ibm.com>
        <20190417110348.28efc8e3.cohuck@redhat.com>
        <b7daaf7d-72e9-7e59-890c-620a4733b93d@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190417171311.3478402b@oc2783563651>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, pmorel@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, 17 Apr 2019 09:58:24 -0400
Eric Farman <farman@linux.ibm.com> wrote:

> 
> 
> On 4/17/19 5:03 AM, Cornelia Huck wrote:
> > On Tue, 16 Apr 2019 17:23:14 -0400
> > Farhan Ali <alifm@linux.ibm.com> wrote:
> > 
> >> The quiesce function calls cio_cancel_halt_clear() and if we
> >> get an -EBUSY we go into a loop where we:
> >> 	- wait for any interrupts
> >> 	- flush all I/O in the workqueue
> >> 	- retry cio_cancel_halt_clear
> >>
> >> During the period where we are waiting for interrupts or
> >> flushing all I/O, the channel subsystem could have completed
> >> a halt/clear action and turned off the corresponding activity
> >> control bits in the subchannel status word. This means the next
> >> time we call cio_cancel_halt_clear(), we will again start by
> >> calling cancel subchannel and so we can be stuck between calling
> >> cancel and halt forever.
> >>
> >> Rather than calling cio_cancel_halt_clear() immediately after
> >> waiting, let's try to disable the subchannel. If we succeed in
> >> disabling the subchannel then we know nothing else can happen
> >> with the device.
> >>
> >> Suggested-by: Eric Farman <farman@linux.ibm.com>
> >> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> >> ---
> >> ChangeLog:
> >> v2 -> v3
> >>     - Log an error message when cio_cancel_halt_clear
> >>       returns EIO and break out of the loop.
> >>     
> >>     - Did not include past change log as the other patches
> >>       of the original series have been queued by Conny.
> >>       Old series (v2) can be found here:
> >>       https://marc.info/?l=kvm&m=155475754101769&w=2
> >>
> >>   drivers/s390/cio/vfio_ccw_drv.c | 32 ++++++++++++++++++--------------
> >>   1 file changed, 18 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> >> index 78517aa..66a66ac 100644
> >> --- a/drivers/s390/cio/vfio_ccw_drv.c
> >> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> >> @@ -43,26 +43,30 @@ int vfio_ccw_sch_quiesce(struct subchannel *sch)
> >>   	if (ret != -EBUSY)
> >>   		goto out_unlock;
> >>   
> >> +	iretry = 255;
> >>   	do {
> >> -		iretry = 255;
> >>   
> >>   		ret = cio_cancel_halt_clear(sch, &iretry);
> >> -		while (ret == -EBUSY) {
> >> -			/*
> >> -			 * Flush all I/O and wait for
> >> -			 * cancel/halt/clear completion.
> >> -			 */
> >> -			private->completion = &completion;
> >> -			spin_unlock_irq(sch->lock);
> >>   
> >> -			wait_for_completion_timeout(&completion, 3*HZ);
> >> +		if (ret == -EIO) {
> >> +			pr_err("vfio_ccw: could not quiesce subchannel 0.%x.%04x!\n",
> >> +			       sch->schid.ssid, sch->schid.sch_no);
> > 
> > What about using
> > 	dev_err(&sch->dev, "could not quiesce");
> > instead?
> 
> +1
> 
> > 
> > (Can make that change while applying, no need to resend for that.)
> > 
> >> +			break;
> >> +		}
> >> +
> >> +		/*
> >> +		 * Flush all I/O and wait for
> >> +		 * cancel/halt/clear completion.
> >> +		 */
> >> +		private->completion = &completion;
> >> +		spin_unlock_irq(sch->lock);
> >>   
> >> -			private->completion = NULL;
> >> -			flush_workqueue(vfio_ccw_work_q);
> >> -			spin_lock_irq(sch->lock);
> >> -			ret = cio_cancel_halt_clear(sch, &iretry);
> >> -		};
> >> +		if (ret == -EBUSY)
> >> +			wait_for_completion_timeout(&completion, 3*HZ);
> >>   
> >> +		private->completion = NULL;
> >> +		flush_workqueue(vfio_ccw_work_q);
> >> +		spin_lock_irq(sch->lock);
> >>   		ret = cio_disable_subchannel(sch);
> >>   	} while (ret == -EBUSY);
> >>   out_unlock:
> > 
> > Otherwise, looks good to me. Will queue when I get some ack/r-b.
> > 
> 
> I like it, but I feel weird giving an r-b to something I suggested:
> 
> Acked-by: Eric Farman <farman@linux.ibm.com>
> 

I think r-b is fine. You did verify both the design and the
implementation I guess. So I don't see why not.

How urgent is this. I could give this some love till the end of the
week. Should I @Connie,@Farhan?

I was mostly ignoring these patches so I can't capitalize on my
understanding from reviewing the previous versions and need some time to
say something about it.

Regards,
Halil
