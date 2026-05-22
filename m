Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189605FDA7;
	Fri, 22 May 2026 04:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779424120; cv=none; b=c5IIjlUdNOWgMkXE5qem89+kPtpCHq6QUVSVlvhJ2mGwJrEUBGAWlRk7ecq9fxK9xs+KrMHaKbskxd4Zkokyx6umzF6jSGEv9/gSwAPX6D6y++oUBBFZbl0Uga88hRUvh7opNhvJ4b8jKrjm9IXTseV8hsdxHP2AhRhCvQqkYiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779424120; c=relaxed/simple;
	bh=Tc5jARP32JrlSX4LbMI8H5VpF/0nJ5U2YU2MmE4VLLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VVxdr9wtB1DEtYnWwqhW/YIalFJOvAVtObe5M3y4oefbs3/oUWKcPY3ilCEprUNMZKyhZYA4037Ze+D9SrOEzdI603fOEsOLkWykmj3nAUw+5zA1suUNZMtpHSq0KZmgcY1DYG1J24lqfhxXK8CW10RyOytu+ozpaEGzDkMO1ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNFMTmeY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNFMTmeY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C811F000E9;
	Fri, 22 May 2026 04:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779424118;
	bh=ljCA/NXDFKTES1AXmSE7gDisUBh/0q1jcBgMHCOX1RE=;
	h=From:To:Cc:Subject:Date;
	b=YNFMTmeYmK+CTbMr3BS7Np59jMFPjdf9kFRHUkkhPKCcpEHUrxHezGdW+lpgleiwd
	 EUOI1mxDIQ/c9A05SdR4DSAuVJjmIHfk6j6XX0ELA0ygVA/4zoxVgtto8AaAcjICkM
	 xoVdScPnU+ERmASx4pIaMerDRYJ/QI4T9sTNRawV46knUsPI3v5FBT3wXIyO5LfuTw
	 8CzxtQTipM0WZO8KKmbE0C9pT1S0XiPGaok7McNBs2BRR2BI4D4znsgrcBecYuhiMN
	 LM+yf2wBwQ7vvvDGiPth0ffqJCi5y5h8JD7mnMMzBoNtimi4ZQ2TEKD79H72rZe7Lq
	 TYDU33uaLt30g==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org,
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
	Sven Schnelle <svens@linux.ibm.com>,
	x86@kernel.org
Subject: [PATCH v5 00/20] dma-mapping: Use DMA_ATTR_CC_SHARED through direct, pool and swiotlb paths
Date: Fri, 22 May 2026 09:57:55 +0530
Message-ID: <20260522042815.370873-1-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series propagates DMA_ATTR_CC_SHARED through the dma-direct,
dma-pool, and swiotlb paths so that encrypted and decrypted DMA buffers
are handled consistently.

Today, the direct DMA path mostly relies on force_dma_unencrypted() for
shared/decrypted buffer handling. This series consolidates the
force_dma_unencrypted() checks in the top-level functions and ensures
that the remaining DMA interfaces use DMA attributes to make the correct
decisions.

The series:
- moves swiotlb-backed allocations out of __dma_direct_alloc_pages(),
- propagates DMA_ATTR_CC_SHARED through the dma-direct alloc/free
  paths
- teaches the atomic DMA pools to track encrypted versus decrypted
  state
- tracks swiotlb pool encryption state and enforces strict pool
  selection
- centralizes encrypted/decrypted pgprot handling in dma_pgprot() using
  DMA attributes
- passes DMA attributes down to dma_capable() so capability checks can
  validate whether the selected DMA address encoding matches
  DMA_ATTR_CC_SHARED
- makes dma_direct_map_phys() choose the DMA address encoding from
  DMA_ATTR_CC_SHARED and fall back to swiotlb when a shared DMA request
  cannot use the direct mapping, which lets arm64 and x86 CCA guests stop
  relying on SWIOTLB_FORCE for DMA mappings
- use the selected swiotlb pool state to derive the returned DMA
  address.

Changes since v4:
https://lore.kernel.org/all/20260512090408.794195-1-aneesh.kumar@kernel.org
* Add new patches based on Sashiko review:
  swiotlb: Preserve allocation virtual address for dynamic pools
  dma: free atomic pool pages by physical address
  dma: swiotlb: handle set_memory_decrypted() failures
  dma: swiotlb: free dynamic pools from process context
  iommu/dma: Check atomic pool allocation result directly
* Include pKVM and s390 changes as dependent patches. These are not yet
  ready to merge and are waiting for subsystem testing feedback.
* Drop the AMD GART patch because it requires wider testing.
* Update swiotlb_tbl_map_single() to take attrs by reference.
* Switch swiotlb_free() to use rcu_work.
* Avoid calling swiotlb_find_pool() multiple times in the free path.
* Make DMA_ATTR_MMIO imply DMA_ATTR_CC_SHARED for devices requiring unencrypted DMA.

