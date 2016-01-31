From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v5 00/10] virtio DMA API, yet again
Date: Sun, 31 Jan 2016 22:12:32 +0200
Message-ID: <20160131201232.GA1643@redhat.com>
References: <cover.1454034075.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <sparclinux-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1454034075.git.luto@kernel.org>
Sender: sparclinux-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Woodhouse <dwmw2@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, KVM <kvm@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Vrabel <david.vrabel@citrix.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, xen-devel@lists.xenproject.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jan 28, 2016 at 06:31:13PM -0800, Andy Lutomirski wrote:
> This switches virtio to use the DMA API on Xen and if requested by
> module option.
> 
> This fixes virtio on Xen, and it should break anything because it's
> off by default on everything except Xen PV on x86.
> 
> To the Xen people: is this okay?  If it doesn't work on other Xen
> variants (PVH? HVM?), can you submit follow-up patches to fix it?
> 
> To everyone else: we've waffled on this for way too long.  I think
> we should to get DMA API implementation in with a conservative
> policy like this rather than waiting until we achieve perfection.
> I'm tired of carrying these patches around.

I agree, thanks for working on this!

> Michael, if these survive review, can you stage these in your tree?

Yes, I'll stage everything except 10/10. I'd rather not maintain a
module option like this, things work for now and I'm working on a
clean solution for things like dpdk within guest.

So far I saw some comments on 9/10.

> Can you also take a look at tools/virtio?  I probably broke it, but I
> couldn't get it to build without these patches either, so I'm stuck.

Will do.

> Changes from v4:
>  - Bake vring_use_dma_api in from the beginning.
>  - Automatically enable only on Xen.
>  - Add module parameter.
>  - Add s390 and alpha DMA API implementations.
>  - Rebase to 4.5-rc1.
> 
> Changes from v3:
>  - More big-endian fixes.
>  - Added better virtio-ring APIs that handle allocation and use them in
>    virtio-mmio and virtio-pci.
>  - Switch to Michael's virtio-net patch.
> 
> Changes from v2:
>  - Fix vring_mapping_error incorrect argument
> 
> Changes from v1:
>  - Fix an endian conversion error causing a BUG to hit.
>  - Fix a DMA ordering issue (swiotlb=force works now).
>  - Minor cleanups.
> 
> Andy Lutomirski (7):
>   vring: Introduce vring_use_dma_api()
>   virtio_ring: Support DMA APIs
>   virtio: Add improved queue allocation API
>   virtio_mmio: Use the DMA API if enabled
>   virtio_pci: Use the DMA API if enabled
>   vring: Use the DMA API on Xen
>   vring: Add a module parameter to force-enable the DMA API
> 
> Christian Borntraeger (3):
>   dma: Provide simple noop dma ops
>   alpha/dma: use common noop dma ops
>   s390/dma: Allow per device dma ops
> 
>  arch/alpha/kernel/pci-noop.c        |  46 +---
>  arch/s390/Kconfig                   |   6 +-
>  arch/s390/include/asm/device.h      |   6 +-
>  arch/s390/include/asm/dma-mapping.h |   6 +-
>  arch/s390/pci/pci.c                 |   1 +
>  arch/s390/pci/pci_dma.c             |   4 +-
>  drivers/virtio/Kconfig              |   2 +-
>  drivers/virtio/virtio_mmio.c        |  67 ++----
>  drivers/virtio/virtio_pci_common.h  |   6 -
>  drivers/virtio/virtio_pci_legacy.c  |  42 ++--
>  drivers/virtio/virtio_pci_modern.c  |  61 ++----
>  drivers/virtio/virtio_ring.c        | 412 ++++++++++++++++++++++++++++++------
>  include/linux/dma-mapping.h         |   2 +
>  include/linux/virtio.h              |  23 +-
>  include/linux/virtio_ring.h         |  35 +++
>  lib/Makefile                        |   1 +
>  lib/dma-noop.c                      |  75 +++++++
>  tools/virtio/linux/dma-mapping.h    |  17 ++
>  18 files changed, 568 insertions(+), 244 deletions(-)
>  create mode 100644 lib/dma-noop.c
>  create mode 100644 tools/virtio/linux/dma-mapping.h
> 
> -- 
> 2.5.0
