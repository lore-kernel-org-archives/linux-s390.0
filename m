Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DAB3469FC;
	Wed, 19 Aug 2026 13:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144745; cv=none; b=kdjNxo7L0aOFn/g4hpufTl8yluDpRK49GnWE2mjLxsHLsR4bbDCYEEEz8TZ67dVAF2Sya8tkJJh/B3taBE3sZJl4c2rwZXgGOFJFKx26VqkRayAyqh637E9aV0zJYW9qGXvViVJ8nUsJlUFb3X2mNe8I2xcczbA9HV0H0qR27Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144745; c=relaxed/simple;
	bh=8tZeoA1qM6yseHc5wH6x5IAXCz7o0dIu8IBtXCtDR5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etAHTbBH5EO7kNlx2W/4a5ewRuKwsx76OJm0olw98iJG/pDWa4NKib9YOV6o50gCYUfmAuGfbU+dSvLc+pxTXLF8zJfnqIo3y3EdcpTP3ZemQmm8JePAgO6JOdKGXQs4mCe4Q9BOFReWy5cPlRyUZBFDaN4nm6+XQaILJvfmO1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=t3yWksBP; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="t3yWksBP"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAF8214BF;
	Wed, 19 Aug 2026 06:05:31 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4142F3F763;
	Wed, 19 Aug 2026 06:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787144735; bh=8tZeoA1qM6yseHc5wH6x5IAXCz7o0dIu8IBtXCtDR5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t3yWksBPwJHtK3Fh45zd2qMesmCsZj0EcT0Z3hkyOVtVEG9Mxa6bfiidSqLWTXzo4
	 whdeeirC8wqKVHU+1MTFT5sLwfrgQ2XXTsu9lig87KYPcNaBdKnnKT+HDpBjIv1tHd
	 6Sq3qDJKVnxymVmnOpi18PnEp+N8VXvbXJBYRKRY=
Date: Wed, 19 Aug 2026 14:05:29 +0100
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
Subject: Re: [RFC PATCH v2 2/2] dma: swiotlb: Initialize and size shared
 default pools for memory encryption
Message-ID: <aoWqGW5PhY9K_xTs@arm.com>
References: <20260813102521.1367737-1-aneesh.kumar@kernel.org>
 <20260813102521.1367737-3-aneesh.kumar@kernel.org>
 <an9RrwoaAsqJQ2vN@arm.com>
 <yq5aecfuiapg.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5aecfuiapg.fsf@kernel.org>

