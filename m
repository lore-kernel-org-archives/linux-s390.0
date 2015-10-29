From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Subject: Re: [PATCH v1 2/2] dma-mapping-common: add DMA attribute -
 DMA_ATTR_IOMMU_BYPASS
Date: Thu, 29 Oct 2015 09:32:32 +0200
Message-ID: <20151029073231.GE30785@shamir-ThinkPad-T430>
References: <1445789224-28032-1-git-send-email-shamir.rabinovitch@oracle.com>
 <1445789224-28032-2-git-send-email-shamir.rabinovitch@oracle.com>
 <1446013801.3405.183.camel@infradead.org>
 <20151028111049.GA30785@shamir-ThinkPad-T430>
 <1446039110.3405.212.camel@infradead.org>
 <1446078721.1856.49.camel@kernel.crashing.org>
 <1446079332.3405.273.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1446079332.3405.273.camel@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, arnd@arndb.de, corbet@lwn.net, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Joerg Roedel <jroedel@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, KVM <kvm@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Oct 29, 2015 at 09:42:12AM +0900, David Woodhouse wrote:

> Aside from the lack of security, the other disadvantage of that is that
> you have to pin *all* pages of a guest in case DMA happens; you don't
> get to pin *only* those pages which are referenced by that guest's
> IOMMU page tables...

We do bypass the IOMMU but not the DMA API and given that before we call 
the DMA API we pin the page then we do not need to pin all the pages.
Just the ones we use for the DMA. 

For me this flag looks orthogonal to the page pinning issue you brought. It
is just a hint to the DMA API that we want to use simple & fast mapping while
knowing we loose IOMMU protection for this memory.

For the IB case, setting and tearing DMA mappings for the drivers data buffers
is expensive. But we could for example consider to map all the HW control objects
that validate the HW access to the drivers data buffers as IOMMU protected and so
have IOMMU protection on those critical objects while having fast set-up/tear-down
of driver data buffers. The HW control objects have stable mapping for the lifetime
of the system. So the case of using both types of DMA mappings is still valid. 
 
> 
> -- 
> dwmw2
> 
> 
