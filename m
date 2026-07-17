Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB8127AC4C;
	Fri, 17 Jul 2026 18:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784311502; cv=none; b=PlfqKGA5PqD2/lTP5TyJ2U4E3FnOZmEz/M36GseQDyM/urWWTiJQUswRm09JCgfodv28rXVhuo9lrkL62Lr/Cjc4flc/+bn9LxjeD8hiqfrhqGzz8QijvPmwopn2zTRHYhe/7nFXySEMiMmaubXvAfJ1GysP2cc/JKm7Elxje5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784311502; c=relaxed/simple;
	bh=qxk9PmkWIsmw2SIk/aN/40OHqvY9sjrUBrxmzV6fKBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=scVLiwVTZvWSfQlJ5qQGqU8zyHiRh5Nchz6hnJtDGjgCrRlckW2Tzr2kJJUjT4463MfmpsXXcHEMjxi9QJJ3kUTl66zJfv4eXgY5nj77f0l+VZbtR5RWHGhNHgMCNtaxtx9Fm1+7X4Ekd+SatBtFVIWHA34KeV7PXLTBvjzJtZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUsbeMjD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUsbeMjD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693A61F000E9;
	Fri, 17 Jul 2026 18:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784311501;
	bh=ncpsGFMWEl9T9gCC5g1veSLwl+Av6zTadCXYF2SNSp8=;
	h=From:To:Cc:Subject:Date;
	b=EUsbeMjD3AJTUht8Jd5qLBmAe3HzO4ixUuj8Y0Fqw8zkjDfDI3PWhb3Dr1JVwUo/j
	 G2pwkeR0zH8iMpgg2/MNowZwYBEQcNbqvZdmJv+EBF6urlHyMI5218QRGC5FDpllZF
	 Jd6ieEBUcf4joS+D1b1+3sixzCadjFj+dIWfiv2jlY+Ihc0bD6ztW/ZnO17Hc+IFVs
	 6B3//L0o2quZN/L3RKKlcY5+VURB0SFC7mLtrXeafNihQJbHWxAHkpyGhYy+zG+mqg
	 fk+Jfy+SML3/GqnhdJGY1nOnzfiBmPhbRYRV0N+/AB5VpFG7/jt7wTql2bTgnp6WiQ
	 TqwCKQn2Z5ipA==
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
Subject: [PATCH v8 00/23] dma-mapping: Track shared DMA state through direct, pool and swiotlb paths
Date: Fri, 17 Jul 2026 23:34:18 +0530
Message-ID: <20260717180442.110954-1-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series tracks confidential-computing shared DMA state through the
dma-direct, dma-pool, and swiotlb paths so that encrypted and decrypted
DMA buffers are handled consistently.

Today, the direct DMA path mostly relies on force_dma_unencrypted() for
shared/decrypted buffer handling. This series consolidates the
force_dma_unencrypted() checks in the top-level functions and ensures
that the remaining DMA interfaces use DMA attributes to make the correct
decisions.

The series separates mapping and allocation state:
- DMA_ATTR_CC_SHARED describes the DMA address attribute requested for a
  mapping. It tells the DMA mapping path that the DMA address must target
  shared/decrypted memory.
- __DMA_ATTR_ALLOC_CC_SHARED is an internal DMA-mapping attribute used only
  by allocation paths after the DMA core decides that the backing pages
  must be allocated as shared/decrypted memory.

The series:
- moves swiotlb-backed allocations out of __dma_direct_alloc_pages(),
- uses __DMA_ATTR_ALLOC_CC_SHARED through the dma-direct alloc/free paths
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
  address
- reports CC_ATTR_GUEST_MEM_ENCRYPT for arm64 Realms, powerpc secure
  guests, and s390 protected virtualization guests.

Dependency:
This series depends on the pKVM changes posted at:
https://lore.kernel.org/all/20260603110522.3331819-1-smostafa@google.com

Please merge this series only after the pKVM changes above are merged.
Otherwise pKVM will be broken.

Changes since v7:
https://lore.kernel.org/all/20260701054926.825925-1-aneesh.kumar@kernel.org
* Rebased onto dma-mapping-for-next
* Prepared the series on top of the prerequisite pKVM changes, resolving
  conflicts so it can be applied directly to the pKVM topic branch once ready.
  https://git.gitlab.arm.com/linux-arm/linux-cca/-/commits/scratch/pkvm/testing
