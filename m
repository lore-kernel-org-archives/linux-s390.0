Return-Path: <bpf-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 25/29] mm: switch the test_vmalloc module to use __vmalloc_node
Date: Tue, 14 Apr 2020 15:13:44 +0200
Message-Id: <20200414131348.444715-26-hch@lst.de>
In-Reply-To: <20200414131348.444715-1-hch@lst.de>
References: <20200414131348.444715-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, x86@kernel.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Laura Abbott <labbott@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

No need to export the very low-level __vmalloc_node_range when the
test module can use a slightly higher level variant.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 lib/test_vmalloc.c | 26 +++++++-------------------
 mm/vmalloc.c       | 17 ++++++++---------
 2 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index 8bbefcaddfe8..cd6aef05dfb4 100644
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -91,12 +91,8 @@ static int random_size_align_alloc_test(void)
 		 */
 		size = ((rnd % 10) + 1) * PAGE_SIZE;
 
-		ptr = __vmalloc_node_range(size, align,
-		   VMALLOC_START, VMALLOC_END,
-		   GFP_KERNEL | __GFP_ZERO,
-		   PAGE_KERNEL,
-		   0, 0, __builtin_return_address(0));
-
+		ptr = __vmalloc_node(size, align, GFP_KERNEL | __GFP_ZERO,
+				__builtin_return_address(0));
 		if (!ptr)
 			return -1;
 
@@ -118,12 +114,8 @@ static int align_shift_alloc_test(void)
 	for (i = 0; i < BITS_PER_LONG; i++) {
 		align = ((unsigned long) 1) << i;
 
-		ptr = __vmalloc_node_range(PAGE_SIZE, align,
-			VMALLOC_START, VMALLOC_END,
-			GFP_KERNEL | __GFP_ZERO,
-			PAGE_KERNEL,
-			0, 0, __builtin_return_address(0));
-
+		ptr = __vmalloc_node(PAGE_SIZE, align, GFP_KERNEL | __GFP_ZERO,
+				__builtin_return_address(0));
 		if (!ptr)
 			return -1;
 
@@ -139,13 +131,9 @@ static int fix_align_alloc_test(void)
 	int i;
 
 	for (i = 0; i < test_loop_count; i++) {
-		ptr = __vmalloc_node_range(5 * PAGE_SIZE,
-			THREAD_ALIGN << 1,
-			VMALLOC_START, VMALLOC_END,
-			GFP_KERNEL | __GFP_ZERO,
-			PAGE_KERNEL,
-			0, 0, __builtin_return_address(0));
-
+		ptr = __vmalloc_node(5 * PAGE_SIZE, THREAD_ALIGN << 1,
+				GFP_KERNEL | __GFP_ZERO,
+				__builtin_return_address(0));
 		if (!ptr)
 			return -1;
 
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ae8249ef5821..333fbe77255a 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2522,15 +2522,6 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 	return NULL;
 }
 
-/*
- * This is only for performance analysis of vmalloc and stress purpose.
- * It is required by vmalloc test module, therefore do not use it other
- * than that.
- */
-#ifdef CONFIG_TEST_VMALLOC_MODULE
-EXPORT_SYMBOL_GPL(__vmalloc_node_range);
-#endif
-
 /**
  * __vmalloc_node - allocate virtually contiguous memory
  * @size:	    allocation size
@@ -2556,6 +2547,14 @@ void *__vmalloc_node(unsigned long size, unsigned long align,
 	return __vmalloc_node_range(size, align, VMALLOC_START, VMALLOC_END,
 				gfp_mask, PAGE_KERNEL, 0, node, caller);
 }
+/*
+ * This is only for performance analysis of vmalloc and stress purpose.
+ * It is required by vmalloc test module, therefore do not use it other
+ * than that.
+ */
+#ifdef CONFIG_TEST_VMALLOC_MODULE
+EXPORT_SYMBOL_GPL(__vmalloc_node);
+#endif
 
 void *__vmalloc(unsigned long size, gfp_t gfp_mask)
 {
-- 
2.25.1
