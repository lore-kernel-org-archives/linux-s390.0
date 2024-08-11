Received: from mail.tkos.co.il (mail.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913DC1BF58;
	Sun, 11 Aug 2024 07:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723360189; cv=none; b=RwMwtM5Q+jo8G5owcijS0fVxkZMNjCdbSJns6MqxPBvImfeCdsbDdAgaFqZRN+inm1Y8QFAQRklaJ5IeB8AK8ZqtsBoqf2ja9XzYOInU3pZPKMQTHn3x1aeQtz/hf3juV/5q9DoX2lsghaGupFgL0XApjy6BqLmBrnwYl+od9BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723360189; c=relaxed/simple;
	bh=ETswJ2dtFPfh+twflGVXRxa/k2k5q2bbYBtQX7oOOy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjTwPnHCajYYbFmfWEweorWFP2jhgx02vsYSGfiGouLpDoVJUyhSS66s01f7/bN61r3jZT4FKcmuKjyCeSHMVupEKlajhcGzzHuEt/TfLmmYvcrTYtzl/FwkM1o2BvQcEejjyvJ9arjXQuKQBDSJcMv1BILKAvk3eiAfbjpll2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=bv1aSHUM; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="bv1aSHUM"
Received: from tarshish.tkos.co.il (unknown [10.0.8.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 2CE08440F39;
	Sun, 11 Aug 2024 10:08:14 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1723360094;
	bh=ETswJ2dtFPfh+twflGVXRxa/k2k5q2bbYBtQX7oOOy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bv1aSHUMhcuFAy62jUNbvY0HSVjL/m7iMhqnCNkWi6qxb/0yj3hsKoNG0RMB7i1RC
	 f4+khwiPlBUSLhyCzYUwJRtuHrHAQ3Yu2MGlSvgi8pwaAK2s8Asm8/KluB5XKgTL36
	 wHKL+17LVALgiaPOdm2UUJQpByVW1vMonecsZbtZpFcR60S5/sX1UnU9xLzASCZedh
	 eYuJ0ENw4ihfv8edVfFsqWohhm1hLy6HrCi2gAOeva7K+PTZHHw/II+UqNUnpgMHJ9
	 npCYT15v78mTKCFFBz41HZdYhhnIeQvrnmONwmLnAoe6AEGZvDlES88bvugXdG9CIL
	 2jeOmKk4BTTpw==
From: Baruch Siach <baruch@tkos.co.il>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Baruch Siach <baruch@tkos.co.il>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	=?UTF-8?q?Petr=20Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>,
	Ramon Fried <ramon@neureality.ai>,
	Elad Nachman <enachman@marvell.com>
Subject: [PATCH v6 RESED 1/2] dma: replace zone_dma_bits by zone_dma_limit
Date: Sun, 11 Aug 2024 10:09:35 +0300
Message-ID: <17c067618b93e5d71f19c37826d54db4299621a3.1723359916.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723359916.git.baruch@tkos.co.il>
References: <cover.1723359916.git.baruch@tkos.co.il>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Catalin Marinas <catalin.marinas@arm.com>

Hardware DMA limit might not be power of 2. When RAM range starts above
0, say 4GB, DMA limit of 30 bits should end at 5GB. A single high bit
can not encode this limit.

Use plain address for DMA zone limit.

Since DMA zone can now potentially span beyond 4GB physical limit of
DMA32, make sure to use DMA zone for GFP_DMA32 allocations in that case.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Co-developed-by: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm64/mm/init.c       | 30 +++++++++++++++---------------
 arch/powerpc/mm/mem.c      |  5 ++++-
 arch/s390/mm/init.c        |  2 +-
 include/linux/dma-direct.h |  2 +-
 kernel/dma/direct.c        |  6 +++---
 kernel/dma/pool.c          |  4 ++--
 kernel/dma/swiotlb.c       |  6 +++---
 7 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 9b5ab6818f7f..c45e2152ca9e 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -115,35 +115,35 @@ static void __init arch_reserve_crashkernel(void)
 }
 
 /*
- * Return the maximum physical address for a zone accessible by the given bits
- * limit. If DRAM starts above 32-bit, expand the zone to the maximum
+ * Return the maximum physical address for a zone given its limit.
+ * If DRAM starts above 32-bit, expand the zone to the maximum
  * available memory, otherwise cap it at 32-bit.
  */
-static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
+static phys_addr_t __init max_zone_phys(phys_addr_t zone_limit)
 {
-	phys_addr_t zone_mask = DMA_BIT_MASK(zone_bits);
 	phys_addr_t phys_start = memblock_start_of_DRAM();
 
 	if (phys_start > U32_MAX)
-		zone_mask = PHYS_ADDR_MAX;
-	else if (phys_start > zone_mask)
-		zone_mask = U32_MAX;
+		zone_limit = PHYS_ADDR_MAX;
+	else if (phys_start > zone_limit)
+		zone_limit = U32_MAX;
 
-	return min(zone_mask, memblock_end_of_DRAM() - 1) + 1;
+	return min(zone_limit, memblock_end_of_DRAM() - 1) + 1;
 }
 
 static void __init zone_sizes_init(void)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
-	unsigned int __maybe_unused acpi_zone_dma_bits;
-	unsigned int __maybe_unused dt_zone_dma_bits;
-	phys_addr_t __maybe_unused dma32_phys_limit = max_zone_phys(32);
+	phys_addr_t __maybe_unused acpi_zone_dma_limit;
+	phys_addr_t __maybe_unused dt_zone_dma_limit;
+	phys_addr_t __maybe_unused dma32_phys_limit =
+		max_zone_phys(DMA_BIT_MASK(32));
 
 #ifdef CONFIG_ZONE_DMA
-	acpi_zone_dma_bits = fls64(acpi_iort_dma_get_max_cpu_address());
-	dt_zone_dma_bits = fls64(of_dma_get_max_cpu_address(NULL));
-	zone_dma_bits = min3(32U, dt_zone_dma_bits, acpi_zone_dma_bits);
-	arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
+	acpi_zone_dma_limit = acpi_iort_dma_get_max_cpu_address();
+	dt_zone_dma_limit = of_dma_get_max_cpu_address(NULL);
+	zone_dma_limit = min(dt_zone_dma_limit, acpi_zone_dma_limit);
+	arm64_dma_phys_limit = max_zone_phys(zone_dma_limit);
 	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
 #endif
 #ifdef CONFIG_ZONE_DMA32
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index d325217ab201..05b7f702b3f7 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -216,7 +216,7 @@ static int __init mark_nonram_nosave(void)
  * everything else. GFP_DMA32 page allocations automatically fall back to
  * ZONE_DMA.
  *
- * By using 31-bit unconditionally, we can exploit zone_dma_bits to inform the
+ * By using 31-bit unconditionally, we can exploit zone_dma_limit to inform the
  * generic DMA mapping code.  32-bit only devices (if not handled by an IOMMU
  * anyway) will take a first dip into ZONE_NORMAL and get otherwise served by
  * ZONE_DMA.
@@ -230,6 +230,7 @@ void __init paging_init(void)
 {
 	unsigned long long total_ram = memblock_phys_mem_size();
 	phys_addr_t top_of_ram = memblock_end_of_DRAM();
+	int zone_dma_bits;
 
 #ifdef CONFIG_HIGHMEM
 	unsigned long v = __fix_to_virt(FIX_KMAP_END);
@@ -256,6 +257,8 @@ void __init paging_init(void)
 	else
 		zone_dma_bits = 31;
 
+	zone_dma_limit = DMA_BIT_MASK(zone_dma_bits);
+
 #ifdef CONFIG_ZONE_DMA
 	max_zone_pfns[ZONE_DMA]	= min(max_low_pfn,
 				      1UL << (zone_dma_bits - PAGE_SHIFT));
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index ddcd39ef4346..91fc2b91adfc 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -97,7 +97,7 @@ void __init paging_init(void)
 
 	vmem_map_init();
 	sparse_init();
-	zone_dma_bits = 31;
+	zone_dma_limit = DMA_BIT_MASK(31);
 	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
 	max_zone_pfns[ZONE_DMA] = virt_to_pfn(MAX_DMA_ADDRESS);
 	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index edbe13d00776..d7e30d4f7503 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -12,7 +12,7 @@
 #include <linux/mem_encrypt.h>
 #include <linux/swiotlb.h>
 
-extern unsigned int zone_dma_bits;
+extern u64 zone_dma_limit;
 
 /*
  * Record the mapping of CPU physical to DMA addresses for a given region.
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 4480a3cd92e0..f2ba074a6a54 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -20,7 +20,7 @@
  * it for entirely different regions. In that case the arch code needs to
  * override the variable below for dma-direct to work properly.
  */
-unsigned int zone_dma_bits __ro_after_init = 24;
+u64 zone_dma_limit __ro_after_init = DMA_BIT_MASK(24);
 
 static inline dma_addr_t phys_to_dma_direct(struct device *dev,
 		phys_addr_t phys)
@@ -59,7 +59,7 @@ static gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 *phys_limit)
 	 * zones.
 	 */
 	*phys_limit = dma_to_phys(dev, dma_limit);
-	if (*phys_limit <= DMA_BIT_MASK(zone_dma_bits))
+	if (*phys_limit <= zone_dma_limit)
 		return GFP_DMA;
 	if (*phys_limit <= DMA_BIT_MASK(32))
 		return GFP_DMA32;
@@ -580,7 +580,7 @@ int dma_direct_supported(struct device *dev, u64 mask)
 	 * part of the check.
 	 */
 	if (IS_ENABLED(CONFIG_ZONE_DMA))
-		min_mask = min_t(u64, min_mask, DMA_BIT_MASK(zone_dma_bits));
+		min_mask = min_t(u64, min_mask, zone_dma_limit);
 	return mask >= phys_to_dma_unencrypted(dev, min_mask);
 }
 
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index d10613eb0f63..7b04f7575796 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -70,9 +70,9 @@ static bool cma_in_zone(gfp_t gfp)
 	/* CMA can't cross zone boundaries, see cma_activate_area() */
 	end = cma_get_base(cma) + size - 1;
 	if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp & GFP_DMA))
