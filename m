Return-Path: <SRS0=oVSW=SZ=vger.kernel.org=kvm-owner@kernel.org>
Date: Tue, 23 Apr 2019 19:42:51 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] vfio-ccw: Prevent quiesce function going into an
 infinite loop
In-Reply-To: <8bd8ec0b-8b0c-3e74-1b14-7fad7470679e@linux.ibm.com>
References: <cover.1555449329.git.alifm@linux.ibm.com>
        <4d5a4b98ab1b41ac6131b5c36de18b76c5d66898.1555449329.git.alifm@linux.ibm.com>
        <20190417110348.28efc8e3.cohuck@redhat.com>
        <b7daaf7d-72e9-7e59-890c-620a4733b93d@linux.ibm.com>
        <20190417171311.3478402b@oc2783563651>
        <f457d63a-69b9-43da-c425-5c34fb0d9dd4@linux.ibm.com>
        <20190419221251.5b4aa9c8.pasic@linux.ibm.com>
        <8bd8ec0b-8b0c-3e74-1b14-7fad7470679e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190423194251.093304c7.pasic@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, pmorel@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Mon, 22 Apr 2019 10:01:46 -0400
Farhan Ali <alifm@linux.ibm.com> wrote:

> 
> 
> On 04/19/2019 04:12 PM, Halil Pasic wrote:
> > On Wed, 17 Apr 2019 11:18:19 -0400
> > Farhan Ali <alifm@linux.ibm.com> wrote:
> > 
> >>
> >>
> >> On 04/17/2019 11:13 AM, Halil Pasic wrote:
> >>>>> Otherwise, looks good to me. Will queue when I get some ack/r-b.
> >>>>>
> >>>> I like it, but I feel weird giving an r-b to something I suggested:
> >>>>
> >>>> Acked-by: Eric Farman<farman@linux.ibm.com>
> >>>>
> >>> I think r-b is fine. You did verify both the design and the
> >>> implementation I guess. So I don't see why not.
> >>>
> >>> How urgent is this. I could give this some love till the end of the
> >>> week. Should I @Connie,@Farhan?
> >>
> >> Having more people review it is always a good thing :)
> >>
> > 
> > Hi Farhan,
> > 
> > I was starring at this code for about an hour if not more and could not
> > figure out the intentions/ideas behind it. That is not a fault of your
> > patch, but I can't say that I understand neither the before nor the
> > after.
> > 
> > What understand this patch basically does is make us call
> > cio_disable_subchannel() more often. That is what you point out in your
> > commit message as well. But I fail to see how does this achieve what the
> > summary line promises:  'Prevent quiesce function going into an infinite
> > loop'.
> > 
> 

> The main problem with the previous way, was we were calling 
> cio_cancel_halt_clear and then waiting and then calling it again.

Thanks for explaining this to me offline ;).

> 
> So if cio_cancel_halt_clear returned EBUSY we would always be stuck in 
> the first loop. Now a problem can occur when cancel subchannel returns 
> EINVAL (cc 2) and so we try to do halt subchannel. cio_cancel_halt_clear 
> will return EBUSY for a successful halt subchannel as well. And so back 
> in the quiesce function we will wait and if the halt succeeds, the 
> channel subsystem will clear the halt pending bit in the activity 
> control field of SCSW. This means the next time we try 
> cio_cancel_halt_clear we will again start by calling cancel subchannel, 
> which could again return EINVAL....
> 


So in other words (one of) the problematic scenario(s) is the following.
1. xsch() returns cc 2 because there is not start pending and is not
suspended (i.e. there is nothing to cancel)
2. we proceed to hsch() which completes successfully and
cio_cancel_halt_clear() returns EBUSY
3. We wait for the interrupt and halt pending gets cleared because
a halt signal was issued to the device (e.g. halt worked fine).
4. We call cio_cancel_halt_clear() again *despite the fact that halt
already accomplished what we were hoping for*.
5. xsch() returns cc 2 again, because hopefully no new ssch() caused
the subchannel to have a start/resume pending. So we progress to 2.

