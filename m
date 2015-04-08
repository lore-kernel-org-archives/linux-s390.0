Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jarod Wilson <jarod@redhat.com>
Subject: [PATCH 6/7] block: replace trylock with mutex_lock in blkdev_reread_part()
Date: Wed,  8 Apr 2015 02:23:45 -0400
Message-Id: <1428474226-27386-7-git-send-email-jarod@redhat.com>
In-Reply-To: <1428474226-27386-1-git-send-email-jarod@redhat.com>
References: <1428218688-4092-1-git-send-email-ming.lei@canonical.com>
 <1428474226-27386-1-git-send-email-jarod@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Ming Lei <ming.lei@canonical.com>, Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Markus Pargmann <mpa@pengutronix.de>, Stefan Weinhuber <wein@de.ibm.com>, Stefan Haberland <stefan.haberland@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Fabian Frederick <fabf@skynet.be>, David Herrmann <dh.herrmann@gmail.com>, Mike Galbraith <bitbucket@online.de>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, nbd-general@lists.sourceforge.net, linux-s390@vger.kernel.org, Jarod Wilson <jarod@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ming Lei <ming.lei@canonical.com>

The only possible problem of using mutex_lock() instead of trylock
is about deadlock.

If there aren't any locks held before calling blkdev_reread_part(lock),
deadlock can't be caused by this conversion.

If there are locks held before calling blkdev_reread_part(lock),
and if these locks arn't required in open, close handler and I/O
path, deadlock shouldn't be caused too.

Both user space's ioctl(BLKRRPART) and md_setup_drive() from
init/do_mounts_md.c belongs to the 1st case, so the conversion is safe
for the two cases.

For loop, the previous patches in this pathset has fixed the ABBA lock
dependency, so the conversion is OK.

For nbd, tx_lock is held when calling the function:

        - both open and release won't hold the lock
        - when blkdev_reread_part() is run, I/O thread has been stopped
        already, so tx_lock won't be acquired in I/O path at that time.
        - so the conversion won't cause deadlock for nbd

For dasd, both dasd_open(), dasd_release() and request function don't
acquire any mutex/semphone, so the conversion should be safe.

[jarod: update for modifications earlier in series.]

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
Signed-off-by: Ming Lei <ming.lei@canonical.com>
Signed-off-by: Jarod Wilson <jarod@redhat.com>
---
 block/ioctl.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 64a4fcb..47c8e6d 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -170,15 +170,19 @@ EXPORT_SYMBOL(__blkdev_reread_part);
 
 /*
  * This is an exported API for the block driver, and will
- * acquire bd_mutex. Make sure you aren't calling it with
- * bd_mutex already held, or we'll return -EBUSY.
+ * acquire bd_mutex.
+ *
+ * Make sure held locks aren't required in open()/close()
+ * handlers and I/O paths to avoid an ABBA deadlock:
+ * - bd_mutex is held before calling a block driver's open/close
+ *   handler
+ * - reading a partition table may submit I/O to the block device
  */
 int blkdev_reread_part(struct block_device *bdev)
 {
 	int res;
 
-	if (!mutex_trylock(&bdev->bd_mutex))
-		return -EBUSY;
+	mutex_lock(&bdev->bd_mutex);
 	res = __blkdev_reread_part(bdev);
 	mutex_unlock(&bdev->bd_mutex);
 
-- 
1.8.3.1
