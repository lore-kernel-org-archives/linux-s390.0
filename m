From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v1 2/2] dma-mapping-common: add DMA attribute -
 DMA_ATTR_IOMMU_BYPASS
Date: Mon, 02 Nov 2015 21:00:34 +1100
Message-ID: <1446458434.4060.21.camel@kernel.crashing.org>
References: <1446013801.3405.183.camel@infradead.org>
	 <20151028111049.GA30785@shamir-ThinkPad-T430>
	 <1446039110.3405.212.camel@infradead.org>
	 <1446078721.1856.49.camel@kernel.crashing.org>
	 <1446079332.3405.273.camel@infradead.org>
	 <1446081046.1856.55.camel@kernel.crashing.org>
	 <CALCETrXrzq1f9sMAbKcmhpEtiyq5FE871=4+YspA=X+RjD7p8Q@mail.gmail.com>
	 <1446158125.4471.5.camel@infradead.org>
	 <20151101074534.GC23022@shamir-ThinkPad-T430>
	 <1446412249.4060.7.camel@kernel.crashing.org>
	 <20151102072358.GA4642@shamir-ThinkPad-T430>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <20151102072358.GA4642@shamir-ThinkPad-T430>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Andy Lutomirski <luto@amacapital.net>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-arch <linux-arch@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Joerg Roedel <jroedel@suse.de>, Jonathan Corbet <corbet@lwn.net>, KVM <kvm@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2015-11-02 at 09:23 +0200, Shamir Rabinovitch wrote:
> To summary -
> 
> 1. The whole point of the IOMMU pass through was to get bigger address space
>         and faster map/unmap operations for performance critical hardware
> 2. SPARC IOMMU in particular has the ability to DVMA which adress all the 
>         protection concerns raised above. Not sure what will be the performance
>         impact though. This still need a lot of work before we could test this.
> 3. On x86 we use IOMMU in pass through mode so all the above concerns are valid
> 
> The question are -
> 
> 1. Does partial use of IOMMU while the pass through window is enabled add some
>         protection?
> 2. Do we rather the x86 way of doing this which is enable / disable IOMMU 
>         translations at kernel level?
> 
> I think that I can live with option (2) till I have DVMA if there is strong
> disagree on the need for per allocation IOMMU bypass.

Chosing on a per-mapping basis *in the back end* might still make some
amount of sense. What I don't completely grasp is what does it give
you to expose that choice to the *driver* all the way up the chain. Why
does the driver knows better whether something should use the bypass or
not ?

I can imagine some in-between setups, for example, on POWER (and
probably x86), I could setup a window that is TCE-mapped (TCEs are our
iommu PTEs) but used to create a 1:1 mapping. IE. A given TCE always
map to the same physical page. I could then use map/unmap to adjust the
protection, the idea being that only "relaxing" the protection requires
flushing the IO TLB, ie, we could delay most flushes.

But that sort of optimization only makes sense in the back-end.

So what was your original idea where you thought the driver was the
right one to decide whether to use the bypass or not for a given map
operation ? That's what I don't grasp... you might have a valid case
that I just fail to see.

Cheers,
Ben.
