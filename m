Return-Path: <linux-kernel-owner+w=401wt.eu-S1761286AbXJDLh5@vger.kernel.org>
Message-Id: <20071004112833.409003375@de.ibm.com>
References: <20071004112706.574737175@de.ibm.com>
Date: Thu, 04 Oct 2007 13:27:37 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 31/34] Make vmalloc area start at address > 4GB.
Content-Disposition: inline; filename=031-vmalloc-4gb.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Prevent that modules get loaded at addresses below 4GB to
prevent exchanging system call table entries.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/pgtable.h |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

Index: quilt-2.6/include/asm-s390/pgtable.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/pgtable.h
+++ quilt-2.6/include/asm-s390/pgtable.h
@@ -107,11 +107,18 @@ extern char empty_zero_page[PAGE_SIZE];
  * any out-of-bounds memory accesses will hopefully be caught.
  * The vmalloc() routines leaves a hole of 4kB between each vmalloced
  * area for the same reason. ;)
+ * vmalloc area starts at 4GB to prevent syscall table entry exchanging
+ * from modules.
  */
 extern unsigned long vmalloc_end;
-#define VMALLOC_OFFSET  (8*1024*1024)
-#define VMALLOC_START   (((unsigned long) high_memory + VMALLOC_OFFSET) \
-			 & ~(VMALLOC_OFFSET-1))
+
+#ifdef CONFIG_64BIT
+#define VMALLOC_ADDR	(max(0x100000000UL, (unsigned long) high_memory))
+#else
+#define VMALLOC_ADDR	((unsigned long) high_memory)
+#endif
+#define VMALLOC_OFFSET	(8*1024*1024)
+#define VMALLOC_START	((VMALLOC_ADDR + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1))
 #define VMALLOC_END	vmalloc_end
 
 /*

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
