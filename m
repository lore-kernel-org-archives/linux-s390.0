Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50676 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbfH1Mju (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Aug 2019 08:39:50 -0400
Date: Wed, 28 Aug 2019 14:39:47 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH RFC UNTESTED] vfio-ccw: indirect access to translated
 cps
Message-ID: <20190828143947.1c6b88e4.cohuck@redhat.com>
In-Reply-To: <20190816003402.2a52b863.pasic@linux.ibm.com>
References: <20190726100617.19718-1-cohuck@redhat.com>
        <20190730174910.47930494.pasic@linux.ibm.com>
        <20190807132311.5238bc24.cohuck@redhat.com>
        <20190807160136.178e69de.pasic@linux.ibm.com>
        <20190808104306.2450bdcf.cohuck@redhat.com>
        <20190816003402.2a52b863.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Fri, 16 Aug 2019 00:34:02 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Thu, 8 Aug 2019 10:43:06 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Wed, 7 Aug 2019 16:01:36 +0200
> > Halil Pasic <pasic@linux.ibm.com> wrote:  

> > > > > Besides the only point of converting cp to a pointer seems to be
> > > > > policing access to cp_area (which used to be cp). I.e. if it is
> > > > > NULL: don't touch it, otherwise: go ahead. We can do that with a single
> > > > > bit, we don't need a pointer for that.    
> > > > 
> > > > The idea was
> > > > - do translation etc. on an area only accessed by the thread doing the
> > > >   translation
> > > > - switch the pointer to that area once the cp has been submitted
> > > >   successfully (and it is therefore associated with further interrupts
> > > >   etc.)
> > > > The approach in this patch is probably a bit simplistic.
> > > > 
> > > > I think one bit is not enough, we have at least three states:
> > > > - idle; start using the area if you like
> > > > - translating; i.e. only the translator is touching the area, keep off
> > > > - submitted; we wait for interrupts, handle them or free if no (more)
> > > >   interrupts can happen    
> > > 
> > > I think your patch assigns the pointer when transitioning from
> > > translated --> submitted. That can be tracked with a single bit, that's
> > > what I was trying to say. You seem to have misunderstood: I never
> > > intended to claim that a single bit is sufficient to get this clean (only
> > > to accomplish what the pointer accomplishes -- modulo races).
> > > 
> > > My impression was that the 'initialized' field is abut the idle -->
> > > translating transition, but I never fully understood this 'initialized'
> > > patch.  
> > 
> > So we do have three states here, right? (I hope we're not talking past
> > each other again...)  
> 
> Right, AFAIR  and without any consideration to fine details the three
> states and two state transitions do make sense.

If we translate the three states to today's states in the fsm, we get:
- "idle" -> VFIO_CCW_STATE_IDLE
- "doing translation" -> VFIO_CCW_STATE_CP_PROCESSING
- "submitted" -> VFIO_CCW_STATE_CP_PENDING
and the transitions between the three already look fine to me (modulo
locking). We also seem to handle async requests correctly (-EAGAIN if
_PROCESSING, else just go ahead).

So we can probably forget about the approach in this patch, and
concentrate on eliminating races in state transitions.

Not sure what the best approach is for tackling these: intermediate
transit state, a mutex or another lock, running locked and running
stuff that cannot be done locked on workqueues (and wait for all work
to finish while disallowing new work while doing the transition)?

Clever ideas wanted :)
