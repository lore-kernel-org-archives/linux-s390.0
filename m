Return-Path: <linux-kernel-owner+w=401wt.eu-S1756599AbYK0Kme@vger.kernel.org>
Message-Id: <20081127103138.667270661@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:30:59 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 39/60] convert vmur printks to pr_xxx macros.
Content-Disposition: inline; filename=154-kmsg-vmur.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Frank Munzert <munzert@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Frank Munzert <munzert@de.ibm.com>

Signed-off-by: Frank Munzert <munzert@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/vmur.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

Index: quilt-2.6/drivers/s390/char/vmur.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/vmur.c
+++ quilt-2.6/drivers/s390/char/vmur.c
@@ -8,6 +8,9 @@
  *	    Frank Munzert <munzert@de.ibm.com>
  */
 
+#define KMSG_COMPONENT "vmur"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/cdev.h>
 #include <linux/smp_lock.h>
 
@@ -40,8 +43,6 @@ MODULE_AUTHOR("IBM Corporation");
 MODULE_DESCRIPTION("s390 z/VM virtual unit record device driver");
 MODULE_LICENSE("GPL");
 
-#define PRINTK_HEADER "vmur: "
-
 static dev_t ur_first_dev_maj_min;
 static struct class *vmur_class;
 static struct debug_info *vmur_dbf;
@@ -987,7 +988,8 @@ static int __init ur_init(void)
 	dev_t dev;
 
 	if (!MACHINE_IS_VM) {
-		PRINT_ERR("%s is only available under z/VM.\n", ur_banner);
+		pr_err("The %s cannot be loaded without z/VM\n",
+		       ur_banner);
 		return -ENODEV;
 	}
 
@@ -1006,7 +1008,8 @@ static int __init ur_init(void)
 
 	rc = alloc_chrdev_region(&dev, 0, NUM_MINORS, "vmur");
 	if (rc) {
-		PRINT_ERR("alloc_chrdev_region failed: err = %d\n", rc);
+		pr_err("Kernel function alloc_chrdev_region failed with "
+		       "error code %d\n", rc);
 		goto fail_unregister_driver;
 	}
 	ur_first_dev_maj_min = MKDEV(MAJOR(dev), 0);
@@ -1016,7 +1019,7 @@ static int __init ur_init(void)
 		rc = PTR_ERR(vmur_class);
 		goto fail_unregister_region;
 	}
-	PRINT_INFO("%s loaded.\n", ur_banner);
+	pr_info("%s loaded.\n", ur_banner);
 	return 0;
 
 fail_unregister_region:
@@ -1034,7 +1037,7 @@ static void __exit ur_exit(void)
 	unregister_chrdev_region(ur_first_dev_maj_min, NUM_MINORS);
 	ccw_driver_unregister(&ur_driver);
 	debug_unregister(vmur_dbf);
-	PRINT_INFO("%s unloaded.\n", ur_banner);
+	pr_info("%s unloaded.\n", ur_banner);
 }
 
 module_init(ur_init);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
