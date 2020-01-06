Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:40278 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727450AbgAFEJb (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sun, 5 Jan 2020 23:09:31 -0500
From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH] mm/memblock: Define memblock_physmem_add()
Date: Mon,  6 Jan 2020 09:40:35 +0530
Message-Id: <1578283835-21969-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-mm@kvack.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Collin Walling <walling@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Philipp Rudo <prudo@linux.ibm.com>, Mike Rapoport <rppt@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On s390 platform memblock.physmem array is being built by directly calling
into memblock_add_range() which is a low level function not intended to be
used outside of memblock. Hence lets conditionally add helper functions for
physmem array when HAVE_MEMBLOCK_PHYS_MAP is enabled. Also use MAX_NUMNODES
instead of 0 as node ID similar to memblock_add() and memblock_reserve().
Make memblock_add_range() a static function as it is no longer getting used
outside of memblock.

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Collin Walling <walling@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: Philipp Rudo <prudo@linux.ibm.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Only build tested for s390, will appreciate if some one can give it a try
on a real system.

Changes from RFC:

- Dropped all memblock_dbg() changes per Mike
- Renamed memblock_physmem() as memblock_physmem_add() per Mike
- Made memblock_add_range() a static function per Mike
- Updated the commit message

RFC: (https://patchwork.kernel.org/patch/11316627/)

 arch/s390/kernel/setup.c | 12 +++---------
 include/linux/memblock.h |  7 +++----
 mm/memblock.c            | 14 +++++++++++++-
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index b9104ae162f4..424cb8fd2c35 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -762,14 +762,6 @@ static void __init free_mem_detect_info(void)
 		memblock_free(start, size);
 }
 
-static void __init memblock_physmem_add(phys_addr_t start, phys_addr_t size)
-{
-	memblock_dbg("memblock_physmem_add: [%#016llx-%#016llx]\n",
-		     start, start + size - 1);
-	memblock_add_range(&memblock.memory, start, size, 0, 0);
-	memblock_add_range(&memblock.physmem, start, size, 0, 0);
-}
-
 static const char * __init get_mem_info_source(void)
 {
 	switch (mem_detect.info_source) {
@@ -794,8 +786,10 @@ static void __init memblock_add_mem_detect_info(void)
 		     get_mem_info_source(), mem_detect.info_source);
 	/* keep memblock lists close to the kernel */
 	memblock_set_bottom_up(true);
-	for_each_mem_detect_block(i, &start, &end)
+	for_each_mem_detect_block(i, &start, &end) {
+		memblock_add(start, end - start);
 		memblock_physmem_add(start, end - start);
+	}
 	memblock_set_bottom_up(false);
 	memblock_dump_all();
 }
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index b38bbefabfab..079d17d96410 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -113,6 +113,9 @@ int memblock_add(phys_addr_t base, phys_addr_t size);
 int memblock_remove(phys_addr_t base, phys_addr_t size);
 int memblock_free(phys_addr_t base, phys_addr_t size);
 int memblock_reserve(phys_addr_t base, phys_addr_t size);
+#ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
+int memblock_physmem_add(phys_addr_t base, phys_addr_t size);
+#endif
 void memblock_trim_memory(phys_addr_t align);
 bool memblock_overlaps_region(struct memblock_type *type,
 			      phys_addr_t base, phys_addr_t size);
@@ -127,10 +130,6 @@ void reset_node_managed_pages(pg_data_t *pgdat);
 void reset_all_zones_managed_pages(void);
 
 /* Low level functions */
-int memblock_add_range(struct memblock_type *type,
-		       phys_addr_t base, phys_addr_t size,
-		       int nid, enum memblock_flags flags);
-
 void __next_mem_range(u64 *idx, int nid, enum memblock_flags flags,
 		      struct memblock_type *type_a,
 		      struct memblock_type *type_b, phys_addr_t *out_start,
diff --git a/mm/memblock.c b/mm/memblock.c
index 4bc2c7d8bf42..fc0d4db1d646 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -575,7 +575,7 @@ static void __init_memblock memblock_insert_region(struct memblock_type *type,
  * Return:
  * 0 on success, -errno on failure.
  */
-int __init_memblock memblock_add_range(struct memblock_type *type,
+static int __init_memblock memblock_add_range(struct memblock_type *type,
 				phys_addr_t base, phys_addr_t size,
 				int nid, enum memblock_flags flags)
 {
@@ -830,6 +830,18 @@ int __init_memblock memblock_reserve(phys_addr_t base, phys_addr_t size)
 	return memblock_add_range(&memblock.reserved, base, size, MAX_NUMNODES, 0);
 }
 
+#ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
+int __init_memblock memblock_physmem_add(phys_addr_t base, phys_addr_t size)
+{
+	phys_addr_t end = base + size - 1;
+
+	memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
+		     &base, &end, (void *)_RET_IP_);
+
+	return memblock_add_range(&memblock.physmem, base, size, MAX_NUMNODES, 0);
+}
+#endif
+
 /**
  * memblock_setclr_flag - set or clear flag for a memory region
  * @base: base address of the region
-- 
2.20.1
