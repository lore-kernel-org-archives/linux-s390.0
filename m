Return-Path: <linux-kernel-owner+w=401wt.eu-S936192AbXLTPco@vger.kernel.org>
Message-Id: <20071220152112.845028665@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:20:10 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 45/47] dasd: add hyper PAV support to DASD device driver, part 1
Content-Disposition: inline; filename=144-hyperpav-1.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Stefan Weinhuber <wein@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Weinhuber <wein@de.ibm.com>

Parallel access volumes (PAV) is a storage server feature, that allows
to start multiple channel programs on the same DASD in parallel. It
defines alias devices which can be used as alternative paths to the
same disk. With the old base PAV support we only needed rudimentary
functionality in the DASD device driver. As the mapping between base
and alias devices was static, we just had to export an identifier
(uid) and could leave the combining of devices to external layers
like a device mapper multipath.
Now hyper PAV removes the requirement to dedicate alias devices to
specific base devices. Instead each alias devices can be combined with
multiple base device on a per request basis. This requires full
support by the DASD device driver as now each channel program itself
has to identify the target base device.
The changes to the dasd device driver and the ECKD discipline are:
- Separate subchannel device representation (dasd_device) from block
  device representation (dasd_block). Only base devices are block
  devices.
- Gather information about base and alias devices and possible
  combinations.
- For each request decide which dasd_device should be used (base or
  alias) and build specific channel program.
- Support summary unit checks, which allow the storage server to
  upgrade / downgrade between base and hyper PAV at runtime (support
  is mandatory).

Signed-off-by: Stefan Weinhuber <wein@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/Makefile        |    4 
 drivers/s390/block/dasd_3370_erp.c |   84 ---
 drivers/s390/block/dasd_3990_erp.c |  358 +++++---------
 drivers/s390/block/dasd_9336_erp.c |   41 -
 drivers/s390/block/dasd_9343_erp.c |   21 
 drivers/s390/block/dasd_alias.c    |  903 +++++++++++++++++++++++++++++++++++++
 drivers/s390/block/dasd_int.h      |  158 ++++--
 drivers/s390/block/dasd_ioctl.c    |  165 +++---
 drivers/s390/block/dasd_proc.c     |   21 
 9 files changed, 1231 insertions(+), 524 deletions(-)

