From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 14 Sep 2010 19:34:54 +0000
Subject: [PATCH 03/18] s390/block: kill the big kernel lock
Message-Id: <1284492909-7147-4-git-send-email-arnd@arndb.de>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The dasd and dcssblk drivers gained the big
kernel lock in the recent pushdown from the
block layer, but they don't really need it,
so remove the calls without a replacement.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 drivers/s390/block/dasd.c       |    6 ------
 drivers/s390/block/dasd_ioctl.c |   17 ++---------------
 drivers/s390/block/dcssblk.c    |    5 -----
 3 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 8373ca0..38e6fa9 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -21,7 +21,6 @@
 #include <linux/hdreg.h>
 #include <linux/async.h>
 #include <linux/mutex.h>
-#include <linux/smp_lock.h>
 
 #include <asm/ccwdev.h>
 #include <asm/ebcdic.h>
@@ -2236,7 +2235,6 @@ static int dasd_open(struct block_device *bdev, fmode_t mode)
 	if (!block)
 		return -ENODEV;
 
-	lock_kernel();
 	base = block->base;
 	atomic_inc(&block->open_count);
 	if (test_bit(DASD_FLAG_OFFLINE, &base->flags)) {
@@ -2271,14 +2269,12 @@ static int dasd_open(struct block_device *bdev, fmode_t mode)
 		goto out;
 	}
 
-	unlock_kernel();
 	return 0;
 
 out:
 	module_put(base->discipline->owner);
 unlock:
 	atomic_dec(&block->open_count);
-	unlock_kernel();
 	return rc;
 }
 
@@ -2286,10 +2282,8 @@ static int dasd_release(struct gendisk *disk, fmode_t mode)
 {
 	struct dasd_block *block = disk->private_data;
 
-	lock_kernel();
 	atomic_dec(&block->open_count);
 	module_put(block->base->discipline->owner);
-	unlock_kernel();
 	return 0;
 }
 
diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 1557214..26075e9 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -16,7 +16,6 @@
 #include <linux/major.h>
 #include <linux/fs.h>
 #include <linux/blkpg.h>
-#include <linux/smp_lock.h>
 #include <linux/slab.h>
 #include <asm/compat.h>
 #include <asm/ccwdev.h>
@@ -370,9 +369,8 @@ static int dasd_ioctl_readall_cmb(struct dasd_block *block, unsigned int cmd,
 	return ret;
 }
 
-static int
-dasd_do_ioctl(struct block_device *bdev, fmode_t mode,
-	      unsigned int cmd, unsigned long arg)
+int dasd_ioctl(struct block_device *bdev, fmode_t mode,
+	       unsigned int cmd, unsigned long arg)
 {
 	struct dasd_block *block = bdev->bd_disk->private_data;
 	void __user *argp;
@@ -430,14 +428,3 @@ dasd_do_ioctl(struct block_device *bdev, fmode_t mode,
 		return -EINVAL;
 	}
 }
-
-int dasd_ioctl(struct block_device *bdev, fmode_t mode,
-	       unsigned int cmd, unsigned long arg)
-{
-	int rc;
-
-	lock_kernel();
-	rc = dasd_do_ioctl(bdev, mode, cmd, arg);
-	unlock_kernel();
-	return rc;
-}
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 2bd72aa..9b43ae9 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -14,7 +14,6 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/blkdev.h>
-#include <linux/smp_lock.h>
 #include <linux/completion.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
@@ -776,7 +775,6 @@ dcssblk_open(struct block_device *bdev, fmode_t mode)
 	struct dcssblk_dev_info *dev_info;
 	int rc;
 
-	lock_kernel();
 	dev_info = bdev->bd_disk->private_data;
 	if (NULL == dev_info) {
 		rc = -ENODEV;
@@ -786,7 +784,6 @@ dcssblk_open(struct block_device *bdev, fmode_t mode)
 	bdev->bd_block_size = 4096;
 	rc = 0;
 out:
-	unlock_kernel();
 	return rc;
 }
 
@@ -797,7 +794,6 @@ dcssblk_release(struct gendisk *disk, fmode_t mode)
 	struct segment_info *entry;
 	int rc;
 
-	lock_kernel();
 	if (!dev_info) {
 		rc = -ENODEV;
 		goto out;
@@ -815,7 +811,6 @@ dcssblk_release(struct gendisk *disk, fmode_t mode)
 	up_write(&dcssblk_devices_sem);
 	rc = 0;
 out:
-	unlock_kernel();
 	return rc;
 }
 
-- 
1.7.1
