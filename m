Return-Path: <linux-kernel-owner+w=401wt.eu-S1757851AbYK0Kw1@vger.kernel.org>
Message-Id: <20081127103140.390785374@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:31:05 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 45/60] convert appldata printks to pr_xxx macros.
Content-Disposition: inline; filename=160-kmsg-appldata.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Gerald Schaefer <gerald.schaefer@de.ibm.com>

Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/appldata/appldata.h      |    4 ----
 arch/s390/appldata/appldata_base.c |   12 +++++++-----
 arch/s390/appldata/appldata_os.c   |   21 +++++++++------------
 3 files changed, 16 insertions(+), 21 deletions(-)

Index: quilt-2.6/arch/s390/appldata/appldata_base.c
===================================================================
--- quilt-2.6.orig/arch/s390/appldata/appldata_base.c
+++ quilt-2.6/arch/s390/appldata/appldata_base.c
@@ -10,6 +10,9 @@
  * Author: Gerald Schaefer <gerald.schaefer@de.ibm.com>
  */
 
+#define KMSG_COMPONENT	"appldata"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -32,7 +35,6 @@
 #include "appldata.h"
 
 
-#define MY_PRINT_NAME	"appldata"		/* for debug messages, etc. */
 #define APPLDATA_CPU_INTERVAL	10000		/* default (CPU) time for
 						   sampling interval in
 						   milliseconds */
@@ -390,8 +392,8 @@ appldata_generic_handler(ctl_table *ctl,
 					(unsigned long) ops->data, ops->size,
 					ops->mod_lvl);
 		if (rc != 0) {
-			P_ERROR("START DIAG 0xDC for %s failed, "
-				"return code: %d\n", ops->name, rc);
+			pr_err("Starting the data collection for %s "
+			       "failed with rc=%d\n", ops->name, rc);
 			module_put(ops->owner);
 		} else
 			ops->active = 1;
@@ -401,8 +403,8 @@ appldata_generic_handler(ctl_table *ctl,
 				(unsigned long) ops->data, ops->size,
 				ops->mod_lvl);
 		if (rc != 0)
-			P_ERROR("STOP DIAG 0xDC for %s failed, "
-				"return code: %d\n", ops->name, rc);
+			pr_err("Stopping the data collection for %s "
+			       "failed with rc=%d\n", ops->name, rc);
 		module_put(ops->owner);
 	}
 	spin_unlock(&appldata_ops_lock);
Index: quilt-2.6/arch/s390/appldata/appldata.h
===================================================================
--- quilt-2.6.orig/arch/s390/appldata/appldata.h
+++ quilt-2.6/arch/s390/appldata/appldata.h
@@ -26,10 +26,6 @@
 #define CTL_APPLDATA_NET_SUM	2125
 #define CTL_APPLDATA_PROC	2126
 
-#define P_INFO(x...)	printk(KERN_INFO MY_PRINT_NAME " info: " x)
-#define P_ERROR(x...)	printk(KERN_ERR MY_PRINT_NAME " error: " x)
-#define P_WARNING(x...)	printk(KERN_WARNING MY_PRINT_NAME " status: " x)
-
 struct appldata_ops {
 	struct list_head list;
 	struct ctl_table_header *sysctl_header;
Index: quilt-2.6/arch/s390/appldata/appldata_os.c
===================================================================
--- quilt-2.6.orig/arch/s390/appldata/appldata_os.c
+++ quilt-2.6/arch/s390/appldata/appldata_os.c
@@ -9,6 +9,9 @@
  * Author: Gerald Schaefer <gerald.schaefer@de.ibm.com>
  */
 
+#define KMSG_COMPONENT	"appldata"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -22,7 +25,6 @@
 #include "appldata.h"
 
 
-#define MY_PRINT_NAME	"appldata_os"		/* for debug messages, etc. */
 #define LOAD_INT(x) ((x) >> FSHIFT)
 #define LOAD_FRAC(x) LOAD_INT(((x) & (FIXED_1-1)) * 100)
 
@@ -143,21 +145,16 @@ static void appldata_get_os_data(void *d
 					   (unsigned long) ops.data, new_size,
 					   ops.mod_lvl);
 			if (rc != 0)
-				P_ERROR("os: START NEW DIAG 0xDC failed, "
-					"return code: %d, new size = %i\n", rc,
-					new_size);
+				pr_err("Starting a new OS data collection "
+				       "failed with rc=%d\n", rc);
 
 			rc = appldata_diag(APPLDATA_RECORD_OS_ID,
 					   APPLDATA_STOP_REC,
 					   (unsigned long) ops.data, ops.size,
 					   ops.mod_lvl);
 			if (rc != 0)
-				P_ERROR("os: STOP OLD DIAG 0xDC failed, "
-					"return code: %d, old size = %i\n", rc,
-					ops.size);
-			else
-				P_INFO("os: old record size = %i stopped\n",
-					ops.size);
+				pr_err("Stopping a faulty OS data "
+				       "collection failed with rc=%d\n", rc);
 		}
 		ops.size = new_size;
 	}
@@ -178,8 +175,8 @@ static int __init appldata_os_init(void)
 	max_size = sizeof(struct appldata_os_data) +
 		   (NR_CPUS * sizeof(struct appldata_os_per_cpu));
 	if (max_size > APPLDATA_MAX_REC_SIZE) {
-		P_ERROR("Max. size of OS record = %i, bigger than maximum "
-			"record size (%i)\n", max_size, APPLDATA_MAX_REC_SIZE);
+		pr_err("Maximum OS record size %i exceeds the maximum "
+		       "record size %i\n", max_size, APPLDATA_MAX_REC_SIZE);
 		rc = -ENOMEM;
 		goto out;
 	}

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
