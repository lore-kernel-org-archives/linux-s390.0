From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3 0/3] virtio DMA API core stuff
Date: Tue, 27 Oct 2015 23:38:57 -0700
Message-ID: <cover.1446014204.git.luto@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Joerg Roedel <jroedel@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, benh@kernel.crashing.org, KVM <kvm@vger.kernel.org>, dwmw2@infradead.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Andy Lutomirski <luto@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

This switches virtio to use the DMA API unconditionally.  I'm sure
it breaks things, but it seems to work on x86 using virtio-pci, with
and without Xen, and using both the modern 1.0 variant and the
legacy variant.

Changes from v2:
 - Fix really embarrassing bug.  This version actually works.

Changes from v1:
 - Fix an endian conversion error causing a BUG to hit.
 - Fix a DMA ordering issue (swiotlb=force works now).
 - Minor cleanups.

Andy Lutomirski (3):
  virtio_net: Stop doing DMA from the stack
  virtio_ring: Support DMA APIs
  virtio_pci: Use the DMA API

 drivers/net/virtio_net.c           |  53 +++++++----
 drivers/virtio/Kconfig             |   2 +-
 drivers/virtio/virtio_pci_common.h |   3 +-
 drivers/virtio/virtio_pci_legacy.c |  19 +++-
 drivers/virtio/virtio_pci_modern.c |  34 +++++--
 drivers/virtio/virtio_ring.c       | 187 ++++++++++++++++++++++++++++++-------
 tools/virtio/linux/dma-mapping.h   |  17 ++++
 7 files changed, 246 insertions(+), 69 deletions(-)
 create mode 100644 tools/virtio/linux/dma-mapping.h

-- 
2.4.3
