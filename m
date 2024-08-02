Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220871C2312;
	Fri,  2 Aug 2024 09:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722591464; cv=none; b=nj9I3+3L/Zdu6IU3Z84wBJ2V1F5sQCRFzc116qQdVOkjM3IId3Gb9jFcUMuINuivi6s11RY0ceutLch21KNH9Cgc4ruWdIWhskAJb9I3cPEWM2W+lNsR1yNfzSy0Lk3lIIui5W3KB0/GdUEI3BLdHfpI3SBjBWP4nZa1oj4X3rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722591464; c=relaxed/simple;
	bh=ltOSUPsZibGklzCT+726uDqpI/gR+HZvRJVWnku4cnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i21sYO1AR40qpQegvDZvNHpFajyzKDN18buW2hdIp0wJoG7GPjsgnTefQOZ0ISjQIIq8ND5EG5PgH+SpxvQs46stF3Qq+5qOiW/20r/swPlBkYpHIfVUXPKZQPahw107ziv24YznRQNlb5PNAKPq9XvMRkgwOsEjd/ydPsuOWiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C709C32782;
	Fri,  2 Aug 2024 09:37:41 +0000 (UTC)
Date: Fri, 2 Aug 2024 10:37:38 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
	Ramon Fried <ramon@neureality.ai>,
	Elad Nachman <enachman@marvell.com>
Subject: Re: [PATCH v5 2/3] dma: replace zone_dma_bits by zone_dma_limit
Message-ID: <Zqyo4qjPRHUeUfS5@arm.com>
References: <cover.1722578375.git.baruch@tkos.co.il>
 <5821a1b2eb82847ccbac0945da040518d6f6f16b.1722578375.git.baruch@tkos.co.il>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5821a1b2eb82847ccbac0945da040518d6f6f16b.1722578375.git.baruch@tkos.co.il>

On Fri, Aug 02, 2024 at 09:03:47AM +0300, Baruch Siach wrote:
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 3b4be4ca3b08..62b36fda44c9 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -20,7 +20,7 @@
>   * it for entirely different regions. In that case the arch code needs to
>   * override the variable below for dma-direct to work properly.
>   */
> -unsigned int zone_dma_bits __ro_after_init = 24;
> +u64 zone_dma_limit __ro_after_init = DMA_BIT_MASK(24);

u64 here makes sense even if it may be larger than phys_addr_t. It
matches the phys_limit type in the swiotlb code. The compilers should no
longer complain.

> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index d10613eb0f63..7b04f7575796 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -70,9 +70,9 @@ static bool cma_in_zone(gfp_t gfp)
>  	/* CMA can't cross zone boundaries, see cma_activate_area() */
>  	end = cma_get_base(cma) + size - 1;
>  	if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp & GFP_DMA))
> -		return end <= DMA_BIT_MASK(zone_dma_bits);
> +		return end <= zone_dma_limit;
>  	if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32))
> -		return end <= DMA_BIT_MASK(32);
> +		return end <= max(DMA_BIT_MASK(32), zone_dma_limit);
>  	return true;
>  }
>  
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 043b0ecd3e8d..bb51bd5335ad 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -450,9 +450,9 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>  	if (!remap)
>  		io_tlb_default_mem.can_grow = true;
>  	if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp_mask & __GFP_DMA))
> -		io_tlb_default_mem.phys_limit = DMA_BIT_MASK(zone_dma_bits);
> +		io_tlb_default_mem.phys_limit = zone_dma_limit;
>  	else if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp_mask & __GFP_DMA32))
> -		io_tlb_default_mem.phys_limit = DMA_BIT_MASK(32);
> +		io_tlb_default_mem.phys_limit = max(DMA_BIT_MASK(32), zone_dma_limit);
>  	else
>  		io_tlb_default_mem.phys_limit = virt_to_phys(high_memory - 1);
>  #endif

These two look correct to me now and it's the least intrusive (the
alternative would have been a zone_dma32_limit). The arch code, however,
needs to ensure that zone_dma_limit can always support 32-bit devices
even if it is above 4GB (with the relevant dma offsets in place for such
devices).

-- 
Catalin
