Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97C6448B98
	for <linux-s390@vger.kernel.org>; Tue, 28 Jul 2026 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785248536; cv=none; b=lJnKgH4OLWkaLv5GQkdyqQReRNUcCP5tF0vvOfFfxsd6YvB374kRa98wqNhkANcvLupLEJ7QrNNLlWNF3VkfJuUlXmB8YskqwpVyLspDcfb/+A6Zn2GuuKJ3rZrB3BimC0UIpk3cJkQNmLkCwWiv0XcJvmmCeQAp+aQetcl3/TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785248536; c=relaxed/simple;
	bh=ivljL6kq2veliFFs/cqIsngvBYmK8alSQCuPHbgyblw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9BiHh6MvlkCbjgNP5LobunB/yKn/dKO9L9KusYkWNQjT6fy2BPvcFjYCRT4EqiLnuMfYepTi8D6Lshy2E9Alytl9XyoUNFnwB0+Txyjy8YrQaeCyuar5ymzkOdWuAa7H91kEW1KQGp6yp/7rvhfJhtVDCNQ0vewgd0Fh83EEHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GYLnjzZ5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GYLnjzZ5"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493be0fbcc5so61665e9.0
        for <linux-s390@vger.kernel.org>; Tue, 28 Jul 2026 07:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785248533; x=1785853333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cjI/qIF8COGmEwdyirpRIztZNWL1yf6sjcg+eLvBxKM=;
        b=GYLnjzZ571cff5OntvM/EzLqtL64mZbKeUI4e6IKcswsZL65utC8+CcaUNv6Lx5JUW
         fdJAMlTgla5nAucrjqsNomFmDSHijbFwt6RVo43A0E7SmJnwSVNsZNtWrri4IEaXJlFg
         cWXQgBwx2NClSFm/zlD5S4oSwG/BemujVrnms3kn9lmnEYQCLAPHnghVqFTSzdFJbCvB
         2G5BsA1U5yHdfR6ToaArQvJoUW1L82LR+p+eweD1yl1tRLjJyE0PC6kWQomRgZejoHKx
         KnLmHj3anjCHvurmuXWd/Me09ghIlr/m66CME4KtgpqQ0CrQmDmMfR6jtp0XM6hukxFa
         Tgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785248533; x=1785853333;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cjI/qIF8COGmEwdyirpRIztZNWL1yf6sjcg+eLvBxKM=;
        b=YTLoEKFJZ9nIN7L44U7kSqCMGHXzRTN0sEYjMkKQP033Q/UTZAJMBc5K+USlRsog6t
         KS+o8/1Exh1SFcNb90ag8wD3rkdALEHTk0BFvUVKb0FAaaETVKZRUsgjRqpP7pC3OWIl
         ZapHHhWHvQcFyMzFEfIGJvxKSdCZy8jTZpeofxMcWYhfHmCZyXU5DQpw4te4S+mzrrte
         nmkZnjz8lfbgnyi7tPISNe4RgTxv/upd+ybpsbszJr5EoHxnFZbw7ANa9IrspHIDx1+c
         o2FBaPLCOUgsfiUdTv7FeKRuLcezpxKCn9SjZmxOmFMsGFRqi8Hf6iAKnHcxr2zd5wLI
         k1qg==
X-Forwarded-Encrypted: i=1; AHgh+RpV3I6jKjDajyGhbNVPfp298En5AIATDXJ6fhfsN8NtlQarx0Ckzo2RhO84ZNIkVQP7UK5OMb85VHWa@vger.kernel.org
X-Gm-Message-State: AOJu0Yw53DZfklgw7akNKe6DFrgfBVZiLjmBLYpNJjeshWUx+DSnKUru
	XlEnUp5IuqM6ngzmJLBKFNv6hcs0R685PqBDBRpA8GLkk0BFCJKC8+aSZ4rvj0Jq8Q==
