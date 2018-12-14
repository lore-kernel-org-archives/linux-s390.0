From: Greg Ungerer <gregungerer@westnet.com.au>
Subject: Re: [PATCH 1/2] dma-mapping: zero memory returned from dma_alloc_*
Date: Sat, 15 Dec 2018 00:14:29 +1000
Message-ID: <5ae55118-6858-9121-6b3e-9b19b41550ef@westnet.com.au>
References: <20181214082515.14835-1-hch@lst.de>
 <20181214082515.14835-2-hch@lst.de>
 <CAMuHMdWOr0EsgFQF8tjJYLxKVXx+Jwn73N8SVKt8AQGLKQ8V-A@mail.gmail.com>
 <20181214114719.GA3316@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181214114719.GA3316@lst.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
To: Christoph Hellwig <hch@lst.de>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, linux-c6x-dev@linux-c6x.org, Parisc List <linux-parisc@vger.kernel.org>, linux-xtensa@linux-xtensa.org, linux-m68k <linux-m68k@lists.linux-m68k.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ashutosh.dixit@intel.com, Linux IOMMU <iommu@lists.linux-foundation.org>, Openrisc <openrisc@lists.librecores.org>, alpha <linux-alpha@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>
List-ID: <linux-s390.vger.kernel.org>


On 14/12/18 9:47 pm, Christoph Hellwig wrote:
> On Fri, Dec 14, 2018 at 10:54:32AM +0100, Geert Uytterhoeven wrote:
>>> -       page = alloc_pages(flag, order);
>>> +       page = alloc_pages(flag | GFP_ZERO, order);
>>>          if (!page)
>>>                  return NULL;
>>
>> There's second implementation below, which calls __get_free_pages() and
>> does an explicit memset().  As __get_free_pages() calls alloc_pages(), perhaps
>> it makes sense to replace the memset() by GFP_ZERO, to increase consistency?
> 
> It would, but this patch really tries to be minimally invasive to just
> provide the zeroing everywhere.  There is plenty of opportunity
> to improve the m68k dma allocator if I can get enough reviewers/testers:
> 
>   - for one the coldfire/nommu case absolutely does not make sense to
>     me as there is not work done at all to make sure the memory is
>     mapped uncached despite the architecture implementing cache
>     flushing for the map interface.  So this whole implementation
>     looks broken to me and will need some major work (I had a previous
>     discussion with Greg on that which needs to be dug out)

Yep, that is right. Certainly the MMU case is broken. Some noMMU cases work
by virtue of the SoC only having an instruction cache (the older V2 cores).

The MMU case is fixable, but I think it will mean changing away from
the fall-back virtual:physical 1:1 mapping it uses for the kernel address
space. So not completely trivial. Either that or a dedicated area of RAM
for coherent allocations that we can mark as non-cachable via the really
course grained and limited ACR registers - not really very appealing.

The noMMU case in general is probably limited to something like that same
type of dedicated RAM/ACR register mechamism.

