Return-Path: <linux-kernel-owner+w=401wt.eu-S1764132AbXGJJaA@vger.kernel.org>
Message-Id: <20070710093108.793183492@de.ibm.com>
References: <20070710092935.896013926@de.ibm.com>
Date: Tue, 10 Jul 2007 11:29:40 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 05/16] fixed cdl-format detection.
Content-Disposition: inline; filename=005-partitions.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Stefan Haberland <stefan.haberland@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Haberland <stefan.haberland@de.ibm.com>

CDL formated DASDs are now detected correctly even if no VOL1 label is
on the disk. This prevents possible loss of data.

Signed-off-by: Stefan Haberland <stefan.haberland@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 fs/partitions/ibm.c |  167 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 97 insertions(+), 70 deletions(-)

Index: quilt-2.6/fs/partitions/ibm.c
===================================================================
--- quilt-2.6.orig/fs/partitions/ibm.c
+++ quilt-2.6/fs/partitions/ibm.c
@@ -45,7 +45,7 @@ ibm_partition(struct parsed_partitions *
 {
 	int blocksize, offset, size,res;
 	loff_t i_size;
-	dasd_information_t *info;
+	dasd_information2_t *info;
 	struct hd_geometry *geo;
 	char type[5] = {0,};
 	char name[7] = {0,};
@@ -64,14 +64,17 @@ ibm_partition(struct parsed_partitions *
 	if (i_size == 0)
 		goto out_exit;
 
-	if ((info = kmalloc(sizeof(dasd_information_t), GFP_KERNEL)) == NULL)
+	info = kmalloc(sizeof(dasd_information2_t), GFP_KERNEL);
+	if (info == NULL)
 		goto out_exit;
-	if ((geo = kmalloc(sizeof(struct hd_geometry), GFP_KERNEL)) == NULL)
+	geo = kmalloc(sizeof(struct hd_geometry), GFP_KERNEL);
+	if (geo == NULL)
 		goto out_nogeo;
-	if ((label = kmalloc(sizeof(union label_t), GFP_KERNEL)) == NULL)
+	label = kmalloc(sizeof(union label_t), GFP_KERNEL);
+	if (label == NULL)
 		goto out_nolab;
 
-	if (ioctl_by_bdev(bdev, BIODASDINFO, (unsigned long)info) != 0 ||
+	if (ioctl_by_bdev(bdev, BIODASDINFO2, (unsigned long)info) != 0 ||
 	    ioctl_by_bdev(bdev, HDIO_GETGEO, (unsigned long)geo) != 0)
 		goto out_freeall;
 
@@ -96,84 +99,108 @@ ibm_partition(struct parsed_partitions *
 	res = 1;
 
 	/*
-	 * Three different types: CMS1, VOL1 and LNX1/unlabeled
+	 * Three different formats: LDL, CDL and unformated disk
+	 *
+	 * identified by info->format
+	 *
+	 * unformated disks we do not have to care about
 	 */
-	if (strncmp(type, "CMS1", 4) == 0) {
-		/*
-		 * VM style CMS1 labeled disk
-		 */
-		if (label->cms.disk_offset != 0) {
-			printk("CMS1/%8s(MDSK):", name);
-			/* disk is reserved minidisk */
-			blocksize = label->cms.block_size;
-			offset = label->cms.disk_offset;
-			size = (label->cms.block_count - 1) * (blocksize >> 9);
+	if (info->format == DASD_FORMAT_LDL) {
+		if (strncmp(type, "CMS1", 4) == 0) {
+			/*
+			 * VM style CMS1 labeled disk
+			 */
+			if (label->cms.disk_offset != 0) {
+				printk("CMS1/%8s(MDSK):", name);
+				/* disk is reserved minidisk */
+				blocksize = label->cms.block_size;
+				offset = label->cms.disk_offset;
+				size = (label->cms.block_count - 1)
+					* (blocksize >> 9);
+			} else {
+				printk("CMS1/%8s:", name);
+				offset = (info->label_block + 1);
+				size = i_size >> 9;
+			}
 		} else {
-			printk("CMS1/%8s:", name);
+			/*
+			 * Old style LNX1 or unlabeled disk
+			 */
+			if (strncmp(type, "LNX1", 4) == 0)
+				printk ("LNX1/%8s:", name);
+			else
+				printk("(nonl)");
 			offset = (info->label_block + 1);
 			size = i_size >> 9;
 		}
 		put_partition(state, 1, offset*(blocksize >> 9),
-				 size-offset*(blocksize >> 9));
-	} else if ((strncmp(type, "VOL1", 4) == 0) &&
-		(!info->FBA_layout) && (!strcmp(info->type, "ECKD"))) {
+				      size-offset*(blocksize >> 9));
+	} else if (info->format == DASD_FORMAT_CDL) {
 		/*
-		 * New style VOL1 labeled disk
+		 * New style CDL formatted disk
 		 */
 		unsigned int blk;
 		int counter;
 
-		printk("VOL1/%8s:", name);
-
-		/* get block number and read then go through format1 labels */
-		blk = cchhb2blk(&label->vol.vtoc, geo) + 1;
-		counter = 0;
-		while ((data = read_dev_sector(bdev, blk*(blocksize/512),
-					       &sect)) != NULL) {
-			struct vtoc_format1_label f1;
-
-			memcpy(&f1, data, sizeof(struct vtoc_format1_label));
-			put_dev_sector(sect);
-
-			/* skip FMT4 / FMT5 / FMT7 labels */
-			if (f1.DS1FMTID == _ascebc['4']
-			    || f1.DS1FMTID == _ascebc['5']
-			    || f1.DS1FMTID == _ascebc['7']) {
-			        blk++;
-				continue;
-			}
-
-			/* only FMT1 valid at this point */
-			if (f1.DS1FMTID != _ascebc['1'])
-				break;
-
-			/* OK, we got valid partition data */
-		        offset = cchh2blk(&f1.DS1EXT1.llimit, geo);
-			size  = cchh2blk(&f1.DS1EXT1.ulimit, geo) -
-				offset + geo->sectors;
-			if (counter >= state->limit)
-				break;
-			put_partition(state, counter + 1,
-				      offset * (blocksize >> 9),
-				      size * (blocksize >> 9));
-			counter++;
-			blk++;
-		}
-		if (!data)
-		/* Are we not supposed to report this ? */
-			goto out_readerr;
-	} else {
 		/*
-		 * Old style LNX1 or unlabeled disk
+		 * check if VOL1 label is available
+		 * if not, something is wrong, skipping partition detection
 		 */
-		if (strncmp(type, "LNX1", 4) == 0)
-			printk ("LNX1/%8s:", name);
-		else
-			printk("(nonl)/%8s:", name);
-		offset = (info->label_block + 1);
-		size = i_size >> 9;
-		put_partition(state, 1, offset*(blocksize >> 9),
-			      size-offset*(blocksize >> 9));
+		if (strncmp(type, "VOL1",  4) == 0) {
+			printk("VOL1/%8s:", name);
+			/*
+			 * get block number and read then go through format1
+			 * labels
+			 */
+			blk = cchhb2blk(&label->vol.vtoc, geo) + 1;
+			counter = 0;
+			data = read_dev_sector(bdev, blk * (blocksize/512),
+					       &sect);
+			while (data != NULL) {
+				struct vtoc_format1_label f1;
+
+				memcpy(&f1, data,
+				       sizeof(struct vtoc_format1_label));
+				put_dev_sector(sect);
+
+				/* skip FMT4 / FMT5 / FMT7 labels */
+				if (f1.DS1FMTID == _ascebc['4']
+				    || f1.DS1FMTID == _ascebc['5']
+				    || f1.DS1FMTID == _ascebc['7']) {
+					blk++;
+					data = read_dev_sector(bdev, blk *
+							       (blocksize/512),
+								&sect);
+					continue;
+				}
+
+				/* only FMT1 valid at this point */
+				if (f1.DS1FMTID != _ascebc['1'])
+					break;
+
+				/* OK, we got valid partition data */
+				offset = cchh2blk(&f1.DS1EXT1.llimit, geo);
+				size  = cchh2blk(&f1.DS1EXT1.ulimit, geo) -
+					offset + geo->sectors;
+				if (counter >= state->limit)
+					break;
+				put_partition(state, counter + 1,
+					      offset * (blocksize >> 9),
+					      size * (blocksize >> 9));
+				counter++;
+				blk++;
+				data = read_dev_sector(bdev,
+						       blk * (blocksize/512),
+						       &sect);
+			}
+
+			if (!data)
+				/* Are we not supposed to report this ? */
+				goto out_readerr;
+		} else
+			printk(KERN_WARNING "Warning, expected Label VOL1 not "
+			       "found, treating as CDL formated Disk");
+
 	}
 
 	printk("\n");

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
