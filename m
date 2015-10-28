From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 3/3] virtio_pci: Use the DMA API
Date: Wed, 28 Oct 2015 11:25:24 +0900
Message-ID: <20151028022524.GE18467@suse.de>
References: <cover.1445994839.git.luto@kernel.org>
 <b954294d8716e96daf827b85594b0e6cbdd7c321.1445994839.git.luto@kernel.org>
 <20151028021530.GC18467@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151028021530.GC18467@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: linux-kernel@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, benh@kernel.crashing.org, KVM <kvm@vger.kernel.org>, dwmw2@infradead.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Oct 28, 2015 at 11:15:30AM +0900, Joerg Roedel wrote:
> Same here, you need to call the dma_sync* functions when passing data
> from/to the virtio-device.

Okay, forget about this comment. This patch only converts to
dma_coherent allocations, which don't need synchronization.

> I think a good test for that is to boot a virtio kvm-guest with
> swiotlb=force and see if it still works.

But this holds, Its a good way to test if your changes work with
bounce-buffering. Together with DMA_API_DEBUG you also see if your
specified dma_directions are right.



	Joerg
