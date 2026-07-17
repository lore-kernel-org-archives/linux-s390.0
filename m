Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E599363C75;
	Fri, 17 Jul 2026 18:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784311642; cv=none; b=RxnZ5biEqykrsNs6jHJ3f/hAbQeUR6Dx4mFFbay+QxRRDi1kr7TTGHA5567H8TXPjBSjMSyWSW0hy+GtH7YRXhuj3eSytGF9WNdASDM8KOpxDLH/IQZDvT/kgvimeiCcxfu5stW63BjgHjOa46WLDATjaNZelKUNnKxnjOlbtWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784311642; c=relaxed/simple;
	bh=hjk54hwCeXFuHOgGlL08cCYy5A8Di3d+CJ09zT+uMFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vr2o2lxQNtqRGLWUiF6cf9Rj3paSPEzZ7RxD1EG1mdjIegxOSP1oHFW14qGQRs9b9LDEkiZ6+lNBldulopVLP30bQDgud5BFq4x5gf1Zna7l0igFm9B/Auc/jAQoTtrtSd9injWH1gJT+Xnn5N1GxcruIPcD0zjMuLydgSAFJn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=az13Ithd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="az13Ithd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37B11F000E9;
	Fri, 17 Jul 2026 18:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784311641;
	bh=GmV+DLQ7tYIWroxvAExoKmvbkkmdzgJAVMErN4og4x4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=az13IthdkXyuHXIkezoBcf/c1Fq7gOmr7pJ1N3ScoTlVliZ+mKyhugHc9IoFT/+ps
	 mx/VWltvB/OE4cP7XVfJT7AqIaVa7vuI1ROM488yX1sON079TaNz/XxE+xmHpKkt8M
	 /hZFLyvrERm9g9N7xKjKO9NUJrnHEBcwHHBg7sH5PBNQyieyFGG7wCvdZngIL5m3j+
	 ael+cAywtofFkarpwGqmsZLoLfjzo12yL3TkTj8rc0hI4v+RYuvJ7cnoHuhB0vZPUz
	 Qziyito1Btp7hGtyoEZ9uNsobXFeDPhhKVJQYbd306KM6UCfmPQpZagHXHUAo/FDXE
	 oax4sLpMKdbDA==
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
	x86@kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH v8 12/23] dma: swiotlb: pass mapping attributes by reference
Date: Fri, 17 Jul 2026 23:34:30 +0530
Message-ID: <20260717180442.110954-13-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717180442.110954-1-aneesh.kumar@kernel.org>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change swiotlb_tbl_map_single() to take the DMA mapping attributes by
reference and update the direct callers accordingly.

This is a preparatory change for a follow-up patch which updates the
attributes based on the selected swiotlb pool. Keeping the signature change
separate makes the follow-up patch easier to review.

No functional change in this patch.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Petr Tesarik <ptesarik@suse.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/dma-iommu.c | 2 +-
 drivers/xen/swiotlb-xen.c | 2 +-
 include/linux/swiotlb.h   | 2 +-
 kernel/dma/swiotlb.c      | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 83bf15ae9777..c42e40e60575 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1180,7 +1180,7 @@ static phys_addr_t iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
 	trace_swiotlb_bounced(dev, phys, size);
 
 	phys = swiotlb_tbl_map_single(dev, phys, size, iova_mask(iovad), dir,
-			attrs);
+				      &attrs);
 
 	/*
 	 * Untrusted devices should not see padding areas with random leftover
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 2cbf2b588f5b..8c4abe65cd49 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -243,7 +243,7 @@ static dma_addr_t xen_swiotlb_map_phys(struct device *dev, phys_addr_t phys,
 	 */
 	trace_swiotlb_bounced(dev, dev_addr, size);
 
-	map = swiotlb_tbl_map_single(dev, phys, size, 0, dir, attrs);
+	map = swiotlb_tbl_map_single(dev, phys, size, 0, dir, &attrs);
 	if (map == (phys_addr_t)DMA_MAPPING_ERROR)
 		return DMA_MAPPING_ERROR;
 
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index c92ff6791595..ea4c0a292dea 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -238,7 +238,7 @@ static inline phys_addr_t default_swiotlb_limit(void)
 
 phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t phys,
 		size_t mapping_size, unsigned int alloc_aligned_mask,
-		enum dma_data_direction dir, unsigned long attrs);
+		enum dma_data_direction dir, unsigned long *attrs);
 dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
 		size_t size, enum dma_data_direction dir, unsigned long attrs);
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 908de28aceb2..046ae92c4832 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1396,7 +1396,7 @@ static unsigned long mem_used(struct io_tlb_mem *mem)
  */
 phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		size_t mapping_size, unsigned int alloc_align_mask,
-		enum dma_data_direction dir, unsigned long attrs)
+		enum dma_data_direction dir, unsigned long *attrs)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	unsigned int offset;
@@ -1430,7 +1430,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	size = ALIGN(mapping_size + offset, alloc_align_mask + 1);
 	index = swiotlb_find_slots(dev, orig_addr, size, alloc_align_mask, &pool);
 	if (index == -1) {
-		if (!(attrs & DMA_ATTR_NO_WARN))
+		if (!(*attrs & DMA_ATTR_NO_WARN))
 			dev_warn_ratelimited(dev,
 	"swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
 				 size, mem->nslabs, mem_used(mem));
@@ -1609,7 +1609,7 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
 
 	trace_swiotlb_bounced(dev, phys_to_dma(dev, paddr), size);
 
-	swiotlb_addr = swiotlb_tbl_map_single(dev, paddr, size, 0, dir, attrs);
+	swiotlb_addr = swiotlb_tbl_map_single(dev, paddr, size, 0, dir, &attrs);
 	if (swiotlb_addr == (phys_addr_t)DMA_MAPPING_ERROR)
 		return DMA_MAPPING_ERROR;
 
-- 
2.43.0

