From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v1 2/2] dma-mapping-common: add DMA attribute -
 DMA_ATTR_IOMMU_BYPASS
Date: Mon, 2 Nov 2015 15:51:15 +0100
Message-ID: <20151102145115.GB2876@suse.de>
References: <1445789224-28032-1-git-send-email-shamir.rabinovitch@oracle.com>
 <1446079332.3405.273.camel@infradead.org>
 <1446081046.1856.55.camel@kernel.crashing.org>
 <3880193.j0XDKyhAXH@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3880193.j0XDKyhAXH@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Woodhouse <dwmw2@infradead.org>, Shamir Rabinovitch <shamir.rabinovitch@oracle.com>, corbet@lwn.net, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, KVM <kvm@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Oct 30, 2015 at 11:32:06AM +0100, Arnd Bergmann wrote:
> I wonder if the 'iommu=force' attribute is too coarse-grained though,
> and if we should perhaps allow a per-device setting on architectures
> that allow this.

Yeah, definitly. Currently we only have iommu=pt to enable pass-through
mode for _all_ devices. I think it makes sense to introduce a per-device
opt-in for pass-through, but have it configured by the user and not by
the device driver.

If the user enables the IOMMU in his system, he expects to be secure
against DMA attacks. If drivers could opt-out, every protection would be
voided.


	Joerg
