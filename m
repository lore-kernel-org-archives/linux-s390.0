Return-Path: <BATV+780813b3d5625c257917+5120+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] partitions/ibm: call ->getgeo directly
Date: Wed, 30 Aug 2017 09:22:42 +0200
Message-Id: <20170830072242.11222-1-hch@lst.de>
List-Archive: <https://lore.kernel.org/linux-block/>
List-Post: <mailto:linux-block@vger.kernel.org>
To: axboe@kernel.dk, sth@linux.vnet.ibm.com, hoeppner@linux.vnet.ibm.com
Cc: linux-s390@vger.kernel.org, linux-block@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Trying to get rid of as many as possible ioctl_by_bdev callers to reduce
set_fs instances.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/ibm.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/block/partitions/ibm.c b/block/partitions/ibm.c
index 14b081af8d61..3ef8bfa3db9d 100644
--- a/block/partitions/ibm.c
+++ b/block/partitions/ibm.c
@@ -282,7 +282,6 @@ static int find_cms1_partitions(struct parsed_partitions *state,
 	return 1;
 }
 
-
 /*
  * This is the main function, called by check.c
  */
@@ -292,7 +291,7 @@ int ibm_partition(struct parsed_partitions *state)
 	int blocksize, res;
 	loff_t i_size, offset, size;
 	dasd_information2_t *info;
-	struct hd_geometry *geo;
+	struct hd_geometry geo = { 0, };
 	char type[5] = {0,};
 	char name[7] = {0,};
 	sector_t labelsect;
@@ -308,30 +307,30 @@ int ibm_partition(struct parsed_partitions *state)
 	info = kmalloc(sizeof(dasd_information2_t), GFP_KERNEL);
 	if (info == NULL)
 		goto out_exit;
-	geo = kmalloc(sizeof(struct hd_geometry), GFP_KERNEL);
-	if (geo == NULL)
-		goto out_nogeo;
 	label = kmalloc(sizeof(union label_t), GFP_KERNEL);
 	if (label == NULL)
 		goto out_nolab;
-	if (ioctl_by_bdev(bdev, HDIO_GETGEO, (unsigned long)geo) != 0)
+	if (!bdev->bd_disk->fops->getgeo)
+		goto out_freeall;
+	geo.start = get_start_sect(bdev);
+	if (bdev->bd_disk->fops->getgeo(bdev, &geo) != 0)
 		goto out_freeall;
 	if (ioctl_by_bdev(bdev, BIODASDINFO2, (unsigned long)info) != 0) {
 		kfree(info);
 		info = NULL;
 	}
 
-	if (find_label(state, info, geo, blocksize, &labelsect, name, type,
+	if (find_label(state, info, &geo, blocksize, &labelsect, name, type,
 		       label)) {
 		if (!strncmp(type, "VOL1", 4)) {
-			res = find_vol1_partitions(state, geo, blocksize, name,
+			res = find_vol1_partitions(state, &geo, blocksize, name,
 						   label);
 		} else if (!strncmp(type, "LNX1", 4)) {
-			res = find_lnx1_partitions(state, geo, blocksize, name,
+			res = find_lnx1_partitions(state, &geo, blocksize, name,
 						   label, labelsect, i_size,
 						   info);
 		} else if (!strncmp(type, "CMS1", 4)) {
-			res = find_cms1_partitions(state, geo, blocksize, name,
+			res = find_cms1_partitions(state, &geo, blocksize, name,
 						   label, labelsect);
 		}
 	} else if (info) {
@@ -356,8 +355,6 @@ int ibm_partition(struct parsed_partitions *state)
 out_freeall:
 	kfree(label);
 out_nolab:
-	kfree(geo);
-out_nogeo:
 	kfree(info);
 out_exit:
 	return res;
-- 
2.11.0
