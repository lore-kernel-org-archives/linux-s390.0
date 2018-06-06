From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH RFC 2/2] vfio-ccw: support for halt/clear subchannel
Date: Wed, 6 Jun 2018 14:21:31 +0200
Message-ID: <20180606142131.74ea2eb7.cohuck@redhat.com>
References: <20180509154822.23510-1-cohuck@redhat.com>
        <20180509154822.23510-3-cohuck@redhat.com>
        <c18f9b9f-da00-1a0b-8ef0-7ac223c73d1a@linux.ibm.com>
        <20180515181006.0cb1dfc2.cohuck@redhat.com>
        <a5d08fb7-d9c1-b230-fe0c-acebbda2ba65@linux.ibm.com>
        <20180522145208.310143ea.cohuck@redhat.com>
        <4e4001cc-540e-0f2b-bbd1-1f82ca594bb3@linux.ibm.com>
        <20180605151449.22aafbfc.cohuck@redhat.com>
        <e73038ff-fb2d-5865-8b84-e775990f3983@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e73038ff-fb2d-5865-8b84-e775990f3983@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 5 Jun 2018 17:23:02 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 05/06/2018 15:14, Cornelia Huck wrote:
> > On Tue, 22 May 2018 17:10:44 +0200
> > Pierre Morel <pmorel@linux.ibm.com> wrote:
> >  
> >> On 22/05/2018 14:52, Cornelia Huck wrote:  
> >>> On Wed, 16 May 2018 15:32:48 +0200
> >>> Pierre Morel <pmorel@linux.ibm.com> wrote:
> >>>     
> >>>> On 15/05/2018 18:10, Cornelia Huck wrote:  
> >>>>> On Fri, 11 May 2018 11:33:35 +0200
> >>>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
> >>>>>        
> >>>>>> On 09/05/2018 17:48, Cornelia Huck wrote:  
> >>>>>>> @@ -126,7 +192,24 @@ static void fsm_io_request(struct vfio_ccw_private *private,
> >>>>>>>      
> >>>>>>>      	memcpy(scsw, io_region->scsw_area, sizeof(*scsw));
> >>>>>>>      
> >>>>>>> -	if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) {
> >>>>>>> +	/*
> >>>>>>> +	 * Start processing with the clear function, then halt, then start.
> >>>>>>> +	 * We may still be start pending when the caller wants to clean
> >>>>>>> +	 * up things via halt/clear.
> >>>>>>> +	 */  
> >>>>>> hum. The scsw here does not reflect the hardware state but the
> >>>>>> command passed from the user interface.
> >>>>>> Can we and should we authorize multiple commands in one call?
> >>>>>>
> >>>>>> If not, the comment is not appropriate and a switch on cmd.fctl
> >>>>>> would be a clearer.  
> >>>>> There may be multiple functions specified, but we need to process them
> >>>>> in precedence order (and clear wins over the others, so to speak).
> >>>>> Would adding a sentence like "we always process just one function" help?  
> >>>> Why should we allow multiple commands in a single call ?
> >>>> It brings no added value.
> >>>> Is there a use case?
> >>>> Currently QEMU does not do this and since we only have the SCSH there
> >>>> is no difference having the bit set alone or not alone.  
> >>> I found this to be a very easy way to implement halt/clear. This still
> >>> holds true if we switch to some kind of capabilities for this (did not
> >>> have time to look at this further, though).
> >>>
> >>> As we have the fctl field anyway, I'm in favour of processing this all
> >>> in one function.
> >>>     
> > [starting to look at this again]
> >  
> >> Sorry, I do not understand if we agree or not.
> >>
> >> I agree we have the fctl field and we must continue to use it
> >> for backward compatibility.  
> > It also mirrors the hardware, no?  
> 
> No, in the hardware this is the result of the instruction in the SCSW.
> Not the instruction itself.

Not sure if I parse this correctly... but the architecture says that
the subchannel has the {start,halt,clear} function set as a result of
{start,halt,clear} subchannel, doesn't it?

> 
> >  
> >> I do not understand the "processing all in one function".
> >>
> >> Since yo already have 3 function to process these three instructions.
> >>
> >> Do you mean the if .. else if .. else if ?  
> > Yes. There is a lot of common handling for each of these.  
> 
> There are also differences and it breaks the FSM

Depends on what we will do with the fsm ;)

