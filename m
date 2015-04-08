Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ming Lei <ming.lei@canonical.com>
Subject: [PATCH v1 3/7] block: loop: fix another reread part failure
Date: Wed,  8 Apr 2015 23:53:00 +0800
Message-Id: <1428508384-29008-4-git-send-email-ming.lei@canonical.com>
In-Reply-To: <1428508384-29008-1-git-send-email-ming.lei@canonical.com>
References: <1428508384-29008-1-git-send-email-ming.lei@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jarod Wilson <jarod@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, nbd-general@lists.sourceforge.net, Stefan Haberland <stefan.haberland@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Fabian Frederick <fabf@skynet.be>, Peter Zijlstra <peterz@infradead.org>, linux-s390@vger.kernel.org, Ming Lei <ming.lei@canonical.com>
List-ID: <linux-s390.vger.kernel.org>

loop_clr_fd() can be run piggyback with lo_release(), and
under this situation, reread partition may always fail because
bd_mutex has been held already.

This patch detects the situation by the reference count, and
call __blkdev_reread_part() to avoid acquiring the lock again.

In the meantime, this patch switches to new kernel APIs
of blkdev_reread_part() and __blkdev_reread_part().

Signed-off-by: Jarod Wilson <jarod@redhat.com>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 drivers/block/loop.c |   30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 0d9f014..9f17054 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -530,6 +530,28 @@ static int loop_flush(struct loop_device *lo)
 	return loop_switch(lo, NULL);
 }
 
+static void loop_reread_partitions(struct loop_device *lo,
+				   struct block_device *bdev)
+{
+	int rc;
+
+	/*
+	 * bd_mutex has been held already in release path, so don't
+	 * acquire it if this function is called in such case.
+	 *
+	 * If the reread partition isn't from release path, lo_refcnt
+	 * must be at least one and it can only become zero when the
+	 * current holder is released.
+	 */
+	if (!atomic_read(&lo->lo_refcnt))
+		rc = __blkdev_reread_part(bdev);
+	else
+		rc = blkdev_reread_part(bdev);
+	if (rc)
+		pr_warn("%s: partition scan of loop%d (%s) failed (rc=%d)\n",
+			__func__, lo->lo_number, lo->lo_file_name, rc);
+}
+
 /*
  * loop_change_fd switched the backing store of a loopback device to
  * a new file. This is useful for operating system installers to free up
@@ -578,7 +600,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 
 	fput(old_file);
 	if (lo->lo_flags & LO_FLAGS_PARTSCAN)
-		ioctl_by_bdev(bdev, BLKRRPART, 0);
+		loop_reread_partitions(lo, bdev);
 	return 0;
 
  out_putf:
@@ -809,7 +831,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	if (part_shift)
 		lo->lo_flags |= LO_FLAGS_PARTSCAN;
 	if (lo->lo_flags & LO_FLAGS_PARTSCAN)
-		ioctl_by_bdev(bdev, BLKRRPART, 0);
+		loop_reread_partitions(lo, bdev);
 
 	/* Grab the block_device to prevent its destruction after we
 	 * put /dev/loopXX inode. Later in loop_clr_fd() we bdput(bdev).
@@ -927,7 +949,7 @@ static int loop_clr_fd(struct loop_device *lo)
 	blk_mq_unfreeze_queue(lo->lo_queue);
 
 	if (lo->lo_flags & LO_FLAGS_PARTSCAN && bdev)
-		ioctl_by_bdev(bdev, BLKRRPART, 0);
+		loop_reread_partitions(lo, bdev);
 	lo->lo_flags = 0;
 	if (!part_shift)
 		lo->lo_disk->flags |= GENHD_FL_NO_PART_SCAN;
@@ -1002,7 +1024,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	     !(lo->lo_flags & LO_FLAGS_PARTSCAN)) {
 		lo->lo_flags |= LO_FLAGS_PARTSCAN;
 		lo->lo_disk->flags &= ~GENHD_FL_NO_PART_SCAN;
-		ioctl_by_bdev(lo->lo_device, BLKRRPART, 0);
+		loop_reread_partitions(lo, lo->lo_device);
 	}
 
 	lo->lo_encrypt_key_size = info->lo_encrypt_key_size;
-- 
1.7.9.5
