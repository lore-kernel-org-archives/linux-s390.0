Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2216390C85;
	Wed,  8 Jul 2026 11:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783510559; cv=none; b=jL+LAz4qxE0ESoInR0qF7TJUQUFIFfGORNVy4D3L+YC99rZTUAe0WNeRPnZ2ZxO1ev8T4QRM+npoG1KjNrlJ93agBzFFbgJ5ird7JawLt8ag1bKRZhhs0qyurm4xNQLM4XuoCjldokdOUwlWvn3L70X3Z9oCvQZnE9v+oN9eO+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783510559; c=relaxed/simple;
	bh=skF61y21KgPsVGfJvwoIpH8oYC/C836tWg/Zi0aByAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtCXphLx5hXQOjvrjEZYoElacHTsrfSVjy8GDUKBdGa4RSccMmt1JAgPHAZIuJ+Xs29dUhd7IXVyoRX5YMaYXr0Gf3CgrTOciMCylsKnK272tfNn52dSZukID0WsODp0p6RNmQdRhxySEelFZEioTMYHEz0T/6OuMdJZD/KlU/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BDUtEDVy; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BDUtEDVy"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00BCE1E5E;
	Wed,  8 Jul 2026 04:35:53 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E39E3F85F;
	Wed,  8 Jul 2026 04:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783510557; bh=skF61y21KgPsVGfJvwoIpH8oYC/C836tWg/Zi0aByAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BDUtEDVyOjE2X987uSwyfq3z9RD7lBFkhkdA5EBvVEUJF3xFy0wXNZao/bpBtdGJT
	 bzEIyGgplNZ8FteGaCdPd8M9i1hu4qN4jloW+AkzdgaaYEgqMwYQieSh7ECTVL08I/
	 ukOcYIu1QhMGKdh1zDxGves8zlEW6X1jwQ6tkJ14=
Date: Wed, 8 Jul 2026 12:35:51 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Jiri Pirko <jiri@nvidia.com>, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 16/22] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
Message-ID: <ak42F240d-53QeFN@arm.com>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-17-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-17-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:20AM +0530, Aneesh Kumar K.V (Arm) wrote:
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 97987f850a33..acf67c7064db 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -338,10 +338,8 @@ void __init arch_mm_preinit(void)
>  	unsigned int flags = SWIOTLB_VERBOSE;
>  	bool swiotlb = max_pfn > PFN_DOWN(arm64_dma_phys_limit);
>  
> -	if (is_realm_world()) {
> +	if (is_realm_world())
>  		swiotlb = true;
> -		flags |= SWIOTLB_FORCE;
> -	}

For this part:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
> index e05dc7649366..f3fc28f352ba 100644
> --- a/kernel/dma/direct.h
> +++ b/kernel/dma/direct.h
> @@ -88,37 +88,40 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
>  {
>  	dma_addr_t dma_addr;
>  
> +	/*
> +	 * For a device requiring unencrypted DMA, MMIO memory is treated
> +	 * as shared by default.
> +	 */
> +	if (force_dma_unencrypted(dev) && (attrs & DMA_ATTR_MMIO))
> +		attrs |= DMA_ATTR_CC_SHARED;
> +
>  	if (is_swiotlb_force_bounce(dev)) {
> -		if (!(attrs & DMA_ATTR_CC_SHARED)) {
> -			if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
> -				return DMA_MAPPING_ERROR;
> +		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
> +			return DMA_MAPPING_ERROR;
>  
> -			return swiotlb_map(dev, phys, size, dir, attrs);
> -		}
> -	} else if (attrs & DMA_ATTR_CC_SHARED) {
> -		return DMA_MAPPING_ERROR;
> +		return swiotlb_map(dev, phys, size, dir, attrs);
>  	}
>  
> -	if (attrs & DMA_ATTR_MMIO) {
> -		dma_addr = phys;
> -		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
> -			goto err_overflow;
> -	} else if (attrs & DMA_ATTR_CC_SHARED) {
> +	if (attrs & DMA_ATTR_CC_SHARED)
>  		dma_addr = phys_to_dma_unencrypted(dev, phys);
> +	else
> +		dma_addr = phys_to_dma_encrypted(dev, phys);

For AMD/SME, on host with memory encryption we now end up setting the C
bit for DMA_ATTR_MMIO. This is fine for RAM but not sure whether
some other MMIO bus understands this attribute. Maybe we should stick to
something like __phys_to_dma() for the !CC_SHARED && MMIO path. Or,
since this is not universally defined, just use the old dma_addr = phys
if MMIO and ignore any unlikely DMA offsets.

In the other case, for an arm CCA guest, if the MMIO is shared we end up
setting the shared attribute but that's fine, it's only an IPA address.

-- 
Catalin
