Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 5/8] dasd: no need for BKL in ioctl
Date: Sun,  4 Jul 2010 00:02:29 +0200
Message-Id: <1278194552-24943-6-git-send-email-arnd@arndb.de>
In-Reply-To: <1278194552-24943-1-git-send-email-arnd@arndb.de>
References: <1278194552-24943-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: John Kacur <jkacur@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The dasd driver does not need the BKL, so we can
remove it here as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 drivers/s390/block/dasd_ioctl.c |   17 ++---------------
 1 files changed, 2 insertions(+), 15 deletions(-)

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
-- 
1.7.1
