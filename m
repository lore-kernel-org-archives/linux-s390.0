Return-Path: <linux-kernel-owner+w=401wt.eu-S1757518AbYK0Kti@vger.kernel.org>
Message-Id: <20081127103143.214121077@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:31:15 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 55/60] convert zfcp dumper printks to pr_xxx macros.
Content-Disposition: inline; filename=170-kmsg-zcore.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Holzheu <holzheu@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Holzheu <holzheu@de.ibm.com>

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/zcore.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

Index: quilt-2.6/drivers/s390/char/zcore.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/zcore.c
+++ quilt-2.6/drivers/s390/char/zcore.c
@@ -9,6 +9,9 @@
  * Author(s): Michael Holzheu
  */
 
+#define KMSG_COMPONENT "zdump"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/init.h>
 #include <linux/miscdevice.h>
 #include <linux/utsname.h>
@@ -24,8 +27,6 @@
 #include "sclp.h"
 
 #define TRACE(x...) debug_sprintf_event(zcore_dbf, 1, x)
-#define MSG(x...) printk( KERN_ALERT x )
-#define ERROR_MSG(x...) printk ( KERN_ALERT "DUMP: " x )
 
 #define TO_USER		0
 #define TO_KERNEL	1
@@ -563,19 +564,19 @@ static int __init sys_info_init(enum arc
 
 	switch (arch) {
 	case ARCH_S390X:
-		MSG("DETECTED 'S390X (64 bit) OS'\n");
+		pr_alert("DETECTED 'S390X (64 bit) OS'\n");
 		sys_info.sa_base = SAVE_AREA_BASE_S390X;
 		sys_info.sa_size = sizeof(struct save_area_s390x);
 		set_s390x_lc_mask(&sys_info.lc_mask);
 		break;
 	case ARCH_S390:
-		MSG("DETECTED 'S390 (32 bit) OS'\n");
+		pr_alert("DETECTED 'S390 (32 bit) OS'\n");
 		sys_info.sa_base = SAVE_AREA_BASE_S390;
 		sys_info.sa_size = sizeof(struct save_area_s390);
 		set_s390_lc_mask(&sys_info.lc_mask);
 		break;
 	default:
-		ERROR_MSG("unknown architecture 0x%x.\n",arch);
+		pr_alert("0x%x is an unknown architecture.\n",arch);
 		return -EINVAL;
 	}
 	sys_info.arch = arch;
@@ -674,7 +675,8 @@ static int __init zcore_init(void)
 
 #ifndef __s390x__
 	if (arch == ARCH_S390X) {
-		ERROR_MSG("32 bit dumper can't dump 64 bit system!\n");
+		pr_alert("The 32-bit dump tool cannot be used for a "
+			 "64-bit system\n");
 		rc = -EINVAL;
 		goto fail;
 	}

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
