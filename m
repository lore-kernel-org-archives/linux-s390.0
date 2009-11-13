Return-Path: <linux-kernel-owner+w=401wt.eu-S1757088AbZKMPQz@vger.kernel.org>
Message-Id: <20091113150910.689561802@de.ibm.com>
Date: Fri, 13 Nov 2009 16:08:32 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 08/52] [PATCH] dasd: support DIAG access for read-only devices
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=107-dasd-diag-ro.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Weinhuber <wein@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Weinhuber <wein@de.ibm.com>

When a DASD device is used with the DIAG discipline, the DIAG
initialization will indicate success or error with a respective
return code. So far we have interpreted a return code of 4 as error,
but it actually means that the initialization was successful, but
the device is read-only. To allow read-only devices to be used with
DIAG we need to accept a return code of 4 as success.

Re-initialization of the DIAG access is also part of the DIAG error
recovery. If we find that the access mode of a device has been
changed from writable to read-only while the device was in use,
we print an error message.

Signed-off-by: Stefan Weinhuber <wein@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd_diag.c |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

Index: quilt-2.6/drivers/s390/block/dasd_diag.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_diag.c	2009-11-13 15:48:33.000000000 +0100
+++ quilt-2.6/drivers/s390/block/dasd_diag.c	2009-11-13 16:08:13.000000000 +0100
@@ -145,6 +145,15 @@
 
 	mdsk_term_io(device);
 	rc = mdsk_init_io(device, device->block->bp_block, 0, NULL);
+	if (rc == 4) {
+		if (!(device->features & DASD_FEATURE_READONLY)) {
+			dev_warn(&device->cdev->dev,
+				 "The access mode of a DIAG device changed"
+				 " to read-only");
+			device->features |= DASD_FEATURE_READONLY;
+		}
+		rc = 0;
+	}
 	if (rc)
 		dev_warn(&device->cdev->dev, "DIAG ERP failed with "
 			    "rc=%d\n", rc);
@@ -433,16 +442,20 @@
 	for (sb = 512; sb < bsize; sb = sb << 1)
 		block->s2b_shift++;
 	rc = mdsk_init_io(device, block->bp_block, 0, NULL);
-	if (rc) {
+	if (rc && (rc != 4)) {
 		dev_warn(&device->cdev->dev, "DIAG initialization "
 			"failed with rc=%d\n", rc);
 		rc = -EIO;
 	} else {
+		if (rc == 4)
+			device->features |= DASD_FEATURE_READONLY;
 		dev_info(&device->cdev->dev,
-			 "New DASD with %ld byte/block, total size %ld KB\n",
+			 "New DASD with %ld byte/block, total size %ld KB%s\n",
 			 (unsigned long) block->bp_block,
 			 (unsigned long) (block->blocks <<
-					  block->s2b_shift) >> 1);
+					  block->s2b_shift) >> 1,
+			 (rc == 4) ? ", read-only device" : "");
+		rc = 0;
 	}
 out_label:
 	free_page((long) label);
