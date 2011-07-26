Return-Path: <linux-arch-owner@vger.kernel.org>
From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 20/23] s390: Use HAVE_MEMBLOCK_NODE_MAP
Date: Tue, 26 Jul 2011 17:35:31 +0200
Message-Id: <1311694534-5161-21-git-send-email-tj@kernel.org>
In-Reply-To: <1311694534-5161-1-git-send-email-tj@kernel.org>
References: <1311694534-5161-1-git-send-email-tj@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: benh@kernel.crashing.org, yinghai@kernel.org, hpa@zytor.com, tony.luck@intel.com, ralf@linux-mips.org, schwidefsky@de.ibm.com, liqin.chen@sunplusct.com, lethal@linux-sh.org, davem@davemloft.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@redhat.com, Tejun Heo <tj@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

s390 used early_node_map[] just to prime free_area_init_nodes().  Now
memblock can be used for the same purpose and early_node_map[] is
scheduled to be dropped.  Use memblock instead.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
---
Only compile tested.

 arch/s390/Kconfig        |    3 +++
 arch/s390/kernel/setup.c |    4 +++-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index c03fef7..e0c3929 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -90,6 +90,9 @@ config S390
 	select HAVE_ARCH_MUTEX_CPU_RELAX
 	select HAVE_ARCH_JUMP_LABEL if !MARCH_G5
 	select HAVE_RCU_TABLE_FREE if SMP
+	select HAVE_MEMBLOCK
+	select HAVE_MEMBLOCK_NODE_MAP
+	select ARCH_DISCARD_MEMBLOCK
 	select ARCH_INLINE_SPIN_TRYLOCK
 	select ARCH_INLINE_SPIN_TRYLOCK_BH
 	select ARCH_INLINE_SPIN_LOCK
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 0c35dee..5b4e48a 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -21,6 +21,7 @@
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
+#include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/stddef.h>
 #include <linux/unistd.h>
@@ -596,7 +597,8 @@ setup_memory(void)
 		end_chunk = min(end_chunk, end_pfn);
 		if (start_chunk >= end_chunk)
 			continue;
-		add_active_range(0, start_chunk, end_chunk);
+		memblock_add_node(PFN_PHYS(start_chunk),
+				  PFN_PHYS(end_chunk - start_chunk), 0);
 		pfn = max(start_chunk, start_pfn);
 		for (; pfn < end_chunk; pfn++)
 			page_set_storage_key(PFN_PHYS(pfn),
-- 
1.7.6
