Received: from mail.tkos.co.il (wiki.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43072AE7C;
	Fri,  2 Aug 2024 06:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722578644; cv=none; b=OVeIImx19Pq9JvXfioGMfFF8gVFTjqVxoxnA3s//Ij1S0WckXG2/3nlVZEVaIqVM8VEFsj3BJM7ZN3dbQRycluqy3bHRipm8IOSCUvJqBV7Vl9MOpUpna6vUPMYiIdQPVl7pz6F2vnbxHZwWS3BqY3aZUDv23gBHI/4QvyEzv/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722578644; c=relaxed/simple;
	bh=tlbzHOmR+YWKDaXTzmv16+qKQ4GD0RAJ4ZinTP45mfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IxSC5qeqXpEb6dia59vXP8uaYE5vzp7zb7L6x4RJbM6r4X/X80uOV8GMDNxJ+WVtK1ZZEWgXp598xLF6UjwVggzQRcgSSV8VWqUIpehQHGABM574qQUkWhjdkNUUecEjQc4HDJw/OEOViC/2gDHvVkN3/tTxUOJt9I/BkTVFe6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=PVdJ6HN7; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="PVdJ6HN7"
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id DC44044076F;
	Fri,  2 Aug 2024 09:02:39 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1722578560;
	bh=tlbzHOmR+YWKDaXTzmv16+qKQ4GD0RAJ4ZinTP45mfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PVdJ6HN7IdRp5JNz/JWSQbsHA7Kes+j9NmavmBJxup/D6sm2ogXY80y1C/KB7avXj
	 SkRdjoL5b/48Oy6WCSHgAOI8yE5as2VG2jIl6VYVlYoUwaY9mypv9naZkYOeH5wyeS
	 sKwjoJzN5RboMzILkgzKDO3kiQhASSsXwS34IO8aXICKGyxqYBvuvkDlDNipgNUJ1N
	 FW8ZAPPYphA1FdRcqahTJF0A9QSCPOVc+8zsn9zctfLiz5KshTM9sdxDqEH3bpyRMh
	 0029zi5vLHM49PFpTh6qMlQFbgS/+hCxII+XAZEV2vRCaHsT8764cfqVaH0hfMYAFv
	 uJNGkrKR59TZQ==
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
Subject: [PATCH v5 1/3] dma: improve DMA zone selection
Date: Fri,  2 Aug 2024 09:03:46 +0300
Message-ID: <5200f289af1a9b80dfd329b6ed3d54e1d4a02876.1722578375.git.baruch@tkos.co.il>
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

When device DMA limit does not fit in DMA32 zone it should use DMA zone,
even when DMA zone is stricter than needed.

Same goes for devices that can't allocate from the entire normal zone.
Limit to DMA32 in that case.

Reported-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 kernel/dma/direct.c  | 6 +++---
 kernel/dma/swiotlb.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 4480a3cd92e0..3b4be4ca3b08 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -4,7 +4,7 @@
  *
  * DMA operations that map physical memory directly without using an IOMMU.
  */
-#include <linux/memblock.h> /* for max_pfn */
+#include <linux/memblock.h>
 #include <linux/export.h>
 #include <linux/mm.h>
 #include <linux/dma-map-ops.h>
@@ -59,9 +59,9 @@ static gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 *phys_limit)
 	 * zones.
 	 */
 	*phys_limit = dma_to_phys(dev, dma_limit);
-	if (*phys_limit <= DMA_BIT_MASK(zone_dma_bits))
+	if (*phys_limit < DMA_BIT_MASK(32))
 		return GFP_DMA;
-	if (*phys_limit <= DMA_BIT_MASK(32))
+	if (*phys_limit < memblock_end_of_DRAM())
 		return GFP_DMA32;
 	return 0;
 }
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index df68d29740a0..043b0ecd3e8d 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -629,9 +629,9 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
 	}
 
 	gfp &= ~GFP_ZONEMASK;
-	if (phys_limit <= DMA_BIT_MASK(zone_dma_bits))
+	if (phys_limit < DMA_BIT_MASK(32))
 		gfp |= __GFP_DMA;
-	else if (phys_limit <= DMA_BIT_MASK(32))
+	else if (phys_limit < memblock_end_of_DRAM())
 		gfp |= __GFP_DMA32;
 
 	while (IS_ERR(page = alloc_dma_pages(gfp, bytes, phys_limit))) {
-- 
2.43.0

