From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 04 Apr 2019 08:58:32 +0000
Subject: Re: [RFC v1 2/3] vfio-ccw: Prevent quiesce function going into an infinite loop
Message-Id: <20190404105832.1fc25f2f.cohuck@redhat.com>
In-Reply-To: <2498a158-7574-c5bb-a39d-b0aed9bc71b0@linux.ibm.com>
References: <2498a158-7574-c5bb-a39d-b0aed9bc71b0@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 3 Apr 2019 11:06:14 -0400
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 04/03/2019 03:58 AM, Cornelia Huck wrote:
> > On Tue,  2 Apr 2019 12:44:34 -0400
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
> > 
> > Hmm... I had to spend some time looking at the code and it seems to be
> > a bit confused (not your patch, the general logic).
> > 
> > Basically, we call the quiesce function for two reasons:
> > - The device is shutdown/removed. We don't want to do anything with the
> >    device afterwards, and especially want nobody to start anything new.
> >    The subchannel will be disabled, and stay like that.
> > - The mdev reset callback is invoked. When resetting, we basically
> >    disable the subchannel (any I/O of course needs to be done prior to
> >    that), and then enable it again.
> > 
> > In the first case, our goal is to disable the subchannel, and nothing
> > more will be done with it.
> > 
> > In the second case, we simply want to perform a reset operation; that
> > is, get the subchannel into a clean state. The disable/enable is just a
> > means to get there.  
> >  > Looking at what the common I/O layer does with the cancel_halt_clear  
> > operation, it moves the device into a special quiescing state so that
> > no new I/O will be started. And I think that's how it is intended to be
> > used: If we want to quiesce the subchannel prior to remove/shutdown,
> > fencing off any new I/O is what we want. That means nobody will submit
> > requests we're not aware of.  
> 
> Agreed. Under normal conditions, if someone explicitly requested the 
> removal of the device we can safely assume that they are no more I/O 
> request sent from the userspace.

Yes, and we would not lose any functionality if we actively fence this.

> 
> > 
> > That leaves the reset case, in which disabling the subchannel is only a
> > means to reset the subchannel to a defined state. We definitely want to
> > accept new I/O requests once we're done with the disable/enable dance.
> > That leaves the question of what to do with requests that come in while
> > resetting: Reject them? Queue them for later? Is disable/enable even
> > the best solution here? We basically came up with it because we
> > couldn't think of anything else...
> >   
> 
> So right now the reset callback is invoked through an ioctl. Would a 
> sane userspace try to issue read/write request before the completion of 
> reset? I am assuming that if userspace is requesting a device reset, it 
> will at least wait for the reset to complete?

It depends on the semantics of reset, of which I am not completely
clear TBH. It's probably ok to fence here as well, maybe with a
different error ("try again later" vs. "the device is going away
anyway" in the first case).

> 
> 
> > (And yes, I also find it confusing that the quiesce function not only
> > clears out pending I/O, but also disables the subchannel...)
> >   
> >>
> >> Suggested-by: Eric Farman <farman@linux.ibm.com>
> >> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> >> ---
> >>   drivers/s390/cio/vfio_ccw_drv.c | 28 ++++++++++++----------------
> >>   1 file changed, 12 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> >> index 5aca475..f87757b 100644
> >> --- a/drivers/s390/cio/vfio_ccw_drv.c
> >> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> >> @@ -43,26 +43,22 @@ int vfio_ccw_sch_quiesce(struct subchannel *sch)
> >>   	if (ret != -EBUSY)
> >>   		goto out_unlock;
> >>   
> >> +	iretry = 255;
> >>   	do {
> >> -		iretry = 255;
> >>   
> >> -		ret = cio_cancel_halt_clear(sch, &iretry);
> >> -		while (ret == -EBUSY) {
> >> -			/*
> >> -			 * Flush all I/O and wait for
> >> -			 * cancel/halt/clear completion.
> >> -			 */
> >> -			private->completion = &completion;
> >> -			spin_unlock_irq(sch->lock);
> >> +		cio_cancel_halt_clear(sch, &iretry);  
> > 
> > I think you still want to check the return code here...
> >   
> >> +		/*
> >> +		 * Flush all I/O and wait for
> >> +		 * cancel/halt/clear completion.
> >> +		 */
> >> +		private->completion = &completion;
> >> +		spin_unlock_irq(sch->lock);
> >>   
> >> -			wait_for_completion_timeout(&completion, 3*HZ);
> >> -
> >> -			private->completion = NULL;
> >> -			flush_workqueue(vfio_ccw_work_q);
> >> -			spin_lock_irq(sch->lock);
> >> -			ret = cio_cancel_halt_clear(sch, &iretry);
> >> -		};
> >> +		wait_for_completion_timeout(&completion, 3*HZ);  
> > 
> > ...because you don't want to wait for an interrupt that won't arrive
> > (e.g. when xsch was successful, or if the subchannel has become
> > non-operational in the meantime.)
> >   
> 
> Hmm, this makes sense. I think we probably could wrap the waiting within 
> an if condition, similar to io_subchannel_quiesce()?

Probably yes.

> 
> >>   
> >> +		private->completion = NULL;
> >> +		flush_workqueue(vfio_ccw_work_q);
> >> +		spin_lock_irq(sch->lock);
> >>   		ret = cio_disable_subchannel(sch);
> >>   	} while (ret == -EBUSY);
> >>   out_unlock:  
> > 
> > Regardless of my comments above, this looks like an improvement over
> > what we have now. Have you been able to observe the issue in real life?
> > 
> >   
> Yes, I have observed this in my testing. I think if you try to remove 
> the mediated device (echo 1 > /path/to/mdev/remove) while a guest is 
> running I/O, there is a good chance you will enter in this infinite loop.

Good to know, a testcase is always helpful :)

> 
> Thanks for taking a look at the patches.
> 
> Thanks
> Farhan
> 
