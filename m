From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Subject: Re: [PATCH v1 2/2] dma-mapping-common: add DMA attribute -
 DMA_ATTR_IOMMU_BYPASS
Date: Sun, 1 Nov 2015 09:45:34 +0200
Message-ID: <20151101074534.GC23022@shamir-ThinkPad-T430>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1446158125.4471.5.camel@infradead.org>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-arch <linux-arch@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Joerg Roedel <jroedel@suse.de>, Jonathan Corbet <corbet@lwn.net>, KVM <kvm@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Oct 29, 2015 at 10:35:25PM +0000, David Woodhouse wrote:
> > 
> > Could this be mitigated using pools?  I don't know if the net code
> > would play along easily.
> 
> For the receive side, it shouldn't be beyond the wit of man to
> introduce an API which allocates *and* DMA-maps a skb. Pass it to
> netif_rx() still mapped, with a destructor that just shoves it back in
> a pool for re-use.
> 
> Doing it for transmit might be a little more complex, but perhaps still
> possible.

Not sure this use case is possible for Infiniband where application hold
the data buffers and there is no way to force application to re use the 
buffer as suggested.

This is why I think there will be no easy way to bypass the DMA mapping cost
for all use cases unless we allow applications to request bypass/pass through
DMA mapping (implicitly or explicitly).

> 
> -- 
> dwmw2
> 
