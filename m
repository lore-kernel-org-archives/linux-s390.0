Return-Path: <linux-kernel-owner+w=401wt.eu-S1751201AbYGaMjq@vger.kernel.org>
Message-Id: <20080731123932.093946726@de.ibm.com>
References: <20080731123004.868574766@de.ibm.com>
Date: Thu, 31 Jul 2008 14:30:05 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 1/6] Remove diag 0x260 call from memory detection.
Content-Disposition: inline; filename=100-rm-diag260.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

The result of the diag 0x260 call is not always what one would expect.
So just remove it.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/mem_detect.c |   23 -----------------------
 1 file changed, 23 deletions(-)

Index: quilt-2.6/arch/s390/kernel/mem_detect.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/mem_detect.c
+++ quilt-2.6/arch/s390/kernel/mem_detect.c
@@ -9,27 +9,6 @@
 #include <asm/sclp.h>
 #include <asm/setup.h>
 
-static int memory_fast_detect(struct mem_chunk *chunk)
-{
-	unsigned long val0 = 0;
-	unsigned long val1 = 0xc;
-	int rc = -EOPNOTSUPP;
-
-	if (ipl_flags & IPL_NSS_VALID)
-		return -EOPNOTSUPP;
-	asm volatile(
-		"	diag	%1,%2,0x260\n"
-		"0:	lhi	%0,0\n"
-		"1:\n"
-		EX_TABLE(0b,1b)
-		: "+d" (rc), "+d" (val0), "+d" (val1) : : "cc");
-
-	if (rc || val0 != val1)
-		return -EOPNOTSUPP;
-	chunk->size = val0 + 1;
-	return 0;
-}
-
 static inline int tprot(unsigned long addr)
 {
 	int rc = -EFAULT;
@@ -84,8 +63,6 @@ void detect_memory_layout(struct mem_chu
 	unsigned long flags, cr0;
 
 	memset(chunk, 0, MEMORY_CHUNKS * sizeof(struct mem_chunk));
-	if (memory_fast_detect(&chunk[0]) == 0)
-		return;
 	/* Disable IRQs, DAT and low address protection so tprot does the
 	 * right thing and we don't get scheduled away with low address
 	 * protection disabled.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
