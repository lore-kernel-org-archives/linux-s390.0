Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726628AbgDUGMm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Apr 2020 02:12:42 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/3] partitions/ibm: stop using ioctl_by_bdev
Date: Tue, 21 Apr 2020 08:12:26 +0200
Message-Id: <20200421061226.33731-4-hch@lst.de>
In-Reply-To: <20200421061226.33731-1-hch@lst.de>
References: <20200421061226.33731-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org

Just call the getgeo and biodasdinfo methods directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/ibm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/partitions/ibm.c b/block/partitions/ibm.c
index 073faa6a69b8..21dc6da20ff2 100644
--- a/block/partitions/ibm.c
+++ b/block/partitions/ibm.c
@@ -289,6 +289,7 @@ static int find_cms1_partitions(struct parsed_partitions *state,
 int ibm_partition(struct parsed_partitions *state)
 {
 	struct block_device *bdev = state->bdev;
+	struct gendisk *disk = bdev->bd_disk;
 	int blocksize, res;
 	loff_t i_size, offset, size;
 	dasd_information2_t *info;
@@ -308,15 +309,16 @@ int ibm_partition(struct parsed_partitions *state)
 	info = kmalloc(sizeof(dasd_information2_t), GFP_KERNEL);
 	if (info == NULL)
 		goto out_exit;
-	geo = kmalloc(sizeof(struct hd_geometry), GFP_KERNEL);
+	geo = kzalloc(sizeof(struct hd_geometry), GFP_KERNEL);
 	if (geo == NULL)
 		goto out_nogeo;
 	label = kmalloc(sizeof(union label_t), GFP_KERNEL);
 	if (label == NULL)
 		goto out_nolab;
-	if (ioctl_by_bdev(bdev, HDIO_GETGEO, (unsigned long)geo) != 0)
+	geo->start = get_start_sect(bdev);
+	if (!disk->fops->getgeo || disk->fops->getgeo(bdev, geo))
 		goto out_freeall;
-	if (ioctl_by_bdev(bdev, BIODASDINFO2, (unsigned long)info) != 0) {
+	if (!disk->fops->biodasdinfo || disk->fops->biodasdinfo(disk, info)) {
 		kfree(info);
 		info = NULL;
 	}
-- 
2.26.1
