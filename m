Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13580 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726896AbfGLN7n (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 12 Jul 2019 09:59:43 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6CDv3Vm132992
        for <linux-s390@vger.kernel.org>; Fri, 12 Jul 2019 09:59:41 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tptjujt3b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 12 Jul 2019 09:59:41 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Fri, 12 Jul 2019 14:59:39 +0100
Date: Fri, 12 Jul 2019 15:59:34 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC v2 4/5] vfio-ccw: Don't call cp_free if we are processing
 a channel program
In-Reply-To: <ed983668-44da-9e90-18b7-3f5d78164712@linux.ibm.com>
References: <cover.1562616169.git.alifm@linux.ibm.com>
        <1405df8415d3bff446c22753d0e9b91ff246eb0f.1562616169.git.alifm@linux.ibm.com>
        <20190709121613.6a3554fa.cohuck@redhat.com>
        <45ad7230-3674-2601-af5b-d9beef9312be@linux.ibm.com>
        <20190709162142.789dd605.pasic@linux.ibm.com>
        <87f7a37f-cc34-36fb-3a33-309e33bbbdde@linux.ibm.com>
        <20190711165703.3a1a8462.pasic@linux.ibm.com>
        <ed983668-44da-9e90-18b7-3f5d78164712@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Message-Id: <20190712155934.4eb38470.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Thu, 11 Jul 2019 16:09:22 -0400
Eric Farman <farman@linux.ibm.com> wrote:

> 
> 
> On 7/11/19 10:57 AM, Halil Pasic wrote:
> > On Tue, 9 Jul 2019 17:27:47 -0400
> > Farhan Ali <alifm@linux.ibm.com> wrote:
> > 
> >>
> >>
> >> On 07/09/2019 10:21 AM, Halil Pasic wrote:
> >>> On Tue, 9 Jul 2019 09:46:51 -0400
> >>> Farhan Ali <alifm@linux.ibm.com> wrote:
> >>>
> >>>>
> >>>>
> >>>> On 07/09/2019 06:16 AM, Cornelia Huck wrote:
> >>>>> On Mon,  8 Jul 2019 16:10:37 -0400
> >>>>> Farhan Ali <alifm@linux.ibm.com> wrote:
> >>>>>
> >>>>>> There is a small window where it's possible that we could be working
> >>>>>> on an interrupt (queued in the workqueue) and setting up a channel
> >>>>>> program (i.e allocating memory, pinning pages, translating address).
> >>>>>> This can lead to allocating and freeing the channel program at the
> >>>>>> same time and can cause memory corruption.
> >>>>>>
> >>>>>> Let's not call cp_free if we are currently processing a channel program.
> >>>>>> The only way we know for sure that we don't have a thread setting
> >>>>>> up a channel program is when the state is set to VFIO_CCW_STATE_CP_PENDING.
> >>>>>
> >>>>> Can we pinpoint a commit that introduced this bug, or has it been there
> >>>>> since the beginning?
> >>>>>
> >>>>
> >>>> I think the problem was always there.
> >>>>
> >>>
> >>> I think it became relevant with the async stuff. Because after the async
> >>> stuff was added we start getting solicited interrupts that are not about
> >>> channel program is done. At least this is how I remember the discussion.
> >>>
> > 
> > You seem to have ignored this comment. 
> 
> I read both comments as being in agreement with one another.

Which both comments do you see in agreement? The one that states 'was
always there' and the one that states 'was introduced by the async
series'?

> The
> problem has always been there, but didn't mean anything until we had
> another mechanism (async) to drive additional interrupts.  Hence the v3
> patch including the async patch in a Fixes tag.
> 

Sorry, when I started writing this response, there was no v3 out yet.
Later I've seen the Fixes tag in v3. I'm not sure it is the correct one
though. Hence my question about cp->is_initialized.

