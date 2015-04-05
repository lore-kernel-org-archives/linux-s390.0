Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ming Lei <ming.lei@canonical.com>
Subject: [PATCH 2/6] block: loop: don't hold lo_ctl_mutex in lo_open
Date: Sun,  5 Apr 2015 15:24:44 +0800
Message-Id: <1428218688-4092-3-git-send-email-ming.lei@canonical.com>
In-Reply-To: <1428218688-4092-1-git-send-email-ming.lei@canonical.com>
References: <1428218688-4092-1-git-send-email-ming.lei@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jarod Wilson <jarod@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, nbd-general@lists.sourceforge.net, Stefan Haberland <stefan.haberland@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Fabian Frederick <fabf@skynet.be>, linux-s390@vger.kernel.org, Ming Lei <ming.lei@canonical.com>
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

1) introduce lo_open_mutex to protect lo_refcnt and avoid acquiring
lo_ctl_mutex in lo_open():
	- for open vs. add/del loop, no any problem because of loop_index_mutex
	- lo_open_mutex is used for syncing open() and loop_clr_fd()
	- both open() and release() have been serialized by bd_mutex already

2) don't hold lo_ctl_mutex for decreasing/checking lo_refcnt in
lo_release(), then lo_ctl_mutex is only required for the last release.

Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 drivers/block/loop.c |   32 ++++++++++++++++++++++++++------
 drivers/block/loop.h |    1 +
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d1f168b..81a6bc1 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -879,14 +879,18 @@ static int loop_clr_fd(struct loop_device *lo)
 	 * <dev>/do something like mkfs/losetup -d <dev> causing the losetup -d
 	 * command to fail with EBUSY.
 	 */
+	mutex_lock(&lo->lo_open_mutex);
 	if (lo->lo_refcnt > 1) {
+		mutex_unlock(&lo->lo_open_mutex);
 		lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
 		mutex_unlock(&lo->lo_ctl_mutex);
 		return 0;
 	}
 
-	if (filp == NULL)
+	if (filp == NULL) {
+		mutex_unlock(&lo->lo_open_mutex);
 		return -EINVAL;
+	}
 
 	spin_lock_irq(&lo->lo_lock);
 	lo->lo_state = Lo_rundown;
@@ -919,6 +923,15 @@ static int loop_clr_fd(struct loop_device *lo)
 	lo->lo_state = Lo_unbound;
 	/* This is safe: open() is still holding a reference. */
 	module_put(THIS_MODULE);
+
+	/*
+	 * Unlock open_mutex for avoiding -EBUSY of rereading part:
+	 * - try to acquire bd_mutex from reread part
+	 * - another task is opening the loop with holding bd_mutex
+	 *   and trys to acquire open_mutex
+	 */
+	mutex_unlock(&lo->lo_open_mutex);
+
 	if (lo->lo_flags & LO_FLAGS_PARTSCAN && bdev)
 		ioctl_by_bdev(bdev, BLKRRPART, 0);
 	lo->lo_flags = 0;
@@ -1376,9 +1389,9 @@ static int lo_open(struct block_device *bdev, fmode_t mode)
 		goto out;
 	}
 
-	mutex_lock(&lo->lo_ctl_mutex);
+	mutex_lock(&lo->lo_open_mutex);
 	lo->lo_refcnt++;
-	mutex_unlock(&lo->lo_ctl_mutex);
+	mutex_unlock(&lo->lo_open_mutex);
 out:
 	mutex_unlock(&loop_index_mutex);
 	return err;
@@ -1387,13 +1400,16 @@ out:
 static void lo_release(struct gendisk *disk, fmode_t mode)
 {
 	struct loop_device *lo = disk->private_data;
-	int err;
+	int err, ref;
 
-	mutex_lock(&lo->lo_ctl_mutex);
+	mutex_lock(&lo->lo_open_mutex);
+	ref = --lo->lo_refcnt;
+	mutex_unlock(&lo->lo_open_mutex);
 
-	if (--lo->lo_refcnt)
+	if (ref)
 		goto out;
 
+	mutex_lock(&lo->lo_ctl_mutex);
 	if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
 		/*
 		 * In autoclear mode, stop the loop thread
@@ -1646,6 +1662,7 @@ static int loop_add(struct loop_device **l, int i)
 		disk->flags |= GENHD_FL_NO_PART_SCAN;
 	disk->flags |= GENHD_FL_EXT_DEVT;
 	mutex_init(&lo->lo_ctl_mutex);
+	mutex_init(&lo->lo_open_mutex);
 	lo->lo_number		= i;
 	spin_lock_init(&lo->lo_lock);
 	disk->major		= LOOP_MAJOR;
@@ -1763,11 +1780,14 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
 			mutex_unlock(&lo->lo_ctl_mutex);
 			break;
 		}
+		mutex_lock(&lo->lo_open_mutex);
 		if (lo->lo_refcnt > 0) {
 			ret = -EBUSY;
+			mutex_unlock(&lo->lo_open_mutex);
 			mutex_unlock(&lo->lo_ctl_mutex);
 			break;
 		}
+		mutex_unlock(&lo->lo_open_mutex);
 		lo->lo_disk->private_data = NULL;
 		mutex_unlock(&lo->lo_ctl_mutex);
 		idr_remove(&loop_index_idr, lo->lo_number);
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index 301c27f..1b4acf2 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -59,6 +59,7 @@ struct loop_device {
 	bool			write_started;
 	int			lo_state;
 	struct mutex		lo_ctl_mutex;
+	struct mutex		lo_open_mutex;
 
 	struct request_queue	*lo_queue;
 	struct blk_mq_tag_set	tag_set;
-- 
1.7.9.5
