Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49405 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725440AbgF3HIm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 30 Jun 2020 03:08:42 -0400
Date: Tue, 30 Jun 2020 09:08:25 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 1/1] s390: virtio: let arch accept devices without
 IOMMU feature
Message-ID: <20200630090825.18a439f5.cohuck@redhat.com>
In-Reply-To: <20200629171241-mutt-send-email-mst@kernel.org>
References: <1592390637-17441-1-git-send-email-pmorel@linux.ibm.com>
        <1592390637-17441-2-git-send-email-pmorel@linux.ibm.com>
        <20200629115952-mutt-send-email-mst@kernel.org>
        <66f808f2-5dd9-9127-d0e8-6bafbf13fc62@linux.ibm.com>
        <20200629171241-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Pierre Morel <pmorel@linux.ibm.com>, linux-kernel@vger.kernel.org, pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, jasowang@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com

On Mon, 29 Jun 2020 17:18:09 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Jun 29, 2020 at 06:48:28PM +0200, Pierre Morel wrote:
> > 
> > 
> > On 2020-06-29 18:09, Michael S. Tsirkin wrote:  
> > > On Wed, Jun 17, 2020 at 12:43:57PM +0200, Pierre Morel wrote:  
> > > > An architecture protecting the guest memory against unauthorized host
> > > > access may want to enforce VIRTIO I/O device protection through the
> > > > use of VIRTIO_F_IOMMU_PLATFORM.
> > > > Let's give a chance to the architecture to accept or not devices
> > > > without VIRTIO_F_IOMMU_PLATFORM.  
> > > 
> > > I agree it's a bit misleading. Protection is enforced by memory
> > > encryption, you can't trust the hypervisor to report the bit correctly
> > > so using that as a securoty measure would be pointless.
> > > The real gain here is that broken configs are easier to
> > > debug.
> > > 
> > > Here's an attempt at a better description:
> > > 
> > > 	On some architectures, guest knows that VIRTIO_F_IOMMU_PLATFORM is
> > > 	required for virtio to function: e.g. this is the case on s390 protected
> > > 	virt guests, since otherwise guest passes encrypted guest memory to devices,
> > > 	which the device can't read. Without VIRTIO_F_IOMMU_PLATFORM the
> > > 	result is that affected memory (or even a whole page containing
> > > 	it is corrupted). Detect and fail probe instead - that is easier
> > > 	to debug.  

s/guest/the guest/ (x2)

> > 
> > Thanks indeed better aside from the "encrypted guest memory": the mechanism
> > used to avoid the access to the guest memory from the host by s390 is not
> > encryption but a hardware feature denying the general host access and
> > allowing pieces of memory to be shared between guest and host.  
> 
> s/encrypted/protected/
> 
> > As a consequence the data read from memory is not corrupted but not read at
> > all and the read error kills the hypervizor with a SIGSEGV.  
> 
> s/(or even a whole page containing it is corrupted)/can not be
> 	read and the read error kills the hypervizor with a SIGSEGV/

s/hypervizor/hypervisor/

> 
> 
> As an aside, we could maybe handle that more gracefully
> on the hypervisor side.
> 
> >   
> > > 
> > > however, now that we have described what it is (hypervisor
> > > misconfiguration) I ask a question: can we be sure this will never
> > > ever work? E.g. what if some future hypervisor gains ability to
> > > access the protected guest memory in some abstractly secure manner?  
> > 
> > The goal of the s390 PV feature is to avoid this possibility so I don't
> > think so; however, there is a possibility that some hardware VIRTIO device
> > gain access to the guest's protected memory, even such device does not exist
> > yet.
> > 
> > At the moment such device exists we will need a driver for it, at least to
> > enable the feature and apply policies, it is also one of the reasons why a
> > hook to the architecture is interesting.  
> 
> 
> Not neessarily, it could also be fully transparent. See e.g.
> recent AMD andvances allowing unmodified guests with SEV.

I guess it depends on the architecture's protection mechanism and
threat model whether this makes sense.

> 
> 
> > > We are blocking this here, and it's hard to predict the future,
> > > and a broken hypervisor can always find ways to crash the guest ...  
> > 
> > yes, this is also something to fix on the hypervizor side, Halil is working
> > on it.
> >   
> > > 
> > > IMHO it would be safer to just print a warning.
> > > What do you think?  
> > 
> > Sadly, putting a warning may not help as qemu is killed if it accesses the
> > protected memory.
> > Also note that the crash occurs not only on start but also on hotplug.

Failing to start a guest is not that bad IMHO, but crashing a guest
that is running perfectly fine is. I vote for just failing the probe if
preconditions are not met.

> > 
> > Thanks,
> > Pierre  
> 
> Well that depends on where does the warning go. If it's on a serial port
> it might be reported host side before the crash triggers.  But
> interesting point generally. How about a feature to send a warning code
> or string to host then?

I would generally expect a guest warning to stay on the guest side --
especially as the host admin and the guest admin may be different
persons. So having a general way to send an alert to from a guest to
the host is not uninteresting, although we need to be careful to avoid
the guest being able to DOS the host.
