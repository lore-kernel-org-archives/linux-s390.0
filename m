Return-Path: <linux-kernel-owner+w=401wt.eu-S1755947AbXD0OLw@vger.kernel.org>
Message-Id: <20070427140518.425608573@de.ibm.com>
References: <20070427140503.087958775@de.ibm.com>
Date: Fri, 27 Apr 2007 16:05:31 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 28/38] sclp: initialize early.
Content-Disposition: inline; filename=131-sclp-init.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Add explicit sclp initialization for those sclp users that do not
register with the interface.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/sclp.c |    8 ++++++++
 1 files changed, 8 insertions(+)

Index: quilt-2.6/drivers/s390/char/sclp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp.c	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/drivers/s390/char/sclp.c	2007-04-27 16:04:59.000000000 +0200
@@ -15,6 +15,7 @@
 #include <linux/timer.h>
 #include <linux/reboot.h>
 #include <linux/jiffies.h>
+#include <linux/init.h>
 #include <asm/types.h>
 #include <asm/s390_ext.h>
 
@@ -930,3 +931,10 @@
 	sclp_init_mask(1);
 	return 0;
 }
+
+static __init int sclp_initcall(void)
+{
+	return sclp_init();
+}
+
+arch_initcall(sclp_initcall);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
