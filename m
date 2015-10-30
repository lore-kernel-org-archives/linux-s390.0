From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 2/2] dma-mapping-common: add DMA attribute - DMA_ATTR_IOMMU_BYPASS
Date: Fri, 30 Oct 2015 11:32:06 +0100
Message-ID: <3880193.j0XDKyhAXH@wuerfel>
References: <1445789224-28032-1-git-send-email-shamir.rabinovitch@oracle.com> <1446079332.3405.273.camel@infradead.org> <1446081046.1856.55.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1446081046.1856.55.camel@kernel.crashing.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Shamir Rabinovitch <shamir.rabinovitch@oracle.com>, corbet@lwn.net, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Joerg Roedel <jroedel@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, KVM <kvm@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Thursday 29 October 2015 10:10:46 Benjamin Herrenschmidt wrote:
> 
> > Maybe we should at least coordinate IOMMU 'paranoid/fast' modes across
> > architectures, and then the DMA_ATTR_IOMMU_BYPASS flag would have a
> > sane meaning in the paranoid mode (and perhaps we'd want an ultra
> > -paranoid mode where it's not honoured).
> 
> Possibly, though ideally that would be a user policy but of course by
> the time you get to userspace it's generally too late.

IIRC, we have an 'iommu=force' command line switch for this, to ensure
that no device can use a linear mapping and everything goes through
the page tables. This is often useful for both debugging and as a
security measure when dealing with unpriviledged DMA access (virtual
machines, vfio, ...).

If we add a DMA_ATTR_IOMMU_BYPASS attribute, we should clearly document
which of the two we expect to take priority in cases where we have a
choice.

I wonder if the 'iommu=force' attribute is too coarse-grained though,
and if we should perhaps allow a per-device setting on architectures
that allow this.

	Arnd
