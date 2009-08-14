Return-Path: <linux-kernel-owner+w=401wt.eu-S932155AbZHNL0t@vger.kernel.org>
Message-Id: <20090814112615.151258162@de.ibm.com>
References: <20090814112517.982007860@de.ibm.com>
Date: Fri, 14 Aug 2009 13:25:28 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 11/34] dasd: fix message naming
Content-Disposition: inline; filename=110-dasd-message-naming.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Haberland <stefan.haberland@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Haberland <stefan.haberland@de.ibm.com>

This patch fixes message naming so that generic dasd messages do not
contain the device discipline. For this purpose the dev_ makros are
replaced by pr_ makros for generic dasd messages.

Signed-off-by: Stefan Haberland <stefan.haberland@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd_3990_erp.c |    2 +-
 drivers/s390/block/dasd_alias.c    |    2 +-
 drivers/s390/block/dasd_diag.c     |    2 +-
 drivers/s390/block/dasd_eckd.c     |    2 +-
 drivers/s390/block/dasd_eer.c      |    2 +-
 drivers/s390/block/dasd_erp.c      |    4 ++--
 drivers/s390/block/dasd_fba.c      |    2 +-
 drivers/s390/block/dasd_ioctl.c    |   24 ++++++++++++------------
 8 files changed, 20 insertions(+), 20 deletions(-)

Index: quilt-2.6/drivers/s390/block/dasd_3990_erp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_3990_erp.c
+++ quilt-2.6/drivers/s390/block/dasd_3990_erp.c
@@ -7,7 +7,7 @@
  *
  */
 
-#define KMSG_COMPONENT "dasd"
+#define KMSG_COMPONENT "dasd-eckd"
 
 #include <linux/timer.h>
 #include <linux/slab.h>
Index: quilt-2.6/drivers/s390/block/dasd_alias.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_alias.c
+++ quilt-2.6/drivers/s390/block/dasd_alias.c
@@ -5,7 +5,7 @@
  * Author(s): Stefan Weinhuber <wein@de.ibm.com>
  */
 
-#define KMSG_COMPONENT "dasd"
+#define KMSG_COMPONENT "dasd-eckd"
 
 #include <linux/list.h>
 #include <asm/ebcdic.h>
Index: quilt-2.6/drivers/s390/block/dasd_diag.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_diag.c
+++ quilt-2.6/drivers/s390/block/dasd_diag.c
@@ -8,7 +8,7 @@
  *
  */
 
-#define KMSG_COMPONENT "dasd"
+#define KMSG_COMPONENT "dasd-diag"
 
 #include <linux/stddef.h>
 #include <linux/kernel.h>
Index: quilt-2.6/drivers/s390/block/dasd_eckd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_eckd.c
+++ quilt-2.6/drivers/s390/block/dasd_eckd.c
@@ -10,7 +10,7 @@
  * Author.........: Nigel Hislop <hislop_nigel@emc.com>
  */
 
-#define KMSG_COMPONENT "dasd"
+#define KMSG_COMPONENT "dasd-eckd"
 
 #include <linux/stddef.h>
 #include <linux/kernel.h>
Index: quilt-2.6/drivers/s390/block/dasd_eer.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_eer.c
+++ quilt-2.6/drivers/s390/block/dasd_eer.c
@@ -6,7 +6,7 @@
  *  Author(s): Stefan Weinhuber <wein@de.ibm.com>
  */
 
-#define KMSG_COMPONENT "dasd"
+#define KMSG_COMPONENT "dasd-eckd"
 
 #include <linux/init.h>
 #include <linux/fs.h>
Index: quilt-2.6/drivers/s390/block/dasd_erp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_erp.c
+++ quilt-2.6/drivers/s390/block/dasd_erp.c
@@ -99,8 +99,8 @@ dasd_default_erp_action(struct dasd_ccw_
 		cqr->lpm    = LPM_ANYPATH;
 		cqr->status = DASD_CQR_FILLED;
         } else {
-		dev_err(&device->cdev->dev,
-			"default ERP has run out of retries and failed\n");
+		pr_err("%s: default ERP has run out of retries and failed\n",
+		       dev_name(&device->cdev->dev));
 		cqr->status = DASD_CQR_FAILED;
 		cqr->stopclk = get_clock();
         }
