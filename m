From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 01/10] vfio: ccw: Moving state change out of IRQ context
Date: Tue, 24 Apr 2018 13:55:33 +0200
Message-ID: <20180424135533.2e9d03dc.cohuck@redhat.com>
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
        <1524149293-12658-2-git-send-email-pmorel@linux.vnet.ibm.com>
        <20180424065442.GV12194@bjsdjshi@linux.vnet.ibm.com>
        <ac4b7441-2d17-922b-695e-98c01d87cd42@linux.vnet.ibm.com>
        <20180424115929.5b5e1ff0.cohuck@redhat.com>
        <f6253047-e364-c240-c4c5-cf186ca75a7d@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f6253047-e364-c240-c4c5-cf186ca75a7d@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, pasic@linux.vnet.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 24 Apr 2018 13:49:14 +0200
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> On 24/04/2018 11:59, Cornelia Huck wrote:
> > On Tue, 24 Apr 2018 10:40:56 +0200
> > Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
> >  
> >> On 24/04/2018 08:54, Dong Jia Shi wrote:  
> >>> * Pierre Morel <pmorel@linux.vnet.ibm.com> [2018-04-19 16:48:04 +0200]:
> >>>
> >>> [...]
> >>>     
> >>>> @@ -94,9 +83,15 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
> >>>>    static void vfio_ccw_sch_irq(struct subchannel *sch)
> >>>>    {
> >>>>    	struct vfio_ccw_private *private = dev_get_drvdata(&sch->dev);
> >>>> +	struct irb *irb = this_cpu_ptr(&cio_irb);
> >>>>
> >>>>    	inc_irq_stat(IRQIO_CIO);
> >>>> -	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_INTERRUPT);
> >>>> +	memcpy(&private->irb, irb, sizeof(*irb));
> >>>> +
> >>>> +	WARN_ON(work_pending(&private->io_work));  
> >>> Hmm, why do we need this?  
> >> The current design insure that we have not two concurrent SSCH requests.
> >> How ever I want here to track spurious interrupt.
> >> If we implement cancel, halt or clear requests, we also may trigger (AFAIU)
> >> a second interrupts depending on races between instructions, controller
> >> and device.  
> > You won't get an interrupt for a successful cancel. If you do a
> > halt/clear, you will make the subchannel halt/clear pending in addition
> > to start pending and you'll only get one interrupt (if the I/O has
> > progressed far enough, you won't be able to issue a hsch). The
> > interesting case is:
> > - guest does a ssch, we do a ssch on the device
> > - the guest does a csch before it got the interrupt for the ssch
> > - before we do the csch on the device, the subchannel is already status
> >    pending with completion of the ssch
> > - after we issue the csch, we get a second interrupt (for the csch)  
> 
> We agree.
> 
> >
> > I think we should present two interrupts to the guest in that case.
> > Races between issuing ssch/hsch/csch and the subchannel becoming status
> > pending happen on real hardware as well, we're just more likely to see
> > them with the vfio layer in between.  
> 
> Yes, agreed too.
> 
> >
> > (I'm currently trying to recall what we're doing with unsolicited
> > interrupts. These are fun wrt deferred cc 1; I'm not sure if there are
> > cases where we want to present a deferred cc to the guest.)  
> 
> This patch does not change the current functionalities, only 
> consolidates the FSM.
> The current way to handle unsolicited interrupts is to report them to 
> the guest
> along with the deferred code AFAIU.

My question was more along the line of "do we actually want to
_generate_ a deferred cc1 or unsolicited interrupt, based upon what we
do in our state machine". My guess is no, regardless of the changes you
do in this series.

> 
> >
> > Also, doing a second ssch before we got final state for the first one
> > is perfectly valid. Linux just does not do it, so I'm not sure if we
> > should invest too much time there.  
> 
> I agree too, it would just make things unnecessary complicated.

I'm a big fan of just throwing everything at the hardware and let it
sort out any races etc. We just need to be sure we don't mix up
interrupts :)
