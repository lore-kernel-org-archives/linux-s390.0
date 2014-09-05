From: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC][patch 0/6] pci pass-through support for qemu/KVM on s390
Date: Fri, 05 Sep 2014 10:21:27 +0200
Message-ID: <54097287.1000006@suse.de>
References: <20140904105223.336503578@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20140904105223.336503578@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: frank.blaschka@de.ibm.com, qemu-devel@nongnu.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: aik@ozlabs.ru, pbonzini@redhat.com, Alex Williamson <alex.williamson@redhat.com>
List-ID: <linux-s390.vger.kernel.org>



On 04.09.14 12:52, frank.blaschka@de.ibm.com wrote:
> This set of patches implements pci pass-through support for qemu/KVM on s390.
> PCI support on s390 is very different from other platforms.
> Major differences are:
> 
> 1) all PCI operations are driven by special s390 instructions
> 2) all s390 PCI instructions are privileged
> 3) PCI config and memory spaces can not be mmap'ed

That's ok, vfio abstracts config space anyway.

> 4) no classic interrupts (INTX, MSI). The pci hw understands the concept
>    of requesting MSIX irqs but irqs are delivered as s390 adapter irqs.

This is in line with other implementations. Interrupts go from

  device -> PHB -> PIC -> CPU

(some times you can have another converter device in between)

In your case, the PHB converts INTX and MSI interrupts to Adapter
interrupts to go to the floating interrupt controller. Same thing as
everyone else really.

> 5) For DMA access there is always an IOMMU required. s390 pci implementation
>    does not support a complete memory to iommu mapping, dma mappings are
>    created on request.

Sounds great :). So I suppose we should implement a guest facing IOMMU?

> 6) The OS does not get any informations about the physical layout
>    of the PCI bus.

So how does it know whether different devices are behind the same IOMMU
context? Or can we assume that every device has its own context?

> 7) To take advantage of system z specific virtualization features
>    we need to access the SIE control block residing in the kernel KVM

Pleas elaborate.

> 8) To enable system z specific virtualization features we have to manipulate
>    the zpci device in kernel.

Why?

> 
> For this reasons I decided to implement a kernel based approach similar
> to x86 device assignment. There is a new qemu device (s390-pci) representing a

I fail to see the rationale and I definitely don't want to see anything
even remotely similar to the legacy x86 device assignment on s390 ;).

Can't we just enhance VFIO?

Also, I think we'll get the cleanest model if we start off with an
implementation that allows us to add emulated PCI devices to an s390x
machine and only then follow on with physical ones.


Alex
