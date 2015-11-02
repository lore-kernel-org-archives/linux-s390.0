From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Subject: Re: [PATCH v1 2/2] dma-mapping-common: add DMA attribute -
 DMA_ATTR_IOMMU_BYPASS
Date: Mon, 2 Nov 2015 23:49:45 +0200
Message-ID: <20151102214944.GE12484@shamir-ThinkPad-T430>
References: <1446079332.3405.273.camel@infradead.org>
 <1446081046.1856.55.camel@kernel.crashing.org>
 <CALCETrXrzq1f9sMAbKcmhpEtiyq5FE871=4+YspA=X+RjD7p8Q@mail.gmail.com>
 <1446158125.4471.5.camel@infradead.org>
 <20151101074534.GC23022@shamir-ThinkPad-T430>
 <1446412249.4060.7.camel@kernel.crashing.org>
 <20151102072358.GA4642@shamir-ThinkPad-T430>
 <1446458434.4060.21.camel@kernel.crashing.org>
 <20151102120659.GC4642@shamir-ThinkPad-T430>
 <1446495208.17404.11.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1446495208.17404.11.camel@kernel.crashing.org>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Andy Lutomirski <luto@amacapital.net>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-arch <linux-arch@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Joerg Roedel <jroedel@suse.de>, Jonathan Corbet <corbet@lwn.net>, KVM <kvm@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Nov 03, 2015 at 07:13:28AM +1100, Benjamin Herrenschmidt wrote:
> 
> Then I would argue for naming this differently. Make it an optional
> hint "DMA_ATTR_HIGH_PERF" or something like that. Whether this is
> achieved via using a bypass or other means in the backend not the
> business of the driver.
> 

Correct. This comment was also from internal review :-) Although
currently there is strong opposition to such new attribute.

> 
> It will partially only but it's just an example of another way the
> bakcend could provide some improved performances without a bypass.

Just curious.. 

In the Infiniband case where user application request the driver to DMA 
map some random pages they allocated - will your suggestion still
function? 

I mean can you use this limited 1:1 mapping window to map any page the
user application choose? How?

At the bypass we just use the physical address of the page (almost as is).
We use the fact that bypass address space cover the whole memory and so we
have mapping for any address.

In IOMMU case we use the IOMMU translation tables and so can map 64 bit 
address to some 32 bit address (or less).

In your case it is not clear to me what can we do with such limited 1:1
mapping.

> 
> Cheers,
> Ben.
> 
