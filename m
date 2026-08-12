Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A4A3EB81D;
	Wed, 12 Aug 2026 10:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786528898; cv=none; b=ZVm/j8g7c0w11IJG8Q7PHaywYAM0juPMrHRwgxQkzmnFuNUr6uK2aMN+6n8iLqD6Cr9QHPzAoJ+tP74r/YGmQ40eswj3g+OUG+Qq3MkkjfQyxNZf3ocTR8V8mt4oI4G7cOlQ4ekD/HhILyps+nKlNg1VIhvWWuv24Kft8Rhldpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786528898; c=relaxed/simple;
	bh=laAQxkCDgu5rybBDPLSZxhaA8e2vicoqRxfv8eyBppg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RgzGA0468304u2JfeJpCffuOzl01cy9tSsA/1j8feT4EGu25isee5mpcamyP8lGZzYeBIN8FAx/dm+AG/6LhH3Juys8csV6ycb5Ns+eVv7iD4LTnrtyIMsD8anuya2CrZXLnjnTztyPNGV7Xpn3mHjUgqBAWOBlweq9Lukwc88E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=H9+Q3rwe; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="H9+Q3rwe"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2BC51596;
	Wed, 12 Aug 2026 03:01:30 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58C893F632;
	Wed, 12 Aug 2026 03:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786528894; bh=laAQxkCDgu5rybBDPLSZxhaA8e2vicoqRxfv8eyBppg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H9+Q3rweucDYcVESosYOqah1VsOK5/gZBmUDqRzZn63O1t3HEhDbFomEHapCTWR2C
	 4HjayAQgmAUs2cjgjubPrIW3CeX2n+B9zHWT7RcBq9sIXEnzQmXnFEsazv1HuywPNi
	 wqnvNT0Uoa+RgTsn5+EP2jUJQjbBJpJapx1rZX8o=
Date: Wed, 12 Aug 2026 11:01:23 +0100
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
	Christophe Leroy <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [RFC PATCH] dma: swiotlb: Size shared default pools for memory
 encryption
Message-ID: <anxEc8EHmJQywVI5@arm.com>
References: <20260811134056.756015-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811134056.756015-1-aneesh.kumar@kernel.org>

On Tue, Aug 11, 2026 at 07:10:56PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Systems with memory encryption use swiotlb to provide shared or
> unencrypted buffers for device DMA. Confidential guests may route all
> DMA through these buffers, while SME hosts use them for devices that
> cannot address encrypted memory. The default swiotlb pool can therefore
> be exhausted under I/O-intensive workloads.
> 
> Let architectures mark the default swiotlb pool as shared before
> swiotlb_init().

I thought we wanted even this decision to be moved out of the arch code.

> Move the existing x86 sizing policy into generic swiotlb
> code and add early pool marking for arm64 Realm guests, powerpc secure
> guests, s390 protected-virtualization guests, and x86 memory-encryption
> platforms. Use CC_ATTR_MEM_ENCRYPT on x86 to include host SME, whose
> swiotlb pool must also be decrypted for devices that cannot address
> encrypted memory.

That's a functional change for x86. For now, I'd keep it to
CC_ATTR_GUEST_MEM_ENCRYPT.

BTW, why does arm64 report CC_ATTR_MEM_ENCRYPT instead of the GUEST
option in realms?

> Move the powerpc secure-guest swiotlb enablement before initialization
> so that the shared pool is allocated with the required flags. pKVM
> guests continue to use a restricted DMA pool instead of the default
> swiotlb pool.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  arch/arm64/mm/init.c                 |  6 ++-
>  arch/powerpc/mm/mem.c                |  7 +++
>  arch/powerpc/platforms/pseries/svm.c | 10 ----
>  arch/s390/mm/init.c                  |  2 +
>  arch/x86/mm/mem_encrypt.c            | 27 ++--------
>  include/linux/swiotlb.h              |  7 ++-
>  kernel/dma/swiotlb.c                 | 73 ++++++++++++++++++++++------
>  7 files changed, 82 insertions(+), 50 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index e308a7cabd12..4c022e8aed43 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -338,8 +338,12 @@ void __init arch_setup_zero_pages(void)
>  void __init arch_mm_preinit(void)
>  {
>  	unsigned int flags = SWIOTLB_VERBOSE;
> +	/* pKVM uses restricted-dma-pool */
> +	bool cc_guest = is_realm_world();
>  
> -	if (max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
> +	if (cc_guest) {
> +		swiotlb_mark_default_cc_shared();
> +	} else if (max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
>  		/*
>  		 * If no bouncing needed for ZONE_DMA, reduce the swiotlb
>  		 * buffer for kmalloc() bouncing to 1MB per 1GB of RAM.

With your other reworking, doesn't the core code know the swiotlb will
be shared? Can it not make the decision to resize at that point based
solely on CC_ATTR_GUEST_MEM_ENCRYPT?

I also wonder whether we could address Will's pKVM request not to
allocate a bounce buffer once pKVM guests will start reporting
CC_ATTR_GUEST_MEM_ENCRYPT. Some simple heuristic: if a
restricted-dma-pool is advertised in DT (it will end up in
rmem_swiotlb_setup()), skip resizing the default swiotlb. It's not
perfect but the bounce buffer can be overridden on the command line.

-- 
Catalin
