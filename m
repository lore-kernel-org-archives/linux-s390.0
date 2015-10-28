From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Subject: Re: [PATCH v1 2/2] dma-mapping-common: add DMA attribute -
 DMA_ATTR_IOMMU_BYPASS
Date: Wed, 28 Oct 2015 13:10:49 +0200
Message-ID: <20151028111049.GA30785@shamir-ThinkPad-T430>
References: <1445789224-28032-1-git-send-email-shamir.rabinovitch@oracle.com>
 <1445789224-28032-2-git-send-email-shamir.rabinovitch@oracle.com>
 <1446013801.3405.183.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1446013801.3405.183.camel@infradead.org>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: arnd@arndb.de, corbet@lwn.net, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Joerg Roedel <jroedel@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, benh@kernel.crashing.org, KVM <kvm@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Oct 28, 2015 at 03:30:01PM +0900, David Woodhouse wrote:
> > > +For systems with IOMMU it is assumed all DMA translations use the IOMMU.
> 
> Not entirely true. We have per-device dma_ops on a most architectures
> already, and we were just talking about the need to add them to
> POWER/SPARC too, because we need to avoid trying to use the IOMMU to
> map virtio devices too.

SPARC has it's implementation under arch/sparc for dma_ops (sun4v_dma_ops).

Some drivers use IOMMU under SPARC for example ixgbe (Intel 10G ETH).
Some, like IB, suffer from IOMMU MAP setup/tear-down & limited address range.
On SPARC IOMMU bypass is not total bypass of the IOMMU but rather much simple
translation that does not require any complex translations tables.

> 
> As we look at that (and make the per-device dma_ops a generic thing
> rather than per-arch), we should probably look at folding your case in
> too.

Whether to use IOMMU or not for DMA is up to the driver. The above example
show real situation where one driver can use IOMMU and the other can't. It
seems that the device cannot know when to use IOMMU bypass and when not.
Even in the driver we can decide to DMA map some buffers using IOMMU
translation and some as IOMMU bypass.

Do you agree that we need this attribute in the generic DMA API? 

> 
> -- 
> dwmw2
> 
> 
