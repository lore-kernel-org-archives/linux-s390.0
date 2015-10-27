From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 0/4] dma ops and virtio
Date: Tue, 27 Oct 2015 23:48:47 +0100
Message-ID: <1445986131-239566-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, benh@kernel.crashing.org, KVM <kvm@vger.kernel.org>, dwmw2@infradead.org, Joerg Roedel <jroedel@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This is an RFC to check if I am on the right track.  There
are some attempts to unify the dma ops (Christoph) as well
as some attempts to make virtio use the dma API (Andy).

At todays discussion at the kernel summit, we concluded that
we want to use the same code on all platforms, whereever
possible, so having a dummy dma_op might be the easiest
solution to keep virtio-ccw as similar as possible to
virtio-pci. Andy Lutomirski will rework his patchset to
unconditionally use the dma ops.  We will also need a
compatibility quirk for powerpc to bypass the iommu mappings
on older QEMU version (which translates to all versions as
of today) and per device, e.g.  via device tree.  Ben
Herrenschmidt will look into that.

Here is a very quick (still untested) shot at providing the s390 part:
- patch1: dummy dma ops, inspired by the alpha code
- patch2: replace some of the alpha functions with the dummy ones
- patch3: allow per device dma ops for s390
- patch4: wire up virtio dma ops

TODOs
- test (s390 virtio-ccw with Andis changes, s390 pci) and review
- check i386 nommu dma ops for potential improvements in the noop 
  handlers
- make dma-noop only compile when necessary

Christian Borntraeger (4):
  Provide simple noop dma ops
  alpha: use common noop dma ops
  s390/dma: Allow per device dma ops
  s390/virtio: use noop dma ops

 arch/alpha/kernel/pci-noop.c        | 46 ++--------------------
 arch/s390/include/asm/device.h      |  6 ++-
 arch/s390/include/asm/dma-mapping.h |  2 +-
 arch/s390/pci/pci.c                 |  1 +
 drivers/s390/virtio/kvm_virtio.c    |  2 +
 drivers/s390/virtio/virtio_ccw.c    |  2 +
 include/linux/dma-mapping.h         |  2 +
 lib/Makefile                        |  2 +-
 lib/dma-noop.c                      | 77 +++++++++++++++++++++++++++++++++++++
 9 files changed, 95 insertions(+), 45 deletions(-)
 create mode 100644 lib/dma-noop.c

-- 
2.4.3
