Return-Path: <linux-kernel-owner+w=401wt.eu-S1759928AbYFYOlj@vger.kernel.org>
Message-Id: <20080625143612.371701146@de.ibm.com>
References: <20080625143459.100139455@de.ibm.com>
Date: Wed, 25 Jun 2008 16:35:03 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 04/21] Cleanup 3270 printk messages.
Content-Disposition: inline; filename=803-printk-con3270.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/fs3270.c  |    5 +----
 drivers/s390/char/raw3270.c |    1 -
 drivers/s390/char/tty3270.c |    3 ---
 3 files changed, 1 insertion(+), 8 deletions(-)

Index: quilt-2.6/drivers/s390/char/fs3270.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/fs3270.c
+++ quilt-2.6/drivers/s390/char/fs3270.c
@@ -512,11 +512,8 @@ fs3270_init(void)
 	int rc;
 
 	rc = register_chrdev(IBM_FS3270_MAJOR, "fs3270", &fs3270_fops);
-	if (rc) {
-		printk(KERN_ERR "fs3270 can't get major number %d: errno %d\n",
-		       IBM_FS3270_MAJOR, rc);
+	if (rc)
 		return rc;
-	}
 	return 0;
 }
 
Index: quilt-2.6/drivers/s390/char/raw3270.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/raw3270.c
+++ quilt-2.6/drivers/s390/char/raw3270.c
@@ -619,7 +619,6 @@ __raw3270_size_device_vm(struct raw3270 
 		rp->cols = 132;
 		break;
 	default:
-		printk(KERN_WARNING "vrdccrmd is 0x%.8x\n", model);
 		rc = -EOPNOTSUPP;
 		break;
 	}
Index: quilt-2.6/drivers/s390/char/tty3270.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/tty3270.c
+++ quilt-2.6/drivers/s390/char/tty3270.c
@@ -1792,15 +1792,12 @@ static int __init tty3270_init(void)
 	tty_set_operations(driver, &tty3270_ops);
 	ret = tty_register_driver(driver);
 	if (ret) {
-		printk(KERN_ERR "tty3270 registration failed with %d\n", ret);
 		put_tty_driver(driver);
 		return ret;
 	}
 	tty3270_driver = driver;
 	ret = raw3270_register_notifier(tty3270_notifier);
 	if (ret) {
-		printk(KERN_ERR "tty3270 notifier registration failed "
-		       "with %d\n", ret);
 		put_tty_driver(driver);
 		return ret;
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
