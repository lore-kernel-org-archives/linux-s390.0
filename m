Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF813C0A04;
	Fri, 14 Aug 2026 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786724134; cv=none; b=qwH5EmpyhnmY5HkzsVlXA1GueUb6fqPmGhp3YEbtzADFevXkgZIeN/Hu/DYW3tE7Im5YnFxkbKbK72vSYHI4Qj16TZBh2ZGkgvOoTXM6T5ceXa6sSelCbTby/mh01u1nRKECPqQLuONMmTNPtr/JPNc1Tx8fZMkaysLkyMf9SLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786724134; c=relaxed/simple;
	bh=CDXQA+EPdlI0BbPlq/PGU1VNQn7L/CNo5Id1Sf3ism8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFlnan+IOxRxa5M48PHt8dGorMAJWuk4RrIH8AsH/z3mwY5mmwqxH97whnCSyFaRIje//J5WpJk/WsFwDZq27eps3uCCZixdgdRK3b97SGMB8HnxhseQhsKXsTlp1h/9ab0L+Wq+nAOUYLBPWh9KXWR59oEjmdZJ6C1IVJJEAEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cbfJLndh; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cbfJLndh"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 435B01596;
	Fri, 14 Aug 2026 09:15:21 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0879C3F632;
	Fri, 14 Aug 2026 09:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786724125; bh=CDXQA+EPdlI0BbPlq/PGU1VNQn7L/CNo5Id1Sf3ism8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cbfJLndhxTyrWoqa7N0FvMI7C5ellZPkmqibKvH/xugi4DkwGUR8MXxECibikKhHA
	 r2peZGXac4kfP7Iq+wBnj49hJv4z1WzdVYAlmECjmYuTAyTPTllk67UYCjRBKitdio
	 +Xjl6D4uqfp94Fg6zciUVaBL+LX0gfOk2Ey1b8pE=
Date: Fri, 14 Aug 2026 17:15:18 +0100
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
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [RFC PATCH v2 1/2] dma: swiotlb: Centralize default pool
 initialization and sizing
Message-ID: <an8_FvcdI01XmVXs@arm.com>
References: <20260813102521.1367737-1-aneesh.kumar@kernel.org>
 <20260813102521.1367737-2-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813102521.1367737-2-aneesh.kumar@kernel.org>

On Thu, Aug 13, 2026 at 03:55:20PM +0530, Aneesh Kumar K.V (Arm) wrote:
> The addressing_limited argument to swiotlb_init() no longer describes
> all the reasons why a default swiotlb pool may be needed. Confidential
> computing systems need a shared pool even without addressing limitations,
> while some systems need a smaller pool for bouncing unaligned kmalloc
> buffers.
> 
> Replace the argument with SWIOTLB_INIT_ADDRESSING_LIMIT and
> SWIOTLB_INIT_CC_SHARED reason flags, and add swiotlb_should_init() to
> determine whether initialization is required for limited DMA addressing,
> confidential-computing shared DMA, unaligned kmalloc bouncing, or
> swiotlb=force.
> 
> Have architectures report addressing-limit and confidential-computing
> requirements before swiotlb_init(). Mark CC pools shared before their
> memory attributes are updated, and keep both addressing-limited and
> CC-shared pools at their normal size instead of applying the reduced
> kmalloc-only sizing policy.
> 
> Move the reduced kmalloc-bounce sizing policy from arm64 and RISC-V into
> the SWIOTLB core. This keeps architecture code responsible for reporting
> why a pool is needed while centralizing initialization and sizing
> decisions.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  arch/arm/mm/init.c                   |  6 +++-
>  arch/arm64/mm/init.c                 | 18 ++++------
>  arch/loongarch/kernel/setup.c        |  2 +-
>  arch/mips/cavium-octeon/dma-octeon.c |  2 +-
>  arch/mips/loongson64/dma.c           |  2 +-
>  arch/mips/sibyte/common/dma.c        |  2 +-
>  arch/powerpc/kernel/dma-swiotlb.c    |  4 ++-
>  arch/powerpc/mm/mem.c                | 15 +++++++-
>  arch/powerpc/platforms/pseries/svm.c | 10 ------
>  arch/powerpc/sysdev/fsl_pci.c        |  1 +
>  arch/riscv/mm/init.c                 | 18 +++-------
>  arch/s390/mm/init.c                  |  2 +-
>  arch/x86/include/asm/iommu.h         |  2 ++
>  arch/x86/kernel/amd_gart_64.c        |  1 +
>  arch/x86/kernel/pci-dma.c            | 17 +++++----
>  arch/x86/mm/mem_encrypt.c            |  4 +++
>  include/linux/swiotlb.h              | 12 ++++---
>  kernel/dma/swiotlb.c                 | 52 ++++++++++++++++++++++++----
>  18 files changed, 109 insertions(+), 61 deletions(-)
> 
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 0cc1bf04686d..aca97a4e5dcd 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -223,7 +223,11 @@ static inline void poison_init_mem(void *s, size_t count)
>  void __init arch_mm_preinit(void)
>  {
>  #ifdef CONFIG_ARM_LPAE
> -	swiotlb_init(max_pfn > arm_dma_pfn_limit, SWIOTLB_VERBOSE);
> +	unsigned int flags = SWIOTLB_VERBOSE;
> +
> +	if (max_pfn > arm_dma_pfn_limit)
> +		flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
> +	swiotlb_init(flags);
>  #endif
>  
>  #ifdef CONFIG_SA1111
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index e308a7cabd12..9f5b366d2086 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -338,19 +338,15 @@ void __init arch_setup_zero_pages(void)
>  void __init arch_mm_preinit(void)
>  {
>  	unsigned int flags = SWIOTLB_VERBOSE;
> +	/* pKVM uses restricted-dma-pool */
> +	bool cc_guest = is_realm_world();
>  
> -	if (max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
> -		/*
> -		 * If no bouncing needed for ZONE_DMA, reduce the swiotlb
> -		 * buffer for kmalloc() bouncing to 1MB per 1GB of RAM.
> -		 */
> -		unsigned long size =
> -			DIV_ROUND_UP(memblock_phys_mem_size(), 1024);
> -
> -		swiotlb_adjust_size(min(swiotlb_size_or_default(), size));
> -	}
> +	if (cc_guest)
> +		flags |= SWIOTLB_INIT_CC_SHARED;
> +	else if (max_pfn > PFN_DOWN(arm64_dma_phys_limit))
> +		flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
>  
> -	swiotlb_init(true, flags);
> +	swiotlb_init(flags);

I like the idea of more flags than the boolean for address limit.
However, depending on when such patch would go in (presumably on top of
what's currently in -next), we may not need the SWIOTLB_INIT_CC_SHARED
at all here just to remove it in the second patch. I think we have all
the information available already.

Other than that, it looks fine to me. If you repost at -rc1, hopefully
Sashiko will manage to apply it.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
