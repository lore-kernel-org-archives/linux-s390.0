Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ming Lei <ming.lei@canonical.com>
Subject: [PATCH 1/6] block: export blkdev_reread_part()
Date: Sun,  5 Apr 2015 15:24:43 +0800
Message-Id: <1428218688-4092-2-git-send-email-ming.lei@canonical.com>
In-Reply-To: <1428218688-4092-1-git-send-email-ming.lei@canonical.com>
References: <1428218688-4092-1-git-send-email-ming.lei@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jarod Wilson <jarod@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, nbd-general@lists.sourceforge.net, Stefan Haberland <stefan.haberland@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Fabian Frederick <fabf@skynet.be>, linux-s390@vger.kernel.org, Ming Lei <ming.lei@canonical.com>
List-ID: <linux-s390.vger.kernel.org>

This patch exports blkdev_reread_part() for block drivers, also
introduce blkdev_reread_part_no_lock().

For some drivers, such as loop, reread partition can be run
from release path, and the bd_mutex has been held already before
calling ioctl_by_bdev(bdev, BLKRRPART, 0), so this patch introduces
blkdev_reread_part_no_lock() too for this requirment.

Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 block/ioctl.c      |   14 ++++++++++----
 include/linux/fs.h |    9 +++++++++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 7d8befd..7dce19a 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -150,7 +150,11 @@ static int blkpg_ioctl(struct block_device *bdev, struct blkpg_ioctl_arg __user
 	}
 }
 
-static int blkdev_reread_part(struct block_device *bdev)
+/*
+ * This is exported as API for block driver, can be called
+ * with requiring bd_mutex or not.
+ */
+int __blkdev_reread_part(struct block_device *bdev, bool lock)
 {
 	struct gendisk *disk = bdev->bd_disk;
 	int res;
@@ -159,12 +163,14 @@ static int blkdev_reread_part(struct block_device *bdev)
 		return -EINVAL;
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
-	if (!mutex_trylock(&bdev->bd_mutex))
+	if (lock && !mutex_trylock(&bdev->bd_mutex))
 		return -EBUSY;
 	res = rescan_partitions(disk, bdev);
-	mutex_unlock(&bdev->bd_mutex);
+	if (lock)
+		mutex_unlock(&bdev->bd_mutex);
 	return res;
 }
+EXPORT_SYMBOL(__blkdev_reread_part);
 
 static int blk_ioctl_discard(struct block_device *bdev, uint64_t start,
 			     uint64_t len, int secure)
@@ -407,7 +413,7 @@ int blkdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 		ret = blkpg_ioctl(bdev, (struct blkpg_ioctl_arg __user *) arg);
 		break;
 	case BLKRRPART:
-		ret = blkdev_reread_part(bdev);
+		ret = __blkdev_reread_part(bdev, true);
 		break;
 	case BLKGETSIZE:
 		size = i_size_read(bdev->bd_inode);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 368e349..948bf75 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2275,6 +2275,15 @@ extern struct block_device *blkdev_get_by_path(const char *path, fmode_t mode,
 extern struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode,
 					      void *holder);
 extern void blkdev_put(struct block_device *bdev, fmode_t mode);
+extern int __blkdev_reread_part(struct block_device *bdev, bool lock);
+static inline int blkdev_reread_part(struct block_device *bdev)
+{
+	return __blkdev_reread_part(bdev, true);
+}
+static inline int blkdev_reread_part_nolock(struct block_device *bdev)
+{
+	return __blkdev_reread_part(bdev, false);
+}
 #ifdef CONFIG_SYSFS
 extern int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk);
 extern void bd_unlink_disk_holder(struct block_device *bdev,
-- 
1.7.9.5
