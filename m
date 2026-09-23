Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0141651E43E;
	Wed, 23 Sep 2026 12:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790167683; cv=none; b=pzeNnZSBlvowPDHXvxpWDOkyCBJ8vdDK9F9y5sL51vKmm5SgDuCRbmaImp7iJdsxGwbILxDQcdfyGxPHzRH/b5HJ/m9aSPg91zKv5GOR5Kyz9crlq0/2LQHoPV6BZ4kN8+X1Ce+rs6AiO6EEHQYhlJLK9bjHJ96S70QuNecbB9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790167683; c=relaxed/simple;
	bh=RIhC3hUarxRrR/f5mRDyLyshn3OVC6xd4Pet+9BmBkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dxBwz8oPjtqFmAVcTA2TbWsH1sHdgbLmCoYCgnNIZYyoOHD/GtwEC9T3e+h7PTZnh6qbRYDGFSezOW3stCmblXXvBctC5FD/GbMs+pUDaeC68UVd5tFpk07Bfbxqx5fSepzNuRksWL/RXD2a61FPsA0AcsFAd6e/B3V43KTY/4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=db+pBdYh; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="db+pBdYh"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACA861570;
	Wed, 23 Sep 2026 05:47:56 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86ECA3F86C;
	Wed, 23 Sep 2026 05:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790167680; bh=RIhC3hUarxRrR/f5mRDyLyshn3OVC6xd4Pet+9BmBkI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=db+pBdYhJE2fGHV6VKDio2pztmLqY1Eh+yFiBoVVLDJx2jEVzxpsuPFnx+/nlttpc
	 Cf7Ot496F1Lyd/LCV9ab67bSymlJjM1X4hMWqAB3TKvs0DOlRrG+fpxyRQ9Bkqz49+
	 7jFl+bqKwsuz59JreWAqLWWa4hJJWVTOV1uNJGBk=
Message-ID: <644aa208-55f0-440c-94b9-75e58e588dde@arm.com>
Date: Wed, 23 Sep 2026 13:47:43 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] dma: swiotlb: Centralize memory-encryption pool
 sizing
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
 <20260921063628.362078-5-aneesh.kumar@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260921063628.362078-5-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/09/2026 7:36 am, Aneesh Kumar K.V (Arm) wrote:
