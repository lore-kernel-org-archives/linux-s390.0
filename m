From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Subject: Re: [PATCH v1 2/2] dma-mapping-common: add DMA attribute -
 DMA_ATTR_IOMMU_BYPASS
Date: Mon, 2 Nov 2015 14:07:00 +0200
Message-ID: <20151102120659.GC4642@shamir-ThinkPad-T430>
References: <1446039110.3405.212.camel@infradead.org>
 <1446078721.1856.49.camel@kernel.crashing.org>
 <1446079332.3405.273.camel@infradead.org>
 <1446081046.1856.55.camel@kernel.crashing.org>
 <CALCETrXrzq1f9sMAbKcmhpEtiyq5FE871=4+YspA=X+RjD7p8Q@mail.gmail.com>
 <1446158125.4471.5.camel@infradead.org>
 <20151101074534.GC23022@shamir-ThinkPad-T430>
 <1446412249.4060.7.camel@kernel.crashing.org>
 <20151102072358.GA4642@shamir-ThinkPad-T430>
 <1446458434.4060.21.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1446458434.4060.21.camel@kernel.crashing.org>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Andy Lutomirski <luto@amacapital.net>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-arch <linux-arch@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Joerg Roedel <jroedel@suse.de>, Jonathan Corbet <corbet@lwn.net>, KVM <kvm@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Nov 02, 2015 at 09:00:34PM +1100, Benjamin Herrenschmidt wrote:
> 
> Chosing on a per-mapping basis *in the back end* might still make some

In my case, choosing mapping based on the hardware that will use this
mappings makes more sense. Most hardware are not that performance sensitive
as the Infiniband hardware.

> amount of sense. What I don't completely grasp is what does it give
> you to expose that choice to the *driver* all the way up the chain. Why
> does the driver knows better whether something should use the bypass or
> not ?

The driver know for what hardware it is mapping the memory so it know if
the memory will be used by performance sensitive hardware or not.

> 
> I can imagine some in-between setups, for example, on POWER (and
> probably x86), I could setup a window that is TCE-mapped (TCEs are our
> iommu PTEs) but used to create a 1:1 mapping. IE. A given TCE always
> map to the same physical page. I could then use map/unmap to adjust the
> protection, the idea being that only "relaxing" the protection requires
> flushing the IO TLB, ie, we could delay most flushes.

In your case, what will give the better performance - 1:1 mapping or IOMMU
mapping? When you say 'relaxing the protection' you refer to 1:1 mapping?

Also, how this 1:1 window address the security concerns that other raised
by other here?

> 
> But that sort of optimization only makes sense in the back-end.
> 
> So what was your original idea where you thought the driver was the
> right one to decide whether to use the bypass or not for a given map
> operation ? That's what I don't grasp... you might have a valid case
> that I just fail to see.

Please see above.

> 
> Cheers,
> Ben.
> 

I think that given that IOMMU bypass on per allocation basis raise some
concerns, the only path for SPARC is this:

1. Support 'iommu=pt' as x86 for total IOMMU as intermediate step. Systems
	that use Infiniband will be set to pass through.

2. Add support in DVMA which allow less contention on the IOMMU resources
	while doing the map/unmap, bigger address range and full protection.
	Still this is not clear what will be the performance cost of using
	DVMA.
