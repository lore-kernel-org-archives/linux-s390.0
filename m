Return-Path: <linux-kernel-owner+w=401wt.eu-S1760795AbYG1R4p@vger.kernel.org>
Message-Id: <20080728175513.667893892@de.ibm.com>
References: <20080728175355.734299984@de.ibm.com>
Date: Mon, 28 Jul 2008 19:54:07 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 12/15] kmsg: convert appldata printk messages to kmsg api.
Content-Disposition: inline; filename=812-kmsg-appldata.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Gerald Schaefer <gerald.schaefer@de.ibm.com>

Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 Documentation/s390/kmsg/appldata   |   93 +++++++++++++++++++++++++++++++++++++
 arch/s390/appldata/appldata.h      |    4 -
 arch/s390/appldata/appldata_base.c |   11 ++--
 arch/s390/appldata/appldata_os.c   |   20 +++----
 4 files changed, 107 insertions(+), 21 deletions(-)

Index: quilt-2.6/arch/s390/appldata/appldata_base.c
===================================================================
--- quilt-2.6.orig/arch/s390/appldata/appldata_base.c
+++ quilt-2.6/arch/s390/appldata/appldata_base.c
@@ -28,11 +28,12 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/smp.h>
+#include <asm/kmsg.h>
 
 #include "appldata.h"
 
 
-#define MY_PRINT_NAME	"appldata"		/* for debug messages, etc. */
+#define KMSG_COMPONENT	"appldata"
 #define APPLDATA_CPU_INTERVAL	10000		/* default (CPU) time for
 						   sampling interval in
 						   milliseconds */
@@ -390,8 +391,8 @@ appldata_generic_handler(ctl_table *ctl,
 					(unsigned long) ops->data, ops->size,
 					ops->mod_lvl);
 		if (rc != 0) {
-			P_ERROR("START DIAG 0xDC for %s failed, "
-				"return code: %d\n", ops->name, rc);
+			kmsg_err(1, "Starting the data collection for %s "
+				 "failed with rc=%d\n", ops->name, rc);
 			module_put(ops->owner);
 		} else
 			ops->active = 1;
@@ -401,8 +402,8 @@ appldata_generic_handler(ctl_table *ctl,
 				(unsigned long) ops->data, ops->size,
 				ops->mod_lvl);
 		if (rc != 0)
-			P_ERROR("STOP DIAG 0xDC for %s failed, "
-				"return code: %d\n", ops->name, rc);
+			kmsg_err(2, "Stopping the data collection for %s "
+				 "failed with rc=%d\n", ops->name, rc);
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
@@ -18,11 +18,12 @@
 #include <linux/sched.h>
 #include <asm/appldata.h>
 #include <asm/smp.h>
+#include <asm/kmsg.h>
 
 #include "appldata.h"
 
 
-#define MY_PRINT_NAME	"appldata_os"		/* for debug messages, etc. */
+#define KMSG_COMPONENT	"appldata"
 #define LOAD_INT(x) ((x) >> FSHIFT)
 #define LOAD_FRAC(x) LOAD_INT(((x) & (FIXED_1-1)) * 100)
 
@@ -143,21 +144,16 @@ static void appldata_get_os_data(void *d
 					   (unsigned long) ops.data, new_size,
 					   ops.mod_lvl);
 			if (rc != 0)
-				P_ERROR("os: START NEW DIAG 0xDC failed, "
-					"return code: %d, new size = %i\n", rc,
-					new_size);
+				kmsg_err(3, "Starting a new OS data collection "
+					 "failed with rc=%d\n", rc);
 
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
+				kmsg_err(4, "Stopping a faulty OS data "
+					 "collection failed with rc=%d\n", rc);
 		}
 		ops.size = new_size;
 	}
@@ -178,8 +174,8 @@ static int __init appldata_os_init(void)
 	max_size = sizeof(struct appldata_os_data) +
 		   (NR_CPUS * sizeof(struct appldata_os_per_cpu));
 	if (max_size > APPLDATA_MAX_REC_SIZE) {
-		P_ERROR("Max. size of OS record = %i, bigger than maximum "
-			"record size (%i)\n", max_size, APPLDATA_MAX_REC_SIZE);
+		kmsg_err(5, "Maximum OS record size %i exceeds the maximum "
+			 "record size %i\n", max_size, APPLDATA_MAX_REC_SIZE);
 		rc = -ENOMEM;
 		goto out;
 	}
