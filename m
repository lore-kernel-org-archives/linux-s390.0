Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 05/16] drm: don't mark pages returned from drm_pci_alloc reserved
Date: Fri, 14 Jun 2019 15:47:15 +0200
Message-Id: <20190614134726.3827-6-hch@lst.de>
In-Reply-To: <20190614134726.3827-1-hch@lst.de>
References: <20190614134726.3827-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Ian Abbott <abbotti@mev.co.uk>, H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Intel Linux Wireless <linuxwifi@intel.com>, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-rdma@vger.kernel.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, linux-s390@vger.kernel.org, devel@driverdev.osuosl.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org

We are not allowed to call virt_to_page on pages returned from
dma_alloc_coherent, as in many cases the virtual address returned
is aactually a kernel direct mapping.  Also there generally is no
need to mark dma memory as reserved.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/drm_bufs.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/drm_bufs.c b/drivers/gpu/drm/drm_bufs.c
index 7418872d87c6..b640437ce90f 100644
--- a/drivers/gpu/drm/drm_bufs.c
+++ b/drivers/gpu/drm/drm_bufs.c
@@ -77,13 +77,6 @@ drm_dma_handle_t *drm_pci_alloc(struct drm_device * dev, size_t size, size_t ali
 		return NULL;
 	}
 
-	/* XXX - Is virt_to_page() legal for consistent mem? */
-	/* Reserve */
-	for (addr = (unsigned long)dmah->vaddr, sz = size;
-	     sz > 0; addr += PAGE_SIZE, sz -= PAGE_SIZE) {
-		SetPageReserved(virt_to_page((void *)addr));
-	}
-
 	return dmah;
 }
 
@@ -97,16 +90,9 @@ void __drm_legacy_pci_free(struct drm_device * dev, drm_dma_handle_t * dmah)
 	unsigned long addr;
 	size_t sz;
 
-	if (dmah->vaddr) {
-		/* XXX - Is virt_to_page() legal for consistent mem? */
-		/* Unreserve */
-		for (addr = (unsigned long)dmah->vaddr, sz = dmah->size;
-		     sz > 0; addr += PAGE_SIZE, sz -= PAGE_SIZE) {
-			ClearPageReserved(virt_to_page((void *)addr));
-		}
+	if (dmah->vaddr)
 		dma_free_coherent(&dev->pdev->dev, dmah->size, dmah->vaddr,
 				  dmah->busaddr);
-	}
 }
 
 /**
-- 
2.20.1