* Added comments documenting possible follow-up improvements for CC_SHARED
  atomic pools and physical-address-based pool freeing.
* Retained virtual-address-based pool freeing when
  CONFIG_DMA_DIRECT_REMAP is disabled.
* Applied pgprot_decrypted() only when expanding a CC_SHARED atomic pool.

Changes since v6:
https://lore.kernel.org/all/20260604083959.1265923-1-aneesh.kumar@kernel.org
* Rebase onto the latest kernel.
* Add __DMA_ATTR_ALLOC_CC_SHARED for allocation paths. DMA_ATTR_CC_SHARED
  is now used to describe the requested DMA mapping address attribute,
  while __DMA_ATTR_ALLOC_CC_SHARED is used internally when allocating
  shared/decrypted backing pages.
* Report CC_ATTR_GUEST_MEM_ENCRYPT for arm64 Realms, powerpc secure
  guests, and s390 protected virtualization guests.
* Add CC_ATTR_HOST_MEM_ENCRYPT and swiotlb=force fixes.

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

Aneesh Kumar K.V (Arm) (23):
  dma-direct: return struct page from dma_direct_alloc_from_pool()
  dma-pool: fix page leak in atomic_pool_expand() cleanup
  iommu/dma: Check atomic pool allocation result directly
  dma: free atomic pool pages by physical address
  swiotlb: Preserve allocation virtual address for dynamic pools
  s390: Expose protected virtualization through cc_platform_has()
  dma-direct: swiotlb: handle swiotlb alloc/free outside
    __dma_direct_alloc_pages
  coco: arm64: s390: powerpc: Mark secure guests with
    CC_ATTR_GUEST_MEM_ENCRYPT
  dma-mapping: Add internal shared allocation attribute
  dma-direct: use __DMA_ATTR_ALLOC_CC_SHARED in alloc/free paths
  dma-pool: track decrypted atomic pools and select them via attrs
  dma: swiotlb: pass mapping attributes by reference
  dma: swiotlb: track pool encryption state and honor DMA_ATTR_CC_SHARED
  dma-mapping: make dma_pgprot() honor __DMA_ATTR_ALLOC_CC_SHARED
  dma-direct: pass attrs to dma_capable() for DMA_ATTR_CC_SHARED checks
  dma-direct: Move dma_direct_map_phys() to dma/direct.c
  dma-direct: make dma_direct_map_phys() honor DMA_ATTR_CC_SHARED
  dma-direct: set decrypted flag for remapped DMA allocations
  dma-direct: select DMA address encoding from
    __DMA_ATTR_ALLOC_CC_SHARED
  dma-direct: rename ret to cpu_addr in alloc helpers
  dma: swiotlb: free dynamic pools from process context
  dma: swiotlb: handle set_memory_decrypted() failures
  swiotlb: remove unused SWIOTLB_FORCE flag

 Documentation/core-api/dma-attributes.rst    |  29 ++
 arch/arm64/mm/init.c                         |   5 +-
 arch/powerpc/platforms/pseries/cc_platform.c |   1 +
 arch/powerpc/platforms/pseries/svm.c         |   2 +-
 arch/s390/Kconfig                            |   1 +
 arch/s390/mm/init.c                          |  17 +-
 arch/x86/kernel/amd_gart_64.c                |  30 +-
 arch/x86/kernel/pci-dma.c                    |   4 +-
 drivers/iommu/dma-iommu.c                    |  20 +-
 drivers/xen/swiotlb-xen.c                    |   8 +-
 include/linux/dma-direct.h                   |  20 +-
 include/linux/dma-map-ops.h                  |   3 +-
 include/linux/dma-mapping.h                  |   8 +
 include/linux/swiotlb.h                      |  25 +-
 include/trace/events/dma.h                   |   3 +-
 kernel/dma/direct.c                          | 326 ++++++++++++++-----
 kernel/dma/direct.h                          |  56 +---
 kernel/dma/mapping.c                         |  25 +-
 kernel/dma/pool.c                            | 237 ++++++++++----
 kernel/dma/swiotlb.c                         | 292 +++++++++++++----
 20 files changed, 810 insertions(+), 302 deletions(-)

-- 
2.43.0

