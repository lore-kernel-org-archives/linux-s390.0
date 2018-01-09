From: Jesper Nilsson <jesper.nilsson@axis.com>
Subject: Re: [PATCH 34/67] cris: use dma-direct
Date: Tue, 9 Jan 2018 16:53:17 +0100
Message-ID: <20180109155317.GN32368@axis.com>
References: <20171229081911.2802-1-hch@lst.de>
 <20171229081911.2802-35-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-m68k-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171229081911.2802-35-hch@lst.de>
Sender: linux-m68k-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, x86@kernel.org, linux-snps-arc@lists.infradead.org, adi-buildroot-devel@lists.sourceforge.net, linux-m68k@lists.linux-m68k.org, patches@groups.riscv.org, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Dec 29, 2017 at 09:18:38AM +0100, Christoph Hellwig wrote:
> cris currently has an incomplete direct mapping dma_map_ops implementation
> is PCI support is enabled.  Replace it with the fully feature generic
> dma-direct implementation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

For CRIS:

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> ---
>  arch/cris/Kconfig                       |  4 ++
>  arch/cris/arch-v32/drivers/pci/Makefile |  2 +-
>  arch/cris/arch-v32/drivers/pci/dma.c    | 78 ---------------------------------
>  arch/cris/include/asm/Kbuild            |  1 +
>  arch/cris/include/asm/dma-mapping.h     | 20 ---------
>  5 files changed, 6 insertions(+), 99 deletions(-)
>  delete mode 100644 arch/cris/arch-v32/drivers/pci/dma.c
>  delete mode 100644 arch/cris/include/asm/dma-mapping.h
> 

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
