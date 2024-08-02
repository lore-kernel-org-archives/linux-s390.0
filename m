Received: from mail.tkos.co.il (wiki.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A429922EF0;
	Fri,  2 Aug 2024 06:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722578645; cv=none; b=h80QHwETSNGSn+KQiWyfr5zG76aQdQZj24ZF5Vm1lVWSN8OtxzEZIuexRxtLOet2oPy5vw44egZA+1lMK943SoCLgaZJgaDNb+9V6s0OFAH7Z/Q94D+SLqFaQvRdrzx4YfHyWWD2l6xceK6Svs38gLeFSeY0l9yRu1OnLMIZvLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722578645; c=relaxed/simple;
	bh=gZOWymHOEmkHAug5M9b/xdnNdL0aUZko8BF6/adGviE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5cZy4Y2V+6nWJyDrEOhsgpXBN05fl9+MsLQ/nx3hwqXP9Y7+QxrJvgjns9thNh5QYpoHTGexxqWU3GdydsOfh2wBKDwYQSgMS3WfCnP/en0h7tJNdcfROr37cYysnKWzHli3wN1/0ixo/tb+PcTCFzXz0WQpu4vorX5CmfQhI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=FaOmOctA; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="FaOmOctA"
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 2940B44077F;
	Fri,  2 Aug 2024 09:02:40 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1722578560;
	bh=gZOWymHOEmkHAug5M9b/xdnNdL0aUZko8BF6/adGviE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FaOmOctAKuZCEYWD+FZAdHs3ae4M9xRhYaDdRXITKj00Bl1gnikRPykLnWpKFypUI
	 hK6pjKEJNdDxVFc4r5DsNTNrW7RAsSq1FzZiEmqAQKMM8jwYIhz1r53C9tDXW5XAdT
	 Vh2w271u3q4JsCIaJ5S9UAtDwX2HBIFg4uDgB0PKEenChpSF5A/t/ashmYXL14jASh
	 ydIzEAqfVFYbtfobpUbTI4/IkaZntWbrk04MuftnmnLOUF1s+dVessGwfFz43VehYo
	 IfktUGtAD8R/82q7j+l0p43pYKAWk6WOEfGHw6SRt2Bi3HObDZcWOOPahhnumJSi1T
	 Y1Tuxk5M2tn9g==
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
Subject: [PATCH v5 2/3] dma: replace zone_dma_bits by zone_dma_limit
Date: Fri,  2 Aug 2024 09:03:47 +0300
Message-ID: <5821a1b2eb82847ccbac0945da040518d6f6f16b.1722578375.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722578375.git.baruch@tkos.co.il>
References: <cover.1722578375.git.baruch@tkos.co.il>
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
 arch/powerpc/mm/mem.c      |  9 ++++-----
 arch/s390/mm/init.c        |  2 +-
 include/linux/dma-direct.h |  2 +-
 kernel/dma/direct.c        |  4 ++--
 kernel/dma/pool.c          |  4 ++--
 kernel/dma/swiotlb.c       |  4 ++--
 7 files changed, 27 insertions(+), 28 deletions(-)

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
index d325217ab201..342c006cc1b8 100644
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
@@ -252,13 +252,12 @@ void __init paging_init(void)
 	 * powerbooks.
 	 */
 	if (IS_ENABLED(CONFIG_PPC32))
-		zone_dma_bits = 30;
+		zone_dma_limit = DMA_BIT_MASK(30);
 	else
-		zone_dma_bits = 31;
+		zone_dma_limit = DMA_BIT_MASK(31);
 
 #ifdef CONFIG_ZONE_DMA
-	max_zone_pfns[ZONE_DMA]	= min(max_low_pfn,
-				      1UL << (zone_dma_bits - PAGE_SHIFT));
+	max_zone_pfns[ZONE_DMA]	= min(max_low_pfn, zone_dma_limit >> PAGE_SHIFT);
 #endif
 	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
 #ifdef CONFIG_HIGHMEM
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
index 3b4be4ca3b08..62b36fda44c9 100644
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
index 043b0ecd3e8d..bb51bd5335ad 100644
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
-- 
2.43.0

