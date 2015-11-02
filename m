From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Subject: Re: [PATCH v1 2/2] dma-mapping-common: add DMA attribute -
 DMA_ATTR_IOMMU_BYPASS
Date: Mon, 2 Nov 2015 09:23:58 +0200
Message-ID: <20151102072358.GA4642@shamir-ThinkPad-T430>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1446412249.4060.7.camel@kernel.crashing.org>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Andy Lutomirski <luto@amacapital.net>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-arch <linux-arch@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Joerg Roedel <jroedel@suse.de>, Jonathan Corbet <corbet@lwn.net>, KVM <kvm@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Nov 02, 2015 at 08:10:49AM +1100, Benjamin Herrenschmidt wrote:
> But but but ...
> 
> What I don't understand is how that brings you any safety.

Limited safety maybe? If some device DMA mappings are via IOMMU 
and this fall to some address range that is far from the bypass / 
pass through range then small drifts in address might be still figured 
if we do not bypass / pass through the IOMMU - right?

Device can sure use the bypass address and just reach the memory w/o 
IOMMU protection. See some comments about that below.

> 
> Basically, either your bridge has a bypass window, or it doesn't. (Or
> it has one and it's enabled or not, same thing).

Agree.

> 
> If you request the bypass on a per-mapping basis, you basically have to
> keep the window always enabled, unless you do some nasty refcounting of
> how many people have a bypass mapping in flight, but that doesn't seem
> useful.
> 
> Thus you have already lost all protection from the device, since your
> entire memory is accessible via the bypass mapping.

Correct, see my above comment. 

> 
> Which means what is the point of then having non-bypass mappings for
> other things ? Just to make things slower ?
> 
> I really don't see what this whole "bypass on a per-mapping basis" buys
> you.
> 
> Note that we implicitly already do that on powerpc, but not for those
> reasons, we do it based on the DMA mask, so that if your coherent mask
> is 32-bit but your dma mask is 64-bit (which is not an uncommon
> combination), we service the "coherent" requests (basically the long
> lifed dma allocs) from the remapped region and the "stream" requests
> (ie, map_page/map_sg) from the bypass.



To summary -

1. The whole point of the IOMMU pass through was to get bigger address space
	and faster map/unmap operations for performance critical hardware
2. SPARC IOMMU in particular has the ability to DVMA which adress all the 
	protection concerns raised above. Not sure what will be the performance
	impact though. This still need a lot of work before we could test this.
3. On x86 we use IOMMU in pass through mode so all the above concerns are valid

The question are -

1. Does partial use of IOMMU while the pass through window is enabled add some
	protection?
2. Do we rather the x86 way of doing this which is enable / disable IOMMU 
	translations at kernel level?

I think that I can live with option (2) till I have DVMA if there is strong
disagree on the need for per allocation IOMMU bypass.


> 
> Cheers,
> Ben.
> 
