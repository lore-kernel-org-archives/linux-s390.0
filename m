Return-Path: <linux-kernel-owner+w=401wt.eu-S1755584AbZHNL0X@vger.kernel.org>
Message-Id: <20090814112616.769552700@de.ibm.com>
References: <20090814112517.982007860@de.ibm.com>
Date: Fri, 14 Aug 2009 13:25:35 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 18/34] hibernation: remove dead file
Content-Disposition: inline; filename=117-pm-dead-file.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

There is no caller of do_after_copyback() anywhere. Remove it.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/power/Makefile    |    1 -
 arch/s390/power/swsusp_64.c |   17 -----------------
 2 files changed, 18 deletions(-)

Index: quilt-2.6/arch/s390/power/Makefile
===================================================================
--- quilt-2.6.orig/arch/s390/power/Makefile
+++ quilt-2.6/arch/s390/power/Makefile
@@ -4,5 +4,4 @@
 
 obj-$(CONFIG_HIBERNATION) += suspend.o
 obj-$(CONFIG_HIBERNATION) += swsusp.o
-obj-$(CONFIG_HIBERNATION) += swsusp_64.o
 obj-$(CONFIG_HIBERNATION) += swsusp_asm64.o
Index: quilt-2.6/arch/s390/power/swsusp_64.c
===================================================================
--- quilt-2.6.orig/arch/s390/power/swsusp_64.c
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * Support for suspend and resume on s390
- *
- * Copyright IBM Corp. 2009
- *
- * Author(s): Hans-Joachim Picht <hans@linux.vnet.ibm.com>
- *
- */
-
-#include <asm/system.h>
-#include <linux/interrupt.h>
-
-void do_after_copyback(void)
-{
-	mb();
-}
-

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
