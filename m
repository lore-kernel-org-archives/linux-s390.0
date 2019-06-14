Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:54062 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbfFNNsj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 14 Jun 2019 09:48:39 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 14/16] mm: use alloc_pages_exact_node to implement alloc_pages_exact
Date: Fri, 14 Jun 2019 15:47:24 +0200
Message-Id: <20190614134726.3827-15-hch@lst.de>
In-Reply-To: <20190614134726.3827-1-hch@lst.de>
References: <20190614134726.3827-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Ian Abbott <abbotti@mev.co.uk>, H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Intel Linux Wireless <linuxwifi@intel.com>, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-rdma@vger.kernel.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, linux-s390@vger.kernel.org, devel@driverdev.osuosl.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org

No need to duplicate the logic over two functions that are almost the
same.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/gfp.h |  5 +++--
 mm/page_alloc.c     | 39 +++++++--------------------------------
 2 files changed, 10 insertions(+), 34 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 4274ea6bc72b..c616a23a3f81 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -530,9 +530,10 @@ extern struct page *alloc_pages_vma(gfp_t gfp_mask, int order,
 extern unsigned long __get_free_pages(gfp_t gfp_mask, unsigned int order);
 extern unsigned long get_zeroed_page(gfp_t gfp_mask);
 
-void *alloc_pages_exact(size_t size, gfp_t gfp_mask);
 void free_pages_exact(void *virt, size_t size);
-void * __meminit alloc_pages_exact_node(int nid, size_t size, gfp_t gfp_mask);
+void *alloc_pages_exact_node(int nid, size_t size, gfp_t gfp_mask);
+#define alloc_pages_exact(size, gfp_mask) \
+	alloc_pages_exact_node(NUMA_NO_NODE, size, gfp_mask)
 
 #define __get_free_page(gfp_mask) \
 		__get_free_pages((gfp_mask), 0)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index dd2fed66b656..dec68bd21a71 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4859,34 +4859,6 @@ static void *make_alloc_exact(unsigned long addr, unsigned int order,
 	return (void *)addr;
 }
 
-/**
- * alloc_pages_exact - allocate an exact number physically-contiguous pages.
- * @size: the number of bytes to allocate
- * @gfp_mask: GFP flags for the allocation, must not contain __GFP_COMP
- *
- * This function is similar to alloc_pages(), except that it allocates the
- * minimum number of pages to satisfy the request.  alloc_pages() can only
- * allocate memory in power-of-two pages.
- *
- * This function is also limited by MAX_ORDER.
- *
- * Memory allocated by this function must be released by free_pages_exact().
- *
- * Return: pointer to the allocated area or %NULL in case of error.
- */
-void *alloc_pages_exact(size_t size, gfp_t gfp_mask)
-{
-	unsigned int order = get_order(size);
-	unsigned long addr;
-
-	if (WARN_ON_ONCE(gfp_mask & __GFP_COMP))
-		gfp_mask &= ~__GFP_COMP;
-
-	addr = __get_free_pages(gfp_mask, order);
-	return make_alloc_exact(addr, order, size);
-}
-EXPORT_SYMBOL(alloc_pages_exact);
-
 /**
  * alloc_pages_exact_node - allocate an exact number of physically-contiguous
  *			   pages on a node.
@@ -4894,12 +4866,15 @@ EXPORT_SYMBOL(alloc_pages_exact);
  * @size: the number of bytes to allocate
  * @gfp_mask: GFP flags for the allocation, must not contain __GFP_COMP
  *
- * Like alloc_pages_exact(), but try to allocate on node nid first before falling
- * back.
+ * This function is similar to alloc_pages_node(), except that it allocates the
+ * minimum number of pages to satisfy the request while alloc_pages() can only
+ * allocate memory in power-of-two pages.  This function is also limited by
+ * MAX_ORDER.
  *
- * Return: pointer to the allocated area or %NULL in case of error.
+ * Returns a pointer to the allocated area or %NULL in case of error, memory
+ * allocated by this function must be released by free_pages_exact().
  */
-void * __meminit alloc_pages_exact_node(int nid, size_t size, gfp_t gfp_mask)
+void *alloc_pages_exact_node(int nid, size_t size, gfp_t gfp_mask)
 {
 	unsigned int order = get_order(size);
 	struct page *p;
-- 
2.20.1
