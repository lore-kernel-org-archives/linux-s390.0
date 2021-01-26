Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56808 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S316736AbhAZXUX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 26 Jan 2021 18:20:23 -0500
Date: Tue, 26 Jan 2021 16:18:17 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 4/4] vfio-pci/zdev: Introduce the zPCI I/O vfio region
Message-ID: <20210126161817.683485e0@omen.home.shazbot.org>
In-Reply-To: <9c363ff5-b76c-d697-98e2-cf091a404d15@linux.ibm.com>
References: <1611086550-32765-1-git-send-email-mjrosato@linux.ibm.com>
        <1611086550-32765-5-git-send-email-mjrosato@linux.ibm.com>
        <20210122164843.269f806c@omen.home.shazbot.org>
        <9c363ff5-b76c-d697-98e2-cf091a404d15@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: cohuck@redhat.com, schnelle@linux.ibm.com, pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 09:40:38 -0500
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> On 1/22/21 6:48 PM, Alex Williamson wrote:
> > On Tue, 19 Jan 2021 15:02:30 -0500
> > Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> >   
> >> Some s390 PCI devices (e.g. ISM) perform I/O operations that have very
> >> specific requirements in terms of alignment as well as the patterns in
> >> which the data is read/written. Allowing these to proceed through the
> >> typical vfio_pci_bar_rw path will cause them to be broken in up in such a
> >> way that these requirements can't be guaranteed. In addition, ISM devices
> >> do not support the MIO codepaths that might be triggered on vfio I/O coming
> >> from userspace; we must be able to ensure that these devices use the
> >> non-MIO instructions.  To facilitate this, provide a new vfio region by
> >> which non-MIO instructions can be passed directly to the host kernel s390
> >> PCI layer, to be reliably issued as non-MIO instructions.
> >>
> >> This patch introduces the new vfio VFIO_REGION_SUBTYPE_IBM_ZPCI_IO region
> >> and implements the ability to pass PCISTB and PCILG instructions over it,
> >> as these are what is required for ISM devices.  
> > 
> > There have been various discussions about splitting vfio-pci to allow
> > more device specific drivers rather adding duct tape and bailing wire
> > for various device specific features to extend vfio-pci.  The latest
> > iteration is here[1].  Is it possible that such a solution could simply
> > provide the standard BAR region indexes, but with an implementation that
> > works on s390, rather than creating new device specific regions to
> > perform the same task?  Thanks,
> > 
> > Alex
> > 
> > [1]https://lore.kernel.org/lkml/20210117181534.65724-1-mgurtovoy@nvidia.com/
> >   
> 
> Thanks for the pointer, I'll have to keep an eye on this.  An approach 
> like this could solve some issues, but I think a main issue that still 
> remains with relying on the standard BAR region indexes (whether using 
> the current vfio-pci driver or a device-specific driver) is that QEMU 
> writes to said BAR memory region are happening in, at most, 8B chunks 
> (which then, in the current general-purpose vfio-pci code get further 
> split up into 4B iowrite operations).  The alternate approach I'm 
> proposing here is allowing for the whole payload (4K) in a single 
> operation, which is significantly faster.  So, I suspect even with a 
> device specific driver we'd want this sort of a region anyhow..

Why is this device specific behavior?  It would be a fair argument that
acceptable device access widths for MMIO are always device specific, so
we should never break them down.  Looking at the PCI spec, a TLP
requires a dword (4-byte) aligned address with a 10-bit length field
indicating the number of dwords, so up to 4K data as you suggest is the
whole payload.  It's quite possible that the reason we don't have more
access width problems is that MMIO is typically mmap'd on other
platforms.  We get away with using the x-no-mmap=on flag for debugging,
but it's not unheard of that the device also doesn't work quite
correctly with that flag, which could be due to access width or timing
difference.

So really, I don't see why we wouldn't want to maintain the guest
access width through QEMU and the kernel interface for all devices.  It
seems like that should be our default vfio-pci implementation.  I think
we chose the current width based on the QEMU implementation that was
already splitting accesses, and it (mostly) worked.  Thanks,

Alex
