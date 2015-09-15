Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH 1/2] s390/crash_dump: Use for_each_mem_range
Date: Wed, 16 Sep 2015 00:54:24 +0600
Message-Id: <1442343264-10583-1-git-send-email-kuleshovmail@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, Tony Luck <tony.luck@intel.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

The <linux/memblock.h> already provides for_each_mem_range() macro that
iterates through memblock areas from type_a and not included in type_b.
We can remove custom for_each_dump_mem_range() macro and use the
for_each_mem_range() instead.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 arch/s390/kernel/crash_dump.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index 0c6c01e..1e4fcfa 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -32,16 +32,6 @@ static struct memblock_type oldmem_type = {
 	.regions = &oldmem_region,
 };
 
-#define for_each_dump_mem_range(i, nid, p_start, p_end, p_nid)		\
-	for (i = 0, __next_mem_range(&i, nid, MEMBLOCK_NONE,		\
-				     &memblock.physmem,			\
-				     &oldmem_type, p_start,		\
-				     p_end, p_nid);			\
-	     i != (u64)ULLONG_MAX;					\
-	     __next_mem_range(&i, nid, MEMBLOCK_NONE, &memblock.physmem,\
-			      &oldmem_type,				\
-			      p_start, p_end, p_nid))
-
 struct dump_save_areas dump_save_areas;
 
 /*
@@ -515,7 +505,8 @@ static int get_mem_chunk_cnt(void)
 	int cnt = 0;
 	u64 idx;
 
-	for_each_dump_mem_range(idx, NUMA_NO_NODE, NULL, NULL, NULL)
+	for_each_mem_range(idx, &memblock.physmem, &oldmem_type, NUMA_NO_NODE,
+			MEMBLOCK_NONE, NULL, NULL, NULL)
 		cnt++;
 	return cnt;
 }
@@ -528,7 +519,8 @@ static void loads_init(Elf64_Phdr *phdr, u64 loads_offset)
 	phys_addr_t start, end;
 	u64 idx;
 
-	for_each_dump_mem_range(idx, NUMA_NO_NODE, &start, &end, NULL) {
+	for_each_mem_range(idx, &memblock.physmem, &oldmem_type, NUMA_NO_NODE,
+			MEMBLOCK_NONE, &start, &end, NULL) {
 		phdr->p_filesz = end - start;
 		phdr->p_type = PT_LOAD;
 		phdr->p_offset = start;
-- 
2.5.0
