Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v6 38/46] s390: dma-mapping: Use unsigned long for dma_attrs
Date: Wed, 13 Jul 2016 10:41:29 +0200
Message-id: <1468399300-5399-38-git-send-email-k.kozlowski@samsung.com>
In-reply-to: <1468399300-5399-37-git-send-email-k.kozlowski@samsung.com>
References: <1468399167-28083-1-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-1-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-2-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-3-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-4-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-5-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-6-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-7-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-8-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-9-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-10-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-11-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-12-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-13-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-14-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-15-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-16-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-17-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-18-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-19-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-20-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-21-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-22-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-23-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-24-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-25-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-26-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-27-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-28-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-29-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-30-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-31-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-32-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-33-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-34-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-35-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-36-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-37-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, hch@infradead.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Split out subsystem specific changes for easier reviews. This will be
squashed with main commit.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
[for s390]
Acked-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
---
 arch/s390/include/asm/dma-mapping.h |  1 -
 arch/s390/pci/pci_dma.c             | 23 ++++++++++++-----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/s390/include/asm/dma-mapping.h b/arch/s390/include/asm/dma-mapping.h
index 3249b7464889..ffaba07f50ab 100644
--- a/arch/s390/include/asm/dma-mapping.h
+++ b/arch/s390/include/asm/dma-mapping.h
@@ -5,7 +5,6 @@
 #include <linux/types.h>
 #include <linux/mm.h>
 #include <linux/scatterlist.h>
-#include <linux/dma-attrs.h>
 #include <linux/dma-debug.h>
 #include <linux/io.h>
 
diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
index 070f1ae5cfad..7297fce9bf80 100644
--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -286,7 +286,7 @@ static inline void zpci_err_dma(unsigned long rc, unsigned long addr)
 static dma_addr_t s390_dma_map_pages(struct device *dev, struct page *page,
 				     unsigned long offset, size_t size,
 				     enum dma_data_direction direction,
-				     struct dma_attrs *attrs)
+				     unsigned long attrs)
 {
 	struct zpci_dev *zdev = to_zpci(to_pci_dev(dev));
 	unsigned long nr_pages, iommu_page_index;
@@ -332,7 +332,7 @@ out_err:
 
 static void s390_dma_unmap_pages(struct device *dev, dma_addr_t dma_addr,
 				 size_t size, enum dma_data_direction direction,
-				 struct dma_attrs *attrs)
+				 unsigned long attrs)
 {
 	struct zpci_dev *zdev = to_zpci(to_pci_dev(dev));
 	unsigned long iommu_page_index;
@@ -355,7 +355,7 @@ static void s390_dma_unmap_pages(struct device *dev, dma_addr_t dma_addr,
 
 static void *s390_dma_alloc(struct device *dev, size_t size,
 			    dma_addr_t *dma_handle, gfp_t flag,
-			    struct dma_attrs *attrs)
+			    unsigned long attrs)
 {
 	struct zpci_dev *zdev = to_zpci(to_pci_dev(dev));
 	struct page *page;
@@ -370,7 +370,7 @@ static void *s390_dma_alloc(struct device *dev, size_t size,
 	pa = page_to_phys(page);
 	memset((void *) pa, 0, size);
 
-	map = s390_dma_map_pages(dev, page, 0, size, DMA_BIDIRECTIONAL, NULL);
+	map = s390_dma_map_pages(dev, page, 0, size, DMA_BIDIRECTIONAL, 0);
 	if (dma_mapping_error(dev, map)) {
 		free_pages(pa, get_order(size));
 		return NULL;
@@ -384,19 +384,19 @@ static void *s390_dma_alloc(struct device *dev, size_t size,
 
 static void s390_dma_free(struct device *dev, size_t size,
 			  void *pa, dma_addr_t dma_handle,
-			  struct dma_attrs *attrs)
+			  unsigned long attrs)
 {
 	struct zpci_dev *zdev = to_zpci(to_pci_dev(dev));
 
 	size = PAGE_ALIGN(size);
 	atomic64_sub(size / PAGE_SIZE, &zdev->allocated_pages);
-	s390_dma_unmap_pages(dev, dma_handle, size, DMA_BIDIRECTIONAL, NULL);
+	s390_dma_unmap_pages(dev, dma_handle, size, DMA_BIDIRECTIONAL, 0);
 	free_pages((unsigned long) pa, get_order(size));
 }
 
 static int s390_dma_map_sg(struct device *dev, struct scatterlist *sg,
 			   int nr_elements, enum dma_data_direction dir,
-			   struct dma_attrs *attrs)
+			   unsigned long attrs)
 {
 	int mapped_elements = 0;
 	struct scatterlist *s;
@@ -405,7 +405,7 @@ static int s390_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	for_each_sg(sg, s, nr_elements, i) {
 		struct page *page = sg_page(s);
 		s->dma_address = s390_dma_map_pages(dev, page, s->offset,
-						    s->length, dir, NULL);
+						    s->length, dir, 0);
 		if (!dma_mapping_error(dev, s->dma_address)) {
 			s->dma_length = s->length;
 			mapped_elements++;
@@ -419,7 +419,7 @@ unmap:
 	for_each_sg(sg, s, mapped_elements, i) {
 		if (s->dma_address)
 			s390_dma_unmap_pages(dev, s->dma_address, s->dma_length,
-					     dir, NULL);
+					     dir, 0);
 		s->dma_address = 0;
 		s->dma_length = 0;
 	}
@@ -429,13 +429,14 @@ unmap:
 
 static void s390_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 			      int nr_elements, enum dma_data_direction dir,
-			      struct dma_attrs *attrs)
+			      unsigned long attrs)
 {
 	struct scatterlist *s;
 	int i;
 
 	for_each_sg(sg, s, nr_elements, i) {
-		s390_dma_unmap_pages(dev, s->dma_address, s->dma_length, dir, NULL);
+		s390_dma_unmap_pages(dev, s->dma_address, s->dma_length, dir,
+				     0);
 		s->dma_address = 0;
 		s->dma_length = 0;
 	}
-- 
1.9.1
