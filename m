Return-Path: <linux-kernel-owner+w=401wt.eu-S1760107AbZFDQ32@vger.kernel.org>
Message-Id: <20090604161908.529698385@de.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
Date: Thu, 04 Jun 2009 18:19:24 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 37/38] pm: dcssblk power management callbacks.
Content-Disposition: inline; filename=pm_dcssblk.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Gerald Schaefer <gerald.schaefer@de.ibm.com>

Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 drivers/s390/block/dcssblk.c |  132 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 115 insertions(+), 17 deletions(-)

Index: linux-2.6/drivers/s390/block/dcssblk.c
===================================================================
--- linux-2.6.orig/drivers/s390/block/dcssblk.c
+++ linux-2.6/drivers/s390/block/dcssblk.c
@@ -14,10 +14,11 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/blkdev.h>
-#include <asm/extmem.h>
-#include <asm/io.h>
 #include <linux/completion.h>
 #include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <asm/extmem.h>
+#include <asm/io.h>
 
 #define DCSSBLK_NAME "dcssblk"
 #define DCSSBLK_MINORS_PER_DISK 1
@@ -940,11 +941,94 @@ dcssblk_check_params(void)
 }
 
 /*
+ * Suspend / Resume
+ */
+static int dcssblk_freeze(struct device *dev)
+{
+	struct dcssblk_dev_info *dev_info;
+	int rc = 0;
+
+	list_for_each_entry(dev_info, &dcssblk_devices, lh) {
+		switch (dev_info->segment_type) {
+			case SEG_TYPE_SR:
+			case SEG_TYPE_ER:
+			case SEG_TYPE_SC:
+				if (!dev_info->is_shared)
+					rc = -EINVAL;
+				break;
+			default:
+				rc = -EINVAL;
+				break;
+		}
+		if (rc)
+			break;
+	}
+	if (rc)
+		pr_err("Suspend failed because device %s is writeable.\n",
+		       dev_info->segment_name);
+	return rc;
+}
+
+static int dcssblk_restore(struct device *dev)
+{
+	struct dcssblk_dev_info *dev_info;
+	struct segment_info *entry;
+	unsigned long start, end;
+	int rc = 0;
+
+	list_for_each_entry(dev_info, &dcssblk_devices, lh) {
+		list_for_each_entry(entry, &dev_info->seg_list, lh) {
+			segment_unload(entry->segment_name);
+			rc = segment_load(entry->segment_name, SEGMENT_SHARED,
+					  &start, &end);
+			if (rc < 0) {
+// TODO in_use check ?
+				segment_warning(rc, entry->segment_name);
+				goto out_panic;
+			}
+			if (start != entry->start || end != entry->end) {
+				pr_err("Mismatch of start / end address after "
+				       "resuming device %s\n",
+				       entry->segment_name);
+				goto out_panic;
+			}
+		}
+	}
+	return 0;
+out_panic:
+	panic("fatal dcssblk resume error\n");
+}
+
+static int dcssblk_thaw(struct device *dev)
+{
+	return 0;
+}
+
+static struct dev_pm_ops dcssblk_pm_ops = {
+	.freeze		= dcssblk_freeze,
+	.thaw		= dcssblk_thaw,
+	.restore	= dcssblk_restore,
+};
+
+static struct platform_driver dcssblk_pdrv = {
+	.driver = {
+		.name	= "dcssblk",
+		.owner	= THIS_MODULE,
+		.pm	= &dcssblk_pm_ops,
+	},
+};
+
+static struct platform_device *dcssblk_pdev;
+
+
+/*
  * The init/exit functions.
  */
 static void __exit
 dcssblk_exit(void)
 {
+	platform_device_unregister(dcssblk_pdev);
+	platform_driver_unregister(&dcssblk_pdrv);
 	root_device_unregister(dcssblk_root_dev);
 	unregister_blkdev(dcssblk_major, DCSSBLK_NAME);
 }
@@ -954,30 +1038,44 @@ dcssblk_init(void)
 {
 	int rc;
 
-	dcssblk_root_dev = root_device_register("dcssblk");
-	if (IS_ERR(dcssblk_root_dev))
-		return PTR_ERR(dcssblk_root_dev);
-	rc = device_create_file(dcssblk_root_dev, &dev_attr_add);
-	if (rc) {
-		root_device_unregister(dcssblk_root_dev);
+	rc = platform_driver_register(&dcssblk_pdrv);
+	if (rc)
 		return rc;
+
+	dcssblk_pdev = platform_device_register_simple("dcssblk", -1, NULL,
+							0);
+	if (IS_ERR(dcssblk_pdev)) {
+		rc = PTR_ERR(dcssblk_pdev);
+		goto out_pdrv;
 	}
-	rc = device_create_file(dcssblk_root_dev, &dev_attr_remove);
-	if (rc) {
-		root_device_unregister(dcssblk_root_dev);
-		return rc;
+
+	dcssblk_root_dev = root_device_register("dcssblk");
+	if (IS_ERR(dcssblk_root_dev)) {
+		rc = PTR_ERR(dcssblk_root_dev);
+		goto out_pdev;
 	}
+	rc = device_create_file(dcssblk_root_dev, &dev_attr_add);
+	if (rc)
+		goto out_root;
+	rc = device_create_file(dcssblk_root_dev, &dev_attr_remove);
+	if (rc)
+		goto out_root;
 	rc = register_blkdev(0, DCSSBLK_NAME);
-	if (rc < 0) {
-		root_device_unregister(dcssblk_root_dev);
-		return rc;
-	}
+	if (rc < 0)
+		goto out_root;
 	dcssblk_major = rc;
 	init_rwsem(&dcssblk_devices_sem);
 
 	dcssblk_check_params();
-
 	return 0;
+
+out_root:
+	root_device_unregister(dcssblk_root_dev);
+out_pdev:
+	platform_device_unregister(dcssblk_pdev);
+out_pdrv:
+	platform_driver_unregister(&dcssblk_pdrv);
+	return rc;
 }
 
 module_init(dcssblk_init);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
