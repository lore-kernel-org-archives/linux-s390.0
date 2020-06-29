Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44925 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726967AbgF2S6r (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 29 Jun 2020 14:58:47 -0400
Date: Mon, 29 Jun 2020 16:56:29 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH v3 0/3] vfio-ccw: Fix interrupt handling for
 HALT/CLEAR
Message-ID: <20200629165629.24f21585.cohuck@redhat.com>
In-Reply-To: <5ae6151b-31de-eca6-2917-4e23ecd4f0df@linux.ibm.com>
References: <20200616195053.99253-1-farman@linux.ibm.com>
        <5ae6151b-31de-eca6-2917-4e23ecd4f0df@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Jared Rossi <jrossi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Wed, 17 Jun 2020 07:24:17 -0400
Eric Farman <farman@linux.ibm.com> wrote:

> On 6/16/20 3:50 PM, Eric Farman wrote:
> > Let's continue our discussion of the handling of vfio-ccw interrupts.
> > 
> > The initial fix [1] relied upon the interrupt path's examination of the
> > FSM state, and freeing all resources if it were CP_PENDING. But the
> > interface used by HALT/CLEAR SUBCHANNEL doesn't affect the FSM state.
> > Consider this sequence:
> > 
> >     CPU 1                           CPU 2
> >     CLEAR (state=IDLE/no change)
> >                                     START [2]
> >     INTERRUPT (set state=IDLE)
> >                                     INTERRUPT (set state=IDLE)
> > 
> > This translates to a couple of possible scenarios:
> > 
> >  A) The START gets a cc2 because of the outstanding CLEAR, -EBUSY is
> >     returned, resources are freed, and state remains IDLE
> >  B) The START gets a cc0 because the CLEAR has already presented an
> >     interrupt, and state is set to CP_PENDING
> > 
> > If the START gets a cc0 before the CLEAR INTERRUPT (stacked onto a
> > workqueue by the IRQ context) gets a chance to run, then the INTERRUPT
> > will release the channel program memory prematurely. If the two
> > operations run concurrently, then the FSM state set to CP_PROCESSING
> > will prevent the cp_free() from being invoked. But the io_mutex
> > boundary on that path will pause itself until the START completes,
> > and then allow the FSM to be reset to IDLE without considering the
> > outstanding START. Neither scenario would be considered good.
> > 
> > Having said all of that, in v2 Conny suggested [3] the following:
> >   
> >> - Detach the cp from the subchannel (or better, remove the 1:1
> >>   relationship). By that I mean building the cp as a separately
> >>   allocated structure (maybe embedding a kref, but that might not be
> >>   needed), and appending it to a list after SSCH with cc=0. Discard it
> >>   if cc!=0.
> >> - Remove the CP_PENDING state. The state is either IDLE after any
> >>   successful SSCH/HSCH/CSCH, or a new state in that case. But no
> >>   special state for SSCH.
> >> - A successful CSCH removes the first queued request, if any.
> >> - A final interrupt removes the first queued request, if any.  
> > 
> > What I have implemented here is basically this, with a few changes:
> > 
> >  - I don't queue cp's. Since there should only be one START in process
> >    at a time, and HALT/CLEAR doesn't build a cp, I didn't see a pressing
> >    need to introduce that complexity.
> >  - Furthermore, while I initially made a separately allocated cp, adding
> >    an alloc for a cp on each I/O AND moving the guest_cp alloc from the
> >    probe path to the I/O path seems excessive. So I implemented a
> >    "started" flag to the cp, set after a cc0 from the START, and examine
> >    that on the interrupt path to determine whether cp_free() is needed.  
> 
> FYI... After a day or two of running, I sprung a kernel debug oops for
> list corruption in ccwchain_free(). I'm going to blame this piece, since
> it was the last thing I changed and I hadn't come across any such damage
> since v2. So either "started" is a bad idea, or a broken one. Or both. :)

Have you come to any conclusion wrt 'started'? Not wanting to generate
stress, just asking :)
