From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v1 2/2] dma-mapping-common: add DMA attribute -
 DMA_ATTR_IOMMU_BYPASS
Date: Thu, 29 Oct 2015 10:10:46 +0900
Message-ID: <1446081046.1856.55.camel@kernel.crashing.org>
References: <1445789224-28032-1-git-send-email-shamir.rabinovitch@oracle.com>
	 <1445789224-28032-2-git-send-email-shamir.rabinovitch@oracle.com>
	 <1446013801.3405.183.camel@infradead.org>
	 <20151028111049.GA30785@shamir-ThinkPad-T430>
	 <1446039110.3405.212.camel@infradead.org>
	 <1446078721.1856.49.camel@kernel.crashing.org>
	 <1446079332.3405.273.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1446079332.3405.273.camel@infradead.org>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Woodhouse <dwmw2@infradead.org>, Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Cc: arnd@arndb.de, corbet@lwn.net, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Joerg Roedel <jroedel@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, KVM <kvm@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 2015-10-29 at 09:42 +0900, David Woodhouse wrote:
> On Thu, 2015-10-29 at 09:32 +0900, Benjamin Herrenschmidt wrote:
> 
> > On Power, I generally have 2 IOMMU windows for a device, one at the
> > bottom is remapped, and is generally used for 32-bit devices and the
> > one at the top us setup as a bypass 
> 
> So in the normal case of decent 64-bit devices (and not in a VM),
> they'll *already* be using the bypass region and have full access to
> all of memory, all of the time? And you have no protection against
> driver and firmware bugs causing stray DMA?

Correct, we chose to do that for performance reasons.

> > I don't see how thata ttribute would work for us.
> 
> Because you're already doing it anyway without being asked :)
> 
> If SPARC and POWER are both doing that, perhaps we should change the
> default for Intel too?
> 
> Aside from the lack of security, the other disadvantage of that is that
> you have to pin *all* pages of a guest in case DMA happens; you don't
> get to pin *only* those pages which are referenced by that guest's
> IOMMU page tables...

Correct, the problem is that the cost of doing map/unmap from a guest
is really a huge hit on things like network devices.

Another problem is that the failure mode isn't great if you don't pin. 

IE. You have to pin pages as they get mapped into the iommu by the
guest, but you don't know in advance how much and you may hit the
process ulimit on pinned pages half way through.

We tried to address that in various ways but it always ended up horrid.

> Maybe we should at least coordinate IOMMU 'paranoid/fast' modes across
> architectures, and then the DMA_ATTR_IOMMU_BYPASS flag would have a
> sane meaning in the paranoid mode (and perhaps we'd want an ultra
> -paranoid mode where it's not honoured).

Possibly, though ideally that would be a user policy but of course by
the time you get to userspace it's generally too late.

Cheers,
Ben.
