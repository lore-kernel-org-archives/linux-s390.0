From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC patch 0/6] vfio based pci pass-through for qemu/KVM on s390
Date: Mon, 22 Sep 2014 14:47:31 -0600
Message-ID: <1411418851.1199.137.camel@ul30vt.home>
References: <20140919115429.557279920@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20140919115429.557279920@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: frank.blaschka@de.ibm.com
Cc: qemu-devel@nongnu.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com, agraf@suse.de
List-ID: <linux-s390.vger.kernel.org>

On Fri, 2014-09-19 at 13:54 +0200, frank.blaschka@de.ibm.com wrote:
> This set of patches implements a vfio based solution for pci
> pass-through on the s390 platform. The kernel stuff is pretty
> much straight forward, but qemu needs more work.
> 
> Most interesting patch is:
>   vfio: make vfio run on s390 platform
> 
> I hope Alex & Alex can give me some guidance how to do the changes
> in an appropriate way. After creating a separate iommmu address space
> for each attached PCI device I can successfully run the vfio type1
> iommu. So If we could extend type1 not registering all guest memory
> (see patch) I think we do not need a special vfio iommu for s390
> for the moment.
> 
> The patches implement the base pass-through support. s390 specific
> virtualization functions are currently not included. This would
> be a second step after the base support is done.
> 
> kernel patches apply to linux-kvm-next
> 
> KVM: s390: Enable PCI instructions
> iommu: add iommu for s390 platform
> vfio: make vfio build on s390
> 
> qemu patches apply to qemu-master
> 
> s390: Add PCI bus support
> s390: implement pci instruction
> vfio: make vfio run on s390 platform
> 
> Thx for feedback and review comments

Sending patches as attachments makes it difficult to comment inline.

2/6
 - careful of the namespace as you're changing functions from static and
exporting them
 - doesn't seem like functions need to be exported, just non-static to
call from s390-iommu.c

6/6
 - We shouldn't need to globally disable mmap, each VFIO region reports
whether it supports mmap and vfio-pci on s390 should indicate mmap is
not supported on the platform.
 - INTx should be done the same way, the interrupt index for INTx should
report 0 count.  The current code likely doesn't handle this, but it
should be easy to fix.
 - s390_msix_notify() vs msix_notify() should be abstracted somewhere
else.  How would an emulated PCI device with MSI-X support work?
 - same for add_msi_route
 - We can probably come up with a better way to determine which address
space to connect to the memory listener.

Looks like a reasonable first pass, good re-use of vfio code.  Thanks,

Alex
