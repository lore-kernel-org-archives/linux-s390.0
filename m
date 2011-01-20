From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH] s390: use asm-generic/cacheflush.h
Date: Thu, 20 Jan 2011 20:32:13 +0900
Message-ID: <1295523136-4277-1-git-send-email-akinobu.mita@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The implementation of the cache flushing interfaces on the s390
is identical with the default implementation in asm-generic.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux390@de.ibm.com
Cc: linux-s390@vger.kernel.org
---
 arch/s390/include/asm/cacheflush.h |   23 +----------------------
 1 files changed, 1 insertions(+), 22 deletions(-)

diff --git a/arch/s390/include/asm/cacheflush.h b/arch/s390/include/asm/cacheflush.h
index 405cc97..7e1f776 100644
--- a/arch/s390/include/asm/cacheflush.h
+++ b/arch/s390/include/asm/cacheflush.h
@@ -1,29 +1,8 @@
 #ifndef _S390_CACHEFLUSH_H
 #define _S390_CACHEFLUSH_H
 
-/* Keep includes the same across arches.  */
-#include <linux/mm.h>
-
 /* Caches aren't brain-dead on the s390. */
-#define flush_cache_all()			do { } while (0)
-#define flush_cache_mm(mm)			do { } while (0)
-#define flush_cache_dup_mm(mm)			do { } while (0)
-#define flush_cache_range(vma, start, end)	do { } while (0)
-#define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
-#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
-#define flush_dcache_page(page)			do { } while (0)
-#define flush_dcache_mmap_lock(mapping)		do { } while (0)
-#define flush_dcache_mmap_unlock(mapping)	do { } while (0)
-#define flush_icache_range(start, end)		do { } while (0)
-#define flush_icache_page(vma,pg)		do { } while (0)
-#define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
-#define flush_cache_vmap(start, end)		do { } while (0)
-#define flush_cache_vunmap(start, end)		do { } while (0)
-
-#define copy_to_user_page(vma, page, vaddr, dst, src, len) \
-	memcpy(dst, src, len)
-#define copy_from_user_page(vma, page, vaddr, dst, src, len) \
-	memcpy(dst, src, len)
+#include <asm-generic/cacheflush.h>
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
 void kernel_map_pages(struct page *page, int numpages, int enable);
-- 
1.7.3.4
