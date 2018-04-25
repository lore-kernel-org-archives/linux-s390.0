From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 01/10] vfio: ccw: Moving state change out of IRQ context
Date: Wed, 25 Apr 2018 08:57:26 +0200
Message-ID: <20180425085726.3a8a97a5.cohuck@redhat.com>
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
        <1524149293-12658-2-git-send-email-pmorel@linux.vnet.ibm.com>
        <20180424065442.GV12194@bjsdjshi@linux.vnet.ibm.com>
        <ac4b7441-2d17-922b-695e-98c01d87cd42@linux.vnet.ibm.com>
        <20180424115929.5b5e1ff0.cohuck@redhat.com>
        <245ee547-75bc-95f5-5acb-bfa96f91afd2@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <245ee547-75bc-95f5-5acb-bfa96f91afd2@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, pasic@linux.vnet.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 24 Apr 2018 18:42:38 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On 04/24/2018 11:59 AM, Cornelia Huck wrote:
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
> >>
> >> The current design insure that we have not two concurrent SSCH requests.
> >> How ever I want here to track spurious interrupt.
> >> If we implement cancel, halt or clear requests, we also may trigger (AFAIU)
> >> a second interrupts depending on races between instructions, controller
> >> and device.  
> > 
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
> > 
> > I think we should present two interrupts to the guest in that case.
> > Races between issuing ssch/hsch/csch and the subchannel becoming status
> > pending happen on real hardware as well, we're just more likely to see
> > them with the vfio layer in between.
> >   
> 
> AFAIU this will be the problem of the person implementing the clear
> and the halt for vfio-ccw. I.e. it's a non-problem right now.

Well, that person is me :) I will post some RFC Real Soon Now if I stop
getting sidetracked...

> 
> > (I'm currently trying to recall what we're doing with unsolicited
> > interrupts. These are fun wrt deferred cc 1; I'm not sure if there are
> > cases where we want to present a deferred cc to the guest.)  
> 
> What are 'fun wrt deferred cc 1' again? The deferred cc I understand
> but wrt does not click at all.

wrt == with regard to

(Or were you asking something else?)

> 
> > 
> > Also, doing a second ssch before we got final state for the first one
> > is perfectly valid. Linux just does not do it, so I'm not sure if we
> > should invest too much time there.
> >   
> >>
> >> We do not need it strongly.
> >>  
> >>>     
> >>>> +	queue_work(vfio_ccw_work_q, &private->io_work);
> >>>> +	if (private->completion)
> >>>> +		complete(private->completion);
> >>>>    }
> >>>>
> >>>>    static int vfio_ccw_sch_probe(struct subchannel *sch)  
> >>> [...]
> >>>     
> >>  
> >   
> 
