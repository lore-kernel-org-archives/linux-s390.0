Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 04/16] drm: move drm_pci_{alloc,free} to drm_legacy
Date: Fri, 14 Jun 2019 15:47:14 +0200
Message-Id: <20190614134726.3827-5-hch@lst.de>
In-Reply-To: <20190614134726.3827-1-hch@lst.de>
References: <20190614134726.3827-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Ian Abbott <abbotti@mev.co.uk>, H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Intel Linux Wireless <linuxwifi@intel.com>, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-rdma@vger.kernel.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, linux-s390@vger.kernel.org, devel@driverdev.osuosl.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org

These functions are rather broken in that they try to pass __GFP_COMP
to dma_alloc_coherent, call virt_to_page on the return value and
mess with PageReserved.  And not actually used by any modern driver.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/drm_bufs.c | 85 ++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_pci.c  | 89 --------------------------------------
 2 files changed, 85 insertions(+), 89 deletions(-)

diff --git a/drivers/gpu/drm/drm_bufs.c b/drivers/gpu/drm/drm_bufs.c
index bfc419ed9d6c..7418872d87c6 100644
--- a/drivers/gpu/drm/drm_bufs.c
+++ b/drivers/gpu/drm/drm_bufs.c
@@ -38,6 +38,91 @@
 
 #include <linux/nospec.h>
 
