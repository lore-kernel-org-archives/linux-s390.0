Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39116 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726144AbgEONJw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 May 2020 09:09:52 -0400
Subject: Re: [RFC PATCH v2 0/4] vfio-ccw: Fix interrupt handling for
 HALT/CLEAR
References: <20200513142934.28788-1-farman@linux.ibm.com>
 <20200514154601.007ae46f.pasic@linux.ibm.com>
From: Eric Farman <farman@linux.ibm.com>
Message-ID: <4e00c83b-146f-9f1d-882b-a5378257f32c@linux.ibm.com>
Date: Fri, 15 May 2020 09:09:47 -0400
MIME-Version: 1.0
In-Reply-To: <20200514154601.007ae46f.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org



On 5/14/20 9:46 AM, Halil Pasic wrote:
> On Wed, 13 May 2020 16:29:30 +0200
> Eric Farman <farman@linux.ibm.com> wrote:
> 
>> Hi Conny,
>>
>> Back in January, I suggested a small patch [1] to try to clean up
>> the handling of HSCH/CSCH interrupts, especially as it relates to
>> concurrent SSCH interrupts. Here is a new attempt to address this.
>>
>> There was some suggestion earlier about locking the FSM, but I'm not
>> seeing any problems with that. Rather, what I'm noticing is that the
>> flow between a synchronous START and asynchronous HALT/CLEAR have
>> different impacts on the FSM state. Consider:
>>
>>     CPU 1                           CPU 2
>>
>>     SSCH (set state=CP_PENDING)
>>     INTERRUPT (set state=IDLE)
>>     CSCH (no change in state)
>>                                     SSCH (set state=CP_PENDING)
>>     INTERRUPT (set state=IDLE)
>>                                     INTERRUPT (set state=IDLE)
> 
> How does the PoP view of the composite device look like 
> (where composite device = vfio-ccw + host device)?

(Just want to be sure that "composite device" is a term that you're
creating, because it's not one I'm familiar with.)

In today's code, there isn't a "composite device" that contains
POPs-defined state information like we find in, for example, the host
SCHIB, but that incorporates vfio-ccw state. This series (in a far more
architecturally valid, non-RFC, form) would get us closer to that.

> 
> I suppose at the moment where we accept the CSCH the FC bit
> indicated clear function (19) goes to set. When this happens
> there are 2 possibilities: either the start (17) bit is set,
> or it is not. You describe a scenario where the start bit is
> not set. In that case we don't have a channel program that
> is currently being processed, and any SSCH must bounce right
> off without doing anything (with cc 2) as long as FC clear
> is set. Please note that we are still talking about the composite
> device here.

Correct. Though, whether the START function control bit is currently set
is immaterial to a CLEAR function; that's the biggest recovery action we
have at our disposal, and will always go through.

The point is that there is nothing to prevent the START on CPU 2 from
going through. The CLEAR does not affect the FSM today, and doesn't
record a FC CLEAR bit within vfio-ccw, and so we're only relying on the
return code from the SSCH instruction to give us cc0 vs cc2 (or
whatever). The actual results of that will depend, since the CPU may
have presented the interrupt for the CLEAR (via the .irq callback and
thus FSM VFIO_CCW_EVENT_INTERRUPT) and thus a new START is perfectly
legal from its point of view. Since vfio-ccw may not have unstacked the
work it placed to finish up that interrupt handler means we have a problem.

> 
> Thus in my reading CPU2 making the IDLE -> CP_PENDING transition
> happen is already wrong. We should have rejected to look at the
> channel program in the first place. Because as far as I can tell
> for the composite device the FC clear bit remains set until we
> process the last interrupt on the CPU 1 side in your scenario. Or
> am I wrong?

You're not wrong. You're agreeing with everything I've described.  :)

> 
> AFAIR I was preaching about this several times, but could never
> convince the people that 'let the host ccw device sort out
> concurrency' is not the way this should work.

I'm going to ignore this paragraph.

> 
> Maybe I have got a hole in my argument somewhere. If my argument
> is wrong, please do point out why!
> 
>>
>> The second interrupt on CPU 1 will call cp_free() for the START
>> created by CPU 2, and our results will be, um, messy. This
>> suggests that three things must be true:
>>
>>  A) cp_free() must be called for either a final interrupt,
>> or a failure issuing a SSCH
>>  B) The FSM state must only be set to IDLE once cp_free()
>> has been called
>>  C) A SSCH cannot be issued while an interrupt is outstanding
> 
> So you propose to reject SSCH in the IDLE state (if an interrupt
> is outstanding)? That is one silly IDLE state and FSM for sure.

