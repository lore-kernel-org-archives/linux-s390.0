Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6303446A1;
	Thu,  1 Aug 2024 10:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508251; cv=none; b=PiN732Q2/mpPnK8nU7p2GQ0N+gv5MOQqJhRB5qZ4r8RXTD3igifJ8d7K7qP4E19T8Lqq5ePhl4XfT/LnmM1eQVSaBuVVPy86J7ci+Izf7AfnzEgIPESUAsQLKch8FOPOMXdnQyJvdzgRK0M2befPcXCwqwutUwFNn80KoKDl/ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508251; c=relaxed/simple;
	bh=840boNeP0FMtLMePk2Z6i4zIPxM/EiNSN0Vbo1zyxEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGg2l4s41BayT0CZc65TK3SgF4U/nz5UId7uipqrsiSHsloV+gbE2zOZxDW9W5l9ApgLpnTVI6E3CHfCvRdzsTzP1cIELl59K+yfWEamQrZ3M3bNhtBcNzQRAD7J8QLAqBIUOkfcDju8qq4FD0Yd0f2JPb1sDCObZHCbwoB0U24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030D1C32786;
	Thu,  1 Aug 2024 10:30:48 +0000 (UTC)
Date: Thu, 1 Aug 2024 11:30:46 +0100
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
Subject: Re: [PATCH v4 2/2] dma: replace zone_dma_bits by zone_dma_limit
Message-ID: <Zqtj1iCyRJqh_xeL@arm.com>
References: <cover.1722499975.git.baruch@tkos.co.il>
 <f05178048096908a13379a61ca56f0035a5cdb2d.1722499975.git.baruch@tkos.co.il>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f05178048096908a13379a61ca56f0035a5cdb2d.1722499975.git.baruch@tkos.co.il>

On Thu, Aug 01, 2024 at 11:25:07AM +0300, Baruch Siach wrote:
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index d10613eb0f63..a6e15db9d1e7 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -70,9 +70,10 @@ static bool cma_in_zone(gfp_t gfp)
>  	/* CMA can't cross zone boundaries, see cma_activate_area() */
>  	end = cma_get_base(cma) + size - 1;
>  	if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp & GFP_DMA))
> -		return end <= DMA_BIT_MASK(zone_dma_bits);
> +		return end <= zone_dma_limit;
> +	/* Account for possible zone_dma_limit > DMA_BIT_MASK(32) */
>  	if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32))
> -		return end <= DMA_BIT_MASK(32);
> +		return end <= DMA_BIT_MASK(32) || end <= zone_dma_limit;
>  	return true;
>  }
>  
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 043b0ecd3e8d..53595eb41922 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -450,7 +450,7 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>  	if (!remap)
>  		io_tlb_default_mem.can_grow = true;
>  	if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp_mask & __GFP_DMA))
> -		io_tlb_default_mem.phys_limit = DMA_BIT_MASK(zone_dma_bits);
> +		io_tlb_default_mem.phys_limit = zone_dma_limit;
>  	else if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp_mask & __GFP_DMA32))
>  		io_tlb_default_mem.phys_limit = DMA_BIT_MASK(32);

I think this needs some adjustment as the cma_in_zone() case. Maybe just
use max(DMA_BIT_MASK(32), zone_dma_limit) in both cases for consistency.

-- 
Catalin
