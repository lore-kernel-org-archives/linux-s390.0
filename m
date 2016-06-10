Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v4 37/44] s390: dma-mapping: Use unsigned long for dma_attrs
Date: Fri, 10 Jun 2016 12:11:54 +0200
Message-id: <1465553521-27303-38-git-send-email-k.kozlowski@samsung.com>
In-reply-to: <1465553521-27303-1-git-send-email-k.kozlowski@samsung.com>
References: <1465553521-27303-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: hch@infradead.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Max Filippov <jcmvbkbc@gmail.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Split out subsystem specific changes for easier reviews. This will be
squashed with main commit.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
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
index 1ea8c07eab84..159f767f9011 100644
--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -285,7 +285,7 @@ static inline void zpci_err_dma(unsigned long rc, unsigned long addr)
 static dma_addr_t s390_dma_map_pages(struct device *dev, struct page *page,
 				     unsigned long offset, size_t size,
 				     enum dma_data_direction direction,
-				     struct dma_attrs *attrs)
+				     unsigned long attrs)
 {
 	struct zpci_dev *zdev = to_zpci(to_pci_dev(dev));
 	unsigned long nr_pages, iommu_page_index;
@@ -331,7 +331,7 @@ out_err:
 
 static void s390_dma_unmap_pages(struct device *dev, dma_addr_t dma_addr,
 				 size_t size, enum dma_data_direction direction,
-				 struct dma_attrs *attrs)
+				 unsigned long attrs)
 {
 	struct zpci_dev *zdev = to_zpci(to_pci_dev(dev));
 	unsigned long iommu_page_index;
@@ -354,7 +354,7 @@ static void s390_dma_unmap_pages(struct device *dev, dma_addr_t dma_addr,
 
 static void *s390_dma_alloc(struct device *dev, size_t size,
 			    dma_addr_t *dma_handle, gfp_t flag,
-			    struct dma_attrs *attrs)
+			    unsigned long attrs)
 {
 	struct zpci_dev *zdev = to_zpci(to_pci_dev(dev));
 	struct page *page;
@@ -369,7 +369,7 @@ static void *s390_dma_alloc(struct device *dev, size_t size,
 	pa = page_to_phys(page);
 	memset((void *) pa, 0, size);
 
-	map = s390_dma_map_pages(dev, page, 0, size, DMA_BIDIRECTIONAL, NULL);
+	map = s390_dma_map_pages(dev, page, 0, size, DMA_BIDIRECTIONAL, 0);
 	if (dma_mapping_error(dev, map)) {
 		free_pages(pa, get_order(size));
 		return NULL;
@@ -383,19 +383,19 @@ static void *s390_dma_alloc(struct device *dev, size_t size,
 
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
@@ -404,7 +404,7 @@ static int s390_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	for_each_sg(sg, s, nr_elements, i) {
 		struct page *page = sg_page(s);
 		s->dma_address = s390_dma_map_pages(dev, page, s->offset,
-						    s->length, dir, NULL);
+						    s->length, dir, 0);
 		if (!dma_mapping_error(dev, s->dma_address)) {
 			s->dma_length = s->length;
 			mapped_elements++;
@@ -418,7 +418,7 @@ unmap:
 	for_each_sg(sg, s, mapped_elements, i) {
 		if (s->dma_address)
 			s390_dma_unmap_pages(dev, s->dma_address, s->dma_length,
-					     dir, NULL);
+					     dir, 0);
 		s->dma_address = 0;
 		s->dma_length = 0;
 	}
@@ -428,13 +428,14 @@ unmap:
 
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
