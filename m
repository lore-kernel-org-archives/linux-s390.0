Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0EF1607A5;
	Thu,  1 Aug 2024 10:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722506952; cv=none; b=J9Ez2IHvBFDo4NdEwv4OTdV8UrHW5CBgtQI8DPN7NrXrKzCA5JBRokBwJjDhkW/gYotcryayMlfG6FTS5NJ4ewIPE9uodPy4nCwYvdNzRdeFhENjOjqM6/XYGe20r/6ziRJmdK3x5JYawrn2iM+DtRdDN4GM1pDXT9hSafVJ1gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722506952; c=relaxed/simple;
	bh=lEGW+kdJEkCoozNDdKuFRerDnO0MoGrNtEtUI3sBXhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBIjTqMHMissCPBxZPBDmWGgCTP792VTWyvoNzh83sEbHvbXRNSo8iVm3IvVcZOUOU3PgPpXqpw8wbtzoQPZzpp4iggDjhIoQKY638eXvKq7s3DxdBsHpoGX7aI2Xd7ycibVvQYgXwszvGIu0G5WnH5oeMutDsnbcByPfYzZvlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF65C32786;
	Thu,  1 Aug 2024 10:09:09 +0000 (UTC)
Date: Thu, 1 Aug 2024 11:09:07 +0100
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
Message-ID: <Zqtew0ra4opFgl9l@arm.com>
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

OK, so no functional change here which is good. But isn't this series
missing some additional patches to limit ZONE_DMA? For you platform, the
above function expands ZONE_DMA to the whole RAM which IIUC it's not
what you want eventually.

-- 
Catalin
