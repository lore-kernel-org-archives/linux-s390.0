Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A6A3E51C1;
	Thu,  4 Jun 2026 08:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562420; cv=none; b=JpRDe7GsQ5ODBiE3cN8g8obaf6jrl0W53JycI2NuwdnVdQ+9Z4uGYLArRkpE53/UwSBp7ZGBBp7JhWLRAWaW8klYQnUwvmz7j1O8hNoP6pARq8z8DpgEqcPAQ7SNRZcStTCeg5p1naDg+dSkewNlH4BlpdbDh5fzokWRoBudBFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562420; c=relaxed/simple;
	bh=a5QZZCy9Wob3UPjjoQGUMvW9yB+7RmfM1eFovwyCltw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ERY4RWkOXfJ8CXJt+4z5+ZmXBp0wt9wzABeZMjABm7i6pFZa8GpC9Ag89CDck4V4MY6aveZY7AagGnmrF/OPImNatN6z2HK6Jv43xc/gzXtwBCOn1nJ4P+WV8/syLXRuPJhVwG32lCI7j4GaffvybZjc8wtnqgb221P/ll7uVeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i77XriBT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i77XriBT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAAF1F00893;
	Thu,  4 Jun 2026 08:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780562413;
	bh=wHOprMx7xR6nqpYaL4ej4AIk1kPiMId1xf+MLlCyuGM=;
	h=From:To:Cc:Subject:Date;
	b=i77XriBTPGuUv0oAi0lasSX+AaT58/2yrzJiwqs8PcjatYYDo4+fQKCPkQO+G4eRq
	 Rrz2tQO+WMMJw0f77rRW3AtUh+Ki141ppS8hV+XcNxQQvg1DqkajOyOZpbbsD/qCKf
	 N7wXVYitXtPftDibMPWQjUNNEsEjkbb++hBIWWrVnpM7xdqG6Ia+Onl+r2zFQZLkmD
	 kWEvxJbxJLh/t8cv1bIQJlKeGkRZEBDTMrMm2fSMIc6dmVxjd4+TcXDoGrQGTdPOQU
	 tvGGdcaSy+BEPnD2oQer5+hedm9s5j2s7XhvPu7oL6D5SULj6UwyMkzRMQI+CTDypR
	 DIYG1PdxMhwRQ==
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
Subject: [PATCH v6 00/20] dma-mapping: Use DMA_ATTR_CC_SHARED through direct, pool and swiotlb paths
Date: Thu,  4 Jun 2026 14:09:39 +0530
Message-ID: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
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

Changes since v5:
https://lore.kernel.org/all/20260522042815.370873-1-aneesh.kumar@kernel.org
* Add Tested-by
* Drop the pKVM patch, which has now been posted separately:
  https://lore.kernel.org/all/20260603110522.3331819-1-smostafa@google.com
* Remove the DO_NOT_MERGE tag from the s390 change.
* Add a patch to drop the SWIOTLB_FORCE flag.
* Rebase onto the latest kernel.

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
  s390: Expose protected virtualization through cc_platform_has()
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
  swiotlb: remove unused SWIOTLB_FORCE flag

 arch/arm64/mm/init.c                 |   4 +-
 arch/powerpc/platforms/pseries/svm.c |   2 +-
 arch/s390/Kconfig                    |   1 +
 arch/s390/mm/init.c                  |  16 +-
 arch/x86/kernel/amd_gart_64.c        |  30 +--
 arch/x86/kernel/pci-dma.c            |   4 +-
 drivers/iommu/dma-iommu.c            |  15 +-
 drivers/xen/swiotlb-xen.c            |   8 +-
 include/linux/dma-direct.h           |  20 +-
 include/linux/dma-map-ops.h          |   3 +-
 include/linux/swiotlb.h              |  21 +-
 kernel/dma/direct.c                  | 275 +++++++++++++++++++--------
 kernel/dma/direct.h                  |  47 ++---
 kernel/dma/mapping.c                 |  16 +-
 kernel/dma/pool.c                    | 221 +++++++++++++++------
 kernel/dma/swiotlb.c                 | 273 ++++++++++++++++++++------
 16 files changed, 692 insertions(+), 264 deletions(-)


base-commit: ba3e43a9e601636f5edb54e259a74f96ca3b8fd8
-- 
2.43.0

