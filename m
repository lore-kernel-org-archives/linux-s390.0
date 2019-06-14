Return-Path: <netdev-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 02/16] drm/ati_pcigart: stop using drm_pci_alloc
Date: Fri, 14 Jun 2019 15:47:12 +0200
Message-Id: <20190614134726.3827-3-hch@lst.de>
In-Reply-To: <20190614134726.3827-1-hch@lst.de>
References: <20190614134726.3827-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Ian Abbott <abbotti@mev.co.uk>, H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Intel Linux Wireless <linuxwifi@intel.com>, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-rdma@vger.kernel.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, linux-s390@vger.kernel.org, devel@driverdev.osuosl.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org

Remove usage of the legacy drm PCI DMA wrappers, and with that the
incorrect usage cocktail of __GFP_COMP, virt_to_page on DMA allocation
and SetPageReserved.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/ati_pcigart.c | 27 +++++++++++----------------
 include/drm/ati_pcigart.h     |  5 ++++-
 2 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/ati_pcigart.c b/drivers/gpu/drm/ati_pcigart.c
index 2362f07fe1fc..f66d4fccd812 100644
--- a/drivers/gpu/drm/ati_pcigart.c
+++ b/drivers/gpu/drm/ati_pcigart.c
@@ -41,21 +41,14 @@
 static int drm_ati_alloc_pcigart_table(struct drm_device *dev,
 				       struct drm_ati_pcigart_info *gart_info)
 {
-	gart_info->table_handle = drm_pci_alloc(dev, gart_info->table_size,
-						PAGE_SIZE);
-	if (gart_info->table_handle == NULL)
+	gart_info->table_vaddr = dma_alloc_coherent(&dev->pdev->dev,
+			gart_info->table_size, &gart_info->table_handle,
+			GFP_KERNEL);
+	if (!gart_info->table_vaddr)
 		return -ENOMEM;
-
 	return 0;
 }
 
-static void drm_ati_free_pcigart_table(struct drm_device *dev,
-				       struct drm_ati_pcigart_info *gart_info)
-{
-	drm_pci_free(dev, gart_info->table_handle);
-	gart_info->table_handle = NULL;
-}
-
 int drm_ati_pcigart_cleanup(struct drm_device *dev, struct drm_ati_pcigart_info *gart_info)
 {
 	struct drm_sg_mem *entry = dev->sg;
@@ -87,8 +80,10 @@ int drm_ati_pcigart_cleanup(struct drm_device *dev, struct drm_ati_pcigart_info
 	}
 
 	if (gart_info->gart_table_location == DRM_ATI_GART_MAIN &&
-	    gart_info->table_handle) {
-		drm_ati_free_pcigart_table(dev, gart_info);
+	    gart_info->table_vaddr) {
+		dma_free_coherent(&dev->pdev->dev, gart_info->table_size,
+				gart_info->table_vaddr, gart_info->table_handle);
+		gart_info->table_vaddr = NULL;
 	}
 
 	return 1;
@@ -127,9 +122,9 @@ int drm_ati_pcigart_init(struct drm_device *dev, struct drm_ati_pcigart_info *ga
 			goto done;
 		}
 
-		pci_gart = gart_info->table_handle->vaddr;
-		address = gart_info->table_handle->vaddr;
-		bus_address = gart_info->table_handle->busaddr;
+		pci_gart = gart_info->table_vaddr;
+		address = gart_info->table_vaddr;
+		bus_address = gart_info->table_handle;
 	} else {
 		address = gart_info->addr;
 		bus_address = gart_info->bus_addr;
diff --git a/include/drm/ati_pcigart.h b/include/drm/ati_pcigart.h
index a728a1364e66..2ffe278ba3b3 100644
--- a/include/drm/ati_pcigart.h
+++ b/include/drm/ati_pcigart.h
@@ -18,7 +18,10 @@ struct drm_ati_pcigart_info {
 	void *addr;
 	dma_addr_t bus_addr;
 	dma_addr_t table_mask;
-	struct drm_dma_handle *table_handle;
+
+	dma_addr_t table_handle;
+	void *table_vaddr;
+
 	struct drm_local_map mapping;
 	int table_size;
 };
-- 
2.20.1
