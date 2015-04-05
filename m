Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ming Lei <ming.lei@canonical.com>
Subject: [PATCH 4/6] block: nbd: convert to blkdev_reread_part()
Date: Sun,  5 Apr 2015 15:24:46 +0800
Message-Id: <1428218688-4092-5-git-send-email-ming.lei@canonical.com>
In-Reply-To: <1428218688-4092-1-git-send-email-ming.lei@canonical.com>
References: <1428218688-4092-1-git-send-email-ming.lei@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jarod Wilson <jarod@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, nbd-general@lists.sourceforge.net, Stefan Haberland <stefan.haberland@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Fabian Frederick <fabf@skynet.be>, linux-s390@vger.kernel.org, Ming Lei <ming.lei@canonical.com>
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 drivers/block/nbd.c |    2 +-
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
1.7.9.5
