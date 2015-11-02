From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v1 2/2] dma-mapping-common: add DMA attribute -
 DMA_ATTR_IOMMU_BYPASS
Date: Mon, 2 Nov 2015 15:44:27 +0100
Message-ID: <20151102144427.GA2876@suse.de>
References: <1445789224-28032-1-git-send-email-shamir.rabinovitch@oracle.com>
 <1445789224-28032-2-git-send-email-shamir.rabinovitch@oracle.com>
 <1446013801.3405.183.camel@infradead.org>
 <20151028111049.GA30785@shamir-ThinkPad-T430>
 <1446039110.3405.212.camel@infradead.org>
 <1446078721.1856.49.camel@kernel.crashing.org>
 <1446079332.3405.273.camel@infradead.org>
 <20151029073231.GE30785@shamir-ThinkPad-T430>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151029073231.GE30785@shamir-ThinkPad-T430>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, arnd@arndb.de, corbet@lwn.net, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, KVM <kvm@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Oct 29, 2015 at 09:32:32AM +0200, Shamir Rabinovitch wrote:
> For the IB case, setting and tearing DMA mappings for the drivers data buffers
> is expensive. But we could for example consider to map all the HW control objects
> that validate the HW access to the drivers data buffers as IOMMU protected and so
> have IOMMU protection on those critical objects while having fast set-up/tear-down
> of driver data buffers. The HW control objects have stable mapping for the lifetime
> of the system. So the case of using both types of DMA mappings is still valid.

How do you envision this per-mapping by-pass to work? For the DMA-API
mappings you have only one device address space. For by-pass to work,
you need to map all physical memory of the machine into this space,
which leaves the question where you want to put the window for
remapping.

You surely have to put it after the physical mappings, but any
protection will be gone, as the device can access all physical memory.

So instead of working around the shortcomings of DMA-API
implementations, can you present us some numbers and analysis of how bad
the performance impact with an IOMMU is and what causes it?

I know that we have lock-contention issues in our IOMMU drivers, which
can be fixed. Maybe the performance problems you are seeing can be fixed
too, when you give us more details about them.


	Joerg
