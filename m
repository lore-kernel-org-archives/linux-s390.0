Return-Path: <linux-kernel-owner+w=401wt.eu-S932798AbXCZV1x@vger.kernel.org>
Message-Id: <20070326212641.300051199@de.ibm.com>
References: <20070326212459.711271424@de.ibm.com>
Date: Mon, 26 Mar 2007 23:25:06 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [patch 7/8] dasd: Add ipldev parameter.
Content-Disposition: inline; filename=115-dasd-ipldev.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Specifying 'ipldev' in the dasd= kernel parameter will automatically
activate the boot device for use by the dasd driver.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/block/dasd_devmap.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+)

Index: linux-2.6/drivers/s390/block/dasd_devmap.c
===================================================================
--- linux-2.6.orig/drivers/s390/block/dasd_devmap.c
+++ linux-2.6/drivers/s390/block/dasd_devmap.c
@@ -19,6 +19,7 @@
 
 #include <asm/debug.h>
 #include <asm/uaccess.h>
+#include <asm/ipl.h>
 
 /* This is ugly... */
 #define PRINTK_HEADER "dasd_devmap:"
@@ -133,6 +134,8 @@ dasd_call_setup(char *str)
 __setup ("dasd=", dasd_call_setup);
 #endif	/* #ifndef MODULE */
 
+#define	DASD_IPLDEV	"ipldev"
+
 /*
  * Read a device busid/devno from a string.
  */
@@ -141,6 +144,20 @@ dasd_busid(char **str, int *id0, int *id
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
