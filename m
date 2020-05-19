Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35080 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726949AbgESLXR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 19 May 2020 07:23:17 -0400
Date: Tue, 19 May 2020 13:23:06 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH v2 0/4] vfio-ccw: Fix interrupt handling for
 HALT/CLEAR
Message-ID: <20200519132306.0a3335ed.cohuck@redhat.com>
In-Reply-To: <33909b2e-2939-9345-175b-960697d05b4e@linux.ibm.com>
References: <20200513142934.28788-1-farman@linux.ibm.com>
        <20200518180903.7cb21dd8.cohuck@redhat.com>
        <33909b2e-2939-9345-175b-960697d05b4e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Jared Rossi <jrossi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Mon, 18 May 2020 17:57:39 -0400
Eric Farman <farman@linux.ibm.com> wrote:

> On 5/18/20 12:09 PM, Cornelia Huck wrote:
> > On Wed, 13 May 2020 16:29:30 +0200
> > Eric Farman <farman@linux.ibm.com> wrote:
> >   
> >> Hi Conny,
> >>
> >> Back in January, I suggested a small patch [1] to try to clean up
> >> the handling of HSCH/CSCH interrupts, especially as it relates to
> >> concurrent SSCH interrupts. Here is a new attempt to address this.
> >>
> >> There was some suggestion earlier about locking the FSM, but I'm not
> >> seeing any problems with that. Rather, what I'm noticing is that the
> >> flow between a synchronous START and asynchronous HALT/CLEAR have
> >> different impacts on the FSM state. Consider:
> >>
> >>     CPU 1                           CPU 2
> >>
> >>     SSCH (set state=CP_PENDING)
> >>     INTERRUPT (set state=IDLE)
> >>     CSCH (no change in state)
> >>                                     SSCH (set state=CP_PENDING)  
> > 
> > This is the transition I do not understand. When we get a request via
> > the I/O area, we go to CP_PROCESSING and start doing translations.
> > However, we only transition to CP_PENDING if we actually do a SSCH with
> > cc 0 -- which shouldn't be possible in the flow you outline... unless
> > it really is something that can be taken care of with locking (state
> > machine transitioning due to an interrupt without locking, so we go to
> > IDLE without other parts noticing.)  
> 
> I'm only going by what the (existing and my temporary) tea leaves in
> s390dbf are telling us. :)

/me makes a note to try tea leaves :)

> 
> >   
> >>     INTERRUPT (set state=IDLE)  
> 
> Part of the problem is that this is actually comprised of these elements:
> 
> if (irb_is_final && state == CP_PENDING)
> 	cp_free()
> 
> lock io_mutex
> copy irb to io_region
> unlock io_mutex
> 
> if (irb_is_final)
> 	state = IDLE
> 
> The CP_PENDING check will protect us if a SSCH is still being built at
> the time we execute this code. But if we got to CP_PENDING first
> (between fsm_irq() stacking to the workqueue and us unstacking
> vfio_ccw_sch_io_todo()), we would free an unrelated operation. (This was
> the scenario in the first version of my fix back in January.)
> 
> We can't add a CP_PENDING check after the io_mutex barrier, because if a
> second SSCH is being processed, we will hang on the lock acquisition and
> will DEFINITELY be in CP_PENDING state when we come back. But by that
> point, we will have skipped freeing the (now active) CP but are back in
> an IDLE state.

That's all very ugly :(

> 
> 
> >>                                     INTERRUPT (set state=IDLE)  
> > 
> > But taking a step back (and ignoring your series and the discussion,
> > sorry about that):  
> 
> No apologies necessary.
> 
> > 
> > We need to do something (creating a local translation of the guest's
> > channel program) that does not have any relation to the process in the
> > architecture at all, but is only something that needs to be done
> > because of what vfio-ccw is trying to do (issuing a channel program on
> > behalf of another entity.) Trying to sort that out by poking at actl
> > and fctl bits does not seem like the best way; especially as keeping
> > the bits up-to-date via STSCH is an exercise in futility.  
> 
> I am coming to strongly agree with this sentiment.

Thank you for making me feel like I'm not completely out in the weeds :)

> 
> > 
> > What about the following (and yes, I had suggested something vaguely in
> > that direction before):
> > 
> > - Detach the cp from the subchannel (or better, remove the 1:1
> >   relationship). By that I mean building the cp as a separately
> >   allocated structure (maybe embedding a kref, but that might not be
> >   needed), and appending it to a list after SSCH with cc=0. Discard it
> >   if cc!=0.
> > - Remove the CP_PENDING state. The state is either IDLE after any
> >   successful SSCH/HSCH/CSCH, or a new state in that case. But no
> >   special state for SSCH.
> > - A successful CSCH removes the first queued request, if any.
> > - A final interrupt removes the first queued request, if any.
> > 
> > Thoughts?
> >   
> 
> I'm cautiously optimistic, for exactly the reason I mention above. If we
> always expect to be in IDLE state once an interrupt arrives, we can just
> rely on determining if the interrupt is in relation to an actual
> operation we're waiting on. I'll give this a try and report back.

Great, good luck!
