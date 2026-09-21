Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2014BA1F4;
	Mon, 21 Sep 2026 15:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790004337; cv=none; b=d8ncaHumIJ20PXDceeJnPLdPmyRzgdwvi1KII4H+FTtMVUkBTVg/svaJNMeA0P96IjoL4z8IkFTvLTQCTjUhs/I/tJagYtpesKen3njnxMRXXMxWDbcunnU1UrzV8xoSLQBF2eL4P+hgOxwhadffdfHJri/htCCpY4Jhucrr63s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790004337; c=relaxed/simple;
	bh=zzx3mjbudK64AmYFt4zDvBW4IWB8i50rKocOK6Kc+dM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pOEi//IoGRKYGl/91JKSCxxwW4HDytz6p+K1GFAv+tyWCs1ucKjuER7DQbP73+6NCPMIIG1v/Sz//sEhwhrQphHIyN3YquM8WvkwvCLendl520yKKqbvvip4nedGOh9PxLL5gQpEq0l29JLQESdmMOIW2e0D36FnVEMkLz7f3zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bJ6BTSYH; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bJ6BTSYH"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 467AE176C;
	Mon, 21 Sep 2026 08:25:31 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4049D3F9A2;
	Mon, 21 Sep 2026 08:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790004334; bh=zzx3mjbudK64AmYFt4zDvBW4IWB8i50rKocOK6Kc+dM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bJ6BTSYHKivo2/eRF9c4tWP/TAAVxpqB5Gki+6hqB70gMH9c6T0DN/7LvVp33NcYt
	 fV1Z2JO0j2YRGDrhpnqtAy2GN69cKLeg4YLIjHpGCN+UjR/tG+22iBWPqhPA/ijEBI
	 8cO8DvQWcF+Nt3XHK3carG/MXQkDFh2hAqfz/P4w=
Message-ID: <4ef23d65-02d2-4187-904b-9d1665d8cff5@arm.com>
Date: Mon, 21 Sep 2026 16:25:25 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] dma: swiotlb: Centralize default pool policy
 selection
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon
 <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Steven Price <steven.price@arm.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>,
 Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
 Petr Tesarik <ptesarik@suse.com>, Alexey Kardashevskiy <aik@amd.com>,
 Dan Williams <dan.j.williams@intel.com>, Xu Yilun
 <yilun.xu@linux.intel.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Russell King <linux@armlinux.org.uk>,
 Huacai Chen <chenhuacai@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, x86@kernel.org
References: <20260921063628.362078-1-aneesh.kumar@kernel.org>
 <20260921063628.362078-2-aneesh.kumar@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260921063628.362078-2-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/09/2026 7:36 am, Aneesh Kumar K.V (Arm) wrote:
[...]
> diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
> index ba256c37bcc0..97fffa46f05a 100644
> --- a/arch/powerpc/kernel/dma-swiotlb.c
> +++ b/arch/powerpc/kernel/dma-swiotlb.c
> @@ -14,8 +14,10 @@ unsigned int ppc_swiotlb_flags;
>   
>   void __init swiotlb_detect_4g(void)
>   {
> -	if ((memblock_end_of_DRAM() - 1) > 0xffffffff)
> +	if ((memblock_end_of_DRAM() - 1) > 0xffffffff) {
>   		ppc_swiotlb_enable = 1;

Nit: Perhaps it's beyond the functional scope of this patch, but I do 
wonder if these <arch>_swiotlb_enable conditions become redundant and 
could just be replaced with "if (<arch>_swiotlb_flags != 0)" too.

> +		ppc_swiotlb_flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
> +	}
>   }
>   
>   static int __init check_swiotlb_enabled(void)
[...]
> diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
> index 75cf8f6ae8cd..0cff255827ba 100644
> --- a/arch/x86/kernel/pci-dma.c
> +++ b/arch/x86/kernel/pci-dma.c
> @@ -44,8 +44,10 @@ static unsigned int x86_swiotlb_flags;
>   static void __init pci_swiotlb_detect(void)
>   {
>   	/* don't initialize swiotlb if iommu=off (no_iommu=1) */
> -	if (!no_iommu && max_possible_pfn > MAX_DMA32_PFN)
> +	if (!no_iommu && max_possible_pfn > MAX_DMA32_PFN) {
>   		x86_swiotlb_enable = true;
> +		x86_swiotlb_flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
> +	}
>   
>   	/*
>   	 * Set swiotlb to 1 so that bounce buffers are allocated and used for
> @@ -81,8 +83,10 @@ static void __init pci_xen_swiotlb_init(void)
>   	if (!xen_swiotlb_enabled())
>   		return;
>   	x86_swiotlb_enable = true;
> -	x86_swiotlb_flags |= SWIOTLB_ANY;
> -	swiotlb_init_remap(true, x86_swiotlb_flags, xen_swiotlb_fixup);
> +	/* Xen can use a SWIOTLB pool anywhere in directly mapped memory. */
> +	x86_swiotlb_flags &= ~SWIOTLB_INIT_ADDRESSING_LIMIT;
> +	x86_swiotlb_flags |= SWIOTLB_INIT_REMAP | SWIOTLB_ANY;

Similarly, I see how having a SWIOTLB_INIT_REMAP flag keeps 
swiotlb_select_pool_policy() neat, but couldn't we technically already 
infer that from the fact that a non-NULL remap function was passed?

Nits aside, the overall change seems reasonable to me;

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
