Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22032 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728303AbgEHNPH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 8 May 2020 09:15:07 -0400
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH v3 2/3] block: add a s390-only biodasdinfo method
Date: Fri,  8 May 2020 15:14:54 +0200
Message-Id: <20200508131455.55407-3-sth@linux.ibm.com>
In-Reply-To: <20200508131455.55407-1-sth@linux.ibm.com>
References: <20200508131455.55407-1-sth@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: hch@lst.de
Cc: axboe@kernel.dk, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, linux-kernel@vger.kernel.org, borntraeger@de.ibm.com

From: Christoph Hellwig <hch@lst.de>

The IBM partition parser needs to query the DASD driver for details that
are very s390 specific.  Instead of using ioctl_by_bdev with a fake user
space pointer just add a s390-specific method to get the information
directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
[sth@linux.ibm.com: remove fop, add gendisk check, export funcion]
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_int.h   |  1 +
 drivers/s390/block/dasd_ioctl.c | 21 +++++++++++++++++++++
 include/linux/blkdev.h          |  1 +
 3 files changed, 23 insertions(+)

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
index dabcb4ce92da..d29045a37b92 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -666,3 +666,24 @@ int dasd_ioctl(struct block_device *bdev, fmode_t mode,
 	dasd_put_device(base);
 	return rc;
 }
+
+int dasd_biodasdinfo(struct gendisk *disk, struct dasd_information2_t *info)
+{
+	struct dasd_device *base;
+	int error;
+
+	/*
+	 * we might get called externaly, so check if the gendisk belongs
+	 * to a DASD by checking the fops pointer
+	 */
+	if (disk->fops != &dasd_device_operations)
+		return -EINVAL;
+
+	base = dasd_device_from_gendisk(disk);
+	if (!base)
+		return -ENODEV;
+	error = __dasd_ioctl_information(base->block, info);
+	dasd_put_device(base);
+	return error;
+}
+EXPORT_SYMBOL(dasd_biodasdinfo);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 32868fbedc9e..915465aa8e43 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -43,6 +43,7 @@ struct pr_ops;
 struct rq_qos;
 struct blk_queue_stats;
 struct blk_stat_callback;
+struct dasd_information2_t;
 
 #define BLKDEV_MIN_RQ	4
 #define BLKDEV_MAX_RQ	128	/* Default maximum */
-- 
2.17.1
