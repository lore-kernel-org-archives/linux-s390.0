Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFA077115;
	Wed,  7 Aug 2024 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723041028; cv=none; b=UgoYOMzoGCj1gj8rcbZLVkAAXISwtWIr+E4jMG+Z6MekfuXALLWpGSe7/kla47VgE8ASwYkL2OPHHv/Gs83SnCBvzl//ewrypu7zeciQmcNAAe85Iv5rziUDOC6nFAUK+ei7ZZgIwayeIphQJ+vkA3uJm9lkj33PRnRrbo/0Ya4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723041028; c=relaxed/simple;
	bh=QzPepkmn5t3sttqjso+RrxDl7XmkJR9GRm1RfLnXD5w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hm75gywr8NuvYVYiv2UX/xlHbADKMwGBDzvCkspfIGsqzTod9eKxlClUSM2YyLLUaaUIH6MdJ74Wz9anYUpSsbJdTiqQMNXgab/FzANRHmAkgt+5jcsuXggnuH2g8MrZSPEW3pgKCPdqDdYhBFXidiQeGhNwcwBn8uryHIPV9dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=K1dxIE0F; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="K1dxIE0F"
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id F2E101D075D;
	Wed,  7 Aug 2024 16:30:23 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1723041024; bh=XAUy83SIsEkQWYxz3O+tVWcw2Qdh3or1+I8QyhdW1Ag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K1dxIE0FMMd+6gq7o8Dd512aiISXSgpu78zkPa7RXq8GCuFL7cwj17FMXIMD5ohSD
	 iZpudqWW352ZAXTIxcuHOq73sa8nkQLd54b/qRwqMXOkGn+R867ChpSLkky2fCKSXm
	 GPk9eMk7rPSZ+vqPUzzfB0Llgf/366Y1n80SLTdjCdpdBSjcw5sY44f0qhv9LTOnWY
	 lDBFgNaWYmEO2LKBpHllA7AHNYNnkAnYBcvLQxBFX1T4xB3uPxR1gaxjkLYWKIYG6O
	 qi80YmPalbqthWACc4tyrrpRtEDAm/jDmR5JXZzSz3/IxBFa6TDpOCiB7jayThH7Ux
	 pA8NNipy0wowA==
Date: Wed, 7 Aug 2024 16:30:19 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, Ramon Fried <ramon@neureality.ai>, Elad Nachman
 <enachman@marvell.com>
Subject: Re: [PATCH v5 2/3] dma: replace zone_dma_bits by zone_dma_limit
Message-ID: <20240807163019.3dddd2ad@mordecai.tesarici.cz>
In-Reply-To: <5821a1b2eb82847ccbac0945da040518d6f6f16b.1722578375.git.baruch@tkos.co.il>
References: <cover.1722578375.git.baruch@tkos.co.il>
	<5821a1b2eb82847ccbac0945da040518d6f6f16b.1722578375.git.baruch@tkos.co.il>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 Aug 2024 09:03:47 +0300
Baruch Siach <baruch@tkos.co.il> wrote:

