Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53661 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405462AbgFYPAq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 25 Jun 2020 11:00:46 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH RFC] s390x/vmem: get rid of memory segment list
Date: Thu, 25 Jun 2020 17:00:29 +0200
Message-Id: <20200625150029.45019-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org, David Hildenbrand <david@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>

I can't come up with a satisfying reason why we still need the memory
segment list. We used to represent in the list:
- boot memory
- standby memory added via add_memory()
- loaded dcss segments

When loading/unloading dcss segments, we already track them in a
separate list and check for overlaps
(arch/s390/mm/extmem.c:segment_overlaps_others()) when loading segments.

The overlap check was introduced for some segments in
commit b2300b9efe1b ("[S390] dcssblk: add >2G DCSSs support and stacked
contiguous DCSSs support.")
and was extended to cover all dcss segments in
commit ca57114609d1 ("s390/extmem: remove code for 31 bit addressing
mode").

Although I doubt that overlaps with boot memory and standby memory
are relevant, let's reshuffle the checks in load_segment() to request
the resource first. This will bail out in case we have overlaps with
other resources (esp. boot memory and standby memory). The order
is now different compared to segment_unload() and segment_unload(), but
that should not matter.

This smells like a leftover from ancient times, let's get rid of it. We
can now convert vmem_remove_mapping() into a void function - everybody
ignored the return value already.

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/include/asm/pgtable.h |   2 +-
 arch/s390/mm/extmem.c           |  25 +++----
 arch/s390/mm/vmem.c             | 115 ++------------------------------
 3 files changed, 21 insertions(+), 121 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 19d603bd1f36e..7eb01a5459cdf 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1669,7 +1669,7 @@ static inline swp_entry_t __swp_entry(unsigned long type, unsigned long offset)
 #define kern_addr_valid(addr)   (1)
 
 extern int vmem_add_mapping(unsigned long start, unsigned long size);
-extern int vmem_remove_mapping(unsigned long start, unsigned long size);
+extern void vmem_remove_mapping(unsigned long start, unsigned long size);
 extern int s390_enable_sie(void);
 extern int s390_enable_skey(void);
 extern void s390_reset_cmma(struct mm_struct *mm);
diff --git a/arch/s390/mm/extmem.c b/arch/s390/mm/extmem.c
index 9e0aa7aa03ba4..105c09282f8c5 100644
--- a/arch/s390/mm/extmem.c
+++ b/arch/s390/mm/extmem.c
@@ -313,15 +313,10 @@ __segment_load (char *name, int do_nonshared, unsigned long *addr, unsigned long
 		goto out_free;
 	}
 
-	rc = vmem_add_mapping(seg->start_addr, seg->end - seg->start_addr + 1);
-
-	if (rc)
-		goto out_free;
-
 	seg->res = kzalloc(sizeof(struct resource), GFP_KERNEL);
 	if (seg->res == NULL) {
 		rc = -ENOMEM;
-		goto out_shared;
+		goto out_free;
 	}
 	seg->res->flags = IORESOURCE_BUSY | IORESOURCE_MEM;
 	seg->res->start = seg->start_addr;
@@ -335,12 +330,17 @@ __segment_load (char *name, int do_nonshared, unsigned long *addr, unsigned long
 	if (rc == SEG_TYPE_SC ||
 	    ((rc == SEG_TYPE_SR || rc == SEG_TYPE_ER) && !do_nonshared))
 		seg->res->flags |= IORESOURCE_READONLY;
+
+	/* Check for overlapping resources before adding the mapping. */
 	if (request_resource(&iomem_resource, seg->res)) {
 		rc = -EBUSY;
-		kfree(seg->res);
-		goto out_shared;
+		goto out_free_resource;
 	}
 
+	rc = vmem_add_mapping(seg->start_addr, seg->end - seg->start_addr + 1);
+	if (rc)
+		goto out_resource;
+
 	if (do_nonshared)
 		diag_cc = dcss_diag(&loadnsr_scode, seg->dcss_name,
 				&start_addr, &end_addr);
@@ -351,14 +351,14 @@ __segment_load (char *name, int do_nonshared, unsigned long *addr, unsigned long
 		dcss_diag(&purgeseg_scode, seg->dcss_name,
 				&dummy, &dummy);
 		rc = diag_cc;
-		goto out_resource;
+		goto out_mapping;
 	}
 	if (diag_cc > 1) {
 		pr_warn("Loading DCSS %s failed with rc=%ld\n", name, end_addr);
 		rc = dcss_diag_translate_rc(end_addr);
 		dcss_diag(&purgeseg_scode, seg->dcss_name,
 				&dummy, &dummy);
-		goto out_resource;
+		goto out_mapping;
 	}
 	seg->start_addr = start_addr;
 	seg->end = end_addr;
@@ -377,11 +377,12 @@ __segment_load (char *name, int do_nonshared, unsigned long *addr, unsigned long
 			(void*) seg->end, segtype_string[seg->vm_segtype]);
 	}
 	goto out;
+ out_mapping:
+	vmem_remove_mapping(seg->start_addr, seg->end - seg->start_addr + 1);
  out_resource:
 	release_resource(seg->res);
+ out_free_resource:
 	kfree(seg->res);
- out_shared:
-	vmem_remove_mapping(seg->start_addr, seg->end - seg->start_addr + 1);
  out_free:
 	kfree(seg);
  out:
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index 8b6282cf7d139..3b9e71654c37b 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -20,14 +20,6 @@
 
 static DEFINE_MUTEX(vmem_mutex);
 
-struct memory_segment {
-	struct list_head list;
-	unsigned long start;
-	unsigned long size;
-};
-
-static LIST_HEAD(mem_segs);
-
 static void __ref *vmem_alloc_pages(unsigned int order)
 {
 	unsigned long size = PAGE_SIZE << order;
@@ -300,94 +292,25 @@ void vmemmap_free(unsigned long start, unsigned long end,
 {
 }
 
-/*
- * Add memory segment to the segment list if it doesn't overlap with
- * an already present segment.
- */
-static int insert_memory_segment(struct memory_segment *seg)
-{
-	struct memory_segment *tmp;
-
-	if (seg->start + seg->size > VMEM_MAX_PHYS ||
-	    seg->start + seg->size < seg->start)
-		return -ERANGE;
-
-	list_for_each_entry(tmp, &mem_segs, list) {
-		if (seg->start >= tmp->start + tmp->size)
-			continue;
-		if (seg->start + seg->size <= tmp->start)
-			continue;
-		return -ENOSPC;
-	}
-	list_add(&seg->list, &mem_segs);
-	return 0;
-}
-
-/*
- * Remove memory segment from the segment list.
- */
-static void remove_memory_segment(struct memory_segment *seg)
-{
-	list_del(&seg->list);
-}
-
-static void __remove_shared_memory(struct memory_segment *seg)
+void vmem_remove_mapping(unsigned long start, unsigned long size)
 {
-	remove_memory_segment(seg);
-	vmem_remove_range(seg->start, seg->size);
-}
-
-int vmem_remove_mapping(unsigned long start, unsigned long size)
-{
-	struct memory_segment *seg;
-	int ret;
-
 	mutex_lock(&vmem_mutex);
-
-	ret = -ENOENT;
-	list_for_each_entry(seg, &mem_segs, list) {
-		if (seg->start == start && seg->size == size)
-			break;
-	}
-
-	if (seg->start != start || seg->size != size)
-		goto out;
-
-	ret = 0;
-	__remove_shared_memory(seg);
-	kfree(seg);
-out:
+	vmem_remove_range(start, size);
 	mutex_unlock(&vmem_mutex);
-	return ret;
 }
 
 int vmem_add_mapping(unsigned long start, unsigned long size)
 {
-	struct memory_segment *seg;
 	int ret;
 
-	mutex_lock(&vmem_mutex);
-	ret = -ENOMEM;
-	seg = kzalloc(sizeof(*seg), GFP_KERNEL);
-	if (!seg)
-		goto out;
-	seg->start = start;
-	seg->size = size;
-
-	ret = insert_memory_segment(seg);
-	if (ret)
-		goto out_free;
+	if (start + size > VMEM_MAX_PHYS ||
+	    start + size < start)
+		return -ERANGE;
 
+	mutex_lock(&vmem_mutex);
 	ret = vmem_add_mem(start, size);
 	if (ret)
-		goto out_remove;
-	goto out;
-
-out_remove:
-	__remove_shared_memory(seg);
-out_free:
-	kfree(seg);
-out:
+		vmem_remove_range(start, size);
 	mutex_unlock(&vmem_mutex);
 	return ret;
 }
@@ -421,27 +344,3 @@ void __init vmem_map_init(void)
 	pr_info("Write protected kernel read-only data: %luk\n",
 		(unsigned long)(__end_rodata - _stext) >> 10);
 }
-
-/*
- * Convert memblock.memory  to a memory segment list so there is a single
- * list that contains all memory segments.
- */
-static int __init vmem_convert_memory_chunk(void)
-{
-	struct memblock_region *reg;
-	struct memory_segment *seg;
-
-	mutex_lock(&vmem_mutex);
-	for_each_memblock(memory, reg) {
-		seg = kzalloc(sizeof(*seg), GFP_KERNEL);
-		if (!seg)
-			panic("Out of memory...\n");
-		seg->start = reg->base;
-		seg->size = reg->size;
-		insert_memory_segment(seg);
-	}
-	mutex_unlock(&vmem_mutex);
-	return 0;
-}
-
-core_initcall(vmem_convert_memory_chunk);
-- 
2.26.2
