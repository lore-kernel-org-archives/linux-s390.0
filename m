Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH 20/33] dma-mapping: clear harmful GFP_* flags in common
 code
References: <20180110080027.13879-1-hch@lst.de>
 <20180110080027.13879-21-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <27b90341-f9d0-356f-0194-1c7203a3f93e@arm.com>
Date: Wed, 10 Jan 2018 11:59:30 +0000
MIME-Version: 1.0
In-Reply-To: <20180110080027.13879-21-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20180110115930.4WRO-OJiZ64fysr0n95q9RjVUAASZoTMeKtyIFGqOB0@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, x86@kernel.org, Konrad Rzeszutek Wilk <konrad@darnok.org>, linux-snps-arc@lists.infradead.org, linux-m68k@lists.linux-m68k.org, patches@groups.riscv.org, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

On 10/01/18 08:00, Christoph Hellwig wrote:
[...]
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 9f28b2fa329e..88bcb1a8211d 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -518,6 +518,13 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
>   	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
>   		return cpu_addr;
>   
> +	/*
> +	 * Let the implementation decide on the zone to allocate from, and
> +	 * decide on the way of zeroing the memory given that the memory
> +	 * returned should always be zeroed.
> +	 */

Just a note that if we're all happy to enshrine the "allocations are 
always zeroed" behaviour in the API (I am too, for the record), we 
should remember to follow up once the dust settles to update the docs 
and I guess just #define dma_zalloc_coherent dma_alloc_coherent.

Robin.

> +	flag &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM | __GFP_ZERO);
> +
>   	if (!arch_dma_alloc_attrs(&dev, &flag))
>   		return NULL;
>   	if (!ops->alloc)
> 
