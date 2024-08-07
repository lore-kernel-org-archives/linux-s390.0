Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3907740C03;
	Wed,  7 Aug 2024 18:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054503; cv=none; b=hW9L6NFVarkEE98lhtYKvY7j/8y6GVx8lI5AjjOuDyR3bWPIDWrUIetPBmmzNu3gC3O1T56CeGzRuqklAPAWlmaSMnMP7aMszaKTqrRhD8h5+1pD3zB36sTFkjlf+8FbLp/BYhbDCXe4PEjSMLDHxlt19YVJl3Zuvzyen+V9984=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054503; c=relaxed/simple;
	bh=S9+3aXk/90xN7zHpUlBdinuML+LWZSnp6QRU/eb+WW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=El5Oc1FyapJ+qen6wnyklUMRdfYdyLbdoNlkz+k8cvI2nooNcvcUWxlx3VD8c+Aw/bU9m05I4CKF/n8kq9lj8Yii4rvshde23HKShbMfKrlBA1RrHNOhELdQPas2AdpFaKVguFujg34NbgQJHo1pIcHTw4NKZDPUb8k24IfclL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C87EC32781;
	Wed,  7 Aug 2024 18:15:00 +0000 (UTC)
Date: Wed, 7 Aug 2024 19:14:58 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Baruch Siach <baruch@tkos.co.il>, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, Ramon Fried <ramon@neureality.ai>,
	Elad Nachman <enachman@marvell.com>
Subject: Re: [PATCH v5 2/3] dma: replace zone_dma_bits by zone_dma_limit
Message-ID: <ZrO5okGUljTc9E7N@arm.com>
References: <cover.1722578375.git.baruch@tkos.co.il>
 <5821a1b2eb82847ccbac0945da040518d6f6f16b.1722578375.git.baruch@tkos.co.il>
 <Zqyo4qjPRHUeUfS5@arm.com>
 <20240807161938.5729b656@mordecai.tesarici.cz>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240807161938.5729b656@mordecai.tesarici.cz>

On Wed, Aug 07, 2024 at 04:19:38PM +0200, Petr Tesařík wrote:
> On Fri, 2 Aug 2024 10:37:38 +0100
> Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Fri, Aug 02, 2024 at 09:03:47AM +0300, Baruch Siach wrote:
> > > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > > index 3b4be4ca3b08..62b36fda44c9 100644
> > > --- a/kernel/dma/direct.c
> > > +++ b/kernel/dma/direct.c
> > > @@ -20,7 +20,7 @@
> > >   * it for entirely different regions. In that case the arch code needs to
> > >   * override the variable below for dma-direct to work properly.
> > >   */
> > > -unsigned int zone_dma_bits __ro_after_init = 24;
> > > +u64 zone_dma_limit __ro_after_init = DMA_BIT_MASK(24);  
> > 
> > u64 here makes sense even if it may be larger than phys_addr_t. It
> > matches the phys_limit type in the swiotlb code. The compilers should no
> > longer complain.
> 
> FTR I have never quite understood why phys_limit is u64, but u64 was
> already used all around the place when I first looked into swiotlb.
> 
> > > diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> > > index d10613eb0f63..7b04f7575796 100644
> > > --- a/kernel/dma/pool.c
> > > +++ b/kernel/dma/pool.c
> > > @@ -70,9 +70,9 @@ static bool cma_in_zone(gfp_t gfp)
> > >  	/* CMA can't cross zone boundaries, see cma_activate_area() */
> > >  	end = cma_get_base(cma) + size - 1;
> > >  	if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp & GFP_DMA))
> > > -		return end <= DMA_BIT_MASK(zone_dma_bits);
> > > +		return end <= zone_dma_limit;
> > >  	if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32))
> > > -		return end <= DMA_BIT_MASK(32);
> > > +		return end <= max(DMA_BIT_MASK(32), zone_dma_limit);
> > >  	return true;
> > >  }
> > >  
> > > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > > index 043b0ecd3e8d..bb51bd5335ad 100644
> > > --- a/kernel/dma/swiotlb.c
> > > +++ b/kernel/dma/swiotlb.c
> > > @@ -450,9 +450,9 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
> > >  	if (!remap)
> > >  		io_tlb_default_mem.can_grow = true;
> > >  	if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp_mask & __GFP_DMA))
> > > -		io_tlb_default_mem.phys_limit = DMA_BIT_MASK(zone_dma_bits);
> > > +		io_tlb_default_mem.phys_limit = zone_dma_limit;
> > >  	else if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp_mask & __GFP_DMA32))
> > > -		io_tlb_default_mem.phys_limit = DMA_BIT_MASK(32);
> > > +		io_tlb_default_mem.phys_limit = max(DMA_BIT_MASK(32), zone_dma_limit);
> > >  	else
> > >  		io_tlb_default_mem.phys_limit = virt_to_phys(high_memory - 1);
> > >  #endif  
> > 
> > These two look correct to me now and it's the least intrusive (the
> > alternative would have been a zone_dma32_limit). The arch code, however,
> > needs to ensure that zone_dma_limit can always support 32-bit devices
> > even if it is above 4GB (with the relevant dma offsets in place for such
> > devices).
> 
> Just to make sure, the DMA zone (if present) must map to at most 32-bit
> bus address space (possibly behind a bridge). Is that what you're
> saying?

No exactly. What I'm trying to say is that on arm64 zone_dma_limit can
go beyond DMA_BIT_MASK(32) when the latter is treated as a CPU address.
In such cases, ZONE_DMA32 is empty.

TBH, this code is confusing and not entirely suitable for a system where
the CPU address offsets are not 0. The device::dma_coherent_mask is
about the bus address range and phys_limit is calculated correctly in
functions like dma_direct_optimal_gfp_mask(). But that's about it w.r.t.
DMA bit masks because zone_dma_bits and DMA_BIT_MASK(32) are assumed to
be about the CPU address ranges in some cases (in other cases
DMA_BIT_MASK() is used to initialise dma_coherent_mask, so more of a bus
address).

On the platform Baruch is trying to fix, RAM starts at 32GB and ZONE_DMA
should end at 33GB. That's 30-bit mask in bus address terms but
something not a power of two for the CPU address, hence the
zone_dma_limit introduced here.

With ZONE_DMA32, since all the DMA code assumes that ZONE_DMA32 ends at
4GB CPU address, it doesn't really work for such platforms. If there are
32-bit devices with a corresponding CPU address offset, ZONE_DMA32
should end at 36GB on Baruch's platform. But to simplify things, we just
ignore this on arm64 and make ZONE_DMA32 empty.

In some cases where we have the device structure we could instead do a
dma_to_phys(DMA_BIT_MASK(32)) but not in the two cases above. I guess if
we really want to address this properly, we'd need to introduce a
zone_dma32_limit that's initialised by the arch code. For arm64, I'm
happy with just having an empty ZONE_DMA32 on such platforms.

-- 
Catalin