> > BTW wasn't the cp->is_initialized
> > make 'Make it safe to call the cp accessors in any case, so we can call
> > them unconditionally.'?
> > 
> > @Connie: Your opinion as the author of that patch and of the cited
> > sentence?
> > >>>>>>
> >>>>>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> >>>>>> ---
> >>>>>>    drivers/s390/cio/vfio_ccw_drv.c | 2 +-
> >>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> >>>>>> index 4e3a903..0357165 100644
> >>>>>> --- a/drivers/s390/cio/vfio_ccw_drv.c
> >>>>>> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> >>>>>> @@ -92,7 +92,7 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
> >>>>>>    		     (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT));
> >>>>>>    	if (scsw_is_solicited(&irb->scsw)) {
> >>>>>>    		cp_update_scsw(&private->cp, &irb->scsw);

<BACKREF_1>

> >>>>>> -		if (is_final)
> >>>>>> +		if (is_final && private->state == VFIO_CCW_STATE_CP_PENDING)
> >>>
> >>> Ain't private->state potentially used by multiple threads of execution?
> >>
> >> yes
> >>

</BACKREF_1>

> >> One of the paths I can think of is a machine check from the host which 
> >> will ultimately call vfio_ccw_sch_event callback which could set state 
> >> to NOT_OPER or IDLE.
> >>

<BACKREF_2>

> >>> Do we need to use atomic operations or external synchronization to avoid
> >>> this being another gamble? Or am I missing something?
> >>
> >> I think we probably should think about atomic operations for 
> >> synchronizing the state (and it could be a separate add on patch?).
> >>

</BACKREF_2>

> >> But for preventing 2 threads from stomping on the cp the check should be 
> >> enough, unless I am missing something?
> >>
> > 
> > Usually programming languages don't like incorrectly synchronized
> > programs. One tends to end up in undefined behavior land -- form language
> > perspective. That doesn't actually mean you are bound to see strange
> > stuff. With implementation spec + ABI spec + platform/architecture
> > spec one may end up with things being well defined. But it that is a much
> > deeper rabbit hole.
> > 
> > The nice thing about condition state == VFIO_CCW_STATE_CP_PENDING is
> > that it can tolerate stale state values. The bad case at hand
> > (you free but you should not) would be we see a stale
> > VFIO_CCW_STATE_CP_PENDING but we are actually
> > VFIO_CCW_STATE_CP_PROCESSING. That is pretty difficult to imagine
> > because one can enter VFIO_CCW_STATE_CP_PROCESSING only form
> > VFIO_CCW_STATE_CP_PENDING afair. 
> 
> I think you're backwards here.  The path is IDLE -> CP_PROCESSING ->
> (CP_PENDING | IDLE)

That is what I tried to say. The backwards twist probably comes from
the fact that I'm discussing what can happen if we read stale value
from state.

> 
> > On s390x torn reads/writes (i.e.
> > observing something that ain't either the old nor the new value) on an
> > int shouldn't be a concern.
> > 
> > The other bad case (where you don't free albeit you should) looks a
> > bit trickier.
> 
> I'm afraid I don't understand your intention with the above paragraphs.  :(
> 

All three paragraphs are about discussing what can happen or can not
happen in practice. The paragraph before those three is about the so
called academic aspects.

> > 
> > I'm not a fan of keeping races around without good reasons. And I don't
> > see good reasons here. I'm no fan of needlessly complicated solutions
> > either.
> > 
> > But seems, at least with my beliefs about races, I'm the oddball
> > here. 
> 
> The "race" here is that we have one synchronous operation (SSCH) and two
> asynchronous operations (HSCH, CSCH), both of which interact with one
> another and generate interrupts that pass through this chunk of code.
> 

I don't agree. Please consider the stuff between the <BACKREF_[12]> tags.
In my reading Farhan agrees that we have a data race on private->state.

If you did not get that, no wonder my email makes little sense.

> I have not fully considered this patch yet, but the race is a concern to
> all of us oddballs.  

Yes, but seems to a different extent. The rest of the guys are fine with
just plainly accessing private->state in <BACKREF_1>, and do different
logic based on the value, even though nobody seems to argue that the
accesses to private->state involve race.

> I have not chimed in any great detail because I
> only got through the first couple patches in v1 before going on holiday,
> and the discussions on v1/v2 are numerous.

My email was mostly addressed to Farhan, the author of the patch. No
need to for apologies. :)

Regards,
Halil
