Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FC23FCB0A;
	Thu,  9 Jul 2026 11:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783595608; cv=none; b=tybnqddG6+Vu5dbrZ6Wn9O1VI8VVONMlFAJoP5tVPYznosP3Pdtjz1QXq59bZHsBKU9qkN7QET3vt9/iPBfINCGPeehZLizD5i8tv0B2pwT17FH2nxyJAExs2k3L/p0SD5BF5MkS3fh3Md2IPBXIT+XXk5zIv/aws6F5ydb9HGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783595608; c=relaxed/simple;
	bh=SAV3PQ7+eCtje2uVxH/LefEDAxakMvTJxqH9sWGHNjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ilp/WTK+4w638hH1gh3EUXiofRT0YvEqQH4UI/QA5oAodbSJOe3eUns+/qkJnJlwqlU62IorvbjoA3zeLpczsdQ5yEixzkfUGwFRiPMt9xSXe3UmRJfK4EEM43heCw4syLpkHj+6Nc5N9f90mZrnsb26pe37BwRaPnB1ElkE84k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dqr2VgVo; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dqr2VgVo"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25E443570;
	Thu,  9 Jul 2026 04:13:22 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E40B83FE53;
	Thu,  9 Jul 2026 04:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783595606; bh=SAV3PQ7+eCtje2uVxH/LefEDAxakMvTJxqH9sWGHNjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dqr2VgVo4J5uM+joPiCCMcuMryXYkHoDl8Yseh7vn5qnsw8KiVm31/w5zxn+qHZz6
	 FQ+PFakz3CMKt8/wA88yoTOV9CvFtW55mtYdapJsL6VEivjrkA7AVCtB4s+WoNPG6B
	 FEJ4cXCyQS9OxIYWx7h63mAscI4uPmXdfA6VwK+M=
Date: Thu, 9 Jul 2026 12:13:19 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
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
Message-ID: <ak-CT3oanlDfgTy4@arm.com>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-17-aneesh.kumar@kernel.org>
 <ak42F240d-53QeFN@arm.com>
 <yq5apl0xgy89.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5apl0xgy89.fsf@kernel.org>

On Wed, Jul 08, 2026 at 11:28:14PM +0530, Aneesh Kumar K.V wrote:
> Catalin Marinas <catalin.marinas@arm.com> writes:
> 
> > On Wed, Jul 01, 2026 at 11:19:20AM +0530, Aneesh Kumar K.V (Arm) wrote:
> >> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> >> index 97987f850a33..acf67c7064db 100644
> >> --- a/arch/arm64/mm/init.c
> >> +++ b/arch/arm64/mm/init.c
> >> @@ -338,10 +338,8 @@ void __init arch_mm_preinit(void)
> >>  	unsigned int flags = SWIOTLB_VERBOSE;
> >>  	bool swiotlb = max_pfn > PFN_DOWN(arm64_dma_phys_limit);
> >>  
> >> -	if (is_realm_world()) {
> >> +	if (is_realm_world())
> >>  		swiotlb = true;
> >> -		flags |= SWIOTLB_FORCE;
> >> -	}
> >
> > For this part:
> >
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> >
> >> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
> >> index e05dc7649366..f3fc28f352ba 100644
> >> --- a/kernel/dma/direct.h
> >> +++ b/kernel/dma/direct.h
> >> @@ -88,37 +88,40 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
> >>  {
> >>  	dma_addr_t dma_addr;
> >>  
> >> +	/*
> >> +	 * For a device requiring unencrypted DMA, MMIO memory is treated
> >> +	 * as shared by default.
> >> +	 */
> >> +	if (force_dma_unencrypted(dev) && (attrs & DMA_ATTR_MMIO))
> >> +		attrs |= DMA_ATTR_CC_SHARED;
> >> +
> >>  	if (is_swiotlb_force_bounce(dev)) {
> >> -		if (!(attrs & DMA_ATTR_CC_SHARED)) {
> >> -			if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
> >> -				return DMA_MAPPING_ERROR;
> >> +		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
> >> +			return DMA_MAPPING_ERROR;
> >>  
> >> -			return swiotlb_map(dev, phys, size, dir, attrs);
> >> -		}
> >> -	} else if (attrs & DMA_ATTR_CC_SHARED) {
> >> -		return DMA_MAPPING_ERROR;
> >> +		return swiotlb_map(dev, phys, size, dir, attrs);
> >>  	}
> >>  
> >> -	if (attrs & DMA_ATTR_MMIO) {
> >> -		dma_addr = phys;
> >> -		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
> >> -			goto err_overflow;
> >> -	} else if (attrs & DMA_ATTR_CC_SHARED) {
> >> +	if (attrs & DMA_ATTR_CC_SHARED)
> >>  		dma_addr = phys_to_dma_unencrypted(dev, phys);
> >> +	else
> >> +		dma_addr = phys_to_dma_encrypted(dev, phys);
> >
> > For AMD/SME, on host with memory encryption we now end up setting the C
> > bit for DMA_ATTR_MMIO. This is fine for RAM but not sure whether
> > some other MMIO bus understands this attribute. Maybe we should stick to
> > something like __phys_to_dma() for the !CC_SHARED && MMIO path. Or,
> > since this is not universally defined, just use the old dma_addr = phys
> > if MMIO and ignore any unlikely DMA offsets.
> >
> 
> Considering for AMD/SME system an unencrypted dma addr is one without C
> bit, will this be good?
> 
> 	/*
> 	 * For host memory encryption and device requiring unencrypted DMA,
> 	 * MMIO memory is treated as shared by default.
> 	 */
> 	if (attrs & DMA_ATTR_MMIO) {
> 		if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) || force_dma_unencrypted(dev))
> 			attrs |= DMA_ATTR_CC_SHARED;
> 	}

Yes, I think it does the trick, preserves the current semantics for AMD.
I guess you could use a single 'if' for all checks (up to you).

-- 
Catalin
