From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v6 0/9] virtio DMA API, yet again
Date: Mon,  1 Feb 2016 10:00:50 -0800
Message-ID: <cover.1454349471.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Christian Borntraeger <borntraeger@de.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Andy Lutomirski <luto@kernel.org>, xen-devel@lists.xenproject.org, sparclinux@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, "David S. Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This switches virtio to use the DMA API on Xen and if requested by
module option.

This fixes virtio on Xen, and it should break anything because it's
off by default on everything except Xen PV on x86.

To the Xen people: is this okay?  If it doesn't work on other Xen
variants (PVH? HVM?), can you submit follow-up patches to fix it?

To everyone else: we've waffled on this for way too long.  I think
we should to get DMA API implementation in with a conservative
policy like this rather than waiting until we achieve perfection.
I'm tired of carrying these patches around.

Michael, if these survive review, can you stage these in your tree?
Can you also take a look at tools/virtio?  I probably broke it, but I
couldn't get it to build without these patches either, so I'm stuck.

Changes from v5:
 - Typo fixes (David Woodhouse)
 - Use xen_domain() to detect Xen (David Vrabel)
 - Pass struct vring_virtqueue * into vring_use_dma_api for future proofing
 - Removed module parameter (Michael)

Changes from v4:
 - Bake vring_use_dma_api in from the beginning.
 - Automatically enable only on Xen.
 - Add module parameter.
 - Add s390 and alpha DMA API implementations.
 - Rebase to 4.5-rc1.

Changes from v3:
 - More big-endian fixes.
 - Added better virtio-ring APIs that handle allocation and use them in
   virtio-mmio and virtio-pci.
 - Switch to Michael's virtio-net patch.

Changes from v2:
 - Fix vring_mapping_error incorrect argument

Changes from v1:
 - Fix an endian conversion error causing a BUG to hit.
 - Fix a DMA ordering issue (swiotlb=force works now).
 - Minor cleanups.

Andy Lutomirski (6):
  vring: Introduce vring_use_dma_api()
  virtio_ring: Support DMA APIs
  virtio: Add improved queue allocation API
  virtio_mmio: Use the DMA API if enabled
  virtio_pci: Use the DMA API if enabled
  vring: Use the DMA API on Xen

Christian Borntraeger (3):
  dma: Provide simple noop dma ops
  alpha/dma: use common noop dma ops
  s390/dma: Allow per device dma ops

 arch/alpha/kernel/pci-noop.c        |  46 +---
 arch/s390/Kconfig                   |   6 +-
 arch/s390/include/asm/device.h      |   6 +-
 arch/s390/include/asm/dma-mapping.h |   6 +-
 arch/s390/pci/pci.c                 |   1 +
 arch/s390/pci/pci_dma.c             |   4 +-
 drivers/virtio/Kconfig              |   2 +-
 drivers/virtio/virtio_mmio.c        |  67 ++----
 drivers/virtio/virtio_pci_common.h  |   6 -
 drivers/virtio/virtio_pci_legacy.c  |  42 ++--
 drivers/virtio/virtio_pci_modern.c  |  61 ++----
 drivers/virtio/virtio_ring.c        | 408 ++++++++++++++++++++++++++++++------
 include/linux/dma-mapping.h         |   2 +
 include/linux/virtio.h              |  23 +-
 include/linux/virtio_ring.h         |  35 ++++
 lib/Makefile                        |   1 +
 lib/dma-noop.c                      |  75 +++++++
 tools/virtio/linux/dma-mapping.h    |  17 ++
 18 files changed, 564 insertions(+), 244 deletions(-)
 create mode 100644 lib/dma-noop.c
 create mode 100644 tools/virtio/linux/dma-mapping.h

-- 
2.5.0