On Wed, Aug 19, 2026 at 05:28:03PM +0530, Aneesh Kumar K.V wrote:
> Catalin Marinas <catalin.marinas@arm.com> writes:
> > On Thu, Aug 13, 2026 at 03:55:21PM +0530, Aneesh Kumar K.V (Arm) wrote:
> >> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> >> index 9f5b366d2086..c3188ca878f3 100644
> >> --- a/arch/arm64/mm/init.c
> >> +++ b/arch/arm64/mm/init.c
> >> @@ -338,12 +338,8 @@ void __init arch_setup_zero_pages(void)
> >>  void __init arch_mm_preinit(void)
> >>  {
> >>  	unsigned int flags = SWIOTLB_VERBOSE;
> >> -	/* pKVM uses restricted-dma-pool */
> >> -	bool cc_guest = is_realm_world();
> >>  
> >> -	if (cc_guest)
> >> -		flags |= SWIOTLB_INIT_CC_SHARED;
> >> -	else if (max_pfn > PFN_DOWN(arm64_dma_phys_limit))
> >> +	if (max_pfn > PFN_DOWN(arm64_dma_phys_limit))
> >>  		flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
> >>  
> >>  	swiotlb_init(flags);
> >
> > This looks fine. As I mentioned on patch 1, we might as well move this
> > hunk over there and avoid the flag definition.
> >
> >> @@ -102,9 +101,6 @@ void __init mem_encrypt_init(void)
> >>  
> >>  void __init mem_encrypt_setup_arch(void)
> >>  {
> >> -	phys_addr_t total_mem = memblock_phys_mem_size();
> >> -	unsigned long size;
> >> -
> >>  	/*
> >>  	 * Do RMP table fixups after the e820 tables have been setup by
> >>  	 * e820__memory_setup().
> >> @@ -112,33 +108,9 @@ void __init mem_encrypt_setup_arch(void)
> >>  	if (cc_platform_has(CC_ATTR_HOST_SEV_SNP))
> >>  		snp_fixup_e820_tables();
> >>  
> >> -	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> >> -		x86_swiotlb_flags |= SWIOTLB_INIT_CC_SHARED;
> >> -
> >>  	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> >>  		return;
> >>  
> >> -	/*
> >> -	 * For SEV and TDX, all DMA has to occur via shared/unencrypted pages.
> >> -	 * Kernel uses SWIOTLB to make this happen without changing device
> >> -	 * drivers. However, depending on the workload being run, the
> >> -	 * default 64MB of SWIOTLB may not be enough and SWIOTLB may
> >> -	 * run out of buffers for DMA, resulting in I/O errors and/or
> >> -	 * performance degradation especially with high I/O workloads.
> >> -	 *
> >> -	 * Adjust the default size of SWIOTLB using a percentage of guest
> >> -	 * memory for SWIOTLB buffers. Also, as the SWIOTLB bounce buffer
> >> -	 * memory is allocated from low memory, ensure that the adjusted size
> >> -	 * is within the limits of low available memory.
> >> -	 *
> >> -	 * The percentage of guest memory used here for SWIOTLB buffers
> >> -	 * is more of an approximation of the static adjustment which
> >> -	 * 64MB for <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
> >> -	 */
> >> -	size = total_mem * 6 / 100;
> >> -	size = clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
> >> -	swiotlb_adjust_size(size);
> >> -
> >>  	/* Set restricted memory access for virtio. */
> >>  	virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
> >>  }
> >
> > Credit to claude, it noticed a slight change in behaviour for x86 w.r.t.
> > the crash kernel reservation. crash_low_size_default() reads the swiotlb
> > size but the resizing now happens after arch_reserve_crashkernel().
> > Maybe not an issue.
> >
> > Alternatively, we could build the sizing logic into
> > swiotlb_size_or_default() but I haven't checked whether we have the
> > right information when this function is called.
> 
> IIUC, the current code can still get a different value from
> crash_low_size_default() than the final swiotlb size we end up using.
> This is because crash_low_size_default() is computed early, before
> default_nareas, which is derived from num_possible_cpus(), has been set.
> 
> If we are okay with keeping this consistent with the existing behavior,
> moving sizing logic to swiotlb_adjusted_size() looks like a clean option.

See how it looks, it may turn out cleaner.

> > I think at a high level, we need (i.e. separate attributed from sizing):
> >
> > 	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> > 		io_tlb_default_mem.cc_shared = true;
> >
> > 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
> > 		if (!restricted_dma_pool_present)
> > 			swiotlb_adjust_cc_size();	/* 6%, clamped */
> > 	} else if (!(flags & SWIOTLB_INIT_ADDRESSING_LIMIT) &&
> > 		   swiotlb_kmalloc_needs_bounce()) {
> > 		swiotlb_shrink_for_kmalloc();		/* 1MB per 1GB */
> > 	}
> >
> 
> But pKVM wants to reduce the swiotlb size based on
> kmalloc_needs_bounce() when it is using a restricted-dma-pool.
> 
> ie,
> 	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> 		io_tlb_default_mem.cc_shared = true;
> ..
> 
> 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
> 	    !restricted_dma_pool_present) {
> 		swiotlb_adjust_cc_attributes();
> 	} else if (!(flags & SWIOTLB_INIT_ADDRESSING_LIMIT) &&
> 		   swiotlb_kmalloc_needs_bounce()) {

Ah, right, I got my conditions wrong. Basically a restricted pool
prevents an swiotlb growth in a protected guest. If no addressing limit
but kmalloc bouncing, we allocate a small one. Otherwise we should not
have any swiotlb at all.

I need to write it in a table, too many combinations

CC guest:
  no restricted pool			=> 6% of RAM
  restricted pool (pKVM heuristics):
    addressing limit			=> default size
    no addressing limit:
      kmalloc needs bounce		=> minimal
      no kmalloc bouncing		=> no default swiotlb

Host CC_ATTR_MEM_ENCRYPT		=> default size

No CC:
  addressing limit			=> default size
  no addressing limit:
    kmalloc needs bounce		=> minimal
    no kmalloc bouncing			=> no default swiotlb

-- 
Catalin
