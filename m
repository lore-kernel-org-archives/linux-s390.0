Return-Path: <linux-kernel-owner+w=401wt.eu-S1756339AbZBYPKt@vger.kernel.org>
Message-Id: <20090225150828.807377982@de.ibm.com>
References: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:06:29 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 07/46] dasd: message cleanup
Content-Disposition: inline; filename=106-kmsg-dasd.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Haberland <stefan.haberland@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Haberland <stefan.haberland@de.ibm.com>

Moved some Messages into s390 debugfeature and changed remaining 
messages to use the dev_xxx and pr_xxx macros.

Signed-off-by: Stefan Haberland <stefan.haberland@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd.c          |  159 ++++----
 drivers/s390/block/dasd_3990_erp.c |  730 ++++++++++++++++++-------------------
 drivers/s390/block/dasd_alias.c    |   10 
 drivers/s390/block/dasd_diag.c     |   57 +-
 drivers/s390/block/dasd_eckd.c     |  171 +++++---
 drivers/s390/block/dasd_erp.c      |   19 
 drivers/s390/block/dasd_fba.c      |   48 +-
 drivers/s390/block/dasd_int.h      |    6 
 drivers/s390/block/dasd_ioctl.c    |   27 -
 9 files changed, 650 insertions(+), 577 deletions(-)

Index: quilt-2.6/drivers/s390/block/dasd_3990_erp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_3990_erp.c
+++ quilt-2.6/drivers/s390/block/dasd_3990_erp.c
@@ -7,6 +7,8 @@
  *
  */
 
+#define KMSG_COMPONENT "dasd"
+
 #include <linux/timer.h>
 #include <linux/slab.h>
 #include <asm/idals.h>
@@ -75,7 +77,7 @@ dasd_3990_erp_block_queue(struct dasd_cc
 	struct dasd_device *device = erp->startdev;
 	unsigned long flags;
 
-	DEV_MESSAGE(KERN_INFO, device,
+	DBF_DEV_EVENT(DBF_INFO, device,
 		    "blocking request queue for %is", expires/HZ);
 
 	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
@@ -114,9 +116,9 @@ dasd_3990_erp_int_req(struct dasd_ccw_re
 	} else {
 
 		/* issue a message and wait for 'device ready' interrupt */
-		DEV_MESSAGE(KERN_ERR, device, "%s",
+		dev_err(&device->cdev->dev,
 			    "is offline or not installed - "
-			    "INTERVENTION REQUIRED!!");
+			    "INTERVENTION REQUIRED!!\n");
 
 		dasd_3990_erp_block_queue(erp, 60*HZ);
 	}
@@ -158,7 +160,7 @@ dasd_3990_erp_alternate_path(struct dasd
 
 	if ((erp->lpm & opm) != 0x00) {
 
-		DEV_MESSAGE(KERN_DEBUG, device,
+		DBF_DEV_EVENT(DBF_WARNING, device,
 			    "try alternate lpm=%x (lpum=%x / opm=%x)",
 			    erp->lpm, erp->irb.esw.esw0.sublog.lpum, opm);
 
@@ -166,10 +168,9 @@ dasd_3990_erp_alternate_path(struct dasd
 		erp->status = DASD_CQR_FILLED;
 		erp->retries = 10;
 	} else {
-		DEV_MESSAGE(KERN_ERR, device,
-			    "No alternate channel path left (lpum=%x / "
-			    "opm=%x) -> permanent error",
-			    erp->irb.esw.esw0.sublog.lpum, opm);
+		dev_err(&device->cdev->dev,
+			"The DASD cannot be reached on any path (lpum=%x"
+			"/opm=%x)\n", erp->irb.esw.esw0.sublog.lpum, opm);
 
 		/* post request with permanent error */
 		erp->status = DASD_CQR_FAILED;
@@ -204,8 +205,8 @@ dasd_3990_erp_DCTL(struct dasd_ccw_req *
 					  sizeof(struct DCTL_data),
 					  device);
 	if (IS_ERR(dctl_cqr)) {
-		DEV_MESSAGE(KERN_ERR, device, "%s",
-			    "Unable to allocate DCTL-CQR");
+		dev_err(&device->cdev->dev,
+			    "Unable to allocate DCTL-CQR\n");
 		erp->status = DASD_CQR_FAILED;
 		return erp;
 	}
@@ -294,7 +295,7 @@ dasd_3990_erp_action_4(struct dasd_ccw_r
 	/* interrupt (this enables easier enqueing of the cqr)	    */
 	if (erp->function != dasd_3990_erp_action_4) {
 
-		DEV_MESSAGE(KERN_INFO, device, "%s",
+		DBF_DEV_EVENT(DBF_INFO, device, "%s",
 			    "dasd_3990_erp_action_4: first time retry");
 
 		erp->retries = 256;
@@ -303,7 +304,7 @@ dasd_3990_erp_action_4(struct dasd_ccw_r
 	} else {
 		if (sense && (sense[25] == 0x1D)) { /* state change pending */
 
-			DEV_MESSAGE(KERN_INFO, device,
+			DBF_DEV_EVENT(DBF_INFO, device,
 				    "waiting for state change pending "
 				    "interrupt, %d retries left",
 				    erp->retries);
@@ -311,15 +312,14 @@ dasd_3990_erp_action_4(struct dasd_ccw_r
 			dasd_3990_erp_block_queue(erp, 30*HZ);
 
 		} else if (sense && (sense[25] == 0x1E)) {	/* busy */
-			DEV_MESSAGE(KERN_INFO, device,
+			DBF_DEV_EVENT(DBF_INFO, device,
 				    "busy - redriving request later, "
 				    "%d retries left",
 				    erp->retries);
                         dasd_3990_erp_block_queue(erp, HZ);
 		} else {
-
 			/* no state change pending - retry */
-			DEV_MESSAGE (KERN_INFO, device,
+			DBF_DEV_EVENT(DBF_INFO, device,
 				     "redriving request immediately, "
 				     "%d retries left",
 				     erp->retries);
@@ -384,6 +384,7 @@ dasd_3990_handle_env_data(struct dasd_cc
 	struct dasd_device *device = erp->startdev;
 	char msg_format = (sense[7] & 0xF0);
 	char msg_no = (sense[7] & 0x0F);
+	char errorstring[ERRORLENGTH];
 
 	switch (msg_format) {
 	case 0x00:		/* Format 0 - Program or System Checks */
@@ -394,95 +395,97 @@ dasd_3990_handle_env_data(struct dasd_cc
 			case 0x00:	/* No Message */
 				break;
 			case 0x01:
-				DEV_MESSAGE(KERN_WARNING, device, "%s",
-					    "FORMAT 0 - Invalid Command");
+				dev_warn(&device->cdev->dev,
+					    "FORMAT 0 - Invalid Command\n");
 				break;
 			case 0x02:
-				DEV_MESSAGE(KERN_WARNING, device, "%s",
+				dev_warn(&device->cdev->dev,
 					    "FORMAT 0 - Invalid Command "
-					    "Sequence");
+					    "Sequence\n");
 				break;
 			case 0x03:
-				DEV_MESSAGE(KERN_WARNING, device, "%s",
+				dev_warn(&device->cdev->dev,
 					    "FORMAT 0 - CCW Count less than "
-					    "required");
+					    "required\n");
 				break;
 			case 0x04:
-				DEV_MESSAGE(KERN_WARNING, device, "%s",
-					    "FORMAT 0 - Invalid Parameter");
+				dev_warn(&device->cdev->dev,
+					    "FORMAT 0 - Invalid Parameter\n");
 				break;
 			case 0x05:
-				DEV_MESSAGE(KERN_WARNING, device, "%s",
-					    "FORMAT 0 - Diagnostic of Sepecial"
-					    " Command Violates File Mask");
+				dev_warn(&device->cdev->dev,
+					    "FORMAT 0 - Diagnostic of Special"
+					    " Command Violates File Mask\n");
 				break;
 			case 0x07:
-				DEV_MESSAGE(KERN_WARNING, device, "%s",
+				dev_warn(&device->cdev->dev,
 					    "FORMAT 0 - Channel Returned with "
-					    "Incorrect retry CCW");
+					    "Incorrect retry CCW\n");
 				break;
 			case 0x08:
-				DEV_MESSAGE(KERN_WARNING, device, "%s",
-					    "FORMAT 0 - Reset Notification");
+				dev_warn(&device->cdev->dev,
+					    "FORMAT 0 - Reset Notification\n");
 				break;
 			case 0x09:
-				DEV_MESSAGE(KERN_WARNING, device, "%s",
-					    "FORMAT 0 - Storage Path Restart");
+				dev_warn(&device->cdev->dev,
+					 "FORMAT 0 - Storage Path Restart\n");
 				break;
 			case 0x0A:
-				DEV_MESSAGE(KERN_WARNING, device,
+				dev_warn(&device->cdev->dev,
 					    "FORMAT 0 - Channel requested "
-					    "... %02x", sense[8]);
+					    "... %02x\n", sense[8]);
 				break;
 			case 0x0B:
-				DEV_MESSAGE(KERN_WARNING, device, "%s",
+				dev_warn(&device->cdev->dev,
 					    "FORMAT 0 - Invalid Defective/"
-					    "Alternate Track Pointer");
+					    "Alternate Track Pointer\n");
 				break;
 			case 0x0C:
-				DEV_MESSAGE(KERN_WARNING, device, "%s",
+				dev_warn(&device->cdev->dev,
 					    "FORMAT 0 - DPS Installation "
-					    "Check");
+					    "Check\n");
 				break;
 			case 0x0E:
-				DEV_MESSAGE(KERN_WARNING, device, "%s",
+				dev_warn(&device->cdev->dev,
 					    "FORMAT 0 - Command Invalid on "
-					    "Secondary Address");
+					    "Secondary Address\n");
 				break;
 			case 0x0F:
-				DEV_MESSAGE(KERN_WARNING, device,
+				dev_warn(&device->cdev->dev,
 					    "FORMAT 0 - Status Not As "
-					    "Required: reason %02x", sense[8]);
+					    "Required: reason %02x\n",
+					 sense[8]);
 				break;
 			default:
-				DEV_MESSAGE(KERN_WARNING, device, "%s",
-					    "FORMAT 0 - Reseved");
+				dev_warn(&device->cdev->dev,
+					    "FORMAT 0 - Reserved\n");
 			}
 		} else {
 			switch (msg_no) {
 			case 0x00:	/* No Message */
 				break;
 			case 0x01:
-				DEV_MESSAGE(KERN_WARNING, device, "%s",
-					    "FORMAT 0 - Device Error Source");
+				dev_warn(&device->cdev->dev,
+					 "FORMAT 0 - Device Error "
+					 "Source\n");
 				break;
 			case 0x02:
-				DEV_MESSAGE(KERN_WARNING, device, "%s",
-					    "FORMAT 0 - Reserved");
+				dev_warn(&device->cdev->dev,
+					    "FORMAT 0 - Reserved\n");
 				break;
 			case 0x03:
-				DEV_MESSAGE(KERN_WARNING, device,
+				dev_warn(&device->cdev->dev,
 					    "FORMAT 0 - Device Fenced - "
-					    "device = %02x", sense[4]);
+					    "device = %02x\n", sense[4]);
 				break;
 			case 0x04:
-				DEV_MESSAGE(KERN_WARNING, device, "%s",
+				dev_warn(&device->cdev->dev,
 					    "FORMAT 0 - Data Pinned for "
-					    "Device");
+					    "Device\n");
 				break;
 			default:
-				DEV_MESSAGE(KERN_WARNING, device, "%s",
-					    "FORMAT 0 - Reserved");
+				dev_warn(&device->cdev->dev,
+					    "FORMAT 0 - Reserved\n");
 			}
 		}
 		break;
@@ -492,348 +495,352 @@ dasd_3990_handle_env_data(struct dasd_cc
 		case 0x00:	/* No Message */
 			break;
 		case 0x01:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 1 - Device Status 1 not as "
-				    "expected");
+				    "expected\n");
 			break;
 		case 0x03:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 1 - Index missing");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT 1 - Index missing\n");
 			break;
 		case 0x04:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 1 - Interruption cannot be reset");
+			dev_warn(&device->cdev->dev,
+				 "FORMAT 1 - Interruption cannot be "
+				 "reset\n");
 			break;
 		case 0x05:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 1 - Device did not respond to "
-				    "selection");
+				    "selection\n");
 			break;
 		case 0x06:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 1 - Device check-2 error or Set "
-				    "Sector is not complete");
+				    "Sector is not complete\n");
 			break;
 		case 0x07:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 1 - Head address does not "
-				    "compare");
+				    "compare\n");
 			break;
 		case 0x08:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 1 - Device status 1 not valid");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT 1 - Device status 1 not valid\n");
 			break;
 		case 0x09:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 1 - Device not ready");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT 1 - Device not ready\n");
 			break;
 		case 0x0A:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 1 - Track physical address did "
-				    "not compare");
+				    "not compare\n");
 			break;
 		case 0x0B:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 1 - Missing device address bit");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT 1 - Missing device address bit\n");
 			break;
 		case 0x0C:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 1 - Drive motor switch is off");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT 1 - Drive motor switch is off\n");
 			break;
 		case 0x0D:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 1 - Seek incomplete");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT 1 - Seek incomplete\n");
 			break;
 		case 0x0E:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 1 - Cylinder address did not "
-				    "compare");
+				    "compare\n");
 			break;
 		case 0x0F:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 1 - Offset active cannot be "
