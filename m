Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5FA20012A;
	Wed,  7 Aug 2024 13:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039134; cv=none; b=ONIIK6KXCpv1i9mbo5oAbOOH5KaB+0ezrm4seug7B1UljM24zdPDAB8nS8qah3AXXV2jB19VI6nHyDyLsR+6hS5yOPJ43Z6T8raz4fF9NzNm4R3W1hG5ozxKDBNeld3ndsRpSkJs+iWkjfDZuS9tgLukn8i0+dGlu2B/lErT+v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039134; c=relaxed/simple;
	bh=6FHgpQfZoZLmxO9E7JDL51SAO3eeUQ7kibi3sNPMDBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZraVEFW0jqsOeybqfA+QbhuR/I/Yv78HZvn+pUS8lrSMuY/DzKz+kSKzX4TKym2s17RjWrtZzgj40hmrShGyqdpSna9yhA9J/bPdNyAD3sOKbSl34Xn4Y/zFYkeepKd9p1TWqxV+bEi7exPD8mstWHKN5GB6WEqEgNow7DE7y20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555DAC32781;
	Wed,  7 Aug 2024 13:58:51 +0000 (UTC)
Date: Wed, 7 Aug 2024 14:58:49 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Baruch Siach <baruch@tkos.co.il>, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
	Ramon Fried <ramon@neureality.ai>,
	Elad Nachman <enachman@marvell.com>
Subject: Re: [PATCH v5 1/3] dma: improve DMA zone selection
Message-ID: <ZrN9mRoQj2lTo6L5@arm.com>
References: <cover.1722578375.git.baruch@tkos.co.il>
 <5200f289af1a9b80dfd329b6ed3d54e1d4a02876.1722578375.git.baruch@tkos.co.il>
 <8230985e-1581-411f-895c-b49065234520@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8230985e-1581-411f-895c-b49065234520@arm.com>

Thanks Robin for having a look.

On Wed, Aug 07, 2024 at 02:13:06PM +0100, Robin Murphy wrote:
> On 2024-08-02 7:03 am, Baruch Siach wrote:
> > When device DMA limit does not fit in DMA32 zone it should use DMA zone,
> > even when DMA zone is stricter than needed.
> > 
> > Same goes for devices that can't allocate from the entire normal zone.
> > Limit to DMA32 in that case.
> 
> Per the bot report this only works for CONFIG_ARCH_KEEP_MEMBLOCK,

Yeah, I just noticed.

> however
> the whole concept looks wrong anyway. The logic here is that we're only
> forcing a particular zone if there's *no* chance of the higher zone being
> usable. For example, ignoring offsets for simplicity, if we have a 40-bit
> DMA mask then we *do* want to initially try allocating from ZONE_NORMAL even
> if max_pfn is above 40 bits, since we still might get a usable allocation
> from between 32 and 40 bits, and if we don't, then we'll fall back to
> retrying from the DMA zone(s) anyway.

Ah, I did not read the code further down in __dma_direct_alloc_pages(),
it does fall back to a GFP_DMA allocation if !dma_coherent_ok().
Similarly with swiotlb_alloc_tlb(), it keeps retrying until the
allocation fails.

So yes, this patch can be dropped.

-- 
Catalin
