Return-Path: <linux-kernel-owner+w=401wt.eu-S1758766AbXEaPea@vger.kernel.org>
Message-Id: <20070531153436.830155646@de.ibm.com>
References: <20070531142024.011160634@de.ibm.com>
Date: Thu, 31 May 2007 16:20:25 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 1/7] Add exception handler for diagnose 224
Content-Disposition: inline; filename=001-hypfs-fixup.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Michael Holzheu <holzheu@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Holzheu <holzheu@de.ibm.com>

To be able to run with the diagnose 224 switched off, a potential
specification exception has to be handled.

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/hypfs/hypfs_diag.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

Index: quilt-2.6/arch/s390/hypfs/hypfs_diag.c
===================================================================
--- quilt-2.6.orig/arch/s390/hypfs/hypfs_diag.c
+++ quilt-2.6/arch/s390/hypfs/hypfs_diag.c
@@ -481,9 +481,17 @@ out:
 
 /* Diagnose 224 functions */
 
-static void diag224(void *ptr)
+static int diag224(void *ptr)
 {
-	asm volatile("diag %0,%1,0x224" : :"d" (0), "d"(ptr) : "memory");
+	int rc = -ENOTSUPP;
+
+	asm volatile(
+		"	diag	%1,%2,0x224\n"
+		"0:	lhi	%0,0x0\n"
+		"1:\n"
+		EX_TABLE(0b,1b)
+		: "+d" (rc) :"d" (0), "d" (ptr) : "memory");
+	return rc;
 }
 
 static int diag224_get_name_table(void)
@@ -492,7 +500,10 @@ static int diag224_get_name_table(void)
 	diag224_cpu_names = kmalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!diag224_cpu_names)
 		return -ENOMEM;
-	diag224(diag224_cpu_names);
+	if (diag224(diag224_cpu_names)) {
+		kfree(diag224_cpu_names);
+		return -ENOTSUPP;
+	}
 	EBCASC(diag224_cpu_names + 16, (*diag224_cpu_names + 1) * 16);
 	return 0;
 }

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
