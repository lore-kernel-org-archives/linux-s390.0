From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: Re: [PATCHv2 0/3] dma ops and virtio
Date: Mon, 2 Nov 2015 16:27:05 +0100 (CET)
Message-ID: <alpine.LFD.2.11.1511021619541.1672@denkbrett>
References: <1446211237-111298-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1446211237-111298-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Andy Lutomirski <luto@kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, benh@kernel.crashing.org, KVM <kvm@vger.kernel.org>, dwmw2@infradead.org, Joerg Roedel <jroedel@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, virtualization@lists.linux-foundation.org, Michael Tsirkin <mst@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

Hi,

On Fri, 30 Oct 2015, Christian Borntraeger wrote:

> here is the 2nd version of providing an DMA API for s390.
> 
> There are some attempts to unify the dma ops (Christoph) as well
> as some attempts to make virtio use the dma API (Andy).
> 
> At kernel summit we concluded that we want to use the same code on all
> platforms, whereever possible, so having a dummy dma_op might be the
> easiest solution to keep virtio-ccw as similar as possible to
> virtio-pci.Together with a fixed up patch set from Andy Lutomirski
> this seems to work.  
> 
> We will also need a fixup for powerc and QEMU changes to make virtio
> work with iommu on power and x86.
> 
> TODO:
> - future add-on patches to also fold in x86 no iommu
> 	- dma_mask
> 	- checking?
> - make compilation of dma-noop dependent on something
> 
> v1->v2:
> - initial testing
> - always use dma_noop_ops if device has no private dma_ops
> - get rid of setup in virtio_ccw,kvm_virtio
> - set CONFIG_HAS_DMA(ATTRS) for virtio (fixes compile for !PCI)
> - rename s390_dma_ops to s390_pci_dma_ops
> 
> Christian Borntraeger (3):
>   Provide simple noop dma ops
>   alpha: use common noop dma ops
>   s390/dma: Allow per device dma ops
> 
>  arch/alpha/kernel/pci-noop.c        | 46 ++--------------------
>  arch/s390/Kconfig                   |  3 +-
>  arch/s390/include/asm/device.h      |  6 ++-
>  arch/s390/include/asm/dma-mapping.h |  6 ++-
>  arch/s390/pci/pci.c                 |  1 +
>  arch/s390/pci/pci_dma.c             |  4 +-
>  include/linux/dma-mapping.h         |  2 +
>  lib/Makefile                        |  2 +-
>  lib/dma-noop.c                      | 77 +++++++++++++++++++++++++++++++++++++
>  9 files changed, 98 insertions(+), 49 deletions(-)
>  create mode 100644 lib/dma-noop.c
> 
> -- 

I agree with these changes in principle. As long as we don't do MMIO
(writel and friends) on a dummy mapping we're fine.

Regards,
Sebastian
