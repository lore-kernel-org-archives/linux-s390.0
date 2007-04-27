Return-Path: <linux-kernel-owner+w=401wt.eu-S1755925AbXD0ON5@vger.kernel.org>
Message-Id: <20070427140517.673458804@de.ibm.com>
References: <20070427140503.087958775@de.ibm.com>
Date: Fri, 27 Apr 2007 16:05:28 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 25/38] dasd: Add ipldev parameter.
Content-Disposition: inline; filename=128-dasd-ipldev.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Specifying 'ipldev' in the dasd= kernel parameter will automatically
activate the boot device for use by the dasd driver.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd_devmap.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+)

Index: quilt-2.6/drivers/s390/block/dasd_devmap.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_devmap.c	2007-04-27 16:04:58.000000000 +0200
+++ quilt-2.6/drivers/s390/block/dasd_devmap.c	2007-04-27 16:04:58.000000000 +0200
@@ -19,6 +19,7 @@
 
 #include <asm/debug.h>
 #include <asm/uaccess.h>
+#include <asm/ipl.h>
 
 /* This is ugly... */
 #define PRINTK_HEADER "dasd_devmap:"
@@ -133,6 +134,8 @@
 __setup ("dasd=", dasd_call_setup);
 #endif	/* #ifndef MODULE */
 
+#define	DASD_IPLDEV	"ipldev"
+
 /*
  * Read a device busid/devno from a string.
  */
@@ -141,6 +144,20 @@
 {
 	int val, old_style;
 
+	/* Interpret ipldev busid */
+	if (strncmp(DASD_IPLDEV, *str, strlen(DASD_IPLDEV)) == 0) {
+		if (ipl_info.type != IPL_TYPE_CCW) {
+			MESSAGE(KERN_ERR, "%s", "ipl device is not a ccw "
+				"device");
+			return -EINVAL;
+		}
+		*id0 = 0;
+		*id1 = ipl_info.data.ccw.dev_id.ssid;
+		*devno = ipl_info.data.ccw.dev_id.devno;
+		*str += strlen(DASD_IPLDEV);
+
+		return 0;
+	}
 	/* check for leading '0x' */
 	old_style = 0;
 	if ((*str)[0] == '0' && (*str)[1] == 'x') {

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
