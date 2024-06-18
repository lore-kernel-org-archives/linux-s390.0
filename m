Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60202178370;
	Tue, 18 Jun 2024 21:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718746845; cv=none; b=O5EgNL5MVQ6Vvt0rFtgKQ4C30LLYdN+CFaKdBjpMD6R5zEZ8jNAHMFTf9ETG8AJ0sXmEaatSODU7dtBy+bFsr6BGAQ3I1klVYRkvyBXcofS8UUqEPyfVwShNO/lI/2BuAv3+5btrZypMbgf8jTg/Pm+7iwFBZjp6cDUHHyK5xQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718746845; c=relaxed/simple;
	bh=y0JDpHsLF+T1MFExA7y0H6q1nD+saREx6EdOp5AccRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KStvzitgtgbQTiPPzVWlk953+qEQvfAj9FEKBO6CaMkqu5InTfGsNNH+MC7zyfY+3EdRUKrT6Ny1qa+ntFNU+edQnejoUf4tO5shLMs1DC3erIjnScl7UxvrbTjoYKvnEEXLqDRhkmDiyRGEQQ30LKK+YKDnWa3ASGxar7RPay4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E00DC3277B;
	Tue, 18 Jun 2024 21:40:41 +0000 (UTC)
Date: Tue, 18 Jun 2024 22:40:39 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
	Ramon Fried <ramon@neureality.ai>,
	Elad Nachman <enachman@marvell.com>
Subject: Re: [PATCH RFC v2 4/5] dma-direct: add base offset to zone_dma_bits
Message-ID: <ZnH-18_lQsdYaxgj@arm.com>
References: <cover.1712642324.git.baruch@tkos.co.il>
 <1d7b0d59590aae631b6f0b894257ab961b907b44.1712642324.git.baruch@tkos.co.il>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d7b0d59590aae631b6f0b894257ab961b907b44.1712642324.git.baruch@tkos.co.il>

On Tue, Apr 09, 2024 at 09:17:57AM +0300, Baruch Siach wrote:
> Current code using zone_dma_bits assume that all addresses range in the
> bits mask are suitable for DMA. For some existing platforms this
> assumption is not correct. DMA range might have non zero lower limit.
[...]
> @@ -59,7 +60,7 @@ static gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 *phys_limit)
>  	 * zones.
>  	 */
>  	*phys_limit = dma_to_phys(dev, dma_limit);
> -	if (*phys_limit <= zone_dma_limit)
> +	if (*phys_limit <= zone_dma_base + zone_dma_limit)
>  		return GFP_DMA;
>  	if (*phys_limit <= DMA_BIT_MASK(32))
>  		return GFP_DMA32;

As I said previously, we no longer have zone_dma_bits after the first
patch, so adding this limit no longer make sense. In v1, you wanted a
limit like 32G to be added to the 30-bit zone_dma_bits to give you 33G
upper limit for ZONE_DMA. But since the first patch sets zone_dma_limit
to 33G already, this is no longer needed.

-- 
Catalin
