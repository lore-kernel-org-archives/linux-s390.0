Return-Path: <linux-kernel-owner+w=401wt.eu-S1758979AbYBEPoF@vger.kernel.org>
Message-Id: <20080205153915.892066661@de.ibm.com>
References: <20080205153835.337897404@de.ibm.com>
Date: Tue, 05 Feb 2008 16:38:52 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 17/18] Remove BUILD_BUG_ON() in vmem code.
Content-Disposition: inline; filename=017-vmem-bug.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Remove BUILD_BUG_ON() in vmem code since it causes build failures if
the size of struct page increases. Instead calculate at compile time
the address of the highest physical address that can be added to the
1:1 mapping.
This supposed to fix a build failure with the page owner tracking leak
detector patches as reported by akpm.

page-owner-tracking-leak-detector-broken-on-s390.patch can be removed
from -mm again when this is merged.

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/setup.c   |    2 +-
 arch/s390/mm/vmem.c        |    3 +--
 include/asm-s390/pgtable.h |   12 +++++++++---
 3 files changed, 11 insertions(+), 6 deletions(-)

Index: quilt-2.6/arch/s390/kernel/setup.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/setup.c
+++ quilt-2.6/arch/s390/kernel/setup.c
@@ -528,7 +528,7 @@ static void __init setup_memory_end(void
 	memory_size = 0;
 	memory_end &= PAGE_MASK;
 
-	max_mem = memory_end ? min(VMALLOC_START, memory_end) : VMALLOC_START;
+	max_mem = memory_end ? min(VMEM_MAX_PHYS, memory_end) : VMEM_MAX_PHYS;
 	memory_end = min(max_mem, memory_end);
 
 	/*
Index: quilt-2.6/arch/s390/mm/vmem.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/vmem.c
+++ quilt-2.6/arch/s390/mm/vmem.c
@@ -250,7 +250,7 @@ static int insert_memory_segment(struct 
 {
 	struct memory_segment *tmp;
 
-	if (seg->start + seg->size >= VMALLOC_START ||
+	if (seg->start + seg->size >= VMEM_MAX_PHYS ||
 	    seg->start + seg->size < seg->start)
 		return -ERANGE;
 
@@ -360,7 +360,6 @@ void __init vmem_map_init(void)
 {
 	int i;
 
-	BUILD_BUG_ON((unsigned long)VMEM_MAP + VMEM_MAP_SIZE > VMEM_MAP_MAX);
 	NODE_DATA(0)->node_mem_map = VMEM_MAP;
 	for (i = 0; i < MEMORY_CHUNKS && memory_chunk[i].size > 0; i++)
 		vmem_add_mem(memory_chunk[i].addr, memory_chunk[i].size);
Index: quilt-2.6/include/asm-s390/pgtable.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/pgtable.h
+++ quilt-2.6/include/asm-s390/pgtable.h
@@ -115,15 +115,21 @@ extern char empty_zero_page[PAGE_SIZE];
 #ifndef __s390x__
 #define VMALLOC_START	0x78000000UL
 #define VMALLOC_END	0x7e000000UL
-#define VMEM_MAP_MAX	0x80000000UL
+#define VMEM_MAP_END	0x80000000UL
 #else /* __s390x__ */
 #define VMALLOC_START	0x3e000000000UL
 #define VMALLOC_END	0x3e040000000UL
-#define VMEM_MAP_MAX	0x40000000000UL
+#define VMEM_MAP_END	0x40000000000UL
 #endif /* __s390x__ */
 
+/*
+ * VMEM_MAX_PHYS is the highest physical address that can be added to the 1:1
+ * mapping. This needs to be calculated at compile time since the size of the
+ * VMEM_MAP is static but the size of struct page can change.
+ */
+#define VMEM_MAX_PHYS	min(VMALLOC_START, ((VMEM_MAP_END - VMALLOC_END) / \
+			  sizeof(struct page) * PAGE_SIZE) & ~((16 << 20) - 1))
 #define VMEM_MAP	((struct page *) VMALLOC_END)
-#define VMEM_MAP_SIZE	((VMALLOC_START / PAGE_SIZE) * sizeof(struct page))
 
 /*
  * A 31 bit pagetable entry of S390 has following format:

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
