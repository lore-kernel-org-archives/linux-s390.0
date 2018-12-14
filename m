From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] dma-mapping: zero memory returned from dma_alloc_*
Date: Fri, 14 Dec 2018 19:35:09 +0100
Message-ID: <20181214183509.GA5247@lst.de>
References: <20181214082515.14835-1-hch@lst.de> <20181214082515.14835-2-hch@lst.de> <20181214181056.GA17941@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181214181056.GA17941@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, Michal Simek <monstr@monstr.eu>, Ashutosh Dixit <ashutosh.dixit@intel.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Dec 14, 2018 at 07:10:56PM +0100, Sam Ravnborg wrote:
> Hi Christoph,
> 
> I stumbled upon this one:
> 
> #define __get_dma_pages(gfp_mask, order) \
>                 __get_free_pages((gfp_mask) | GFP_DMA, (order))

This isn't directly related to the dma mapping, but another place
that hides GFP_DMA allocations.  So no need for the treatment,
but we really should kill this obsfucating wrapper..
