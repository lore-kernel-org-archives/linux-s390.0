From: frank.blaschka@de.ibm.com
Subject: [RFC][patch 0/6] pci pass-through support for qemu/KVM on s390
Date: Thu, 04 Sep 2014 12:52:23 +0200
Message-ID: <20140904105223.336503578@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: aik@ozlabs.ru, pbonzini@redhat.com, agraf@suse.de
List-ID: <linux-s390.vger.kernel.org>

This set of patches implements pci pass-through support for qemu/KVM on s390.
PCI support on s390 is very different from other platforms.
Major differences are:

1) all PCI operations are driven by special s390 instructions
2) all s390 PCI instructions are privileged
3) PCI config and memory spaces can not be mmap'ed
4) no classic interrupts (INTX, MSI). The pci hw understands the concept
   of requesting MSIX irqs but irqs are delivered as s390 adapter irqs.
5) For DMA access there is always an IOMMU required. s390 pci implementation
   does not support a complete memory to iommu mapping, dma mappings are
   created on request.
6) The OS does not get any informations about the physical layout
   of the PCI bus.
7) To take advantage of system z specific virtualization features
   we need to access the SIE control block residing in the kernel KVM
8) To enable system z specific virtualization features we have to manipulate
   the zpci device in kernel.

For this reasons I decided to implement a kernel based approach similar
to x86 device assignment. There is a new qemu device (s390-pci) representing a
pass through device on the host. Here is a sample qemu device configuration:

-device s390-pci,host=0000:00:00.0

The device executes the KVM_ASSIGN_PCI_DEVICE ioctl to create a proxy instance
in the kernel KVM and connect this instance to the host pci device.

kernel patches apply to linux-kvm

s390: cio: chsc function to register GIB
s390: pci: export pci functions for pass-through usage
KVM: s390: Add GISA support
KVM: s390: Add PCI pass-through support

qemu patches apply to qemu-master

s390: Add PCI bus support
s390: Add PCI pass-through device support

Feedback and discussion is highly welcome ...
Thx!

Frank
