Return-Path: <linux-kernel-owner+w=401wt.eu-S966222AbXLTPkh@vger.kernel.org>
Message-Id: <20071220152107.723041491@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:19:46 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 21/47] Change vmalloc defintions
Content-Disposition: inline; filename=120-vmalloc.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

Currently the vmalloc area starts at a dynamic address depending on
the memory size. There was also an 8MB security hole after the
physical memory to catch out-of-bounds accesses.
We can simplify the code by putting the vmalloc area explicitely at
the top of the kernel mapping and setting the vmalloc size to a fixed
value of 128MB/128GB for 31bit/64bit systems. Part of the vmalloc
area will be used for the vmem_map. This leaves an area of 96MB/1GB
for normal vmalloc allocations.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/setup.c   |    6 ++---
 arch/s390/mm/vmem.c        |   20 ++++++-------------
 include/asm-s390/pgtable.h |   46 +++++++++++++++------------------------------
 3 files changed, 26 insertions(+), 46 deletions(-)

Index: quilt-2.6/arch/s390/kernel/setup.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/setup.c
+++ quilt-2.6/arch/s390/kernel/setup.c
@@ -617,7 +617,7 @@ EXPORT_SYMBOL_GPL(real_memory_size);
 static void __init setup_memory_end(void)
 {
 	unsigned long memory_size;
-	unsigned long max_mem, max_phys;
+	unsigned long max_mem;
 	int i;
 
 #if defined(CONFIG_ZFCPDUMP) || defined(CONFIG_ZFCPDUMP_MODULE)
@@ -625,10 +625,10 @@ static void __init setup_memory_end(void
 		memory_end = ZFCPDUMP_HSA_SIZE;
 #endif
 	memory_size = 0;
-	max_phys = VMALLOC_END_INIT - VMALLOC_MIN_SIZE;
 	memory_end &= PAGE_MASK;
 
-	max_mem = memory_end ? min(max_phys, memory_end) : max_phys;
+	max_mem = memory_end ? min(VMALLOC_START, memory_end) : VMALLOC_START;
+	memory_end = min(max_mem, memory_end);
 
 	for (i = 0; i < MEMORY_CHUNKS; i++) {
 		struct mem_chunk *chunk = &memory_chunk[i];
Index: quilt-2.6/arch/s390/mm/vmem.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/vmem.c
+++ quilt-2.6/arch/s390/mm/vmem.c
@@ -15,10 +15,6 @@
 #include <asm/setup.h>
 #include <asm/tlbflush.h>
 
-unsigned long vmalloc_end;
-EXPORT_SYMBOL(vmalloc_end);
-
-static struct page *vmem_map;
 static DEFINE_MUTEX(vmem_mutex);
 
 struct memory_segment {
@@ -188,8 +184,8 @@ static int vmem_add_mem_map(unsigned lon
 	pte_t  pte;
 	int ret = -ENOMEM;
 
-	map_start = vmem_map + PFN_DOWN(start);
-	map_end	= vmem_map + PFN_DOWN(start + size);
+	map_start = VMEM_MAP + PFN_DOWN(start);
+	map_end	= VMEM_MAP + PFN_DOWN(start + size);
 
 	start_addr = (unsigned long) map_start & PAGE_MASK;
 	end_addr = PFN_ALIGN((unsigned long) map_end);
@@ -254,7 +250,7 @@ static int insert_memory_segment(struct 
 {
 	struct memory_segment *tmp;
 
-	if (PFN_DOWN(seg->start + seg->size) > max_pfn ||
+	if (seg->start + seg->size >= VMALLOC_START ||
 	    seg->start + seg->size < seg->start)
 		return -ERANGE;
 
@@ -357,17 +353,15 @@ out:
 
 /*
  * map whole physical memory to virtual memory (identity mapping)
+ * we reserve enough space in the vmalloc area for vmemmap to hotplug
+ * additional memory segments.
  */
 void __init vmem_map_init(void)
 {
-	unsigned long map_size;
 	int i;
 
-	map_size = ALIGN(max_low_pfn, MAX_ORDER_NR_PAGES) * sizeof(struct page);
-	vmalloc_end = PFN_ALIGN(VMALLOC_END_INIT) - PFN_ALIGN(map_size);
-	vmem_map = (struct page *) vmalloc_end;
-	NODE_DATA(0)->node_mem_map = vmem_map;
-
+	BUILD_BUG_ON((unsigned long)VMEM_MAP + VMEM_MAP_SIZE > VMEM_MAP_MAX);
+	NODE_DATA(0)->node_mem_map = VMEM_MAP;
 	for (i = 0; i < MEMORY_CHUNKS && memory_chunk[i].size > 0; i++)
 		vmem_add_mem(memory_chunk[i].addr, memory_chunk[i].size);
 }
Index: quilt-2.6/include/asm-s390/pgtable.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/pgtable.h
+++ quilt-2.6/include/asm-s390/pgtable.h
@@ -104,41 +104,27 @@ extern char empty_zero_page[PAGE_SIZE];
 
 #ifndef __ASSEMBLY__
 /*
- * Just any arbitrary offset to the start of the vmalloc VM area: the
- * current 8MB value just means that there will be a 8MB "hole" after the
- * physical memory until the kernel virtual memory starts.  That means that
- * any out-of-bounds memory accesses will hopefully be caught.
- * The vmalloc() routines leaves a hole of 4kB between each vmalloced
- * area for the same reason. ;)
- * vmalloc area starts at 4GB to prevent syscall table entry exchanging
- * from modules.
- */
-extern unsigned long vmalloc_end;
-
-#ifdef CONFIG_64BIT
-#define VMALLOC_ADDR	(max(0x100000000UL, (unsigned long) high_memory))
-#else
-#define VMALLOC_ADDR	((unsigned long) high_memory)
-#endif
-#define VMALLOC_OFFSET	(8*1024*1024)
-#define VMALLOC_START	((VMALLOC_ADDR + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1))
-#define VMALLOC_END	vmalloc_end
-
-/*
- * We need some free virtual space to be able to do vmalloc.
- * VMALLOC_MIN_SIZE defines the minimum size of the vmalloc
- * area. On a machine with 2GB memory we make sure that we
- * have at least 128MB free space for vmalloc. On a machine
- * with 4TB we make sure we have at least 128GB.
+ * The vmalloc area will always be on the topmost area of the kernel
+ * mapping. We reserve 96MB (31bit) / 1GB (64bit) for vmalloc,
+ * which should be enough for any sane case.
+ * By putting vmalloc at the top, we maximise the gap between physical
+ * memory and vmalloc to catch misplaced memory accesses. As a side
+ * effect, this also makes sure that 64 bit module code cannot be used
+ * as system call address.
  */
 #ifndef __s390x__
-#define VMALLOC_MIN_SIZE	0x8000000UL
-#define VMALLOC_END_INIT	0x80000000UL
+#define VMALLOC_START	0x78000000UL
+#define VMALLOC_END	0x7e000000UL
+#define VMEM_MAP_MAX	0x80000000UL
 #else /* __s390x__ */
-#define VMALLOC_MIN_SIZE	0x2000000000UL
-#define VMALLOC_END_INIT	0x40000000000UL
+#define VMALLOC_START	0x3e000000000UL
+#define VMALLOC_END	0x3e040000000UL
+#define VMEM_MAP_MAX	0x40000000000UL
 #endif /* __s390x__ */
 
+#define VMEM_MAP	((struct page *) VMALLOC_END)
+#define VMEM_MAP_SIZE	((VMALLOC_START / PAGE_SIZE) * sizeof(struct page))
+
 /*
  * A 31 bit pagetable entry of S390 has following format:
  *  |   PFRA          |    |  OS  |

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