-				    "reset");
+				    "reset\n");
 			break;
 		default:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 1 - Reserved");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT 1 - Reserved\n");
 		}
 		break;
 
 	case 0x20:		/* Format 2 - 3990 Equipment Checks */
 		switch (msg_no) {
 		case 0x08:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 2 - 3990 check-2 error");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT 2 - 3990 check-2 error\n");
 			break;
 		case 0x0E:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 2 - Support facility errors");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT 2 - Support facility errors\n");
 			break;
 		case 0x0F:
-			DEV_MESSAGE(KERN_WARNING, device,
-				    "FORMAT 2 - Microcode detected error %02x",
-				    sense[8]);
+			dev_warn(&device->cdev->dev,
+				 "FORMAT 2 - Microcode detected error "
+				 "%02x\n",
+				 sense[8]);
 			break;
 		default:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 2 - Reserved");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT 2 - Reserved\n");
 		}
 		break;
 
 	case 0x30:		/* Format 3 - 3990 Control Checks */
 		switch (msg_no) {
 		case 0x0F:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 3 - Allegiance terminated");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT 3 - Allegiance terminated\n");
 			break;
 		default:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 3 - Reserved");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT 3 - Reserved\n");
 		}
 		break;
 
 	case 0x40:		/* Format 4 - Data Checks */
 		switch (msg_no) {
 		case 0x00:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 4 - Home address area error");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT 4 - Home address area error\n");
 			break;
 		case 0x01:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 4 - Count area error");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT 4 - Count area error\n");
 			break;
 		case 0x02:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 4 - Key area error");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT 4 - Key area error\n");
 			break;
 		case 0x03:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 4 - Data area error");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT 4 - Data area error\n");
 			break;
 		case 0x04:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 4 - No sync byte in home address "
-				    "area");
+				    "area\n");
 			break;
 		case 0x05:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 4 - No sync byte in count address "
-				    "area");
+				    "area\n");
 			break;
 		case 0x06:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 4 - No sync byte in key area");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT 4 - No sync byte in key area\n");
 			break;
 		case 0x07:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 4 - No sync byte in data area");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT 4 - No sync byte in data area\n");
 			break;
 		case 0x08:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 4 - Home address area error; "
-				    "offset active");
+				    "offset active\n");
 			break;
 		case 0x09:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 4 - Count area error; offset "
-				    "active");
+				    "active\n");
 			break;
 		case 0x0A:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 4 - Key area error; offset "
-				    "active");
+				    "active\n");
 			break;
 		case 0x0B:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 4 - Data area error; "
-				    "offset active");
+				    "offset active\n");
 			break;
 		case 0x0C:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 4 - No sync byte in home "
-				    "address area; offset active");
+				    "address area; offset active\n");
 			break;
 		case 0x0D:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 4 - No syn byte in count "
-				    "address area; offset active");
+				    "address area; offset active\n");
 			break;
 		case 0x0E:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 4 - No sync byte in key area; "
-				    "offset active");
+				    "offset active\n");
 			break;
 		case 0x0F:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 4 - No syn byte in data area; "
-				    "offset active");
+				    "offset active\n");
 			break;
 		default:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 4 - Reserved");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT 4 - Reserved\n");
 		}
 		break;
 
 	case 0x50:  /* Format 5 - Data Check with displacement information */
 		switch (msg_no) {
 		case 0x00:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 5 - Data Check in the "
-				    "home address area");
+				    "home address area\n");
 			break;
 		case 0x01:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 5 - Data Check in the count area");
+			dev_warn(&device->cdev->dev,
+				 "FORMAT 5 - Data Check in the count "
+				 "area\n");
 			break;
 		case 0x02:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 5 - Data Check in the key area");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT 5 - Data Check in the key area\n");
 			break;
 		case 0x03:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 5 - Data Check in the data area");
+			dev_warn(&device->cdev->dev,
+				 "FORMAT 5 - Data Check in the data "
+				 "area\n");
 			break;
 		case 0x08:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 5 - Data Check in the "
-				    "home address area; offset active");
+				    "home address area; offset active\n");
 			break;
 		case 0x09:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 5 - Data Check in the count area; "
-				    "offset active");
+				    "offset active\n");
 			break;
 		case 0x0A:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 5 - Data Check in the key area; "
-				    "offset active");
+				    "offset active\n");
 			break;
 		case 0x0B:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 5 - Data Check in the data area; "
-				    "offset active");
+				    "offset active\n");
 			break;
 		default:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 5 - Reserved");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT 5 - Reserved\n");
 		}
 		break;
 
 	case 0x60:  /* Format 6 - Usage Statistics/Overrun Errors */
 		switch (msg_no) {
 		case 0x00:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 6 - Overrun on channel A");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT 6 - Overrun on channel A\n");
 			break;
 		case 0x01:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 6 - Overrun on channel B");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT 6 - Overrun on channel B\n");
 			break;
 		case 0x02:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 6 - Overrun on channel C");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT 6 - Overrun on channel C\n");
 			break;
 		case 0x03:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 6 - Overrun on channel D");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT 6 - Overrun on channel D\n");
 			break;
 		case 0x04:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 6 - Overrun on channel E");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT 6 - Overrun on channel E\n");
 			break;
 		case 0x05:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 6 - Overrun on channel F");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT 6 - Overrun on channel F\n");
 			break;
 		case 0x06:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 6 - Overrun on channel G");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT 6 - Overrun on channel G\n");
 			break;
 		case 0x07:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 6 - Overrun on channel H");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT 6 - Overrun on channel H\n");
 			break;
 		default:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 6 - Reserved");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT 6 - Reserved\n");
 		}
 		break;
 
 	case 0x70:  /* Format 7 - Device Connection Control Checks */
 		switch (msg_no) {
 		case 0x00:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 7 - RCC initiated by a connection "
-				    "check alert");
+				    "check alert\n");
 			break;
 		case 0x01:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 7 - RCC 1 sequence not "
-				    "successful");
+				    "successful\n");
 			break;
 		case 0x02:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 7 - RCC 1 and RCC 2 sequences not "
-				    "successful");
+				    "successful\n");
 			break;
 		case 0x03:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 7 - Invalid tag-in during "
-				    "selection sequence");
+				    "selection sequence\n");
 			break;
 		case 0x04:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 7 - extra RCC required");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT 7 - extra RCC required\n");
 			break;
 		case 0x05:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 7 - Invalid DCC selection "
-				    "response or timeout");
+				    "response or timeout\n");
 			break;
 		case 0x06:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 7 - Missing end operation; device "
-				    "transfer complete");
+				    "transfer complete\n");
 			break;
 		case 0x07:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 7 - Missing end operation; device "
-				    "transfer incomplete");
+				    "transfer incomplete\n");
 			break;
 		case 0x08:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 7 - Invalid tag-in for an "
-				    "immediate command sequence");
+				    "immediate command sequence\n");
 			break;
 		case 0x09:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 7 - Invalid tag-in for an "
-				    "extended command sequence");
+				    "extended command sequence\n");
 			break;
 		case 0x0A:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 7 - 3990 microcode time out when "
-				    "stopping selection");
+				    "stopping selection\n");
 			break;
 		case 0x0B:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 7 - No response to selection "
-				    "after a poll interruption");
+				    "after a poll interruption\n");
 			break;
 		case 0x0C:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 7 - Permanent path error (DASD "
-				    "controller not available)");
+				    "controller not available)\n");
 			break;
 		case 0x0D:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 7 - DASD controller not available"
-				    " on disconnected command chain");
+				    " on disconnected command chain\n");
 			break;
 		default:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 7 - Reserved");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT 7 - Reserved\n");
 		}
 		break;
 
@@ -841,52 +848,52 @@ dasd_3990_handle_env_data(struct dasd_cc
 		switch (msg_no) {
 		case 0x00:	/* No Message */
 		case 0x01:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 8 - Error correction code "
-				    "hardware fault");
+				    "hardware fault\n");
 			break;
 		case 0x03:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 8 - Unexpected end operation "
-				    "response code");
+				    "response code\n");
 			break;
 		case 0x04:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 8 - End operation with transfer "
-				    "count not zero");
+				    "count not zero\n");
 			break;
 		case 0x05:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 8 - End operation with transfer "
-				    "count zero");
+				    "count zero\n");
 			break;
 		case 0x06:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 8 - DPS checks after a system "
-				    "reset or selective reset");
+				    "reset or selective reset\n");
 			break;
 		case 0x07:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 8 - DPS cannot be filled");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT 8 - DPS cannot be filled\n");
 			break;
 		case 0x08:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 8 - Short busy time-out during "
-				    "device selection");
+				    "device selection\n");
 			break;
 		case 0x09:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 8 - DASD controller failed to "
-				    "set or reset the long busy latch");
+				    "set or reset the long busy latch\n");
 			break;
 		case 0x0A:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 8 - No interruption from device "
-				    "during a command chain");
+				    "during a command chain\n");
 			break;
 		default:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 8 - Reserved");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT 8 - Reserved\n");
 		}
 		break;
 
@@ -895,97 +902,100 @@ dasd_3990_handle_env_data(struct dasd_cc
 		case 0x00:
 			break;	/* No Message */
 		case 0x06:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 9 - Device check-2 error");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT 9 - Device check-2 error\n");
 			break;
 		case 0x07:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 9 - Head address did not compare");
+			dev_warn(&device->cdev->dev,
+				 "FORMAT 9 - Head address did not "
+				 "compare\n");
 			break;
 		case 0x0A:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 9 - Track physical address did "
-				    "not compare while oriented");
+				    "not compare while oriented\n");
 			break;
 		case 0x0E:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT 9 - Cylinder address did not "
-				    "compare");
+				    "compare\n");
 			break;
 		default:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT 9 - Reserved");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT 9 - Reserved\n");
 		}
 		break;
 
 	case 0xF0:		/* Format F - Cache Storage Checks */
 		switch (msg_no) {
 		case 0x00:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT F - Operation Terminated");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT F - Operation Terminated\n");
 			break;
 		case 0x01:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT F - Subsystem Processing Error");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT F - Subsystem Processing Error\n");
 			break;
 		case 0x02:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT F - Cache or nonvolatile storage "
-				    "equipment failure");
+				    "equipment failure\n");
 			break;
 		case 0x04:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT F - Caching terminated");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT F - Caching terminated\n");
 			break;
 		case 0x06:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT F - Cache fast write access not "
-				    "authorized");
+				    "authorized\n");
 			break;
 		case 0x07:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT F - Track format incorrect");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT F - Track format incorrect\n");
 			break;
 		case 0x09:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT F - Caching reinitiated");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT F - Caching reinitiated\n");
 			break;
 		case 0x0A:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT F - Nonvolatile storage "
-				    "terminated");
+				    "terminated\n");
 			break;
 		case 0x0B:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT F - Volume is suspended duplex");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT F - Volume is suspended duplex\n");
 			/* call extended error reporting (EER) */
 			dasd_eer_write(device, erp->refers,
 				       DASD_EER_PPRCSUSPEND);
 			break;
 		case 0x0C:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT F - Subsystem status connot be "
-				    "determined");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT F - Subsystem status cannot be "
+				    "determined\n");
 			break;
 		case 0x0D:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
+			dev_warn(&device->cdev->dev,
 				    "FORMAT F - Caching status reset to "
-				    "default");
+				    "default\n");
 			break;
 		case 0x0E:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT F - DASD Fast Write inhibited");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT F - DASD Fast Write inhibited\n");
 			break;
 		default:
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "FORMAT D - Reserved");
+			dev_warn(&device->cdev->dev,
+				    "FORMAT D - Reserved\n");
 		}
 		break;
 
-	default:	/* unknown message format - should not happen */
-	        DEV_MESSAGE (KERN_WARNING, device,
-                             "unknown message format %02x",
-                             msg_format);
+	default:	/* unknown message format - should not happen
+			   internal error 03 - unknown message format */
+		snprintf(errorstring, ERRORLENGTH, "03 %x02", msg_format);
+		dev_err(&device->cdev->dev,
+			 "An error occurred in the DASD device driver, "
+			 "reason=%s\n", errorstring);
 		break;
 	}			/* end switch message format */
 
