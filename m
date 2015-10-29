From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v1 2/2] dma-mapping-common: add DMA attribute -
 DMA_ATTR_IOMMU_BYPASS
Date: Thu, 29 Oct 2015 09:32:01 +0900
Message-ID: <1446078721.1856.49.camel@kernel.crashing.org>
References: <1445789224-28032-1-git-send-email-shamir.rabinovitch@oracle.com>
	 <1445789224-28032-2-git-send-email-shamir.rabinovitch@oracle.com>
	 <1446013801.3405.183.camel@infradead.org>
	 <20151028111049.GA30785@shamir-ThinkPad-T430>
	 <1446039110.3405.212.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1446039110.3405.212.camel@infradead.org>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Woodhouse <dwmw2@infradead.org>, Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Cc: arnd@arndb.de, corbet@lwn.net, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Joerg Roedel <jroedel@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, KVM <kvm@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2015-10-28 at 22:31 +0900, David Woodhouse wrote:
> We have an option in the Intel IOMMU for pass-through mode too, which
> basically *is* a total bypass. In practice, what's the difference
> between that and a "simple translation that does not require any
> [translation]"? We set up a full 1:1 mapping of all memory, and then
> the map/unmap methods become no-ops.
> 
> Currently we have no way to request that mode on a per-device basis;
> we
> only have 'iommu=pt' on the command line to set it for *all* devices.
> But performance-sensitive devices might want it, while we keep doing
> proper translation for others.

On Power, I generally have 2 IOMMU windows for a device, one at the
bottom is remapped, and is generally used for 32-bit devices and the
one at the top us setup as a bypass (or in the case of KVM, as a linear
mapping of guest memory which looks the same as a bypass to the guest).

The DMA ops will automatically hit the appropriate one based on the
DMA mask.

I don't see how that attribute would work for us.

Cheers,
Ben.
