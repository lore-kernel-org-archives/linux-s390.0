Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43435 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728612AbgESLgP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 19 May 2020 07:36:15 -0400
Date: Tue, 19 May 2020 13:36:06 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH v2 0/4] vfio-ccw: Fix interrupt handling for
 HALT/CLEAR
Message-ID: <20200519133606.56e019b3.cohuck@redhat.com>
In-Reply-To: <20200519000943.70098774.pasic@linux.ibm.com>
References: <20200513142934.28788-1-farman@linux.ibm.com>
        <20200518180903.7cb21dd8.cohuck@redhat.com>
        <20200519000943.70098774.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Tue, 19 May 2020 00:09:43 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Mon, 18 May 2020 18:09:03 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:

> > But taking a step back (and ignoring your series and the discussion,
> > sorry about that):
> > 
> > We need to do something (creating a local translation of the guest's
> > channel program) that does not have any relation to the process in the
> > architecture at all, but is only something that needs to be done
> > because of what vfio-ccw is trying to do (issuing a channel program on
> > behalf of another entity.)   
> 
> I violently disagree with this point. Looking at the whole vfio-ccw
> device the translation is part of the execution of the channel program,
> more specifically it fits in as prefetching. Thus it needs to happen
> with the FC start bit set. Before FC start is set the subchannel is
> not allowed to process (including look at) the channel program. At least
> that is what I remember.

I fear we really have to agree to disagree here. The PoP describes how
a SSCH etc. has to be done and what reaction to expect. It does not
cover the 'SSCH on behalf of someone else' pattern: only what we can
expect from that second SSCH, and what the guest can expect from us. In
particular, the PoP does not specify anything about how a hypervisor is
supposed to handle I/O from its guests (and why should it?)

> 
> > Trying to sort that out by poking at actl
> > and fctl bits does not seem like the best way; especially as keeping
> > the bits up-to-date via STSCH is an exercise in futility.  
> 
> I disagree. A single subchannel is processing at most one channel
> program at any given point in time. Or am I reading the PoP wrong?

The hypervisor cannot know the exact status of the subchannel. It only
knows the state of the subchannel at the time it issued its last STSCH.
Anything else it needs to track is the hypervisor's business, and
ideally, it should track that in its own control structures. (I know we
muck around with the control bits today; but maybe that's not the best
idea.)

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
> See above. IMHO the second SSCH is to be rejected by QEMU. I've
> explained this in more detail in my previous mail.

I don't think we should rely on whatever QEMU is or isn't doing. We
should not get all tangled up if userspace is doing weird stuff.