X-Gm-Gg: AR+sD10jbzhxbIpU4ZsRBdvR21B/DXPBlRrHTbmAsCKifvodOaH6Z80sYS2z6pg4QN9
	1EbGSKJULdadxoRl/mhc9cfZd0iHYUwLFQu7DH+V8RnWf1Q9MP9vCM2HFsZ3YkhRElamjRF3A28
	Rz8Ij/wW/W3vN6nztQ5Ia89UUBPFRfvaeXyL+rpiHmgkRBHsIruxjuA6pCPXmtDZFfubZcY6Cq8
	W05B3aWRbikaIhx0jPPpvKlE42j49wvmRXkAvSELEifvHhbwlhqmF5DyV404PEbA9iLqmLnxRr0
	zlyuc643DMWemjyTVP5+rJhHhKtVLEwfuUS8a+sfFBVzafGkZup5jEmwmGqjwfxKy/a1Enh81I/
	mbUyvrvS2oapsOmjPKXdZF/ms5E5PXNSoEGwaFSuiI7Nv72Wu26mjzlJaPDsWilgAwOPgbJYNqn
	Ftx+FgrH4rrmxSkNM1SZJ/3zdNBnCWlLvfK7gKPXGkOLPntBE3Lxii0g==
X-Received: by 2002:a05:600c:528c:b0:490:ab15:b9e8 with SMTP id 5b1f17b1804b1-496b944f535mr5088815e9.2.1785248532370;
        Tue, 28 Jul 2026 07:22:12 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a5a2sm64337943f8f.7.2026.07.28.07.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 07:22:11 -0700 (PDT)
Date: Tue, 28 Jul 2026 14:22:04 +0000
From: Mostafa Saleh <smostafa@google.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v8 00/23] dma-mapping: Track shared DMA state through
 direct, pool and swiotlb paths
Message-ID: <ami7DMIlYHbcEt_6@google.com>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717180442.110954-1-aneesh.kumar@kernel.org>

On Fri, Jul 17, 2026 at 11:34:18PM +0530, Aneesh Kumar K.V (Arm) wrote:
> This series tracks confidential-computing shared DMA state through the
> dma-direct, dma-pool, and swiotlb paths so that encrypted and decrypted
> DMA buffers are handled consistently.
> 
> Today, the direct DMA path mostly relies on force_dma_unencrypted() for
> shared/decrypted buffer handling. This series consolidates the
> force_dma_unencrypted() checks in the top-level functions and ensures
> that the remaining DMA interfaces use DMA attributes to make the correct
> decisions.
> 
> The series separates mapping and allocation state:
> - DMA_ATTR_CC_SHARED describes the DMA address attribute requested for a
>   mapping. It tells the DMA mapping path that the DMA address must target
>   shared/decrypted memory.
> - __DMA_ATTR_ALLOC_CC_SHARED is an internal DMA-mapping attribute used only
>   by allocation paths after the DMA core decides that the backing pages
>   must be allocated as shared/decrypted memory.
> 
> The series:
> - moves swiotlb-backed allocations out of __dma_direct_alloc_pages(),
> - uses __DMA_ATTR_ALLOC_CC_SHARED through the dma-direct alloc/free paths
> - teaches the atomic DMA pools to track encrypted versus decrypted
>   state
> - tracks swiotlb pool encryption state and enforces strict pool
>   selection
> - centralizes encrypted/decrypted pgprot handling in dma_pgprot() using
>   DMA attributes
> - passes DMA attributes down to dma_capable() so capability checks can
>   validate whether the selected DMA address encoding matches
>   DMA_ATTR_CC_SHARED
> - makes dma_direct_map_phys() choose the DMA address encoding from
>   DMA_ATTR_CC_SHARED and fall back to swiotlb when a shared DMA request
>   cannot use the direct mapping, which lets arm64 and x86 CCA guests stop
>   relying on SWIOTLB_FORCE for DMA mappings
> - use the selected swiotlb pool state to derive the returned DMA
>   address
> - reports CC_ATTR_GUEST_MEM_ENCRYPT for arm64 Realms, powerpc secure
>   guests, and s390 protected virtualization guests.
> 

This series has been getting bigger, going through it again, I see
that patches (1, 2, 3, 4, 5, 16, 20, 22) are not really related to the
shared DMA work and are either fixes for exisiting bugs or clean ups.
Would it make sense to have those separated?

Thanks,
Mostafa

