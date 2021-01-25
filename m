Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 25 Jan 2021 16:42:52 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 4/4] vfio-pci/zdev: Introduce the zPCI I/O vfio region
Message-ID: <20210125164252.1d1af6cd.cohuck@redhat.com>
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
Cc: Alex Williamson <alex.williamson@redhat.com>, schnelle@linux.ibm.com, pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

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

I'm also wondering about device specific vs architecture/platform
specific handling.

If we're trying to support ISM devices, that's device specific
handling; but if we're trying to add more generic things like the large
payload support, that's not necessarily tied to a device, is it? For
example, could a device support large payload if plugged into a z, but
not if plugged into another machine?
