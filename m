Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44506 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728237AbgEHNPI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 8 May 2020 09:15:08 -0400
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH v3 3/3] s390/dasd: remove ioctl_by_bdev calls
Date: Fri,  8 May 2020 15:14:55 +0200
Message-Id: <20200508131455.55407-4-sth@linux.ibm.com>
In-Reply-To: <20200508131455.55407-1-sth@linux.ibm.com>
References: <20200508131455.55407-1-sth@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: hch@lst.de
Cc: axboe@kernel.dk, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, linux-kernel@vger.kernel.org, borntraeger@de.ibm.com

Call getgeo method directly and obtain pointer to dasd_biodasdinfo
function and use this instead of ioctl.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 block/partitions/ibm.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/block/partitions/ibm.c b/block/partitions/ibm.c
index 073faa6a69b8..69c27b8bee97 100644
--- a/block/partitions/ibm.c
+++ b/block/partitions/ibm.c
@@ -13,10 +13,10 @@
 #include <asm/ebcdic.h>
 #include <linux/uaccess.h>
 #include <asm/vtoc.h>
+#include <linux/kallsyms.h>
 
 #include "check.h"
 
-
 union label_t {
 	struct vtoc_volume_label_cdl vol;
 	struct vtoc_volume_label_ldl lnx;
@@ -288,7 +288,9 @@ static int find_cms1_partitions(struct parsed_partitions *state,
  */
 int ibm_partition(struct parsed_partitions *state)
 {
+	int (*dasd_biodasdinfo)(struct gendisk *, dasd_information2_t *);
 	struct block_device *bdev = state->bdev;
+	struct gendisk *disk = bdev->bd_disk;
 	int blocksize, res;
 	loff_t i_size, offset, size;
 	dasd_information2_t *info;
@@ -297,6 +299,7 @@ int ibm_partition(struct parsed_partitions *state)
 	char name[7] = {0,};
 	sector_t labelsect;
 	union label_t *label;
+	int rc = 0;
 
 	res = 0;
 	blocksize = bdev_logical_block_size(bdev);
@@ -314,9 +317,15 @@ int ibm_partition(struct parsed_partitions *state)
 	label = kmalloc(sizeof(union label_t), GFP_KERNEL);
 	if (label == NULL)
 		goto out_nolab;
-	if (ioctl_by_bdev(bdev, HDIO_GETGEO, (unsigned long)geo) != 0)
+	geo->start = get_start_sect(bdev);
+	if (!disk->fops->getgeo || disk->fops->getgeo(bdev, geo))
+		goto out_freeall;
+	dasd_biodasdinfo = (void *)kallsyms_lookup_name("dasd_biodasdinfo");
+	if (dasd_biodasdinfo)
+		rc = dasd_biodasdinfo(disk, info);
+	if (rc == -EINVAL)
 		goto out_freeall;
-	if (ioctl_by_bdev(bdev, BIODASDINFO2, (unsigned long)info) != 0) {
+	if (rc) {
 		kfree(info);
 		info = NULL;
 	}
-- 
2.17.1
