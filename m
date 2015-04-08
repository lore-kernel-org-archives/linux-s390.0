Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jarod Wilson <jarod@redhat.com>
Subject: [PATCH 3/7] block: loop: fix another reread part failure
Date: Wed,  8 Apr 2015 02:23:42 -0400
Message-Id: <1428474226-27386-4-git-send-email-jarod@redhat.com>
In-Reply-To: <1428474226-27386-1-git-send-email-jarod@redhat.com>
References: <1428218688-4092-1-git-send-email-ming.lei@canonical.com>
 <1428474226-27386-1-git-send-email-jarod@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Jarod Wilson <jarod@redhat.com>, Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Markus Pargmann <mpa@pengutronix.de>, Stefan Weinhuber <wein@de.ibm.com>, Stefan Haberland <stefan.haberland@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Fabian Frederick <fabf@skynet.be>, Ming Lei <ming.lei@canonical.com>, David Herrmann <dh.herrmann@gmail.com>, Mike Galbraith <bitbucket@online.de>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, nbd-general@lists.sourceforge.net, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

loop_clr_fd() can be run piggyback with lo_release(), and
under this situation, reread partition may always fail because
of bd_mutex which has been held in release path.

This patch detects the situation by the reference count, and
call blkdev_reread_part_nolock() to avoid acquiring the lock again.

In the meantime, this patch switches to new kernel APIs
of blkdev_reread_part() and blkdev_reread_part_nolock().

[jarod: this is a merger of my original patch, Ming's patch, and some
reworking for my reworked first patch in the series.]

CC: Christoph Hellwig <hch@infradead.org>
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
CC: Mike Galbraith <bitbucket@online.de>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: nbd-general@lists.sourceforge.net
CC: linux-s390@vger.kernel.org
Signed-off-by: Jarod Wilson <jarod@redhat.com>
---
 drivers/block/loop.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 81a6bc1..ab5c678 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -528,6 +528,26 @@ static int loop_flush(struct loop_device *lo)
 	return loop_switch(lo, NULL);
 }
 
+static void loop_reread_partitions(struct loop_device *lo,
+				   struct block_device *bdev)
+{
+	int rc;
+	bool in_release;
+
+	mutex_lock(&lo->lo_open_mutex);
+	in_release = lo->lo_refcnt == 0;
+	mutex_unlock(&lo->lo_open_mutex);
+
+	/* bd_mutex has been held already in release path */
+	if (in_release)
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
@@ -576,7 +596,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 
 	fput(old_file);
 	if (lo->lo_flags & LO_FLAGS_PARTSCAN)
-		ioctl_by_bdev(bdev, BLKRRPART, 0);
+		loop_reread_partitions(lo, bdev);
 	return 0;
 
  out_putf:
@@ -807,7 +827,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	if (part_shift)
 		lo->lo_flags |= LO_FLAGS_PARTSCAN;
 	if (lo->lo_flags & LO_FLAGS_PARTSCAN)
-		ioctl_by_bdev(bdev, BLKRRPART, 0);
+		loop_reread_partitions(lo, bdev);
 
 	/* Grab the block_device to prevent its destruction after we
 	 * put /dev/loopXX inode. Later in loop_clr_fd() we bdput(bdev).
@@ -933,7 +953,7 @@ static int loop_clr_fd(struct loop_device *lo)
 	mutex_unlock(&lo->lo_open_mutex);
 
 	if (lo->lo_flags & LO_FLAGS_PARTSCAN && bdev)
-		ioctl_by_bdev(bdev, BLKRRPART, 0);
+		loop_reread_partitions(lo, bdev);
 	lo->lo_flags = 0;
 	if (!part_shift)
 		lo->lo_disk->flags |= GENHD_FL_NO_PART_SCAN;
@@ -1008,7 +1028,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	     !(lo->lo_flags & LO_FLAGS_PARTSCAN)) {
 		lo->lo_flags |= LO_FLAGS_PARTSCAN;
 		lo->lo_disk->flags &= ~GENHD_FL_NO_PART_SCAN;
-		ioctl_by_bdev(lo->lo_device, BLKRRPART, 0);
+		loop_reread_partitions(lo, lo->lo_device);
 	}
 
 	lo->lo_encrypt_key_size = info->lo_encrypt_key_size;
-- 
1.8.3.1
