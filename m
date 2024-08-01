Received: from mail.tkos.co.il (golan.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72C216C85D;
	Thu,  1 Aug 2024 08:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722500737; cv=none; b=uD+tJS/hoMdXQxk7tPy6LGjo8sOveDfnOFDRyzYg1Fb5pvMnZC91Duv9ROCYMAF63OsCg3lv2E0wJPi+L4jzBTnQC+rAO6iKlEC2YUPnI9wdnOXwUkvrKhSRzduWb/MKaiyEaSsSpYpJH4PZbESgob7g01ciOajEnFoKEA1rmUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722500737; c=relaxed/simple;
	bh=Yaa82cqvK/7ZFcSlM9y57cf/s6CJpTcrZlbQ2R51MpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrDTaKKmS9LpwyaZpBVa+yPoAJzHi9oIgAIRMeiJaKpMmiW4uNqK9/k1OqZaOTEIQwUpzBMI22UC9CCRWK8wpy+lh957VnPSLDK7ba5tQB7+lmmRGUx54alAo4rPCb1AGhsiHkWKRqWue/COheHZNBnpiA1QJCHNm1sJ4wHkJTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=HFyQUvTl; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="HFyQUvTl"
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 864ED440932;
	Thu,  1 Aug 2024 11:24:07 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1722500648;
	bh=Yaa82cqvK/7ZFcSlM9y57cf/s6CJpTcrZlbQ2R51MpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HFyQUvTlTTY/eVqJOchHKkcdrdrGmNohf9og26uXHRe5MRgamACVy6P1EEO1MVAh1
	 II0T6z3ntd4j4LJPyPrQjkGF+KVwjbHDj6f1p31XD7ZDg4siEAAlAqy90hAE3AOKEQ
	 kfDZc6BxfUE3DB1Ze04ejUdK82dx8Wuu01nPg3VFnD2z6gBadmBRwLLlR4AEFA8JPV
	 FRAiKSo0+y6o3FQTn67gC63CII16EWCV7sAwsaCZfaXA6F0NrmAOJc7xQLK8POsxo0
	 aoykzw5fl8o8QJh5LduEATALVyA6vathNBxOzfVlGDILkvJmQOO8u8pCpXR56wm8Tt
	 VHJdGhIcLRSPQ==
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
Subject: [PATCH v4 1/2] dma: improve DMA zone selection
Date: Thu,  1 Aug 2024 11:25:06 +0300
Message-ID: <f8f4da7ea3ead153ca21e628ca90e24fd0e7206e.1722499975.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722499975.git.baruch@tkos.co.il>
References: <cover.1722499975.git.baruch@tkos.co.il>
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

