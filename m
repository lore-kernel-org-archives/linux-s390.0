From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] dma-mapping: zero memory returned from dma_alloc_*
Date: Mon, 17 Dec 2018 12:59:31 +0100
Message-ID: <20181217115931.GA6853@lst.de>
References: <20181214082515.14835-1-hch@lst.de> <20181214082515.14835-2-hch@lst.de> <CAMuHMdWOr0EsgFQF8tjJYLxKVXx+Jwn73N8SVKt8AQGLKQ8V-A@mail.gmail.com> <20181214114719.GA3316@lst.de> <5ae55118-6858-9121-6b3e-9b19b41550ef@westnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5ae55118-6858-9121-6b3e-9b19b41550ef@westnet.com.au>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
To: Greg Ungerer <gregungerer@westnet.com.au>
Cc: Christoph Hellwig <hch@lst.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, Michal Simek <monstr@monstr.eu>, ashutosh.dixit@intel.com, alpha <linux-alpha@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, linux-c6x-dev@linux-c6x.org, linux-m68k <linux-m68k@lists.linux-m68k.org>, Openrisc <openrisc@lists.librecores.org>, Parisc List <linux-parisc@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, linux-xtensa@linux-xtensa.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Sat, Dec 15, 2018 at 12:14:29AM +1000, Greg Ungerer wrote:
> Yep, that is right. Certainly the MMU case is broken. Some noMMU cases work
> by virtue of the SoC only having an instruction cache (the older V2 cores).

Is there a good an easy case to detect if a core has a cache?  Either
runtime or in Kconfig?

> The MMU case is fixable, but I think it will mean changing away from
> the fall-back virtual:physical 1:1 mapping it uses for the kernel address
> space. So not completely trivial. Either that or a dedicated area of RAM
> for coherent allocations that we can mark as non-cachable via the really
> course grained and limited ACR registers - not really very appealing.

What about CF_PAGE_NOCACHE?  Reading arch/m68k/include/asm/mcf_pgtable.h
suggest this would cause an uncached mapping, in which case something
like this should work:

	http://git.infradead.org/users/hch/misc.git/commitdiff/4b8711d436e8d56edbc5ca19aa2be639705bbfef

> The noMMU case in general is probably limited to something like that same
> type of dedicated RAM/ACR register mechamism.
>
> The most commonly used periperal with DMA is the FEC ethernet module,
> and it has some "special" (used very loosely) cache flushing for
> parts like the 532x family which probably makes it mostly work right.
> There is a PCI bus on the 54xx family of parts, and I know general
> ethernet cards on it (like e1000's) have problems I am sure are
> related to the fact that coherent memory allocations aren't.

If we really just care about FEC we can just switch it do use
DMA_ATTR_NON_CONSISTENT and do explicit cache flushing.  But as far
as I can tell FEC only uses DMA coherent allocations for the TSO
headers anyway, is TSO even used on this SOC?