@@ -1015,7 +1025,7 @@ dasd_3990_erp_com_rej(struct dasd_ccw_re
 	/* env data present (ACTION 10 - retry should work) */
 	if (sense[2] & SNS2_ENV_DATA_PRESENT) {
 
-		DEV_MESSAGE(KERN_DEBUG, device, "%s",
+		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			    "Command Reject - environmental data present");
 
 		dasd_3990_handle_env_data(erp, sense);
@@ -1023,9 +1033,10 @@ dasd_3990_erp_com_rej(struct dasd_ccw_re
 		erp->retries = 5;
 
 	} else {
-		/* fatal error -  set status to FAILED */
-		DEV_MESSAGE(KERN_ERR, device, "%s",
-			    "Command Reject - Fatal error");
+		/* fatal error -  set status to FAILED
+		   internal error 09 - Command Reject */
+		dev_err(&device->cdev->dev, "An error occurred in the DASD "
+			"device driver, reason=%s\n", "09");
 
 		erp = dasd_3990_erp_cleanup(erp, DASD_CQR_FAILED);
 	}
@@ -1061,7 +1072,7 @@ dasd_3990_erp_bus_out(struct dasd_ccw_re
 	} else {
 
 		/* issue a message and wait for 'device ready' interrupt */
-		DEV_MESSAGE(KERN_DEBUG, device, "%s",
+		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			    "bus out parity error or BOPC requested by "
 			    "channel");
 
@@ -1093,21 +1104,19 @@ dasd_3990_erp_equip_check(struct dasd_cc
 	erp->function = dasd_3990_erp_equip_check;
 
 	if (sense[1] & SNS1_WRITE_INHIBITED) {
+		dev_info(&device->cdev->dev,
+			    "Write inhibited path encountered\n");
 
-		DEV_MESSAGE(KERN_DEBUG, device, "%s",
-			    "Write inhibited path encountered");
-
-		/* vary path offline */
-		DEV_MESSAGE(KERN_ERR, device, "%s",
-			    "Path should be varied off-line. "
-			    "This is not implemented yet \n - please report "
-			    "to linux390@de.ibm.com");
+		/* vary path offline
+		   internal error 04 - Path should be varied off-line.*/
+		dev_err(&device->cdev->dev, "An error occurred in the DASD "
+			"device driver, reason=%s\n", "04");
 
 		erp = dasd_3990_erp_action_1(erp);
 
 	} else if (sense[2] & SNS2_ENV_DATA_PRESENT) {
 
-		DEV_MESSAGE(KERN_DEBUG, device, "%s",
+		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			    "Equipment Check - " "environmental data present");
 
 		dasd_3990_handle_env_data(erp, sense);
@@ -1116,7 +1125,7 @@ dasd_3990_erp_equip_check(struct dasd_cc
 
 	} else if (sense[1] & SNS1_PERM_ERR) {
 
-		DEV_MESSAGE(KERN_DEBUG, device, "%s",
+		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			    "Equipment Check - retry exhausted or "
 			    "undesirable");
 
@@ -1125,7 +1134,7 @@ dasd_3990_erp_equip_check(struct dasd_cc
 	} else {
 		/* all other equipment checks - Action 5 */
 		/* rest is done when retries == 0 */
-		DEV_MESSAGE(KERN_DEBUG, device, "%s",
+		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			    "Equipment check or processing error");
 
 		erp = dasd_3990_erp_action_5(erp);
@@ -1156,9 +1165,9 @@ dasd_3990_erp_data_check(struct dasd_ccw
 	if (sense[2] & SNS2_CORRECTABLE) {	/* correctable data check */
 
 		/* issue message that the data has been corrected */
-		DEV_MESSAGE(KERN_EMERG, device, "%s",
+		dev_emerg(&device->cdev->dev,
 			    "Data recovered during retry with PCI "
-			    "fetch mode active");
+			    "fetch mode active\n");
 
 		/* not possible to handle this situation in Linux */
 		panic("No way to inform application about the possibly "
@@ -1166,7 +1175,7 @@ dasd_3990_erp_data_check(struct dasd_ccw
 
 	} else if (sense[2] & SNS2_ENV_DATA_PRESENT) {
 
-		DEV_MESSAGE(KERN_DEBUG, device, "%s",
+		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			    "Uncorrectable data check recovered secondary "
 			    "addr of duplex pair");
 
@@ -1174,7 +1183,7 @@ dasd_3990_erp_data_check(struct dasd_ccw
 
 	} else if (sense[1] & SNS1_PERM_ERR) {
 
-		DEV_MESSAGE(KERN_DEBUG, device, "%s",
+		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			    "Uncorrectable data check with internal "
 			    "retry exhausted");
 
@@ -1182,7 +1191,7 @@ dasd_3990_erp_data_check(struct dasd_ccw
 
 	} else {
 		/* all other data checks */
-		DEV_MESSAGE(KERN_DEBUG, device, "%s",
+		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			    "Uncorrectable data check with retry count "
 			    "exhausted...");
 
@@ -1212,7 +1221,7 @@ dasd_3990_erp_overrun(struct dasd_ccw_re
 
 	erp->function = dasd_3990_erp_overrun;
 
-	DEV_MESSAGE(KERN_DEBUG, device, "%s",
+	DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 		    "Overrun - service overrun or overrun"
 		    " error requested by channel");
 
@@ -1243,7 +1252,7 @@ dasd_3990_erp_inv_format(struct dasd_ccw
 
 	if (sense[2] & SNS2_ENV_DATA_PRESENT) {
 
-		DEV_MESSAGE(KERN_DEBUG, device, "%s",
+		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			    "Track format error when destaging or "
 			    "staging data");
 
@@ -1252,8 +1261,10 @@ dasd_3990_erp_inv_format(struct dasd_ccw
 		erp = dasd_3990_erp_action_4(erp, sense);
 
 	} else {
-		DEV_MESSAGE(KERN_ERR, device, "%s",
-			    "Invalid Track Format - Fatal error");
+		/* internal error 06 - The track format is not valid*/
+		dev_err(&device->cdev->dev,
+			"An error occurred in the DASD device driver, "
+			"reason=%s\n", "06");
 
 		erp = dasd_3990_erp_cleanup(erp, DASD_CQR_FAILED);
 	}
@@ -1279,8 +1290,8 @@ dasd_3990_erp_EOC(struct dasd_ccw_req * 
 
 	struct dasd_device *device = default_erp->startdev;
 
-	DEV_MESSAGE(KERN_ERR, device, "%s",
-		    "End-of-Cylinder - must never happen");
+	dev_err(&device->cdev->dev,
+		"The cylinder data for accessing the DASD is inconsistent\n");
 
 	/* implement action 7 - BUG */
 	return dasd_3990_erp_cleanup(default_erp, DASD_CQR_FAILED);
@@ -1306,7 +1317,7 @@ dasd_3990_erp_env_data(struct dasd_ccw_r
 
 	erp->function = dasd_3990_erp_env_data;
 
-	DEV_MESSAGE(KERN_DEBUG, device, "%s", "Environmental data present");
+	DBF_DEV_EVENT(DBF_WARNING, device, "%s", "Environmental data present");
 
 	dasd_3990_handle_env_data(erp, sense);
 
@@ -1339,8 +1350,8 @@ dasd_3990_erp_no_rec(struct dasd_ccw_req
 
 	struct dasd_device *device = default_erp->startdev;
 
-	DEV_MESSAGE(KERN_ERR, device, "%s",
-		    "No Record Found - Fatal error ");
+	dev_err(&device->cdev->dev,
+		    "The specified record was not found\n");
 
 	return dasd_3990_erp_cleanup(default_erp, DASD_CQR_FAILED);
 
@@ -1365,7 +1376,8 @@ dasd_3990_erp_file_prot(struct dasd_ccw_
 
 	struct dasd_device *device = erp->startdev;
 
-	DEV_MESSAGE(KERN_ERR, device, "%s", "File Protected");
+	dev_err(&device->cdev->dev, "Accessing the DASD failed because of "
+		"a hardware error\n");
 
 	return dasd_3990_erp_cleanup(erp, DASD_CQR_FAILED);
 
@@ -1394,7 +1406,7 @@ static struct dasd_ccw_req *dasd_3990_er
 	if (cqr->block &&
 	    (cqr->block->base != cqr->startdev)) {
 		if (cqr->startdev->features & DASD_FEATURE_ERPLOG) {
-			DEV_MESSAGE(KERN_ERR, cqr->startdev,
+			DBF_DEV_EVENT(DBF_ERR, cqr->startdev,
 				    "ERP on alias device for request %p,"
 				    " recover on base device %s", cqr,
 				    dev_name(&cqr->block->base->cdev->dev));
@@ -1511,7 +1523,7 @@ dasd_3990_erp_action_10_32(struct dasd_c
 	erp->retries = 256;
 	erp->function = dasd_3990_erp_action_10_32;
 
-	DEV_MESSAGE(KERN_DEBUG, device, "%s", "Perform logging requested");
+	DBF_DEV_EVENT(DBF_WARNING, device, "%s", "Perform logging requested");
 
 	return erp;
 
@@ -1549,7 +1561,7 @@ dasd_3990_erp_action_1B_32(struct dasd_c
 	char *LO_data;		/* LO_eckd_data_t */
 	struct ccw1 *ccw, *oldccw;
 
-	DEV_MESSAGE(KERN_DEBUG, device, "%s",
+	DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 		    "Write not finished because of unexpected condition");
 
 	default_erp->function = dasd_3990_erp_action_1B_32;
@@ -1563,8 +1575,7 @@ dasd_3990_erp_action_1B_32(struct dasd_c
 
 	/* for imprecise ending just do default erp */
 	if (sense[1] & 0x01) {
-
-		DEV_MESSAGE(KERN_DEBUG, device, "%s",
+		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			    "Imprecise ending is set - just retry");
 
 		return default_erp;
@@ -1575,8 +1586,7 @@ dasd_3990_erp_action_1B_32(struct dasd_c
 	cpa = default_erp->refers->irb.scsw.cmd.cpa;
 
 	if (cpa == 0) {
-
-		DEV_MESSAGE(KERN_DEBUG, device, "%s",
+		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			    "Unable to determine address of the CCW "
 			    "to be restarted");
 
@@ -1590,7 +1600,9 @@ dasd_3990_erp_action_1B_32(struct dasd_c
 				     sizeof(struct LO_eckd_data), device);
 
 	if (IS_ERR(erp)) {
-		DEV_MESSAGE(KERN_ERR, device, "%s", "Unable to allocate ERP");
+		/* internal error 01 - Unable to allocate ERP */
+		dev_err(&device->cdev->dev, "An error occurred in the DASD "
+			"device driver, reason=%s\n", "01");
 		return dasd_3990_erp_cleanup(default_erp, DASD_CQR_FAILED);
 	}
 
@@ -1608,10 +1620,7 @@ dasd_3990_erp_action_1B_32(struct dasd_c
 	LO_data = erp->data + sizeof(struct DE_eckd_data);
 
 	if ((sense[3] == 0x01) && (LO_data[1] & 0x01)) {
-
-		DEV_MESSAGE(KERN_ERR, device, "%s",
-			    "BUG - this should not happen");
-
+		/* should not */
 		return dasd_3990_erp_cleanup(default_erp, DASD_CQR_FAILED);
 	}
 
@@ -1701,7 +1710,7 @@ dasd_3990_update_1B(struct dasd_ccw_req 
 	char *LO_data;		/* struct LO_eckd_data */
 	struct ccw1 *ccw;
 
-	DEV_MESSAGE(KERN_DEBUG, device, "%s",
+	DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 		    "Write not finished because of unexpected condition"
 		    " - follow on");
 
@@ -1714,8 +1723,7 @@ dasd_3990_update_1B(struct dasd_ccw_req 
 
 	/* for imprecise ending just do default erp */
 	if (sense[1] & 0x01) {
-
-		DEV_MESSAGE(KERN_DEBUG, device, "%s",
+		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			    "Imprecise ending is set - just retry");
 
 		previous_erp->status = DASD_CQR_FILLED;
@@ -1728,10 +1736,10 @@ dasd_3990_update_1B(struct dasd_ccw_req 
 	cpa = previous_erp->irb.scsw.cmd.cpa;
 
 	if (cpa == 0) {
-
-		DEV_MESSAGE(KERN_DEBUG, device, "%s",
-			    "Unable to determine address of the CCW "
-			    "to be restarted");
+		/* internal error 02 -
+		   Unable to determine address of the CCW to be restarted */
+		dev_err(&device->cdev->dev, "An error occurred in the DASD "
+			"device driver, reason=%s\n", "02");
 
 		previous_erp->status = DASD_CQR_FAILED;
 
@@ -1744,10 +1752,7 @@ dasd_3990_update_1B(struct dasd_ccw_req 
 	LO_data = erp->data + sizeof(struct DE_eckd_data);
 
 	if ((sense[3] == 0x01) && (LO_data[1] & 0x01)) {
-
-		DEV_MESSAGE(KERN_ERR, device, "%s",
-			    "BUG - this should not happen");
-
+		/* should not happen */
 		previous_erp->status = DASD_CQR_FAILED;
 
 		return previous_erp;
@@ -1935,14 +1940,13 @@ dasd_3990_erp_compound_config(struct das
 
 	if ((sense[25] & DASD_SENSE_BIT_1) && (sense[26] & DASD_SENSE_BIT_2)) {
 
-		/* set to suspended duplex state then restart */
+		/* set to suspended duplex state then restart
+		   internal error 05 - Set device to suspended duplex state
+		   should be done */
 		struct dasd_device *device = erp->startdev;
-
-		DEV_MESSAGE(KERN_ERR, device, "%s",
-			    "Set device to suspended duplex state should be "
-			    "done!\n"
-			    "This is not implemented yet (for compound ERP)"
-			    " - please report to linux390@de.ibm.com");
+		dev_err(&device->cdev->dev,
+			"An error occurred in the DASD device driver, "
+			"reason=%s\n", "05");
 
 	}
 
@@ -2012,15 +2016,14 @@ dasd_3990_erp_handle_sim(struct dasd_dev
 {
 	/* print message according to log or message to operator mode */
 	if ((sense[24] & DASD_SIM_MSG_TO_OP) || (sense[1] & 0x10)) {
-
 		/* print SIM SRC from RefCode */
-		DEV_MESSAGE(KERN_ERR, device, "SIM - SRC: "
-			    "%02x%02x%02x%02x", sense[22],
+		dev_err(&device->cdev->dev, "SIM - SRC: "
+			    "%02x%02x%02x%02x\n", sense[22],
 			    sense[23], sense[11], sense[12]);
 	} else if (sense[24] & DASD_SIM_LOG) {
 		/* print SIM SRC Refcode */
-		DEV_MESSAGE(KERN_WARNING, device, "SIM - SRC: "
-			    "%02x%02x%02x%02x", sense[22],
+		dev_warn(&device->cdev->dev, "log SIM - SRC: "
+			    "%02x%02x%02x%02x\n", sense[22],
 			    sense[23], sense[11], sense[12]);
 	}
 }
@@ -2063,14 +2066,14 @@ dasd_3990_erp_inspect_32(struct dasd_ccw
 		switch (sense[25]) {
 
 		case 0x00:	/* success - use default ERP for retries */
-		        DEV_MESSAGE(KERN_DEBUG, device, "%s",
+			DBF_DEV_EVENT(DBF_DEBUG, device, "%s",
 				    "ERP called for successful request"
 				    " - just retry");
 			break;
 
 		case 0x01:	/* fatal error */
-			DEV_MESSAGE(KERN_ERR, device, "%s",
-				    "Retry not recommended - Fatal error");
+			dev_err(&device->cdev->dev,
+				    "ERP failed for the DASD\n");
 
 			erp = dasd_3990_erp_cleanup(erp, DASD_CQR_FAILED);
 			break;
@@ -2080,13 +2083,10 @@ dasd_3990_erp_inspect_32(struct dasd_ccw
 			erp = dasd_3990_erp_int_req(erp);
 			break;
 
-		case 0x0F:  /* length mismatch during update write command */
-			DEV_MESSAGE(KERN_ERR, device, "%s",
-				    "update write command error - should not "
-				    "happen;\n"
-				    "Please send this message together with "
-				    "the above sense data to linux390@de."
-				    "ibm.com");
+		case 0x0F:  /* length mismatch during update write command
+			       internal error 08 - update write command error*/
+			dev_err(&device->cdev->dev, "An error occurred in the "
+				"DASD device driver, reason=%s\n", "08");
 
 			erp = dasd_3990_erp_cleanup(erp, DASD_CQR_FAILED);
 			break;
@@ -2095,13 +2095,12 @@ dasd_3990_erp_inspect_32(struct dasd_ccw
 			erp = dasd_3990_erp_action_10_32(erp, sense);
 			break;
 
-		case 0x15:	/* next track outside defined extend */
-			DEV_MESSAGE(KERN_ERR, device, "%s",
-				    "next track outside defined extend - "
-				    "should not happen;\n"
-				    "Please send this message together with "
-				    "the above sense data to linux390@de."
-				    "ibm.com");
+		case 0x15:	/* next track outside defined extend
+				   internal error 07 - The next track is not
+				   within the defined storage extent */
+			dev_err(&device->cdev->dev,
+				"An error occurred in the DASD device driver, "
+				"reason=%s\n", "07");
 
 			erp = dasd_3990_erp_cleanup(erp, DASD_CQR_FAILED);
 			break;
@@ -2112,9 +2111,9 @@ dasd_3990_erp_inspect_32(struct dasd_ccw
 			break;
 
 		case 0x1C:	/* invalid data */
-			DEV_MESSAGE(KERN_EMERG, device, "%s",
+			dev_emerg(&device->cdev->dev,
 				    "Data recovered during retry with PCI "
-				    "fetch mode active");
+				    "fetch mode active\n");
 
 			/* not possible to handle this situation in Linux */
 			panic
@@ -2123,7 +2122,7 @@ dasd_3990_erp_inspect_32(struct dasd_ccw
 			break;
 
 		case 0x1D:	/* state-change pending */
-			DEV_MESSAGE(KERN_DEBUG, device, "%s",
+			DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 				    "A State change pending condition exists "
 				    "for the subsystem or device");
 
@@ -2131,7 +2130,7 @@ dasd_3990_erp_inspect_32(struct dasd_ccw
 			break;
 
 		case 0x1E:	/* busy */
-                        DEV_MESSAGE(KERN_DEBUG, device, "%s",
+			DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 				    "Busy condition exists "
 				    "for the subsystem or device");
                         erp = dasd_3990_erp_action_4(erp, sense);
@@ -2173,7 +2172,7 @@ dasd_3990_erp_control_check(struct dasd_
 
 	if (erp->refers->irb.scsw.cmd.cstat & (SCHN_STAT_INTF_CTRL_CHK
 					   | SCHN_STAT_CHN_CTRL_CHK)) {
-		DEV_MESSAGE(KERN_DEBUG, device, "%s",
+		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			    "channel or interface control check");
 		erp = dasd_3990_erp_action_4(erp, NULL);
 	}
@@ -2252,12 +2251,12 @@ dasd_3990_erp_add_erp(struct dasd_ccw_re
 	erp = dasd_alloc_erp_request((char *) &cqr->magic, 2, 0, device);
 	if (IS_ERR(erp)) {
                 if (cqr->retries <= 0) {
-		        DEV_MESSAGE(KERN_ERR, device, "%s",
+			DBF_DEV_EVENT(DBF_ERR, device, "%s",
 				    "Unable to allocate ERP request");
 			cqr->status = DASD_CQR_FAILED;
                         cqr->stopclk = get_clock ();
 		} else {
-                        DEV_MESSAGE (KERN_ERR, device,
+			DBF_DEV_EVENT(DBF_ERR, device,
                                      "Unable to allocate ERP request "
 				     "(%i retries left)",
                                      cqr->retries);
@@ -2471,7 +2470,7 @@ dasd_3990_erp_further_erp(struct dasd_cc
 					break;
 				}
 			default:
-				DEV_MESSAGE(KERN_DEBUG, device,
+				DBF_DEV_EVENT(DBF_WARNING, device,
 					    "invalid subcommand modifier 0x%x "
 					    "for Diagnostic Control Command",
 					    sense[25]);
@@ -2487,11 +2486,12 @@ dasd_3990_erp_further_erp(struct dasd_cc
 		erp = dasd_3990_erp_compound(erp, sense);
 
 	} else {
-		/* No retry left and no additional special handling */
-		/*necessary */
-		DEV_MESSAGE(KERN_ERR, device,
-			    "no retries left for erp %p - "
-			    "set status to FAILED", erp);
+		/*
+		 * No retry left and no additional special handling
+		 * necessary
+		 */
+		dev_err(&device->cdev->dev,
+			"ERP %p has run out of retries and failed\n", erp);
 
 		erp->status = DASD_CQR_FAILED;
 	}
@@ -2565,7 +2565,7 @@ dasd_3990_erp_handle_match_erp(struct da
 
 		} else {
 			/* simple retry	  */
-			DEV_MESSAGE(KERN_DEBUG, device,
+			DBF_DEV_EVENT(DBF_DEBUG, device,
 				    "%i retries left for erp %p",
 				    erp->retries, erp);
 
@@ -2609,13 +2609,13 @@ dasd_3990_erp_action(struct dasd_ccw_req
 
 	if (device->features & DASD_FEATURE_ERPLOG) {
 		/* print current erp_chain */
-		DEV_MESSAGE(KERN_ERR, device, "%s",
-			    "ERP chain at BEGINNING of ERP-ACTION");
+		dev_err(&device->cdev->dev,
+			    "ERP chain at BEGINNING of ERP-ACTION\n");
 		for (temp_erp = cqr;
 		     temp_erp != NULL; temp_erp = temp_erp->refers) {
 
-			DEV_MESSAGE(KERN_ERR, device,
-				    "   erp %p (%02x) refers to %p",
+			dev_err(&device->cdev->dev,
+				    "ERP %p (%02x) refers to %p\n",
 				    temp_erp, temp_erp->status,
 				    temp_erp->refers);
 		}
@@ -2626,7 +2626,7 @@ dasd_3990_erp_action(struct dasd_ccw_req
 	    (cqr->irb.scsw.cmd.dstat ==
 	     (DEV_STAT_CHN_END | DEV_STAT_DEV_END))) {
 
-		DEV_MESSAGE(KERN_DEBUG, device,
+		DBF_DEV_EVENT(DBF_DEBUG, device,
 			    "ERP called for successful request %p"
 			    " - NO ERP necessary", cqr);
 
@@ -2648,13 +2648,13 @@ dasd_3990_erp_action(struct dasd_ccw_req
 
 	if (device->features & DASD_FEATURE_ERPLOG) {
 		/* print current erp_chain */
-		DEV_MESSAGE(KERN_ERR, device, "%s",
-			    "ERP chain at END of ERP-ACTION");
+		dev_err(&device->cdev->dev,
+			    "ERP chain at END of ERP-ACTION\n");
 		for (temp_erp = erp;
 		     temp_erp != NULL; temp_erp = temp_erp->refers) {
 
-			DEV_MESSAGE(KERN_ERR, device,
-				    "   erp %p (%02x) refers to %p",
+			dev_err(&device->cdev->dev,
+				    "ERP %p (%02x) refers to %p\n",
 				    temp_erp, temp_erp->status,
 				    temp_erp->refers);
 		}
@@ -2667,6 +2667,8 @@ dasd_3990_erp_action(struct dasd_ccw_req
 		list_add_tail(&erp->blocklist, &cqr->blocklist);
 	}
 
+
+
 	return erp;
 
 }				/* end dasd_3990_erp_action */
Index: quilt-2.6/drivers/s390/block/dasd_alias.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_alias.c
+++ quilt-2.6/drivers/s390/block/dasd_alias.c
@@ -503,7 +503,7 @@ static void lcu_update_work(struct work_
 	 */
 	spin_lock_irqsave(&lcu->lock, flags);
 	if (rc || (lcu->flags & NEED_UAC_UPDATE)) {
-		DEV_MESSAGE(KERN_WARNING, device, "could not update"
+		DBF_DEV_EVENT(DBF_WARNING, device, "could not update"
 			    " alias data in lcu (rc = %d), retry later", rc);
 		schedule_delayed_work(&lcu->ruac_data.dwork, 30*HZ);
 	} else {
@@ -859,12 +859,12 @@ void dasd_alias_handle_summary_unit_chec
 	private = (struct dasd_eckd_private *) device->private;
 
 	reason = irb->ecw[8];
-	DEV_MESSAGE(KERN_WARNING, device, "%s %x",
+	DBF_DEV_EVENT(DBF_WARNING, device, "%s %x",
 		    "eckd handle summary unit check: reason", reason);
 
 	lcu = private->lcu;
 	if (!lcu) {
-		DEV_MESSAGE(KERN_WARNING, device, "%s",
+		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			    "device not ready to handle summary"
 			    " unit check (no lcu structure)");
 		return;
@@ -877,7 +877,7 @@ void dasd_alias_handle_summary_unit_chec
 	 * the next interrupt on a different device
 	 */
 	if (list_empty(&device->alias_list)) {
-		DEV_MESSAGE(KERN_WARNING, device, "%s",
+		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			    "device is in offline processing,"
 			    " don't do summary unit check handling");
 		spin_unlock(&lcu->lock);
@@ -885,7 +885,7 @@ void dasd_alias_handle_summary_unit_chec
 	}
 	if (lcu->suc_data.device) {
 		/* already scheduled or running */
-		DEV_MESSAGE(KERN_WARNING, device, "%s",
+		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			    "previous instance of summary unit check worker"
 			    " still pending");
 		spin_unlock(&lcu->lock);
Index: quilt-2.6/drivers/s390/block/dasd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd.c
+++ quilt-2.6/drivers/s390/block/dasd.c
@@ -9,6 +9,9 @@
  *
  */
 
+#define KMSG_COMPONENT "dasd"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/kmod.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -221,7 +224,7 @@ static int dasd_state_known_to_basic(str
 			return rc;
 	}
 	/* register 'device' debug area, used for all DBF_DEV_XXX calls */
-	device->debug_area = debug_register(dev_name(&device->cdev->dev), 1, 1,
+	device->debug_area = debug_register(dev_name(&device->cdev->dev), 4, 1,
 					    8 * sizeof(long));
 	debug_register_view(device->debug_area, &debug_sprintf_view);
 	debug_set_level(device->debug_area, DBF_WARNING);
@@ -762,7 +765,7 @@ static inline int dasd_check_cqr(struct 
 		return -EINVAL;
 	device = cqr->startdev;
 	if (strncmp((char *) &cqr->magic, device->discipline->ebcname, 4)) {
-		DEV_MESSAGE(KERN_WARNING, device,
+		DBF_DEV_EVENT(DBF_WARNING, device,
 			    " dasd_ccw_req 0x%08x magic doesn't match"
 			    " discipline 0x%08x",
 			    cqr->magic,
@@ -782,6 +785,7 @@ int dasd_term_IO(struct dasd_ccw_req *cq
 {
 	struct dasd_device *device;
 	int retries, rc;
+	char errorstring[ERRORLENGTH];
 
 	/* Check the cqr */
 	rc = dasd_check_cqr(cqr);
@@ -815,10 +819,10 @@ int dasd_term_IO(struct dasd_ccw_req *cq
 				      "device busy, retry later");
 			break;
 		default:
-			DEV_MESSAGE(KERN_ERR, device,
-				    "line %d unknown RC=%d, please "
-				    "report to linux390@de.ibm.com",
-				    __LINE__, rc);
+			/* internal error 10 - unknown rc*/
+			snprintf(errorstring, ERRORLENGTH, "10 %d", rc);
+			dev_err(&device->cdev->dev, "An error occurred in the "
+				"DASD device driver, reason=%s\n", errorstring);
 			BUG();
 			break;
 		}
@@ -836,6 +840,7 @@ int dasd_start_IO(struct dasd_ccw_req *c
 {
 	struct dasd_device *device;
 	int rc;
+	char errorstring[ERRORLENGTH];
 
 	/* Check the cqr */
 	rc = dasd_check_cqr(cqr);
@@ -843,9 +848,8 @@ int dasd_start_IO(struct dasd_ccw_req *c
 		return rc;
 	device = (struct dasd_device *) cqr->startdev;
 	if (cqr->retries < 0) {
-		DEV_MESSAGE(KERN_DEBUG, device,
-			    "start_IO: request %p (%02x/%i) - no retry left.",
-			    cqr, cqr->status, cqr->retries);
+		dev_err(&device->cdev->dev, "start_IO run out of retries "
+			"and failed with request %s\n", cqr);
 		cqr->status = DASD_CQR_ERROR;
 		return -EIO;
 	}
@@ -862,11 +866,11 @@ int dasd_start_IO(struct dasd_ccw_req *c
 			      cqr);
 		break;
 	case -EBUSY:
-		DBF_DEV_EVENT(DBF_ERR, device, "%s",
+		DBF_DEV_EVENT(DBF_DEBUG, device, "%s",
 			      "start_IO: device busy, retry later");
 		break;
 	case -ETIMEDOUT:
-		DBF_DEV_EVENT(DBF_ERR, device, "%s",
+		DBF_DEV_EVENT(DBF_DEBUG, device, "%s",
 			      "start_IO: request timeout, retry later");
 		break;
 	case -EACCES:
@@ -876,19 +880,21 @@ int dasd_start_IO(struct dasd_ccw_req *c
 		 * Do a retry with all available pathes.
 		 */
 		cqr->lpm = LPM_ANYPATH;
-		DBF_DEV_EVENT(DBF_ERR, device, "%s",
+		DBF_DEV_EVENT(DBF_DEBUG, device, "%s",
 			      "start_IO: selected pathes gone,"
 			      " retry on all pathes");
 		break;
 	case -ENODEV:
 	case -EIO:
-		DBF_DEV_EVENT(DBF_ERR, device, "%s",
+		DBF_DEV_EVENT(DBF_DEBUG, device, "%s",
 			      "start_IO: device gone, retry");
 		break;
 	default:
-		DEV_MESSAGE(KERN_ERR, device,
-			    "line %d unknown RC=%d, please report"
-			    " to linux390@de.ibm.com", __LINE__, rc);
+		/* internal error 11 - unknown rc */
+		snprintf(errorstring, ERRORLENGTH, "11 %d", rc);
+		dev_err(&device->cdev->dev,
+			"An error occurred in the DASD device driver, "
+			"reason=%s\n", errorstring);
 		BUG();
 		break;
 	}
@@ -996,11 +1002,11 @@ void dasd_int_handler(struct ccw_device 
 		case -EIO:
 			break;
 		case -ETIMEDOUT:
-			printk(KERN_WARNING"%s(%s): request timed out\n",
+			DBF_EVENT(DBF_WARNING, "%s(%s): request timed out\n",
 			       __func__, dev_name(&cdev->dev));
 			break;
 		default:
-			printk(KERN_WARNING"%s(%s): unknown error %ld\n",
+			DBF_EVENT(DBF_WARNING, "%s(%s): unknown error %ld\n",
 			       __func__, dev_name(&cdev->dev), PTR_ERR(irb));
 		}
 		dasd_handle_killed_request(cdev, intparm);
@@ -1009,10 +1015,6 @@ void dasd_int_handler(struct ccw_device 
 
 	now = get_clock();
 
-	DBF_EVENT(DBF_ERR, "Interrupt: bus_id %s CS/DS %04x ip %08x",
-		  dev_name(&cdev->dev), ((irb->scsw.cmd.cstat << 8) |
-		  irb->scsw.cmd.dstat), (unsigned int) intparm);
-
 	/* check for unsolicited interrupts */
 	cqr = (struct dasd_ccw_req *) intparm;
 	if (!cqr || ((irb->scsw.cmd.cc == 1) &&
@@ -1055,8 +1057,7 @@ void dasd_int_handler(struct ccw_device 
 			dev_name(&cdev->dev), cqr->status);
 		return;
 	}
-	DBF_DEV_EVENT(DBF_DEBUG, device, "Int: CS/DS 0x%04x for cqr %p",
-		      ((irb->scsw.cmd.cstat << 8) | irb->scsw.cmd.dstat), cqr);
+
 	next = NULL;
 	expires = 0;
 	if (irb->scsw.cmd.dstat == (DEV_STAT_CHN_END | DEV_STAT_DEV_END) &&
@@ -1071,18 +1072,23 @@ void dasd_int_handler(struct ccw_device 
 		}
 	} else {  /* error */
 		memcpy(&cqr->irb, irb, sizeof(struct irb));
+		/* log sense for every failed I/O to s390 debugfeature */
+		dasd_log_sense_dbf(cqr, irb);
 		if (device->features & DASD_FEATURE_ERPLOG) {
 			dasd_log_sense(cqr, irb);
 		}
+
 		/*
 		 * If we don't want complex ERP for this request, then just
 		 * reset this and retry it in the fastpath
 		 */
 		if (!test_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags) &&
 		    cqr->retries > 0) {
-			DEV_MESSAGE(KERN_DEBUG, device,
-				    "default ERP in fastpath (%i retries left)",
-				    cqr->retries);
+			if (cqr->lpm == LPM_ANYPATH)
+				DBF_DEV_EVENT(DBF_DEBUG, device,
+					      "default ERP in fastpath "
+					      "(%i retries left)",
+					      cqr->retries);
 			cqr->lpm    = LPM_ANYPATH;
 			cqr->status = DASD_CQR_QUEUED;
 			next = cqr;
@@ -1093,10 +1099,6 @@ void dasd_int_handler(struct ccw_device 
 	    (!device->stopped)) {
 		if (device->discipline->start_IO(next) == 0)
 			expires = next->expires;
-		else
-			DEV_MESSAGE(KERN_DEBUG, device, "%s",
-				    "Interrupt fastpath "
-				    "failed!");
 	}
 	if (expires != 0)
 		dasd_device_set_timer(device, expires);
@@ -1169,6 +1171,7 @@ static void __dasd_device_process_final_
 	struct dasd_block *block;
 	void (*callback)(struct dasd_ccw_req *, void *data);
 	void *callback_data;
+	char errorstring[ERRORLENGTH];
 
 	list_for_each_safe(l, n, final_queue) {
 		cqr = list_entry(l, struct dasd_ccw_req, devlist);
@@ -1189,10 +1192,11 @@ static void __dasd_device_process_final_
 			cqr->status = DASD_CQR_TERMINATED;
 			break;
 		default:
-			DEV_MESSAGE(KERN_ERR, device,
-				    "wrong cqr status in __dasd_process_final_queue "
-				    "for cqr %p, status %x",
-				    cqr, cqr->status);
+			/* internal error 12 - wrong cqr status*/
+			snprintf(errorstring, ERRORLENGTH, "12 %p %x02", cqr, cqr->status);
+			dev_err(&device->cdev->dev,
+				"An error occurred in the DASD device driver, "
+				"reason=%s\n", errorstring);
 			BUG();
 		}
 		if (cqr->callback != NULL)
@@ -1217,18 +1221,17 @@ static void __dasd_device_check_expire(s
 	    (time_after_eq(jiffies, cqr->expires + cqr->starttime))) {
 		if (device->discipline->term_IO(cqr) != 0) {
 			/* Hmpf, try again in 5 sec */
-			DEV_MESSAGE(KERN_ERR, device,
-				    "internal error - timeout (%is) expired "
-				    "for cqr %p, termination failed, "
-				    "retrying in 5s",
-				    (cqr->expires/HZ), cqr);
+			dev_err(&device->cdev->dev,
+				"cqr %p timed out (%is) but cannot be "
+				"ended, retrying in 5 s\n",
+				(cqr->expires/HZ), cqr);
 			cqr->expires += 5*HZ;
 			dasd_device_set_timer(device, 5*HZ);
 		} else {
-			DEV_MESSAGE(KERN_ERR, device,
-				    "internal error - timeout (%is) expired "
-				    "for cqr %p (%i retries left)",
-				    (cqr->expires/HZ), cqr, cqr->retries);
+			dev_err(&device->cdev->dev,
+				"cqr %p timed out (%is), %i retries "
+				"remaining\n", (cqr->expires/HZ),
+				cqr, cqr->retries);
 		}
 	}
 }
@@ -1290,10 +1293,9 @@ int dasd_flush_device_queue(struct dasd_
 			rc = device->discipline->term_IO(cqr);
 			if (rc) {
 				/* unable to terminate requeust */
-				DEV_MESSAGE(KERN_ERR, device,
-					    "dasd flush ccw_queue is unable "
-					    " to terminate request %p",
-					    cqr);
+				dev_err(&device->cdev->dev,
+					"Flushing the DASD request queue "
+					"failed for request %p\n", cqr);
 				/* stop flush processing */
 				goto finished;
 			}
@@ -1537,10 +1539,9 @@ int dasd_cancel_req(struct dasd_ccw_req 
 		/* request in IO - terminate IO and release again */
 		rc = device->discipline->term_IO(cqr);
 		if (rc) {
-			DEV_MESSAGE(KERN_ERR, device,
-				    "dasd_cancel_req is unable "
-				    " to terminate request %p, rc = %d",
-				    cqr, rc);
+			dev_err(&device->cdev->dev,
+				"Cancelling request %p failed with rc=%d\n",
+				cqr, rc);
 		} else {
 			cqr->stopclk = get_clock();
 			rc = 1;
@@ -1617,7 +1618,7 @@ static inline void __dasd_block_process_
 	if (cqr->status == DASD_CQR_DONE)
 		DBF_DEV_EVENT(DBF_NOTICE, device, "%s", "ERP successful");
 	else
-		DEV_MESSAGE(KERN_ERR, device, "%s", "ERP unsuccessful");
+		dev_err(&device->cdev->dev, "ERP failed for the DASD\n");
 	erp_fn = device->discipline->erp_postaction(cqr);
 	erp_fn(cqr);
 }
@@ -2043,8 +2044,9 @@ static int dasd_open(struct block_device
 	}
 
 	if (dasd_probeonly) {
-		DEV_MESSAGE(KERN_INFO, base, "%s",
-			    "No access to device due to probeonly mode");
+		dev_info(&base->cdev->dev,
+			 "Accessing the DASD failed because it is in "
+			 "probeonly mode\n");
 		rc = -EPERM;
 		goto out;
 	}
@@ -2144,14 +2146,14 @@ int dasd_generic_probe(struct ccw_device
 
 	ret = ccw_device_set_options(cdev, CCWDEV_DO_PATHGROUP);
 	if (ret) {
-		printk(KERN_WARNING
+		DBF_EVENT(DBF_WARNING,
 		       "dasd_generic_probe: could not set ccw-device options "
 		       "for %s\n", dev_name(&cdev->dev));
 		return ret;
 	}
 	ret = dasd_add_sysfs_files(cdev);
 	if (ret) {
-		printk(KERN_WARNING
+		DBF_EVENT(DBF_WARNING,
 		       "dasd_generic_probe: could not add sysfs entries "
 		       "for %s\n", dev_name(&cdev->dev));
 		return ret;
@@ -2167,9 +2169,7 @@ int dasd_generic_probe(struct ccw_device
 	    (dasd_autodetect && dasd_busid_known(dev_name(&cdev->dev)) != 0))
 		ret = ccw_device_set_online(cdev);
 	if (ret)
-		printk(KERN_WARNING
-		       "dasd_generic_probe: could not initially "
-		       "online ccw-device %s; return code: %d\n",
+		pr_warning("%s: Setting the DASD online failed with rc=%d\n",
 		       dev_name(&cdev->dev), ret);
 	return 0;
 }
@@ -2233,10 +2233,9 @@ int dasd_generic_set_online(struct ccw_d
 	discipline = base_discipline;
 	if (device->features & DASD_FEATURE_USEDIAG) {
 	  	if (!dasd_diag_discipline_pointer) {
-		        printk (KERN_WARNING
-				"dasd_generic couldn't online device %s "
-				"- discipline DIAG not available\n",
-				dev_name(&cdev->dev));
+			pr_warning("%s Setting the DASD online failed because "
+				   "of missing DIAG discipline\n",
+				   dev_name(&cdev->dev));
 			dasd_delete_device(device);
 			return -ENODEV;
 		}
@@ -2257,10 +2256,9 @@ int dasd_generic_set_online(struct ccw_d
 	/* check_device will allocate block device if necessary */
 	rc = discipline->check_device(device);
 	if (rc) {
-		printk (KERN_WARNING
-			"dasd_generic couldn't online device %s "
-			"with discipline %s rc=%i\n",
-			dev_name(&cdev->dev), discipline->name, rc);
+		pr_warning("%s Setting the DASD online with discipline %s "
+			   "failed with rc=%i\n",
+			   dev_name(&cdev->dev), discipline->name, rc);
 		module_put(discipline->owner);
 		module_put(base_discipline->owner);
 		dasd_delete_device(device);
@@ -2269,9 +2267,8 @@ int dasd_generic_set_online(struct ccw_d
 
 	dasd_set_target_state(device, DASD_STATE_ONLINE);
 	if (device->state <= DASD_STATE_KNOWN) {
-		printk (KERN_WARNING
-			"dasd_generic discipline not found for %s\n",
-			dev_name(&cdev->dev));
+		pr_warning("%s Setting the DASD online failed because of a "
+			   "missing discipline\n", dev_name(&cdev->dev));
 		rc = -ENODEV;
 		dasd_set_target_state(device, DASD_STATE_NEW);
 		if (device->block)
@@ -2315,13 +2312,13 @@ int dasd_generic_set_offline(struct ccw_
 		open_count = atomic_read(&device->block->open_count);
 		if (open_count > max_count) {
 			if (open_count > 0)
-				printk(KERN_WARNING "Can't offline dasd "
-				       "device with open count = %i.\n",
-				       open_count);
+				pr_warning("%s: The DASD cannot be set offline "
+					   "with open count %i\n",
+					   dev_name(&cdev->dev), open_count);
 			else
-				printk(KERN_WARNING "%s",
-				       "Can't offline dasd device due "
-				       "to internal use\n");
+				pr_warning("%s: The DASD cannot be set offline "
+					   "while it is in use\n",
+					   dev_name(&cdev->dev));
 			clear_bit(DASD_FLAG_OFFLINE, &device->flags);
 			dasd_put_device(device);
 			return -EBUSY;
@@ -2394,8 +2391,10 @@ static struct dasd_ccw_req *dasd_generic
 	cqr = dasd_smalloc_request(magic, 1 /* RDC */, rdc_buffer_size, device);
 
 	if (IS_ERR(cqr)) {
-		DEV_MESSAGE(KERN_WARNING, device, "%s",
-			    "Could not allocate RDC request");
+		/* internal error 13 - Allocating the RDC request failed*/
+		dev_err(&device->cdev->dev,
+			 "An error occurred in the DASD device driver, "
+			 "reason=%s\n", "13");
 		return cqr;
 	}
 
@@ -2473,7 +2472,7 @@ static int __init dasd_init(void)
 
 	return 0;
 failed:
-	MESSAGE(KERN_INFO, "%s", "initialization not performed due to errors");
+	pr_info("The DASD device driver could not be initialized\n");
 	dasd_exit();
 	return rc;
 }
Index: quilt-2.6/drivers/s390/block/dasd_diag.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_diag.c
+++ quilt-2.6/drivers/s390/block/dasd_diag.c
@@ -8,6 +8,8 @@
  *
  */
 
+#define KMSG_COMPONENT "dasd"
+
 #include <linux/stddef.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -144,8 +146,8 @@ dasd_diag_erp(struct dasd_device *device
 	mdsk_term_io(device);
 	rc = mdsk_init_io(device, device->block->bp_block, 0, NULL);
 	if (rc)
-		DEV_MESSAGE(KERN_WARNING, device, "DIAG ERP unsuccessful, "
-			    "rc=%d", rc);
+		dev_warn(&device->cdev->dev, "DIAG ERP failed with "
+			    "rc=%d\n", rc);
 }
 
 /* Start a given request at the device. Return zero on success, non-zero
@@ -160,7 +162,7 @@ dasd_start_diag(struct dasd_ccw_req * cq
 
 	device = cqr->startdev;
 	if (cqr->retries < 0) {
-		DEV_MESSAGE(KERN_WARNING, device, "DIAG start_IO: request %p "
+		DBF_DEV_EVENT(DBF_ERR, device, "DIAG start_IO: request %p "
 			    "- no retry left)", cqr);
 		cqr->status = DASD_CQR_ERROR;
 		return -EIO;
@@ -195,7 +197,7 @@ dasd_start_diag(struct dasd_ccw_req * cq
 		break;
 	default: /* Error condition */
 		cqr->status = DASD_CQR_QUEUED;
-		DEV_MESSAGE(KERN_WARNING, device, "dia250 returned rc=%d", rc);
+		DBF_DEV_EVENT(DBF_WARNING, device, "dia250 returned rc=%d", rc);
 		dasd_diag_erp(device);
 		rc = -EIO;
 		break;
@@ -249,7 +251,7 @@ dasd_ext_handler(__u16 code)
 	cqr = (struct dasd_ccw_req *) ip;
 	device = (struct dasd_device *) cqr->startdev;
 	if (strncmp(device->discipline->ebcname, (char *) &cqr->magic, 4)) {
-		DEV_MESSAGE(KERN_WARNING, device,
+		DBF_DEV_EVENT(DBF_WARNING, device,
 			    " magic number of dasd_ccw_req 0x%08X doesn't"
 			    " match discipline 0x%08X",
 			    cqr->magic, *(int *) (&device->discipline->name));
@@ -281,15 +283,11 @@ dasd_ext_handler(__u16 code)
 				rc = dasd_start_diag(next);
 				if (rc == 0)
 					expires = next->expires;
-				else if (rc != -EACCES)
-					DEV_MESSAGE(KERN_WARNING, device, "%s",
-						    "Interrupt fastpath "
-						    "failed!");
 			}
 		}
 	} else {
 		cqr->status = DASD_CQR_QUEUED;
-		DEV_MESSAGE(KERN_WARNING, device, "interrupt status for "
+		DBF_DEV_EVENT(DBF_DEBUG, device, "interrupt status for "
 			    "request %p was %d (%d retries left)", cqr, status,
 			    cqr->retries);
 		dasd_diag_erp(device);
@@ -322,8 +320,9 @@ dasd_diag_check_device(struct dasd_devic
 	if (private == NULL) {
 		private = kzalloc(sizeof(struct dasd_diag_private),GFP_KERNEL);
 		if (private == NULL) {
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				"memory allocation failed for private data");
+			DBF_DEV_EVENT(DBF_WARNING, device, "%s",
+				"Allocating memory for private DASD data "
+				      "failed\n");
 			return -ENOMEM;
 		}
 		ccw_device_get_id(device->cdev, &private->dev_id);
@@ -331,7 +330,7 @@ dasd_diag_check_device(struct dasd_devic
 	}
 	block = dasd_alloc_block();
 	if (IS_ERR(block)) {
-		DEV_MESSAGE(KERN_WARNING, device, "%s",
+		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			    "could not allocate dasd block structure");
 		device->private = NULL;
 		kfree(private);
@@ -347,7 +346,7 @@ dasd_diag_check_device(struct dasd_devic
 
 	rc = diag210((struct diag210 *) rdc_data);
 	if (rc) {
-		DEV_MESSAGE(KERN_WARNING, device, "failed to retrieve device "
+		DBF_DEV_EVENT(DBF_WARNING, device, "failed to retrieve device "
 			    "information (rc=%d)", rc);
 		rc = -EOPNOTSUPP;
 		goto out;
@@ -362,8 +361,8 @@ dasd_diag_check_device(struct dasd_devic
 		private->pt_block = 2;
 		break;
 	default:
-		DEV_MESSAGE(KERN_WARNING, device, "unsupported device class "
-			    "(class=%d)", private->rdc_data.vdev_class);
+		dev_warn(&device->cdev->dev, "Device type %d is not supported "
+			    "in DIAG mode\n", private->rdc_data.vdev_class);
 		rc = -EOPNOTSUPP;
 		goto out;
 	}
@@ -380,7 +379,7 @@ dasd_diag_check_device(struct dasd_devic
 	/* figure out blocksize of device */
 	label = (struct vtoc_cms_label *) get_zeroed_page(GFP_KERNEL);
 	if (label == NULL)  {
-		DEV_MESSAGE(KERN_WARNING, device, "%s",
+		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			    "No memory to allocate initialization request");
 		rc = -ENOMEM;
 		goto out;
@@ -404,8 +403,8 @@ dasd_diag_check_device(struct dasd_devic
 		private->iob.flaga = DASD_DIAG_FLAGA_DEFAULT;
 		rc = dia250(&private->iob, RW_BIO);
 		if (rc == 3) {
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				"DIAG call failed");
+			dev_warn(&device->cdev->dev,
+				"A 64-bit DIAG call failed\n");
 			rc = -EOPNOTSUPP;
 			goto out_label;
 		}
@@ -414,8 +413,8 @@ dasd_diag_check_device(struct dasd_devic
 			break;
 	}
 	if (bsize > PAGE_SIZE) {
-		DEV_MESSAGE(KERN_WARNING, device, "device access failed "
-			    "(rc=%d)", rc);
+		dev_warn(&device->cdev->dev, "Accessing the DASD failed because"
+			 " of an incorrect format (rc=%d)\n", rc);
 		rc = -EIO;
 		goto out_label;
 	}
@@ -433,15 +432,15 @@ dasd_diag_check_device(struct dasd_devic
 		block->s2b_shift++;
 	rc = mdsk_init_io(device, block->bp_block, 0, NULL);
 	if (rc) {
-		DEV_MESSAGE(KERN_WARNING, device, "DIAG initialization "
-			"failed (rc=%d)", rc);
+		dev_warn(&device->cdev->dev, "DIAG initialization "
+			"failed with rc=%d\n", rc);
 		rc = -EIO;
 	} else {
-		DEV_MESSAGE(KERN_INFO, device,
-			    "(%ld B/blk): %ldkB",
-			    (unsigned long) block->bp_block,
-			    (unsigned long) (block->blocks <<
-				block->s2b_shift) >> 1);
+		dev_info(&device->cdev->dev,
+			 "New DASD with %ld byte/block, total size %ld KB\n",
+			 (unsigned long) block->bp_block,
+			 (unsigned long) (block->blocks <<
+					  block->s2b_shift) >> 1);
 	}
 out_label:
 	free_page((long) label);
@@ -595,7 +594,7 @@ static void
 dasd_diag_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
 		     struct irb *stat)
 {
-	DEV_MESSAGE(KERN_ERR, device, "%s",
+	DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 		    "dump sense not available for DIAG data");
 }
 
Index: quilt-2.6/drivers/s390/block/dasd_eckd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_eckd.c
+++ quilt-2.6/drivers/s390/block/dasd_eckd.c
@@ -11,6 +11,8 @@
  *
  */
 
+#define KMSG_COMPONENT "dasd"
+
 #include <linux/stddef.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -84,7 +86,7 @@ dasd_eckd_probe (struct ccw_device *cdev
 	/* set ECKD specific ccw-device options */
 	ret = ccw_device_set_options(cdev, CCWDEV_ALLOW_FORCE);
 	if (ret) {
-		printk(KERN_WARNING
+		DBF_EVENT(DBF_WARNING,
 		       "dasd_eckd_probe: could not set ccw-device options "
 		       "for %s\n", dev_name(&cdev->dev));
 		return ret;
@@ -245,7 +247,8 @@ define_extent(struct ccw1 *ccw, struct D
 		rc = check_XRC (ccw, data, device);
 		break;
 	default:
-		DEV_MESSAGE(KERN_ERR, device, "unknown opcode 0x%x", cmd);
+		dev_err(&device->cdev->dev,
+			"0x%x is not a known command\n", cmd);
 		break;
 	}
 
@@ -369,7 +372,8 @@ static int prefix(struct ccw1 *ccw, stru
 		rc = check_XRC_on_prefix(pfxdata, basedev);
 		break;
 	default:
-		DEV_MESSAGE(KERN_ERR, basedev, "unknown opcode 0x%x", cmd);
+		DBF_DEV_EVENT(DBF_ERR, basedev, "unknown prefix opcode 0x%x",
+			      cmd);
 		break;
 	}
 
@@ -495,7 +499,8 @@ locate_record(struct ccw1 *ccw, struct L
 		data->operation.operation = 0x0b;
 		break;
 	default:
-		DEV_MESSAGE(KERN_ERR, device, "unknown opcode 0x%x", cmd);
+		DBF_DEV_EVENT(DBF_ERR, device, "unknown locate record "
+			      "opcode 0x%x", cmd);
 	}
 	set_ch_t(&data->seek_addr,
 		 trk / private->rdc_data.trk_per_cyl,
@@ -590,8 +595,8 @@ static struct dasd_ccw_req *dasd_eckd_bu
 	cqr = dasd_smalloc_request("ECKD", 1 /* RCD */, ciw->count, device);
 
 	if (IS_ERR(cqr)) {
-		DEV_MESSAGE(KERN_WARNING, device, "%s",
-			    "Could not allocate RCD request");
+		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
+			      "Could not allocate RCD request");
 		return cqr;
 	}
 
@@ -741,14 +746,16 @@ static int dasd_eckd_read_conf(struct da
 			rc = dasd_eckd_read_conf_lpm(device, &conf_data,
 						     &conf_len, lpm);
 			if (rc && rc != -EOPNOTSUPP) {	/* -EOPNOTSUPP is ok */
-				MESSAGE(KERN_WARNING,
-					"Read configuration data returned "
-					"error %d", rc);
+				DBF_EVENT(DBF_WARNING,
+					  "Read configuration data returned "
+					  "error %d for device: %s", rc,
+					  dev_name(&device->cdev->dev));
 				return rc;
 			}
 			if (conf_data == NULL) {
-				MESSAGE(KERN_WARNING, "%s", "No configuration "
-					"data retrieved");
+				DBF_EVENT(DBF_WARNING, "No configuration "
+					  "data retrieved for device: %s",
+					  dev_name(&device->cdev->dev));
 				continue;	/* no error */
 			}
 			/* save first valid configuration data */
@@ -795,8 +802,9 @@ static int dasd_eckd_read_features(struc
 				    sizeof(struct dasd_rssd_features)),
 				   device);
 	if (IS_ERR(cqr)) {
-		DEV_MESSAGE(KERN_WARNING, device, "%s",
-			    "Could not allocate initialization request");
+		DBF_EVENT(DBF_WARNING, "Could not allocate initialization "
+			  "request for device: %s",
+			  dev_name(&device->cdev->dev));
 		return PTR_ERR(cqr);
 	}
 	cqr->startdev = device;
@@ -856,7 +864,7 @@ static struct dasd_ccw_req *dasd_eckd_bu
 				  device);
 
 	if (IS_ERR(cqr)) {
-		DEV_MESSAGE(KERN_WARNING, device, "%s",
+		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			   "Could not allocate PSF-SSC request");
 		return cqr;
 	}
@@ -918,10 +926,10 @@ static int dasd_eckd_validate_server(str
 	/* may be requested feature is not available on server,
 	 * therefore just report error and go ahead */
 	private = (struct dasd_eckd_private *) device->private;
-	DEV_MESSAGE(KERN_INFO, device,
-		    "PSF-SSC on storage subsystem %s.%s.%04x returned rc=%d",
-		    private->uid.vendor, private->uid.serial,
-		    private->uid.ssid, rc);
+	DBF_EVENT(DBF_WARNING, "PSF-SSC on storage subsystem %s.%s.%04x "
+		  "returned rc=%d for device: %s",
+		  private->uid.vendor, private->uid.serial,
+		  private->uid.ssid, rc, dev_name(&device->cdev->dev));
 	/* RE-Read Configuration Data */
 	return dasd_eckd_read_conf(device);
 }
@@ -943,9 +951,9 @@ dasd_eckd_check_characteristics(struct d
 		private = kzalloc(sizeof(struct dasd_eckd_private),
 				  GFP_KERNEL | GFP_DMA);
 		if (private == NULL) {
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "memory allocation failed for private "
-				    "data");
+			dev_warn(&device->cdev->dev,
+				 "Allocating memory for private DASD data "
+				 "failed\n");
 			return -ENOMEM;
 		}
 		device->private = (void *) private;
@@ -970,8 +978,9 @@ dasd_eckd_check_characteristics(struct d
 	if (private->uid.type == UA_BASE_DEVICE) {
 		block = dasd_alloc_block();
 		if (IS_ERR(block)) {
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "could not allocate dasd block structure");
+			DBF_EVENT(DBF_WARNING, "could not allocate dasd "
+				  "block structure for device: %s",
+				  dev_name(&device->cdev->dev));
 			rc = PTR_ERR(block);
 			goto out_err1;
 		}
@@ -1002,9 +1011,9 @@ dasd_eckd_check_characteristics(struct d
 	memset(rdc_data, 0, sizeof(rdc_data));
 	rc = dasd_generic_read_dev_chars(device, "ECKD", &rdc_data, 64);
 	if (rc) {
-		DEV_MESSAGE(KERN_WARNING, device,
-			    "Read device characteristics returned "
-			    "rc=%d", rc);
+		DBF_EVENT(DBF_WARNING,
+			  "Read device characteristics failed, rc=%d for "
+			  "device: %s", rc, dev_name(&device->cdev->dev));
 		goto out_err3;
 	}
 	/* find the vaild cylinder size */
@@ -1014,15 +1023,15 @@ dasd_eckd_check_characteristics(struct d
 	else
 		private->real_cyl = private->rdc_data.no_cyl;
 
-	DEV_MESSAGE(KERN_INFO, device,
-		    "%04X/%02X(CU:%04X/%02X) Cyl:%d Head:%d Sec:%d",
-		    private->rdc_data.dev_type,
-		    private->rdc_data.dev_model,
-		    private->rdc_data.cu_type,
-		    private->rdc_data.cu_model.model,
+	dev_info(&device->cdev->dev, "New DASD %04X/%02X (CU %04X/%02X) "
+		 "with %d cylinders, %d heads, %d sectors\n",
+		 private->rdc_data.dev_type,
+		 private->rdc_data.dev_model,
+		 private->rdc_data.cu_type,
+		 private->rdc_data.cu_model.model,
 		    private->real_cyl,
-		    private->rdc_data.trk_per_cyl,
-		    private->rdc_data.sec_per_trk);
+		 private->rdc_data.trk_per_cyl,
+		 private->rdc_data.sec_per_trk);
 	return 0;
 
 out_err3:
@@ -1163,8 +1172,8 @@ dasd_eckd_end_analysis(struct dasd_block
 	status = private->init_cqr_status;
 	private->init_cqr_status = -1;
 	if (status != DASD_CQR_DONE) {
-		DEV_MESSAGE(KERN_WARNING, device, "%s",
-			    "volume analysis returned unformatted disk");
+		dev_warn(&device->cdev->dev,
+			    "The DASD is not formatted\n");
 		return -EMEDIUMTYPE;
 	}
 
@@ -1192,8 +1201,8 @@ dasd_eckd_end_analysis(struct dasd_block
 			count_area = &private->count_area[0];
 	} else {
 		if (private->count_area[3].record == 1)
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "Trk 0: no records after VTOC!");
+			dev_warn(&device->cdev->dev,
+				 "Track 0 has no records following the VTOC\n");
 	}
 	if (count_area != NULL && count_area->kl == 0) {
 		/* we found notthing violating our disk layout */
@@ -1201,8 +1210,8 @@ dasd_eckd_end_analysis(struct dasd_block
 			block->bp_block = count_area->dl;
 	}
 	if (block->bp_block == 0) {
-		DEV_MESSAGE(KERN_WARNING, device, "%s",
-			    "Volume has incompatible disk layout");
+		dev_warn(&device->cdev->dev,
+			 "The disk layout of the DASD is not supported\n");
 		return -EMEDIUMTYPE;
 	}
 	block->s2b_shift = 0;	/* bits to shift 512 to get a block */
@@ -1214,15 +1223,15 @@ dasd_eckd_end_analysis(struct dasd_block
 			  private->rdc_data.trk_per_cyl *
 			  blk_per_trk);
 
-	DEV_MESSAGE(KERN_INFO, device,
-		    "(%dkB blks): %dkB at %dkB/trk %s",
-		    (block->bp_block >> 10),
-		    ((private->real_cyl *
-		      private->rdc_data.trk_per_cyl *
-		      blk_per_trk * (block->bp_block >> 9)) >> 1),
-		    ((blk_per_trk * block->bp_block) >> 10),
-		    private->uses_cdl ?
-		    "compatible disk layout" : "linux disk layout");
+	dev_info(&device->cdev->dev,
+		 "DASD with %d KB/block, %d KB total size, %d KB/track, "
+		 "%s\n", (block->bp_block >> 10),
+		 ((private->real_cyl *
+		   private->rdc_data.trk_per_cyl *
+		   blk_per_trk * (block->bp_block >> 9)) >> 1),
+		 ((blk_per_trk * block->bp_block) >> 10),
+		 private->uses_cdl ?
+		 "compatible disk layout" : "linux disk layout");
 
 	return 0;
 }
@@ -1288,19 +1297,19 @@ dasd_eckd_format_device(struct dasd_devi
 	/* Sanity checks. */
 	if (fdata->start_unit >=
 	    (private->real_cyl * private->rdc_data.trk_per_cyl)) {
-		DEV_MESSAGE(KERN_INFO, device, "Track no %u too big!",
-			    fdata->start_unit);
+		dev_warn(&device->cdev->dev, "Start track number %d used in "
+			 "formatting is too big\n", fdata->start_unit);
 		return ERR_PTR(-EINVAL);
 	}
 	if (fdata->start_unit > fdata->stop_unit) {
-		DEV_MESSAGE(KERN_INFO, device, "Track %u reached! ending.",
-			    fdata->start_unit);
+		dev_warn(&device->cdev->dev, "Start track %d used in "
+			 "formatting exceeds end track\n", fdata->start_unit);
 		return ERR_PTR(-EINVAL);
 	}
 	if (dasd_check_blocksize(fdata->blksize) != 0) {
-		DEV_MESSAGE(KERN_WARNING, device,
-			    "Invalid blocksize %u...terminating!",
-			    fdata->blksize);
+		dev_warn(&device->cdev->dev,
+			 "The DASD cannot be formatted with block size %d\n",
+			 fdata->blksize);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -1344,8 +1353,8 @@ dasd_eckd_format_device(struct dasd_devi
 			sizeof(struct eckd_count);
 		break;
 	default:
-		DEV_MESSAGE(KERN_WARNING, device, "Invalid flags 0x%x.",
-			    fdata->intensity);
+		dev_warn(&device->cdev->dev, "An I/O control call used "
+			 "incorrect flags 0x%x\n", fdata->intensity);
 		return ERR_PTR(-EINVAL);
 	}
 	/* Allocate the format ccw request. */
@@ -1539,13 +1548,14 @@ static void dasd_eckd_handle_unsolicited
 
 	if (!(irb->esw.esw0.erw.cons)) {
 		/* just report other unsolicited interrupts */
-		DEV_MESSAGE(KERN_ERR, device, "%s",
+		DBF_DEV_EVENT(DBF_ERR, device, "%s",
 			    "unsolicited interrupt received");
 	} else {
-		DEV_MESSAGE(KERN_ERR, device, "%s",
+		DBF_DEV_EVENT(DBF_ERR, device, "%s",
 			    "unsolicited interrupt received "
 			    "(sense available)");
-		device->discipline->dump_sense(device, NULL, irb);
+		device->discipline->dump_sense_dbf(device, NULL, irb,
+						   "unsolicited");
 	}
 
 	dasd_schedule_device_bh(device);
@@ -1893,7 +1903,7 @@ dasd_eckd_release(struct dasd_device *de
 	cqr = dasd_smalloc_request(dasd_eckd_discipline.name,
 				   1, 32, device);
 	if (IS_ERR(cqr)) {
-		DEV_MESSAGE(KERN_WARNING, device, "%s",
+		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			    "Could not allocate initialization request");
 		return PTR_ERR(cqr);
 	}
@@ -1934,7 +1944,7 @@ dasd_eckd_reserve(struct dasd_device *de
 	cqr = dasd_smalloc_request(dasd_eckd_discipline.name,
 				   1, 32, device);
 	if (IS_ERR(cqr)) {
-		DEV_MESSAGE(KERN_WARNING, device, "%s",
+		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			    "Could not allocate initialization request");
 		return PTR_ERR(cqr);
 	}
@@ -1974,7 +1984,7 @@ dasd_eckd_steal_lock(struct dasd_device 
 	cqr = dasd_smalloc_request(dasd_eckd_discipline.name,
 				   1, 32, device);
 	if (IS_ERR(cqr)) {
-		DEV_MESSAGE(KERN_WARNING, device, "%s",
+		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			    "Could not allocate initialization request");
 		return PTR_ERR(cqr);
 	}
@@ -2015,7 +2025,7 @@ dasd_eckd_performance(struct dasd_device
 				    sizeof(struct dasd_rssd_perf_stats_t)),
 				   device);
 	if (IS_ERR(cqr)) {
-		DEV_MESSAGE(KERN_WARNING, device, "%s",
+		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			    "Could not allocate initialization request");
 		return PTR_ERR(cqr);
 	}
@@ -2105,9 +2115,9 @@ dasd_eckd_set_attrib(struct dasd_device 
 		return -EFAULT;
 	private->attrib = attrib;
 
-	DEV_MESSAGE(KERN_INFO, device,
-		    "cache operation mode set to %x (%i cylinder prestage)",
-		    private->attrib.operation, private->attrib.nr_cyl);
+	dev_info(&device->cdev->dev,
+		 "The DASD cache mode was set to %x (%i cylinder prestage)\n",
+		 private->attrib.operation, private->attrib.nr_cyl);
 	return 0;
 }
 
@@ -2158,7 +2168,7 @@ static int dasd_symm_io(struct dasd_devi
 	/* setup CCWs for PSF + RSSD */
 	cqr = dasd_smalloc_request("ECKD", 2 , 0, device);
 	if (IS_ERR(cqr)) {
-		DEV_MESSAGE(KERN_WARNING, device, "%s",
+		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			"Could not allocate initialization request");
 		rc = PTR_ERR(cqr);
 		goto out_free;
@@ -2267,6 +2277,24 @@ dasd_eckd_dump_ccw_range(struct ccw1 *fr
 	return len;
 }
 
+static void
+dasd_eckd_dump_sense_dbf(struct dasd_device *device, struct dasd_ccw_req *req,
+			 struct irb *irb, char *reason)
+{
+	int sl;
+	if (irb->esw.esw0.erw.cons) {
+		for (sl = 0; sl < 4; sl++) {
+			DBF_DEV_EVENT(DBF_EMERG, device,
+				      "%s: %08x %08x %08x %08x",
+				      reason, irb->ecw[8 * 0], irb->ecw[8 * 1],
+				      irb->ecw[8 * 2], irb->ecw[8 * 3]);
+		}
+	} else {
+		DBF_DEV_EVENT(DBF_EMERG, device, "%s",
+			      "SORRY - NO VALID SENSE AVAILABLE\n");
+	}
+}
+
 /*
  * Print sense data and related channel program.
  * Parts are printed because printk buffer is only 1024 bytes.
@@ -2280,8 +2308,8 @@ static void dasd_eckd_dump_sense(struct 
 
 	page = (char *) get_zeroed_page(GFP_ATOMIC);
 	if (page == NULL) {
-		DEV_MESSAGE(KERN_ERR, device, " %s",
-			    "No memory to dump sense data");
+		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
+			      "No memory to dump sense data\n");
 		return;
 	}
 	/* dump the sense data */
@@ -2400,6 +2428,7 @@ static struct dasd_discipline dasd_eckd_
 	.build_cp = dasd_eckd_build_alias_cp,
 	.free_cp = dasd_eckd_free_alias_cp,
 	.dump_sense = dasd_eckd_dump_sense,
+	.dump_sense_dbf = dasd_eckd_dump_sense_dbf,
 	.fill_info = dasd_eckd_fill_info,
 	.ioctl = dasd_eckd_ioctl,
 };
Index: quilt-2.6/drivers/s390/block/dasd_erp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_erp.c
+++ quilt-2.6/drivers/s390/block/dasd_erp.c
@@ -91,14 +91,14 @@ dasd_default_erp_action(struct dasd_ccw_
 
         /* just retry - there is nothing to save ... I got no sense data.... */
         if (cqr->retries > 0) {
-		DEV_MESSAGE (KERN_DEBUG, device,
+		DBF_DEV_EVENT(DBF_DEBUG, device,
                              "default ERP called (%i retries left)",
                              cqr->retries);
 		cqr->lpm    = LPM_ANYPATH;
 		cqr->status = DASD_CQR_FILLED;
         } else {
-                DEV_MESSAGE (KERN_WARNING, device, "%s",
-			     "default ERP called (NO retry left)");
+		dev_warn(&device->cdev->dev,
+			     "default ERP called (NO retry left)\n");
 		cqr->status = DASD_CQR_FAILED;
 		cqr->stopclk = get_clock();
         }
@@ -162,8 +162,21 @@ dasd_log_sense(struct dasd_ccw_req *cqr,
 		device->discipline->dump_sense(device, cqr, irb);
 }
 
+void
+dasd_log_sense_dbf(struct dasd_ccw_req *cqr, struct irb *irb)
+{
+	struct dasd_device *device;
+
+	device = cqr->startdev;
+	/* dump sense data to s390 debugfeature*/
+	if (device->discipline && device->discipline->dump_sense_dbf)
+		device->discipline->dump_sense_dbf(device, cqr, irb, "log");
+}
+EXPORT_SYMBOL(dasd_log_sense_dbf);
+
 EXPORT_SYMBOL(dasd_default_erp_action);
 EXPORT_SYMBOL(dasd_default_erp_postaction);
 EXPORT_SYMBOL(dasd_alloc_erp_request);
 EXPORT_SYMBOL(dasd_free_erp_request);
 EXPORT_SYMBOL(dasd_log_sense);
+
Index: quilt-2.6/drivers/s390/block/dasd_fba.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_fba.c
+++ quilt-2.6/drivers/s390/block/dasd_fba.c
@@ -128,17 +128,17 @@ dasd_fba_check_characteristics(struct da
 		private = kzalloc(sizeof(struct dasd_fba_private),
 				  GFP_KERNEL | GFP_DMA);
 		if (private == NULL) {
-			DEV_MESSAGE(KERN_WARNING, device, "%s",
-				    "memory allocation failed for private "
-				    "data");
+			dev_warn(&device->cdev->dev,
+				 "memory allocation failed for private data");
 			return -ENOMEM;
 		}
 		device->private = (void *) private;
 	}
 	block = dasd_alloc_block();
 	if (IS_ERR(block)) {
-		DEV_MESSAGE(KERN_WARNING, device, "%s",
-			    "could not allocate dasd block structure");
+		DBF_EVENT(DBF_WARNING, "could not allocate dasd block "
+			  "structure for device: %s",
+			  dev_name(&device->cdev->dev));
 		device->private = NULL;
 		kfree(private);
 		return PTR_ERR(block);
@@ -150,9 +150,9 @@ dasd_fba_check_characteristics(struct da
 	rdc_data = (void *) &(private->rdc_data);
 	rc = dasd_generic_read_dev_chars(device, "FBA ", &rdc_data, 32);
 	if (rc) {
-		DEV_MESSAGE(KERN_WARNING, device,
-			    "Read device characteristics returned error %d",
-			    rc);
+		DBF_EVENT(DBF_WARNING, "Read device characteristics returned "
+			  "error %d for device: %s",
+			  rc, dev_name(&device->cdev->dev));
 		device->block = NULL;
 		dasd_free_block(block);
 		device->private = NULL;
@@ -160,7 +160,7 @@ dasd_fba_check_characteristics(struct da
 		return rc;
 	}
 
-	DEV_MESSAGE(KERN_INFO, device,
+	dev_info(&device->cdev->dev,
 		    "%04X/%02X(CU:%04X/%02X) %dMB at(%d B/blk)",
 		    cdev->id.dev_type,
 		    cdev->id.dev_model,
@@ -180,7 +180,7 @@ static int dasd_fba_do_analysis(struct d
 	private = (struct dasd_fba_private *) block->base->private;
 	rc = dasd_check_blocksize(private->rdc_data.blk_size);
 	if (rc) {
-		DEV_MESSAGE(KERN_INFO, block->base, "unknown blocksize %d",
+		DBF_DEV_EVENT(DBF_WARNING, block->base, "unknown blocksize %d",
 			    private->rdc_data.blk_size);
 		return rc;
 	}
@@ -215,7 +215,7 @@ dasd_fba_erp_postaction(struct dasd_ccw_
 	if (cqr->function == dasd_default_erp_action)
 		return dasd_default_erp_postaction;
 
-	DEV_MESSAGE(KERN_WARNING, cqr->startdev, "unknown ERP action %p",
+	DBF_DEV_EVENT(DBF_WARNING, cqr->startdev, "unknown ERP action %p",
 		    cqr->function);
 	return NULL;
 }
@@ -233,9 +233,9 @@ static void dasd_fba_handle_unsolicited_
 	}
 
 	/* check for unsolicited interrupts */
-	DEV_MESSAGE(KERN_DEBUG, device, "%s",
+	DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 		    "unsolicited interrupt received");
-	device->discipline->dump_sense(device, NULL, irb);
+	device->discipline->dump_sense_dbf(device, NULL, irb, "unsolicited");
 	dasd_schedule_device_bh(device);
 	return;
 };
@@ -437,6 +437,25 @@ dasd_fba_fill_info(struct dasd_device * 
 }
 
 static void
+dasd_fba_dump_sense_dbf(struct dasd_device *device, struct dasd_ccw_req *req,
+			 struct irb *irb, char *reason)
+{
+	int sl;
+	if (irb->esw.esw0.erw.cons) {
+		for (sl = 0; sl < 4; sl++) {
+			DBF_DEV_EVENT(DBF_EMERG, device,
+				      "%s: %08x %08x %08x %08x",
+				      reason, irb->ecw[8 * 0], irb->ecw[8 * 1],
+				      irb->ecw[8 * 2], irb->ecw[8 * 3]);
+		}
+	} else {
+		DBF_DEV_EVENT(DBF_EMERG, device, "%s",
+			      "SORRY - NO VALID SENSE AVAILABLE\n");
+	}
+}
+
+
+static void
 dasd_fba_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
 		    struct irb *irb)
 {
@@ -446,7 +465,7 @@ dasd_fba_dump_sense(struct dasd_device *
 
 	page = (char *) get_zeroed_page(GFP_ATOMIC);
 	if (page == NULL) {
-		DEV_MESSAGE(KERN_ERR, device, " %s",
+		dev_err(&device->cdev->dev,
 			    "No memory to dump sense data");
 		return;
 	}
@@ -576,6 +595,7 @@ static struct dasd_discipline dasd_fba_d
 	.build_cp = dasd_fba_build_cp,
 	.free_cp = dasd_fba_free_cp,
 	.dump_sense = dasd_fba_dump_sense,
+	.dump_sense_dbf = dasd_fba_dump_sense_dbf,
 	.fill_info = dasd_fba_fill_info,
 };
 
Index: quilt-2.6/drivers/s390/block/dasd_int.h
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_int.h
+++ quilt-2.6/drivers/s390/block/dasd_int.h
@@ -112,6 +112,9 @@ do { \
 				d_data); \
 } while(0)
 
+/* limit size for an errorstring */
+#define ERRORLENGTH 30
+
 /* definition of dbf debug levels */
 #define	DBF_EMERG	0	/* system is unusable			*/
 #define	DBF_ALERT	1	/* action must be taken immediately	*/
@@ -280,6 +283,8 @@ struct dasd_discipline {
 	dasd_erp_fn_t(*erp_postaction) (struct dasd_ccw_req *);
 	void (*dump_sense) (struct dasd_device *, struct dasd_ccw_req *,
 			    struct irb *);
+	void (*dump_sense_dbf) (struct dasd_device *, struct dasd_ccw_req *,
+			    struct irb *, char *);
 
 	void (*handle_unsolicited_interrupt) (struct dasd_device *,
 					      struct irb *);
@@ -623,6 +628,7 @@ struct dasd_ccw_req *dasd_alloc_erp_requ
 					    struct dasd_device *);
 void dasd_free_erp_request(struct dasd_ccw_req *, struct dasd_device *);
 void dasd_log_sense(struct dasd_ccw_req *, struct irb *);
+void dasd_log_sense_dbf(struct dasd_ccw_req *cqr, struct irb *irb);
 
 /* externals in dasd_3990_erp.c */
 struct dasd_ccw_req *dasd_3990_erp_action(struct dasd_ccw_req *);
Index: quilt-2.6/drivers/s390/block/dasd_ioctl.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_ioctl.c
+++ quilt-2.6/drivers/s390/block/dasd_ioctl.c
@@ -9,6 +9,9 @@
  *
  * i/o controls for the dasd driver.
  */
+
+#define KMSG_COMPONENT "dasd"
+
 #include <linux/interrupt.h>
 #include <linux/major.h>
 #include <linux/fs.h>
@@ -94,7 +97,8 @@ static int dasd_ioctl_quiesce(struct das
 	if (!capable (CAP_SYS_ADMIN))
 		return -EACCES;
 
-	DEV_MESSAGE(KERN_DEBUG, base, "%s", "Quiesce IO on device");
+	dev_info(&base->cdev->dev, "The DASD has been put in the quiesce "
+		 "state\n");
 	spin_lock_irqsave(get_ccwdev_lock(base->cdev), flags);
 	base->stopped |= DASD_STOPPED_QUIESCE;
 	spin_unlock_irqrestore(get_ccwdev_lock(base->cdev), flags);
@@ -103,7 +107,7 @@ static int dasd_ioctl_quiesce(struct das
 
 
 /*
- * Quiesce device.
+ * Resume device.
  */
 static int dasd_ioctl_resume(struct dasd_block *block)
 {
@@ -114,7 +118,8 @@ static int dasd_ioctl_resume(struct dasd
 	if (!capable (CAP_SYS_ADMIN))
 		return -EACCES;
 
-	DEV_MESSAGE(KERN_DEBUG, base, "%s", "resume IO on device");
+	dev_info(&base->cdev->dev, "I/O operations have been resumed "
+		 "on the DASD\n");
 	spin_lock_irqsave(get_ccwdev_lock(base->cdev), flags);
 	base->stopped &= ~DASD_STOPPED_QUIESCE;
 	spin_unlock_irqrestore(get_ccwdev_lock(base->cdev), flags);
@@ -140,8 +145,8 @@ static int dasd_format(struct dasd_block
 		return -EPERM;
 
 	if (base->state != DASD_STATE_BASIC) {
-		DEV_MESSAGE(KERN_WARNING, base, "%s",
-			    "dasd_format: device is not disabled! ");
+		dev_warn(&base->cdev->dev,
+			 "The DASD cannot be formatted while it is enabled\n");
 		return -EBUSY;
 	}
 
@@ -169,10 +174,9 @@ static int dasd_format(struct dasd_block
 		dasd_sfree_request(cqr, cqr->memdev);
 		if (rc) {
 			if (rc != -ERESTARTSYS)
-				DEV_MESSAGE(KERN_ERR, base,
-					    " Formatting of unit %u failed "
-					    "with rc = %d",
-					    fdata->start_unit, rc);
+				dev_err(&base->cdev->dev,
+					"Formatting unit %d failed with "
+					"rc=%d\n", fdata->start_unit, rc);
 			return rc;
 		}
 		fdata->start_unit++;
@@ -199,8 +203,9 @@ dasd_ioctl_format(struct block_device *b
 	if (copy_from_user(&fdata, argp, sizeof(struct format_data_t)))
 		return -EFAULT;
 	if (bdev != bdev->bd_contains) {
-		DEV_MESSAGE(KERN_WARNING, block->base, "%s",
-			    "Cannot low-level format a partition");
+		dev_warn(&block->base->cdev->dev,
+			 "The specified DASD is a partition and cannot be "
+			 "formatted\n");
 		return -EINVAL;
 	}
 	return dasd_format(block, &fdata);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
