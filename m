From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v1 2/2] dma-mapping-common: add DMA attribute -
 DMA_ATTR_IOMMU_BYPASS
Date: Tue, 03 Nov 2015 07:13:28 +1100
Message-ID: <1446495208.17404.11.camel@kernel.crashing.org>
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
	 <20151102120659.GC4642@shamir-ThinkPad-T430>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <20151102120659.GC4642@shamir-ThinkPad-T430>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Andy Lutomirski <luto@amacapital.net>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-arch <linux-arch@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Joerg Roedel <jroedel@suse.de>, Jonathan Corbet <corbet@lwn.net>, KVM <kvm@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2015-11-02 at 14:07 +0200, Shamir Rabinovitch wrote:
> On Mon, Nov 02, 2015 at 09:00:34PM +1100, Benjamin Herrenschmidt
> wrote:
> > 
> > Chosing on a per-mapping basis *in the back end* might still make
> > some
> 
> In my case, choosing mapping based on the hardware that will use this
> mappings makes more sense. Most hardware are not that performance 
> sensitive as the Infiniband hardware.

 ...

> The driver know for what hardware it is mapping the memory so it know 
> if the memory will be used by performance sensitive hardware or not.

Then I would argue for naming this differently. Make it an optional
hint "DMA_ATTR_HIGH_PERF" or something like that. Whether this is
achieved via using a bypass or other means in the backend not the
business of the driver.

> In your case, what will give the better performance - 1:1 mapping or
> IOMMU
> mapping? When you say 'relaxing the protection' you refer to 1:1
> mapping?

> Also, how this 1:1 window address the security concerns that other
> raised
> by other here?

It will partially only but it's just an example of another way the
bakcend could provide some improved performances without a bypass.

Cheers,
Ben.
