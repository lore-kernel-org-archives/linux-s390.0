Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53073 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730273AbgDVK1z (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 22 Apr 2020 06:27:55 -0400
Date: Wed, 22 Apr 2020 12:27:46 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 0/8] s390x/vfio-ccw: Channel Path Handling [KVM]
Message-ID: <20200422122746.33c53ee3.cohuck@redhat.com>
In-Reply-To: <8acd4662-5a8b-ceda-108f-ed2cfac8dcee@linux.ibm.com>
References: <20200417023001.65006-1-farman@linux.ibm.com>
        <20200421173544.36b48657.cohuck@redhat.com>
        <8acd4662-5a8b-ceda-108f-ed2cfac8dcee@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>

On Tue, 21 Apr 2020 23:10:20 -0400
Eric Farman <farman@linux.ibm.com> wrote:

> On 4/21/20 11:35 AM, Cornelia Huck wrote:
> > On Fri, 17 Apr 2020 04:29:53 +0200
> > Eric Farman <farman@linux.ibm.com> wrote:
> >   
> >> Here is a new pass at the channel-path handling code for vfio-ccw.
> >> Changes from previous versions are recorded in git notes for each patch.
> >>
> >> I dropped the "Remove inline get_schid()" patch from this version.
> >> When I made the change suggested in v2, it seemed rather frivolous and
> >> better to just drop it for the time being.
> >>
> >> I suspect that patches 5 and 7 would be better squashed together, but I
> >> have not done that here.  For future versions, I guess.  
> > 
> > The result also might get a bit large.  
> 
> True.
> 
> Not that someone would pick patch 5 and not 7, but vfio-ccw is broken
> between them, because of a mismatch in IRQs.  An example from hotplug:
> 
> error: internal error: unable to execute QEMU command 'device_add':
> vfio: unexpected number of irqs 1
> 
> Maybe I just pull the CRW_IRQ definition into 5, and leave the wiring of
> the CRW stuff in 7.  That seems to leave a better behavior.

Ok, that makes sense.

> 
> >   
> >>
> >> With this, and the corresponding QEMU series (to be posted momentarily),
> >> applied I am able to configure off/on a CHPID (for example, by issuing
> >> "chchp -c 0/1 xx" on the host), and the guest is able to see both the
> >> events and reflect the updated path masks in its structures.  
> > 
> > Basically, this looks good to me (modulo my comments).  
> 
> Woo!  Thanks for the feedback; I'm going to try to get them all
> addressed in the next couple of days.
> 
> > 
> > One thing though that keeps coming up: do we need any kind of
> > serialization? Can there be any confusion from concurrent reads from
> > userspace, or are we sure that we always provide consistent data?
> >   
> 
> I'm feeling better with the rearrangement in this version of how we get
> data from the queue of CRWs into the region and off to the guest.  The
> weirdness I described a few months ago seems to have been triggered by
> one of the patches that's now been dropped.  But I'll walk through this
> code again once I get your latest comments applied.

Ok. Might also be nice if somebody else could spend some cycles looking
at this (hint, hint :)
