Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2248 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729668AbfHOWeL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 15 Aug 2019 18:34:11 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7FMWAlU033026
        for <linux-s390@vger.kernel.org>; Thu, 15 Aug 2019 18:34:10 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2udemdbdnk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 15 Aug 2019 18:34:09 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Thu, 15 Aug 2019 23:34:07 +0100
Date: Fri, 16 Aug 2019 00:34:02 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH RFC UNTESTED] vfio-ccw: indirect access to translated
 cps
In-Reply-To: <20190808104306.2450bdcf.cohuck@redhat.com>
References: <20190726100617.19718-1-cohuck@redhat.com>
        <20190730174910.47930494.pasic@linux.ibm.com>
        <20190807132311.5238bc24.cohuck@redhat.com>
        <20190807160136.178e69de.pasic@linux.ibm.com>
        <20190808104306.2450bdcf.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Message-Id: <20190816003402.2a52b863.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Thu, 8 Aug 2019 10:43:06 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, 7 Aug 2019 16:01:36 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:

[..]

> > A respin of what? If you mean Pierre's "vfio: ccw: Make FSM functions
> > atomic" (https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1711466.html)
> > that won't work any more because of async.
> 
> s/respin/rework/, more likely.

Nod.

> 
> > 
> > > > 
> > > > Besides the only point of converting cp to a pointer seems to be
> > > > policing access to cp_area (which used to be cp). I.e. if it is
> > > > NULL: don't touch it, otherwise: go ahead. We can do that with a single
> > > > bit, we don't need a pointer for that.  
> > > 
> > > The idea was
> > > - do translation etc. on an area only accessed by the thread doing the
> > >   translation
> > > - switch the pointer to that area once the cp has been submitted
> > >   successfully (and it is therefore associated with further interrupts
> > >   etc.)
> > > The approach in this patch is probably a bit simplistic.
> > > 
> > > I think one bit is not enough, we have at least three states:
> > > - idle; start using the area if you like
> > > - translating; i.e. only the translator is touching the area, keep off
> > > - submitted; we wait for interrupts, handle them or free if no (more)
> > >   interrupts can happen  
> > 
> > I think your patch assigns the pointer when transitioning from
> > translated --> submitted. That can be tracked with a single bit, that's
> > what I was trying to say. You seem to have misunderstood: I never
> > intended to claim that a single bit is sufficient to get this clean (only
> > to accomplish what the pointer accomplishes -- modulo races).
> > 
> > My impression was that the 'initialized' field is abut the idle -->
> > translating transition, but I never fully understood this 'initialized'
> > patch.
> 
> So we do have three states here, right? (I hope we're not talking past
> each other again...)

Right, AFAIR  and without any consideration to fine details the three
states and two state transitions do make sense.

> 
> > 
> > >   
> > > > 
> > > > Could we convert initialized into some sort of cp.status that
> > > > tracks/controls access and responsibilities? By working with bits we
> > > > could benefit from the atomicity of bit-ops -- if I'm not wrong.  
> > > 
> > > We have both the state of the device (state machine) and the state of a
> > > cp, then. If we keep to a single cp area, we should track that within a
> > > single state (i.e. the device state).
> > >   
> > 
> > Maybe. Maybe not. I would have to write or see the code to figure that
> > out. Would we need additional states introduced to the device (state
> > machine)?
> 
> We might, but I don't think so. My point is that we probably want to
> track on a device level and not introduce extra tracking.
> 

OK

> > 
> > Anyway we do need to fix the races in the device state machine
> > for sure. I've already provided some food for thought (in form of a draft
> > patch) to Eric.
> 
> Any chance you could post that patch? :)
> 

Unfortunately I don't have the bandwidth to make a proper patch out of
it. The interactions are quite complex and it would take quite some time
to reach the point where I can say everything feels water-proof and
clean (inclusive testing). But since you seem curious about it I will
send you my draft work.

[..]

> > 
> > TL;DR I don't think having two cp areas make sense.
> 
> Let's stop going down that way further, I agree.
> 

Great!

Regards,
Halil
