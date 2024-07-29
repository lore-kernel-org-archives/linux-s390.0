Received: from mail.tkos.co.il (mail.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7EB1448F1;
	Mon, 29 Jul 2024 10:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722250320; cv=none; b=bp/B04RDxjQeMlU6obJXuo7Q5bc8ggaK+UiTYWnOcZfVfogtBHjn3PbjwQUcJr0Rskd1TZqYCEWGk+C6LnKHi4FLEBilJcbfD6ZAD/t1xabUnXCw/OO++kIATOYUILH0zGfmyACfhjBPlf9UKR+iDbaodPEJjcDeOOYMRZo8gvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722250320; c=relaxed/simple;
	bh=jwVrNkJU6TTXZr03Aq1yS4EYBFAKJQ5ZGtsXERqr5z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qyJp5CIA932iDjU3XqM4JFxoyBF0wQaBZgneA33ntXRhzjfOI0Htbgu+E1elRSumfxBE7AVJ8y8DElD3kgmq35SRQ7u3CxCMAcYYAqQf2spc6kMLXKKd3+qnnaT6/bJ1UiZHympxc1tXqi2oiuR90H/hAzyD4JB3bMufqGeP4gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=vBf0lRuB; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="vBf0lRuB"
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 29561440F5F;
	Mon, 29 Jul 2024 13:50:33 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1722250233;
	bh=jwVrNkJU6TTXZr03Aq1yS4EYBFAKJQ5ZGtsXERqr5z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vBf0lRuBpzD9o62Xp531a74Gq1NOBiZZUSIxG/oPDdoC8/1xjDtYtq/akdkDcE0kj
	 D1/LaqCflZE12HPEnrCkolPF8KvnZtr0KrWCTKoSR/xXowyJXF3UOmXUIhLeKQV+o1
	 DIHAXmMYS3wurN++0F2Ju5m35D+DKYCAgyT5xBmceFFbv2mGTM4Ju+wr8gnSO79YxY
	 /GvtYpbvpKizJHES0JaD2aqYkam5SjvYosOTgWeHXdlvH1I8p3GU3NQ2+uxTWff2bQ
	 uF95ALYYrb+0bwo2KdyQGoaHC7xT0IU01q0mAmBI5/zLflThrleJzDthkYSfLQq70b
	 sxZH+zJqWlzmA==
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
Subject: [PATCH v3 3/3] dma-direct: use RAM start to offset zone_dma_limit
Date: Mon, 29 Jul 2024 13:51:26 +0300
Message-ID: <629b184354fa22cb32a90bd1fa0e1dc258251f81.1722249878.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722249878.git.baruch@tkos.co.il>
References: <cover.1722249878.git.baruch@tkos.co.il>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current code using zone_dma_limit assume that all address range below
limit is suitable for DMA. For some existing platforms this assumption
is not correct. DMA range might have non zero lower limit.

Commit 791ab8b2e3db ("arm64: Ignore any DMA offsets in the
max_zone_phys() calculation") made DMA/DMA32 zones span the entire RAM
when RAM starts above 32-bits. This breaks hardware with DMA area that
start above 32-bits. But the commit log says that "we haven't noticed
any such hardware". It turns out that such hardware does exist.

One such platform has RAM starting at 32GB with an internal bus that has
the following DMA limits:

  #address-cells = <2>;
  #size-cells = <2>;
  dma-ranges = <0x00 0xc0000000 0x08 0x00000000 0x00 0x40000000>;

Devices under this bus can see 1GB of DMA range between 3GB-4GB in each
device address space. This range is mapped to CPU memory at 32GB-33GB.
With current code DMA allocations for devices under this bus are not
limited to DMA area, leading to run-time allocation failure.

Add start of RAM address to zone_dma_limit to make DMA allocation for
constrained devices possible.

The result is DMA zone that properly reflects the hardware constraints
as follows:

[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000800000000-0x000000083fffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000840000000-0x0000000bffffffff]

Rename the dma_direct_supported() local 'min_mask' variable to better
describe its use as limit.

Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 kernel/dma/direct.c  | 7 ++++---
 kernel/dma/pool.c    | 3 ++-
 kernel/dma/swiotlb.c | 4 ++--
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 3dbc0b89d6fb..bd7972d3b101 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -563,7 +563,7 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
 
 int dma_direct_supported(struct device *dev, u64 mask)
 {
-	u64 min_mask = (max_pfn - 1) << PAGE_SHIFT;
+	u64 min_limit = (max_pfn - 1) << PAGE_SHIFT;
 
 	/*
 	 * Because 32-bit DMA masks are so common we expect every architecture
@@ -580,8 +580,9 @@ int dma_direct_supported(struct device *dev, u64 mask)
 	 * part of the check.
 	 */
 	if (IS_ENABLED(CONFIG_ZONE_DMA))
-		min_mask = min_t(u64, min_mask, zone_dma_limit);
-	return mask >= phys_to_dma_unencrypted(dev, min_mask);
+		min_limit = min_t(u64, min_limit,
+				memblock_start_of_DRAM() + zone_dma_limit);
+	return mask >= phys_to_dma_unencrypted(dev, min_limit);
 }
 
 /*
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 410a7b40e496..ded3d841c88c 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -12,6 +12,7 @@
 #include <linux/set_memory.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
+#include <linux/memblock.h>
 
 static struct gen_pool *atomic_pool_dma __ro_after_init;
 static unsigned long pool_size_dma;
@@ -70,7 +71,7 @@ static bool cma_in_zone(gfp_t gfp)
 	/* CMA can't cross zone boundaries, see cma_activate_area() */
 	end = cma_get_base(cma) + size - 1;
 	if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp & GFP_DMA))
-		return end <= zone_dma_limit;
+		return end <= memblock_start_of_DRAM() + zone_dma_limit;
 	if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32))
 		return end <= DMA_BIT_MASK(32);
 	return true;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index dfd83e5ee0b3..2813eeb8b375 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -450,7 +450,7 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 	if (!remap)
 		io_tlb_default_mem.can_grow = true;
 	if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp_mask & __GFP_DMA))
-		io_tlb_default_mem.phys_limit = zone_dma_limit;
+		io_tlb_default_mem.phys_limit = memblock_start_of_DRAM() + zone_dma_limit;
 	else if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp_mask & __GFP_DMA32))
 		io_tlb_default_mem.phys_limit = DMA_BIT_MASK(32);
 	else
@@ -629,7 +629,7 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
 	}
 
 	gfp &= ~GFP_ZONEMASK;
-	if (phys_limit <= zone_dma_limit)
+	if (phys_limit <= memblock_start_of_DRAM() + zone_dma_limit)
 		gfp |= __GFP_DMA;
 	else if (phys_limit <= DMA_BIT_MASK(32))
 		gfp |= __GFP_DMA32;
-- 
2.43.0

