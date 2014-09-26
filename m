From: Frank Blaschka <blaschka@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC patch 0/6] vfio based pci pass-through for
	qemu/KVM on s390
Date: Fri, 26 Sep 2014 08:45:14 +0200
Message-ID: <20140926064514.GA13550@tuxmaker.boeblingen.de.ibm.com>
References: <20140919115429.557279920@de.ibm.com> <1411418851.1199.137.camel@ul30vt.home> <20140924084727.GA17378@tuxmaker.boeblingen.de.ibm.com> <1411574757.24563.101.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1411574757.24563.101.camel@ul30vt.home>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-s390@vger.kernel.org, frank.blaschka@de.ibm.com, kvm@vger.kernel.org, agraf@suse.de, qemu-devel@nongnu.org, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, Sep 24, 2014 at 10:05:57AM -0600, Alex Williamson wrote:
> On Wed, 2014-09-24 at 10:47 +0200, Frank Blaschka wrote:
> > On Mon, Sep 22, 2014 at 02:47:31PM -0600, Alex Williamson wrote:
> > > On Fri, 2014-09-19 at 13:54 +0200, frank.blaschka@de.ibm.com wrote:
> > > > This set of patches implements a vfio based solution for pci
> > > > pass-through on the s390 platform. The kernel stuff is pretty
> > > > much straight forward, but qemu needs more work.
> > > > 
> > > > Most interesting patch is:
> > > >   vfio: make vfio run on s390 platform
> > > > 
> > > > I hope Alex & Alex can give me some guidance how to do the changes
> > > > in an appropriate way. After creating a separate iommmu address space
> > > > for each attached PCI device I can successfully run the vfio type1
> > > > iommu. So If we could extend type1 not registering all guest memory
> > > > (see patch) I think we do not need a special vfio iommu for s390
> > > > for the moment.
> > > > 
> > > > The patches implement the base pass-through support. s390 specific
> > > > virtualization functions are currently not included. This would
> > > > be a second step after the base support is done.
> > > > 
> > > > kernel patches apply to linux-kvm-next
> > > > 
> > > > KVM: s390: Enable PCI instructions
> > > > iommu: add iommu for s390 platform
> > > > vfio: make vfio build on s390
> > > > 
> > > > qemu patches apply to qemu-master
> > > > 
> > > > s390: Add PCI bus support
> > > > s390: implement pci instruction
> > > > vfio: make vfio run on s390 platform
> > > > 
> > > > Thx for feedback and review comments
> > > 
> > > Sending patches as attachments makes it difficult to comment inline.
> > >
> > Sorry, don't understand this. I sent every patch as separate email so
> > you can comment directly on the patch. What do you prefer?
> 
> The patches in each email are showing up as attachments in my mail
> client.  Is it just me?
> 
> > > 2/6
> > >  - careful of the namespace as you're changing functions from static and
> > > exporting them
> > >  - doesn't seem like functions need to be exported, just non-static to
> > > call from s390-iommu.c
> > > 
> > Ok, will change this.
> > 
> > > 6/6
> > >  - We shouldn't need to globally disable mmap, each VFIO region reports
> > > whether it supports mmap and vfio-pci on s390 should indicate mmap is
> > > not supported on the platform.
> > Yes, this is even better to let the kernel announce a BAR can not be
> > mmap'ed. Checking the kernel code I realized the BARs are valid for
> > mmap'ing but the s390 platform does simply not allow this. So I feal we
> > have to introduce a platform switch in kernel. How about this ...
> > 
> > --- a/drivers/vfio/pci/vfio_pci.c
> > +++ b/drivers/vfio/pci/vfio_pci.c
> > @@ -377,9 +377,11 @@ static long vfio_pci_ioctl(void *device_
> > 
> >                         info.flags = VFIO_REGION_INFO_FLAG_READ |
> >                                      VFIO_REGION_INFO_FLAG_WRITE;
> > +#ifndef CONFIG_S390
> >                         if (pci_resource_flags(pdev, info.index) &
> >                             IORESOURCE_MEM && info.size >= PAGE_SIZE)
> >                                 info.flags |= VFIO_REGION_INFO_FLAG_MMAP;
> > +#endif
> >                         break;
> >                 case VFIO_PCI_ROM_REGION_INDEX:
> >                 {
> 
> Maybe pull it out into a function.  Also, is there some capability or
> feature we can test rather than just the architecture?  I'd prefer it to
> be excluded because of a platform feature that prevents it rather than
> the overall architecture itself.
>

Ok, understand this. There is no capability of feature so I will go with
the function.
 
> > >  - INTx should be done the same way, the interrupt index for INTx should
> > > report 0 count.  The current code likely doesn't handle this, but it
> > > should be easy to fix.
> > The current code is fine. Problem is the card reports an interrupt index
> > (PCI_INTERRUPT_PIN) but again the platform does not support INTx at all.
> > So we need a platform switch as well. 
> 
> Yep, let's try to do something consistent with the MMAP testing.
>

Do you mean let the kernel announce this also?

> > >  - s390_msix_notify() vs msix_notify() should be abstracted somewhere
> > 
> > Platform does not have have an apic so there is nothing we could emulate
> > in qemu to make the existing msix_notify() work.
> > 
> > > else.  How would an emulated PCI device with MSI-X support work?
> > >  - same for add_msi_route
> > Same here, we have to setup an adapter route due to the fact MSIX
> > notifications are delivered as adapter/thin IRQs on the platform.
> > 
> > Any suggestion or idea how a better abstraction could look like?
> > 
> > With all the platform constraints I was not able to find a suitable
> > emulated device. Remember s390:
> > - does not support IO BARs
> > - does not support INTx only MSIX
> 
> What about MSI (non-X)?

In theory MSI should work also but I have not seen in reality.

> 
> > - in reality currently there is only a PCI network card available
> 
> On the physical hardware?
> 

yes

> > - platform does not support fancy I/O like usb or audio :-)
> >   So we don't even have kernel (host and guest) support for this
> >   kind of devices.
> 
> Does that mean you couldn't?  What about virtio-net-pci with MSI-X
> interrupts or emulated xhci with MSI-X interrupts, couldn't those be
> supported if s390 MSI-X were properly integrated into the QEMU MSI-X
> API?  vfio-pci isn't the right level to be switching between the
> standard API and the s390 API.
> 

Yes, I also think vfio might not be the best place to switch API. Will try
to move s390 specifics to MSI-X level. 

> > >  - We can probably come up with a better way to determine which address
> > > space to connect to the memory listener.
> > Any suggestion or idea for that?
> 
> I imagine you can tell by the address space of the device whether it
> lives behind an emulated IOMMU or not and therefore pick the closest
> address space for the notifier, the IOMMU or the system.  Thanks,
>

I do not undertand this in detail, can you elaborate a little bit more on this?
Or maybe provide a code snip?

Thx Frank
 
> Alex
> 
> 
