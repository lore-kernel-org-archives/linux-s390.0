Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ming Lei <ming.lei@canonical.com>
Subject: [PATCH v3 1/7] block: export blkdev_reread_part() and __blkdev_reread_part()
Date: Wed,  6 May 2015 12:26:22 +0800
Message-Id: <1430886389-26878-2-git-send-email-ming.lei@canonical.com>
In-Reply-To: <1430886389-26878-1-git-send-email-ming.lei@canonical.com>
References: <1430886389-26878-1-git-send-email-ming.lei@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jarod Wilson <jarod@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, nbd-general@lists.sourceforge.net, Stefan Haberland <stefan.haberland@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Fabian Frederick <fabf@skynet.be>, Peter Zijlstra <peterz@infradead.org>, linux-s390@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Stefan Weinhuber <wein@de.ibm.com>, Ming Lei <ming.lei@canonical.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jarod Wilson <jarod@redhat.com>

This patch exports blkdev_reread_part() for block drivers, also
introduce __blkdev_reread_part().

For some drivers, such as loop, reread of partitions can be run
from the release path, and bd_mutex may already be held prior to
calling ioctl_by_bdev(bdev, BLKRRPART, 0), so introduce
__blkdev_reread_part for use in such cases.

CC: Christoph Hellwig <hch@lst.de>
CC: Jens Axboe <axboe@kernel.dk>
CC: Tejun Heo <tj@kernel.org>
CC: Alexander Viro <viro@zeniv.linux.org.uk>
CC: Markus Pargmann <mpa@pengutronix.de>
CC: Stefan Weinhuber <wein@de.ibm.com>
CC: Stefan Haberland <stefan.haberland@de.ibm.com>
CC: Sebastian Ott <sebott@linux.vnet.ibm.com>
CC: Fabian Frederick <fabf@skynet.be>
CC: Ming Lei <ming.lei@canonical.com>
CC: David Herrmann <dh.herrmann@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: nbd-general@lists.sourceforge.net
CC: linux-s390@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jarod Wilson <jarod@redhat.com>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 block/ioctl.c      | 28 +++++++++++++++++++++++++---
 include/linux/fs.h |  3 +++
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 7d8befd..203cb4a 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -150,21 +150,43 @@ static int blkpg_ioctl(struct block_device *bdev, struct blkpg_ioctl_arg __user
 	}
 }
 
-static int blkdev_reread_part(struct block_device *bdev)
+/*
+ * This is an exported API for the block driver, and will not
+ * acquire bd_mutex. This API should be used in case that
+ * caller has held bd_mutex already.
+ */
+int __blkdev_reread_part(struct block_device *bdev)
 {
 	struct gendisk *disk = bdev->bd_disk;
-	int res;
 
 	if (!disk_part_scan_enabled(disk) || bdev != bdev->bd_contains)
 		return -EINVAL;
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
+
+	lockdep_assert_held(&bdev->bd_mutex);
+
+	return rescan_partitions(disk, bdev);
+}
+EXPORT_SYMBOL(__blkdev_reread_part);
+
+/*
+ * This is an exported API for the block driver, and will
+ * try to acquire bd_mutex. If bd_mutex has been held already
+ * in current context, please call __blkdev_reread_part().
+ */
+int blkdev_reread_part(struct block_device *bdev)
+{
+	int res;
+
 	if (!mutex_trylock(&bdev->bd_mutex))
 		return -EBUSY;
-	res = rescan_partitions(disk, bdev);
+	res = __blkdev_reread_part(bdev);
 	mutex_unlock(&bdev->bd_mutex);
+
 	return res;
 }
+EXPORT_SYMBOL(blkdev_reread_part);
 
 static int blk_ioctl_discard(struct block_device *bdev, uint64_t start,
 			     uint64_t len, int secure)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 35ec87e..1ef6390 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2279,6 +2279,9 @@ extern struct block_device *blkdev_get_by_path(const char *path, fmode_t mode,
 extern struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode,
 					      void *holder);
 extern void blkdev_put(struct block_device *bdev, fmode_t mode);
+extern int __blkdev_reread_part(struct block_device *bdev);
+extern int blkdev_reread_part(struct block_device *bdev);
+
 #ifdef CONFIG_SYSFS
 extern int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk);
 extern void bd_unlink_disk_holder(struct block_device *bdev,
-- 
1.9.1
