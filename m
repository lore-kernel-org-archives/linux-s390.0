From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 3/3] virtio_pci: Use the DMA API
Date: Wed, 28 Oct 2015 11:15:30 +0900
Message-ID: <20151028021530.GC18467@suse.de>
References: <cover.1445994839.git.luto@kernel.org>
 <b954294d8716e96daf827b85594b0e6cbdd7c321.1445994839.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b954294d8716e96daf827b85594b0e6cbdd7c321.1445994839.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: linux-kernel@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, benh@kernel.crashing.org, KVM <kvm@vger.kernel.org>, dwmw2@infradead.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Oct 27, 2015 at 06:17:10PM -0700, Andy Lutomirski wrote:
> From: Andy Lutomirski <luto@amacapital.net>
> 
> This fixes virtio-pci on platforms and busses that have IOMMUs.  This
> will break the experimental QEMU Q35 IOMMU support until QEMU is
> fixed.  In exchange, it fixes physical virtio hardware as well as
> virtio-pci running under Xen.
> 
> We should clean up the virtqueue API to do its own allocation and
> teach virtqueue_get_avail and virtqueue_get_used to return DMA
> addresses directly.
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  drivers/virtio/virtio_pci_common.h |  3 ++-
>  drivers/virtio/virtio_pci_legacy.c | 19 +++++++++++++++----
>  drivers/virtio/virtio_pci_modern.c | 34 ++++++++++++++++++++++++----------
>  3 files changed, 41 insertions(+), 15 deletions(-)

Same here, you need to call the dma_sync* functions when passing data
from/to the virtio-device.

I think a good test for that is to boot a virtio kvm-guest with
swiotlb=force and see if it still works.



	Joerg
