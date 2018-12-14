From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 1/2] dma-mapping: zero memory returned from dma_alloc_*
Date: Fri, 14 Dec 2018 19:10:56 +0100
Message-ID: <20181214181056.GA17941@ravnborg.org>
References: <20181214082515.14835-1-hch@lst.de>
 <20181214082515.14835-2-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181214082515.14835-2-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, Michal Simek <monstr@monstr.eu>, Ashutosh Dixit <ashutosh.dixit@intel.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Christoph,

I stumbled upon this one:

#define __get_dma_pages(gfp_mask, order) \
                __get_free_pages((gfp_mask) | GFP_DMA, (order))

(include/linux/gfp.h)
Should it also have the __GFP_ZERO treatment?
Or maybe this is already done in your tree..

As for the sparc bits:
Acked-by: Sam Ravnborg <sam@ravnborg.org> [sparc]

	Sam
