From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 10/33] arm64: don't override dma_max_pfn
Date: Wed, 10 Jan 2018 11:08:27 +0000
Message-ID: <115563c4-7929-a68c-459a-89d787051053@arm.com>
References: <20180110080027.13879-1-hch@lst.de>
 <20180110080027.13879-11-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <20180110080027.13879-11-hch@lst.de>
Content-Language: en-GB
Sender: linux-m68k-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, x86@kernel.org, Konrad Rzeszutek Wilk <konrad@darnok.org>, linux-snps-arc@lists.infradead.org, linux-m68k@lists.linux-m68k.org, patches@groups.riscv.org, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

On 10/01/18 08:00, Christoph Hellwig wrote:
> The generic version now takes dma_pfn_offset into account, so there is no
> more need for an architecture override.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/arm64/include/asm/dma-mapping.h | 9 ---------
>   1 file changed, 9 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
> index 0df756b24863..eada887a93bf 100644
> --- a/arch/arm64/include/asm/dma-mapping.h
> +++ b/arch/arm64/include/asm/dma-mapping.h
> @@ -76,14 +76,5 @@ static inline void dma_mark_clean(void *addr, size_t size)
>   {
>   }
>   
> -/* Override for dma_max_pfn() */
> -static inline unsigned long dma_max_pfn(struct device *dev)
> -{
> -	dma_addr_t dma_max = (dma_addr_t)*dev->dma_mask;
> -
> -	return (ulong)dma_to_phys(dev, dma_max) >> PAGE_SHIFT;
> -}
> -#define dma_max_pfn(dev) dma_max_pfn(dev)
> -
>   #endif	/* __KERNEL__ */
>   #endif	/* __ASM_DMA_MAPPING_H */
> 