Changes from v3:
https://lore.kernel.org/all/20260427055509.898190-1-aneesh.kumar@kernel.org
* Handle DMA_ATTR_MMIO correctly in dma_direct_map_phys()
* Address most of sashiko review
* Rebase to latest kernel
* drop SWIOTLB_FORCE for s390 and powerpc secure guest.

Changes from v2:
https://lore.kernel.org/all/20260420061415.3650870-1-aneesh.kumar@kernel.org
* pass attrs to dma_capable() and update direct, swiotlb, Xen swiotlb, and
  x86 GART paths so the capability checks see the DMA address attr value
  DMA_ATTR_CC_SHARED.
* rework dma_direct_map_phys() so DMA_ATTR_CC_SHARED selects
  phys_to_dma_unencrypted() while the default path uses
  phys_to_dma_encrypted(), with swiotlb fallback when the requested
  shared/private state cannot be satisfied by a direct DMA address.
* stop relying on SWIOTLB_FORCE for arm64 and x86 CC guest DMA mappings;
  swiotlb is still enabled there, but shared mappings is now selected
  through the generic dma_direct_map_phys()/dma_capable() decision instead
  of a global force-bounce flag.

Changes from v1:
https://lore.kernel.org/all/20260417085900.3062416-1-aneesh.kumar@kernel.org
* rebased to latest kernel (change from DMA_ATTR_CC_DECRYPTED -> DMA_ATTR_CC_SHARED)
* update the alloc path so DMA_ATTR_CC_SHARED is not a caller-visible attribute.

Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Steven Price <steven.price@arm.com>
Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mostafa Saleh <smostafa@google.com>
Cc: Petr Tesarik <ptesarik@suse.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: x86@kernel.org

Aneesh Kumar K.V (Arm) (20):
  [DO NOT MERGE] arm64/coco: Add pKVM as a CC platform
  [DO NOT MERGE] s390: Expose protected virtualization through
    cc_platform_has()
  dma-direct: swiotlb: handle swiotlb alloc/free outside
    __dma_direct_alloc_pages
  dma-direct: use DMA_ATTR_CC_SHARED in alloc/free paths
  dma-pool: track decrypted atomic pools and select them via attrs
  dma: swiotlb: pass mapping attributes by reference
  dma: swiotlb: track pool encryption state and honor DMA_ATTR_CC_SHARED
  dma-mapping: make dma_pgprot() honor DMA_ATTR_CC_SHARED
  dma-direct: pass attrs to dma_capable() for DMA_ATTR_CC_SHARED checks
  dma-direct: make dma_direct_map_phys() honor DMA_ATTR_CC_SHARED
  dma-direct: set decrypted flag for remapped DMA allocations
  dma-direct: select DMA address encoding from DMA_ATTR_CC_SHARED
  dma-pool: fix page leak in atomic_pool_expand() cleanup
  dma-direct: rename ret to cpu_addr in alloc helpers
  dma-direct: return struct page from dma_direct_alloc_from_pool()
  iommu/dma: Check atomic pool allocation result directly
  dma: swiotlb: free dynamic pools from process context
  dma: swiotlb: handle set_memory_decrypted() failures
  dma: free atomic pool pages by physical address
  swiotlb: Preserve allocation virtual address for dynamic pools

 arch/arm64/include/asm/hypervisor.h           |   6 +
 arch/arm64/include/asm/mem_encrypt.h          |   3 +-
 arch/arm64/kernel/rsi.c                       |  12 -
 arch/arm64/mm/init.c                          |  17 +-
 arch/powerpc/platforms/pseries/svm.c          |   2 +-
 arch/s390/Kconfig                             |   1 +
 arch/s390/mm/init.c                           |  16 +-
 arch/x86/kernel/amd_gart_64.c                 |  30 +-
 arch/x86/kernel/pci-dma.c                     |   4 +-
 drivers/iommu/dma-iommu.c                     |  15 +-
 drivers/virt/coco/pkvm-guest/arm-pkvm-guest.c |   5 +
 drivers/xen/swiotlb-xen.c                     |   8 +-
 include/linux/dma-direct.h                    |  20 +-
 include/linux/dma-map-ops.h                   |   3 +-
 include/linux/swiotlb.h                       |  20 +-
 kernel/dma/direct.c                           | 275 +++++++++++++-----
 kernel/dma/direct.h                           |  47 +--
 kernel/dma/mapping.c                          |  16 +-
 kernel/dma/pool.c                             | 221 ++++++++++----
 kernel/dma/swiotlb.c                          | 270 +++++++++++++----
 20 files changed, 717 insertions(+), 274 deletions(-)


base-commit: 50897c955902c93ae71c38698abb910525ebdc89
-- 
2.43.0

