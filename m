Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ming Lei <ming.lei@canonical.com>
Subject: [PATCH v3 4/7] block: nbd: convert to blkdev_reread_part()
Date: Wed,  6 May 2015 12:26:25 +0800
Message-Id: <1430886389-26878-5-git-send-email-ming.lei@canonical.com>
In-Reply-To: <1430886389-26878-1-git-send-email-ming.lei@canonical.com>
References: <1430886389-26878-1-git-send-email-ming.lei@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jarod Wilson <jarod@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, nbd-general@lists.sourceforge.net, Stefan Haberland <stefan.haberland@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Fabian Frederick <fabf@skynet.be>, Peter Zijlstra <peterz@infradead.org>, linux-s390@vger.kernel.org, Ming Lei <ming.lei@canonical.com>
List-ID: <linux-s390.vger.kernel.org>

Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Jarod Wilson <jarod@redhat.com>
Acked-by: Jarod Wilson <jarod@redhat.com>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 drivers/block/nbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 39e5f7f..50d7f87 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -713,7 +713,7 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 		bdev->bd_inode->i_size = 0;
 		set_capacity(nbd->disk, 0);
 		if (max_part > 0)
-			ioctl_by_bdev(bdev, BLKRRPART, 0);
+			blkdev_reread_part(bdev);
 		if (nbd->disconnect) /* user requested, ignore socket errors */
 			return 0;
 		return nbd->harderror;
-- 
1.9.1