And sending a HSCH/CSCH without affecting the FSM or a POPs-valid
structure is not silly?

> 
>>
>> It's not great that items B and C are separated in the interrupt
>> path by a mutex boundary where the copy into io_region occurs.
>> We could (and perhaps should) move them together, which would
>> improve things somewhat, but still doesn't address the scenario
>> laid out above. Even putting that work within the mutex window
>> during interrupt processing doesn't address things totally.
>>
>> So, the patches here do two things. One to handle unsolicited
>> interrupts [2], which I think is pretty straightforward. Though,
>> it does make me want to do a more drastic rearranging of the
>> affected function. :)
>>
>> The other warrants some discussion, since it's sort of weird.
>> Basically, recognize what commands we've issued, expect interrupts
>> for each, and prevent new SSCH's while asynchronous commands are
>> pending. It doesn't address interrupts from the HSCH/CSCH that
>> could be generated by the Channel Path Handling code [3] for an
>> offline CHPID yet, and it needs some TLC to make checkpatch happy.
>> But it's the best possibility I've seen thus far.
>>
>> I used private->scsw for this because it's barely used for anything
>> else; at one point I had been considering removing it outright because
>> we have entirely too many SCSW's in this code. :) I could implement
>> this as three small flags in private, to simplify the code and avoid
>> confusion with the different fctl/actl flags in private vs schib.
>>
> 
> Implementing the FSM described in the PoP (which in turn
> conceptually relies on atomic operations on the FC bits) is IMHO
> the way to go. But we can track that info in our FSM states. In
> fact our FSM states should just add sub-partitioning of states to
> those states (if necessary).

I'm not prepared to rule this out, as I originally stated, but I'm not
thrilled with this idea. Today, we have FSM events for an IO (START) and
asynchronous commands (HALT and CLEAR), and we have FSM states for the
different stages of a START operation. Making asynchronous commands
affect the FSM state isn't too big of a problem, but what happens if we
expand the asynchronous support to handle other commands, such as CANCEL
or RESUME? They don't have FC bits of their own to map into an FSM, and
(just like HALT/CLEAR) have some reliance on the fctl/actl/stctl bits of
the SCHIB.

The fact that you're talking about sub-partitioning of states, as we
have with CP_PROCESSING and CP_PENDING in the context of a START,
suggest we'd drift farther from what one actually finds in POPs and make
it harder to decipher what vfio-ccw is actually up to.

> 
> 
>> It does make me wonder whether the CP_PENDING check before cp_free()
>> is still necessary, but that's a query for a later date.
>>
>> Also, perhaps this could be accomplished with two new FSM states,
>> one for a HALT and one for a CLEAR. I put it aside because the
>> interrupt handler got a little hairy with that, but I'm still looking
>> at it in parallel to this discussion.
>>
> 
> You don't necessarily need 2 new states. Just one that corresponds
> to FC clear function will do.

I don't think so. Maybe for my example above regarding a CSCH, but we
can issue a HSCH in the same way today, and a HALT should also get a cc2
if either a HALT or CLEAR command is already in progress. Just as a
START should get cc2 for a START, HALT, or CLEAR.

> 
>> I look forward to hearing your thoughts...
> 
> Please see above ;)
> 
> Also why do we see the scenario you describe in the wild? I agree that
> this should be taken care of in the kernel as well, but according to my
> understanding QEMU is already supposed to reject the second SSCH (CPU 2)
> with cc 2 because it sees that FC clear function is set. Or?

Maybe for virtio, but for vfio this all gets passed through to the
kernel who makes that distinction. And as I've mentioned above, that's
not happening.

> 
> Regards,
> Halil
> 
>>
>> [1] https://lore.kernel.org/kvm/20200124145455.51181-1-farman@linux.ibm.com/
>> [2] https://lore.kernel.org/kvm/9635c45f-4652-c837-d256-46f426737a5e@linux.ibm.com/
>> [3] https://lore.kernel.org/kvm/20200505122745.53208-1-farman@linux.ibm.com/
>>
>> Eric Farman (4):
>>   vfio-ccw: Do not reset FSM state for unsolicited interrupts
>>   vfio-ccw: Utilize scsw actl to serialize start operations
>>   vfio-ccw: Expand SCSW usage to HALT and CLEAR
>>   vfio-ccw: Clean up how to react to a failed START
>>
>>  drivers/s390/cio/vfio_ccw_drv.c | 10 +++++++++-
>>  drivers/s390/cio/vfio_ccw_fsm.c | 26 ++++++++++++++++++++++++++
>>  drivers/s390/cio/vfio_ccw_ops.c |  3 +--
>>  3 files changed, 36 insertions(+), 3 deletions(-)
>>
> 
