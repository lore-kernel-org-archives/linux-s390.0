From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/2] dma-mapping: deprecate dma_zalloc_coherent
Date: Fri, 14 Dec 2018 09:25:15 +0100
Message-ID: <20181214082515.14835-3-hch@lst.de>
References: <20181214082515.14835-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181214082515.14835-1-hch@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
To: iommu@lists.linux-foundation.org
Cc: linux-s390@vger.kernel.org, Michal Simek <monstr@monstr.eu>, linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org, Ashutosh Dixit <ashutosh.dixit@intel.com>, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org
List-ID: <linux-s390.vger.kernel.org>

We now always return zeroed memory from dma_alloc_coherent.  Note that
simply passing GFP_ZERO to dma_alloc_coherent wasn't always doing the
right thing to start with given that various allocators are not backed
by the page allocator and thus would ignore GFP_ZERO.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/DMA-API.txt   | 9 ---------
 include/linux/dma-mapping.h | 7 ++++---
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
index 016eb6909b8a..e133ccd60228 100644
--- a/Documentation/DMA-API.txt
+++ b/Documentation/DMA-API.txt
@@ -58,15 +58,6 @@ specify the ``GFP_`` flags (see kmalloc()) for the allocation (the
 implementation may choose to ignore flags that affect the location of
 the returned memory, like GFP_DMA).
 
-::
-
-	void *
-	dma_zalloc_coherent(struct device *dev, size_t size,
-			    dma_addr_t *dma_handle, gfp_t flag)
-
-Wraps dma_alloc_coherent() and also zeroes the returned memory if the
-allocation attempt succeeded.
-
 ::
 
 	void
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f422aec0f53c..a52c6409bdc2 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -644,12 +644,13 @@ static inline unsigned long dma_max_pfn(struct device *dev)
 }
 #endif
 
+/*
+ * Please always use dma_alloc_coherent instead as it already zeroes the memory!
+ */
 static inline void *dma_zalloc_coherent(struct device *dev, size_t size,
 					dma_addr_t *dma_handle, gfp_t flag)
 {
-	void *ret = dma_alloc_coherent(dev, size, dma_handle,
-				       flag | __GFP_ZERO);
-	return ret;
+	return dma_alloc_coherent(dev, size, dma_handle, flag);
 }
 
 static inline int dma_get_cache_alignment(void)
-- 
2.19.2
