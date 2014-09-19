From: frank.blaschka@de.ibm.com
Subject: [RFC patch 0/6] vfio based pci pass-through for qemu/KVM on s390
Date: Fri, 19 Sep 2014 13:54:29 +0200
Message-ID: <20140919115429.557279920@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: alex.williamson@redhat.com, pbonzini@redhat.com, agraf@suse.de
List-ID: <linux-s390.vger.kernel.org>

This set of patches implements a vfio based solution for pci
pass-through on the s390 platform. The kernel stuff is pretty
much straight forward, but qemu needs more work.

Most interesting patch is:
  vfio: make vfio run on s390 platform

I hope Alex & Alex can give me some guidance how to do the changes
in an appropriate way. After creating a separate iommmu address space
for each attached PCI device I can successfully run the vfio type1
iommu. So If we could extend type1 not registering all guest memory
(see patch) I think we do not need a special vfio iommu for s390
for the moment.

The patches implement the base pass-through support. s390 specific
virtualization functions are currently not included. This would
be a second step after the base support is done.

kernel patches apply to linux-kvm-next

KVM: s390: Enable PCI instructions
iommu: add iommu for s390 platform
vfio: make vfio build on s390

qemu patches apply to qemu-master

s390: Add PCI bus support
s390: implement pci instruction
vfio: make vfio run on s390 platform

Thx for feedback and review comments

Frank
