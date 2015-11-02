From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v1 2/2] dma-mapping-common: add DMA attribute -
 DMA_ATTR_IOMMU_BYPASS
Date: Tue, 03 Nov 2015 10:10:13 +1100
Message-ID: <1446505813.17404.23.camel@kernel.crashing.org>
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
	 <1446412249.4060.7.camel@kernel.crashing.org>
	 <1446504494.15061.66.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1446504494.15061.66.camel@infradead.org>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Woodhouse <dwmw2@infradead.org>, Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Cc: Andy Lutomirski <luto@amacapital.net>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-arch <linux-arch@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Joerg Roedel <jroedel@suse.de>, Jonathan Corbet <corbet@lwn.net>, KVM <kvm@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2015-11-02 at 22:48 +0000, David Woodhouse wrote:
> 
> In the Intel case, the mapping setup is entirely per-device (except for
> crap devices and devices behind a PCIe-PCI bridge, etc.).
> 
> So you can happily have a passthrough mapping for *one* device, without
> making that same mapping available to another device. You can make that
> trade-off of speed vs. protection for each device in the system.

Same for me. I should have written "in the context of a device ...",
the problem reamains that it doesn't buy you much to do it *per
-mapping* which is what this API seems to be about.

> Currently we have the 'iommu=pt' option that makes us use passthrough
> for *all* devices (except those whose dma_mask can't reach all of
> physical memory). But I could live with something like Shamir is
> proposing, which lets us do the bypass only for performance-sensitive
> devices which actually *ask* for it (and of course we'd have a system-
> wide mode which declines that request and does normal mappings anyway).
> 