Index: quilt-2.6/drivers/s390/block/dasd_fba.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_fba.c
+++ quilt-2.6/drivers/s390/block/dasd_fba.c
@@ -5,7 +5,7 @@
  * Copyright IBM Corp. 1999, 2009
  */
 
-#define KMSG_COMPONENT "dasd"
+#define KMSG_COMPONENT "dasd-fba"
 
 #include <linux/stddef.h>
 #include <linux/kernel.h>
Index: quilt-2.6/drivers/s390/block/dasd_ioctl.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_ioctl.c
+++ quilt-2.6/drivers/s390/block/dasd_ioctl.c
@@ -98,8 +98,8 @@ static int dasd_ioctl_quiesce(struct das
 	if (!capable (CAP_SYS_ADMIN))
 		return -EACCES;
 
-	dev_info(&base->cdev->dev, "The DASD has been put in the quiesce "
-		 "state\n");
+	pr_info("%s: The DASD has been put in the quiesce "
+		"state\n", dev_name(&base->cdev->dev));
 	spin_lock_irqsave(get_ccwdev_lock(base->cdev), flags);
 	base->stopped |= DASD_STOPPED_QUIESCE;
 	spin_unlock_irqrestore(get_ccwdev_lock(base->cdev), flags);
@@ -119,8 +119,8 @@ static int dasd_ioctl_resume(struct dasd
 	if (!capable (CAP_SYS_ADMIN))
 		return -EACCES;
 
-	dev_info(&base->cdev->dev, "I/O operations have been resumed "
-		 "on the DASD\n");
+	pr_info("%s: I/O operations have been resumed "
+		"on the DASD\n", dev_name(&base->cdev->dev));
 	spin_lock_irqsave(get_ccwdev_lock(base->cdev), flags);
 	base->stopped &= ~DASD_STOPPED_QUIESCE;
 	spin_unlock_irqrestore(get_ccwdev_lock(base->cdev), flags);
@@ -146,8 +146,8 @@ static int dasd_format(struct dasd_block
 		return -EPERM;
 
 	if (base->state != DASD_STATE_BASIC) {
-		dev_warn(&base->cdev->dev,
-			 "The DASD cannot be formatted while it is enabled\n");
+		pr_warning("%s: The DASD cannot be formatted while it is "
+			   "enabled\n",  dev_name(&base->cdev->dev));
 		return -EBUSY;
 	}
 
@@ -175,9 +175,9 @@ static int dasd_format(struct dasd_block
 		dasd_sfree_request(cqr, cqr->memdev);
 		if (rc) {
 			if (rc != -ERESTARTSYS)
-				dev_err(&base->cdev->dev,
-					"Formatting unit %d failed with "
-					"rc=%d\n", fdata->start_unit, rc);
+				pr_err("%s: Formatting unit %d failed with "
+				       "rc=%d\n", dev_name(&base->cdev->dev),
+				       fdata->start_unit, rc);
 			return rc;
 		}
 		fdata->start_unit++;
@@ -204,9 +204,9 @@ dasd_ioctl_format(struct block_device *b
 	if (copy_from_user(&fdata, argp, sizeof(struct format_data_t)))
 		return -EFAULT;
 	if (bdev != bdev->bd_contains) {
-		dev_warn(&block->base->cdev->dev,
-			 "The specified DASD is a partition and cannot be "
-			 "formatted\n");
+		pr_warning("%s: The specified DASD is a partition and cannot "
+			   "be formatted\n",
+			   dev_name(&block->base->cdev->dev));
 		return -EINVAL;
 	}
 	return dasd_format(block, &fdata);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