Index: quilt-2.6/Documentation/s390/kmsg/appldata
===================================================================
--- /dev/null
+++ quilt-2.6/Documentation/s390/kmsg/appldata
@@ -0,0 +1,93 @@
+/*?
+ * Tag: appldata.1
+ * Text: "Starting the data collection for %s failed with rc=%d"
+ * Severity: Error
+ * Parameter:
+ *   @1: appldata module
+ *   @2: return code
+ * Description:
+ * The specified data collection module used the z/VM diagnose call
+ * DIAG 0xDC to start writing data. z/VM returned an error and the data
+ * collection could not start. If the return code is 5, your z/VM guest
+ * virtual machine is not authorized to write data records.
+ * User action:
+ * If the return code is 5, ensure that your z/VM guest virtual machine's
+ * entry in the z/VM directory includes the OPTION APPLMON statement.
+ * For other return codes see the section about DIAGNOSE Code X'DC'
+ * in "z/VM CP Programming Services".
+ */
+
+/*?
+ * Tag: appldata.2
+ * Text: "Stopping the data collection for %s failed with rc=%d"
+ * Severity: Error
+ * Parameter:
+ *   @1: appldata module
+ *   @2: return code
+ * Description:
+ * The specified data collection module used the z/VM diagnose call DIAG 0xDC
+ * to stop writing data. z/VM returned an error and the data collection
+ * continues.
+ * User action:
+ * See the section about DIAGNOSE Code X'DC' in "z/VM CP Programming Services".
+ */
+
+/*?
+ * Tag: appldata.3
+ * Text: "Starting a new OS data collection failed with rc=%d"
+ * Severity: Error
+ * Parameter:
+ *   @1: return code
+ * Description:
+ * After a CPU hotplug event, the record size for the running operating
+ * system data collection is no longer correct. The appldata_os module tried
+ * to start a new data collection with the correct record size but received
+ * an error from the z/VM diagnose call DIAG 0xDC. Any data collected with
+ * the current record size might be faulty.
+ * User action:
+ * Start a new data collection with the cappldata_os module. For information
+ * about starting data collections see "Device Drivers, Features, and
+ * Commands". For information about the return codes see the section about
+ * DIAGNOSE Code X'DC' in "z/VM CP Programming Services".
+ */
+
+/*?
+ * Tag: appldata.4
+ * Text: "Stopping a faulty OS data collection failed with rc=%d"
+ * Severity: Error
+ * Parameter:
+ *   @1: return code
+ * Description:
+ * After a CPU hotplug event, the record size for the running operating
+ * system data collection is no longer correct. The appldata_os module tried
+ * to stop the faulty data collection but received an error from the z/VM
+ * diagnose call DIAG 0xDC. Any data collected with the current record size
+ * might be faulty.
+ * User action:
+ * Try to restart appldata_os monitoring. For information about stopping
+ * and starting data collections see "Device Drivers, Features, and
+ * Commands". For information about the return codes see the section about
+ * DIAGNOSE Code X'DC' in "z/VM CP Programming Services".
+ */
+
+/*?
+ * Tag: appldata.5
+ * Text: "Maximum OS record size %i exceeds the maximum record size %i"
+ * Severity: Error
+ * Parameter:
+ *   @1: no of bytes
+ *   @2: no of bytes
+ * Description:
+ * The OS record size grows with the number of CPUs and is adjusted by the
+ * appldata_os module in response to CPU hotplug events. For more than 110
+ * CPUs the record size would exceed the maximum record size of 4024 bytes
+ * that is  supported by the z/VM hypervisor. To prevent the maximum supported
+ * record size from being exceeded while data collection is in progress,
+ * you cannot load the appldata_os module on Linux instances that are
+ * configured for a maximum of more than 110 CPUs.
+ * User action:
+ * If you do not want to collect operating system data, you can ignore this
+ * message. If you want to collect operating system data, reconfigure your
+ * Linux instance to support less than 110 CPUs.
+ */
+

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
