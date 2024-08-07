Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3EF2209B;
	Wed,  7 Aug 2024 14:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040387; cv=none; b=Hy4mW9abWpV4YYBV+MdvOypqFCrApDRUg7hWzsuSJNDpdv3DpMlWPeFzitru9+fX8DtkaPiEG26IxgqA3f8gdaRMtZ6a9BPPQH8HnFIkdBEaxtsl5hgGHtW19AYsO0ydcAWvVXsuC4CLnmMDylYgSCmp8BewZ7sG0nB8wmdOkaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040387; c=relaxed/simple;
	bh=V2XcldorF5mZxWgoV6rXHIZvLXFu/Cfe7abbKfSvCBI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HG8QYkRj297y+xocV1sJ8WKfknz/mgHzekLDdk3gkIQ5ir3QUK1hLkn9mzD0l1J0bwKSU4sry1gaCl+AU8VMKTXtuH4RO5kNJh4SottUCfFKjz/0G8N5W4H1iEsH5L7vSGr6UTq06DeEDy7gq6AJdLR6iymNQPfUDtU8rAfgMdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=i65GwrEa; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="i65GwrEa"
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 581DA1D4827;
	Wed,  7 Aug 2024 16:19:43 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1723040383; bh=XLWRMbtGcTsuduq8sYIgOj2Fv5+dhfpUSVkhtNTwEKs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i65GwrEaWJJSMm99frEtR7SuRGEX3gN1vzFXh2M8PBIgW+RsOaMIeqQVp9+tWaGD8
	 /YNoeYcOzMnMmVYXGfa4/im2fp+jFdGFBjLaB6/wg4YlBgNs87dbzwtqDoB3iboUMQ
	 uknhZZbif8Mx36WsiJPi/ciX025KxDJDtfHQvCaScDK7UjvtnQ+wcvWLFasyNPbiXx
	 4nf7jgzre9eFkJWXAo3rcRvI2k6Pdic8/+K6elXZgoJ8rXB6Zykhp5b9yMcQvENf/9
	 rr/4NtWBGu7ADNh76DtVGevak4OOLyst1aitj0NfgEMtoYlN8XmKbm7/MrBkRa1vW4
	 1fOsAT735pwMQ==
Date: Wed, 7 Aug 2024 16:19:38 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Baruch Siach <baruch@tkos.co.il>, Christoph Hellwig <hch@lst.de>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Ramon Fried
 <ramon@neureality.ai>, Elad Nachman <enachman@marvell.com>
Subject: Re: [PATCH v5 2/3] dma: replace zone_dma_bits by zone_dma_limit
Message-ID: <20240807161938.5729b656@mordecai.tesarici.cz>
In-Reply-To: <Zqyo4qjPRHUeUfS5@arm.com>
References: <cover.1722578375.git.baruch@tkos.co.il>
	<5821a1b2eb82847ccbac0945da040518d6f6f16b.1722578375.git.baruch@tkos.co.il>
	<Zqyo4qjPRHUeUfS5@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 Aug 2024 10:37:38 +0100
Catalin Marinas <catalin.marinas@arm.com> wrote:

> On Fri, Aug 02, 2024 at 09:03:47AM +0300, Baruch Siach wrote:
> > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > index 3b4be4ca3b08..62b36fda44c9 100644
> > --- a/kernel/dma/direct.c
> > +++ b/kernel/dma/direct.c
> > @@ -20,7 +20,7 @@
> >   * it for entirely different regions. In that case the arch code needs to
> >   * override the variable below for dma-direct to work properly.
> >   */
> > -unsigned int zone_dma_bits __ro_after_init = 24;
> > +u64 zone_dma_limit __ro_after_init = DMA_BIT_MASK(24);  
> 
> u64 here makes sense even if it may be larger than phys_addr_t. It
> matches the phys_limit type in the swiotlb code. The compilers should no
> longer complain.

FTR I have never quite understood why phys_limit is u64, but u64 was
already used all around the place when I first looked into swiotlb.

> > diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> > index d10613eb0f63..7b04f7575796 100644
> > --- a/kernel/dma/pool.c
> > +++ b/kernel/dma/pool.c
> > @@ -70,9 +70,9 @@ static bool cma_in_zone(gfp_t gfp)
> >  	/* CMA can't cross zone boundaries, see cma_activate_area() */
> >  	end = cma_get_base(cma) + size - 1;
> >  	if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp & GFP_DMA))
> > -		return end <= DMA_BIT_MASK(zone_dma_bits);
> > +		return end <= zone_dma_limit;
> >  	if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32))
> > -		return end <= DMA_BIT_MASK(32);
> > +		return end <= max(DMA_BIT_MASK(32), zone_dma_limit);
> >  	return true;
> >  }
> >  
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index 043b0ecd3e8d..bb51bd5335ad 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -450,9 +450,9 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
> >  	if (!remap)
> >  		io_tlb_default_mem.can_grow = true;
> >  	if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp_mask & __GFP_DMA))
> > -		io_tlb_default_mem.phys_limit = DMA_BIT_MASK(zone_dma_bits);
> > +		io_tlb_default_mem.phys_limit = zone_dma_limit;
> >  	else if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp_mask & __GFP_DMA32))
> > -		io_tlb_default_mem.phys_limit = DMA_BIT_MASK(32);
> > +		io_tlb_default_mem.phys_limit = max(DMA_BIT_MASK(32), zone_dma_limit);
> >  	else
> >  		io_tlb_default_mem.phys_limit = virt_to_phys(high_memory - 1);
> >  #endif  
> 
> These two look correct to me now and it's the least intrusive (the
> alternative would have been a zone_dma32_limit). The arch code, however,
> needs to ensure that zone_dma_limit can always support 32-bit devices
> even if it is above 4GB (with the relevant dma offsets in place for such
> devices).

Just to make sure, the DMA zone (if present) must map to at most 32-bit
bus address space (possibly behind a bridge). Is that what you're
saying?

Petr T
