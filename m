Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ming Lei <ming.lei@canonical.com>
Subject: [RFC PATCH 6/6] block: replace trylock with mutex_lock in __blkdev_reread_part()
Date: Sun,  5 Apr 2015 15:24:48 +0800
Message-Id: <1428218688-4092-7-git-send-email-ming.lei@canonical.com>
In-Reply-To: <1428218688-4092-1-git-send-email-ming.lei@canonical.com>
References: <1428218688-4092-1-git-send-email-ming.lei@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jarod Wilson <jarod@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, nbd-general@lists.sourceforge.net, Stefan Haberland <stefan.haberland@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Fabian Frederick <fabf@skynet.be>, linux-s390@vger.kernel.org, Ming Lei <ming.lei@canonical.com>
List-ID: <linux-s390.vger.kernel.org>

The only possible problem of using mutex_lock() instead of trylock
is about deadlock.

If there aren't any locks held before calling __blkdev_reread_part(lock),
deadlock can't be caused by this conversion.

If there are locks held before calling __blkdev_reread_part(lock),
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

Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 block/ioctl.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 7dce19a..a7aaf13 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -153,6 +153,12 @@ static int blkpg_ioctl(struct block_device *bdev, struct blkpg_ioctl_arg __user
 /*
  * This is exported as API for block driver, can be called
  * with requiring bd_mutex or not.
+ *
+ * When lock is true, make sure the held locks aren't required in
+ * open()/close() handler and I/O path for avoiding ABBA deadlock:
+ * - bd_mutex is held before calling block driver's open/close
+ *   handler
+ * - reading partition table may submit I/O to the block device
  */
 int __blkdev_reread_part(struct block_device *bdev, bool lock)
 {
@@ -163,8 +169,8 @@ int __blkdev_reread_part(struct block_device *bdev, bool lock)
 		return -EINVAL;
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
-	if (lock && !mutex_trylock(&bdev->bd_mutex))
-		return -EBUSY;
+	if (lock)
+		mutex_lock(&bdev->bd_mutex);
 	res = rescan_partitions(disk, bdev);
 	if (lock)
 		mutex_unlock(&bdev->bd_mutex);
-- 
1.7.9.5
