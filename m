From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 2/3] virtio_ring: Support DMA APIs
Date: Wed, 28 Oct 2015 11:06:50 +0900
Message-ID: <20151028020650.GA18467@suse.de>
References: <cover.1445994839.git.luto@kernel.org>
 <6b42014d04258c706c7c43ae739efb30e32496b9.1445994839.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6b42014d04258c706c7c43ae739efb30e32496b9.1445994839.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: linux-kernel@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, benh@kernel.crashing.org, KVM <kvm@vger.kernel.org>, dwmw2@infradead.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>
List-ID: <linux-s390.vger.kernel.org>

Hi Andy,

On Tue, Oct 27, 2015 at 06:17:09PM -0700, Andy Lutomirski wrote:
> From: Andy Lutomirski <luto@amacapital.net>
> 
> virtio_ring currently sends the device (usually a hypervisor)
> physical addresses of its I/O buffers.  This is okay when DMA
> addresses and physical addresses are the same thing, but this isn't
> always the case.  For example, this never works on Xen guests, and
> it is likely to fail if a physical "virtio" device ever ends up
> behind an IOMMU or swiotlb.

The overall code looks good, but I havn't seen and dma_sync* calls.
When swiotlb=force is in use this would break.

> +		vq->vring.desc[head].addr = cpu_to_virtio64(_vq->vdev, vring_map_single(
> +			vq,
> +			desc, total_sg * sizeof(struct vring_desc),
> +			DMA_TO_DEVICE));

Nit: I think readability could be improved here by using a temporary
variable for the return value of vring_map_single().


	Joerg
