Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:54198 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729065AbfFNNsk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 14 Jun 2019 09:48:40 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 16/16] dma-mapping: use exact allocation in dma_alloc_contiguous
Date: Fri, 14 Jun 2019 15:47:26 +0200
Message-Id: <20190614134726.3827-17-hch@lst.de>
In-Reply-To: <20190614134726.3827-1-hch@lst.de>
References: <20190614134726.3827-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Ian Abbott <abbotti@mev.co.uk>, H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Intel Linux Wireless <linuxwifi@intel.com>, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-rdma@vger.kernel.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, linux-s390@vger.kernel.org, devel@driverdev.osuosl.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org

Many architectures (e.g. arm, m68 and sh) have always used exact
allocation in their dma coherent allocator, which avoids a lot of
memory waste especially for larger allocations.  Lift this behavior
into the generic allocator so that dma-direct and the generic IOMMU
code benefit from this behavior as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-contiguous.h |  8 +++++---
 kernel/dma/contiguous.c        | 17 +++++++++++------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/include/linux/dma-contiguous.h b/include/linux/dma-contiguous.h
index c05d4e661489..2e542e314acf 100644
--- a/include/linux/dma-contiguous.h
+++ b/include/linux/dma-contiguous.h
@@ -161,15 +161,17 @@ static inline struct page *dma_alloc_contiguous(struct device *dev, size_t size,
 		gfp_t gfp)
 {
 	int node = dev ? dev_to_node(dev) : NUMA_NO_NODE;
-	size_t align = get_order(PAGE_ALIGN(size));
+	void *cpu_addr = alloc_pages_exact_node(node, size, gfp);
 
-	return alloc_pages_node(node, gfp, align);
+	if (!cpu_addr)
+		return NULL;
+	return virt_to_page(p);
 }
 
 static inline void dma_free_contiguous(struct device *dev, struct page *page,
 		size_t size)
 {
-	__free_pages(page, get_order(size));
+	free_pages_exact(page_address(page), get_order(size));
 }
 
 #endif
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index bfc0c17f2a3d..84f41eea2741 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -232,9 +232,8 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
 {
 	int node = dev ? dev_to_node(dev) : NUMA_NO_NODE;
 	size_t count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	size_t align = get_order(PAGE_ALIGN(size));
-	struct page *page = NULL;
 	struct cma *cma = NULL;
+	void *cpu_addr;
 
 	if (dev && dev->cma_area)
 		cma = dev->cma_area;
@@ -243,14 +242,20 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
 
 	/* CMA can be used only in the context which permits sleeping */
 	if (cma && gfpflags_allow_blocking(gfp)) {
+		size_t align = get_order(PAGE_ALIGN(size));
+		struct page *page;
+
 		align = min_t(size_t, align, CONFIG_CMA_ALIGNMENT);
 		page = cma_alloc(cma, count, align, gfp & __GFP_NOWARN);
+		if (page)
+			return page;
 	}
 
 	/* Fallback allocation of normal pages */
-	if (!page)
-		page = alloc_pages_node(node, gfp, align);
-	return page;
+	cpu_addr = alloc_pages_exact_node(node, size, gfp);
+	if (!cpu_addr)
+		return NULL;
+	return virt_to_page(cpu_addr);
 }
 
 /**
@@ -267,7 +272,7 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
 void dma_free_contiguous(struct device *dev, struct page *page, size_t size)
 {
 	if (!cma_release(dev_get_cma_area(dev), page, size >> PAGE_SHIFT))
-		__free_pages(page, get_order(size));
+		free_pages_exact(page_address(page), get_order(size));
 }
 
 /*
-- 
2.20.1
