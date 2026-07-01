Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B57C38550E;
	Wed,  1 Jul 2026 05:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782885117; cv=none; b=MxE84UbvXU+BEgExpZagQzvC6Ki9hhsgGSDDLYEJ6w9y5SuAEsYxhgw/zeJ/1ib36w9wGXEflqoyXQmMi6GX2RA4VTwZhT/TGifjMoyhgOrQbWFWIO7XPp4siqsjh65Yjlj6qiXRQ21yvpZO/Nu9LBPmfU/4GbdN5aUUXiPoMHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782885117; c=relaxed/simple;
	bh=OwDg/UrqR7zNsh4SX7+tJNbYx42ses/HLbCO8cKtrjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/90IC17NEQw5suCM40WiZH97nuvjZqITXXmWyh/nNnZuo+JsFJHkDLPK9kxE5ggfS2EFrV2NB3BNqvzHaLTuGm5hxfnmpu+hz7bU//8P1FUQwV6ntFN1CdWO9GNHm04YXVxSsAReGNDWXdXZ9hbYAB4EJNXE/y1DR09Sw7YwKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBuDJMA4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBuDJMA4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54AC1F00A3A;
	Wed,  1 Jul 2026 05:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782885116;
	bh=OZRfpe1gkQB5ylDlaIEs97+2THXrSy+4o76S0htLMaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oBuDJMA4imMAWmgvu0kl7v5CkFWP30f08zqTJbKZjiseHkq+85ygHvASLMbYZbpMH
	 Q9lIvkHqhoT12HBPL7FRbphU4ekgyiKXTr/hPZJSawKv7TnQsLESk0krzxWP5GwBXH
	 hNmh+j8rG5h5B21yxGhL2lMt3ZEWfgpFoxAOVN6CxUWNPOVwui/UN/3LG5HS6GwBXa
	 ndjVHjKXCe05Frpknj0za5SVHkEpZIPJIkyfH4c1HQZ1CdgO4qWwmUDag5eyEaq8Wt
	 beiEuhq9cwrWUWeRJs+gFjGqlV8yjD7f8kRqcCFPRiZd39k46L+kQcmA+uOID2P909
	 CHPPhH7ztjm+A==
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
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH v7 12/22] dma: swiotlb: pass mapping attributes by reference
Date: Wed,  1 Jul 2026 11:19:16 +0530
Message-ID: <20260701054926.825925-13-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701054926.825925-1-aneesh.kumar@kernel.org>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
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
index a7b1da5e06e6..fe387829ee92 100644
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