-		return end <= DMA_BIT_MASK(zone_dma_bits);
+		return end <= zone_dma_limit;
 	if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32))
-		return end <= DMA_BIT_MASK(32);
+		return end <= max(DMA_BIT_MASK(32), zone_dma_limit);
 	return true;
 }
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index df68d29740a0..abcf3fa63a56 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -450,9 +450,9 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 	if (!remap)
 		io_tlb_default_mem.can_grow = true;
 	if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp_mask & __GFP_DMA))
-		io_tlb_default_mem.phys_limit = DMA_BIT_MASK(zone_dma_bits);
+		io_tlb_default_mem.phys_limit = zone_dma_limit;
 	else if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp_mask & __GFP_DMA32))
-		io_tlb_default_mem.phys_limit = DMA_BIT_MASK(32);
+		io_tlb_default_mem.phys_limit = max(DMA_BIT_MASK(32), zone_dma_limit);
 	else
 		io_tlb_default_mem.phys_limit = virt_to_phys(high_memory - 1);
 #endif
@@ -629,7 +629,7 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
 	}
 
 	gfp &= ~GFP_ZONEMASK;
-	if (phys_limit <= DMA_BIT_MASK(zone_dma_bits))
+	if (phys_limit <= zone_dma_limit)
 		gfp |= __GFP_DMA;
 	else if (phys_limit <= DMA_BIT_MASK(32))
 		gfp |= __GFP_DMA32;
-- 
2.43.0

