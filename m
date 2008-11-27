Return-Path: <linux-kernel-owner+w=401wt.eu-S1755784AbYK0KsM@vger.kernel.org>
Message-Id: <20081127103143.772706128@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:31:17 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 57/60] convert zfcp printks to pr_xxx macros.
Content-Disposition: inline; filename=172-kmsg-zfcp.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christof Schmitt <christof.schmitt@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christof Schmitt <christof.schmitt@de.ibm.com>

Signed-off-by: Christof Schmitt <christof.schmitt@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/scsi/zfcp_aux.c   |    9 ++++++---
 drivers/s390/scsi/zfcp_ccw.c   |    3 +++
 drivers/s390/scsi/zfcp_cfdc.c  |    3 +++
 drivers/s390/scsi/zfcp_dbf.c   |    3 +++
 drivers/s390/scsi/zfcp_erp.c   |    3 +++
 drivers/s390/scsi/zfcp_fc.c    |    3 +++
 drivers/s390/scsi/zfcp_fsf.c   |    3 +++
 drivers/s390/scsi/zfcp_qdio.c  |    3 +++
 drivers/s390/scsi/zfcp_scsi.c  |    3 +++
 drivers/s390/scsi/zfcp_sysfs.c |    3 +++
 10 files changed, 33 insertions(+), 3 deletions(-)

Index: quilt-2.6/drivers/s390/scsi/zfcp_aux.c
===================================================================
--- quilt-2.6.orig/drivers/s390/scsi/zfcp_aux.c
+++ quilt-2.6/drivers/s390/scsi/zfcp_aux.c
@@ -25,6 +25,9 @@
  *            Sven Schuetz
  */
 
+#define KMSG_COMPONENT "zfcp"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/miscdevice.h>
 #include <linux/seq_file.h>
 #include "zfcp_ext.h"
@@ -105,7 +108,7 @@ static int __init zfcp_device_setup(char
 
  err_out:
 	kfree(str);
-	pr_err("zfcp: %s is not a valid SCSI device\n", devstr);
+	pr_err("%s is not a valid SCSI device\n", devstr);
 	return 0;
 }
 
@@ -189,13 +192,13 @@ static int __init zfcp_module_init(void)
 
 	retval = misc_register(&zfcp_cfdc_misc);
 	if (retval) {
-		pr_err("zfcp: Registering the misc device zfcp_cfdc failed\n");
+		pr_err("Registering the misc device zfcp_cfdc failed\n");
 		goto out_misc;
 	}
 
 	retval = zfcp_ccw_register();
 	if (retval) {
-		pr_err("zfcp: The zfcp device driver could not register with "
+		pr_err("The zfcp device driver could not register with "
 		       "the common I/O layer\n");
 		goto out_ccw_register;
 	}
Index: quilt-2.6/drivers/s390/scsi/zfcp_ccw.c
===================================================================
--- quilt-2.6.orig/drivers/s390/scsi/zfcp_ccw.c
+++ quilt-2.6/drivers/s390/scsi/zfcp_ccw.c
@@ -6,6 +6,9 @@
  * Copyright IBM Corporation 2002, 2008
  */
 
+#define KMSG_COMPONENT "zfcp"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include "zfcp_ext.h"
 
 /**
Index: quilt-2.6/drivers/s390/scsi/zfcp_cfdc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/scsi/zfcp_cfdc.c
+++ quilt-2.6/drivers/s390/scsi/zfcp_cfdc.c
@@ -7,6 +7,9 @@
  * Copyright IBM Corporation 2008
  */
 
+#define KMSG_COMPONENT "zfcp"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/types.h>
 #include <linux/miscdevice.h>
 #include <asm/ccwdev.h>
Index: quilt-2.6/drivers/s390/scsi/zfcp_dbf.c
===================================================================
--- quilt-2.6.orig/drivers/s390/scsi/zfcp_dbf.c
+++ quilt-2.6/drivers/s390/scsi/zfcp_dbf.c
@@ -6,6 +6,9 @@
  * Copyright IBM Corporation 2002, 2008
  */
 
+#define KMSG_COMPONENT "zfcp"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/ctype.h>
 #include <asm/debug.h>
 #include "zfcp_ext.h"
Index: quilt-2.6/drivers/s390/scsi/zfcp_erp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/scsi/zfcp_erp.c
+++ quilt-2.6/drivers/s390/scsi/zfcp_erp.c
@@ -6,6 +6,9 @@
  * Copyright IBM Corporation 2002, 2008
  */
 
+#define KMSG_COMPONENT "zfcp"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include "zfcp_ext.h"
 
 #define ZFCP_MAX_ERPS                   3
Index: quilt-2.6/drivers/s390/scsi/zfcp_fc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/scsi/zfcp_fc.c
+++ quilt-2.6/drivers/s390/scsi/zfcp_fc.c
@@ -6,6 +6,9 @@
  * Copyright IBM Corporation 2008
  */
 
+#define KMSG_COMPONENT "zfcp"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include "zfcp_ext.h"
 
 struct ct_iu_gpn_ft_req {
Index: quilt-2.6/drivers/s390/scsi/zfcp_fsf.c
===================================================================
--- quilt-2.6.orig/drivers/s390/scsi/zfcp_fsf.c
+++ quilt-2.6/drivers/s390/scsi/zfcp_fsf.c
@@ -6,6 +6,9 @@
  * Copyright IBM Corporation 2002, 2008
  */
 
+#define KMSG_COMPONENT "zfcp"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/blktrace_api.h>
 #include "zfcp_ext.h"
 
Index: quilt-2.6/drivers/s390/scsi/zfcp_qdio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/scsi/zfcp_qdio.c
+++ quilt-2.6/drivers/s390/scsi/zfcp_qdio.c
@@ -6,6 +6,9 @@
  * Copyright IBM Corporation 2002, 2008
  */
 
+#define KMSG_COMPONENT "zfcp"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include "zfcp_ext.h"
 
 /* FIXME(tune): free space should be one max. SBAL chain plus what? */
Index: quilt-2.6/drivers/s390/scsi/zfcp_scsi.c
===================================================================
--- quilt-2.6.orig/drivers/s390/scsi/zfcp_scsi.c
+++ quilt-2.6/drivers/s390/scsi/zfcp_scsi.c
@@ -6,6 +6,9 @@
  * Copyright IBM Corporation 2002, 2008
  */
 
+#define KMSG_COMPONENT "zfcp"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include "zfcp_ext.h"
 #include <asm/atomic.h>
 
Index: quilt-2.6/drivers/s390/scsi/zfcp_sysfs.c
===================================================================
--- quilt-2.6.orig/drivers/s390/scsi/zfcp_sysfs.c
+++ quilt-2.6/drivers/s390/scsi/zfcp_sysfs.c
@@ -6,6 +6,9 @@
  * Copyright IBM Corporation 2008
  */
 
+#define KMSG_COMPONENT "zfcp"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include "zfcp_ext.h"
 
 #define ZFCP_DEV_ATTR(_feat, _name, _mode, _show, _store) \

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
