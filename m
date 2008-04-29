Return-Path: <linux-kernel-owner+w=401wt.eu-S1765711AbYD2OUz@vger.kernel.org>
Message-Id: <20080429140252.231033301@de.ibm.com>
References: <20080429140117.631962807@de.ibm.com>
Date: Tue, 29 Apr 2008 16:01:32 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 15/15] Convert to SPARSEMEM & SPARSEMEM_VMEMMAP
Content-Disposition: inline; filename=015-sparsemem.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Convert s390 to SPARSEMEM and SPARSEMEM_VMEMMAP. We do a select
of SPARSEMEM_VMEMMAP since it is configurable. This is because
SPARSEMEM without SPARSEMEM_VMEMMAP gives us a hell of broken
include dependencies that I don't want to fix.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/Kconfig             |    8 ++++
 arch/s390/mm/extmem.c         |    8 ++--
 arch/s390/mm/init.c           |    2 +
 arch/s390/mm/vmem.c           |   81 +++---------------------------------------
 drivers/s390/kvm/kvm_virtio.c |   23 ++++++-----
 include/asm-s390/page.h       |   20 ----------
 include/asm-s390/pgtable.h    |    9 +---
 include/asm-s390/sparsemem.h  |   18 +++++++++
 8 files changed, 53 insertions(+), 116 deletions(-)

Index: quilt-2.6/arch/s390/Kconfig
===================================================================
--- quilt-2.6.orig/arch/s390/Kconfig
+++ quilt-2.6/arch/s390/Kconfig
@@ -300,6 +300,14 @@ comment "Kernel preemption"
 
 source "kernel/Kconfig.preempt"
 
+config ARCH_SPARSEMEM_ENABLE
+	def_bool y
+	select SPARSEMEM_VMEMMAP_ENABLE
+	select SPARSEMEM_VMEMMAP
+
+config ARCH_SPARSEMEM_DEFAULT
+	def_bool y
+
 source "mm/Kconfig"
 
 comment "I/O subsystem configuration"
