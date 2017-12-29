Return-Path: <linux-arch-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 27/67] dma-direct: add dma address sanity checks
Date: Fri, 29 Dec 2017 09:18:31 +0100
Message-ID: <20171229081911.2802-28-hch@lst.de>
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20171229081831.Sex8FtGfM4wtDczSELnixmmawwT13u1TIkM_4cGixEo@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: iommu@lists.linux-foundation.org
Cc: linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Roughly based on the x86 pci-nommu implementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/dma-direct.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/lib/dma-direct.c b/lib/dma-direct.c
index 0e087650e86b..ddd9dcf4e663 100644
--- a/lib/dma-direct.c
+++ b/lib/dma-direct.c
@@ -9,6 +9,24 @@
 #include <linux/scatterlist.h>
 #include <linux/pfn.h>
 
+#define DIRECT_MAPPING_ERROR		0
+
+static bool
+check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
+		const char *caller)
+{
+	if (unlikely(dev && !dma_capable(dev, dma_addr, size))) {
+		if (*dev->dma_mask >= DMA_BIT_MASK(32)) {
+			dev_err(dev,
+				"%s: overflow %llx+%zu of device mask %llx\n",
+				caller, (long long)dma_addr, size,
+				(long long)*dev->dma_mask);
+		}
+		return false;
+	}
+	return true;
+}
+
 static void *dma_direct_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
@@ -31,7 +49,11 @@ static dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, enum dma_data_direction dir,
 		unsigned long attrs)
 {
-	return phys_to_dma(dev, page_to_phys(page)) + offset;
+	dma_addr_t dma_addr = phys_to_dma(dev, page_to_phys(page)) + offset;
+
+	if (!check_addr(dev, dma_addr, size, __func__))
+		return DIRECT_MAPPING_ERROR;
+	return dma_addr;
 }
 
 static int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl,
@@ -44,17 +66,25 @@ static int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl,
 		BUG_ON(!sg_page(sg));
 
 		sg_dma_address(sg) = phys_to_dma(dev, sg_phys(sg));
+		if (!check_addr(dev, sg_dma_address(sg), sg->length, __func__))
+			return 0;
 		sg_dma_len(sg) = sg->length;
 	}
 
 	return nents;
 }
 
+static int dma_direct_mapping_error(struct device *dev, dma_addr_t dma_addr)
+{
+	return dma_addr == DIRECT_MAPPING_ERROR;
+}
+
 const struct dma_map_ops dma_direct_ops = {
 	.alloc			= dma_direct_alloc,
 	.free			= dma_direct_free,
 	.map_page		= dma_direct_map_page,
 	.map_sg			= dma_direct_map_sg,
+	.mapping_error		= dma_direct_mapping_error,
 	.is_phys		= true,
 };
 EXPORT_SYMBOL(dma_direct_ops);
-- 
2.14.2
