Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ming Lei <ming.lei@canonical.com>
Subject: [PATCH v1 2/7] block: loop: don't hold lo_ctl_mutex in lo_open
Date: Wed,  8 Apr 2015 23:52:59 +0800
Message-Id: <1428508384-29008-3-git-send-email-ming.lei@canonical.com>
In-Reply-To: <1428508384-29008-1-git-send-email-ming.lei@canonical.com>
References: <1428508384-29008-1-git-send-email-ming.lei@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jarod Wilson <jarod@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, nbd-general@lists.sourceforge.net, Stefan Haberland <stefan.haberland@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Fabian Frederick <fabf@skynet.be>, Peter Zijlstra <peterz@infradead.org>, linux-s390@vger.kernel.org, Ming Lei <ming.lei@canonical.com>
List-ID: <linux-s390.vger.kernel.org>

The lo_ctl_mutex is held for running all ioctl handlers, and
in some ioctl handlers, ioctl_by_bdev(BLKRRPART) is called for
rereading partitions, which requires bd_mutex.

So it is easy to cause failure because trylock(bd_mutex) may
fail inside blkdev_reread_part(), and follows the lock context:

blkid or other application:
	->open()
		->mutex_lock(bd_mutex)
		->lo_open()
			->mutex_lock(lo_ctl_mutex)

losetup(set fd ioctl):
	->mutex_lock(lo_ctl_mutex)
	->ioctl_by_bdev(BLKRRPART)
		->trylock(bd_mutex)

This patch trys to eliminate the ABBA lock dependency by removing
lo_ctl_mutext in lo_open() with the following approach:

1) make lo_refcnt as atomic_t and avoid acquiring lo_ctl_mutex in lo_open():
	- for open vs. add/del loop, no any problem because of loop_index_mutex
	- freeze request queue during clr_fd, so I/O can't come until
	  clearing fd is completed, like the effect of holding lo_ctl_mutex
	  in lo_open
	- both open() and release() have been serialized by bd_mutex already

2) don't hold lo_ctl_mutex for decreasing/checking lo_refcnt in
lo_release(), then lo_ctl_mutex is only required for the last release.

Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 drivers/block/loop.c |   19 +++++++++++--------
 drivers/block/loop.h |    2 +-
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index c4fd1e4..0d9f014 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -881,7 +881,7 @@ static int loop_clr_fd(struct loop_device *lo)
 	 * <dev>/do something like mkfs/losetup -d <dev> causing the losetup -d
 	 * command to fail with EBUSY.
 	 */
-	if (lo->lo_refcnt > 1) {
+	if (atomic_read(&lo->lo_refcnt) > 1) {
 		lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
 		mutex_unlock(&lo->lo_ctl_mutex);
 		return 0;
@@ -890,6 +890,9 @@ static int loop_clr_fd(struct loop_device *lo)
 	if (filp == NULL)
 		return -EINVAL;
 
+	/* freeze request queue during the transition */
+	blk_mq_freeze_queue(lo->lo_queue);
+
 	spin_lock_irq(&lo->lo_lock);
 	lo->lo_state = Lo_rundown;
 	lo->lo_backing_file = NULL;
@@ -921,6 +924,8 @@ static int loop_clr_fd(struct loop_device *lo)
 	lo->lo_state = Lo_unbound;
 	/* This is safe: open() is still holding a reference. */
 	module_put(THIS_MODULE);
+	blk_mq_unfreeze_queue(lo->lo_queue);
+
 	if (lo->lo_flags & LO_FLAGS_PARTSCAN && bdev)
 		ioctl_by_bdev(bdev, BLKRRPART, 0);
 	lo->lo_flags = 0;
@@ -1378,9 +1383,7 @@ static int lo_open(struct block_device *bdev, fmode_t mode)
 		goto out;
 	}
 
-	mutex_lock(&lo->lo_ctl_mutex);
-	lo->lo_refcnt++;
-	mutex_unlock(&lo->lo_ctl_mutex);
+	atomic_inc(&lo->lo_refcnt);
 out:
 	mutex_unlock(&loop_index_mutex);
 	return err;
@@ -1391,11 +1394,10 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 	struct loop_device *lo = disk->private_data;
 	int err;
 
-	mutex_lock(&lo->lo_ctl_mutex);
-
-	if (--lo->lo_refcnt)
+	if (atomic_dec_return(&lo->lo_refcnt))
 		goto out;
 
+	mutex_lock(&lo->lo_ctl_mutex);
 	if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
 		/*
 		 * In autoclear mode, stop the loop thread
@@ -1648,6 +1650,7 @@ static int loop_add(struct loop_device **l, int i)
 		disk->flags |= GENHD_FL_NO_PART_SCAN;
 	disk->flags |= GENHD_FL_EXT_DEVT;
 	mutex_init(&lo->lo_ctl_mutex);
+	atomic_set(&lo->lo_refcnt, 0);
 	lo->lo_number		= i;
 	spin_lock_init(&lo->lo_lock);
 	disk->major		= LOOP_MAJOR;
@@ -1765,7 +1768,7 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
 			mutex_unlock(&lo->lo_ctl_mutex);
 			break;
 		}
-		if (lo->lo_refcnt > 0) {
+		if (atomic_read(&lo->lo_refcnt) > 0) {
 			ret = -EBUSY;
 			mutex_unlock(&lo->lo_ctl_mutex);
 			break;
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index 301c27f..ffb6dd6 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -28,7 +28,7 @@ struct loop_func_table;
 
 struct loop_device {
 	int		lo_number;
-	int		lo_refcnt;
+	atomic_t	lo_refcnt;
 	loff_t		lo_offset;
 	loff_t		lo_sizelimit;
 	int		lo_flags;
-- 
1.7.9.5
