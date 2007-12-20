Return-Path: <linux-kernel-owner+w=401wt.eu-S966127AbXLTPjx@vger.kernel.org>
Message-Id: <20071220152108.129681973@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:19:48 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 23/47] Get rid of HOLES_IN_ZONE requirement.
Content-Disposition: inline; filename=122-zone-holes.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Align everything to MAX_ORDER so we can get rid of the extra checks.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/Kconfig        |    3 ---
 arch/s390/kernel/setup.c |   25 ++++++++++++++++++++++++-
 arch/s390/mm/vmem.c      |    2 +-
 3 files changed, 25 insertions(+), 5 deletions(-)

Index: quilt-2.6/arch/s390/Kconfig
===================================================================
--- quilt-2.6.orig/arch/s390/Kconfig
+++ quilt-2.6/arch/s390/Kconfig
@@ -276,9 +276,6 @@ source "kernel/Kconfig.preempt"
 
 source "mm/Kconfig"
 
-config HOLES_IN_ZONE
-	def_bool y
-
 comment "I/O subsystem configuration"
 
 config MACHCHK_WARNING
Index: quilt-2.6/arch/s390/kernel/setup.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/setup.c
+++ quilt-2.6/arch/s390/kernel/setup.c
@@ -559,7 +559,9 @@ setup_resources(void)
 	data_resource.start = (unsigned long) &_etext;
 	data_resource.end = (unsigned long) &_edata - 1;
 
-	for (i = 0; i < MEMORY_CHUNKS && memory_chunk[i].size > 0; i++) {
+	for (i = 0; i < MEMORY_CHUNKS; i++) {
+		if (!memory_chunk[i].size)
+			continue;
 		res = alloc_bootmem_low(sizeof(struct resource));
 		res->flags = IORESOURCE_BUSY | IORESOURCE_MEM;
 		switch (memory_chunk[i].type) {
@@ -630,6 +632,27 @@ static void __init setup_memory_end(void
 	max_mem = memory_end ? min(VMALLOC_START, memory_end) : VMALLOC_START;
 	memory_end = min(max_mem, memory_end);
 
+	/*
+	 * Make sure all chunks are MAX_ORDER aligned so we don't need the
+	 * extra checks that HOLES_IN_ZONE would require.
+	 */
+	for (i = 0; i < MEMORY_CHUNKS; i++) {
+		unsigned long start, end;
+		struct mem_chunk *chunk;
+		unsigned long align;
+
+		chunk = &memory_chunk[i];
+		align = 1UL << (MAX_ORDER + PAGE_SHIFT - 1);
+		start = (chunk->addr + align - 1) & ~(align - 1);
+		end = (chunk->addr + chunk->size) & ~(align - 1);
+		if (start >= end)
+			memset(chunk, 0, sizeof(*chunk));
+		else {
+			chunk->addr = start;
+			chunk->size = end - start;
+		}
+	}
+
 	for (i = 0; i < MEMORY_CHUNKS; i++) {
 		struct mem_chunk *chunk = &memory_chunk[i];
 
Index: quilt-2.6/arch/s390/mm/vmem.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/vmem.c
+++ quilt-2.6/arch/s390/mm/vmem.c
@@ -376,7 +376,7 @@ static int __init vmem_convert_memory_ch
 	int i;
 
 	mutex_lock(&vmem_mutex);
-	for (i = 0; i < MEMORY_CHUNKS && memory_chunk[i].size > 0; i++) {
+	for (i = 0; i < MEMORY_CHUNKS; i++) {
 		if (!memory_chunk[i].size)
 			continue;
 		seg = kzalloc(sizeof(*seg), GFP_KERNEL);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
