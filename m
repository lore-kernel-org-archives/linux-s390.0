Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ming Lei <ming.lei@canonical.com>
Subject: [PATCH v3 6/7] block: replace trylock with mutex_lock in blkdev_reread_part()
Date: Wed,  6 May 2015 12:26:27 +0800
Message-Id: <1430886389-26878-7-git-send-email-ming.lei@canonical.com>
In-Reply-To: <1430886389-26878-1-git-send-email-ming.lei@canonical.com>
References: <1430886389-26878-1-git-send-email-ming.lei@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jarod Wilson <jarod@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, nbd-general@lists.sourceforge.net, Stefan Haberland <stefan.haberland@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Fabian Frederick <fabf@skynet.be>, Peter Zijlstra <peterz@infradead.org>, linux-s390@vger.kernel.org, Ming Lei <ming.lei@canonical.com>
List-ID: <linux-s390.vger.kernel.org>

The only possible problem of using mutex_lock() instead of trylock
is about deadlock.

If there aren't any locks held before calling blkdev_reread_part(),
deadlock can't be caused by this conversion.

If there are locks held before calling blkdev_reread_part(),
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Jarod Wilson <jarod@redhat.com>
Acked-by: Jarod Wilson <jarod@redhat.com>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 block/ioctl.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 203cb4a..8061eba 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -174,13 +174,18 @@ EXPORT_SYMBOL(__blkdev_reread_part);
  * This is an exported API for the block driver, and will
  * try to acquire bd_mutex. If bd_mutex has been held already
  * in current context, please call __blkdev_reread_part().
+ *
+ * Make sure the held locks in current context aren't required
+ * in open()/close() handler and I/O path for avoiding ABBA deadlock:
+ * - bd_mutex is held before calling block driver's open/close
+ *   handler
+ * - reading partition table may submit I/O to the block device
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
1.9.1
