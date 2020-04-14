Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502682AbgDNNOa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Apr 2020 09:14:30 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 04/29] staging: media: ipu3: use vmap instead of reimplementing it
Date: Tue, 14 Apr 2020 15:13:23 +0200
Message-Id: <20200414131348.444715-5-hch@lst.de>
In-Reply-To: <20200414131348.444715-1-hch@lst.de>
References: <20200414131348.444715-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, x86@kernel.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Laura Abbott <labbott@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Just use vmap instead of messing with vmalloc internals.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/staging/media/ipu3/ipu3-css-pool.h |  4 +--
 drivers/staging/media/ipu3/ipu3-dmamap.c   | 30 ++++++----------------
 2 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/media/ipu3/ipu3-css-pool.h b/drivers/staging/media/ipu3/ipu3-css-pool.h
index f4a60b41401b..a8ccd4f70320 100644
--- a/drivers/staging/media/ipu3/ipu3-css-pool.h
+++ b/drivers/staging/media/ipu3/ipu3-css-pool.h
@@ -15,14 +15,12 @@ struct imgu_device;
  * @size:		size of the buffer in bytes.
  * @vaddr:		kernel virtual address.
  * @daddr:		iova dma address to access IPU3.
- * @vma:		private, a pointer to &struct vm_struct,
- *			used for imgu_dmamap_free.
  */
 struct imgu_css_map {
 	size_t size;
 	void *vaddr;
 	dma_addr_t daddr;
-	struct vm_struct *vma;
+	struct page **pages;
 };
 
 /**
diff --git a/drivers/staging/media/ipu3/ipu3-dmamap.c b/drivers/staging/media/ipu3/ipu3-dmamap.c
index 7431322379f6..8a19b0024152 100644
--- a/drivers/staging/media/ipu3/ipu3-dmamap.c
+++ b/drivers/staging/media/ipu3/ipu3-dmamap.c
@@ -96,6 +96,7 @@ void *imgu_dmamap_alloc(struct imgu_device *imgu, struct imgu_css_map *map,
 	unsigned long shift = iova_shift(&imgu->iova_domain);
 	struct device *dev = &imgu->pci_dev->dev;
 	size_t size = PAGE_ALIGN(len);
+	int count = size >> PAGE_SHIFT;
 	struct page **pages;
 	dma_addr_t iovaddr;
 	struct iova *iova;
@@ -114,7 +115,7 @@ void *imgu_dmamap_alloc(struct imgu_device *imgu, struct imgu_css_map *map,
 
 	/* Call IOMMU driver to setup pgt */
 	iovaddr = iova_dma_addr(&imgu->iova_domain, iova);
-	for (i = 0; i < size / PAGE_SIZE; ++i) {
+	for (i = 0; i < count; ++i) {
 		rval = imgu_mmu_map(imgu->mmu, iovaddr,
 				    page_to_phys(pages[i]), PAGE_SIZE);
 		if (rval)
@@ -123,33 +124,23 @@ void *imgu_dmamap_alloc(struct imgu_device *imgu, struct imgu_css_map *map,
 		iovaddr += PAGE_SIZE;
 	}
 
-	/* Now grab a virtual region */
-	map->vma = __get_vm_area(size, VM_USERMAP, VMALLOC_START, VMALLOC_END);
-	if (!map->vma)
+	map->vaddr = vmap(pages, count, VM_USERMAP, PAGE_KERNEL);
+	if (!map->vaddr)
 		goto out_unmap;
 
-	map->vma->pages = pages;
-	/* And map it in KVA */
-	if (map_vm_area(map->vma, PAGE_KERNEL, pages))
-		goto out_vunmap;
-
+	map->pages = pages;
 	map->size = size;
 	map->daddr = iova_dma_addr(&imgu->iova_domain, iova);
-	map->vaddr = map->vma->addr;
 
 	dev_dbg(dev, "%s: allocated %zu @ IOVA %pad @ VA %p\n", __func__,
-		size, &map->daddr, map->vma->addr);
-
-	return map->vma->addr;
+		size, &map->daddr, map->vaddr);
 
-out_vunmap:
-	vunmap(map->vma->addr);
+	return map->vaddr;
 
 out_unmap:
 	imgu_dmamap_free_buffer(pages, size);
 	imgu_mmu_unmap(imgu->mmu, iova_dma_addr(&imgu->iova_domain, iova),
 		       i * PAGE_SIZE);
-	map->vma = NULL;
 
 out_free_iova:
 	__free_iova(&imgu->iova_domain, iova);
@@ -177,8 +168,6 @@ void imgu_dmamap_unmap(struct imgu_device *imgu, struct imgu_css_map *map)
  */
 void imgu_dmamap_free(struct imgu_device *imgu, struct imgu_css_map *map)
 {
-	struct vm_struct *area = map->vma;
-
 	dev_dbg(&imgu->pci_dev->dev, "%s: freeing %zu @ IOVA %pad @ VA %p\n",
 		__func__, map->size, &map->daddr, map->vaddr);
 
@@ -187,11 +176,8 @@ void imgu_dmamap_free(struct imgu_device *imgu, struct imgu_css_map *map)
 
 	imgu_dmamap_unmap(imgu, map);
 
-	if (WARN_ON(!area) || WARN_ON(!area->pages))
-		return;
-
-	imgu_dmamap_free_buffer(area->pages, map->size);
 	vunmap(map->vaddr);
+	imgu_dmamap_free_buffer(map->pages, map->size);
 	map->vaddr = NULL;
 }
 
-- 
2.25.1
