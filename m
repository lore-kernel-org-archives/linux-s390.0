From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC][patch 0/6] pci pass-through support for qemu/KVM on s390
Date: Thu, 04 Sep 2014 07:16:24 -0600
Message-ID: <1409836584.3804.268.camel@ul30vt.home>
References: <20140904105223.336503578@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20140904105223.336503578@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: frank.blaschka@de.ibm.com
Cc: qemu-devel@nongnu.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, aik@ozlabs.ru, pbonzini@redhat.com, agraf@suse.de
List-ID: <linux-s390.vger.kernel.org>

On Thu, 2014-09-04 at 12:52 +0200, frank.blaschka@de.ibm.com wrote:
> This set of patches implements pci pass-through support for qemu/KVM on s390.
> PCI support on s390 is very different from other platforms.
> Major differences are:
> 
> 1) all PCI operations are driven by special s390 instructions

Generating config cycles is always arch specific.

> 2) all s390 PCI instructions are privileged

While the operations to generate config cycles on x86 are not
privileged, they must be arbitrated between accesses, so in a sense
they're privileged.

> 3) PCI config and memory spaces can not be mmap'ed

VFIO has mapping flags that allow any region to specify mmap support.

> 4) no classic interrupts (INTX, MSI). The pci hw understands the concept
>    of requesting MSIX irqs but irqs are delivered as s390 adapter irqs.

VFIO delivers interrupts as eventfds regardless of the underlying
platform mechanism.

> 5) For DMA access there is always an IOMMU required.

x86 requires the same.

>  s390 pci implementation
>    does not support a complete memory to iommu mapping, dma mappings are
>    created on request.

Sounds like POWER.

> 6) The OS does not get any informations about the physical layout
>    of the PCI bus.

If that means that every device is isolated (seems unlikely for
multifunction devices) then that makes IOMMU group support really easy.

> 7) To take advantage of system z specific virtualization features
>    we need to access the SIE control block residing in the kernel KVM

The KVM-VFIO device allows interaction between VFIO devices and KVM.

> 8) To enable system z specific virtualization features we have to manipulate
>    the zpci device in kernel.

VFIO supports different device backends, currently pci_dev and working
towards platform devices.  zpci might just be an extension to standard
pci.

> For this reasons I decided to implement a kernel based approach similar
> to x86 device assignment. There is a new qemu device (s390-pci) representing a
> pass through device on the host. Here is a sample qemu device configuration:
> 
> -device s390-pci,host=0000:00:00.0
> 
> The device executes the KVM_ASSIGN_PCI_DEVICE ioctl to create a proxy instance
> in the kernel KVM and connect this instance to the host pci device.
> 
> kernel patches apply to linux-kvm
> 
> s390: cio: chsc function to register GIB
> s390: pci: export pci functions for pass-through usage
> KVM: s390: Add GISA support
> KVM: s390: Add PCI pass-through support
> 
> qemu patches apply to qemu-master
> 
> s390: Add PCI bus support
> s390: Add PCI pass-through device support
> 
> Feedback and discussion is highly welcome ...

KVM-based device assignment needs to go away.  It's a horrible model for
devices, it offers very little protection to the kernel, assumes every
device is fully isolated and visible to the IOMMU, relies on smattering
of sysfs files to operate, etc.  x86, POWER, and ARM are all moving to
VFIO-based device assignment.  Why is s390 special enough to repeat all
the mistakes that x86 did?  Thanks,

Alex
