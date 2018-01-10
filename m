Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH 11/33] dma-mapping: move swiotlb arch helpers to a new
 header
References: <20180110080027.13879-1-hch@lst.de>
 <20180110080027.13879-12-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <3721b4ba-0685-255e-06b9-6e60678a1a92@arm.com>
Date: Wed, 10 Jan 2018 14:56:01 +0000
MIME-Version: 1.0
In-Reply-To: <20180110080027.13879-12-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20180110145601.vM-zTBFRXJVeTsaMeEyr-jLgpB8zSncSpXT7XDge8Ik@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, x86@kernel.org, Konrad Rzeszutek Wilk <konrad@darnok.org>, linux-snps-arc@lists.infradead.org, linux-m68k@lists.linux-m68k.org, patches@groups.riscv.org, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

On 10/01/18 08:00, Christoph Hellwig wrote:
> phys_to_dma, dma_to_phys and dma_capable are helpers published by
> architecture code for use of swiotlb and xen-swiotlb only.  Drivers are
> not supposed to use these directly, but use the DMA API instead.
> 
> Move these to a new asm/dma-direct.h helper, included by a
> linux/dma-direct.h wrapper that provides the default linear mapping
> unless the architecture wants to override it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
[...]
>   drivers/crypto/marvell/cesa.c                      |  1 +
>   drivers/mtd/nand/qcom_nandc.c                      |  1 +

I took a look at these, and it seems their phys_to_dma() usage is doing 
the thing which we subsequently formalised as dma_map_resource(). I've 
had a crack at a quick patch to update the CESA driver; qcom_nandc looks 
slightly more complex in that the changes probably need to span the BAM 
dmaengine driver as well.

In the process, though, I stumbled across gen_pool_dma_alloc() - yuck, 
something needs doing there, for sure...

Robin.
