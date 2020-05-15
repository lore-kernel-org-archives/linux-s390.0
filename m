Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18054 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726168AbgEOTfh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 May 2020 15:35:37 -0400
Date: Fri, 15 May 2020 21:35:27 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH v2 0/4] vfio-ccw: Fix interrupt handling for
 HALT/CLEAR
Message-ID: <20200515213527.28bd94d1.pasic@linux.ibm.com>
In-Reply-To: <931b96fc-0bb5-cdc1-bb1c-102a96f346ea@linux.ibm.com>
References: <20200513142934.28788-1-farman@linux.ibm.com>
        <20200514154601.007ae46f.pasic@linux.ibm.com>
        <4e00c83b-146f-9f1d-882b-a5378257f32c@linux.ibm.com>
        <20200515165539.2e4a8485.pasic@linux.ibm.com>
        <931b96fc-0bb5-cdc1-bb1c-102a96f346ea@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Fri, 15 May 2020 14:12:05 -0400
Eric Farman <farman@linux.ibm.com> wrote:

> 
> 
> On 5/15/20 10:55 AM, Halil Pasic wrote:
> > On Fri, 15 May 2020 09:09:47 -0400
> > Eric Farman <farman@linux.ibm.com> wrote:
> > 
> >>
> >>
> >> On 5/14/20 9:46 AM, Halil Pasic wrote:
> >>> On Wed, 13 May 2020 16:29:30 +0200
> >>> Eric Farman <farman@linux.ibm.com> wrote:
> >>>
> >>>> Hi Conny,
> >>>>
> >>>> Back in January, I suggested a small patch [1] to try to clean up
> >>>> the handling of HSCH/CSCH interrupts, especially as it relates to
> >>>> concurrent SSCH interrupts. Here is a new attempt to address this.
> >>>>
> >>>> There was some suggestion earlier about locking the FSM, but I'm not
> >>>> seeing any problems with that. Rather, what I'm noticing is that the
> >>>> flow between a synchronous START and asynchronous HALT/CLEAR have
> >>>> different impacts on the FSM state. Consider:
> >>>>
> >>>>     CPU 1                           CPU 2
> >>>>
> >>>>     SSCH (set state=CP_PENDING)
> >>>>     INTERRUPT (set state=IDLE)
> >>>>     CSCH (no change in state)
> >>>>                                     SSCH (set state=CP_PENDING)
> >>>>     INTERRUPT (set state=IDLE)
> >>>>                                     INTERRUPT (set state=IDLE)
> >>>
> >>> How does the PoP view of the composite device look like 
> >>> (where composite device = vfio-ccw + host device)?
> >>
> >> (Just want to be sure that "composite device" is a term that you're
> >> creating, because it's not one I'm familiar with.)
> > 
> > Yes I created this term because I'm unaware of an established one, and
> > I could not come up with a better one. If you have something established
> > or better please do tell, I will start using that.
> > 
> >>
> >> In today's code, there isn't a "composite device" that contains
> >> POPs-defined state information like we find in, for example, the host
> >> SCHIB, but that incorporates vfio-ccw state. This series (in a far more
> >> architecturally valid, non-RFC, form) would get us closer to that.
> >>
> > 
> > I think it is very important to start thinking about the ccw devices
> > that are exposed to the guest as a "composite device" in a sense that
> > the (passed-through) host ccw device is wrapped by vfio-ccw. For instance
> > the guest sees the SCHIB exposed by the vfio-ccw wrapper (adaptation
> > code in qemu and the kernel module), and not the SCHIB of the host
> > device.
> 
> Well, I think of "ccw devices that are exposed to the guest" as
> "vfio-ccw devices" ... They look/smell/sound like CCW devices to the
> guest, but have some pieces emulated by QEMU and some passed down to the
> host kernel (and/or the device itself). I'm not sure what a "composite
> device" buys us in any other context.

Sorry I will try to use the "vfio-ccw device" as a terminology for
this from now on. I wasn't looking at this for a while. I was worried
that it could be confused to something with a narrower scope (like the
mdev, or the bits in QEMU). Terminology is difficult also because we
technically actually do  subchannel pass-through. Please bear with
me when I get lost.

> 
> > 
> > This series definitely has some progressive thoughts. It just that
> > IMHO we sould to be more radical about this. And yes I'm a bit
> > frustrated.
> 
> "we sould to be more radical about this" ... A little help please?
> 

Make sure already the QEMU part catches this (see below). Make sure that
we don't have a hodge-podge of FMS and non-FSM states and state
transitions, and that the userspace/kernel interface is sane and
documented. 

I mean, not maintaining a copy of the SCHIB in QEMU was a design option,
and doing it was a design decision AFAIR.

Don't misunderstand me, I'm not blaming you for anything. Just trying
to bring in my perspective. 

