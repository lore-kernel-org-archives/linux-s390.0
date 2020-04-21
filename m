Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726801AbgDUGMe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Apr 2020 02:12:34 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/3] block: add a s390-only biodasdinfo method
Date: Tue, 21 Apr 2020 08:12:25 +0200
Message-Id: <20200421061226.33731-3-hch@lst.de>
In-Reply-To: <20200421061226.33731-1-hch@lst.de>
References: <20200421061226.33731-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org

The IBM partition parser needs to query the DASD driver for details that
are very s390 specific.  Instead of using ioctl_by_bdev with a fake user
space pointer just add a s390-specific method to get the information
directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/s390/block/dasd.c       |  1 +
 drivers/s390/block/dasd_int.h   |  1 +
 drivers/s390/block/dasd_ioctl.c | 13 +++++++++++++
 include/linux/blkdev.h          |  5 +++++
 4 files changed, 20 insertions(+)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index cf87eb27879f..26edd93167e7 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3394,6 +3394,7 @@ dasd_device_operations = {
 	.ioctl		= dasd_ioctl,
 	.compat_ioctl	= dasd_ioctl,
 	.getgeo		= dasd_getgeo,
+	.biodasdinfo	= dasd_biodasdinfo,
 };
 
 /*******************************************************************************
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index fa552f9f1666..6eac7b11c75b 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -845,6 +845,7 @@ void dasd_destroy_partitions(struct dasd_block *);
 
 /* externals in dasd_ioctl.c */
 int  dasd_ioctl(struct block_device *, fmode_t, unsigned int, unsigned long);
+int dasd_biodasdinfo(struct gendisk *disk, struct dasd_information2_t *info);
 
 /* externals in dasd_proc.c */
 int dasd_proc_init(void);
diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index dabcb4ce92da..332836d46ba0 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -666,3 +666,16 @@ int dasd_ioctl(struct block_device *bdev, fmode_t mode,
 	dasd_put_device(base);
 	return rc;
 }
+
+int dasd_biodasdinfo(struct gendisk *disk, struct dasd_information2_t *info)
+{
+	struct dasd_device *base;
+	int error;
+
+	base = dasd_device_from_gendisk(disk);
+	if (!base)
+		return -ENODEV;
+	error = __dasd_ioctl_information(base->block, info);
+	dasd_put_device(base);
+	return error;
+}
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 32868fbedc9e..3b92cc970083 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -43,6 +43,7 @@ struct pr_ops;
 struct rq_qos;
 struct blk_queue_stats;
 struct blk_stat_callback;
+struct dasd_information2_t;
 
 #define BLKDEV_MIN_RQ	4
 #define BLKDEV_MAX_RQ	128	/* Default maximum */
@@ -1700,6 +1701,10 @@ struct block_device_operations {
 	int (*report_zones)(struct gendisk *, sector_t sector,
 			unsigned int nr_zones, report_zones_cb cb, void *data);
 	char *(*devnode)(struct gendisk *disk, umode_t *mode);
+#ifdef CONFIG_S390
+	int (*biodasdinfo)(struct gendisk *disk,
+			struct dasd_information2_t *info);
+#endif
 	struct module *owner;
 	const struct pr_ops *pr_ops;
 };
-- 
2.26.1
