Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14842 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729408AbfHGOBq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Aug 2019 10:01:46 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x77Dm4WV075847
        for <linux-s390@vger.kernel.org>; Wed, 7 Aug 2019 10:01:44 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u7yc5jb3d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 07 Aug 2019 10:01:43 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Wed, 7 Aug 2019 15:01:42 +0100
Date: Wed, 7 Aug 2019 16:01:36 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH RFC UNTESTED] vfio-ccw: indirect access to translated
 cps
In-Reply-To: <20190807132311.5238bc24.cohuck@redhat.com>
References: <20190726100617.19718-1-cohuck@redhat.com>
        <20190730174910.47930494.pasic@linux.ibm.com>
        <20190807132311.5238bc24.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Message-Id: <20190807160136.178e69de.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Wed, 7 Aug 2019 13:23:11 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Tue, 30 Jul 2019 17:49:10 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Fri, 26 Jul 2019 12:06:17 +0200
> > Cornelia Huck <cohuck@redhat.com> wrote:
> > 
> > > We're currently keeping a single area for translated channel
> > > programs in our private structure, which is filled out when
> > > we are translating a channel program we have been given by
> > > user space and marked invalid again when we received an final
> > > interrupt for that I/O.
> > > 
> > > Unfortunately, properly tracking the lifetime of that cp is
> > > not easy: failures may happen during translation or right when
> > > it is sent to the hardware, unsolicited interrupts may trigger
> > > a deferred condition code, a halt/clear request may be issued
> > > while the I/O is supposed to be running, or a reset request may
> > > come in from the side. The _PROCESSING state and the ->initialized
> > > flag help a bit, but not enough.
> > > 
> > > We want to have a way to figure out whether we actually have a cp
> > > currently in progress, so we can update/free only when applicable.
> > > Points to keep in mind:
> > > - We will get an interrupt after a cp has been submitted iff ssch
> > >   finished with cc 0.
> > > - We will get more interrupts for a cp if the interrupt status is
> > >   not final.
> > > - We can have only one cp in flight at a time.
> > > 
> > > Let's decouple the actual area in the private structure from the
> > > means to access it: Only after we have successfully submitted a
> > > cp (ssch with cc 0), update the pointer in the private structure
> > > to point to the area used. Therefore, the interrupt handler won't
> > > access the cp if we don't actually expect an interrupt pertaining
> > > to it.
> > > 
> > > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > > ---
> > > 
> > > Just hacked this up to get some feedback, did not actually try it
> > > out. Not even sure if this is a sensible approach; if not, let's
> > > blame it on the heat and pretend it didn't happen :)
> > >   
> > 
> > Do not multiple threads access this new cp pointer (and at least one of
> > them writes)? If that is the case, it smells like a data race to me.
> 
> We might need some additional concurrent read/write handling on top, if
> state machine guarantees are not enough. (We may need a respin of the
> state machine locking for that, which we probably want anyway.)
> 

A respin of what? If you mean Pierre's "vfio: ccw: Make FSM functions
atomic" (https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1711466.html)
that won't work any more because of async.

> > 
> > Besides the only point of converting cp to a pointer seems to be
> > policing access to cp_area (which used to be cp). I.e. if it is
> > NULL: don't touch it, otherwise: go ahead. We can do that with a single
> > bit, we don't need a pointer for that.
> 
> The idea was
> - do translation etc. on an area only accessed by the thread doing the
>   translation
> - switch the pointer to that area once the cp has been submitted
>   successfully (and it is therefore associated with further interrupts
>   etc.)
> The approach in this patch is probably a bit simplistic.
> 
> I think one bit is not enough, we have at least three states:
> - idle; start using the area if you like
> - translating; i.e. only the translator is touching the area, keep off
> - submitted; we wait for interrupts, handle them or free if no (more)
>   interrupts can happen

I think your patch assigns the pointer when transitioning from
translated --> submitted. That can be tracked with a single bit, that's
what I was trying to say. You seem to have misunderstood: I never
intended to claim that a single bit is sufficient to get this clean (only
to accomplish what the pointer accomplishes -- modulo races).

My impression was that the 'initialized' field is abut the idle -->
translating transition, but I never fully understood this 'initialized'
patch.

> 
> > 
> > Could we convert initialized into some sort of cp.status that
> > tracks/controls access and responsibilities? By working with bits we
> > could benefit from the atomicity of bit-ops -- if I'm not wrong.
> 
> We have both the state of the device (state machine) and the state of a
> cp, then. If we keep to a single cp area, we should track that within a
> single state (i.e. the device state).
> 

Maybe. Maybe not. I would have to write or see the code to figure that
out. Would we need additional states introduced to the device (state
machine)?

Anyway we do need to fix the races in the device state machine
for sure. I've already provided some food for thought (in form of a draft
patch) to Eric.

> > 
> > > I also thought about having *two* translation areas and switching
> > > the pointer between them; this might be too complicated, though?  
> > 
> > We only have one channel program at a time or? I can't see the benefit
> > of having two areas.
> 
> We can only have one in flight at a time; we could conceivably have
> another one that is currently in the process of being built. The idea
> was to switch between the two (so processing an in-flight one cannot
> overwrite one that is currently being built); but I think this is too
> complicated.
> 

I suppose the subchannel as seen by the guest should have FC 'start' bit
before the first translation (processing) starts. Please have a look at
the PoP if you don't agree. I.e. the translation/processing should be
considered a part of the asynchronous start function at the channel
subsystem, that is, from the guest perspective, that channel program is
already 'in flight'. So it does not make sense to me, to start
translating another cp.

Yes, the current implementation does the translation in instruction
context, and not as a part of the async io function. IMHO that is at
least sub-optimal if not wrong. QEMU however sets SCSW_FCTL_START_FUNC
before calling css_do_ssch(), but that should not be guest observable,
because of BQL. That also means QEMU won't try to issue the next cp
before the previous one was processed by vfio-ccw (submitted via ssch or
rejected) because of BQL. And then SCSW_FCTL_START_FUNC should prevent
acceptance of the next one while the previous one is still relevant.

TL;DR I don't think having two cp areas make sense.

Regards,
Halil

Regards,
Halil
