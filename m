Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EF51C5F13;
	Fri, 22 May 2026 04:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779424188; cv=none; b=F7nkP3PVPwRK968b++yScXc7gRC/aTYc2+Bx41VWHD9r0BqspbV6pPnsHoErHj6vnMThE4tiOTB+SsiaYXF8KgXA3rg/C/AzxEaOKZTMu5BfaATcbqcghN8q285MbRfTMjoUH5fj+1TZDSQrZYrY/wPKJ6JUGwaygX5iKfdc+3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779424188; c=relaxed/simple;
	bh=DTZwtvzr4H/iUrmfhOfanXsmvurs6mR83G/JRtdfrsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9MPh8x/c0DjwwErX1XAz7l4zsDaGdB6xsyB4zREGBkh7eG/YnVbPJHdTAJqqLgF673TxYT+nv3sU6gegRnvMSTzSWJFgAjj6Srs01zUuflb77lD24kw8pa7kjO4Zlv+rCU5ZroOSG03hfZPc3buw3a+NB3W/l06cEEKgek+nuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTpcAEtz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTpcAEtz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53511F000E9;
	Fri, 22 May 2026 04:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779424187;
	bh=fiD0PG9z39TyZrHJFNazn+XwQJBql3fj9afxEX8CQgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DTpcAEtz3uKGBFKHkFzOU4V7cNehSZ84WvKmLbDguu82gpqawSm7NQKAVGnXX8eq6
	 ptrDsyL2dVgsCtoWT/K17V5mHSNV9puGmMDqD2E67JUeM1Pm1pIVoCrKL8e00an2Yc
	 5coCreumM4fDiu7xpU8TBkCYzsqvND1lAZHsXgGmeSh5Jm+HiZUPa+M/VpM4LId2kf
	 I8NdR1Six+SEqwDDeqnrYWcTSn/Ct18aJZCbSSror+lZuMVS2gSZ9BonkJXQM6P/NQ
	 jZIKeAkPyiLAWKnLx1o20KEF4Jrm0zsHLtmwwkNYVHUUd/I3d8wYGQiVGd+jVlSpin
	 fHjzgsGmyPoZg==
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
Subject: [PATCH v5 06/20] dma: swiotlb: pass mapping attributes by reference
Date: Fri, 22 May 2026 09:58:01 +0530
Message-ID: <20260522042815.370873-7-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522042815.370873-1-aneesh.kumar@kernel.org>
References: <20260522042815.370873-1-aneesh.kumar@kernel.org>
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

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/dma-iommu.c | 2 +-
 drivers/xen/swiotlb-xen.c | 2 +-
 include/linux/swiotlb.h   | 2 +-
 kernel/dma/swiotlb.c      | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index c2595bee3d41..725c7adb0a8d 100644
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
index 133bb8ca9032..29187cec90d8 100644
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
index be4d418d92ac..78ce05857c00 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1391,7 +1391,7 @@ static unsigned long mem_used(struct io_tlb_mem *mem)
  */
 phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		size_t mapping_size, unsigned int alloc_align_mask,
-		enum dma_data_direction dir, unsigned long attrs)
+		enum dma_data_direction dir, unsigned long *attrs)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	unsigned int offset;
@@ -1425,7 +1425,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	size = ALIGN(mapping_size + offset, alloc_align_mask + 1);
 	index = swiotlb_find_slots(dev, orig_addr, size, alloc_align_mask, &pool);
 	if (index == -1) {
-		if (!(attrs & DMA_ATTR_NO_WARN))
+		if (!(*attrs & DMA_ATTR_NO_WARN))
 			dev_warn_ratelimited(dev,
 	"swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
 				 size, mem->nslabs, mem_used(mem));
@@ -1604,7 +1604,7 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
 
 	trace_swiotlb_bounced(dev, phys_to_dma(dev, paddr), size);
 
-	swiotlb_addr = swiotlb_tbl_map_single(dev, paddr, size, 0, dir, attrs);
+	swiotlb_addr = swiotlb_tbl_map_single(dev, paddr, size, 0, dir, &attrs);
 	if (swiotlb_addr == (phys_addr_t)DMA_MAPPING_ERROR)
 		return DMA_MAPPING_ERROR;
 
-- 
2.43.0

