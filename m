Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D0117BBF;
	Wed, 31 Jul 2024 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722447243; cv=none; b=MXy/rZCcqGhoyJqw4YWuitbGdGEt+6ZAFH+T7xHB3DzicUKB0S/I5p1SACqOj+dZqXl0VGcsIHyLEYjXiz9lHpO0ntUXvAk8d8jDS3VI6YProh9cVLZvrWMPI+1J6KgCO2sLaodloT4MhE/BLEc7em5fFujU01+4XA7VMuJjKvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722447243; c=relaxed/simple;
	bh=SN8HvVI974rHB09wSII8ovqszq7qCt+7z2AFFW52FyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rm9EFLwuM4VW4MnvczX8tfTd57cXral7BKBFMb3qHUpz3H46gOF/pI68adMwIr9saXfHNpTvmiBaW8x3CstFEFB/49gzqhJXZNYWpt0zyBo/VN+Zcu2s3g2EyuiM3DymaLc/bLtqogq2Dz+/y3P2bxvQ+BLCbzmKgLBWKBfkMVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79E6C116B1;
	Wed, 31 Jul 2024 17:34:00 +0000 (UTC)
Date: Wed, 31 Jul 2024 18:33:58 +0100
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
Subject: Re: [PATCH v3 3/3] dma-direct: use RAM start to offset zone_dma_limit
Message-ID: <Zqp1hvYSmM58IITx@arm.com>
References: <cover.1722249878.git.baruch@tkos.co.il>
 <629b184354fa22cb32a90bd1fa0e1dc258251f81.1722249878.git.baruch@tkos.co.il>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <629b184354fa22cb32a90bd1fa0e1dc258251f81.1722249878.git.baruch@tkos.co.il>

On Mon, Jul 29, 2024 at 01:51:26PM +0300, Baruch Siach wrote:
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 410a7b40e496..ded3d841c88c 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -12,6 +12,7 @@
>  #include <linux/set_memory.h>
>  #include <linux/slab.h>
>  #include <linux/workqueue.h>
> +#include <linux/memblock.h>
>  
>  static struct gen_pool *atomic_pool_dma __ro_after_init;
>  static unsigned long pool_size_dma;
> @@ -70,7 +71,7 @@ static bool cma_in_zone(gfp_t gfp)
>  	/* CMA can't cross zone boundaries, see cma_activate_area() */
>  	end = cma_get_base(cma) + size - 1;
>  	if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp & GFP_DMA))
> -		return end <= zone_dma_limit;
> +		return end <= memblock_start_of_DRAM() + zone_dma_limit;

I think this patch is entirely wrong. After the previous patch,
zone_dma_limit is already a physical/CPU address, not some offset or
range - of_dma_get_max_cpu_address() returns the absolute physical
address. Adding memblock_start_of_DRAM() to it does not make any sense.
It made sense when we had zone_dma_bits but since we are trying to move
away from bitmasks to absolute CPU addresses, zone_dma_limit already
includes the start of DRAM.

What problems do you see without this patch? Is it because
DMA_BIT_MASK(32) can be lower than zone_dma_limit as I mentioned on the
previous patch?

-- 
Catalin