> Dependency:
> This series depends on the pKVM changes posted at:
> https://lore.kernel.org/all/20260603110522.3331819-1-smostafa@google.com
> 
> Please merge this series only after the pKVM changes above are merged.
> Otherwise pKVM will be broken.
> 
> Changes since v7:
> https://lore.kernel.org/all/20260701054926.825925-1-aneesh.kumar@kernel.org
> * Rebased onto dma-mapping-for-next
> * Prepared the series on top of the prerequisite pKVM changes, resolving
>   conflicts so it can be applied directly to the pKVM topic branch once ready.
>   https://git.gitlab.arm.com/linux-arm/linux-cca/-/commits/scratch/pkvm/testing
> * Added comments documenting possible follow-up improvements for CC_SHARED
>   atomic pools and physical-address-based pool freeing.
> * Retained virtual-address-based pool freeing when
>   CONFIG_DMA_DIRECT_REMAP is disabled.
> * Applied pgprot_decrypted() only when expanding a CC_SHARED atomic pool.
> 
> Changes since v6:
> https://lore.kernel.org/all/20260604083959.1265923-1-aneesh.kumar@kernel.org
> * Rebase onto the latest kernel.
> * Add __DMA_ATTR_ALLOC_CC_SHARED for allocation paths. DMA_ATTR_CC_SHARED
>   is now used to describe the requested DMA mapping address attribute,
>   while __DMA_ATTR_ALLOC_CC_SHARED is used internally when allocating
>   shared/decrypted backing pages.
> * Report CC_ATTR_GUEST_MEM_ENCRYPT for arm64 Realms, powerpc secure
>   guests, and s390 protected virtualization guests.
> * Add CC_ATTR_HOST_MEM_ENCRYPT and swiotlb=force fixes.
> 
> Changes since v5:
> https://lore.kernel.org/all/20260522042815.370873-1-aneesh.kumar@kernel.org
> * Add Tested-by
> * Drop the pKVM patch, which has now been posted separately:
>   https://lore.kernel.org/all/20260603110522.3331819-1-smostafa@google.com
> * Remove the DO_NOT_MERGE tag from the s390 change.
> * Add a patch to drop the SWIOTLB_FORCE flag.
> * Rebase onto the latest kernel.
> 
> Changes since v4:
> https://lore.kernel.org/all/20260512090408.794195-1-aneesh.kumar@kernel.org
> * Add new patches based on Sashiko review:
>   swiotlb: Preserve allocation virtual address for dynamic pools
>   dma: free atomic pool pages by physical address
>   dma: swiotlb: handle set_memory_decrypted() failures
>   dma: swiotlb: free dynamic pools from process context
>   iommu/dma: Check atomic pool allocation result directly
> * Include pKVM and s390 changes as dependent patches. These are not yet
>   ready to merge and are waiting for subsystem testing feedback.
> * Drop the AMD GART patch because it requires wider testing.
> * Update swiotlb_tbl_map_single() to take attrs by reference.
> * Switch swiotlb_free() to use rcu_work.
> * Avoid calling swiotlb_find_pool() multiple times in the free path.
> * Make DMA_ATTR_MMIO imply DMA_ATTR_CC_SHARED for devices requiring unencrypted DMA.
> 
> Changes from v3:
> https://lore.kernel.org/all/20260427055509.898190-1-aneesh.kumar@kernel.org
> * Handle DMA_ATTR_MMIO correctly in dma_direct_map_phys()
> * Address most of sashiko review
> * Rebase to latest kernel
> * drop SWIOTLB_FORCE for s390 and powerpc secure guest.
> 
> Changes from v2:
> https://lore.kernel.org/all/20260420061415.3650870-1-aneesh.kumar@kernel.org
> * pass attrs to dma_capable() and update direct, swiotlb, Xen swiotlb, and
>   x86 GART paths so the capability checks see the DMA address attr value
>   DMA_ATTR_CC_SHARED.
> * rework dma_direct_map_phys() so DMA_ATTR_CC_SHARED selects
>   phys_to_dma_unencrypted() while the default path uses
>   phys_to_dma_encrypted(), with swiotlb fallback when the requested
>   shared/private state cannot be satisfied by a direct DMA address.
> * stop relying on SWIOTLB_FORCE for arm64 and x86 CC guest DMA mappings;
>   swiotlb is still enabled there, but shared mappings is now selected
>   through the generic dma_direct_map_phys()/dma_capable() decision instead
>   of a global force-bounce flag.
> 
> Changes from v1:
> https://lore.kernel.org/all/20260417085900.3062416-1-aneesh.kumar@kernel.org
> * rebased to latest kernel (change from DMA_ATTR_CC_DECRYPTED -> DMA_ATTR_CC_SHARED)
> * update the alloc path so DMA_ATTR_CC_SHARED is not a caller-visible attribute.
> 
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Mostafa Saleh <smostafa@google.com>
> Cc: Petr Tesarik <ptesarik@suse.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Xu Yilun <yilun.xu@linux.intel.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-s390@vger.kernel.org
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: x86@kernel.org
> 
> Aneesh Kumar K.V (Arm) (23):
>   dma-direct: return struct page from dma_direct_alloc_from_pool()
>   dma-pool: fix page leak in atomic_pool_expand() cleanup
>   iommu/dma: Check atomic pool allocation result directly
>   dma: free atomic pool pages by physical address
>   swiotlb: Preserve allocation virtual address for dynamic pools
>   s390: Expose protected virtualization through cc_platform_has()
>   dma-direct: swiotlb: handle swiotlb alloc/free outside
>     __dma_direct_alloc_pages
>   coco: arm64: s390: powerpc: Mark secure guests with
>     CC_ATTR_GUEST_MEM_ENCRYPT
>   dma-mapping: Add internal shared allocation attribute
>   dma-direct: use __DMA_ATTR_ALLOC_CC_SHARED in alloc/free paths
>   dma-pool: track decrypted atomic pools and select them via attrs
>   dma: swiotlb: pass mapping attributes by reference
>   dma: swiotlb: track pool encryption state and honor DMA_ATTR_CC_SHARED
>   dma-mapping: make dma_pgprot() honor __DMA_ATTR_ALLOC_CC_SHARED
>   dma-direct: pass attrs to dma_capable() for DMA_ATTR_CC_SHARED checks
>   dma-direct: Move dma_direct_map_phys() to dma/direct.c
>   dma-direct: make dma_direct_map_phys() honor DMA_ATTR_CC_SHARED
>   dma-direct: set decrypted flag for remapped DMA allocations
>   dma-direct: select DMA address encoding from
>     __DMA_ATTR_ALLOC_CC_SHARED
>   dma-direct: rename ret to cpu_addr in alloc helpers
>   dma: swiotlb: free dynamic pools from process context
>   dma: swiotlb: handle set_memory_decrypted() failures
>   swiotlb: remove unused SWIOTLB_FORCE flag
> 
>  Documentation/core-api/dma-attributes.rst    |  29 ++
>  arch/arm64/mm/init.c                         |   5 +-
>  arch/powerpc/platforms/pseries/cc_platform.c |   1 +
>  arch/powerpc/platforms/pseries/svm.c         |   2 +-
>  arch/s390/Kconfig                            |   1 +
>  arch/s390/mm/init.c                          |  17 +-
>  arch/x86/kernel/amd_gart_64.c                |  30 +-
>  arch/x86/kernel/pci-dma.c                    |   4 +-
>  drivers/iommu/dma-iommu.c                    |  20 +-
>  drivers/xen/swiotlb-xen.c                    |   8 +-
>  include/linux/dma-direct.h                   |  20 +-
>  include/linux/dma-map-ops.h                  |   3 +-
>  include/linux/dma-mapping.h                  |   8 +
>  include/linux/swiotlb.h                      |  25 +-
>  include/trace/events/dma.h                   |   3 +-
>  kernel/dma/direct.c                          | 326 ++++++++++++++-----
>  kernel/dma/direct.h                          |  56 +---
>  kernel/dma/mapping.c                         |  25 +-
>  kernel/dma/pool.c                            | 237 ++++++++++----
>  kernel/dma/swiotlb.c                         | 292 +++++++++++++----
>  20 files changed, 810 insertions(+), 302 deletions(-)
> 
> -- 
> 2.43.0
> 
