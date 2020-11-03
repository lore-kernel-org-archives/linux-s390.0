Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbgKCKY3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Nov 2020 05:24:29 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 10/10] block: remove __blkdev_driver_ioctl
Date: Tue,  3 Nov 2020 11:00:18 +0100
Message-Id: <20201103100018.683694-11-hch@lst.de>
In-Reply-To: <20201103100018.683694-1-hch@lst.de>
References: <20201103100018.683694-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ilya Dryomov <idryomov@gmail.com>, Song Liu <song@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-block@vger.kernel.org, ceph-devel@vger.kernel.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org

Just open code it in the few callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/ioctl.c               | 25 +++++--------------------
 drivers/block/pktcdvd.c     |  6 ++++--
 drivers/md/bcache/request.c |  5 +++--
 drivers/md/dm.c             |  5 ++++-
 include/linux/blkdev.h      |  2 --
 5 files changed, 16 insertions(+), 27 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 04255dc5f3bff3..6b785181344fe1 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -219,23 +219,6 @@ static int compat_put_ulong(compat_ulong_t __user *argp, compat_ulong_t val)
 }
 #endif
 
-int __blkdev_driver_ioctl(struct block_device *bdev, fmode_t mode,
-			unsigned cmd, unsigned long arg)
-{
-	struct gendisk *disk = bdev->bd_disk;
-
-	if (disk->fops->ioctl)
-		return disk->fops->ioctl(bdev, mode, cmd, arg);
-
-	return -ENOTTY;
-}
-/*
- * For the record: _GPL here is only because somebody decided to slap it
- * on the previous export.  Sheer idiocy, since it wasn't copyrightable
- * at all and could be open-coded without any exports by anybody who cares.
- */
-EXPORT_SYMBOL_GPL(__blkdev_driver_ioctl);
-
 #ifdef CONFIG_COMPAT
 /*
  * This is the equivalent of compat_ptr_ioctl(), to be used by block
@@ -594,10 +577,12 @@ int blkdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 	}
 
 	ret = blkdev_common_ioctl(bdev, mode, cmd, arg, argp);
-	if (ret == -ENOIOCTLCMD)
-		return __blkdev_driver_ioctl(bdev, mode, cmd, arg);
+	if (ret != -ENOIOCTLCMD)
+		return ret;
 
-	return ret;
+	if (!bdev->bd_disk->fops->ioctl)
+		return -ENOTTY;
+	return bdev->bd_disk->fops->ioctl(bdev, mode, cmd, arg);
 }
 EXPORT_SYMBOL_GPL(blkdev_ioctl); /* for /dev/raw */
 
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 467dbd06b7cdb1..ef1c1f094ea4fc 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2584,9 +2584,11 @@ static int pkt_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd,
 	case CDROM_LAST_WRITTEN:
 	case CDROM_SEND_PACKET:
 	case SCSI_IOCTL_SEND_COMMAND:
-		ret = __blkdev_driver_ioctl(pd->bdev, mode, cmd, arg);
+		if (!bdev->bd_disk->fops->ioctl)
+			ret = -ENOTTY;
+		else
+			ret = bdev->bd_disk->fops->ioctl(bdev, mode, cmd, arg);
 		break;
-
 	default:
 		pkt_dbg(2, pd, "Unknown ioctl (%x)\n", cmd);
 		ret = -ENOTTY;
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 21432638314562..afac8d07c1bd00 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -1230,8 +1230,9 @@ static int cached_dev_ioctl(struct bcache_device *d, fmode_t mode,
 
 	if (dc->io_disable)
 		return -EIO;
-
-	return __blkdev_driver_ioctl(dc->bdev, mode, cmd, arg);
+	if (!dc->bdev->bd_disk->fops->ioctl)
+		return -ENOTTY;
+	return dc->bdev->bd_disk->fops->ioctl(dc->bdev, mode, cmd, arg);
 }
 
 void bch_cached_dev_request_init(struct cached_dev *dc)
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index c18fc25485186d..6db395c3d28be8 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -570,7 +570,10 @@ static int dm_blk_ioctl(struct block_device *bdev, fmode_t mode,
 		}
 	}
 
-	r =  __blkdev_driver_ioctl(bdev, mode, cmd, arg);
+	if (!bdev->bd_disk->fops->ioctl)
+		r = -ENOTTY;
+	else
+		r = bdev->bd_disk->fops->ioctl(bdev, mode, cmd, arg);
 out:
 	dm_unprepare_ioctl(md, srcu_idx);
 	return r;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5c1ba8a8d2bc7e..05b346a68c2eee 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1867,8 +1867,6 @@ extern int blkdev_compat_ptr_ioctl(struct block_device *, fmode_t,
 #define blkdev_compat_ptr_ioctl NULL
 #endif
 
-extern int __blkdev_driver_ioctl(struct block_device *, fmode_t, unsigned int,
-				 unsigned long);
 extern int bdev_read_page(struct block_device *, sector_t, struct page *);
 extern int bdev_write_page(struct block_device *, sector_t, struct page *,
 						struct writeback_control *);
-- 
2.28.0
