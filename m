Return-Path: <linux-kernel-owner+w=401wt.eu-S1761900AbZBYPTa@vger.kernel.org>
Message-Id: <20090225150827.934014838@de.ibm.com>
References: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:06:26 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 04/46] dasd: enable compat ioctls
Content-Disposition: inline; filename=103-dasd-ioctl.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

All of the ioctls are compatible. Just enable them.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd.c       |    3 ++-
 drivers/s390/block/dasd_ioctl.c |   17 ++++++++++++++---
 2 files changed, 16 insertions(+), 4 deletions(-)

Index: quilt-2.6/drivers/s390/block/dasd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd.c
+++ quilt-2.6/drivers/s390/block/dasd.c
@@ -2101,7 +2101,8 @@ dasd_device_operations = {
 	.owner		= THIS_MODULE,
 	.open		= dasd_open,
 	.release	= dasd_release,
-	.locked_ioctl	= dasd_ioctl,
+	.ioctl		= dasd_ioctl,
+	.compat_ioctl	= dasd_ioctl,
 	.getgeo		= dasd_getgeo,
 };
 
Index: quilt-2.6/drivers/s390/block/dasd_ioctl.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_ioctl.c
+++ quilt-2.6/drivers/s390/block/dasd_ioctl.c
@@ -365,9 +365,9 @@ static int dasd_ioctl_readall_cmb(struct
 	return ret;
 }
 
-int
-dasd_ioctl(struct block_device *bdev, fmode_t mode,
-	   unsigned int cmd, unsigned long arg)
+static int
+dasd_do_ioctl(struct block_device *bdev, fmode_t mode,
+	      unsigned int cmd, unsigned long arg)
 {
 	struct dasd_block *block = bdev->bd_disk->private_data;
 	void __user *argp = (void __user *)arg;
@@ -420,3 +420,14 @@ dasd_ioctl(struct block_device *bdev, fm
 		return -EINVAL;
 	}
 }
+
+int dasd_ioctl(struct block_device *bdev, fmode_t mode,
+	       unsigned int cmd, unsigned long arg)
+{
+	int rc;
+
+	lock_kernel();
+	rc = dasd_do_ioctl(bdev, mode, cmd, arg);
+	unlock_kernel();
+	return rc;
+}

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
