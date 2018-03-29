From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 4/4] vfio: ccw: add traceponits for interesting error
 paths
Date: Thu, 29 Mar 2018 14:32:55 +0200
Message-ID: <20180329143255.5ce349f1.cohuck@redhat.com>
References: <20180321020822.86255-1-bjsdjshi@linux.vnet.ibm.com>
        <20180321020822.86255-5-bjsdjshi@linux.vnet.ibm.com>
        <20180326155902.12bed785.cohuck@redhat.com>
        <20180327075114.GK12194@bjsdjshi@linux.vnet.ibm.com>
        <20180327120723.192f7577.cohuck@redhat.com>
        <493b19b7-fa86-0220-7427-be519f1b40ad@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <493b19b7-fa86-0220-7427-be519f1b40ad@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, borntraeger@de.ibm.com, pmorel@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Tue, 27 Mar 2018 17:27:54 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 03/27/2018 12:07 PM, Cornelia Huck wrote:
> > On Tue, 27 Mar 2018 15:51:14 +0800
> > Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> >   
> >> * Cornelia Huck <cohuck@redhat.com> [2018-03-26 15:59:02 +0200]:
> >>
> >> [...]
> >>  
> >>>> @@ -131,6 +138,8 @@ static void fsm_io_request(struct vfio_ccw_private *private,
> >>>>  
> >>>>  		io_region->ret_code = cp_prefetch(&private->cp);
> >>>>  		if (io_region->ret_code) {
> >>>> +			trace_vfio_ccw_cp_prefetch_failed(get_schid(private),
> >>>> +							  io_region->ret_code);
> >>>>  			cp_free(&private->cp);
> >>>>  			goto err_out;
> >>>>  		}
> >>>> @@ -138,6 +147,8 @@ static void fsm_io_request(struct vfio_ccw_private *private,
> >>>>  		/* Start channel program and wait for I/O interrupt. */
> >>>>  		io_region->ret_code = fsm_io_helper(private);
> >>>>  		if (io_region->ret_code) {
> >>>> +			trace_vfio_ccw_ssch_failed(get_schid(private),
> >>>> +						   io_region->ret_code);
> >>>>  			cp_free(&private->cp);
> >>>>  			goto err_out;
> >>>>  		}
> >>>> @@ -145,10 +156,12 @@ static void fsm_io_request(struct vfio_ccw_private *private,
> >>>>  	} else if (scsw->cmd.fctl & SCSW_FCTL_HALT_FUNC) {
> >>>>  		/* XXX: Handle halt. */
> >>>>  		io_region->ret_code = -EOPNOTSUPP;
> >>>> +		trace_vfio_ccw_halt(get_schid(private));
> >>>>  		goto err_out;
> >>>>  	} else if (scsw->cmd.fctl & SCSW_FCTL_CLEAR_FUNC) {
> >>>>  		/* XXX: Handle clear. */
> >>>>  		io_region->ret_code = -EOPNOTSUPP;
> >>>> +		trace_vfio_ccw_clear(get_schid(private));
> >>>>  		goto err_out;    
> >>>
> >>> Hmmm.... perhaps better to just trace the function (start/halt/clear)
> >>> in any case?
> >>>     
> >> I agree trace the function in any case is good. @Halil, opinion?  
> 
> See below. I don't really understand the question. Trace the function
> means, trace when it was requested on a subch, or trace the outcome
> of the request? Seems the question got amended though.

Both tracing the functions per se and tracing their outcome has its
benefits IME.

> 
> >>
> >> But the traces for cp_prefetch() and fsm_io_helper() should also be
> >> kept, since they are helpful to debug problem. So I tend to trace the
> >> following in any case:
> >> - cp_prefetch()
> >> - fsm_io_helper()
> >> - start
> >> - halt
> >> - clear  
> > 
> > OK, I was unclear :) I'd argue to keep the others, just replace the
> > halt/clear tracing with tracing the function.  
> 
> I'm a bit confused.
> 
> My idea was the following: Prior to this patch we had a kind of OK
> possibility to trace what we consider the expected and good scenario
> using the function tracer and the normal cio stuff. But what I wanted is
> to verify that my fix works (problem occurs but is handled more
> appropriately) and I've found it difficult to trace this. So the idea was
> to introduce trace points which tell us what went wrong. The idea is to
> benefit diagnostic of unrecoverable failures and get an idea how often
> are we doing extra work recovering recoverable failures.
> 
> In this sense halt and clear is something that does not work currently.
> When we get proper halt and clear, these trace points were supposed to
> become obsolete and get removed. I guess the implementation will
> eventually issue csch() and hsch() for the underlying subchannel and and
> we should be able to trace those (see drivers/s390/cio/ioasm.c)

Tracing what userspace expects us to do has its benefits as well (i.e.
do we get mainly ssch? unexpected amounts of csch? etc.). I find it
useful to be able to get this information from the vfio-ccw layer
already.

> 
> Now this is the tricky part. I've read some used to see trace points as
> part of the kernel ABI.  See e.g. https://lwn.net/Articles/705270/. AFAIU
> this is not a concern any more -- but my confidence on this is pretty
> low.

I'd not worry about that.

FWIW, for kvm/s390 I tried to do the following:
- one set of tracepoints for things that are mandated by the
  architecture and therefore expected to be stable
- and another set of tracepoints for implementation details that have a
  good change of changing

> 
> So IMHO we have two questions to answer:
> 
> * Do we want static trace points (events) for undesirable or concerning
> stuff happened (e.g. translation failed, a function we hope we can live
> without was supposed to be executed)?
> 
> * Do we want static trace points (events) coverage for the normal path
> (that is beyond what cio and the function tracer already give us)? What
> benefit do we expect if we do want these? (E.g. performance evaluation,
> better debugging especially when multiple virtualized subchannels used.)

Whatever you think is useful. Of course, we can go there step by step
(and I'd really advise to do so; getting some useful info right now and
not holding things up until we have a more complete understand what
would be useful for e.g. ffdc).

You can always have userspace enable tracing of some things by default
and leave the rest off until wanted.

> >>> Just tracing the function is useful now and will stay useful in the
> >>> future.    
> >> If we agree with ideas given above, we could:
> >> 1. DECLARE_EVENT_CLASS as vfio_ccw_schid_errno
> >> 2. DEFINE_EVENT:
> >>    vfio_ccw_fam_io_helper
> >>    vfio_ccw_cp_prefetch
> >>    vfio_ccw_io_start
> >>    vfio_ccw_io_clear
> >>    vfio_ccw_io_halt  
> > 
> > Use a vfio_ccw_io_fctl tracepoint instead?
> >   
> 
> That would trace what? A request to perform a basic I/O function
> on the virtualized subchannel by issuing the corresponding I/O
> instruction to the underlying subchannel?

Basically, what userspace requests us to do.

> 
> If that's the case, I think using the trace events from
> drivers/s390/cio/ioasm.c (tracing the instructions) may suffice for
> the 'good case'.
> 
> >> 3. add trace points in coresponding places
> >>  
> >>>
> >>> Another idea: Trace the fsm state transitions. Probably something for
> >>> an additional patch.    
> >> Considering Pierre is refactoring the fsm, we can add trace points in
> >> that series (or as following on patch).  
> > 
> > Yes, while poking around I also wondered whether we should tweak the
> > fsm in places. So adding tracepoints there looks like a good idea.
> >   
> 
> 
> How does this relate to normal cio? I don't think cio has such trace 
> points capturing the state machine transitions. I wonder why? Spontaneously
> I would say sounds like something useful.

The cio fsm simply dates back to the 2.5 era.
