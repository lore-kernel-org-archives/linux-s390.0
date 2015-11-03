From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCHv3 0/3] dma ops and virtio
Date: Tue,  3 Nov 2015 12:54:36 +0100
Message-ID: <1446551679-33492-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, benh@kernel.crashing.org, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, dwmw2@infradead.org, Joerg Roedel <jroedel@suse.de>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, virtualization@lists.linux-foundation.org, Michael Tsirkin <mst@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Andy,
this is the next and hopefully last version. Seems to work fine
when replacing the previous patches in your tree. I have some
reviews/acks for patch 2 and 3. patch 1 still needs one ack.
Can you replace the patches in your tree and carry them along
with your changes?

old introduction:
-----
There are some attempts to unify the dma ops (Christoph) as well
as some attempts to make virtio use the dma API (Andy).

At kernel summit we concluded that we want to use the same code on all
platforms, whereever possible, so having a dummy dma_op might be the
easiest solution to keep virtio-ccw as similar as possible to
virtio-pci.Together with a fixed up patch set from Andy Lutomirski
this seems to work.  

We will also need a fixup for powerc and QEMU changes to make virtio
work with iommu on power and x86.
----

v2->v3:
- make dma-noop depend on HAS_DMA
- do not do memset on alloc
- prefix patches with *dma*
v1->v2:
- initial testing
- always use dma_noop_ops if device has no private dma_ops
- get rid of setup in virtio_ccw,kvm_virtio
- set CONFIG_HAS_DMA(ATTRS) for virtio (fixes compile for !PCI)
- rename s390_dma_ops to s390_pci_dma_ops


Christian Borntraeger (3):
  dma: Provide simple noop dma ops
  alpha/dma: use common noop dma ops
  s390/dma: Allow per device dma ops

 arch/alpha/kernel/pci-noop.c        | 46 ++---------------------
 arch/s390/Kconfig                   |  3 +-
 arch/s390/include/asm/device.h      |  6 ++-
 arch/s390/include/asm/dma-mapping.h |  6 ++-
 arch/s390/pci/pci.c                 |  1 +
 arch/s390/pci/pci_dma.c             |  4 +-
 include/linux/dma-mapping.h         |  2 +
 lib/Makefile                        |  1 +
 lib/dma-noop.c                      | 75 +++++++++++++++++++++++++++++++++++++
 9 files changed, 96 insertions(+), 48 deletions(-)
 create mode 100644 lib/dma-noop.c

-- 
2.4.3