Seems the current code is broken if the cancel() in
cio_cancel_halt_clear() returns EINVAL (cc 2), and it returning EBUSY
(cc 1) is also suspicious (because we don't do a tsch()).

> We would be stuck in an infinite loop. One way to prevent this is to 
> call cio_disable_subchannel right after calling cio_cancel_halt_clear,
> if we can successfully disable the subchannel then we are sure the 
> device is quiesced.
> 


Yes your change helps with cc 2 form chancel(). I'm not sure about cc 1
though -- I'm not sure cc = 1 is even possible. 

So now that I kind of understand what is this patch trying to accomplish,
I think I can help with some stuff.

Let us have a look at the commit message first:



> Subject: [PATCH v3 1/1] vfio-ccw: Prevent quiesce function going into
> 
> The quiesce function calls cio_cancel_halt_clear() and if we
> get an -EBUSY we go into a loop where we:
> 	- wait for any interrupts
> 	- flush all I/O in the workqueue

We don't actually flush any I/O. What may sit on the workqueue is the
'tell QEMU about an IRB' work.

> 	- retry cio_cancel_halt_clear
> 
> During the period where we are waiting for interrupts or
> flushing all I/O, the channel subsystem could have completed
> a halt/clear action and turned off the corresponding activity
> control bits in the subchannel status word.

The very idea behind the completion is to wait until we get
an interrupt.

> This means the next
> time we call cio_cancel_halt_clear(), we will again start by
> calling cancel subchannel and so we can be stuck between calling
> cancel and halt forever.
> 

Actually very likely if we had a cancel() returned EINVAL previously.

> Rather than calling cio_cancel_halt_clear() immediately after
> waiting, let's try to disable the subchannel. If we succeed in
> disabling the subchannel then we know nothing else can happen
> with the device.

One thing I'm confused about is, that we don't seem to prevent
new I/O being submitted. That is we could still loop indefinitely
if we get new IO after the 'kill I/O on the subchannel' is done but
before the msch() with the disable is issued.

The 'flush all I/O' parts in the commit message and in the code make
this even more confusing.

Another thing that I don't quite understand is injecting interrupts
into QEMU for stuff that is actually not guest initiated.

Furthermore I find how cio_cancel_halt_clear() quite confusing. We
usually return EBUSY to say that the function was suppressed because,
well, the resource is busy. For cio_cancel_halt_clear() EBUSY means:
* either a xsch() was effectively suppressed because status pending
* or an hsch() or csch() was actually successfully executed, and the
client code is supposed to wait for the assync clear/halt function
to complete. This gets even more confusing when one reads:

/**                                                                             
 * cio_cancel_halt_clear - Cancel running I/O by performing cancel, halt        
 * and clear ordinally if subchannel is valid.                                  
 * @sch: subchannel on which to perform the cancel_halt_clear operation         
 * @iretry: the number of the times remained to retry the next operation        
 *                                                                              
 * This should be called repeatedly since halt/clear are asynchronous

This is simply not true. Because halt/clear is async, we may not know
if we managed to accomplish canceling the running I/O. But the next
call of this function won't detect and say 'yep it worked, we are good
now' and return 0. This is the responsibility of the caller.

If it were like that, the current code would have been fine!
           
 * operations. We do one try with cio_cancel, three tries with cio_halt,        
 * 255 tries with cio_clear. The caller should initialize @iretry with          
 * the value 255 for its first call to this, and keep using the same            
 * @iretry in the subsequent calls until it gets a non -EBUSY return.           
 *                                                                              
 * Returns 0 if device now idle, -ENODEV for device not operational,            
 * -EBUSY if an interrupt is expected (either from halt/clear or from a         
 * status pending), and -EIO if out of retries.                                 
 */                                                                             
int cio_cancel_halt_clear(struct subchannel *sch, int *iretry

TL;DR:

I welcome  this batch (with an r-b) but I would like the commit message
and the comment changed so that the misleading 'flush all I/O in the
workqueue'.

I think 'vfio-ccw: fix cio_cancel_halt_clear() usage' would reflect the
content of this patch better, because reasoning about the upper limit,
and what happens if this upper limit is hit is not what this patch is
about. It is about a client code bug that rendered iretry ineffective.

Regards,
Halil
