Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:49672 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728959AbgDHMAr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Apr 2020 08:00:47 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 16/28] mm: remove unmap_vmap_area
Date: Wed,  8 Apr 2020 13:59:14 +0200
Message-Id: <20200408115926.1467567-17-hch@lst.de>
In-Reply-To: <20200408115926.1467567-1-hch@lst.de>
References: <20200408115926.1467567-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, x86@kernel.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Laura Abbott <labbott@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

This function just has a single caller, open code it there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/vmalloc.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index b0c7cdc8701a..258220b203f1 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1247,14 +1247,6 @@ int unregister_vmap_purge_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(unregister_vmap_purge_notifier);
 
-/*
- * Clear the pagetable entries of a given vmap_area
- */
-static void unmap_vmap_area(struct vmap_area *va)
-{
-	unmap_kernel_range_noflush(va->va_start, va->va_end - va->va_start);
-}
-
 /*
  * lazy_max_pages is the maximum amount of virtual address space we gather up
  * before attempting to purge with a TLB flush.
@@ -1416,7 +1408,7 @@ static void free_vmap_area_noflush(struct vmap_area *va)
 static void free_unmap_vmap_area(struct vmap_area *va)
 {
 	flush_cache_vunmap(va->va_start, va->va_end);
-	unmap_vmap_area(va);
+	unmap_kernel_range_noflush(va->va_start, va->va_end - va->va_start);
 	if (debug_pagealloc_enabled_static())
 		flush_tlb_kernel_range(va->va_start, va->va_end);
 
-- 
2.25.1
