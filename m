From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 2/2] dma-mapping-common: add DMA attribute - DMA_ATTR_IOMMU_BYPASS
Date: Sat, 31 Oct 2015 00:24:51 +0100
Message-ID: <4222082.KUcVOXqzxa@wuerfel>
References: <1445789224-28032-1-git-send-email-shamir.rabinovitch@oracle.com> <3880193.j0XDKyhAXH@wuerfel> <1446247042.1856.106.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <1446247042.1856.106.camel@kernel.crashing.org>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Shamir Rabinovitch <shamir.rabinovitch@oracle.com>, corbet@lwn.net, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Joerg Roedel <jroedel@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, KVM <kvm@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Saturday 31 October 2015 10:17:22 Benjamin Herrenschmidt wrote:
> On Fri, 2015-10-30 at 11:32 +0100, Arnd Bergmann wrote:
> > On Thursday 29 October 2015 10:10:46 Benjamin Herrenschmidt wrote:
> > > 
> > > > Maybe we should at least coordinate IOMMU 'paranoid/fast' modes
> > > > across
> > > > architectures, and then the DMA_ATTR_IOMMU_BYPASS flag would have
> > > > a
> > > > sane meaning in the paranoid mode (and perhaps we'd want an ultra
> > > > -paranoid mode where it's not honoured).
> > > 
> > > Possibly, though ideally that would be a user policy but of course
> > > by
> > > the time you get to userspace it's generally too late.
> > 
> > IIRC, we have an 'iommu=force' command line switch for this, to
> > ensure
> > that no device can use a linear mapping and everything goes th ough
> > the page tables. This is often useful for both debugging and as a
> > security measure when dealing with unpriviledged DMA access (virtual
> > machines, vfio, ...).
> 
> That was used to force-enable the iommu on platforms like G5s where we
> would otherwise only do so if the memory was larger than 32-bit but we
> never implemented using it to prevent the bypass region.

Ah, I see. Thanks for the clarification.

> > If we add a DMA_ATTR_IOMMU_BYPASS attribute, we should clearly
> > document
> > which osed to force-enable the iommu on HGthe two we expect to take
> > priority in cases where we have a
> > choice.
> >
> > I wonder if the 'iommu=force' attribute is too coarse-grained though,
> > and if we should perhaps allow a per-device setting on architectures
> > that allow this.
> 
> The interesting thing, if we can make it work, is the bypass attribute
> being per mapping... 

I would say we want both: for the device driver it can make sense to
choose per mapping what it can do, but for the iommu driver, it
can also make sense to ensure we never provide a linear mapping,
because otherwise the additional security aspect is moot.

In particular for the unprivileged VM guest or vfio access, the
code that gives access to the device to something else should
have a way to tell the IOMMU that the linear mapping can no longer
be used.

	Arnd