> 
> >  
> >> Then I come back to what you said earlier on the precedence of the clear
> >> instruction:
> >>
> >> 1) do we have a use case to have more than one bit set in the fctl field?
> >>
> >> - if no, there is no need for precedence  
> > It mirrors what the hardware does: you just set an additional bit if
> > processing has not yet finished.  
> 
> I do not agree, this is true for the SCSW but not for instructions.
> We receive instructions in VFIO and give back status.
> The name used to provide the command is misleading.

Confused. What we get over the interface is an scsw (the current scsw
for the subchannel in QEMU). A halt does set an additional bit in the
fctl if the start is not yet finished.

But that had me re-reading the PoP, and clear is indeed different (it,
ah, clears the other bits). So, clear handling is different enough from
the others, and I'm not sure anymore whether it makes sense to handle
start and halt together. I'll rework this.

> 
> >  
> >> - if yes, why should clear have precedence ?  
> > Because it does on the hardware?  
> 
> What you say is right if we would have a register inside the subchannel
> where we write the commands.
> But this is not what we handle we handle separate instructions coming
> from an instruction stream.
> 
> We do never receive two instructions at the same time, but each after
> the other.
> If the sub-channel is busy on IO a clear or a cancel must be able to 
> stop the IO.
> I agree upon this.
> But we do not have any other command in the same call.
> 
> If we would construct the interface differently, for example using an 
> mmap() system
> call and let the user ORing the command bitfield before using an ioctl 
> to inform
> us from the change, or if we poll on the command bitfield we should 
> implement
> it like you say.
> But this is not what we do, and this is not what the architecture does.
> does it?

The thing is that the guest does not interact with this interface at
all, it is just the backend implementation. The instructions set the
bits in the scsw fctl field, and we get the scsw from QEMU. By the
architecture, both start and halt may be set in the fctl at the same
time. [That this currently does not happen because QEMU is not really
handling things asynchronously is an implementation detail.]

> 
> >  
> >>     How do QEMU set more than one bit in fctl?
> >>     why should we alter the order of the instructions given by the guest?
> >>     How can we know this order if there are multiple instructions at once?  
> > In the future, we should return after we fired off the start etc.
> > request even if we did not receive an interrupt yet, so that the guest
> > might do a halt or clear before the start has finished.  
> 
> This is already what is done here:
> We fire off the start (go to BUSY state) and return
> 
> If the guest want to start another command it polls on
> the vfio_write() untill the channel isn't BUSY anymore.

It's not the guest that polls, but QEMU (resp. another user space
program). And it should be able to fire a halt etc. even if the start
function is still active, as the architecture allows that. (I would
expect the real hardware to give us a busy if applicable anyway.)

> 
> On interrupt we set the channel back to IDLE and the next
> command shall be proceed.
> 
> (I must enhance the cover letter (already said))
> 
> >   IOW, make this
> > as asynchronous as the hardware. That's why I'd like to simply
> > accumulate the things. The architecture already specified what happens
> > in the response.
> >
> > Do you think that is feasible?
> >  
> Yes I think it is feasible and it is what we need to do.
> 
> CLEAR, CANCEL and HALT must be able to overtake the
> START and really stop the IO transfer.
> 
> They just should be able to proceed in the BUSY state
> on the opposite of the START.
> This is easily done with new events in the FSM inside
> both IDLE and BUSY states

On re-reading the PoP, the three of them do have some different
requirements:

- cancel is currently handled completely in QEMU, and it also has quite
  different semantics as it is not asynchronous etc.
- halt can be made pending in addition to a start function
- clear will need to clear anything that's currently going on

I'll need to rethink some of this; probably does not make sense for you
to try to integrate my patches.
