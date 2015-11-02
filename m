From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 2/2] dma-mapping-common: add DMA attribute - DMA_ATTR_IOMMU_BYPASS
Date: Mon, 02 Nov 2015 22:45:54 +0100
Message-ID: <5270615.Sf6ng964Qt@wuerfel>
References: <1446039110.3405.212.camel@infradead.org> <20151102120659.GC4642@shamir-ThinkPad-T430> <1446495208.17404.11.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1446495208.17404.11.camel@kernel.crashing.org>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>, David Woodhouse <dwmw2@infradead.org>, Andy Lutomirski <luto@amacapital.net>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-arch <linux-arch@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Joerg Roedel <jroedel@suse.de>, Jonathan Corbet <corbet@lwn.net>, KVM <kvm@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>

On Tuesday 03 November 2015 07:13:28 Benjamin Herrenschmidt wrote:
> On Mon, 2015-11-02 at 14:07 +0200, Shamir Rabinovitch wrote:
> > On Mon, Nov 02, 2015 at 09:00:34PM +1100, Benjamin Herrenschmidt
> > wrote:
> > > 
> > > Chosing on a per-mapping basis *in the back end* might still make
> > > some
> > 
> > In my case, choosing mapping based on the hardware that will use this
> > mappings makes more sense. Most hardware are not that performance 
> > sensitive as the Infiniband hardware.
> 
>  ...
> 
> > The driver know for what hardware it is mapping the memory so it know 
> > if the memory will be used by performance sensitive hardware or not.
> 
> Then I would argue for naming this differently. Make it an optional
> hint "DMA_ATTR_HIGH_PERF" or something like that. Whether this is
> achieved via using a bypass or other means in the backend not the
> business of the driver.
> 

With a name like that, who wouldn't pass that flag? ;-)

	Arnd