Index: quilt-2.6/arch/s390/mm/extmem.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/extmem.c
+++ quilt-2.6/arch/s390/mm/extmem.c
@@ -287,7 +287,7 @@ __segment_load (char *name, int do_nonsh
 	if (rc < 0)
 		goto out_free;
 
-	rc = add_shared_memory(seg->start_addr, seg->end - seg->start_addr + 1);
+	rc = vmem_add_mapping(seg->start_addr, seg->end - seg->start_addr + 1);
 
 	if (rc)
 		goto out_free;
@@ -351,7 +351,7 @@ __segment_load (char *name, int do_nonsh
 	release_resource(seg->res);
 	kfree(seg->res);
  out_shared:
-	remove_shared_memory(seg->start_addr, seg->end - seg->start_addr + 1);
+	vmem_remove_mapping(seg->start_addr, seg->end - seg->start_addr + 1);
  out_free:
 	kfree(seg);
  out:
@@ -474,7 +474,7 @@ segment_modify_shared (char *name, int d
 	rc = 0;
 	goto out_unlock;
  out_del:
-	remove_shared_memory(seg->start_addr, seg->end - seg->start_addr + 1);
+	vmem_remove_mapping(seg->start_addr, seg->end - seg->start_addr + 1);
 	list_del(&seg->list);
 	dcss_diag(DCSS_PURGESEG, seg->dcss_name, &dummy, &dummy);
 	kfree(seg);
@@ -508,7 +508,7 @@ segment_unload(char *name)
 		goto out_unlock;
 	release_resource(seg->res);
 	kfree(seg->res);
-	remove_shared_memory(seg->start_addr, seg->end - seg->start_addr + 1);
+	vmem_remove_mapping(seg->start_addr, seg->end - seg->start_addr + 1);
 	list_del(&seg->list);
 	dcss_diag(DCSS_PURGESEG, seg->dcss_name, &dummy, &dummy);
 	kfree(seg);
Index: quilt-2.6/arch/s390/mm/init.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/init.c
+++ quilt-2.6/arch/s390/mm/init.c
@@ -106,6 +106,8 @@ void __init paging_init(void)
 	__ctl_load(S390_lowcore.kernel_asce, 13, 13);
 	__raw_local_irq_ssm(ssm_mask);
 
+	sparse_memory_present_with_active_regions(MAX_NUMNODES);
+	sparse_init();
 	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
 #ifdef CONFIG_ZONE_DMA
 	max_zone_pfns[ZONE_DMA] = PFN_DOWN(MAX_DMA_ADDRESS);
Index: quilt-2.6/arch/s390/mm/vmem.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/vmem.c
+++ quilt-2.6/arch/s390/mm/vmem.c
@@ -27,43 +27,6 @@ struct memory_segment {
 
 static LIST_HEAD(mem_segs);
 
-void __meminit memmap_init(unsigned long size, int nid, unsigned long zone,
-			   unsigned long start_pfn)
-{
-	struct page *start, *end;
-	struct page *map_start, *map_end;
-	int i;
-
-	start = pfn_to_page(start_pfn);
-	end = start + size;
-
-	for (i = 0; i < MEMORY_CHUNKS && memory_chunk[i].size > 0; i++) {
-		unsigned long cstart, cend;
-
-		cstart = PFN_DOWN(memory_chunk[i].addr);
-		cend = cstart + PFN_DOWN(memory_chunk[i].size);
-
-		map_start = mem_map + cstart;
-		map_end = mem_map + cend;
-
-		if (map_start < start)
-			map_start = start;
-		if (map_end > end)
-			map_end = end;
-
-		map_start -= ((unsigned long) map_start & (PAGE_SIZE - 1))
-			/ sizeof(struct page);
-		map_end += ((PFN_ALIGN((unsigned long) map_end)
-			     - (unsigned long) map_end)
-			    / sizeof(struct page));
-
-		if (map_start < map_end)
-			memmap_init_zone((unsigned long)(map_end - map_start),
-					 nid, zone, page_to_pfn(map_start),
-					 MEMMAP_EARLY);
-	}
-}
-
 static void __ref *vmem_alloc_pages(unsigned int order)
 {
 	if (slab_is_available())
@@ -115,7 +78,7 @@ static pte_t __init_refok *vmem_pte_allo
 /*
  * Add a physical memory range to the 1:1 mapping.
  */
-static int vmem_add_range(unsigned long start, unsigned long size, int ro)
+static int vmem_add_mem(unsigned long start, unsigned long size, int ro)
 {
 	unsigned long address;
 	pgd_t *pg_dir;
@@ -209,10 +172,9 @@ static void vmem_remove_range(unsigned l
 /*
  * Add a backed mem_map array to the virtual mem_map array.
  */
-static int vmem_add_mem_map(unsigned long start, unsigned long size)
+int __meminit vmemmap_populate(struct page *start, unsigned long nr, int node)
 {
 	unsigned long address, start_addr, end_addr;
-	struct page *map_start, *map_end;
 	pgd_t *pg_dir;
 	pud_t *pu_dir;
 	pmd_t *pm_dir;
@@ -220,11 +182,8 @@ static int vmem_add_mem_map(unsigned lon
 	pte_t  pte;
 	int ret = -ENOMEM;
 
-	map_start = VMEM_MAP + PFN_DOWN(start);
-	map_end	= VMEM_MAP + PFN_DOWN(start + size);
-
-	start_addr = (unsigned long) map_start & PAGE_MASK;
-	end_addr = PFN_ALIGN((unsigned long) map_end);
+	start_addr = (unsigned long) start;
+	end_addr = (unsigned long) (start + nr);
 
 	for (address = start_addr; address < end_addr; address += PAGE_SIZE) {
 		pg_dir = pgd_offset_k(address);
@@ -268,16 +227,6 @@ out:
 	return ret;
 }
 
-static int vmem_add_mem(unsigned long start, unsigned long size, int ro)
-{
-	int ret;
-
-	ret = vmem_add_mem_map(start, size);
-	if (ret)
-		return ret;
-	return vmem_add_range(start, size, ro);
-}
-
 /*
  * Add memory segment to the segment list if it doesn't overlap with
  * an already present segment.
@@ -315,7 +264,7 @@ static void __remove_shared_memory(struc
 	vmem_remove_range(seg->start, seg->size);
 }
 
-int remove_shared_memory(unsigned long start, unsigned long size)
+int vmem_remove_mapping(unsigned long start, unsigned long size)
 {
 	struct memory_segment *seg;
 	int ret;
@@ -339,11 +288,9 @@ out:
 	return ret;
 }
 
-int add_shared_memory(unsigned long start, unsigned long size)
+int vmem_add_mapping(unsigned long start, unsigned long size)
 {
 	struct memory_segment *seg;
-	struct page *page;
-	unsigned long pfn, num_pfn, end_pfn;
 	int ret;
 
 	mutex_lock(&vmem_mutex);
@@ -361,21 +308,6 @@ int add_shared_memory(unsigned long star
 	ret = vmem_add_mem(start, size, 0);
 	if (ret)
 		goto out_remove;
-
-	pfn = PFN_DOWN(start);
-	num_pfn = PFN_DOWN(size);
-	end_pfn = pfn + num_pfn;
-
-	page = pfn_to_page(pfn);
-	memset(page, 0, num_pfn * sizeof(struct page));
-
-	for (; pfn < end_pfn; pfn++) {
-		page = pfn_to_page(pfn);
-		init_page_count(page);
-		reset_page_mapcount(page);
-		SetPageReserved(page);
-		INIT_LIST_HEAD(&page->lru);
-	}
 	goto out;
 
 out_remove:
@@ -401,7 +333,6 @@ void __init vmem_map_init(void)
 	INIT_LIST_HEAD(&init_mm.context.crst_list);
 	INIT_LIST_HEAD(&init_mm.context.pgtable_list);
 	init_mm.context.noexec = 0;
-	NODE_DATA(0)->node_mem_map = VMEM_MAP;
 	ro_start = ((unsigned long)&_stext) & PAGE_MASK;
 	ro_end = PFN_ALIGN((unsigned long)&_eshared);
 	for (i = 0; i < MEMORY_CHUNKS && memory_chunk[i].size > 0; i++) {
Index: quilt-2.6/drivers/s390/kvm/kvm_virtio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/kvm/kvm_virtio.c
+++ quilt-2.6/drivers/s390/kvm/kvm_virtio.c
@@ -17,6 +17,7 @@
 #include <linux/virtio_config.h>
 #include <linux/interrupt.h>
 #include <linux/virtio_ring.h>
+#include <linux/pfn.h>
 #include <asm/io.h>
 #include <asm/kvm_para.h>
 #include <asm/kvm_virtio.h>
@@ -180,11 +181,10 @@ static struct virtqueue *kvm_find_vq(str
 
 	config = kvm_vq_config(kdev->desc)+index;
 
-	if (add_shared_memory(config->address,
-				vring_size(config->num, PAGE_SIZE))) {
-		err = -ENOMEM;
+	err = vmem_add_mapping(config->address,
+			       vring_size(config->num, PAGE_SIZE));
+	if (err)
 		goto out;
-	}
 
 	vq = vring_new_virtqueue(config->num, vdev, (void *) config->address,
 				 kvm_notify, callback);
@@ -202,8 +202,8 @@ static struct virtqueue *kvm_find_vq(str
 	vq->priv = config;
 	return vq;
 unmap:
-	remove_shared_memory(config->address, vring_size(config->num,
-			     PAGE_SIZE));
+	vmem_remove_mapping(config->address,
+			    vring_size(config->num, PAGE_SIZE));
 out:
 	return ERR_PTR(err);
 }
@@ -213,8 +213,8 @@ static void kvm_del_vq(struct virtqueue 
 	struct kvm_vqconfig *config = vq->priv;
 
 	vring_del_virtqueue(vq);
-	remove_shared_memory(config->address,
-			     vring_size(config->num, PAGE_SIZE));
+	vmem_remove_mapping(config->address,
+			    vring_size(config->num, PAGE_SIZE));
 }
 
 /*
@@ -318,12 +318,13 @@ static int __init kvm_devices_init(void)
 		return rc;
 	}
 
-	if (add_shared_memory((max_pfn) << PAGE_SHIFT, PAGE_SIZE)) {
+	rc = vmem_add_mapping(PFN_PHYS(max_pfn), PAGE_SIZE);
+	if (rc) {
 		device_unregister(&kvm_root);
-		return -ENOMEM;
+		return rc;
 	}
 
-	kvm_devices  = (void *) (max_pfn << PAGE_SHIFT);
+	kvm_devices = (void *) PFN_PHYS(max_pfn);
 
 	ctl_set_bit(0, 9);
 	register_external_interrupt(0x2603, kvm_extint_handler);
Index: quilt-2.6/include/asm-s390/page.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/page.h
+++ quilt-2.6/include/asm-s390/page.h
@@ -125,26 +125,6 @@ page_get_storage_key(unsigned long addr)
 	return skey;
 }
 
-extern unsigned long max_pfn;
-
-static inline int pfn_valid(unsigned long pfn)
-{
-	unsigned long dummy;
-	int ccode;
-
-	if (pfn >= max_pfn)
-		return 0;
-
-	asm volatile(
-		"	lra	%0,0(%2)\n"
-		"	ipm	%1\n"
-		"	srl	%1,28\n"
-		: "=d" (dummy), "=d" (ccode)
-		: "a" (pfn << PAGE_SHIFT)
-		: "cc");
-	return !ccode;
-}
-
 #endif /* !__ASSEMBLY__ */
 
 /* to align the pointer to the (next) page boundary */
Index: quilt-2.6/include/asm-s390/pgtable.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/pgtable.h
+++ quilt-2.6/include/asm-s390/pgtable.h
@@ -129,7 +129,7 @@ extern char empty_zero_page[PAGE_SIZE];
 #define VMEM_MAX_PAGES	((VMEM_MAP_END - VMALLOC_END) / sizeof(struct page))
 #define VMEM_MAX_PFN	min(VMALLOC_START >> PAGE_SHIFT, VMEM_MAX_PAGES)
 #define VMEM_MAX_PHYS	((VMEM_MAX_PFN << PAGE_SHIFT) & ~((16 << 20) - 1))
-#define VMEM_MAP	((struct page *) VMALLOC_END)
+#define vmemmap		((struct page *) VMALLOC_END)
 
 /*
  * A 31 bit pagetable entry of S390 has following format:
@@ -1075,8 +1075,8 @@ static inline pte_t mk_swap_pte(unsigned
 
 #define kern_addr_valid(addr)   (1)
 
-extern int add_shared_memory(unsigned long start, unsigned long size);
-extern int remove_shared_memory(unsigned long start, unsigned long size);
+extern int vmem_add_mapping(unsigned long start, unsigned long size);
+extern int vmem_remove_mapping(unsigned long start, unsigned long size);
 extern int s390_enable_sie(void);
 
 /*
@@ -1084,9 +1084,6 @@ extern int s390_enable_sie(void);
  */
 #define pgtable_cache_init()	do { } while (0)
 
-#define __HAVE_ARCH_MEMMAP_INIT
-extern void memmap_init(unsigned long, int, unsigned long, unsigned long);
-
 #include <asm-generic/pgtable.h>
 
 #endif /* _S390_PAGE_H */
Index: quilt-2.6/include/asm-s390/sparsemem.h
===================================================================
--- /dev/null
+++ quilt-2.6/include/asm-s390/sparsemem.h
@@ -0,0 +1,18 @@
+#ifndef _ASM_S390_SPARSEMEM_H
+#define _ASM_S390_SPARSEMEM_H
+
+#define SECTION_SIZE_BITS	25
+
+#ifdef CONFIG_64BIT
+
+#define MAX_PHYSADDR_BITS	42
+#define MAX_PHYSMEM_BITS	42
+
+#else
+
+#define MAX_PHYSADDR_BITS	31
+#define MAX_PHYSMEM_BITS	31
+
+#endif /* CONFIG_64BIT */
+
+#endif /* _ASM_S390_SPARSEMEM_H */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
