Return-Path: <linux-kernel-owner+w=401wt.eu-S1759786AbYFYOlX@vger.kernel.org>
Message-Id: <20080625143613.404764058@de.ibm.com>
References: <20080625143459.100139455@de.ibm.com>
Date: Wed, 25 Jun 2008 16:35:07 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 08/21] Cleanup printk messages in dcssblk.
Content-Disposition: inline; filename=807-printk-dcss.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Hongjie Yang <hongjie@us.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Hongjie Yang <hongjie@us.ibm.com>

Signed-off-by: Hongjie Yang <hongjie@us.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dcssblk.c |   22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

Index: quilt-2.6/drivers/s390/block/dcssblk.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dcssblk.c
+++ quilt-2.6/drivers/s390/block/dcssblk.c
@@ -167,10 +167,8 @@ dcssblk_shared_store(struct device *dev,
 	struct dcssblk_dev_info *dev_info;
 	int rc;
 
-	if ((count > 1) && (inbuf[1] != '\n') && (inbuf[1] != '\0')) {
-		PRINT_WARN("Invalid value, must be 0 or 1\n");
+	if ((count > 1) && (inbuf[1] != '\n') && (inbuf[1] != '\0'))
 		return -EINVAL;
-	}
 	down_write(&dcssblk_devices_sem);
 	dev_info = container_of(dev, struct dcssblk_dev_info, dev);
 	if (atomic_read(&dev_info->use_count)) {
@@ -215,7 +213,6 @@ dcssblk_shared_store(struct device *dev,
 			set_disk_ro(dev_info->gd, 0);
 		}
 	} else {
-		PRINT_WARN("Invalid value, must be 0 or 1\n");
 		rc = -EINVAL;
 		goto out;
 	}
@@ -258,10 +255,8 @@ dcssblk_save_store(struct device *dev, s
 {
 	struct dcssblk_dev_info *dev_info;
 
-	if ((count > 1) && (inbuf[1] != '\n') && (inbuf[1] != '\0')) {
-		PRINT_WARN("Invalid value, must be 0 or 1\n");
+	if ((count > 1) && (inbuf[1] != '\n') && (inbuf[1] != '\0'))
 		return -EINVAL;
-	}
 	dev_info = container_of(dev, struct dcssblk_dev_info, dev);
 
 	down_write(&dcssblk_devices_sem);
@@ -289,7 +284,6 @@ dcssblk_save_store(struct device *dev, s
 		}
 	} else {
 		up_write(&dcssblk_devices_sem);
-		PRINT_WARN("Invalid value, must be 0 or 1\n");
 		return -EINVAL;
 	}
 	up_write(&dcssblk_devices_sem);
@@ -441,7 +435,6 @@ dcssblk_add_store(struct device *dev, st
 	goto out;
 
 unregister_dev:
-	PRINT_ERR("device_create_file() failed!\n");
 	list_del(&dev_info->lh);
 	blk_cleanup_queue(dev_info->dcssblk_queue);
 	dev_info->gd->queue = NULL;
@@ -702,10 +695,8 @@ dcssblk_check_params(void)
 static void __exit
 dcssblk_exit(void)
 {
-	PRINT_DEBUG("DCSSBLOCK EXIT...\n");
 	s390_root_dev_unregister(dcssblk_root_dev);
 	unregister_blkdev(dcssblk_major, DCSSBLK_NAME);
-	PRINT_DEBUG("...finished!\n");
 }
 
 static int __init
@@ -713,27 +704,21 @@ dcssblk_init(void)
 {
 	int rc;
 
-	PRINT_DEBUG("DCSSBLOCK INIT...\n");
 	dcssblk_root_dev = s390_root_dev_register("dcssblk");
-	if (IS_ERR(dcssblk_root_dev)) {
-		PRINT_ERR("device_register() failed!\n");
+	if (IS_ERR(dcssblk_root_dev))
 		return PTR_ERR(dcssblk_root_dev);
-	}
 	rc = device_create_file(dcssblk_root_dev, &dev_attr_add);
 	if (rc) {
-		PRINT_ERR("device_create_file(add) failed!\n");
 		s390_root_dev_unregister(dcssblk_root_dev);
 		return rc;
 	}
 	rc = device_create_file(dcssblk_root_dev, &dev_attr_remove);
 	if (rc) {
-		PRINT_ERR("device_create_file(remove) failed!\n");
 		s390_root_dev_unregister(dcssblk_root_dev);
 		return rc;
 	}
 	rc = register_blkdev(0, DCSSBLK_NAME);
 	if (rc < 0) {
-		PRINT_ERR("Can't get dynamic major!\n");
 		s390_root_dev_unregister(dcssblk_root_dev);
 		return rc;
 	}
@@ -742,7 +727,6 @@ dcssblk_init(void)
 
 	dcssblk_check_params();
 
-	PRINT_DEBUG("...finished!\n");
 	return 0;
 }
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
