Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE61F37E5E7;
	Thu, 17 Sep 2026 15:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789660058; cv=none; b=QViu1PRnno5/3ZB/kWhZws1Mi+601uArw7gj6yGvb/bvx5U5zRPUtLRb3gs3na3lm9rYBssBmk2zWcGkA/QUUA0wQvtAQ0/e30sj+JYyH8UNPlrQOkkizghDGeNyPPmg7nZZLjgHZUqjij37MucTCuBOlXQA5agrRt1Td6VHFvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789660058; c=relaxed/simple;
	bh=G4HWLVNXzhSCswJXl+GAJjZ5dE9EPV7jBwWTmIkK6T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIlmufDo0OGjL5i6RmB/M4wg9vFP5T50paaEsFln5QFl2UOemGootufScisAR55oaet1O3a6qen4isdMbslK1svdoX/hFVMxjS+kBG4N3yuG1H/ZfEc44YG8SND6//yOn1m50QitTwCphd5kx9yaQ7jKXSlhQfYLMz6JsNIgw0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jujJeTkR; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jujJeTkR"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA9981476;
	Thu, 17 Sep 2026 08:47:25 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91A183F7B4;
	Thu, 17 Sep 2026 08:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789660049; bh=G4HWLVNXzhSCswJXl+GAJjZ5dE9EPV7jBwWTmIkK6T0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jujJeTkRY9cy1NiL8rY70s3FzxqxUPmYtddnwYMekhhHo/JoTCrFo6hMKOk9rLuOm
	 twsIKR3Ht2HCoURivfSghdsivEyGC4q6zt9yB8X/Lo5a+tO7z6Y8Zh38KNsuDkXoA+
	 03JZSCS3IMQ44FpHgVwMp+OhHuQl0PQKLatASQKE=
Date: Thu, 17 Sep 2026 16:47:20 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
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
	Xu Yilun <yilun.xu@linux.intel.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v4 2/5] dma: swiotlb: Centralize minimal pool sizing
Message-ID: <aqwLiHQb71hU8cEy@arm.com>
References: <20260914070135.313337-1-aneesh.kumar@kernel.org>
 <20260914070135.313337-3-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914070135.313337-3-aneesh.kumar@kernel.org>

On Mon, Sep 14, 2026 at 12:31:31PM +0530, Aneesh Kumar K.V (Arm) wrote:
> NOTE: We lose the RISC-V SWIOTLB_ANY setting in this patch. It will be
> reinstated in a follow-up patch where we make SWIOTLB_ANY redundant.

[...]

> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index e0e4c103d603..734712230f35 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -165,31 +165,11 @@ static void print_vm_layout(void) { }
>  
>  void __init arch_mm_preinit(void)
>  {
> -	bool swiotlb = max_pfn > PFN_DOWN(dma32_phys_limit) &&
> -		       memblock_start_of_DRAM() < dma32_phys_limit;
>  	unsigned int swiotlb_flags = SWIOTLB_VERBOSE;
>  #ifdef CONFIG_FLATMEM
>  	BUG_ON(!mem_map);
>  #endif /* CONFIG_FLATMEM */
>  
> -	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) && !swiotlb &&
> -	    dma_cache_alignment != 1) {
> -		/*
> -		 * No 32-bit DMA bouncing needed (either all DRAM is within
> -		 * the 32-bit limit, or it all starts above it), but
> -		 * kmalloc() buffers whose sizes are not cache-line-aligned
> -		 * still require bouncing for non-coherent DMA.  Use
> -		 * SWIOTLB_ANY so that the buffer can be allocated from high
> -		 * memory when DRAM starts above dma32_phys_limit.  Allocate
> -		 * ~1 MB per 1 GB of RAM.
> -		 */
> -		unsigned long size =
> -			DIV_ROUND_UP(memblock_phys_mem_size(), 1024);
> -		swiotlb_adjust_size(min(swiotlb_size_or_default(), size));
> -		swiotlb = true;
> -		swiotlb_flags |= SWIOTLB_ANY;
> -	}

Does it break the bisectability for risc-v? IIUC this undoes commit
cfca5a48b03f until patch 5. Basically if there's no low memory and no
SWIOTLB_ANY passed, memblock_alloc_low() will fail.

I think we could preserve SWIOTLB_ANY until patch 5. Or it might be
simpler to move patches 2 and 3 at the end (I haven't tried).

> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index aa19e81ae544..90e0bfd0715c 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -304,6 +304,11 @@ unsigned long swiotlb_size_or_default(void)
>  	return default_nslabs << IO_TLB_SHIFT;
>  }
>  
> +static bool __init swiotlb_default_size_changed(void)
> +{
> +	return default_nslabs != IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT;
> +}

I mentioned before in passing
(https://lore.kernel.org/all/ann6noRzoPLL9kDY@arm.com/), if one sets
swiotlb= to the default size, it will go unnoticed. I know it's an
existing issue but we might as well fix it now with a bool that tells us
the swiotlb size was forced/changed.

-- 
Catalin