> From: Catalin Marinas <catalin.marinas@arm.com>
> 
> Hardware DMA limit might not be power of 2. When RAM range starts above
> 0, say 4GB, DMA limit of 30 bits should end at 5GB. A single high bit
> can not encode this limit.
> 
> Use plain address for DMA zone limit.
> 
> Since DMA zone can now potentially span beyond 4GB physical limit of
> DMA32, make sure to use DMA zone for GFP_DMA32 allocations in that case.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Co-developed-by: Baruch Siach <baruch@tkos.co.il>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  arch/arm64/mm/init.c       | 30 +++++++++++++++---------------
>  arch/powerpc/mm/mem.c      |  9 ++++-----
>  arch/s390/mm/init.c        |  2 +-
>  include/linux/dma-direct.h |  2 +-
>  kernel/dma/direct.c        |  4 ++--
>  kernel/dma/pool.c          |  4 ++--
>  kernel/dma/swiotlb.c       |  4 ++--
>  7 files changed, 27 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 9b5ab6818f7f..c45e2152ca9e 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -115,35 +115,35 @@ static void __init arch_reserve_crashkernel(void)
>  }
>  
>  /*
> - * Return the maximum physical address for a zone accessible by the given bits
> - * limit. If DRAM starts above 32-bit, expand the zone to the maximum
> + * Return the maximum physical address for a zone given its limit.
> + * If DRAM starts above 32-bit, expand the zone to the maximum
>   * available memory, otherwise cap it at 32-bit.
>   */
> -static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
> +static phys_addr_t __init max_zone_phys(phys_addr_t zone_limit)
>  {
> -	phys_addr_t zone_mask = DMA_BIT_MASK(zone_bits);
>  	phys_addr_t phys_start = memblock_start_of_DRAM();
>  
>  	if (phys_start > U32_MAX)
> -		zone_mask = PHYS_ADDR_MAX;
> -	else if (phys_start > zone_mask)
> -		zone_mask = U32_MAX;
> +		zone_limit = PHYS_ADDR_MAX;
> +	else if (phys_start > zone_limit)
> +		zone_limit = U32_MAX;
>  
> -	return min(zone_mask, memblock_end_of_DRAM() - 1) + 1;
> +	return min(zone_limit, memblock_end_of_DRAM() - 1) + 1;
>  }
>  
>  static void __init zone_sizes_init(void)
>  {
>  	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
> -	unsigned int __maybe_unused acpi_zone_dma_bits;
> -	unsigned int __maybe_unused dt_zone_dma_bits;
> -	phys_addr_t __maybe_unused dma32_phys_limit = max_zone_phys(32);
> +	phys_addr_t __maybe_unused acpi_zone_dma_limit;
> +	phys_addr_t __maybe_unused dt_zone_dma_limit;
> +	phys_addr_t __maybe_unused dma32_phys_limit =
> +		max_zone_phys(DMA_BIT_MASK(32));
>  
>  #ifdef CONFIG_ZONE_DMA
> -	acpi_zone_dma_bits = fls64(acpi_iort_dma_get_max_cpu_address());
> -	dt_zone_dma_bits = fls64(of_dma_get_max_cpu_address(NULL));
> -	zone_dma_bits = min3(32U, dt_zone_dma_bits, acpi_zone_dma_bits);
> -	arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
> +	acpi_zone_dma_limit = acpi_iort_dma_get_max_cpu_address();
> +	dt_zone_dma_limit = of_dma_get_max_cpu_address(NULL);
> +	zone_dma_limit = min(dt_zone_dma_limit, acpi_zone_dma_limit);
> +	arm64_dma_phys_limit = max_zone_phys(zone_dma_limit);
>  	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
>  #endif
>  #ifdef CONFIG_ZONE_DMA32
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index d325217ab201..342c006cc1b8 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -216,7 +216,7 @@ static int __init mark_nonram_nosave(void)
>   * everything else. GFP_DMA32 page allocations automatically fall back to
>   * ZONE_DMA.
>   *
> - * By using 31-bit unconditionally, we can exploit zone_dma_bits to inform the
> + * By using 31-bit unconditionally, we can exploit zone_dma_limit to inform the
>   * generic DMA mapping code.  32-bit only devices (if not handled by an IOMMU
>   * anyway) will take a first dip into ZONE_NORMAL and get otherwise served by
>   * ZONE_DMA.
> @@ -252,13 +252,12 @@ void __init paging_init(void)
>  	 * powerbooks.
>  	 */
>  	if (IS_ENABLED(CONFIG_PPC32))
> -		zone_dma_bits = 30;
> +		zone_dma_limit = DMA_BIT_MASK(30);
>  	else
> -		zone_dma_bits = 31;
> +		zone_dma_limit = DMA_BIT_MASK(31);
>  
>  #ifdef CONFIG_ZONE_DMA
> -	max_zone_pfns[ZONE_DMA]	= min(max_low_pfn,
> -				      1UL << (zone_dma_bits - PAGE_SHIFT));
> +	max_zone_pfns[ZONE_DMA]	= min(max_low_pfn, zone_dma_limit >> PAGE_SHIFT);

No big deal, but this is off by one. DMA_BIT_MASK() returns the highest
address that can be represented with the given number of bits, whereas
max_zone_pfns[] contains the lowest PFN that is NOT contained in the
zone.

Rest of the patch looks perfect.

Petr T
