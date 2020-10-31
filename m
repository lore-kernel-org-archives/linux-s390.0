Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgJaJEx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 31 Oct 2020 05:04:53 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 02/11] mtip32xx: return -ENOTTY for all unhanled ioctls
Date: Sat, 31 Oct 2020 09:58:01 +0100
Message-Id: <20201031085810.450489-3-hch@lst.de>
In-Reply-To: <20201031085810.450489-1-hch@lst.de>
References: <20201031085810.450489-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ilya Dryomov <idryomov@gmail.com>, Song Liu <song@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-block@vger.kernel.org, ceph-devel@vger.kernel.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org

-ENOTTY is the convention for "driver does not support this ioctl".
Use it properly in mtip32xx instead of the bogys -EINVAL.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/mtip32xx/mtip32xx.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 153e2cdecb4d40..893be95eceb34e 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -2029,7 +2029,7 @@ static int mtip_hw_ioctl(struct driver_data *dd, unsigned int cmd,
 	}
 
 	default:
-		return -EINVAL;
+		return -ENOTTY;
 	}
 	return 0;
 }
@@ -3215,12 +3215,7 @@ static int mtip_block_ioctl(struct block_device *dev,
 	if (unlikely(test_bit(MTIP_DDF_REMOVE_PENDING_BIT, &dd->dd_flag)))
 		return -ENOTTY;
 
-	switch (cmd) {
-	case BLKFLSBUF:
-		return -ENOTTY;
-	default:
-		return mtip_hw_ioctl(dd, cmd, arg);
-	}
+	return mtip_hw_ioctl(dd, cmd, arg);
 }
 
 #ifdef CONFIG_COMPAT
@@ -3254,8 +3249,6 @@ static int mtip_block_compat_ioctl(struct block_device *dev,
 		return -ENOTTY;
 
 	switch (cmd) {
-	case BLKFLSBUF:
-		return -ENOTTY;
 	case HDIO_DRIVE_TASKFILE: {
 		struct mtip_compat_ide_task_request_s __user *compat_req_task;
 		ide_task_request_t req_task;
-- 
2.28.0