Index: quilt-2.6/drivers/s390/block/dasd_3370_erp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_3370_erp.c
+++ /dev/null
@@ -1,84 +0,0 @@
-/*
- * File...........: linux/drivers/s390/block/dasd_3370_erp.c
- * Author(s)......: Holger Smolinski <Holger.Smolinski@de.ibm.com>
- * Bugreports.to..: <Linux390@de.ibm.com>
- * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 2000
- *
- */
-
-#define PRINTK_HEADER "dasd_erp(3370)"
-
-#include "dasd_int.h"
-
-
-/*
- * DASD_3370_ERP_EXAMINE
- *
- * DESCRIPTION
- *   Checks only for fatal/no/recover error.
- *   A detailed examination of the sense data is done later outside
- *   the interrupt handler.
- *
- *   The logic is based on the 'IBM 3880 Storage Control Reference' manual
- *   'Chapter 7. 3370 Sense Data'.
- *
- * RETURN VALUES
- *   dasd_era_none	no error
- *   dasd_era_fatal	for all fatal (unrecoverable errors)
- *   dasd_era_recover	for all others.
- */
-dasd_era_t
-dasd_3370_erp_examine(struct dasd_ccw_req * cqr, struct irb * irb)
-{
-	char *sense = irb->ecw;
-
-	/* check for successful execution first */
-	if (irb->scsw.cstat == 0x00 &&
-	    irb->scsw.dstat == (DEV_STAT_CHN_END | DEV_STAT_DEV_END))
-		return dasd_era_none;
-	if (sense[0] & 0x80) {	/* CMD reject */
-		return dasd_era_fatal;
-	}
-	if (sense[0] & 0x40) {	/* Drive offline */
-		return dasd_era_recover;
-	}
-	if (sense[0] & 0x20) {	/* Bus out parity */
-		return dasd_era_recover;
-	}
-	if (sense[0] & 0x10) {	/* equipment check */
-		if (sense[1] & 0x80) {
-			return dasd_era_fatal;
-		}
-		return dasd_era_recover;
-	}
-	if (sense[0] & 0x08) {	/* data check */
-		if (sense[1] & 0x80) {
-			return dasd_era_fatal;
-		}
-		return dasd_era_recover;
-	}
-	if (sense[0] & 0x04) {	/* overrun */
-		if (sense[1] & 0x80) {
-			return dasd_era_fatal;
-		}
-		return dasd_era_recover;
-	}
-	if (sense[1] & 0x40) {	/* invalid blocksize */
-		return dasd_era_fatal;
-	}
-	if (sense[1] & 0x04) {	/* file protected */
-		return dasd_era_recover;
-	}
-	if (sense[1] & 0x01) {	/* operation incomplete */
-		return dasd_era_recover;
-	}
-	if (sense[2] & 0x80) {	/* check data erroor */
-		return dasd_era_recover;
-	}
-	if (sense[2] & 0x10) {	/* Env. data present */
-		return dasd_era_recover;
-	}
-	/* examine the 24 byte sense data */
-	return dasd_era_recover;
-
-}				/* END dasd_3370_erp_examine */
Index: quilt-2.6/drivers/s390/block/dasd_3990_erp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_3990_erp.c
+++ quilt-2.6/drivers/s390/block/dasd_3990_erp.c
@@ -26,158 +26,6 @@ struct DCTL_data {
 
 /*
  *****************************************************************************
- * SECTION ERP EXAMINATION
- *****************************************************************************
- */
-
-/*
- * DASD_3990_ERP_EXAMINE_24
- *
- * DESCRIPTION
- *   Checks only for fatal (unrecoverable) error.
- *   A detailed examination of the sense data is done later outside
- *   the interrupt handler.
- *
- *   Each bit configuration leading to an action code 2 (Exit with
- *   programming error or unusual condition indication)
- *   are handled as fatal errors.
- *
- *   All other configurations are handled as recoverable errors.
- *
- * RETURN VALUES
- *   dasd_era_fatal	for all fatal (unrecoverable errors)
- *   dasd_era_recover	for all others.
- */
-static dasd_era_t
-dasd_3990_erp_examine_24(struct dasd_ccw_req * cqr, char *sense)
-{
-
-	struct dasd_device *device = cqr->device;
-
-	/* check for 'Command Reject' */
-	if ((sense[0] & SNS0_CMD_REJECT) &&
-	    (!(sense[2] & SNS2_ENV_DATA_PRESENT))) {
-
-		DEV_MESSAGE(KERN_ERR, device, "%s",
-			    "EXAMINE 24: Command Reject detected - "
-			    "fatal error");
-
-		return dasd_era_fatal;
-	}
-
-	/* check for 'Invalid Track Format' */
-	if ((sense[1] & SNS1_INV_TRACK_FORMAT) &&
-	    (!(sense[2] & SNS2_ENV_DATA_PRESENT))) {
-
-		DEV_MESSAGE(KERN_ERR, device, "%s",
-			    "EXAMINE 24: Invalid Track Format detected "
-			    "- fatal error");
-
-		return dasd_era_fatal;
-	}
-
-	/* check for 'No Record Found' */
-	if (sense[1] & SNS1_NO_REC_FOUND) {
-
-                /* FIXME: fatal error ?!? */
-		DEV_MESSAGE(KERN_ERR, device,
-			    "EXAMINE 24: No Record Found detected %s",
-                            device->state <= DASD_STATE_BASIC ?
-			    " " : "- fatal error");
-
-		return dasd_era_fatal;
-	}
-
-	/* return recoverable for all others */
-	return dasd_era_recover;
-}				/* END dasd_3990_erp_examine_24 */
-
-/*
- * DASD_3990_ERP_EXAMINE_32
- *
- * DESCRIPTION
- *   Checks only for fatal/no/recoverable error.
- *   A detailed examination of the sense data is done later outside
- *   the interrupt handler.
- *
- * RETURN VALUES
- *   dasd_era_none	no error
- *   dasd_era_fatal	for all fatal (unrecoverable errors)
- *   dasd_era_recover	for recoverable others.
- */
-static dasd_era_t
-dasd_3990_erp_examine_32(struct dasd_ccw_req * cqr, char *sense)
-{
-
-	struct dasd_device *device = cqr->device;
-
-	switch (sense[25]) {
-	case 0x00:
-		return dasd_era_none;
-
-	case 0x01:
-		DEV_MESSAGE(KERN_ERR, device, "%s", "EXAMINE 32: fatal error");
-
-		return dasd_era_fatal;
-
-	default:
-
-		return dasd_era_recover;
-	}
-
-}				/* end dasd_3990_erp_examine_32 */
-
-/*
- * DASD_3990_ERP_EXAMINE
- *
- * DESCRIPTION
- *   Checks only for fatal/no/recover error.
- *   A detailed examination of the sense data is done later outside
- *   the interrupt handler.
- *
- *   The logic is based on the 'IBM 3990 Storage Control  Reference' manual
- *   'Chapter 7. Error Recovery Procedures'.
- *
- * RETURN VALUES
- *   dasd_era_none	no error
- *   dasd_era_fatal	for all fatal (unrecoverable errors)
- *   dasd_era_recover	for all others.
- */
-dasd_era_t
-dasd_3990_erp_examine(struct dasd_ccw_req * cqr, struct irb * irb)
-{
-
-	char *sense = irb->ecw;
-	dasd_era_t era = dasd_era_recover;
-	struct dasd_device *device = cqr->device;
-
-	/* check for successful execution first */
-	if (irb->scsw.cstat == 0x00 &&
-	    irb->scsw.dstat == (DEV_STAT_CHN_END | DEV_STAT_DEV_END))
-		return dasd_era_none;
-
-	/* distinguish between 24 and 32 byte sense data */
-	if (sense[27] & DASD_SENSE_BIT_0) {
-
-		era = dasd_3990_erp_examine_24(cqr, sense);
-
-	} else {
-
-		era = dasd_3990_erp_examine_32(cqr, sense);
-
-	}
-
-	/* log the erp chain if fatal error occurred */
-	if ((era == dasd_era_fatal) && (device->state >= DASD_STATE_READY)) {
-		dasd_log_sense(cqr, irb);
-	}
-
-	return era;
-
-}				/* END dasd_3990_erp_examine */
-
-/*
- *****************************************************************************
  * SECTION ERP HANDLING
  *****************************************************************************
  */
@@ -206,7 +54,7 @@ dasd_3990_erp_cleanup(struct dasd_ccw_re
 {
 	struct dasd_ccw_req *cqr = erp->refers;
 
-	dasd_free_erp_request(erp, erp->device);
+	dasd_free_erp_request(erp, erp->memdev);
 	cqr->status = final_status;
 	return cqr;
 
@@ -224,15 +72,17 @@ static void
 dasd_3990_erp_block_queue(struct dasd_ccw_req * erp, int expires)
 {
 
-	struct dasd_device *device = erp->device;
+	struct dasd_device *device = erp->startdev;
+	unsigned long flags;
 
 	DEV_MESSAGE(KERN_INFO, device,
 		    "blocking request queue for %is", expires/HZ);
 
+	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
 	device->stopped |= DASD_STOPPED_PENDING;
-	erp->status = DASD_CQR_QUEUED;
-
-	dasd_set_timer(device, expires);
+	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
+	erp->status = DASD_CQR_FILLED;
+	dasd_block_set_timer(device->block, expires);
 }
 
 /*
@@ -251,7 +101,7 @@ static struct dasd_ccw_req *
 dasd_3990_erp_int_req(struct dasd_ccw_req * erp)
 {
 
-	struct dasd_device *device = erp->device;
+	struct dasd_device *device = erp->startdev;
 
 	/* first time set initial retry counter and erp_function */
 	/* and retry once without blocking queue		 */
@@ -292,11 +142,14 @@ dasd_3990_erp_int_req(struct dasd_ccw_re
 static void
 dasd_3990_erp_alternate_path(struct dasd_ccw_req * erp)
 {
-	struct dasd_device *device = erp->device;
+	struct dasd_device *device = erp->startdev;
 	__u8 opm;
+	unsigned long flags;
 
 	/* try alternate valid path */
+	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
 	opm = ccw_device_get_path_mask(device->cdev);
+	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
 	//FIXME: start with get_opm ?
 	if (erp->lpm == 0)
 		erp->lpm = LPM_ANYPATH & ~(erp->irb.esw.esw0.sublog.lpum);
@@ -309,9 +162,8 @@ dasd_3990_erp_alternate_path(struct dasd
 			    "try alternate lpm=%x (lpum=%x / opm=%x)",
 			    erp->lpm, erp->irb.esw.esw0.sublog.lpum, opm);
 
-		/* reset status to queued to handle the request again... */
-		if (erp->status > DASD_CQR_QUEUED)
-			erp->status = DASD_CQR_QUEUED;
+		/* reset status to submit the request again... */
+		erp->status = DASD_CQR_FILLED;
 		erp->retries = 1;
 	} else {
 		DEV_MESSAGE(KERN_ERR, device,
@@ -320,8 +172,7 @@ dasd_3990_erp_alternate_path(struct dasd
 			    erp->irb.esw.esw0.sublog.lpum, opm);
 
 		/* post request with permanent error */
-		if (erp->status > DASD_CQR_QUEUED)
-			erp->status = DASD_CQR_FAILED;
+		erp->status = DASD_CQR_FAILED;
 	}
 }				/* end dasd_3990_erp_alternate_path */
 
@@ -344,14 +195,14 @@ static struct dasd_ccw_req *
 dasd_3990_erp_DCTL(struct dasd_ccw_req * erp, char modifier)
 {
 
-	struct dasd_device *device = erp->device;
+	struct dasd_device *device = erp->startdev;
 	struct DCTL_data *DCTL_data;
 	struct ccw1 *ccw;
 	struct dasd_ccw_req *dctl_cqr;
 
 	dctl_cqr = dasd_alloc_erp_request((char *) &erp->magic, 1,
-					  sizeof (struct DCTL_data),
-					  erp->device);
+					  sizeof(struct DCTL_data),
+					  device);
 	if (IS_ERR(dctl_cqr)) {
 		DEV_MESSAGE(KERN_ERR, device, "%s",
 			    "Unable to allocate DCTL-CQR");
@@ -365,13 +216,14 @@ dasd_3990_erp_DCTL(struct dasd_ccw_req *
 	DCTL_data->modifier = modifier;
 
 	ccw = dctl_cqr->cpaddr;
-	memset(ccw, 0, sizeof (struct ccw1));
+	memset(ccw, 0, sizeof(struct ccw1));
 	ccw->cmd_code = CCW_CMD_DCTL;
 	ccw->count = 4;
 	ccw->cda = (__u32)(addr_t) DCTL_data;
 	dctl_cqr->function = dasd_3990_erp_DCTL;
 	dctl_cqr->refers = erp;
-	dctl_cqr->device = erp->device;
+	dctl_cqr->startdev = device;
+	dctl_cqr->memdev = device;
 	dctl_cqr->magic = erp->magic;
 	dctl_cqr->expires = 5 * 60 * HZ;
 	dctl_cqr->retries = 2;
@@ -435,7 +287,7 @@ static struct dasd_ccw_req *
 dasd_3990_erp_action_4(struct dasd_ccw_req * erp, char *sense)
 {
 
-	struct dasd_device *device = erp->device;
+	struct dasd_device *device = erp->startdev;
 
 	/* first time set initial retry counter and erp_function    */
 	/* and retry once without waiting for state change pending  */
@@ -472,7 +324,7 @@ dasd_3990_erp_action_4(struct dasd_ccw_r
 				     "redriving request immediately, "
 				     "%d retries left",
 				     erp->retries);
-			erp->status = DASD_CQR_QUEUED;
+			erp->status = DASD_CQR_FILLED;
 		}
 	}
 
@@ -530,7 +382,7 @@ static void
 dasd_3990_handle_env_data(struct dasd_ccw_req * erp, char *sense)
 {
 
-	struct dasd_device *device = erp->device;
+	struct dasd_device *device = erp->startdev;
 	char msg_format = (sense[7] & 0xF0);
 	char msg_no = (sense[7] & 0x0F);
 
@@ -1157,7 +1009,7 @@ static struct dasd_ccw_req *
 dasd_3990_erp_com_rej(struct dasd_ccw_req * erp, char *sense)
 {
 
-	struct dasd_device *device = erp->device;
+	struct dasd_device *device = erp->startdev;
 
 	erp->function = dasd_3990_erp_com_rej;
 
@@ -1198,7 +1050,7 @@ static struct dasd_ccw_req *
 dasd_3990_erp_bus_out(struct dasd_ccw_req * erp)
 {
 
-	struct dasd_device *device = erp->device;
+	struct dasd_device *device = erp->startdev;
 
 	/* first time set initial retry counter and erp_function */
 	/* and retry once without blocking queue		 */
@@ -1237,7 +1089,7 @@ static struct dasd_ccw_req *
 dasd_3990_erp_equip_check(struct dasd_ccw_req * erp, char *sense)
 {
 
-	struct dasd_device *device = erp->device;
+	struct dasd_device *device = erp->startdev;
 
 	erp->function = dasd_3990_erp_equip_check;
 
@@ -1279,7 +1131,6 @@ dasd_3990_erp_equip_check(struct dasd_cc
 
 		erp = dasd_3990_erp_action_5(erp);
 	}
-
 	return erp;
 
 }				/* end dasd_3990_erp_equip_check */
@@ -1299,7 +1150,7 @@ static struct dasd_ccw_req *
 dasd_3990_erp_data_check(struct dasd_ccw_req * erp, char *sense)
 {
 
-	struct dasd_device *device = erp->device;
+	struct dasd_device *device = erp->startdev;
 
 	erp->function = dasd_3990_erp_data_check;
 
@@ -1358,7 +1209,7 @@ static struct dasd_ccw_req *
 dasd_3990_erp_overrun(struct dasd_ccw_req * erp, char *sense)
 {
 
-	struct dasd_device *device = erp->device;
+	struct dasd_device *device = erp->startdev;
 
 	erp->function = dasd_3990_erp_overrun;
 
@@ -1387,7 +1238,7 @@ static struct dasd_ccw_req *
 dasd_3990_erp_inv_format(struct dasd_ccw_req * erp, char *sense)
 {
 
-	struct dasd_device *device = erp->device;
+	struct dasd_device *device = erp->startdev;
 
 	erp->function = dasd_3990_erp_inv_format;
 
@@ -1403,8 +1254,7 @@ dasd_3990_erp_inv_format(struct dasd_ccw
 
 	} else {
 		DEV_MESSAGE(KERN_ERR, device, "%s",
-			    "Invalid Track Format - Fatal error should have "
-			    "been handled within the interrupt handler");
+			    "Invalid Track Format - Fatal error");
 
 		erp = dasd_3990_erp_cleanup(erp, DASD_CQR_FAILED);
 	}
@@ -1428,7 +1278,7 @@ static struct dasd_ccw_req *
 dasd_3990_erp_EOC(struct dasd_ccw_req * default_erp, char *sense)
 {
 
-	struct dasd_device *device = default_erp->device;
+	struct dasd_device *device = default_erp->startdev;
 
 	DEV_MESSAGE(KERN_ERR, device, "%s",
 		    "End-of-Cylinder - must never happen");
@@ -1453,7 +1303,7 @@ static struct dasd_ccw_req *
 dasd_3990_erp_env_data(struct dasd_ccw_req * erp, char *sense)
 {
 
-	struct dasd_device *device = erp->device;
+	struct dasd_device *device = erp->startdev;
 
 	erp->function = dasd_3990_erp_env_data;
 
@@ -1463,11 +1313,9 @@ dasd_3990_erp_env_data(struct dasd_ccw_r
 
 	/* don't retry on disabled interface */
 	if (sense[7] != 0x0F) {
-
 		erp = dasd_3990_erp_action_4(erp, sense);
 	} else {
-
-		erp = dasd_3990_erp_cleanup(erp, DASD_CQR_IN_IO);
+		erp->status = DASD_CQR_FILLED;
 	}
 
 	return erp;
@@ -1490,11 +1338,10 @@ static struct dasd_ccw_req *
 dasd_3990_erp_no_rec(struct dasd_ccw_req * default_erp, char *sense)
 {
 
-	struct dasd_device *device = default_erp->device;
+	struct dasd_device *device = default_erp->startdev;
 
 	DEV_MESSAGE(KERN_ERR, device, "%s",
-		    "No Record Found - Fatal error should "
-		    "have been handled within the interrupt handler");
+		    "No Record Found - Fatal error ");
 
 	return dasd_3990_erp_cleanup(default_erp, DASD_CQR_FAILED);
 
@@ -1517,7 +1364,7 @@ static struct dasd_ccw_req *
 dasd_3990_erp_file_prot(struct dasd_ccw_req * erp)
 {
 
-	struct dasd_device *device = erp->device;
+	struct dasd_device *device = erp->startdev;
 
 	DEV_MESSAGE(KERN_ERR, device, "%s", "File Protected");
 
@@ -1526,6 +1373,43 @@ dasd_3990_erp_file_prot(struct dasd_ccw_
 }				/* end dasd_3990_erp_file_prot */
 
 /*
+ * DASD_3990_ERP_INSPECT_ALIAS
+ *
+ * DESCRIPTION
+ *   Checks if the original request was started on an alias device.
+ *   If yes, it modifies the original and the erp request so that
+ *   the erp request can be started on a base device.
+ *
+ * PARAMETER
+ *   erp		pointer to the currently created default ERP
+ *
+ * RETURN VALUES
+ *   erp		pointer to the modified ERP, or NULL
+ */
+
+static struct dasd_ccw_req *dasd_3990_erp_inspect_alias(
+	struct dasd_ccw_req *erp)
+{
+	struct dasd_ccw_req *cqr = erp->refers;
+
+	if (cqr->block &&
+	    (cqr->block->base != cqr->startdev)) {
+		if (cqr->startdev->features & DASD_FEATURE_ERPLOG) {
+			DEV_MESSAGE(KERN_ERR, cqr->startdev,
+				    "ERP on alias device for request %p,"
+				    " recover on base device %s", cqr,
+				    cqr->block->base->cdev->dev.bus_id);
+		}
+		dasd_eckd_reset_ccw_to_base_io(cqr);
+		erp->startdev = cqr->block->base;
+		erp->function = dasd_3990_erp_inspect_alias;
+		return erp;
+	} else
+		return NULL;
+}
+
+
+/*
  * DASD_3990_ERP_INSPECT_24
  *
  * DESCRIPTION
@@ -1623,7 +1507,7 @@ static struct dasd_ccw_req *
 dasd_3990_erp_action_10_32(struct dasd_ccw_req * erp, char *sense)
 {
 
-	struct dasd_device *device = erp->device;
+	struct dasd_device *device = erp->startdev;
 
 	erp->retries = 256;
 	erp->function = dasd_3990_erp_action_10_32;
@@ -1657,13 +1541,14 @@ static struct dasd_ccw_req *
 dasd_3990_erp_action_1B_32(struct dasd_ccw_req * default_erp, char *sense)
 {
 
-	struct dasd_device *device = default_erp->device;
+	struct dasd_device *device = default_erp->startdev;
 	__u32 cpa = 0;
 	struct dasd_ccw_req *cqr;
 	struct dasd_ccw_req *erp;
 	struct DE_eckd_data *DE_data;
+	struct PFX_eckd_data *PFX_data;
 	char *LO_data;		/* LO_eckd_data_t */
-	struct ccw1 *ccw;
+	struct ccw1 *ccw, *oldccw;
 
 	DEV_MESSAGE(KERN_DEBUG, device, "%s",
 		    "Write not finished because of unexpected condition");
@@ -1702,8 +1587,8 @@ dasd_3990_erp_action_1B_32(struct dasd_c
 	/* Build new ERP request including DE/LO */
 	erp = dasd_alloc_erp_request((char *) &cqr->magic,
 				     2 + 1,/* DE/LO + TIC */
-				     sizeof (struct DE_eckd_data) +
-				     sizeof (struct LO_eckd_data), device);
+				     sizeof(struct DE_eckd_data) +
+				     sizeof(struct LO_eckd_data), device);
 
 	if (IS_ERR(erp)) {
 		DEV_MESSAGE(KERN_ERR, device, "%s", "Unable to allocate ERP");
@@ -1712,10 +1597,16 @@ dasd_3990_erp_action_1B_32(struct dasd_c
 
 	/* use original DE */
 	DE_data = erp->data;
-	memcpy(DE_data, cqr->data, sizeof (struct DE_eckd_data));
+	oldccw = cqr->cpaddr;
+	if (oldccw->cmd_code == DASD_ECKD_CCW_PFX) {
+		PFX_data = cqr->data;
+		memcpy(DE_data, &PFX_data->define_extend,
+		       sizeof(struct DE_eckd_data));
+	} else
+		memcpy(DE_data, cqr->data, sizeof(struct DE_eckd_data));
 
 	/* create LO */
-	LO_data = erp->data + sizeof (struct DE_eckd_data);
+	LO_data = erp->data + sizeof(struct DE_eckd_data);
 
 	if ((sense[3] == 0x01) && (LO_data[1] & 0x01)) {
 
@@ -1748,7 +1639,7 @@ dasd_3990_erp_action_1B_32(struct dasd_c
 
 	/* create DE ccw */
 	ccw = erp->cpaddr;
-	memset(ccw, 0, sizeof (struct ccw1));
+	memset(ccw, 0, sizeof(struct ccw1));
 	ccw->cmd_code = DASD_ECKD_CCW_DEFINE_EXTENT;
 	ccw->flags = CCW_FLAG_CC;
 	ccw->count = 16;
@@ -1756,7 +1647,7 @@ dasd_3990_erp_action_1B_32(struct dasd_c
 
 	/* create LO ccw */
 	ccw++;
-	memset(ccw, 0, sizeof (struct ccw1));
+	memset(ccw, 0, sizeof(struct ccw1));
 	ccw->cmd_code = DASD_ECKD_CCW_LOCATE_RECORD;
 	ccw->flags = CCW_FLAG_CC;
 	ccw->count = 16;
@@ -1770,7 +1661,8 @@ dasd_3990_erp_action_1B_32(struct dasd_c
 	/* fill erp related fields */
 	erp->function = dasd_3990_erp_action_1B_32;
 	erp->refers = default_erp->refers;
-	erp->device = device;
+	erp->startdev = device;
+	erp->memdev = device;
 	erp->magic = default_erp->magic;
 	erp->expires = 0;
 	erp->retries = 256;
@@ -1803,7 +1695,7 @@ static struct dasd_ccw_req *
 dasd_3990_update_1B(struct dasd_ccw_req * previous_erp, char *sense)
 {
 
-	struct dasd_device *device = previous_erp->device;
+	struct dasd_device *device = previous_erp->startdev;
 	__u32 cpa = 0;
 	struct dasd_ccw_req *cqr;
 	struct dasd_ccw_req *erp;
@@ -1827,7 +1719,7 @@ dasd_3990_update_1B(struct dasd_ccw_req 
 		DEV_MESSAGE(KERN_DEBUG, device, "%s",
 			    "Imprecise ending is set - just retry");
 
-		previous_erp->status = DASD_CQR_QUEUED;
+		previous_erp->status = DASD_CQR_FILLED;
 
 		return previous_erp;
 	}
@@ -1850,7 +1742,7 @@ dasd_3990_update_1B(struct dasd_ccw_req 
 	erp = previous_erp;
 
 	/* update the LO with the new returned sense data  */
-	LO_data = erp->data + sizeof (struct DE_eckd_data);
+	LO_data = erp->data + sizeof(struct DE_eckd_data);
 
 	if ((sense[3] == 0x01) && (LO_data[1] & 0x01)) {
 
@@ -1889,7 +1781,7 @@ dasd_3990_update_1B(struct dasd_ccw_req 
 	ccw++;			/* addr of TIC ccw */
 	ccw->cda = cpa;
 
-	erp->status = DASD_CQR_QUEUED;
+	erp->status = DASD_CQR_FILLED;
 
 	return erp;
 
@@ -1968,9 +1860,7 @@ dasd_3990_erp_compound_path(struct dasd_
 			 * try further actions. */
 
 			erp->lpm = 0;
-
-			erp->status = DASD_CQR_ERROR;
-
+			erp->status = DASD_CQR_NEED_ERP;
 		}
 	}
 
@@ -2047,7 +1937,7 @@ dasd_3990_erp_compound_config(struct das
 	if ((sense[25] & DASD_SENSE_BIT_1) && (sense[26] & DASD_SENSE_BIT_2)) {
 
 		/* set to suspended duplex state then restart */
-		struct dasd_device *device = erp->device;
+		struct dasd_device *device = erp->startdev;
 
 		DEV_MESSAGE(KERN_ERR, device, "%s",
 			    "Set device to suspended duplex state should be "
@@ -2081,28 +1971,26 @@ dasd_3990_erp_compound(struct dasd_ccw_r
 {
 
 	if ((erp->function == dasd_3990_erp_compound_retry) &&
-	    (erp->status == DASD_CQR_ERROR)) {
+	    (erp->status == DASD_CQR_NEED_ERP)) {
 
 		dasd_3990_erp_compound_path(erp, sense);
 	}
 
 	if ((erp->function == dasd_3990_erp_compound_path) &&
-	    (erp->status == DASD_CQR_ERROR)) {
+	    (erp->status == DASD_CQR_NEED_ERP)) {
 
 		erp = dasd_3990_erp_compound_code(erp, sense);
 	}
 
 	if ((erp->function == dasd_3990_erp_compound_code) &&
-	    (erp->status == DASD_CQR_ERROR)) {
+	    (erp->status == DASD_CQR_NEED_ERP)) {
 
 		dasd_3990_erp_compound_config(erp, sense);
 	}
 
 	/* if no compound action ERP specified, the request failed */
-	if (erp->status == DASD_CQR_ERROR) {
-
+	if (erp->status == DASD_CQR_NEED_ERP)
 		erp->status = DASD_CQR_FAILED;
-	}
 
 	return erp;
 
@@ -2127,7 +2015,7 @@ static struct dasd_ccw_req *
 dasd_3990_erp_inspect_32(struct dasd_ccw_req * erp, char *sense)
 {
 
-	struct dasd_device *device = erp->device;
+	struct dasd_device *device = erp->startdev;
 
 	erp->function = dasd_3990_erp_inspect_32;
 
@@ -2149,8 +2037,7 @@ dasd_3990_erp_inspect_32(struct dasd_ccw
 
 		case 0x01:	/* fatal error */
 			DEV_MESSAGE(KERN_ERR, device, "%s",
-				    "Fatal error should have been "
-				    "handled within the interrupt handler");
+				    "Retry not recommended - Fatal error");
 
 			erp = dasd_3990_erp_cleanup(erp, DASD_CQR_FAILED);
 			break;
@@ -2253,6 +2140,11 @@ dasd_3990_erp_inspect(struct dasd_ccw_re
 	/* already set up new ERP !			      */
 	char *sense = erp->refers->irb.ecw;
 
+	/* if this problem occured on an alias retry on base */
+	erp_new = dasd_3990_erp_inspect_alias(erp);
+	if (erp_new)
+		return erp_new;
+
 	/* distinguish between 24 and 32 byte sense data */
 	if (sense[27] & DASD_SENSE_BIT_0) {
 
@@ -2287,13 +2179,13 @@ static struct dasd_ccw_req *
 dasd_3990_erp_add_erp(struct dasd_ccw_req * cqr)
 {
 
-	struct dasd_device *device = cqr->device;
+	struct dasd_device *device = cqr->startdev;
 	struct ccw1 *ccw;
 
 	/* allocate additional request block */
 	struct dasd_ccw_req *erp;
 
-	erp = dasd_alloc_erp_request((char *) &cqr->magic, 2, 0, cqr->device);
+	erp = dasd_alloc_erp_request((char *) &cqr->magic, 2, 0, device);
 	if (IS_ERR(erp)) {
                 if (cqr->retries <= 0) {
 		        DEV_MESSAGE(KERN_ERR, device, "%s",
@@ -2305,7 +2197,7 @@ dasd_3990_erp_add_erp(struct dasd_ccw_re
                                      "Unable to allocate ERP request "
 				     "(%i retries left)",
                                      cqr->retries);
-			dasd_set_timer(device, (HZ << 3));
+			dasd_block_set_timer(device->block, (HZ << 3));
                 }
 		return cqr;
 	}
@@ -2319,7 +2211,9 @@ dasd_3990_erp_add_erp(struct dasd_ccw_re
 	ccw->cda      = (long)(cqr->cpaddr);
 	erp->function = dasd_3990_erp_add_erp;
 	erp->refers   = cqr;
-	erp->device   = cqr->device;
+	erp->startdev = device;
+	erp->memdev   = device;
+	erp->block    = cqr->block;
 	erp->magic    = cqr->magic;
 	erp->expires  = 0;
 	erp->retries  = 256;
@@ -2466,7 +2360,7 @@ static struct dasd_ccw_req *
 dasd_3990_erp_further_erp(struct dasd_ccw_req *erp)
 {
 
-	struct dasd_device *device = erp->device;
+	struct dasd_device *device = erp->startdev;
 	char *sense = erp->irb.ecw;
 
 	/* check for 24 byte sense ERP */
@@ -2557,7 +2451,7 @@ dasd_3990_erp_handle_match_erp(struct da
 			       struct dasd_ccw_req *erp)
 {
 
-	struct dasd_device *device = erp_head->device;
+	struct dasd_device *device = erp_head->startdev;
 	struct dasd_ccw_req *erp_done = erp_head;	/* finished req */
 	struct dasd_ccw_req *erp_free = NULL;	/* req to be freed */
 
@@ -2569,13 +2463,13 @@ dasd_3990_erp_handle_match_erp(struct da
 			      "original request was lost\n");
 
 		/* remove the request from the device queue */
-		list_del(&erp_done->list);
+		list_del(&erp_done->blocklist);
 
 		erp_free = erp_done;
 		erp_done = erp_done->refers;
 
 		/* free the finished erp request */
-		dasd_free_erp_request(erp_free, erp_free->device);
+		dasd_free_erp_request(erp_free, erp_free->memdev);
 
 	}			/* end while */
 
@@ -2603,7 +2497,7 @@ dasd_3990_erp_handle_match_erp(struct da
 				    erp->retries, erp);
 
 			/* handle the request again... */
-			erp->status = DASD_CQR_QUEUED;
+			erp->status = DASD_CQR_FILLED;
 		}
 
 	} else {
@@ -2636,9 +2530,8 @@ dasd_3990_erp_handle_match_erp(struct da
 struct dasd_ccw_req *
 dasd_3990_erp_action(struct dasd_ccw_req * cqr)
 {
-
 	struct dasd_ccw_req *erp = NULL;
-	struct dasd_device *device = cqr->device;
+	struct dasd_device *device = cqr->startdev;
 	struct dasd_ccw_req *temp_erp = NULL;
 
 	if (device->features & DASD_FEATURE_ERPLOG) {
@@ -2704,10 +2597,11 @@ dasd_3990_erp_action(struct dasd_ccw_req
 		}
 	}
 
-	/* enqueue added ERP request */
-	if (erp->status == DASD_CQR_FILLED) {
-		erp->status = DASD_CQR_QUEUED;
-		list_add(&erp->list, &device->ccw_queue);
+	/* enqueue ERP request if it's a new one */
+	if (list_empty(&erp->blocklist)) {
+		cqr->status = DASD_CQR_IN_ERP;
+		/* add erp request before the cqr */
+		list_add_tail(&erp->blocklist, &cqr->blocklist);
 	}
 
 	return erp;
Index: quilt-2.6/drivers/s390/block/dasd_9336_erp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_9336_erp.c
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- * File...........: linux/drivers/s390/block/dasd_9336_erp.c
- * Author(s)......: Holger Smolinski <Holger.Smolinski@de.ibm.com>
- * Bugreports.to..: <Linux390@de.ibm.com>
- * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 2000
- *
- */
-
-#define PRINTK_HEADER "dasd_erp(9336)"
-
-#include "dasd_int.h"
-
-
-/*
- * DASD_9336_ERP_EXAMINE
- *
- * DESCRIPTION
- *   Checks only for fatal/no/recover error.
- *   A detailed examination of the sense data is done later outside
- *   the interrupt handler.
- *
- *   The logic is based on the 'IBM 3880 Storage Control Reference' manual
- *   'Chapter 7. 9336 Sense Data'.
- *
- * RETURN VALUES
- *   dasd_era_none	no error
- *   dasd_era_fatal	for all fatal (unrecoverable errors)
- *   dasd_era_recover	for all others.
- */
-dasd_era_t
-dasd_9336_erp_examine(struct dasd_ccw_req * cqr, struct irb * irb)
-{
-	/* check for successful execution first */
-	if (irb->scsw.cstat == 0x00 &&
-	    irb->scsw.dstat == (DEV_STAT_CHN_END | DEV_STAT_DEV_END))
-		return dasd_era_none;
-
-	/* examine the 24 byte sense data */
-	return dasd_era_recover;
-
-}				/* END dasd_9336_erp_examine */
Index: quilt-2.6/drivers/s390/block/dasd_9343_erp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_9343_erp.c
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * File...........: linux/drivers/s390/block/dasd_9345_erp.c
- * Author(s)......: Holger Smolinski <Holger.Smolinski@de.ibm.com>
- * Bugreports.to..: <Linux390@de.ibm.com>
- * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 2000
- *
- */
-
-#define PRINTK_HEADER "dasd_erp(9343)"
-
-#include "dasd_int.h"
-
-dasd_era_t
-dasd_9343_erp_examine(struct dasd_ccw_req * cqr, struct irb * irb)
-{
-	if (irb->scsw.cstat == 0x00 &&
-	    irb->scsw.dstat == (DEV_STAT_CHN_END | DEV_STAT_DEV_END))
-		return dasd_era_none;
-
-	return dasd_era_recover;
-}
Index: quilt-2.6/drivers/s390/block/dasd_alias.c
===================================================================
--- /dev/null
+++ quilt-2.6/drivers/s390/block/dasd_alias.c
@@ -0,0 +1,903 @@
+/*
+ * PAV alias management for the DASD ECKD discipline
+ *
+ * Copyright IBM Corporation, IBM Deutschland Entwicklung GmbH, 2007
+ * Author(s): Stefan Weinhuber <wein@de.ibm.com>
+ */
+
+#include <linux/list.h>
+#include <asm/ebcdic.h>
+#include "dasd_int.h"
+#include "dasd_eckd.h"
+
+#ifdef PRINTK_HEADER
+#undef PRINTK_HEADER
+#endif				/* PRINTK_HEADER */
+#define PRINTK_HEADER "dasd(eckd):"
+
+
+/*
+ * General concept of alias management:
+ * - PAV and DASD alias management is specific to the eckd discipline.
+ * - A device is connected to an lcu as long as the device exists.
+ *   dasd_alias_make_device_known_to_lcu will be called wenn the
+ *   device is checked by the eckd discipline and
+ *   dasd_alias_disconnect_device_from_lcu will be called
+ *   befor the device is deleted.
+ * - The dasd_alias_add_device / dasd_alias_remove_device
+ *   functions mark the point when a device is 'ready for service'.
+ * - A summary unit check is a rare occasion, but it is mandatory to
+ *   support it. It requires some complex recovery actions before the
+ *   devices can be used again (see dasd_alias_handle_summary_unit_check).
+ * - dasd_alias_get_start_dev will find an alias device that can be used
+ *   instead of the base device and does some (very simple) load balancing.
+ *   This is the function that get's called for each I/O, so when improving
+ *   something, this function should get faster or better, the rest has just
+ *   to be correct.
+ */
+
+
+static void summary_unit_check_handling_work(struct work_struct *);
+static void lcu_update_work(struct work_struct *);
+static int _schedule_lcu_update(struct alias_lcu *, struct dasd_device *);
+
+static struct alias_root aliastree = {
+	.serverlist = LIST_HEAD_INIT(aliastree.serverlist),
+	.lock = __SPIN_LOCK_UNLOCKED(aliastree.lock),
+};
+
+static struct alias_server *_find_server(struct dasd_uid *uid)
+{
+	struct alias_server *pos;
+	list_for_each_entry(pos, &aliastree.serverlist, server) {
+		if (!strncmp(pos->uid.vendor, uid->vendor,
+			     sizeof(uid->vendor))
+		    && !strncmp(pos->uid.serial, uid->serial,
+				sizeof(uid->serial)))
+			return pos;
+	};
+	return NULL;
+}
+
+static struct alias_lcu *_find_lcu(struct alias_server *server,
+				   struct dasd_uid *uid)
+{
+	struct alias_lcu *pos;
+	list_for_each_entry(pos, &server->lculist, lcu) {
+		if (pos->uid.ssid == uid->ssid)
+			return pos;
+	};
+	return NULL;
+}
+
+static struct alias_pav_group *_find_group(struct alias_lcu *lcu,
+					   struct dasd_uid *uid)
+{
+	struct alias_pav_group *pos;
+	__u8 search_unit_addr;
+
+	/* for hyper pav there is only one group */
+	if (lcu->pav == HYPER_PAV) {
+		if (list_empty(&lcu->grouplist))
+			return NULL;
+		else
+			return list_first_entry(&lcu->grouplist,
+						struct alias_pav_group, group);
+	}
+
+	/* for base pav we have to find the group that matches the base */
+	if (uid->type == UA_BASE_DEVICE)
+		search_unit_addr = uid->real_unit_addr;
+	else
+		search_unit_addr = uid->base_unit_addr;
+	list_for_each_entry(pos, &lcu->grouplist, group) {
+		if (pos->uid.base_unit_addr == search_unit_addr)
+			return pos;
+	};
+	return NULL;
+}
+
+static struct alias_server *_allocate_server(struct dasd_uid *uid)
+{
+	struct alias_server *server;
+
+	server = kzalloc(sizeof(*server), GFP_KERNEL);
+	if (!server)
+		return ERR_PTR(-ENOMEM);
+	memcpy(server->uid.vendor, uid->vendor, sizeof(uid->vendor));
+	memcpy(server->uid.serial, uid->serial, sizeof(uid->serial));
+	INIT_LIST_HEAD(&server->server);
+	INIT_LIST_HEAD(&server->lculist);
+	return server;
+}
+
+static void _free_server(struct alias_server *server)
+{
+	kfree(server);
+}
+
+static struct alias_lcu *_allocate_lcu(struct dasd_uid *uid)
+{
+	struct alias_lcu *lcu;
+
+	lcu = kzalloc(sizeof(*lcu), GFP_KERNEL);
+	if (!lcu)
+		return ERR_PTR(-ENOMEM);
+	lcu->uac = kzalloc(sizeof(*(lcu->uac)), GFP_KERNEL | GFP_DMA);
+	if (!lcu->uac)
+		goto out_err1;
+	lcu->rsu_cqr = kzalloc(sizeof(*lcu->rsu_cqr), GFP_KERNEL | GFP_DMA);
+	if (!lcu->rsu_cqr)
+		goto out_err2;
+	lcu->rsu_cqr->cpaddr = kzalloc(sizeof(struct ccw1),
+				       GFP_KERNEL | GFP_DMA);
+	if (!lcu->rsu_cqr->cpaddr)
+		goto out_err3;
+	lcu->rsu_cqr->data = kzalloc(16, GFP_KERNEL | GFP_DMA);
+	if (!lcu->rsu_cqr->data)
+		goto out_err4;
+
+	memcpy(lcu->uid.vendor, uid->vendor, sizeof(uid->vendor));
+	memcpy(lcu->uid.serial, uid->serial, sizeof(uid->serial));
+	lcu->uid.ssid = uid->ssid;
+	lcu->pav = NO_PAV;
+	lcu->flags = NEED_UAC_UPDATE | UPDATE_PENDING;
+	INIT_LIST_HEAD(&lcu->lcu);
+	INIT_LIST_HEAD(&lcu->inactive_devices);
+	INIT_LIST_HEAD(&lcu->active_devices);
+	INIT_LIST_HEAD(&lcu->grouplist);
+	INIT_WORK(&lcu->suc_data.worker, summary_unit_check_handling_work);
+	INIT_DELAYED_WORK(&lcu->ruac_data.dwork, lcu_update_work);
+	spin_lock_init(&lcu->lock);
+	return lcu;
+
+out_err4:
+	kfree(lcu->rsu_cqr->cpaddr);
+out_err3:
+	kfree(lcu->rsu_cqr);
+out_err2:
+	kfree(lcu->uac);
+out_err1:
+	kfree(lcu);
+	return ERR_PTR(-ENOMEM);
+}
+
+static void _free_lcu(struct alias_lcu *lcu)
+{
+	kfree(lcu->rsu_cqr->data);
+	kfree(lcu->rsu_cqr->cpaddr);
+	kfree(lcu->rsu_cqr);
+	kfree(lcu->uac);
+	kfree(lcu);
+}
+
+/*
+ * This is the function that will allocate all the server and lcu data,
+ * so this function must be called first for a new device.
+ * If the return value is 1, the lcu was already known before, if it
+ * is 0, this is a new lcu.
+ * Negative return code indicates that something went wrong (e.g. -ENOMEM)
+ */
+int dasd_alias_make_device_known_to_lcu(struct dasd_device *device)
+{
+	struct dasd_eckd_private *private;
+	unsigned long flags;
+	struct alias_server *server, *newserver;
+	struct alias_lcu *lcu, *newlcu;
+	int is_lcu_known;
+	struct dasd_uid *uid;
+
+	private = (struct dasd_eckd_private *) device->private;
+	uid = &private->uid;
+	spin_lock_irqsave(&aliastree.lock, flags);
+	is_lcu_known = 1;
+	server = _find_server(uid);
+	if (!server) {
+		spin_unlock_irqrestore(&aliastree.lock, flags);
+		newserver = _allocate_server(uid);
+		if (IS_ERR(newserver))
+			return PTR_ERR(newserver);
+		spin_lock_irqsave(&aliastree.lock, flags);
+		server = _find_server(uid);
+		if (!server) {
+			list_add(&newserver->server, &aliastree.serverlist);
+			server = newserver;
+			is_lcu_known = 0;
+		} else {
+			/* someone was faster */
+			_free_server(newserver);
+		}
+	}
+
+	lcu = _find_lcu(server, uid);
+	if (!lcu) {
+		spin_unlock_irqrestore(&aliastree.lock, flags);
+		newlcu = _allocate_lcu(uid);
+		if (IS_ERR(newlcu))
+			return PTR_ERR(lcu);
+		spin_lock_irqsave(&aliastree.lock, flags);
+		lcu = _find_lcu(server, uid);
+		if (!lcu) {
+			list_add(&newlcu->lcu, &server->lculist);
+			lcu = newlcu;
+			is_lcu_known = 0;
+		} else {
+			/* someone was faster */
+			_free_lcu(newlcu);
+		}
+		is_lcu_known = 0;
+	}
+	spin_lock(&lcu->lock);
+	list_add(&device->alias_list, &lcu->inactive_devices);
+	private->lcu = lcu;
+	spin_unlock(&lcu->lock);
+	spin_unlock_irqrestore(&aliastree.lock, flags);
+
+	return is_lcu_known;
+}
+
+/*
+ * This function removes a device from the scope of alias management.
+ * The complicated part is to make sure that it is not in use by
+ * any of the workers. If necessary cancel the work.
+ */
+void dasd_alias_disconnect_device_from_lcu(struct dasd_device *device)
+{
+	struct dasd_eckd_private *private;
+	unsigned long flags;
+	struct alias_lcu *lcu;
+	struct alias_server *server;
+	int was_pending;
+
+	private = (struct dasd_eckd_private *) device->private;
+	lcu = private->lcu;
+	spin_lock_irqsave(&lcu->lock, flags);
+	list_del_init(&device->alias_list);
+	/* make sure that the workers don't use this device */
+	if (device == lcu->suc_data.device) {
+		spin_unlock_irqrestore(&lcu->lock, flags);
+		cancel_work_sync(&lcu->suc_data.worker);
+		spin_lock_irqsave(&lcu->lock, flags);
+		if (device == lcu->suc_data.device)
+			lcu->suc_data.device = NULL;
+	}
+	was_pending = 0;
+	if (device == lcu->ruac_data.device) {
+		spin_unlock_irqrestore(&lcu->lock, flags);
+		was_pending = 1;
+		cancel_delayed_work_sync(&lcu->ruac_data.dwork);
+		spin_lock_irqsave(&lcu->lock, flags);
+		if (device == lcu->ruac_data.device)
+			lcu->ruac_data.device = NULL;
+	}
+	private->lcu = NULL;
+	spin_unlock_irqrestore(&lcu->lock, flags);
+
+	spin_lock_irqsave(&aliastree.lock, flags);
+	spin_lock(&lcu->lock);
+	if (list_empty(&lcu->grouplist) &&
+	    list_empty(&lcu->active_devices) &&
+	    list_empty(&lcu->inactive_devices)) {
+		list_del(&lcu->lcu);
+		spin_unlock(&lcu->lock);
+		_free_lcu(lcu);
+		lcu = NULL;
+	} else {
+		if (was_pending)
+			_schedule_lcu_update(lcu, NULL);
+		spin_unlock(&lcu->lock);
+	}
+	server = _find_server(&private->uid);
+	if (server && list_empty(&server->lculist)) {
+		list_del(&server->server);
+		_free_server(server);
+	}
+	spin_unlock_irqrestore(&aliastree.lock, flags);
+}
+
+/*
+ * This function assumes that the unit address configuration stored
+ * in the lcu is up to date and will update the device uid before
+ * adding it to a pav group.
+ */
+static int _add_device_to_lcu(struct alias_lcu *lcu,
+			      struct dasd_device *device)
+{
+
+	struct dasd_eckd_private *private;
+	struct alias_pav_group *group;
+	struct dasd_uid *uid;
+
+	private = (struct dasd_eckd_private *) device->private;
+	uid = &private->uid;
+	uid->type = lcu->uac->unit[uid->real_unit_addr].ua_type;
+	uid->base_unit_addr = lcu->uac->unit[uid->real_unit_addr].base_ua;
+	dasd_set_uid(device->cdev, &private->uid);
+
+	group = _find_group(lcu, uid);
+	if (!group) {
+		group = kzalloc(sizeof(*group), GFP_ATOMIC);
+		if (!group)
+			return -ENOMEM;
+		memcpy(group->uid.vendor, uid->vendor, sizeof(uid->vendor));
+		memcpy(group->uid.serial, uid->serial, sizeof(uid->serial));
+		group->uid.ssid = uid->ssid;
+		if (uid->type == UA_BASE_DEVICE)
+			group->uid.base_unit_addr = uid->real_unit_addr;
+		else
+			group->uid.base_unit_addr = uid->base_unit_addr;
+		INIT_LIST_HEAD(&group->group);
+		INIT_LIST_HEAD(&group->baselist);
+		INIT_LIST_HEAD(&group->aliaslist);
+		list_add(&group->group, &lcu->grouplist);
+	}
+	if (uid->type == UA_BASE_DEVICE)
+		list_move(&device->alias_list, &group->baselist);
+	else
+		list_move(&device->alias_list, &group->aliaslist);
+	private->pavgroup = group;
+	return 0;
+};
+
+static void _remove_device_from_lcu(struct alias_lcu *lcu,
+				    struct dasd_device *device)
+{
+	struct dasd_eckd_private *private;
+	struct alias_pav_group *group;
+
+	private = (struct dasd_eckd_private *) device->private;
+	list_move(&device->alias_list, &lcu->inactive_devices);
+	group = private->pavgroup;
+	if (!group)
+		return;
+	private->pavgroup = NULL;
+	if (list_empty(&group->baselist) && list_empty(&group->aliaslist)) {
+		list_del(&group->group);
+		kfree(group);
+		return;
+	}
+	if (group->next == device)
+		group->next = NULL;
+};
+
+static int read_unit_address_configuration(struct dasd_device *device,
+					   struct alias_lcu *lcu)
+{
+	struct dasd_psf_prssd_data *prssdp;
+	struct dasd_ccw_req *cqr;
+	struct ccw1 *ccw;
+	int rc;
+	unsigned long flags;
+
+	cqr = dasd_kmalloc_request("ECKD",
+				   1 /* PSF */	+ 1 /* RSSD */ ,
+				   (sizeof(struct dasd_psf_prssd_data)),
+				   device);
+	if (IS_ERR(cqr))
+		return PTR_ERR(cqr);
+	cqr->startdev = device;
+	cqr->memdev = device;
+	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
+	cqr->retries = 10;
+	cqr->expires = 20 * HZ;
+
+	/* Prepare for Read Subsystem Data */
+	prssdp = (struct dasd_psf_prssd_data *) cqr->data;
+	memset(prssdp, 0, sizeof(struct dasd_psf_prssd_data));
+	prssdp->order = PSF_ORDER_PRSSD;
+	prssdp->suborder = 0x0e;	/* Read unit address configuration */
+	/* all other bytes of prssdp must be zero */
+
+	ccw = cqr->cpaddr;
+	ccw->cmd_code = DASD_ECKD_CCW_PSF;
+	ccw->count = sizeof(struct dasd_psf_prssd_data);
+	ccw->flags |= CCW_FLAG_CC;
+	ccw->cda = (__u32)(addr_t) prssdp;
+
+	/* Read Subsystem Data - feature codes */
+	memset(lcu->uac, 0, sizeof(*(lcu->uac)));
+
+	ccw++;
+	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
+	ccw->count = sizeof(*(lcu->uac));
+	ccw->cda = (__u32)(addr_t) lcu->uac;
+
+	cqr->buildclk = get_clock();
+	cqr->status = DASD_CQR_FILLED;
+
+	/* need to unset flag here to detect race with summary unit check */
+	spin_lock_irqsave(&lcu->lock, flags);
+	lcu->flags &= ~NEED_UAC_UPDATE;
+	spin_unlock_irqrestore(&lcu->lock, flags);
+
+	do {
+		rc = dasd_sleep_on(cqr);
+	} while (rc && (cqr->retries > 0));
+	if (rc) {
+		spin_lock_irqsave(&lcu->lock, flags);
+		lcu->flags |= NEED_UAC_UPDATE;
+		spin_unlock_irqrestore(&lcu->lock, flags);
+	}
+	dasd_kfree_request(cqr, cqr->memdev);
+	return rc;
+}
+
+static int _lcu_update(struct dasd_device *refdev, struct alias_lcu *lcu)
+{
+	unsigned long flags;
+	struct alias_pav_group *pavgroup, *tempgroup;
+	struct dasd_device *device, *tempdev;
+	int i, rc;
+	struct dasd_eckd_private *private;
+
+	spin_lock_irqsave(&lcu->lock, flags);
+	list_for_each_entry_safe(pavgroup, tempgroup, &lcu->grouplist, group) {
+		list_for_each_entry_safe(device, tempdev, &pavgroup->baselist,
+					 alias_list) {
+			list_move(&device->alias_list, &lcu->active_devices);
+			private = (struct dasd_eckd_private *) device->private;
+			private->pavgroup = NULL;
+		}
+		list_for_each_entry_safe(device, tempdev, &pavgroup->aliaslist,
+					 alias_list) {
+			list_move(&device->alias_list, &lcu->active_devices);
+			private = (struct dasd_eckd_private *) device->private;
+			private->pavgroup = NULL;
+		}
+		list_del(&pavgroup->group);
+		kfree(pavgroup);
+	}
+	spin_unlock_irqrestore(&lcu->lock, flags);
+
+	rc = read_unit_address_configuration(refdev, lcu);
+	if (rc)
+		return rc;
+
+	spin_lock_irqsave(&lcu->lock, flags);
+	lcu->pav = NO_PAV;
+	for (i = 0; i < MAX_DEVICES_PER_LCU; ++i) {
+		switch (lcu->uac->unit[i].ua_type) {
+		case UA_BASE_PAV_ALIAS:
+			lcu->pav = BASE_PAV;
+			break;
+		case UA_HYPER_PAV_ALIAS:
+			lcu->pav = HYPER_PAV;
+			break;
+		}
+		if (lcu->pav != NO_PAV)
+			break;
+	}
+
+	/* if we have no PAV anyway, we don't need to bother with PAV groups */
+	if (lcu->pav == NO_PAV) {
+		spin_unlock_irqrestore(&lcu->lock, flags);
+		return 0;
+	}
+
+	list_for_each_entry_safe(device, tempdev, &lcu->active_devices,
+				 alias_list) {
+		_add_device_to_lcu(lcu, device);
+	}
+	spin_unlock_irqrestore(&lcu->lock, flags);
+	return 0;
+}
+
+static void lcu_update_work(struct work_struct *work)
+{
+	struct alias_lcu *lcu;
+	struct read_uac_work_data *ruac_data;
+	struct dasd_device *device;
+	unsigned long flags;
+	int rc;
+
+	ruac_data = container_of(work, struct read_uac_work_data, dwork.work);
+	lcu = container_of(ruac_data, struct alias_lcu, ruac_data);
+	device = ruac_data->device;
+	rc = _lcu_update(device, lcu);
+	/*
+	 * Need to check flags again, as there could have been another
+	 * prepare_update or a new device a new device while we were still
+	 * processing the data
+	 */
+	spin_lock_irqsave(&lcu->lock, flags);
+	if (rc || (lcu->flags & NEED_UAC_UPDATE)) {
+		DEV_MESSAGE(KERN_WARNING, device, "could not update"
+			    " alias data in lcu (rc = %d), retry later", rc);
+		schedule_delayed_work(&lcu->ruac_data.dwork, 30*HZ);
+	} else {
+		lcu->ruac_data.device = NULL;
+		lcu->flags &= ~UPDATE_PENDING;
+	}
+	spin_unlock_irqrestore(&lcu->lock, flags);
+}
+
+static int _schedule_lcu_update(struct alias_lcu *lcu,
+				struct dasd_device *device)
+{
+	struct dasd_device *usedev = NULL;
+	struct alias_pav_group *group;
+
+	lcu->flags |= NEED_UAC_UPDATE;
+	if (lcu->ruac_data.device) {
+		/* already scheduled or running */
+		return 0;
+	}
+	if (device && !list_empty(&device->alias_list))
+		usedev = device;
+
+	if (!usedev && !list_empty(&lcu->grouplist)) {
+		group = list_first_entry(&lcu->grouplist,
+					 struct alias_pav_group, group);
+		if (!list_empty(&group->baselist))
+			usedev = list_first_entry(&group->baselist,
+						  struct dasd_device,
+						  alias_list);
+		else if (!list_empty(&group->aliaslist))
+			usedev = list_first_entry(&group->aliaslist,
+						  struct dasd_device,
+						  alias_list);
+	}
+	if (!usedev && !list_empty(&lcu->active_devices)) {
+		usedev = list_first_entry(&lcu->active_devices,
+					  struct dasd_device, alias_list);
+	}
+	/*
+	 * if we haven't found a proper device yet, give up for now, the next
+	 * device that will be set active will trigger an lcu update
+	 */
+	if (!usedev)
+		return -EINVAL;
+	lcu->ruac_data.device = usedev;
+	schedule_delayed_work(&lcu->ruac_data.dwork, 0);
+	return 0;
+}
+
+int dasd_alias_add_device(struct dasd_device *device)
+{
+	struct dasd_eckd_private *private;
+	struct alias_lcu *lcu;
+	unsigned long flags;
+	int rc;
+
+	private = (struct dasd_eckd_private *) device->private;
+	lcu = private->lcu;
+	rc = 0;
+	spin_lock_irqsave(&lcu->lock, flags);
+	if (!(lcu->flags & UPDATE_PENDING)) {
+		rc = _add_device_to_lcu(lcu, device);
+		if (rc)
+			lcu->flags |= UPDATE_PENDING;
+	}
+	if (lcu->flags & UPDATE_PENDING) {
+		list_move(&device->alias_list, &lcu->active_devices);
+		_schedule_lcu_update(lcu, device);
+	}
+	spin_unlock_irqrestore(&lcu->lock, flags);
+	return rc;
+}
+
+int dasd_alias_remove_device(struct dasd_device *device)
+{
+	struct dasd_eckd_private *private;
+	struct alias_lcu *lcu;
+	unsigned long flags;
+
+	private = (struct dasd_eckd_private *) device->private;
+	lcu = private->lcu;
+	spin_lock_irqsave(&lcu->lock, flags);
+	_remove_device_from_lcu(lcu, device);
+	spin_unlock_irqrestore(&lcu->lock, flags);
+	return 0;
+}
+
+struct dasd_device *dasd_alias_get_start_dev(struct dasd_device *base_device)
+{
+
+	struct dasd_device *alias_device;
+	struct alias_pav_group *group;
+	struct alias_lcu *lcu;
+	struct dasd_eckd_private *private, *alias_priv;
+	unsigned long flags;
+
+	private = (struct dasd_eckd_private *) base_device->private;
+	group = private->pavgroup;
+	lcu = private->lcu;
+	if (!group || !lcu)
+		return NULL;
+	if (lcu->pav == NO_PAV ||
+	    lcu->flags & (NEED_UAC_UPDATE | UPDATE_PENDING))
+		return NULL;
+
+	spin_lock_irqsave(&lcu->lock, flags);
+	alias_device = group->next;
+	if (!alias_device) {
+		if (list_empty(&group->aliaslist)) {
+			spin_unlock_irqrestore(&lcu->lock, flags);
+			return NULL;
+		} else {
+			alias_device = list_first_entry(&group->aliaslist,
+							struct dasd_device,
+							alias_list);
+		}
+	}
+	if (list_is_last(&alias_device->alias_list, &group->aliaslist))
+		group->next = list_first_entry(&group->aliaslist,
+					       struct dasd_device, alias_list);
+	else
+		group->next = list_first_entry(&alias_device->alias_list,
+					       struct dasd_device, alias_list);
+	spin_unlock_irqrestore(&lcu->lock, flags);
+	alias_priv = (struct dasd_eckd_private *) alias_device->private;
+	if ((alias_priv->count < private->count) && !alias_device->stopped)
+		return alias_device;
+	else
+		return NULL;
+}
+
+/*
+ * Summary unit check handling depends on the way alias devices
+ * are handled so it is done here rather then in dasd_eckd.c
+ */
+static int reset_summary_unit_check(struct alias_lcu *lcu,
+				    struct dasd_device *device,
+				    char reason)
+{
+	struct dasd_ccw_req *cqr;
+	int rc = 0;
+
+	cqr = lcu->rsu_cqr;
+	strncpy((char *) &cqr->magic, "ECKD", 4);
+	ASCEBC((char *) &cqr->magic, 4);
+	cqr->cpaddr->cmd_code = DASD_ECKD_CCW_RSCK;
+	cqr->cpaddr->flags = 0 ;
+	cqr->cpaddr->count = 16;
+	cqr->cpaddr->cda = (__u32)(addr_t) cqr->data;
+	((char *)cqr->data)[0] = reason;
+
+	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
+	cqr->retries = 255;	/* set retry counter to enable basic ERP */
+	cqr->startdev = device;
+	cqr->memdev = device;
+	cqr->block = NULL;
+	cqr->expires = 5 * HZ;
+	cqr->buildclk = get_clock();
+	cqr->status = DASD_CQR_FILLED;
+
+	rc = dasd_sleep_on_immediatly(cqr);
+	return rc;
+}
+
+static void _restart_all_base_devices_on_lcu(struct alias_lcu *lcu)
+{
+	struct alias_pav_group *pavgroup;
+	struct dasd_device *device;
+	struct dasd_eckd_private *private;
+
+	/* active and inactive list can contain alias as well as base devices */
+	list_for_each_entry(device, &lcu->active_devices, alias_list) {
+		private = (struct dasd_eckd_private *) device->private;
+		if (private->uid.type != UA_BASE_DEVICE)
+			continue;
+		dasd_schedule_block_bh(device->block);
+		dasd_schedule_device_bh(device);
+	}
+	list_for_each_entry(device, &lcu->inactive_devices, alias_list) {
+		private = (struct dasd_eckd_private *) device->private;
+		if (private->uid.type != UA_BASE_DEVICE)
+			continue;
+		dasd_schedule_block_bh(device->block);
+		dasd_schedule_device_bh(device);
+	}
+	list_for_each_entry(pavgroup, &lcu->grouplist, group) {
+		list_for_each_entry(device, &pavgroup->baselist, alias_list) {
+			dasd_schedule_block_bh(device->block);
+			dasd_schedule_device_bh(device);
+		}
+	}
+}
+
+static void flush_all_alias_devices_on_lcu(struct alias_lcu *lcu)
+{
+	struct alias_pav_group *pavgroup;
+	struct dasd_device *device, *temp;
+	struct dasd_eckd_private *private;
+	int rc;
+	unsigned long flags;
+	LIST_HEAD(active);
+
+	/*
+	 * Problem here ist that dasd_flush_device_queue may wait
+	 * for termination of a request to complete. We can't keep
+	 * the lcu lock during that time, so we must assume that
+	 * the lists may have changed.
+	 * Idea: first gather all active alias devices in a separate list,
+	 * then flush the first element of this list unlocked, and afterwards
+	 * check if it is still on the list before moving it to the
+	 * active_devices list.
+	 */
+
+	spin_lock_irqsave(&lcu->lock, flags);
+	list_for_each_entry_safe(device, temp, &lcu->active_devices,
+				 alias_list) {
+		private = (struct dasd_eckd_private *) device->private;
+		if (private->uid.type == UA_BASE_DEVICE)
+			continue;
+		list_move(&device->alias_list, &active);
+	}
+
+	list_for_each_entry(pavgroup, &lcu->grouplist, group) {
+		list_splice_init(&pavgroup->aliaslist, &active);
+	}
+	while (!list_empty(&active)) {
+		device = list_first_entry(&active, struct dasd_device,
+					  alias_list);
+		spin_unlock_irqrestore(&lcu->lock, flags);
+		rc = dasd_flush_device_queue(device);
+		spin_lock_irqsave(&lcu->lock, flags);
+		/*
+		 * only move device around if it wasn't moved away while we
+		 * were waiting for the flush
+		 */
+		if (device == list_first_entry(&active,
+					       struct dasd_device, alias_list))
+			list_move(&device->alias_list, &lcu->active_devices);
+	}
+	spin_unlock_irqrestore(&lcu->lock, flags);
+}
+
+/*
+ * This function is called in interrupt context, so the
+ * cdev lock for device is already locked!
+ */
+static void _stop_all_devices_on_lcu(struct alias_lcu *lcu,
+				     struct dasd_device *device)
+{
+	struct alias_pav_group *pavgroup;
+	struct dasd_device *pos;
+
+	list_for_each_entry(pos, &lcu->active_devices, alias_list) {
+		if (pos != device)
+			spin_lock(get_ccwdev_lock(pos->cdev));
+		pos->stopped |= DASD_STOPPED_SU;
+		if (pos != device)
+			spin_unlock(get_ccwdev_lock(pos->cdev));
+	}
+	list_for_each_entry(pos, &lcu->inactive_devices, alias_list) {
+		if (pos != device)
+			spin_lock(get_ccwdev_lock(pos->cdev));
+		pos->stopped |= DASD_STOPPED_SU;
+		if (pos != device)
+			spin_unlock(get_ccwdev_lock(pos->cdev));
+	}
+	list_for_each_entry(pavgroup, &lcu->grouplist, group) {
+		list_for_each_entry(pos, &pavgroup->baselist, alias_list) {
+			if (pos != device)
+				spin_lock(get_ccwdev_lock(pos->cdev));
+			pos->stopped |= DASD_STOPPED_SU;
+			if (pos != device)
+				spin_unlock(get_ccwdev_lock(pos->cdev));
+		}
+		list_for_each_entry(pos, &pavgroup->aliaslist, alias_list) {
+			if (pos != device)
+				spin_lock(get_ccwdev_lock(pos->cdev));
+			pos->stopped |= DASD_STOPPED_SU;
+			if (pos != device)
+				spin_unlock(get_ccwdev_lock(pos->cdev));
+		}
+	}
+}
+
+static void _unstop_all_devices_on_lcu(struct alias_lcu *lcu)
+{
+	struct alias_pav_group *pavgroup;
+	struct dasd_device *device;
+	unsigned long flags;
+
+	list_for_each_entry(device, &lcu->active_devices, alias_list) {
+		spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
+		device->stopped &= ~DASD_STOPPED_SU;
+		spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
+	}
+
+	list_for_each_entry(device, &lcu->inactive_devices, alias_list) {
+		spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
+		device->stopped &= ~DASD_STOPPED_SU;
+		spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
+	}
+
+	list_for_each_entry(pavgroup, &lcu->grouplist, group) {
+		list_for_each_entry(device, &pavgroup->baselist, alias_list) {
+			spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
+			device->stopped &= ~DASD_STOPPED_SU;
+			spin_unlock_irqrestore(get_ccwdev_lock(device->cdev),
+					       flags);
+		}
+		list_for_each_entry(device, &pavgroup->aliaslist, alias_list) {
+			spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
+			device->stopped &= ~DASD_STOPPED_SU;
+			spin_unlock_irqrestore(get_ccwdev_lock(device->cdev),
+					       flags);
+		}
+	}
+}
+
+static void summary_unit_check_handling_work(struct work_struct *work)
+{
+	struct alias_lcu *lcu;
+	struct summary_unit_check_work_data *suc_data;
+	unsigned long flags;
+	struct dasd_device *device;
+
+	suc_data = container_of(work, struct summary_unit_check_work_data,
+				worker);
+	lcu = container_of(suc_data, struct alias_lcu, suc_data);
+	device = suc_data->device;
+
+	/* 1. flush alias devices */
+	flush_all_alias_devices_on_lcu(lcu);
+
+	/* 2. reset summary unit check */
+	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
+	device->stopped &= ~(DASD_STOPPED_SU | DASD_STOPPED_PENDING);
+	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
+	reset_summary_unit_check(lcu, device, suc_data->reason);
+
+	spin_lock_irqsave(&lcu->lock, flags);
+	_unstop_all_devices_on_lcu(lcu);
+	_restart_all_base_devices_on_lcu(lcu);
+	/* 3. read new alias configuration */
+	_schedule_lcu_update(lcu, device);
+	lcu->suc_data.device = NULL;
+	spin_unlock_irqrestore(&lcu->lock, flags);
+}
+
+/*
+ * note: this will be called from int handler context (cdev locked)
+ */
+void dasd_alias_handle_summary_unit_check(struct dasd_device *device,
+					  struct irb *irb)
+{
+	struct alias_lcu *lcu;
+	char reason;
+	struct dasd_eckd_private *private;
+
+	private = (struct dasd_eckd_private *) device->private;
+
+	reason = irb->ecw[8];
+	DEV_MESSAGE(KERN_WARNING, device, "%s %x",
+		    "eckd handle summary unit check: reason", reason);
+
+	lcu = private->lcu;
+	if (!lcu) {
+		DEV_MESSAGE(KERN_WARNING, device, "%s",
+			    "device not ready to handle summary"
+			    " unit check (no lcu structure)");
+		return;
+	}
+	spin_lock(&lcu->lock);
+	_stop_all_devices_on_lcu(lcu, device);
+	/* prepare for lcu_update */
+	private->lcu->flags |= NEED_UAC_UPDATE | UPDATE_PENDING;
+	/* If this device is about to be removed just return and wait for
+	 * the next interrupt on a different device
+	 */
+	if (list_empty(&device->alias_list)) {
+		DEV_MESSAGE(KERN_WARNING, device, "%s",
+			    "device is in offline processing,"
+			    " don't do summary unit check handling");
+		spin_unlock(&lcu->lock);
+		return;
+	}
+	if (lcu->suc_data.device) {
+		/* already scheduled or running */
+		DEV_MESSAGE(KERN_WARNING, device, "%s",
+			    "previous instance of summary unit check worker"
+			    " still pending");
+		spin_unlock(&lcu->lock);
+		return ;
+	}
+	lcu->suc_data.reason = reason;
+	lcu->suc_data.device = device;
+	spin_unlock(&lcu->lock);
+	schedule_work(&lcu->suc_data.worker);
+};
Index: quilt-2.6/drivers/s390/block/dasd_int.h
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_int.h
+++ quilt-2.6/drivers/s390/block/dasd_int.h
@@ -64,13 +64,7 @@
  * SECTION: Type definitions
  */
 struct dasd_device;
-
-typedef enum {
-	dasd_era_fatal = -1,	/* no chance to recover		     */
-	dasd_era_none = 0,	/* don't recover, everything alright */
-	dasd_era_msg = 1,	/* don't recover, just report...     */
-	dasd_era_recover = 2	/* recovery action recommended	     */
-} dasd_era_t;
+struct dasd_block;
 
 /* BIT DEFINITIONS FOR SENSE DATA */
 #define DASD_SENSE_BIT_0 0x80
@@ -151,19 +145,22 @@ do { \
 
 struct dasd_ccw_req {
 	unsigned int magic;		/* Eye catcher */
-        struct list_head list;		/* list_head for request queueing. */
+	struct list_head devlist;	/* for dasd_device request queue */
+	struct list_head blocklist;	/* for dasd_block request queue */
 
 	/* Where to execute what... */
-	struct dasd_device *device;	/* device the request is for */
+	struct dasd_block *block;	/* the originating block device */
+	struct dasd_device *memdev;	/* the device used to allocate this */
+	struct dasd_device *startdev;	/* device the request is started on */
 	struct ccw1 *cpaddr;		/* address of channel program */
-	char status;	        	/* status of this request */
+	char status;			/* status of this request */
 	short retries;			/* A retry counter */
 	unsigned long flags;        	/* flags of this request */
 
 	/* ... and how */
 	unsigned long starttime;	/* jiffies time of request start */
 	int expires;			/* expiration period in jiffies */
-	char lpm;               	/* logical path mask */
+	char lpm;			/* logical path mask */
 	void *data;			/* pointer to data area */
 
 	/* these are important for recovering erroneous requests          */
@@ -178,20 +175,27 @@ struct dasd_ccw_req {
 	unsigned long long endclk;	/* TOD-clock of request termination */
 
         /* Callback that is called after reaching final status. */
-        void (*callback)(struct dasd_ccw_req *, void *data);
-        void *callback_data;
+	void (*callback)(struct dasd_ccw_req *, void *data);
+	void *callback_data;
 };
 
 /*
  * dasd_ccw_req -> status can be:
  */
-#define DASD_CQR_FILLED   0x00	/* request is ready to be processed */
-#define DASD_CQR_QUEUED   0x01	/* request is queued to be processed */
-#define DASD_CQR_IN_IO    0x02	/* request is currently in IO */
-#define DASD_CQR_DONE     0x03	/* request is completed successfully */
-#define DASD_CQR_ERROR    0x04	/* request is completed with error */
-#define DASD_CQR_FAILED   0x05	/* request is finally failed */
-#define DASD_CQR_CLEAR    0x06	/* request is clear pending */
+#define DASD_CQR_FILLED 	0x00	/* request is ready to be processed */
+#define DASD_CQR_DONE		0x01	/* request is completed successfully */
+#define DASD_CQR_NEED_ERP	0x02	/* request needs recovery action */
+#define DASD_CQR_IN_ERP 	0x03	/* request is in recovery */
+#define DASD_CQR_FAILED 	0x04	/* request is finally failed */
+#define DASD_CQR_TERMINATED	0x05	/* request was successfull */
+
+#define DASD_CQR_QUEUED 	0x80	/* request is queued to be processed */
+#define DASD_CQR_IN_IO		0x81	/* request is currently in IO */
+#define DASD_CQR_ERROR		0x82	/* request is completed with error */
+#define DASD_CQR_CLEAR_PENDING	0x83	/* request is clear pending */
+#define DASD_CQR_CLEARED	0x84	/* request was cleared */
+#define DASD_CQR_SUCCESS	0x85	/* request was successfull */
+
 
 /* per dasd_ccw_req flags */
 #define DASD_CQR_FLAGS_USE_ERP   0	/* use ERP for this request */
@@ -218,29 +222,46 @@ struct dasd_discipline {
          * Device recognition functions. check_device is used to verify
          * the sense data and the information returned by read device
          * characteristics. It returns 0 if the discipline can be used
-         * for the device in question.
+	 * for the device in question. uncheck_device is called during
+	 * device shutdown to deregister a device from it's discipline.
+	 */
+	int (*check_device)(struct dasd_device *);
+	void (*uncheck_device)(struct dasd_device *);
+
+	/*
          * do_analysis is used in the step from device state "basic" to
          * state "accept". It returns 0 if the device can be made ready,
          * it returns -EMEDIUMTYPE if the device can't be made ready or
          * -EAGAIN if do_analysis started a ccw that needs to complete
          * before the analysis may be repeated.
          */
-        int (*check_device)(struct dasd_device *);
-	int (*do_analysis) (struct dasd_device *);
+	int (*do_analysis) (struct dasd_block *);
+
+	/*
+	 * Last things to do when a device is set online, and first things
+	 * when it is set offline.
+	 */
+	int (*ready_to_online) (struct dasd_device *);
+	int (*online_to_ready) (struct dasd_device *);
 
         /*
          * Device operation functions. build_cp creates a ccw chain for
          * a block device request, start_io starts the request and
          * term_IO cancels it (e.g. in case of a timeout). format_device
          * returns a ccw chain to be used to format the device.
+	 * handle_terminated_request allows to examine a cqr and prepare
+	 * it for retry.
          */
 	struct dasd_ccw_req *(*build_cp) (struct dasd_device *,
+					  struct dasd_block *,
 					  struct request *);
 	int (*start_IO) (struct dasd_ccw_req *);
 	int (*term_IO) (struct dasd_ccw_req *);
+	void (*handle_terminated_request) (struct dasd_ccw_req *);
 	struct dasd_ccw_req *(*format_device) (struct dasd_device *,
 					       struct format_data_t *);
 	int (*free_cp) (struct dasd_ccw_req *, struct request *);
+
         /*
          * Error recovery functions. examine_error() returns a value that
          * indicates what to do for an error condition. If examine_error()
@@ -250,16 +271,17 @@ struct dasd_discipline {
          * is called for every error condition to print the sense data
          * to the console.
          */
-	dasd_era_t(*examine_error) (struct dasd_ccw_req *, struct irb *);
 	dasd_erp_fn_t(*erp_action) (struct dasd_ccw_req *);
 	dasd_erp_fn_t(*erp_postaction) (struct dasd_ccw_req *);
 	void (*dump_sense) (struct dasd_device *, struct dasd_ccw_req *,
 			    struct irb *);
 
+	void (*handle_unsolicited_interrupt) (struct dasd_device *, struct irb *);
+
         /* i/o control functions. */
-	int (*fill_geometry) (struct dasd_device *, struct hd_geometry *);
+	int (*fill_geometry) (struct dasd_block *, struct hd_geometry *);
 	int (*fill_info) (struct dasd_device *, struct dasd_information2_t *);
-	int (*ioctl) (struct dasd_device *, unsigned int, void __user *);
+	int (*ioctl) (struct dasd_block *, unsigned int, void __user *);
 };
 
 extern struct dasd_discipline *dasd_diag_discipline_pointer;
@@ -267,12 +289,18 @@ extern struct dasd_discipline *dasd_diag
 /*
  * Unique identifier for dasd device.
  */
+#define UA_NOT_CONFIGURED  0x00
+#define UA_BASE_DEVICE	   0x01
+#define UA_BASE_PAV_ALIAS  0x02
+#define UA_HYPER_PAV_ALIAS 0x03
+
 struct dasd_uid {
-	__u8 alias;
+	__u8 type;
 	char vendor[4];
 	char serial[15];
 	__u16 ssid;
-	__u8 unit_addr;
+	__u8 real_unit_addr;
+	__u8 base_unit_addr;
 };
 
 /*
@@ -293,14 +321,9 @@ struct dasd_uid {
 
 struct dasd_device {
 	/* Block device stuff. */
-	struct gendisk *gdp;
-	struct request_queue *request_queue;
-	spinlock_t request_queue_lock;
-	struct block_device *bdev;
+	struct dasd_block *block;
+
         unsigned int devindex;
-	unsigned long blocks;	   /* size of volume in blocks */
-	unsigned int bp_block;	   /* bytes per block */
-	unsigned int s2b_shift;	   /* log2 (bp_block/512) */
 	unsigned long flags;	   /* per device flags */
 	unsigned short features;   /* copy of devmap-features (read-only!) */
 
@@ -316,9 +339,8 @@ struct dasd_device {
 	int state, target;
 	int stopped;		/* device (ccw_device_start) was stopped */
 
-	/* Open and reference count. */
+	/* reference count. */
         atomic_t ref_count;
-	atomic_t open_count;
 
 	/* ccw queue and memory for static ccw/erp buffers. */
 	struct list_head ccw_queue;
@@ -337,20 +359,45 @@ struct dasd_device {
 
 	struct ccw_device *cdev;
 
+	/* hook for alias management */
+	struct list_head alias_list;
+};
+
+struct dasd_block {
+	/* Block device stuff. */
+	struct gendisk *gdp;
+	struct request_queue *request_queue;
+	spinlock_t request_queue_lock;
+	struct block_device *bdev;
+	atomic_t open_count;
+
+	unsigned long blocks;	   /* size of volume in blocks */
+	unsigned int bp_block;	   /* bytes per block */
+	unsigned int s2b_shift;	   /* log2 (bp_block/512) */
+
+	struct dasd_device *base;
+	struct list_head ccw_queue;
+	spinlock_t queue_lock;
+
+	atomic_t tasklet_scheduled;
+	struct tasklet_struct tasklet;
+	struct timer_list timer;
+
 #ifdef CONFIG_DASD_PROFILE
 	struct dasd_profile_info_t profile;
 #endif
 };
 
+
+
 /* reasons why device (ccw_device_start) was stopped */
 #define DASD_STOPPED_NOT_ACC 1         /* not accessible */
 #define DASD_STOPPED_QUIESCE 2         /* Quiesced */
 #define DASD_STOPPED_PENDING 4         /* long busy */
 #define DASD_STOPPED_DC_WAIT 8         /* disconnected, wait */
-#define DASD_STOPPED_DC_EIO  16        /* disconnected, return -EIO */
+#define DASD_STOPPED_SU      16        /* summary unit check handling */
 
 /* per device flags */
-#define DASD_FLAG_DSC_ERROR	2	/* return -EIO when disconnected */
 #define DASD_FLAG_OFFLINE	3	/* device is in offline processing */
 #define DASD_FLAG_EER_SNSS	4	/* A SNSS is required */
 #define DASD_FLAG_EER_IN_USE	5	/* A SNSS request is running */
@@ -489,6 +536,9 @@ dasd_kmalloc_set_cda(struct ccw1 *ccw, v
 struct dasd_device *dasd_alloc_device(void);
 void dasd_free_device(struct dasd_device *);
 
+struct dasd_block *dasd_alloc_block(void);
+void dasd_free_block(struct dasd_block *);
+
 void dasd_enable_device(struct dasd_device *);
 void dasd_set_target_state(struct dasd_device *, int);
 void dasd_kick_device(struct dasd_device *);
@@ -497,18 +547,23 @@ void dasd_add_request_head(struct dasd_c
 void dasd_add_request_tail(struct dasd_ccw_req *);
 int  dasd_start_IO(struct dasd_ccw_req *);
 int  dasd_term_IO(struct dasd_ccw_req *);
-void dasd_schedule_bh(struct dasd_device *);
+void dasd_schedule_device_bh(struct dasd_device *);
+void dasd_schedule_block_bh(struct dasd_block *);
 int  dasd_sleep_on(struct dasd_ccw_req *);
 int  dasd_sleep_on_immediatly(struct dasd_ccw_req *);
 int  dasd_sleep_on_interruptible(struct dasd_ccw_req *);
-void dasd_set_timer(struct dasd_device *, int);
-void dasd_clear_timer(struct dasd_device *);
+void dasd_device_set_timer(struct dasd_device *, int);
+void dasd_device_clear_timer(struct dasd_device *);
+void dasd_block_set_timer(struct dasd_block *, int);
+void dasd_block_clear_timer(struct dasd_block *);
 int  dasd_cancel_req(struct dasd_ccw_req *);
+int dasd_flush_device_queue(struct dasd_device *);
 int dasd_generic_probe (struct ccw_device *, struct dasd_discipline *);
 void dasd_generic_remove (struct ccw_device *cdev);
 int dasd_generic_set_online(struct ccw_device *, struct dasd_discipline *);
 int dasd_generic_set_offline (struct ccw_device *cdev);
 int dasd_generic_notify(struct ccw_device *, int);
+void dasd_generic_handle_state_change(struct dasd_device *);
 
 int dasd_generic_read_dev_chars(struct dasd_device *, char *, void **, int);
 
@@ -542,10 +597,10 @@ int dasd_busid_known(char *);
 /* externals in dasd_gendisk.c */
 int  dasd_gendisk_init(void);
 void dasd_gendisk_exit(void);
-int dasd_gendisk_alloc(struct dasd_device *);
-void dasd_gendisk_free(struct dasd_device *);
-int dasd_scan_partitions(struct dasd_device *);
-void dasd_destroy_partitions(struct dasd_device *);
+int dasd_gendisk_alloc(struct dasd_block *);
+void dasd_gendisk_free(struct dasd_block *);
+int dasd_scan_partitions(struct dasd_block *);
+void dasd_destroy_partitions(struct dasd_block *);
 
 /* externals in dasd_ioctl.c */
 int  dasd_ioctl(struct inode *, struct file *, unsigned int, unsigned long);
@@ -563,20 +618,9 @@ struct dasd_ccw_req *dasd_alloc_erp_requ
 void dasd_free_erp_request(struct dasd_ccw_req *, struct dasd_device *);
 void dasd_log_sense(struct dasd_ccw_req *, struct irb *);
 
-/* externals in dasd_3370_erp.c */
-dasd_era_t dasd_3370_erp_examine(struct dasd_ccw_req *, struct irb *);
-
 /* externals in dasd_3990_erp.c */
-dasd_era_t dasd_3990_erp_examine(struct dasd_ccw_req *, struct irb *);
 struct dasd_ccw_req *dasd_3990_erp_action(struct dasd_ccw_req *);
 
-/* externals in dasd_9336_erp.c */
-dasd_era_t dasd_9336_erp_examine(struct dasd_ccw_req *, struct irb *);
-
-/* externals in dasd_9336_erp.c */
-dasd_era_t dasd_9343_erp_examine(struct dasd_ccw_req *, struct irb *);
-struct dasd_ccw_req *dasd_9343_erp_action(struct dasd_ccw_req *);
-
 /* externals in dasd_eer.c */
 #ifdef CONFIG_DASD_EER
 int dasd_eer_init(void);
Index: quilt-2.6/drivers/s390/block/dasd_ioctl.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_ioctl.c
+++ quilt-2.6/drivers/s390/block/dasd_ioctl.c
@@ -38,15 +38,15 @@ dasd_ioctl_api_version(void __user *argp
 static int
 dasd_ioctl_enable(struct block_device *bdev)
 {
-	struct dasd_device *device = bdev->bd_disk->private_data;
+	struct dasd_block *block = bdev->bd_disk->private_data;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
-	dasd_enable_device(device);
+	dasd_enable_device(block->base);
 	/* Formatting the dasd device can change the capacity. */
 	mutex_lock(&bdev->bd_mutex);
-	i_size_write(bdev->bd_inode, (loff_t)get_capacity(device->gdp) << 9);
+	i_size_write(bdev->bd_inode, (loff_t)get_capacity(block->gdp) << 9);
 	mutex_unlock(&bdev->bd_mutex);
 	return 0;
 }
@@ -58,7 +58,7 @@ dasd_ioctl_enable(struct block_device *b
 static int
 dasd_ioctl_disable(struct block_device *bdev)
 {
-	struct dasd_device *device = bdev->bd_disk->private_data;
+	struct dasd_block *block = bdev->bd_disk->private_data;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -71,7 +71,7 @@ dasd_ioctl_disable(struct block_device *
 	 * using the BIODASDFMT ioctl. Therefore the correct state for the
 	 * device is DASD_STATE_BASIC that allows to do basic i/o.
 	 */
-	dasd_set_target_state(device, DASD_STATE_BASIC);
+	dasd_set_target_state(block->base, DASD_STATE_BASIC);
 	/*
 	 * Set i_size to zero, since read, write, etc. check against this
 	 * value.
@@ -86,18 +86,20 @@ dasd_ioctl_disable(struct block_device *
  * Quiesce device.
  */
 static int
-dasd_ioctl_quiesce(struct dasd_device *device)
+dasd_ioctl_quiesce(struct dasd_block *block)
 {
 	unsigned long flags;
+	struct dasd_device *base;
 
+	base = block->base;
 	if (!capable (CAP_SYS_ADMIN))
 		return -EACCES;
 
-	DEV_MESSAGE (KERN_DEBUG, device, "%s",
-		     "Quiesce IO on device");
-	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
-	device->stopped |= DASD_STOPPED_QUIESCE;
-	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
+	DEV_MESSAGE(KERN_DEBUG, base, "%s",
+		    "Quiesce IO on device");
+	spin_lock_irqsave(get_ccwdev_lock(base->cdev), flags);
+	base->stopped |= DASD_STOPPED_QUIESCE;
+	spin_unlock_irqrestore(get_ccwdev_lock(base->cdev), flags);
 	return 0;
 }
 
@@ -106,21 +108,23 @@ dasd_ioctl_quiesce(struct dasd_device *d
  * Quiesce device.
  */
 static int
-dasd_ioctl_resume(struct dasd_device *device)
+dasd_ioctl_resume(struct dasd_block *block)
 {
 	unsigned long flags;
+	struct dasd_device *base;
 
+	base = block->base;
 	if (!capable (CAP_SYS_ADMIN))
 		return -EACCES;
 
-	DEV_MESSAGE (KERN_DEBUG, device, "%s",
-		     "resume IO on device");
+	DEV_MESSAGE(KERN_DEBUG, base, "%s",
+		    "resume IO on device");
 
-	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
-	device->stopped &= ~DASD_STOPPED_QUIESCE;
-	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
+	spin_lock_irqsave(get_ccwdev_lock(base->cdev), flags);
+	base->stopped &= ~DASD_STOPPED_QUIESCE;
+	spin_unlock_irqrestore(get_ccwdev_lock(base->cdev), flags);
 
-	dasd_schedule_bh (device);
+	dasd_schedule_block_bh(block);
 	return 0;
 }
 
@@ -131,21 +135,23 @@ dasd_ioctl_resume(struct dasd_device *de
  * devices this means CCWs are generated to format a single track.
  */
 static int
-dasd_format(struct dasd_device * device, struct format_data_t * fdata)
+dasd_format(struct dasd_block *block, struct format_data_t *fdata)
 {
 	struct dasd_ccw_req *cqr;
+	struct dasd_device *base;
 	int rc;
 
-	if (device->discipline->format_device == NULL)
+	base = block->base;
+	if (base->discipline->format_device == NULL)
 		return -EPERM;
 
-	if (device->state != DASD_STATE_BASIC) {
-		DEV_MESSAGE(KERN_WARNING, device, "%s",
+	if (base->state != DASD_STATE_BASIC) {
+		DEV_MESSAGE(KERN_WARNING, base, "%s",
 			    "dasd_format: device is not disabled! ");
 		return -EBUSY;
 	}
 
-	DBF_DEV_EVENT(DBF_NOTICE, device,
+	DBF_DEV_EVENT(DBF_NOTICE, base,
 		      "formatting units %d to %d (%d B blocks) flags %d",
 		      fdata->start_unit,
 		      fdata->stop_unit, fdata->blksize, fdata->intensity);
@@ -156,20 +162,20 @@ dasd_format(struct dasd_device * device,
 	 * enabling the device later.
 	 */
 	if (fdata->start_unit == 0) {
-		struct block_device *bdev = bdget_disk(device->gdp, 0);
+		struct block_device *bdev = bdget_disk(block->gdp, 0);
 		bdev->bd_inode->i_blkbits = blksize_bits(fdata->blksize);
 		bdput(bdev);
 	}
 
 	while (fdata->start_unit <= fdata->stop_unit) {
-		cqr = device->discipline->format_device(device, fdata);
+		cqr = base->discipline->format_device(base, fdata);
 		if (IS_ERR(cqr))
 			return PTR_ERR(cqr);
 		rc = dasd_sleep_on_interruptible(cqr);
-		dasd_sfree_request(cqr, cqr->device);
+		dasd_sfree_request(cqr, cqr->memdev);
 		if (rc) {
 			if (rc != -ERESTARTSYS)
-				DEV_MESSAGE(KERN_ERR, device,
+				DEV_MESSAGE(KERN_ERR, base,
 					    " Formatting of unit %d failed "
 					    "with rc = %d",
 					    fdata->start_unit, rc);
@@ -186,7 +192,7 @@ dasd_format(struct dasd_device * device,
 static int
 dasd_ioctl_format(struct block_device *bdev, void __user *argp)
 {
-	struct dasd_device *device = bdev->bd_disk->private_data;
+	struct dasd_block *block = bdev->bd_disk->private_data;
 	struct format_data_t fdata;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -194,16 +200,16 @@ dasd_ioctl_format(struct block_device *b
 	if (!argp)
 		return -EINVAL;
 
-	if (device->features & DASD_FEATURE_READONLY)
+	if (block->base->features & DASD_FEATURE_READONLY)
 		return -EROFS;
 	if (copy_from_user(&fdata, argp, sizeof(struct format_data_t)))
 		return -EFAULT;
 	if (bdev != bdev->bd_contains) {
-		DEV_MESSAGE(KERN_WARNING, device, "%s",
+		DEV_MESSAGE(KERN_WARNING, block->base, "%s",
 			    "Cannot low-level format a partition");
 		return -EINVAL;
 	}
-	return dasd_format(device, &fdata);
+	return dasd_format(block, &fdata);
 }
 
 #ifdef CONFIG_DASD_PROFILE
@@ -211,9 +217,9 @@ dasd_ioctl_format(struct block_device *b
  * Reset device profile information
  */
 static int
-dasd_ioctl_reset_profile(struct dasd_device *device)
+dasd_ioctl_reset_profile(struct dasd_block *block)
 {
-	memset(&device->profile, 0, sizeof (struct dasd_profile_info_t));
+	memset(&block->profile, 0, sizeof(struct dasd_profile_info_t));
 	return 0;
 }
 
@@ -221,24 +227,24 @@ dasd_ioctl_reset_profile(struct dasd_dev
  * Return device profile information
  */
 static int
-dasd_ioctl_read_profile(struct dasd_device *device, void __user *argp)
+dasd_ioctl_read_profile(struct dasd_block *block, void __user *argp)
 {
 	if (dasd_profile_level == DASD_PROFILE_OFF)
 		return -EIO;
-	if (copy_to_user(argp, &device->profile,
-			 sizeof (struct dasd_profile_info_t)))
+	if (copy_to_user(argp, &block->profile,
+			 sizeof(struct dasd_profile_info_t)))
 		return -EFAULT;
 	return 0;
 }
 #else
 static int
-dasd_ioctl_reset_profile(struct dasd_device *device)
+dasd_ioctl_reset_profile(struct dasd_block *block)
 {
 	return -ENOSYS;
 }
 
 static int
-dasd_ioctl_read_profile(struct dasd_device *device, void __user *argp)
+dasd_ioctl_read_profile(struct dasd_block *block, void __user *argp)
 {
 	return -ENOSYS;
 }
@@ -247,87 +253,88 @@ dasd_ioctl_read_profile(struct dasd_devi
 /*
  * Return dasd information. Used for BIODASDINFO and BIODASDINFO2.
  */
-static int
-dasd_ioctl_information(struct dasd_device *device,
-		unsigned int cmd, void __user *argp)
+static int dasd_ioctl_information(struct dasd_block *block,
+				  unsigned int cmd, void __user *argp)
 {
 	struct dasd_information2_t *dasd_info;
 	unsigned long flags;
 	int rc;
+	struct dasd_device *base;
 	struct ccw_device *cdev;
 	struct ccw_dev_id dev_id;
 
-	if (!device->discipline->fill_info)
+	base = block->base;
+	if (!base->discipline->fill_info)
 		return -EINVAL;
 
 	dasd_info = kzalloc(sizeof(struct dasd_information2_t), GFP_KERNEL);
 	if (dasd_info == NULL)
 		return -ENOMEM;
 
-	rc = device->discipline->fill_info(device, dasd_info);
+	rc = base->discipline->fill_info(base, dasd_info);
 	if (rc) {
 		kfree(dasd_info);
 		return rc;
 	}
 
-	cdev = device->cdev;
+	cdev = base->cdev;
 	ccw_device_get_id(cdev, &dev_id);
 
 	dasd_info->devno = dev_id.devno;
-	dasd_info->schid = _ccw_device_get_subchannel_number(device->cdev);
+	dasd_info->schid = _ccw_device_get_subchannel_number(base->cdev);
 	dasd_info->cu_type = cdev->id.cu_type;
 	dasd_info->cu_model = cdev->id.cu_model;
 	dasd_info->dev_type = cdev->id.dev_type;
 	dasd_info->dev_model = cdev->id.dev_model;
-	dasd_info->status = device->state;
+	dasd_info->status = base->state;
 	/*
 	 * The open_count is increased for every opener, that includes
 	 * the blkdev_get in dasd_scan_partitions.
 	 * This must be hidden from user-space.
 	 */
-	dasd_info->open_count = atomic_read(&device->open_count);
-	if (!device->bdev)
+	dasd_info->open_count = atomic_read(&block->open_count);
+	if (!block->bdev)
 		dasd_info->open_count++;
 
 	/*
 	 * check if device is really formatted
 	 * LDL / CDL was returned by 'fill_info'
 	 */
-	if ((device->state < DASD_STATE_READY) ||
-	    (dasd_check_blocksize(device->bp_block)))
+	if ((base->state < DASD_STATE_READY) ||
+	    (dasd_check_blocksize(block->bp_block)))
 		dasd_info->format = DASD_FORMAT_NONE;
 
 	dasd_info->features |=
-		((device->features & DASD_FEATURE_READONLY) != 0);
+		((base->features & DASD_FEATURE_READONLY) != 0);
 
-	if (device->discipline)
-		memcpy(dasd_info->type, device->discipline->name, 4);
+	if (base->discipline)
+		memcpy(dasd_info->type, base->discipline->name, 4);
 	else
 		memcpy(dasd_info->type, "none", 4);
 
-	if (device->request_queue->request_fn) {
+	if (block->request_queue->request_fn) {
 		struct list_head *l;
 #ifdef DASD_EXTENDED_PROFILING
 		{
 			struct list_head *l;
-			spin_lock_irqsave(&device->lock, flags);
-			list_for_each(l, &device->request_queue->queue_head)
+			spin_lock_irqsave(&block->lock, flags);
+			list_for_each(l, &block->request_queue->queue_head)
 				dasd_info->req_queue_len++;
-			spin_unlock_irqrestore(&device->lock, flags);
+			spin_unlock_irqrestore(&block->lock, flags);
 		}
 #endif				/* DASD_EXTENDED_PROFILING */
-		spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
-		list_for_each(l, &device->ccw_queue)
+		spin_lock_irqsave(get_ccwdev_lock(base->cdev), flags);
+		list_for_each(l, &base->ccw_queue)
 			dasd_info->chanq_len++;
-		spin_unlock_irqrestore(get_ccwdev_lock(device->cdev),
+		spin_unlock_irqrestore(get_ccwdev_lock(base->cdev),
 				       flags);
 	}
 
 	rc = 0;
 	if (copy_to_user(argp, dasd_info,
 			 ((cmd == (unsigned int) BIODASDINFO2) ?
-			  sizeof (struct dasd_information2_t) :
-			  sizeof (struct dasd_information_t))))
+			  sizeof(struct dasd_information2_t) :
+			  sizeof(struct dasd_information_t))))
 		rc = -EFAULT;
 	kfree(dasd_info);
 	return rc;
@@ -339,7 +346,7 @@ dasd_ioctl_information(struct dasd_devic
 static int
 dasd_ioctl_set_ro(struct block_device *bdev, void __user *argp)
 {
-	struct dasd_device *device =  bdev->bd_disk->private_data;
+	struct dasd_block *block =  bdev->bd_disk->private_data;
 	int intval;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -351,11 +358,11 @@ dasd_ioctl_set_ro(struct block_device *b
 		return -EFAULT;
 
 	set_disk_ro(bdev->bd_disk, intval);
-	return dasd_set_feature(device->cdev, DASD_FEATURE_READONLY, intval);
+	return dasd_set_feature(block->base->cdev, DASD_FEATURE_READONLY, intval);
 }
 
 static int
-dasd_ioctl_readall_cmb(struct dasd_device *device, unsigned int cmd,
+dasd_ioctl_readall_cmb(struct dasd_block *block, unsigned int cmd,
 		unsigned long arg)
 {
 	struct cmbdata __user *argp = (void __user *) arg;
@@ -363,7 +370,7 @@ dasd_ioctl_readall_cmb(struct dasd_devic
 	struct cmbdata data;
 	int ret;
 
-	ret = cmf_readall(device->cdev, &data);
+	ret = cmf_readall(block->base->cdev, &data);
 	if (!ret && copy_to_user(argp, &data, min(size, sizeof(*argp))))
 		return -EFAULT;
 	return ret;
@@ -374,10 +381,10 @@ dasd_ioctl(struct inode *inode, struct f
 	   unsigned int cmd, unsigned long arg)
 {
 	struct block_device *bdev = inode->i_bdev;
-	struct dasd_device *device = bdev->bd_disk->private_data;
+	struct dasd_block *block = bdev->bd_disk->private_data;
 	void __user *argp = (void __user *)arg;
 
-	if (!device)
+	if (!block)
                 return -ENODEV;
 
 	if ((_IOC_DIR(cmd) != _IOC_NONE) && !arg) {
@@ -391,33 +398,33 @@ dasd_ioctl(struct inode *inode, struct f
 	case BIODASDENABLE:
 		return dasd_ioctl_enable(bdev);
 	case BIODASDQUIESCE:
-		return dasd_ioctl_quiesce(device);
+		return dasd_ioctl_quiesce(block);
 	case BIODASDRESUME:
-		return dasd_ioctl_resume(device);
+		return dasd_ioctl_resume(block);
 	case BIODASDFMT:
 		return dasd_ioctl_format(bdev, argp);
 	case BIODASDINFO:
-		return dasd_ioctl_information(device, cmd, argp);
+		return dasd_ioctl_information(block, cmd, argp);
 	case BIODASDINFO2:
-		return dasd_ioctl_information(device, cmd, argp);
+		return dasd_ioctl_information(block, cmd, argp);
 	case BIODASDPRRD:
-		return dasd_ioctl_read_profile(device, argp);
+		return dasd_ioctl_read_profile(block, argp);
 	case BIODASDPRRST:
-		return dasd_ioctl_reset_profile(device);
+		return dasd_ioctl_reset_profile(block);
 	case BLKROSET:
 		return dasd_ioctl_set_ro(bdev, argp);
 	case DASDAPIVER:
 		return dasd_ioctl_api_version(argp);
 	case BIODASDCMFENABLE:
-		return enable_cmf(device->cdev);
+		return enable_cmf(block->base->cdev);
 	case BIODASDCMFDISABLE:
-		return disable_cmf(device->cdev);
+		return disable_cmf(block->base->cdev);
 	case BIODASDREADALLCMB:
-		return dasd_ioctl_readall_cmb(device, cmd, arg);
+		return dasd_ioctl_readall_cmb(block, cmd, arg);
 	default:
 		/* if the discipline has an ioctl method try it. */
-		if (device->discipline->ioctl) {
-			int rval = device->discipline->ioctl(device, cmd, argp);
+		if (block->base->discipline->ioctl) {
+			int rval = block->base->discipline->ioctl(block, cmd, argp);
 			if (rval != -ENOIOCTLCMD)
 				return rval;
 		}
Index: quilt-2.6/drivers/s390/block/dasd_proc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_proc.c
+++ quilt-2.6/drivers/s390/block/dasd_proc.c
@@ -54,11 +54,16 @@ static int
 dasd_devices_show(struct seq_file *m, void *v)
 {
 	struct dasd_device *device;
+	struct dasd_block *block;
 	char *substr;
 
 	device = dasd_device_from_devindex((unsigned long) v - 1);
 	if (IS_ERR(device))
 		return 0;
+	if (device->block)
+		block = device->block;
+	else
+		return 0;
 	/* Print device number. */
 	seq_printf(m, "%s", device->cdev->dev.bus_id);
 	/* Print discipline string. */
@@ -67,14 +72,14 @@ dasd_devices_show(struct seq_file *m, vo
 	else
 		seq_printf(m, "(none)");
 	/* Print kdev. */
-	if (device->gdp)
+	if (block->gdp)
 		seq_printf(m, " at (%3d:%6d)",
-			   device->gdp->major, device->gdp->first_minor);
+			   block->gdp->major, block->gdp->first_minor);
 	else
 		seq_printf(m, "  at (???:??????)");
 	/* Print device name. */
-	if (device->gdp)
-		seq_printf(m, " is %-8s", device->gdp->disk_name);
+	if (block->gdp)
+		seq_printf(m, " is %-8s", block->gdp->disk_name);
 	else
 		seq_printf(m, " is ????????");
 	/* Print devices features. */
@@ -100,14 +105,14 @@ dasd_devices_show(struct seq_file *m, vo
 	case DASD_STATE_READY:
 	case DASD_STATE_ONLINE:
 		seq_printf(m, "active ");
-		if (dasd_check_blocksize(device->bp_block))
+		if (dasd_check_blocksize(block->bp_block))
 			seq_printf(m, "n/f	 ");
 		else
 			seq_printf(m,
 				   "at blocksize: %d, %ld blocks, %ld MB",
-				   device->bp_block, device->blocks,
-				   ((device->bp_block >> 9) *
-				    device->blocks) >> 11);
+				   block->bp_block, block->blocks,
+				   ((block->bp_block >> 9) *
+				    block->blocks) >> 11);
 		break;
 	default:
 		seq_printf(m, "no stat");
Index: quilt-2.6/drivers/s390/block/Makefile
===================================================================
--- quilt-2.6.orig/drivers/s390/block/Makefile
+++ quilt-2.6/drivers/s390/block/Makefile
@@ -2,8 +2,8 @@
 # S/390 block devices
 #
 
-dasd_eckd_mod-objs := dasd_eckd.o dasd_3990_erp.o dasd_9343_erp.o
-dasd_fba_mod-objs  := dasd_fba.o dasd_3370_erp.o dasd_9336_erp.o
+dasd_eckd_mod-objs := dasd_eckd.o dasd_3990_erp.o dasd_alias.o
+dasd_fba_mod-objs  := dasd_fba.o
 dasd_diag_mod-objs := dasd_diag.o
 dasd_mod-objs      := dasd.o dasd_ioctl.o dasd_proc.o dasd_devmap.o \
 			dasd_genhd.o dasd_erp.o

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
