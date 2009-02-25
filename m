Return-Path: <linux-kernel-owner+w=401wt.eu-S1760721AbZBYPKA@vger.kernel.org>
Message-Id: <20090225150828.189768478@de.ibm.com>
References: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:06:27 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 05/46] dasd_eckd / Write format R0 is now allowed BB
Content-Disposition: inline; filename=104-dasd-track0.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Jean-Baptiste Joret <joret@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jean-Baptiste Joret <joret@de.ibm.com>

Permission is now granted to the subsystem to format write R0 with:
* an ID = CCHHR, where CC = physical cylinder number,
  HH = physical head number, and R = 0
* a key length of zero
* a data length of eight
* a data field containing all zeros

Signed-off-by: Jean-Baptiste Joret <joret@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd_eckd.c |   25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

Index: quilt-2.6/drivers/s390/block/dasd_eckd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_eckd.c
+++ quilt-2.6/drivers/s390/block/dasd_eckd.c
@@ -1265,6 +1265,8 @@ dasd_eckd_format_device(struct dasd_devi
 	int rpt, cyl, head;
 	int cplength, datasize;
 	int i;
+	int intensity = 0;
+	int r0_perm;
 
 	private = (struct dasd_eckd_private *) device->private;
 	rpt = recs_per_track(&private->rdc_data, 0, fdata->blksize);
@@ -1296,9 +1298,17 @@ dasd_eckd_format_device(struct dasd_devi
 	 *   Bit 1: write home address, currently not supported
 	 *   Bit 2: invalidate tracks
 	 *   Bit 3: use OS/390 compatible disk layout (cdl)
+	 *   Bit 4: do not allow storage subsystem to modify record zero
 	 * Only some bit combinations do make sense.
 	 */
-	switch (fdata->intensity) {
+	if (fdata->intensity & 0x10) {
+		r0_perm = 0;
+		intensity = fdata->intensity & ~0x10;
+	} else {
+		r0_perm = 1;
+		intensity = fdata->intensity;
+	}
+	switch (intensity) {
 	case 0x00:	/* Normal format */
 	case 0x08:	/* Normal format, use cdl. */
 		cplength = 2 + rpt;
@@ -1335,11 +1345,14 @@ dasd_eckd_format_device(struct dasd_devi
 	data = fcp->data;
 	ccw = fcp->cpaddr;
 
-	switch (fdata->intensity & ~0x08) {
+	switch (intensity & ~0x08) {
 	case 0x00: /* Normal format. */
 		define_extent(ccw++, (struct DE_eckd_data *) data,
 			      fdata->start_unit, fdata->start_unit,
 			      DASD_ECKD_CCW_WRITE_CKD, device);
+		/* grant subsystem permission to format R0 */
+		if (r0_perm)
+			((struct DE_eckd_data *)data)->ga_extended |= 0x04;
 		data += sizeof(struct DE_eckd_data);
 		ccw[-1].flags |= CCW_FLAG_CC;
 		locate_record(ccw++, (struct LO_eckd_data *) data,
@@ -1373,7 +1386,7 @@ dasd_eckd_format_device(struct dasd_devi
 		data += sizeof(struct LO_eckd_data);
 		break;
 	}
-	if (fdata->intensity & 0x01) {	/* write record zero */
+	if (intensity & 0x01) {	/* write record zero */
 		ect = (struct eckd_count *) data;
 		data += sizeof(struct eckd_count);
 		ect->cyl = cyl;
@@ -1388,7 +1401,7 @@ dasd_eckd_format_device(struct dasd_devi
 		ccw->cda = (__u32)(addr_t) ect;
 		ccw++;
 	}
-	if ((fdata->intensity & ~0x08) & 0x04) {	/* erase track */
+	if ((intensity & ~0x08) & 0x04) {	/* erase track */
 		ect = (struct eckd_count *) data;
 		data += sizeof(struct eckd_count);
 		ect->cyl = cyl;
@@ -1411,14 +1424,14 @@ dasd_eckd_format_device(struct dasd_devi
 			ect->kl = 0;
 			ect->dl = fdata->blksize;
 			/* Check for special tracks 0-1 when formatting CDL */
-			if ((fdata->intensity & 0x08) &&
+			if ((intensity & 0x08) &&
 			    fdata->start_unit == 0) {
 				if (i < 3) {
 					ect->kl = 4;
 					ect->dl = sizes_trk0[i] - 4;
 				}
 			}
-			if ((fdata->intensity & 0x08) &&
+			if ((intensity & 0x08) &&
 			    fdata->start_unit == 1) {
 				ect->kl = 44;
 				ect->dl = LABEL_SIZE - 44;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
