From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v1 2/2] dma-mapping-common: add DMA attribute -
 DMA_ATTR_IOMMU_BYPASS
Date: Wed, 04 Nov 2015 06:35:10 +1100
Message-ID: <1446579310.17404.36.camel@kernel.crashing.org>
References: <1446039110.3405.212.camel@infradead.org>
	 <20151102120659.GC4642@shamir-ThinkPad-T430>
	 <1446495208.17404.11.camel@kernel.crashing.org>
	 <5270615.Sf6ng964Qt@wuerfel>
	 <1446505693.17404.20.camel@kernel.crashing.org>
	 <20151103131134.GA6384@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20151103131134.GA6384@lst.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Shamir Rabinovitch <shamir.rabinovitch@oracle.com>, David Woodhouse <dwmw2@infradead.org>, Andy Lutomirski <luto@amacapital.net>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-arch <linux-arch@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Joerg Roedel <jroedel@suse.de>, Jonathan Corbet <corbet@lwn.net>, KVM <kvm@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 2015-11-03 at 14:11 +0100, Christoph Hellwig wrote:
> > xHCI for example, vs. something like 10G ethernet... but yes I agree it
> > sucks. I don't like that sort of policy anywhere in drivers. On the
> > other hand the platform doesn't have much information to make that sort
> > of decision either.
> 
> Mabye because it should simply use what's optimal?  E.g. passthrough
> whenever possible, where arguments against possible are:  dma_mask, vfio
> requirements, kernel command line option. 

Right this is what I do today on powerpc with the exception of
the command line option.

>  This is what a lot of
> architectures already do, I remember the SGI Origin / Altix code has the
> same behavior as well.  Those IOMMUs already had the 64 bit passthrough
> and 32-bit sliding window in addition to the real IOMMU 10 years ago.
> --
