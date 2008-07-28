Return-Path: <linux-kernel-owner+w=401wt.eu-S1760832AbYG1R6X@vger.kernel.org>
Message-Id: <20080728175512.224375633@de.ibm.com>
References: <20080728175355.734299984@de.ibm.com>
Date: Mon, 28 Jul 2008 19:54:01 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 06/15] kmsg: convert vmur to kmsg api.
Content-Disposition: inline; filename=805-kmsg-vmur.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Frank Munzert <munzert@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Frank Munzert <munzert@de.ibm.com>

Signed-off-by: Frank Munzert <munzert@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 Documentation/s390/kmsg/vmur |   33 +++++++++++++++++++++++++++++++++
 drivers/s390/char/vmur.c     |   13 ++++++++-----
 2 files changed, 41 insertions(+), 5 deletions(-)

Index: quilt-2.6/Documentation/s390/kmsg/vmur
===================================================================
--- /dev/null
+++ quilt-2.6/Documentation/s390/kmsg/vmur
@@ -0,0 +1,33 @@
+/*?
+ * Tag: vmur.1
+ * Text: "The %s cannot be loaded without z/VM"
+ * Severity: Error
+ * Parameter:
+ *   @1: z/VM virtual unit record device driver
+ * Description:
+ * The z/VM virtual unit record device driver provides Linux with access to
+ * z/VM virtual unit record devices like punch card readers, card punches, and
+ * line printers. On Linux instances that run in environments other than the
+ * z/VM hypervisor, the device driver does not provide any useful function and
+ * the corresponding vmur module cannot be loaded.
+ * User action:
+ * Load the vmur module only on Linux instances that run as guest operating
+ * systems of the z/VM hypervisor. If the z/VM virtual unit record device
+ * has been compiled into the kernel, ignore this message.
+ */
+
+/*?
+ * Tag: vmur.2
+ * Text: "Kernel function alloc_chrdev_region failed with error code %d"
+ * Severity: Error
+ * Parameter:
+ *   @1: error code according to errno definitions
+ * Description:
+ * The z/VM virtual unit record device driver (vmur) needs to register a range
+ * of character device minor numbers from 0x0000 to 0xffff.
+ * This registration failed, probably because of memory constraints.
+ * User action:
+ * Free some memory and reload the vmur module. If the z/VM virtual unit
+ * record device driver has been compiled into the kernel reboot Linux.
+ * Consider assigning more memory to your LPAR or z/VM guest virtual machine.
+ */
Index: quilt-2.6/drivers/s390/char/vmur.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/vmur.c
+++ quilt-2.6/drivers/s390/char/vmur.c
@@ -16,6 +16,7 @@
 #include <asm/ccwdev.h>
 #include <asm/debug.h>
 #include <asm/diag.h>
+#include <asm/kmsg.h>
 
 #include "vmur.h"
 
@@ -40,7 +41,7 @@ MODULE_AUTHOR("IBM Corporation");
 MODULE_DESCRIPTION("s390 z/VM virtual unit record device driver");
 MODULE_LICENSE("GPL");
 
-#define PRINTK_HEADER "vmur: "
+#define KMSG_COMPONENT "vmur"
 
 static dev_t ur_first_dev_maj_min;
 static struct class *vmur_class;
@@ -988,7 +989,8 @@ static int __init ur_init(void)
 	dev_t dev;
 
 	if (!MACHINE_IS_VM) {
-		PRINT_ERR("%s is only available under z/VM.\n", ur_banner);
+		kmsg_err(1, "The %s cannot be loaded without z/VM\n",
+			 ur_banner);
 		return -ENODEV;
 	}
 
@@ -1007,7 +1009,8 @@ static int __init ur_init(void)
 
 	rc = alloc_chrdev_region(&dev, 0, NUM_MINORS, "vmur");
 	if (rc) {
-		PRINT_ERR("alloc_chrdev_region failed: err = %d\n", rc);
+		kmsg_err(2, "Kernel function alloc_chrdev_region failed with "
+			 "error code %d\n", rc);
 		goto fail_unregister_driver;
 	}
 	ur_first_dev_maj_min = MKDEV(MAJOR(dev), 0);
@@ -1017,7 +1020,7 @@ static int __init ur_init(void)
 		rc = PTR_ERR(vmur_class);
 		goto fail_unregister_region;
 	}
-	PRINT_INFO("%s loaded.\n", ur_banner);
+	kmsg_info(0, "%s loaded.\n", ur_banner);
 	return 0;
 
 fail_unregister_region:
@@ -1035,7 +1038,7 @@ static void __exit ur_exit(void)
 	unregister_chrdev_region(ur_first_dev_maj_min, NUM_MINORS);
 	ccw_driver_unregister(&ur_driver);
 	debug_unregister(vmur_dbf);
-	PRINT_INFO("%s unloaded.\n", ur_banner);
+	kmsg_info(0, "%s unloaded.\n", ur_banner);
 }
 
 module_init(ur_init);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
