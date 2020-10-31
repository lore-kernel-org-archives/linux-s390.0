Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgJaJCn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 31 Oct 2020 05:02:43 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 01/11] mtd_blkdevs: don't override BLKFLSBUF
Date: Sat, 31 Oct 2020 09:58:00 +0100
Message-Id: <20201031085810.450489-2-hch@lst.de>
In-Reply-To: <20201031085810.450489-1-hch@lst.de>
References: <20201031085810.450489-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ilya Dryomov <idryomov@gmail.com>, Song Liu <song@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-block@vger.kernel.org, ceph-devel@vger.kernel.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org

BLKFLSBUF does not actually send a flush command to the device, but
teard down buffer cache structures.  Remove the mtd_blkdevs
implementation and just use the default semantics instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mtd/mtd_blkdevs.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 0c05f77f9b216e..fb8e12d590a13a 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -298,38 +298,10 @@ static int blktrans_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 	return ret;
 }
 
-static int blktrans_ioctl(struct block_device *bdev, fmode_t mode,
-			      unsigned int cmd, unsigned long arg)
-{
-	struct mtd_blktrans_dev *dev = blktrans_dev_get(bdev->bd_disk);
-	int ret = -ENXIO;
-
-	if (!dev)
-		return ret;
-
-	mutex_lock(&dev->lock);
-
-	if (!dev->mtd)
-		goto unlock;
-
-	switch (cmd) {
-	case BLKFLSBUF:
-		ret = dev->tr->flush ? dev->tr->flush(dev) : 0;
-		break;
-	default:
-		ret = -ENOTTY;
-	}
-unlock:
-	mutex_unlock(&dev->lock);
-	blktrans_dev_put(dev);
-	return ret;
-}
-
 static const struct block_device_operations mtd_block_ops = {
 	.owner		= THIS_MODULE,
 	.open		= blktrans_open,
 	.release	= blktrans_release,
-	.ioctl		= blktrans_ioctl,
 	.getgeo		= blktrans_getgeo,
 };
 
-- 
2.28.0
