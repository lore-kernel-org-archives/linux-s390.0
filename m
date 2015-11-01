From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v1 2/2] dma-mapping-common: add DMA attribute -
 DMA_ATTR_IOMMU_BYPASS
Date: Mon, 02 Nov 2015 08:10:49 +1100
Message-ID: <1446412249.4060.7.camel@kernel.crashing.org>
References: <1445789224-28032-1-git-send-email-shamir.rabinovitch@oracle.com>
	 <1445789224-28032-2-git-send-email-shamir.rabinovitch@oracle.com>
	 <1446013801.3405.183.camel@infradead.org>
	 <20151028111049.GA30785@shamir-ThinkPad-T430>
	 <1446039110.3405.212.camel@infradead.org>
	 <1446078721.1856.49.camel@kernel.crashing.org>
	 <1446079332.3405.273.camel@infradead.org>
	 <1446081046.1856.55.camel@kernel.crashing.org>
	 <CALCETrXrzq1f9sMAbKcmhpEtiyq5FE871=4+YspA=X+RjD7p8Q@mail.gmail.com>
	 <1446158125.4471.5.camel@infradead.org>
	 <20151101074534.GC23022@shamir-ThinkPad-T430>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20151101074534.GC23022@shamir-ThinkPad-T430>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-arch <linux-arch@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Joerg Roedel <jroedel@suse.de>, Jonathan Corbet <corbet@lwn.net>, KVM <kvm@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>

On Sun, 2015-11-01 at 09:45 +0200, Shamir Rabinovitch wrote:
> Not sure this use case is possible for Infiniband where application hold
> the data buffers and there is no way to force application to re use the 
> buffer as suggested.
> 
> This is why I think there will be no easy way to bypass the DMA mapping cost
> for all use cases unless we allow applications to request bypass/pass through
> DMA mapping (implicitly or explicitly).

But but but ...

What I don't understand is how that brings you any safety.

Basically, either your bridge has a bypass window, or it doesn't. (Or
it has one and it's enabled or not, same thing).

If you request the bypass on a per-mapping basis, you basically have to
keep the window always enabled, unless you do some nasty refcounting of
how many people have a bypass mapping in flight, but that doesn't seem
useful.

Thus you have already lost all protection from the device, since your
entire memory is accessible via the bypass mapping.

Which means what is the point of then having non-bypass mappings for
other things ? Just to make things slower ?

I really don't see what this whole "bypass on a per-mapping basis" buys
you.

Note that we implicitly already do that on powerpc, but not for those
reasons, we do it based on the DMA mask, so that if your coherent mask
is 32-bit but your dma mask is 64-bit (which is not an uncommon
combination), we service the "coherent" requests (basically the long
lifed dma allocs) from the remapped region and the "stream" requests
(ie, map_page/map_sg) from the bypass.

Cheers,
Ben.
