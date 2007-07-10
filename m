Return-Path: <linux-kernel-owner+w=401wt.eu-S1764638AbXGJJb3@vger.kernel.org>
Message-Id: <20070710093118.053202681@de.ibm.com>
References: <20070710092935.896013926@de.ibm.com>
Date: Tue, 10 Jul 2007 11:29:44 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 09/16] Program check in diag 210 under 31 bit
Content-Disposition: inline; filename=009-diag210.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Michael Holzheu <holzheu@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Holzheu <holzheu@de.ibm.com>

If a virtual address is passed to the diag210 function under 31 bit, we get a
programming exception, since diag 210 only works with physical addresses. To
fix this, the content of the diag210 data structure is copied to a local
structure and the physical address of that structure is passed to diagnose 210.

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device_id.c |   22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

Index: quilt-2.6/drivers/s390/cio/device_id.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_id.c
+++ quilt-2.6/drivers/s390/cio/device_id.c
@@ -27,7 +27,6 @@
 /*
  * diag210 is used under VM to get information about a virtual device
  */
-#ifdef CONFIG_64BIT
 int
 diag210(struct diag210 * addr)
 {
@@ -43,6 +42,7 @@ diag210(struct diag210 * addr)
 	spin_lock_irqsave(&diag210_lock, flags);
 	diag210_tmp = *addr;
 
+#ifdef CONFIG_64BIT
 	asm volatile(
 		"	lhi	%0,-1\n"
 		"	sam31\n"
@@ -51,19 +51,8 @@ diag210(struct diag210 * addr)
 		"	srl	%0,28\n"
 		"1:	sam64\n"
 		EX_TABLE(0b,1b)
-		: "=&d" (ccode) : "a" (__pa(&diag210_tmp)) : "cc", "memory");
-
-	*addr = diag210_tmp;
-	spin_unlock_irqrestore(&diag210_lock, flags);
-
-	return ccode;
-}
+		: "=&d" (ccode) : "a" (&diag210_tmp) : "cc", "memory");
 #else
-int
-diag210(struct diag210 * addr)
-{
-	int ccode;
-
 	asm volatile(
 		"	lhi	%0,-1\n"
 		"	diag	%1,0,0x210\n"
@@ -71,11 +60,14 @@ diag210(struct diag210 * addr)
 		"	srl	%0,28\n"
 		"1:\n"
 		EX_TABLE(0b,1b)
-		: "=&d" (ccode) : "a" (__pa(addr)) : "cc", "memory");
+		: "=&d" (ccode) : "a" (&diag210_tmp) : "cc", "memory");
+#endif
+
+	*addr = diag210_tmp;
+	spin_unlock_irqrestore(&diag210_lock, flags);
 
 	return ccode;
 }
-#endif
 
 /*
  * Input :

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
