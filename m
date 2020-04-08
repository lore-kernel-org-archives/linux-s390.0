Return-Path: <bpf-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 28/28] s390: use __vmalloc_node in stack_alloc
Date: Wed,  8 Apr 2020 13:59:26 +0200
Message-Id: <20200408115926.1467567-29-hch@lst.de>
In-Reply-To: <20200408115926.1467567-1-hch@lst.de>
References: <20200408115926.1467567-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, x86@kernel.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Laura Abbott <labbott@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

stack_alloc can use a slightly higher level vmalloc function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/s390/kernel/setup.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 36445dd40fdb..0f0b140b5558 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -305,12 +305,9 @@ void *restart_stack __section(.data);
 unsigned long stack_alloc(void)
 {
 #ifdef CONFIG_VMAP_STACK
-	return (unsigned long)
-		__vmalloc_node_range(THREAD_SIZE, THREAD_SIZE,
-				     VMALLOC_START, VMALLOC_END,
-				     THREADINFO_GFP,
-				     PAGE_KERNEL, 0, NUMA_NO_NODE,
-				     __builtin_return_address(0));
+	return (unsigned long)__vmalloc_node(THREAD_SIZE, THREAD_SIZE,
+			THREADINFO_GFP, NUMA_NO_NODE,
+			__builtin_return_address(0));
 #else
 	return __get_free_pages(GFP_KERNEL, THREAD_SIZE_ORDER);
 #endif
-- 
2.25.1
