Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:53850 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbfFNNsf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 14 Jun 2019 09:48:35 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 13/16] mm: rename alloc_pages_exact_nid to alloc_pages_exact_node
Date: Fri, 14 Jun 2019 15:47:23 +0200
Message-Id: <20190614134726.3827-14-hch@lst.de>
In-Reply-To: <20190614134726.3827-1-hch@lst.de>
References: <20190614134726.3827-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Ian Abbott <abbotti@mev.co.uk>, H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Intel Linux Wireless <linuxwifi@intel.com>, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-rdma@vger.kernel.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, linux-s390@vger.kernel.org, devel@driverdev.osuosl.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org

This fits in with the naming scheme used by alloc_pages_node.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/gfp.h | 2 +-
 mm/page_alloc.c     | 4 ++--
 mm/page_ext.c       | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index fb07b503dc45..4274ea6bc72b 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -532,7 +532,7 @@ extern unsigned long get_zeroed_page(gfp_t gfp_mask);
 
 void *alloc_pages_exact(size_t size, gfp_t gfp_mask);
 void free_pages_exact(void *virt, size_t size);
-void * __meminit alloc_pages_exact_nid(int nid, size_t size, gfp_t gfp_mask);
+void * __meminit alloc_pages_exact_node(int nid, size_t size, gfp_t gfp_mask);
 
 #define __get_free_page(gfp_mask) \
 		__get_free_pages((gfp_mask), 0)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d66bc8abe0af..dd2fed66b656 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4888,7 +4888,7 @@ void *alloc_pages_exact(size_t size, gfp_t gfp_mask)
 EXPORT_SYMBOL(alloc_pages_exact);
 
 /**
- * alloc_pages_exact_nid - allocate an exact number of physically-contiguous
+ * alloc_pages_exact_node - allocate an exact number of physically-contiguous
  *			   pages on a node.
  * @nid: the preferred node ID where memory should be allocated
  * @size: the number of bytes to allocate
@@ -4899,7 +4899,7 @@ EXPORT_SYMBOL(alloc_pages_exact);
  *
  * Return: pointer to the allocated area or %NULL in case of error.
  */
-void * __meminit alloc_pages_exact_nid(int nid, size_t size, gfp_t gfp_mask)
+void * __meminit alloc_pages_exact_node(int nid, size_t size, gfp_t gfp_mask)
 {
 	unsigned int order = get_order(size);
 	struct page *p;
diff --git a/mm/page_ext.c b/mm/page_ext.c
index d8f1aca4ad43..bca6bb316714 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -215,7 +215,7 @@ static void *__meminit alloc_page_ext(size_t size, int nid)
 	gfp_t flags = GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN;
 	void *addr = NULL;
 
-	addr = alloc_pages_exact_nid(nid, size, flags);
+	addr = alloc_pages_exact_node(nid, size, flags);
 	if (addr) {
 		kmemleak_alloc(addr, size, 1, flags);
 		return addr;
-- 
2.20.1
