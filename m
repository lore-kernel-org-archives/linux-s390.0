Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jarod Wilson <jarod@redhat.com>
Subject: [PATCH 4/7] block: nbd: convert to blkdev_reread_part()
Date: Wed,  8 Apr 2015 02:23:43 -0400
Message-Id: <1428474226-27386-5-git-send-email-jarod@redhat.com>
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
 drivers/block/nbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index a98c41f..7e9d26e 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -734,7 +734,7 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 		bdev->bd_inode->i_size = 0;
 		set_capacity(nbd->disk, 0);
 		if (max_part > 0)
-			ioctl_by_bdev(bdev, BLKRRPART, 0);
+			blkdev_reread_part(bdev);
 		if (nbd->disconnect) /* user requested, ignore socket errors */
 			return 0;
 		return nbd->harderror;
-- 
1.8.3.1