> > 
> >>>
> >>> I suppose at the moment where we accept the CSCH the FC bit
> >>> indicated clear function (19) goes to set. When this happens
> >>> there are 2 possibilities: either the start (17) bit is set,
> >>> or it is not. You describe a scenario where the start bit is
> >>> not set. In that case we don't have a channel program that
> >>> is currently being processed, and any SSCH must bounce right
> >>> off without doing anything (with cc 2) as long as FC clear
> >>> is set. Please note that we are still talking about the composite
> >>> device here.
> >>
> >> Correct. Though, whether the START function control bit is currently set
> >> is immaterial to a CLEAR function; that's the biggest recovery action we
> >> have at our disposal, and will always go through.
> >>
> >> The point is that there is nothing to prevent the START on CPU 2 from
> >> going through. The CLEAR does not affect the FSM today, and doesn't
> >> record a FC CLEAR bit within vfio-ccw, and so we're only relying on the
> >> return code from the SSCH instruction to give us cc0 vs cc2 (or
> >> whatever). The actual results of that will depend, since the CPU may
> >> have presented the interrupt for the CLEAR (via the .irq callback and
> >> thus FSM VFIO_CCW_EVENT_INTERRUPT) and thus a new START is perfectly
> >> legal from its point of view. Since vfio-ccw may not have unstacked the
> >> work it placed to finish up that interrupt handler means we have a problem.
> >>
> >>>
> >>> Thus in my reading CPU2 making the IDLE -> CP_PENDING transition
> >>> happen is already wrong. We should have rejected to look at the
> >>> channel program in the first place. Because as far as I can tell
> >>> for the composite device the FC clear bit remains set until we
> >>> process the last interrupt on the CPU 1 side in your scenario. Or
> >>> am I wrong?
> >>
> >> You're not wrong. You're agreeing with everything I've described.  :)
> >>
> > 
> > I'm happy our understanding seems to converge! :)
> > 
> > My problem is that you tie the denial of SSCH to outstanding interrupts
> > ("C) A SSCH cannot be issued while an interrupt is outstanding") while
> > the PoP says "Condition code 2 is set, and no other action is
> > taken, when a start, halt, or clear function is currently
> > in progress at the subchannel (see “Function Control
> > (FC)” on page 16-22)".
> > 
> > This may or man not be what you have actually implemented, but it is what
> > you describe in this cover letter. Also patches 2 and 3 do the 
> > serialization operate on activity controls instead of on the function
> > controls (as described by the PoP).
> 
> You are conflating two issues here...
> 
> 1) I do use the ACTL bits in this RFC, which is almost certainly wrong
> according to the POPs. But as I suggest here in this cover letter as
> well as the commit message for later patches, that's irrelevant. We're
> not reflecting these particular bits (or anything else in this SCSW)
> back in any way/shape/form today, and they are not used for any other
> decision making. I could signal the existence of another operation by
> the FSM, or via three non-architected flags, or via the (correct)
> architected flags.

I got that. But please consider that code is read by humans. And if the
human sees ACTL he is likely to think ACTL.

> 
> 2) The denial of the SSCH. You quote the POPs above which says "no other
> action is taken, when a start, halt, or clear function is currently in
> progress at the subchannel" ... But in this case, vfio-ccw has to
> supplement the role of the subchannel. It's NOT done processing the
> interrupt, even though the device, subchannel, and (host) CPU think it
> all is.

I think we are talking about the same. The words of the PoP need to
be interpreted with respect to the subchannel as seen by the guest.

Each entity in the stack is basically manipulating a subchannel. The
guest certainly, the API exposed to the userspace (QEMU) is
essentially also about manipulatiting a subchannel, and the kernel
manipulates the passed through subchannel (and the passed through dasd
sits behind the passed through subchannel).

What is the relationship between these at any point in time 
is the thing that needs to be well understood (and well documented).

[..]

> >>> Implementing the FSM described in the PoP (which in turn
> >>> conceptually relies on atomic operations on the FC bits) is IMHO
> >>> the way to go. But we can track that info in our FSM states. In
> >>> fact our FSM states should just add sub-partitioning of states to
> >>> those states (if necessary).
> >>
> >> I'm not prepared to rule this out, as I originally stated, but I'm not
> >> thrilled with this idea. Today, we have FSM events for an IO (START) and
> >> asynchronous commands (HALT and CLEAR), and we have FSM states for the
> >> different stages of a START operation. Making asynchronous commands
> >> affect the FSM state isn't too big of a problem, but what happens if we
> >> expand the asynchronous support to handle other commands, such as CANCEL
> >> or RESUME? They don't have FC bits of their own to map into an FSM, and
> >> (just like HALT/CLEAR) have some reliance on the fctl/actl/stctl bits of
> >> the SCHIB.
> >>
> > 
> > Well, fctl/actl/stctl can be seen as a possible representation of states
> > and state transitions. For example for RESUME the PoP says
> > "Condition code 2 is set, and no other action is
> > taken, when the resume function is not applicable.
> > The resume function is not applicable when the sub-
> > channel (1) has any function other than the start
> > function alone specified, (2) has no function speci-
> > fied, (3) is resume pending, or (4) does not have sus-
> > pend control specified for the start function in
> > progress"
> > 
> > What I'm trying to say is, there is a state machine described in the PoP,
> > and there the state transitions are marked by interlocked updates of bits
> > in fctl/actl/stctl. I don't know how many bits relevant for the state
> > machine are, but I'm pretty confident they can be packaged up in a
> > quadword. So if we want we can represent that stuff with a state variable
> > of ours.
> > 
> > BTW the whole notion of synchronous and asynchronous commands is IMHO
> > broken. I tried to argue against it back then. If you read the PoP SSCH
> > is asynchronous as well.
> 
> That is my fault. I was only trying to distinguish the existing
> io_region used for SSCH and the new async_region used for HSCH and CSCH.
> 

Not your fault. It is mine. I never understood these name and they
make me nervous.

Regards,
Halil
