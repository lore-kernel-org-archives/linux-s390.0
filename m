From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 22/34] dma-mapping: add an arch_dma_supported hook
Date: Fri, 2 Feb 2018 09:47:23 -0800
Message-ID: <5d7dfb29-eeef-2280-13c9-5260e9104f67@infradead.org>
References: <20180112084232.2857-1-hch@lst.de>
 <20180112084232.2857-23-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180112084232.2857-23-hch@lst.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, x86@kernel.org, Konrad Rzeszutek Wilk <konrad@darnok.org>, linux-snps-arc@lists.infradead.org, linux-m68k@lists.linux-m68k.org, patches@groups.riscv.org, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

On 01/12/2018 12:42 AM, Christoph Hellwig wrote:
> To implement the x86 forbid_dac and iommu_sac_force we want an arch hook
> so that it can apply the global options across all dma_map_ops
> implementations.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/x86/include/asm/dma-mapping.h |  3 +++
>  arch/x86/kernel/pci-dma.c          | 19 ++++++++++++-------
>  include/linux/dma-mapping.h        | 11 +++++++++++
>  3 files changed, 26 insertions(+), 7 deletions(-)

> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 88bcb1a8211d..d67742dad904 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -576,6 +576,14 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
>  	return 0;
>  }
>  
> +/*
> + * This is a hack for the legacy x86 forbid_dac and iommu_sac_force. Please
> + * don't use this is new code.

                     in new code.

> + */
> +#ifndef arch_dma_supported
> +#define arch_dma_supported(dev, mask)	(1)
> +#endif


-- 
~Randy