The most commonly used periperal with DMA is the FEC ethernet module,
and it has some "special" (used very loosely) cache flushing for
parts like the 532x family which probably makes it mostly work right.
There is a PCI bus on the 54xx family of parts, and I know general
ethernet cards on it (like e1000's) have problems I am sure are
related to the fact that coherent memory allocations aren't.

I do plan to have a look at this for the MMU case some time soon.

Regards
Greg




>   - the "regular" implementation in this patch should probably be replaced
>     with the generic remapping helpers that have been added for the 4.21
>     merge window:
> 
> 	http://git.infradead.org/users/hch/dma-mapping.git/commitdiff/0c3b3171ceccb8830c2bb5adff1b4e9b204c1450
> 
> Compile tested only patch below:
> 
> --
>>>From ade86dc75b9850daf9111ebf9ce15825a6144f2d Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Fri, 14 Dec 2018 12:41:45 +0100
> Subject: m68k: use the generic dma coherent remap allocator
> 
> This switche to using common code for the DMA allocations, including
> potential use of the CMA allocator if configure.  Also add a few
> comments where the existing behavior seems to be lacking.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/m68k/Kconfig      |  2 ++
>   arch/m68k/kernel/dma.c | 64 ++++++++++++------------------------------
>   2 files changed, 20 insertions(+), 46 deletions(-)
> 
> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> index 8a5868e9a3a0..60788cf02fbc 100644
> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -2,10 +2,12 @@
>   config M68K
>   	bool
>   	default y
> +	select ARCH_HAS_DMA_MMAP_PGPROT if MMU && !COLDFIRE
>   	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if HAS_DMA
>   	select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
>   	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
>   	select ARCH_NO_PREEMPT if !COLDFIRE
> +	select DMA_DIRECT_REMAP if MMU && !COLDFIRE
>   	select HAVE_IDE
>   	select HAVE_AOUT if MMU
>   	select HAVE_DEBUG_BUGVERBOSE
> diff --git a/arch/m68k/kernel/dma.c b/arch/m68k/kernel/dma.c
> index dafe99d08a6a..16da5d96e228 100644
> --- a/arch/m68k/kernel/dma.c
> +++ b/arch/m68k/kernel/dma.c
> @@ -18,57 +18,29 @@
>   #include <asm/pgalloc.h>
>   
>   #if defined(CONFIG_MMU) && !defined(CONFIG_COLDFIRE)
> -
> -void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
> -		gfp_t flag, unsigned long attrs)
> +void arch_dma_prep_coherent(struct page *page, size_t size)
>   {
> -	struct page *page, **map;
> -	pgprot_t pgprot;
> -	void *addr;
> -	int i, order;
> -
> -	pr_debug("dma_alloc_coherent: %d,%x\n", size, flag);
> -
> -	size = PAGE_ALIGN(size);
> -	order = get_order(size);
> -
> -	page = alloc_pages(flag | GFP_ZERO, order);
> -	if (!page)
> -		return NULL;
> -
> -	*handle = page_to_phys(page);
> -	map = kmalloc(sizeof(struct page *) << order, flag & ~__GFP_DMA);
> -	if (!map) {
> -		__free_pages(page, order);
> -		return NULL;
> -	}
> -	split_page(page, order);
> -
> -	order = 1 << order;
> -	size >>= PAGE_SHIFT;
> -	map[0] = page;
> -	for (i = 1; i < size; i++)
> -		map[i] = page + i;
> -	for (; i < order; i++)
> -		__free_page(page + i);
> -	pgprot = __pgprot(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_DIRTY);
> -	if (CPU_IS_040_OR_060)
> -		pgprot_val(pgprot) |= _PAGE_GLOBAL040 | _PAGE_NOCACHE_S;
> -	else
> -		pgprot_val(pgprot) |= _PAGE_NOCACHE030;
> -	addr = vmap(map, size, VM_MAP, pgprot);
> -	kfree(map);
> -
> -	return addr;
> +	/*
> +	 * XXX: don't we need to flush and invalidate the caches before
> +	 * creating a coherent mapping?
> +	 * coherent?
> +	 */
>   }
>   
> -void arch_dma_free(struct device *dev, size_t size, void *addr,
> -		dma_addr_t handle, unsigned long attrs)
> +pgprot_t arch_dma_mmap_pgprot(struct device *dev, pgprot_t prot,
> +		unsigned long attrs)
>   {
> -	pr_debug("dma_free_coherent: %p, %x\n", addr, handle);
> -	vfree(addr);
> +	/*
> +	 * XXX: this doesn't seem to handle the sun3 MMU at all.
> +	 */
> +	if (CPU_IS_040_OR_060) {
> +		pgprot_val(prot) &= ~_PAGE_CACHE040;
> +		pgprot_val(prot) |= _PAGE_GLOBAL040 | _PAGE_NOCACHE_S;
> +	} else {
> +		pgprot_val(prot) |= _PAGE_NOCACHE030;
> +	}
> +	return prot;
>   }
> -
>   #else
>   
>   #include <asm/cacheflush.h>
> 
