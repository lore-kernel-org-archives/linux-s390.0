Return-Path: <linux-kernel-owner+w=401wt.eu-S1758756AbYBEPn3@vger.kernel.org>
Message-Id: <20080205153914.927756387@de.ibm.com>
References: <20080205153835.337897404@de.ibm.com>
Date: Tue, 05 Feb 2008 16:38:49 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 14/18] dasd: add ifcc handling
Content-Disposition: inline; filename=014-dasd-ifcc.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Stefan Haberland <stefan.haberland@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Haberland <stefan.haberland@de.ibm.com>

Adding interface control check (ifcc) handling in error recovery.
First retry up to 255 times and if all retries fail try an alternate
path if possible.

Signed-off-by: Stefan Haberland <stefan.haberland@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd.c          |   17 +++-------
 drivers/s390/block/dasd_3990_erp.c |   62 +++++++++++++++++++++++++++----------
 2 files changed, 52 insertions(+), 27 deletions(-)

Index: quilt-2.6/drivers/s390/block/dasd_3990_erp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_3990_erp.c
+++ quilt-2.6/drivers/s390/block/dasd_3990_erp.c
@@ -164,7 +164,7 @@ dasd_3990_erp_alternate_path(struct dasd
 
 		/* reset status to submit the request again... */
 		erp->status = DASD_CQR_FILLED;
-		erp->retries = 1;
+		erp->retries = 10;
 	} else {
 		DEV_MESSAGE(KERN_ERR, device,
 			    "No alternate channel path left (lpum=%x / "
@@ -301,8 +301,7 @@ dasd_3990_erp_action_4(struct dasd_ccw_r
 		erp->function = dasd_3990_erp_action_4;
 
 	} else {
-
-		if (sense[25] == 0x1D) {	/* state change pending */
+		if (sense && (sense[25] == 0x1D)) { /* state change pending */
 
 			DEV_MESSAGE(KERN_INFO, device,
 				    "waiting for state change pending "
@@ -311,7 +310,7 @@ dasd_3990_erp_action_4(struct dasd_ccw_r
 
 			dasd_3990_erp_block_queue(erp, 30*HZ);
 
-                } else if (sense[25] == 0x1E) {	/* busy */
+		} else if (sense && (sense[25] == 0x1E)) {	/* busy */
 			DEV_MESSAGE(KERN_INFO, device,
 				    "busy - redriving request later, "
 				    "%d retries left",
@@ -2120,6 +2119,34 @@ dasd_3990_erp_inspect_32(struct dasd_ccw
  */
 
 /*
+ * DASD_3990_ERP_CONTROL_CHECK
+ *
+ * DESCRIPTION
+ *   Does a generic inspection if a control check occured and sets up
+ *   the related error recovery procedure
+ *
+ * PARAMETER
+ *   erp		pointer to the currently created default ERP
+ *
+ * RETURN VALUES
+ *   erp_filled		pointer to the erp
+ */
+
+static struct dasd_ccw_req *
+dasd_3990_erp_control_check(struct dasd_ccw_req *erp)
+{
+	struct dasd_device *device = erp->startdev;
+
+	if (erp->refers->irb.scsw.cstat & (SCHN_STAT_INTF_CTRL_CHK
+					   | SCHN_STAT_CHN_CTRL_CHK)) {
+		DEV_MESSAGE(KERN_DEBUG, device, "%s",
+			    "channel or interface control check");
+		erp = dasd_3990_erp_action_4(erp, NULL);
+	}
+	return erp;
+}
+
+/*
  * DASD_3990_ERP_INSPECT
  *
  * DESCRIPTION
@@ -2145,8 +2172,11 @@ dasd_3990_erp_inspect(struct dasd_ccw_re
 	if (erp_new)
 		return erp_new;
 
+	/* check if no concurrent sens is available */
+	if (!erp->refers->irb.esw.esw0.erw.cons)
+		erp_new = dasd_3990_erp_control_check(erp);
 	/* distinguish between 24 and 32 byte sense data */
-	if (sense[27] & DASD_SENSE_BIT_0) {
+	else if (sense[27] & DASD_SENSE_BIT_0) {
 
 		/* inspect the 24 byte sense data */
 		erp_new = dasd_3990_erp_inspect_24(erp, sense);
@@ -2285,6 +2315,17 @@ dasd_3990_erp_error_match(struct dasd_cc
 		//	return 0;	/* CCW doesn't match */
 	}
 
+	if (cqr1->irb.esw.esw0.erw.cons != cqr2->irb.esw.esw0.erw.cons)
+		return 0;
+
+	if ((cqr1->irb.esw.esw0.erw.cons == 0) &&
+	    (cqr2->irb.esw.esw0.erw.cons == 0))	{
+		if ((cqr1->irb.scsw.cstat & (SCHN_STAT_INTF_CTRL_CHK |
+					     SCHN_STAT_CHN_CTRL_CHK)) ==
+		    (cqr2->irb.scsw.cstat & (SCHN_STAT_INTF_CTRL_CHK |
+					     SCHN_STAT_CHN_CTRL_CHK)))
+			return 1; /* match with ifcc*/
+	}
 	/* check sense data; byte 0-2,25,27 */
 	if (!((memcmp (cqr1->irb.ecw, cqr2->irb.ecw, 3) == 0) &&
 	      (cqr1->irb.ecw[27] == cqr2->irb.ecw[27]) &&
@@ -2560,17 +2601,6 @@ dasd_3990_erp_action(struct dasd_ccw_req
 
 		return cqr;
 	}
-	/* check if sense data are available */
-	if (!cqr->irb.ecw) {
-		DEV_MESSAGE(KERN_DEBUG, device,
-			    "ERP called witout sense data avail ..."
-			    "request %p - NO ERP possible", cqr);
-
-		cqr->status = DASD_CQR_FAILED;
-
-		return cqr;
-
-	}
 
 	/* check if error happened before */
 	erp = dasd_3990_erp_in_erp(cqr);
Index: quilt-2.6/drivers/s390/block/dasd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd.c
+++ quilt-2.6/drivers/s390/block/dasd.c
@@ -1057,12 +1057,11 @@ void dasd_int_handler(struct ccw_device 
 		if (device->features & DASD_FEATURE_ERPLOG) {
 			dasd_log_sense(cqr, irb);
 		}
-		/* If we have no sense data, or we just don't want complex ERP
-		 * for this request, but if we have retries left, then just
-		 * reset this request and retry it in the fastpath
+		/*
+		 * If we don't want complex ERP for this request, then just
+		 * reset this and retry it in the fastpath
 		 */
-		if (!(cqr->irb.esw.esw0.erw.cons &&
-		      test_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags)) &&
+		if (!test_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags) &&
 		    cqr->retries > 0) {
 			DEV_MESSAGE(KERN_DEBUG, device,
 				    "default ERP in fastpath (%i retries left)",
@@ -1742,12 +1741,8 @@ restart:
 
 		/*  Process requests that may be recovered */
 		if (cqr->status == DASD_CQR_NEED_ERP) {
-			if (cqr->irb.esw.esw0.erw.cons &&
-			    test_bit(DASD_CQR_FLAGS_USE_ERP,
-				     &cqr->flags)) {
-				erp_fn = base->discipline->erp_action(cqr);
-				erp_fn(cqr);
-			}
+			erp_fn = base->discipline->erp_action(cqr);
+			erp_fn(cqr);
 			goto restart;
 		}
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