+/**
+ * drm_pci_alloc - Allocate a PCI consistent memory block, for DMA.
+ * @dev: DRM device
+ * @size: size of block to allocate
+ * @align: alignment of block
+ *
+ * FIXME: This is a needless abstraction of the Linux dma-api and should be
+ * removed.
+ *
+ * Return: A handle to the allocated memory block on success or NULL on
+ * failure.
+ */
+drm_dma_handle_t *drm_pci_alloc(struct drm_device * dev, size_t size, size_t align)
+{
+	drm_dma_handle_t *dmah;
+	unsigned long addr;
+	size_t sz;
+
+	/* pci_alloc_consistent only guarantees alignment to the smallest
+	 * PAGE_SIZE order which is greater than or equal to the requested size.
+	 * Return NULL here for now to make sure nobody tries for larger alignment
+	 */
+	if (align > size)
+		return NULL;
+
+	dmah = kmalloc(sizeof(drm_dma_handle_t), GFP_KERNEL);
+	if (!dmah)
+		return NULL;
+
+	dmah->size = size;
+	dmah->vaddr = dma_alloc_coherent(&dev->pdev->dev, size,
+					 &dmah->busaddr,
+					 GFP_KERNEL | __GFP_COMP);
+
+	if (dmah->vaddr == NULL) {
+		kfree(dmah);
+		return NULL;
+	}
+
+	/* XXX - Is virt_to_page() legal for consistent mem? */
+	/* Reserve */
+	for (addr = (unsigned long)dmah->vaddr, sz = size;
+	     sz > 0; addr += PAGE_SIZE, sz -= PAGE_SIZE) {
+		SetPageReserved(virt_to_page((void *)addr));
+	}
+
+	return dmah;
+}
+
+/*
+ * Free a PCI consistent memory block without freeing its descriptor.
+ *
+ * This function is for internal use in the Linux-specific DRM core code.
+ */
+void __drm_legacy_pci_free(struct drm_device * dev, drm_dma_handle_t * dmah)
+{
+	unsigned long addr;
+	size_t sz;
+
+	if (dmah->vaddr) {
+		/* XXX - Is virt_to_page() legal for consistent mem? */
+		/* Unreserve */
+		for (addr = (unsigned long)dmah->vaddr, sz = dmah->size;
+		     sz > 0; addr += PAGE_SIZE, sz -= PAGE_SIZE) {
+			ClearPageReserved(virt_to_page((void *)addr));
+		}
+		dma_free_coherent(&dev->pdev->dev, dmah->size, dmah->vaddr,
+				  dmah->busaddr);
+	}
+}
+
+/**
+ * drm_pci_free - Free a PCI consistent memory block
+ * @dev: DRM device
+ * @dmah: handle to memory block
+ *
+ * FIXME: This is a needless abstraction of the Linux dma-api and should be
+ * removed.
+ */
+void drm_pci_free(struct drm_device * dev, drm_dma_handle_t * dmah)
+{
+	__drm_legacy_pci_free(dev, dmah);
+	kfree(dmah);
+}
+
 static struct drm_map_list *drm_find_matching_map(struct drm_device *dev,
 						  struct drm_local_map *map)
 {
diff --git a/drivers/gpu/drm/drm_pci.c b/drivers/gpu/drm/drm_pci.c
index 693748ad8b88..77a215f2a8e4 100644
--- a/drivers/gpu/drm/drm_pci.c
+++ b/drivers/gpu/drm/drm_pci.c
@@ -31,95 +31,6 @@
 #include "drm_internal.h"
 #include "drm_legacy.h"
 
-/**
- * drm_pci_alloc - Allocate a PCI consistent memory block, for DMA.
- * @dev: DRM device
- * @size: size of block to allocate
- * @align: alignment of block
- *
- * FIXME: This is a needless abstraction of the Linux dma-api and should be
- * removed.
- *
- * Return: A handle to the allocated memory block on success or NULL on
- * failure.
- */
-drm_dma_handle_t *drm_pci_alloc(struct drm_device * dev, size_t size, size_t align)
-{
-	drm_dma_handle_t *dmah;
-	unsigned long addr;
-	size_t sz;
-
-	/* pci_alloc_consistent only guarantees alignment to the smallest
-	 * PAGE_SIZE order which is greater than or equal to the requested size.
-	 * Return NULL here for now to make sure nobody tries for larger alignment
-	 */
-	if (align > size)
-		return NULL;
-
-	dmah = kmalloc(sizeof(drm_dma_handle_t), GFP_KERNEL);
-	if (!dmah)
-		return NULL;
-
-	dmah->size = size;
-	dmah->vaddr = dma_alloc_coherent(&dev->pdev->dev, size,
-					 &dmah->busaddr,
-					 GFP_KERNEL | __GFP_COMP);
-
-	if (dmah->vaddr == NULL) {
-		kfree(dmah);
-		return NULL;
-	}
-
-	/* XXX - Is virt_to_page() legal for consistent mem? */
-	/* Reserve */
-	for (addr = (unsigned long)dmah->vaddr, sz = size;
-	     sz > 0; addr += PAGE_SIZE, sz -= PAGE_SIZE) {
-		SetPageReserved(virt_to_page((void *)addr));
-	}
-
-	return dmah;
-}
-
-EXPORT_SYMBOL(drm_pci_alloc);
-
-/*
- * Free a PCI consistent memory block without freeing its descriptor.
- *
- * This function is for internal use in the Linux-specific DRM core code.
- */
-void __drm_legacy_pci_free(struct drm_device * dev, drm_dma_handle_t * dmah)
-{
-	unsigned long addr;
-	size_t sz;
-
-	if (dmah->vaddr) {
-		/* XXX - Is virt_to_page() legal for consistent mem? */
-		/* Unreserve */
-		for (addr = (unsigned long)dmah->vaddr, sz = dmah->size;
-		     sz > 0; addr += PAGE_SIZE, sz -= PAGE_SIZE) {
-			ClearPageReserved(virt_to_page((void *)addr));
-		}
-		dma_free_coherent(&dev->pdev->dev, dmah->size, dmah->vaddr,
-				  dmah->busaddr);
-	}
-}
-
-/**
- * drm_pci_free - Free a PCI consistent memory block
- * @dev: DRM device
- * @dmah: handle to memory block
- *
- * FIXME: This is a needless abstraction of the Linux dma-api and should be
- * removed.
- */
-void drm_pci_free(struct drm_device * dev, drm_dma_handle_t * dmah)
-{
-	__drm_legacy_pci_free(dev, dmah);
-	kfree(dmah);
-}
-
-EXPORT_SYMBOL(drm_pci_free);
-
 #ifdef CONFIG_PCI
 
 static int drm_get_pci_domain(struct drm_device *dev)
-- 
2.20.1