> Memory-encrypted guests use shared or unencrypted memory for DMA and may
> route all DMA through SWIOTLB. The default pool can therefore be too
> small for I/O-intensive workloads.
> 
> Move the existing x86 guest-sizing policy into the SWIOTLB core. For
> SWIOTLB_POOL_CC_GUEST, size the pool to 6% of guest memory, clamped
> between the normal default and 1 GiB. Preserve an explicit swiotlb=
> size.
> 
> Provide swiotlb_adjusted_size() so early users, including the x86 crash
> kernel reservation, can account for the prospective guest pool size
> before SWIOTLB initialization. Use the same area-aware alignment for
> both the prospective and allocated sizes.
> 
> Host memory encryption still selects a normal-sized shared pool and
> does not use the guest-sizing policy.
> 
> A restricted DMA pool already provides shared bounce buffers for its
> devices. Record its presence during reserved-memory initialization and
> do not select the confidential-guest default-pool policy solely because
> guest memory encryption is active.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>   arch/x86/include/asm/crash_reserve.h |  6 ++--
>   arch/x86/mm/mem_encrypt.c            | 24 --------------
>   include/linux/swiotlb.h              |  6 ++++
>   kernel/dma/swiotlb.c                 | 47 +++++++++++++++++++++++++++-
>   4 files changed, 56 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/x86/include/asm/crash_reserve.h b/arch/x86/include/asm/crash_reserve.h
> index 7835b2cdff04..c1f5bf5d4182 100644
> --- a/arch/x86/include/asm/crash_reserve.h
> +++ b/arch/x86/include/asm/crash_reserve.h
> @@ -18,7 +18,9 @@
>    * no good way to detect the paging mode of the target kernel which will be
>    * loaded for dumping.
>    */
> -extern unsigned long swiotlb_size_or_default(void);
> +#ifdef CONFIG_X86_64
> +unsigned long __init swiotlb_adjusted_size(void);
> +#endif
>   
>   #ifdef CONFIG_X86_32
>   # define CRASH_ADDR_LOW_MAX     SZ_512M
> @@ -33,7 +35,7 @@ extern unsigned long swiotlb_size_or_default(void);
>   static inline unsigned long crash_low_size_default(void)
>   {
>   #ifdef CONFIG_X86_64
> -	return max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
> +	return max(swiotlb_adjusted_size() + (8UL << 20), 256UL << 20);
>   #else
>   	return 0;
>   #endif
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 95bae74fdab2..912f22ca838f 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -101,9 +101,6 @@ void __init mem_encrypt_init(void)
>   
>   void __init mem_encrypt_setup_arch(void)
>   {
> -	phys_addr_t total_mem = memblock_phys_mem_size();
> -	unsigned long size;
> -
>   	/*
>   	 * Do RMP table fixups after the e820 tables have been setup by
>   	 * e820__memory_setup().
> @@ -114,27 +111,6 @@ void __init mem_encrypt_setup_arch(void)
>   	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
>   		return;
>   
> -	/*
> -	 * For SEV and TDX, all DMA has to occur via shared/unencrypted pages.
> -	 * Kernel uses SWIOTLB to make this happen without changing device
> -	 * drivers. However, depending on the workload being run, the
> -	 * default 64MB of SWIOTLB may not be enough and SWIOTLB may
> -	 * run out of buffers for DMA, resulting in I/O errors and/or
> -	 * performance degradation especially with high I/O workloads.
> -	 *
> -	 * Adjust the default size of SWIOTLB using a percentage of guest
> -	 * memory for SWIOTLB buffers. Also, as the SWIOTLB bounce buffer
> -	 * memory is allocated from low memory, ensure that the adjusted size
> -	 * is within the limits of low available memory.
> -	 *
> -	 * The percentage of guest memory used here for SWIOTLB buffers
> -	 * is more of an approximation of the static adjustment which
> -	 * 64MB for <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
> -	 */
> -	size = total_mem * 6 / 100;
> -	size = clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
> -	swiotlb_adjust_size(size);
> -
>   	/* Set restricted memory access for virtio. */
>   	virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
>   }
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index d69370c08094..be3962a33fc6 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -193,6 +193,7 @@ void swiotlb_dev_init(struct device *dev);
>   size_t swiotlb_max_mapping_size(struct device *dev);
>   bool is_swiotlb_allocated(void);
>   bool is_swiotlb_active(struct device *dev);
> +unsigned long __init swiotlb_adjusted_size(void);
>   void __init swiotlb_adjust_size(unsigned long size);
>   phys_addr_t default_swiotlb_base(void);
>   phys_addr_t default_swiotlb_limit(void);
> @@ -232,6 +233,11 @@ static inline bool is_swiotlb_active(struct device *dev)
>   	return false;
>   }
>   
> +static inline unsigned long __init swiotlb_adjusted_size(void)
> +{
> +	return 0;
> +}
> +
>   static inline void swiotlb_adjust_size(unsigned long size)
>   {
>   }
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index f368a73f4ed0..c19675846fc1 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -80,6 +80,7 @@ struct io_tlb_slot {
>   
>   static bool swiotlb_force_bounce;
>   static bool swiotlb_force_disable;
> +static bool restricted_dma_pool_present __initdata;
>   
>   enum swiotlb_pool_policy {
>   	SWIOTLB_POOL_NONE,
> @@ -480,6 +481,46 @@ static bool __init swiotlb_kmalloc_needs_bounce(void)
>   	       (dma_get_cache_alignment() > 1);
>   }
>   
> +/**
> + * swiotlb_adjusted_size() - get the prospective adjusted SWIOTLB size
> + *
> + * Return the size that confidential-computing guest sizing would select for
> + * the default pool, without changing the configured SWIOTLB size. An
> + * explicit swiotlb= size is always preserved. An explicit area count is
> + * included in the size calculation. Automatic area sizing is initialized
> + * later from the running kernel's possible CPU map and any resulting size
> + * adjustment is therefore not reflected in the returned size.
> + */
> +unsigned long __init swiotlb_adjusted_size(void)

This is yet another misleadingly ambiguous name.

> +{
> +	unsigned long nslabs, size = swiotlb_size_or_default();
> +
> +	if (swiotlb_default_size_changed() ||
> +	    !cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> +		return size;

And this makes for another needlessly convoluted calling convention.

> +	/*
> +	 * For SEV and TDX and CCA, all DMA has to occur via
> +	 * shared/unencrypted pages. Kernel uses SWIOTLB to make this
> +	 * happen without changing device drivers. However, depending on
> +	 * the workload being run, the default 64MB of SWIOTLB may not be
> +	 * enough and SWIOTLB may run out of buffers for DMA, resulting in
> +	 * I/O errors and/or performance degradation especially with high
> +	 * I/O workloads.
> +	 *
> +	 * Adjust the default size of SWIOTLB using a percentage of guest
> +	 * memory for SWIOTLB buffers.
> +	 *
> +	 * The percentage of guest memory used here for SWIOTLB buffers is
> +	 * more of an approximation of the static adjustment which 64MB for
> +	 * <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
> +	 */
> +	size = memblock_phys_mem_size() * 6 / 100;

But mostly I fail to see how this makes any sense for the x86 
crash_low_size_default() case anyway. This calculation is based on the 
*total* system memory, of which 6% is likely comparable to (or perhaps 
even more than) the *entire* amount of memory reserved for the crash 
kernel itself. What's more, if the low memory and size restrictions are 
lifted for regular CoCo SWIOTLB as people want, then it becomes even 
more utterly nonsensical to tie crashkernel_low to this.

Yes, this happens to be the behaviour that falls out of how two 
different parts of the existing code interact, but I highly doubt it was 
ever intentional, so I'm not convinced that complicating SWIOTLB 
interfaces to blindly preserve it is the right thing to do.

Thanks,
Robin.

> +	size = clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
> +	nslabs = swiotlb_aligned_nslabs(size);
> +
> +	return nslabs << IO_TLB_SHIFT;
> +}
> +
>   static void __init
>   swiotlb_adjust_pool_size(enum swiotlb_pool_policy policy)
>   {
> @@ -496,6 +537,7 @@ swiotlb_adjust_pool_size(enum swiotlb_pool_policy policy)
>   		break;
>   	}
>   	case SWIOTLB_POOL_CC_GUEST:
> +		swiotlb_adjust_size(swiotlb_adjusted_size());
>   		break;
>   	case SWIOTLB_POOL_NONE:
>   		WARN(true, "Cannot adjust SWIOTLB size without a pool\n");
> @@ -511,7 +553,8 @@ swiotlb_select_pool_policy(unsigned int flags)
>   	if (swiotlb_force_disable)
>   		return SWIOTLB_POOL_NONE;
>   
> -	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
> +	    !restricted_dma_pool_present)
>   		return SWIOTLB_POOL_CC_GUEST;
>   
>   	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
> @@ -2157,6 +2200,8 @@ static int __init rmem_swiotlb_setup(unsigned long node,
>   	    of_get_flat_dt_prop(node, "no-map", NULL))
>   		return -EINVAL;
>   
> +	restricted_dma_pool_present = true;
> +
>   	pr_info("Reserved memory: created restricted DMA pool at %pa, size %ld MiB\n",
>   		&rmem->base, (unsigned long)rmem->size / SZ_1M);
>   	return 0;

