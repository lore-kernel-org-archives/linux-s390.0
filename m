From: Frank Blaschka <blaschka@linux.vnet.ibm.com>
Subject: Re: [RFC][patch 0/6] pci pass-through support for qemu/KVM on s390
Date: Fri, 5 Sep 2014 13:39:54 +0200
Message-ID: <20140905113954.GB17325@tuxmaker.boeblingen.de.ibm.com>
References: <20140904105223.336503578@de.ibm.com> <54097287.1000006@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54097287.1000006@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: frank.blaschka@de.ibm.com, qemu-devel@nongnu.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, aik@ozlabs.ru, pbonzini@redhat.com, Alex Williamson <alex.williamson@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Sep 05, 2014 at 10:21:27AM +0200, Alexander Graf wrote:
> 
> 
> On 04.09.14 12:52, frank.blaschka@de.ibm.com wrote:
> > This set of patches implements pci pass-through support for qemu/KVM on s390.
> > PCI support on s390 is very different from other platforms.
> > Major differences are:
> > 
> > 1) all PCI operations are driven by special s390 instructions
> > 2) all s390 PCI instructions are privileged
> > 3) PCI config and memory spaces can not be mmap'ed
> 
> That's ok, vfio abstracts config space anyway.
> 
> > 4) no classic interrupts (INTX, MSI). The pci hw understands the concept
> >    of requesting MSIX irqs but irqs are delivered as s390 adapter irqs.
> 
> This is in line with other implementations. Interrupts go from
> 
>   device -> PHB -> PIC -> CPU
> 
> (some times you can have another converter device in between)
> 
> In your case, the PHB converts INTX and MSI interrupts to Adapter
> interrupts to go to the floating interrupt controller. Same thing as
> everyone else really.
> 

Yes, I think this can be done, but we need s390 specific changes in vfio.

> > 5) For DMA access there is always an IOMMU required. s390 pci implementation
> >    does not support a complete memory to iommu mapping, dma mappings are
> >    created on request.
> 
> Sounds great :). So I suppose we should implement a guest facing IOMMU?
> 
> > 6) The OS does not get any informations about the physical layout
> >    of the PCI bus.
> 
> So how does it know whether different devices are behind the same IOMMU
> context? Or can we assume that every device has its own context?

Actually yes

> 
> > 7) To take advantage of system z specific virtualization features
> >    we need to access the SIE control block residing in the kernel KVM
> 
> Pleas elaborate.
> 
> > 8) To enable system z specific virtualization features we have to manipulate
> >    the zpci device in kernel.
> 
> Why?
>

We have following s390 specific virtualization features:

1) interpretive execution of pci load/store instruction. If we use this function
   pci access does not get intercepted (no SIE exit) but is handled via microcode.
   To enable this we have to disable zpci device and enable it again with information
   from the SIE control block. Further in qemu problem is: vfio traps access to
   MSIX table so we have to find another way programming msix if we do not get
   intercepts for memory space access.

2) Adapter event forwarding (with alerting). This is a mechanism the adpater event (irq)
   is directly forwarded to the guest. To set this up we also need to manipulate
   the zpci device (in kernel) with information form the SIE block. Exploiting
   GISA is only one part of this mechanism.

Both might be possible with some more or less nice looking vfio extensions. As I said
before we have to dig more into. Also this can be further optimazation steps later
if we have a running vfio implementation on the platform. 
 
> > 
> > For this reasons I decided to implement a kernel based approach similar
> > to x86 device assignment. There is a new qemu device (s390-pci) representing a
> 
> I fail to see the rationale and I definitely don't want to see anything
> even remotely similar to the legacy x86 device assignment on s390 ;).
> 
> Can't we just enhance VFIO?
> 

Probably yes, but we need some vfio changes (kernel and qemu)

> Also, I think we'll get the cleanest model if we start off with an
> implementation that allows us to add emulated PCI devices to an s390x
> machine and only then follow on with physical ones.
> 

I can already do this. With some more s390 intercepts a device can be detected and
guest is able to access config/memory space. Unfortunately s390 platform does not
support I/O bars so non of the emulated devices will work on the platform ...

> 
> Alex
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
