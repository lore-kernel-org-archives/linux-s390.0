Return-Path: <linux-kernel-owner+w=401wt.eu-S1761062AbZBYPLo@vger.kernel.org>
Message-Id: <20090225150829.154112047@de.ibm.com>
References: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:06:30 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 08/46] dasd: add High Performance FICON support
Content-Disposition: inline; filename=107-dasd-hpf.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Weinhuber <wein@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Weinhuber <wein@de.ibm.com>

To support High Performance FICON, the DASD device driver has to
translate I/O requests into the new transport mode control words (TCW)
instead of the traditional (command mode) CCW requests.

Signed-off-by: Stefan Weinhuber <wein@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/idals.h      |   17 
 drivers/s390/block/dasd.c          |   70 ++
 drivers/s390/block/dasd_3990_erp.c |  141 +++--
 drivers/s390/block/dasd_alias.c    |   25 
 drivers/s390/block/dasd_devmap.c   |    7 
 drivers/s390/block/dasd_eckd.c     |  970 +++++++++++++++++++++++++++++++++----
 drivers/s390/block/dasd_eckd.h     |   40 +
 drivers/s390/block/dasd_eer.c      |   21 
 drivers/s390/block/dasd_int.h      |    5 
 9 files changed, 1121 insertions(+), 175 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/idals.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/idals.h
+++ quilt-2.6/arch/s390/include/asm/idals.h
@@ -44,24 +44,18 @@ idal_is_needed(void *vaddr, unsigned int
 /*
  * Return the number of idal words needed for an address/length pair.
  */
-static inline unsigned int
-idal_nr_words(void *vaddr, unsigned int length)
+static inline unsigned int idal_nr_words(void *vaddr, unsigned int length)
 {
-#ifdef __s390x__
-	if (idal_is_needed(vaddr, length))
-		return ((__pa(vaddr) & (IDA_BLOCK_SIZE-1)) + length + 
-			(IDA_BLOCK_SIZE-1)) >> IDA_SIZE_LOG;
-#endif
-	return 0;
+	return ((__pa(vaddr) & (IDA_BLOCK_SIZE-1)) + length +
+		(IDA_BLOCK_SIZE-1)) >> IDA_SIZE_LOG;
 }
 
 /*
  * Create the list of idal words for an address/length pair.
  */
-static inline unsigned long *
-idal_create_words(unsigned long *idaws, void *vaddr, unsigned int length)
+static inline unsigned long *idal_create_words(unsigned long *idaws,
+					       void *vaddr, unsigned int length)
 {
-#ifdef __s390x__
 	unsigned long paddr;
 	unsigned int cidaw;
 
@@ -74,7 +68,6 @@ idal_create_words(unsigned long *idaws, 
 		paddr += IDA_BLOCK_SIZE;
 		*idaws++ = paddr;
 	}
-#endif
 	return idaws;
 }
 
Index: quilt-2.6/drivers/s390/block/dasd_3990_erp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_3990_erp.c
+++ quilt-2.6/drivers/s390/block/dasd_3990_erp.c
@@ -1573,6 +1573,13 @@ dasd_3990_erp_action_1B_32(struct dasd_c
 		cqr = cqr->refers;
 	}
 
+	if (scsw_is_tm(&cqr->irb.scsw)) {
+		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
+			      "32 bit sense, action 1B is not defined"
+			      " in transport mode - just retry");
+		return default_erp;
+	}
+
 	/* for imprecise ending just do default erp */
 	if (sense[1] & 0x01) {
 		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
@@ -1611,7 +1618,7 @@ dasd_3990_erp_action_1B_32(struct dasd_c
 	oldccw = cqr->cpaddr;
 	if (oldccw->cmd_code == DASD_ECKD_CCW_PFX) {
 		PFX_data = cqr->data;
-		memcpy(DE_data, &PFX_data->define_extend,
+		memcpy(DE_data, &PFX_data->define_extent,
 		       sizeof(struct DE_eckd_data));
 	} else
 		memcpy(DE_data, cqr->data, sizeof(struct DE_eckd_data));
@@ -1721,6 +1728,13 @@ dasd_3990_update_1B(struct dasd_ccw_req 
 		cqr = cqr->refers;
 	}
 
+	if (scsw_is_tm(&cqr->irb.scsw)) {
+		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
+			      "32 bit sense, action 1B, update,"
+			      " in transport mode - just retry");
+		return previous_erp;
+	}
+
 	/* for imprecise ending just do default erp */
 	if (sense[1] & 0x01) {
 		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
@@ -2170,7 +2184,7 @@ dasd_3990_erp_control_check(struct dasd_
 {
 	struct dasd_device *device = erp->startdev;
 
-	if (erp->refers->irb.scsw.cmd.cstat & (SCHN_STAT_INTF_CTRL_CHK
+	if (scsw_cstat(&erp->refers->irb.scsw) & (SCHN_STAT_INTF_CTRL_CHK
 					   | SCHN_STAT_CHN_CTRL_CHK)) {
 		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			    "channel or interface control check");
@@ -2192,21 +2206,23 @@ dasd_3990_erp_control_check(struct dasd_
  *   erp_new		contens was possibly modified
  */
 static struct dasd_ccw_req *
-dasd_3990_erp_inspect(struct dasd_ccw_req * erp)
+dasd_3990_erp_inspect(struct dasd_ccw_req *erp)
 {
 
 	struct dasd_ccw_req *erp_new = NULL;
-	/* sense data are located in the refers record of the */
-	/* already set up new ERP !			      */
-	char *sense = erp->refers->irb.ecw;
+	char *sense;
 
 	/* if this problem occured on an alias retry on base */
 	erp_new = dasd_3990_erp_inspect_alias(erp);
 	if (erp_new)
 		return erp_new;
 
-	/* check if no concurrent sens is available */
-	if (!erp->refers->irb.esw.esw0.erw.cons)
+	/* sense data are located in the refers record of the
+	 * already set up new ERP !
+	 * check if concurrent sens is available
+	 */
+	sense = dasd_get_sense(&erp->refers->irb);
+	if (!sense)
 		erp_new = dasd_3990_erp_control_check(erp);
 	/* distinguish between 24 and 32 byte sense data */
 	else if (sense[27] & DASD_SENSE_BIT_0) {
@@ -2230,7 +2246,11 @@ dasd_3990_erp_inspect(struct dasd_ccw_re
  * DESCRIPTION
  *   This funtion adds an additional request block (ERP) to the head of
  *   the given cqr (or erp).
- *   This erp is initialized as an default erp (retry TIC)
+ *   For a command mode cqr the erp is initialized as an default erp
+ *   (retry TIC).
+ *   For transport mode we make a copy of the original TCW (points to
+ *   the original TCCB, TIDALs, etc.) but give it a fresh
+ *   TSB so the original sense data will not be changed.
  *
  * PARAMETER
  *   cqr		head of the current ERP-chain (or single cqr if
@@ -2238,17 +2258,27 @@ dasd_3990_erp_inspect(struct dasd_ccw_re
  * RETURN VALUES
  *   erp		pointer to new ERP-chain head
  */
-static struct dasd_ccw_req *
-dasd_3990_erp_add_erp(struct dasd_ccw_req * cqr)
+static struct dasd_ccw_req *dasd_3990_erp_add_erp(struct dasd_ccw_req *cqr)
 {
 
 	struct dasd_device *device = cqr->startdev;
 	struct ccw1 *ccw;
-
-	/* allocate additional request block */
 	struct dasd_ccw_req *erp;
+	int cplength, datasize;
+	struct tcw *tcw;
+	struct tsb *tsb;
+
+	if (cqr->cpmode == 1) {
+		cplength = 0;
+		datasize = sizeof(struct tcw) + sizeof(struct tsb);
+	} else {
+		cplength = 2;
+		datasize = 0;
+	}
 
-	erp = dasd_alloc_erp_request((char *) &cqr->magic, 2, 0, device);
+	/* allocate additional request block */
+	erp = dasd_alloc_erp_request((char *) &cqr->magic,
+				     cplength, datasize, device);
 	if (IS_ERR(erp)) {
                 if (cqr->retries <= 0) {
 			DBF_DEV_EVENT(DBF_ERR, device, "%s",
@@ -2265,13 +2295,24 @@ dasd_3990_erp_add_erp(struct dasd_ccw_re
 		return cqr;
 	}
 
-	/* initialize request with default TIC to current ERP/CQR */
-	ccw = erp->cpaddr;
-	ccw->cmd_code = CCW_CMD_NOOP;
-	ccw->flags = CCW_FLAG_CC;
-	ccw++;
-	ccw->cmd_code = CCW_CMD_TIC;
-	ccw->cda      = (long)(cqr->cpaddr);
+	if (cqr->cpmode == 1) {
+		/* make a shallow copy of the original tcw but set new tsb */
+		erp->cpmode = 1;
+		erp->cpaddr = erp->data;
+		tcw = erp->data;
+		tsb = (struct tsb *) &tcw[1];
+		*tcw = *((struct tcw *)cqr->cpaddr);
+		tcw->tsb = (long)tsb;
+	} else {
+		/* initialize request with default TIC to current ERP/CQR */
+		ccw = erp->cpaddr;
+		ccw->cmd_code = CCW_CMD_NOOP;
+		ccw->flags = CCW_FLAG_CC;
+		ccw++;
+		ccw->cmd_code = CCW_CMD_TIC;
+		ccw->cda      = (long)(cqr->cpaddr);
+	}
+
 	erp->function = dasd_3990_erp_add_erp;
 	erp->refers   = cqr;
 	erp->startdev = device;
@@ -2281,7 +2322,6 @@ dasd_3990_erp_add_erp(struct dasd_ccw_re
 	erp->expires  = 0;
 	erp->retries  = 256;
 	erp->buildclk = get_clock();
-
 	erp->status = DASD_CQR_FILLED;
 
 	return erp;
@@ -2339,28 +2379,33 @@ dasd_3990_erp_additional_erp(struct dasd
  *   match		'boolean' for match found
  *			returns 1 if match found, otherwise 0.
  */
-static int
-dasd_3990_erp_error_match(struct dasd_ccw_req *cqr1, struct dasd_ccw_req *cqr2)
+static int dasd_3990_erp_error_match(struct dasd_ccw_req *cqr1,
+				     struct dasd_ccw_req *cqr2)
 {
+	char *sense1, *sense2;
 
 	if (cqr1->startdev != cqr2->startdev)
 		return 0;
 
-	if (cqr1->irb.esw.esw0.erw.cons != cqr2->irb.esw.esw0.erw.cons)
-		return 0;
+	sense1 = dasd_get_sense(&cqr1->irb);
+	sense2 = dasd_get_sense(&cqr2->irb);
 
-	if ((cqr1->irb.esw.esw0.erw.cons == 0) &&
-	    (cqr2->irb.esw.esw0.erw.cons == 0))	{
-		if ((cqr1->irb.scsw.cmd.cstat & (SCHN_STAT_INTF_CTRL_CHK |
-					     SCHN_STAT_CHN_CTRL_CHK)) ==
-		    (cqr2->irb.scsw.cmd.cstat & (SCHN_STAT_INTF_CTRL_CHK |
-					     SCHN_STAT_CHN_CTRL_CHK)))
+	/* one request has sense data, the other not -> no match, return 0 */
+	if (!sense1 != !sense2)
+		return 0;
+	/* no sense data in both cases -> check cstat for IFCC */
+	if (!sense1 && !sense2)	{
+		if ((scsw_cstat(&cqr1->irb.scsw) & (SCHN_STAT_INTF_CTRL_CHK |
+						    SCHN_STAT_CHN_CTRL_CHK)) ==
+		    (scsw_cstat(&cqr2->irb.scsw) & (SCHN_STAT_INTF_CTRL_CHK |
+						    SCHN_STAT_CHN_CTRL_CHK)))
 			return 1; /* match with ifcc*/
 	}
 	/* check sense data; byte 0-2,25,27 */
-	if (!((memcmp (cqr1->irb.ecw, cqr2->irb.ecw, 3) == 0) &&
-	      (cqr1->irb.ecw[27] == cqr2->irb.ecw[27]) &&
-	      (cqr1->irb.ecw[25] == cqr2->irb.ecw[25]))) {
+	if (!(sense1 && sense2 &&
+	      (memcmp(sense1, sense2, 3) == 0) &&
+	      (sense1[27] == sense2[27]) &&
+	      (sense1[25] == sense2[25]))) {
 
 		return 0;	/* sense doesn't match */
 	}
@@ -2433,7 +2478,7 @@ dasd_3990_erp_further_erp(struct dasd_cc
 {
 
 	struct dasd_device *device = erp->startdev;
-	char *sense = erp->irb.ecw;
+	char *sense = dasd_get_sense(&erp->irb);
 
 	/* check for 24 byte sense ERP */
 	if ((erp->function == dasd_3990_erp_bus_out) ||
@@ -2448,7 +2493,7 @@ dasd_3990_erp_further_erp(struct dasd_cc
 		/* prepare erp for retry on different channel path */
 		erp = dasd_3990_erp_action_1(erp);
 
-		if (!(sense[2] & DASD_SENSE_BIT_0)) {
+		if (sense && !(sense[2] & DASD_SENSE_BIT_0)) {
 
 			/* issue a Diagnostic Control command with an
 			 * Inhibit Write subcommand */
@@ -2478,10 +2523,11 @@ dasd_3990_erp_further_erp(struct dasd_cc
 		}
 
 		/* check for 32 byte sense ERP */
-	} else if ((erp->function == dasd_3990_erp_compound_retry) ||
-		   (erp->function == dasd_3990_erp_compound_path) ||
-		   (erp->function == dasd_3990_erp_compound_code) ||
-		   (erp->function == dasd_3990_erp_compound_config)) {
+	} else if (sense &&
+		   ((erp->function == dasd_3990_erp_compound_retry) ||
+		    (erp->function == dasd_3990_erp_compound_path) ||
+		    (erp->function == dasd_3990_erp_compound_code) ||
+		    (erp->function == dasd_3990_erp_compound_config))) {
 
 		erp = dasd_3990_erp_compound(erp, sense);
 
@@ -2548,18 +2594,19 @@ dasd_3990_erp_handle_match_erp(struct da
 
 	if (erp->retries > 0) {
 
-		char *sense = erp->refers->irb.ecw;
+		char *sense = dasd_get_sense(&erp->refers->irb);
 
 		/* check for special retries */
-		if (erp->function == dasd_3990_erp_action_4) {
+		if (sense && erp->function == dasd_3990_erp_action_4) {
 
 			erp = dasd_3990_erp_action_4(erp, sense);
 
-		} else if (erp->function == dasd_3990_erp_action_1B_32) {
+		} else if (sense &&
+			   erp->function == dasd_3990_erp_action_1B_32) {
 
 			erp = dasd_3990_update_1B(erp, sense);
 
-		} else if (erp->function == dasd_3990_erp_int_req) {
+		} else if (sense && erp->function == dasd_3990_erp_int_req) {
 
 			erp = dasd_3990_erp_int_req(erp);
 
@@ -2622,8 +2669,8 @@ dasd_3990_erp_action(struct dasd_ccw_req
 	}
 
 	/* double-check if current erp/cqr was successful */
-	if ((cqr->irb.scsw.cmd.cstat == 0x00) &&
-	    (cqr->irb.scsw.cmd.dstat ==
+	if ((scsw_cstat(&cqr->irb.scsw) == 0x00) &&
+	    (scsw_dstat(&cqr->irb.scsw) ==
 	     (DEV_STAT_CHN_END | DEV_STAT_DEV_END))) {
 
 		DBF_DEV_EVENT(DBF_DEBUG, device,
Index: quilt-2.6/drivers/s390/block/dasd_alias.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_alias.c
+++ quilt-2.6/drivers/s390/block/dasd_alias.c
@@ -646,14 +646,16 @@ static int reset_summary_unit_check(stru
 {
 	struct dasd_ccw_req *cqr;
 	int rc = 0;
+	struct ccw1 *ccw;
 
 	cqr = lcu->rsu_cqr;
 	strncpy((char *) &cqr->magic, "ECKD", 4);
 	ASCEBC((char *) &cqr->magic, 4);
-	cqr->cpaddr->cmd_code = DASD_ECKD_CCW_RSCK;
-	cqr->cpaddr->flags = 0 ;
-	cqr->cpaddr->count = 16;
-	cqr->cpaddr->cda = (__u32)(addr_t) cqr->data;
+	ccw = cqr->cpaddr;
+	ccw->cmd_code = DASD_ECKD_CCW_RSCK;
+	ccw->flags = 0 ;
+	ccw->count = 16;
+	ccw->cda = (__u32)(addr_t) cqr->data;
 	((char *)cqr->data)[0] = reason;
 
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
@@ -855,12 +857,21 @@ void dasd_alias_handle_summary_unit_chec
 	struct alias_lcu *lcu;
 	char reason;
 	struct dasd_eckd_private *private;
+	char *sense;
 
 	private = (struct dasd_eckd_private *) device->private;
 
-	reason = irb->ecw[8];
-	DBF_DEV_EVENT(DBF_WARNING, device, "%s %x",
-		    "eckd handle summary unit check: reason", reason);
+	sense = dasd_get_sense(irb);
+	if (sense) {
+		reason = sense[8];
+		DBF_DEV_EVENT(DBF_NOTICE, device, "%s %x",
+			    "eckd handle summary unit check: reason", reason);
+	} else {
+		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
+			    "eckd handle summary unit check:"
+			    " no reason code available");
+		return;
+	}
 
 	lcu = private->lcu;
 	if (!lcu) {
Index: quilt-2.6/drivers/s390/block/dasd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd.c
+++ quilt-2.6/drivers/s390/block/dasd.c
@@ -25,6 +25,7 @@
 #include <asm/ebcdic.h>
 #include <asm/idals.h>
 #include <asm/todclk.h>
+#include <asm/itcw.h>
 
 /* This is ugly... */
 #define PRINTK_HEADER "dasd:"
@@ -856,8 +857,13 @@ int dasd_start_IO(struct dasd_ccw_req *c
 	cqr->startclk = get_clock();
 	cqr->starttime = jiffies;
 	cqr->retries--;
-	rc = ccw_device_start(device->cdev, cqr->cpaddr, (long) cqr,
-			      cqr->lpm, 0);
+	if (cqr->cpmode == 1) {
+		rc = ccw_device_tm_start(device->cdev, cqr->cpaddr,
+					 (long) cqr, cqr->lpm);
+	} else {
+		rc = ccw_device_start(device->cdev, cqr->cpaddr,
+				      (long) cqr, cqr->lpm, 0);
+	}
 	switch (rc) {
 	case 0:
 		cqr->status = DASD_CQR_IN_IO;
@@ -885,9 +891,12 @@ int dasd_start_IO(struct dasd_ccw_req *c
 			      " retry on all pathes");
 		break;
 	case -ENODEV:
+		DBF_DEV_EVENT(DBF_DEBUG, device, "%s",
+			      "start_IO: -ENODEV device gone, retry");
+		break;
 	case -EIO:
 		DBF_DEV_EVENT(DBF_DEBUG, device, "%s",
-			      "start_IO: device gone, retry");
+			      "start_IO: -EIO device gone, retry");
 		break;
 	default:
 		/* internal error 11 - unknown rc */
@@ -1017,9 +1026,9 @@ void dasd_int_handler(struct ccw_device 
 
 	/* check for unsolicited interrupts */
 	cqr = (struct dasd_ccw_req *) intparm;
-	if (!cqr || ((irb->scsw.cmd.cc == 1) &&
-		     (irb->scsw.cmd.fctl & SCSW_FCTL_START_FUNC) &&
-		     (irb->scsw.cmd.stctl & SCSW_STCTL_STATUS_PEND))) {
+	if (!cqr || ((scsw_cc(&irb->scsw) == 1) &&
+		     (scsw_fctl(&irb->scsw) & SCSW_FCTL_START_FUNC) &&
+		     (scsw_stctl(&irb->scsw) & SCSW_STCTL_STATUS_PEND))) {
 		if (cqr && cqr->status == DASD_CQR_IN_IO)
 			cqr->status = DASD_CQR_QUEUED;
 		device = dasd_device_from_cdev_locked(cdev);
@@ -1042,7 +1051,7 @@ void dasd_int_handler(struct ccw_device 
 
 	/* Check for clear pending */
 	if (cqr->status == DASD_CQR_CLEAR_PENDING &&
-	    irb->scsw.cmd.fctl & SCSW_FCTL_CLEAR_FUNC) {
+	    scsw_fctl(&irb->scsw) & SCSW_FCTL_CLEAR_FUNC) {
 		cqr->status = DASD_CQR_CLEARED;
 		dasd_device_clear_timer(device);
 		wake_up(&dasd_flush_wq);
@@ -1050,7 +1059,7 @@ void dasd_int_handler(struct ccw_device 
 		return;
 	}
 
- 	/* check status - the request might have been killed by dyn detach */
+	/* check status - the request might have been killed by dyn detach */
 	if (cqr->status != DASD_CQR_IN_IO) {
 		MESSAGE(KERN_DEBUG,
 			"invalid status: bus_id %s, status %02x",
@@ -1060,8 +1069,8 @@ void dasd_int_handler(struct ccw_device 
 
 	next = NULL;
 	expires = 0;
-	if (irb->scsw.cmd.dstat == (DEV_STAT_CHN_END | DEV_STAT_DEV_END) &&
-	    irb->scsw.cmd.cstat == 0 && !irb->esw.esw0.erw.cons) {
+	if (scsw_dstat(&irb->scsw) == (DEV_STAT_CHN_END | DEV_STAT_DEV_END) &&
+	    scsw_cstat(&irb->scsw) == 0) {
 		/* request was completed successfully */
 		cqr->status = DASD_CQR_SUCCESS;
 		cqr->stopclk = now;
@@ -1992,8 +2001,11 @@ static void dasd_setup_queue(struct dasd
 	blk_queue_max_sectors(block->request_queue, max);
 	blk_queue_max_phys_segments(block->request_queue, -1L);
 	blk_queue_max_hw_segments(block->request_queue, -1L);
-	blk_queue_max_segment_size(block->request_queue, -1L);
-	blk_queue_segment_boundary(block->request_queue, -1L);
+	/* with page sized segments we can translate each segement into
+	 * one idaw/tidaw
+	 */
+	blk_queue_max_segment_size(block->request_queue, PAGE_SIZE);
+	blk_queue_segment_boundary(block->request_queue, PAGE_SIZE - 1);
 	blk_queue_ordered(block->request_queue, QUEUE_ORDERED_DRAIN, NULL);
 }
 
@@ -2431,6 +2443,40 @@ int dasd_generic_read_dev_chars(struct d
 }
 EXPORT_SYMBOL_GPL(dasd_generic_read_dev_chars);
 
+/*
+ *   In command mode and transport mode we need to look for sense
+ *   data in different places. The sense data itself is allways
+ *   an array of 32 bytes, so we can unify the sense data access
+ *   for both modes.
+ */
+char *dasd_get_sense(struct irb *irb)
+{
+	struct tsb *tsb = NULL;
+	char *sense = NULL;
+
+	if (scsw_is_tm(&irb->scsw) && (irb->scsw.tm.fcxs == 0x01)) {
+		if (irb->scsw.tm.tcw)
+			tsb = tcw_get_tsb((struct tcw *)(unsigned long)
+					  irb->scsw.tm.tcw);
+		if (tsb && tsb->length == 64 && tsb->flags)
+			switch (tsb->flags & 0x07) {
+			case 1:	/* tsa_iostat */
+				sense = tsb->tsa.iostat.sense;
+				break;
+			case 2: /* tsa_ddpc */
+				sense = tsb->tsa.ddpc.sense;
+				break;
+			default:
+				/* currently we don't use interrogate data */
+				break;
+			}
+	} else if (irb->esw.esw0.erw.cons) {
+		sense = irb->ecw;
+	}
+	return sense;
+}
+EXPORT_SYMBOL_GPL(dasd_get_sense);
+
 static int __init dasd_init(void)
 {
 	int rc;
Index: quilt-2.6/drivers/s390/block/dasd_devmap.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_devmap.c
+++ quilt-2.6/drivers/s390/block/dasd_devmap.c
@@ -67,6 +67,8 @@ int dasd_probeonly =  0;	/* is true, whe
 int dasd_autodetect = 0;	/* is true, when autodetection is active */
 int dasd_nopav = 0;		/* is true, when PAV is disabled */
 EXPORT_SYMBOL_GPL(dasd_nopav);
+int dasd_nofcx;			/* disable High Performance Ficon */
+EXPORT_SYMBOL_GPL(dasd_nofcx);
 
 /*
  * char *dasd[] is intended to hold the ranges supplied by the dasd= statement
@@ -272,6 +274,11 @@ dasd_parse_keyword( char *parsestring ) 
 		}
 		return residual_str;
 	}
+	if (strncmp("nofcx", parsestring, length) == 0) {
+		dasd_nofcx = 1;
+		MESSAGE(KERN_INFO, "%s", "disable High Performance Ficon");
+		return residual_str;
+	}
 	if (strncmp("fixedbuffers", parsestring, length) == 0) {
 		if (dasd_page_cache)
 			return residual_str;
Index: quilt-2.6/drivers/s390/block/dasd_eckd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_eckd.c
+++ quilt-2.6/drivers/s390/block/dasd_eckd.c
@@ -29,9 +29,12 @@
 #include <asm/uaccess.h>
 #include <asm/cio.h>
 #include <asm/ccwdev.h>
+#include <asm/itcw.h>
 
 #include "dasd_int.h"
 #include "dasd_eckd.h"
+#include "../cio/chsc.h"
+
 
 #ifdef PRINTK_HEADER
 #undef PRINTK_HEADER
@@ -292,30 +295,145 @@ static int check_XRC_on_prefix(struct PF
 		return 0;
 
 	/* switch on System Time Stamp - needed for XRC Support */
-	pfxdata->define_extend.ga_extended |= 0x08; /* 'Time Stamp Valid'   */
-	pfxdata->define_extend.ga_extended |= 0x02; /* 'Extended Parameter' */
+	pfxdata->define_extent.ga_extended |= 0x08; /* 'Time Stamp Valid'   */
+	pfxdata->define_extent.ga_extended |= 0x02; /* 'Extended Parameter' */
 	pfxdata->validity.time_stamp = 1;	    /* 'Time Stamp Valid'   */
 
-	rc = get_sync_clock(&pfxdata->define_extend.ep_sys_time);
+	rc = get_sync_clock(&pfxdata->define_extent.ep_sys_time);
 	/* Ignore return code if sync clock is switched off. */
 	if (rc == -ENOSYS || rc == -EACCES)
 		rc = 0;
 	return rc;
 }
 
-static int prefix(struct ccw1 *ccw, struct PFX_eckd_data *pfxdata,
-		  unsigned int trk, unsigned int totrk, int cmd,
-		  struct dasd_device *basedev, struct dasd_device *startdev)
+static void fill_LRE_data(struct LRE_eckd_data *data, unsigned int trk,
+			  unsigned int rec_on_trk, int count, int cmd,
+			  struct dasd_device *device, unsigned int reclen,
+			  unsigned int tlf)
+{
+	struct dasd_eckd_private *private;
+	int sector;
+	int dn, d;
+
+	private = (struct dasd_eckd_private *) device->private;
+
+	memset(data, 0, sizeof(*data));
+	sector = 0;
+	if (rec_on_trk) {
+		switch (private->rdc_data.dev_type) {
+		case 0x3390:
+			dn = ceil_quot(reclen + 6, 232);
+			d = 9 + ceil_quot(reclen + 6 * (dn + 1), 34);
+			sector = (49 + (rec_on_trk - 1) * (10 + d)) / 8;
+			break;
+		case 0x3380:
+			d = 7 + ceil_quot(reclen + 12, 32);
+			sector = (39 + (rec_on_trk - 1) * (8 + d)) / 7;
+			break;
+		}
+	}
+	data->sector = sector;
+	/* note: meaning of count depends on the operation
+	 *	 for record based I/O it's the number of records, but for
+	 *	 track based I/O it's the number of tracks
+	 */
+	data->count = count;
+	switch (cmd) {
+	case DASD_ECKD_CCW_WRITE_HOME_ADDRESS:
+		data->operation.orientation = 0x3;
+		data->operation.operation = 0x03;
+		break;
+	case DASD_ECKD_CCW_READ_HOME_ADDRESS:
+		data->operation.orientation = 0x3;
+		data->operation.operation = 0x16;
+		break;
+	case DASD_ECKD_CCW_WRITE_RECORD_ZERO:
+		data->operation.orientation = 0x1;
+		data->operation.operation = 0x03;
+		data->count++;
+		break;
+	case DASD_ECKD_CCW_READ_RECORD_ZERO:
+		data->operation.orientation = 0x3;
+		data->operation.operation = 0x16;
+		data->count++;
+		break;
+	case DASD_ECKD_CCW_WRITE:
+	case DASD_ECKD_CCW_WRITE_MT:
+	case DASD_ECKD_CCW_WRITE_KD:
+	case DASD_ECKD_CCW_WRITE_KD_MT:
+		data->auxiliary.length_valid = 0x1;
+		data->length = reclen;
+		data->operation.operation = 0x01;
+		break;
+	case DASD_ECKD_CCW_WRITE_CKD:
+	case DASD_ECKD_CCW_WRITE_CKD_MT:
+		data->auxiliary.length_valid = 0x1;
+		data->length = reclen;
+		data->operation.operation = 0x03;
+		break;
+	case DASD_ECKD_CCW_WRITE_TRACK_DATA:
+		data->auxiliary.length_valid = 0x1;
+		data->length = reclen;	/* not tlf, as one might think */
+		data->operation.operation = 0x3F;
+		data->extended_operation = 0x23;
+		break;
+	case DASD_ECKD_CCW_READ:
+	case DASD_ECKD_CCW_READ_MT:
+	case DASD_ECKD_CCW_READ_KD:
+	case DASD_ECKD_CCW_READ_KD_MT:
+		data->auxiliary.length_valid = 0x1;
+		data->length = reclen;
+		data->operation.operation = 0x06;
+		break;
+	case DASD_ECKD_CCW_READ_CKD:
+	case DASD_ECKD_CCW_READ_CKD_MT:
+		data->auxiliary.length_valid = 0x1;
+		data->length = reclen;
+		data->operation.operation = 0x16;
+		break;
+	case DASD_ECKD_CCW_READ_COUNT:
+		data->operation.operation = 0x06;
+		break;
+	case DASD_ECKD_CCW_READ_TRACK_DATA:
+		data->auxiliary.length_valid = 0x1;
+		data->length = tlf;
+		data->operation.operation = 0x0C;
+		break;
+	case DASD_ECKD_CCW_ERASE:
+		data->length = reclen;
+		data->auxiliary.length_valid = 0x1;
+		data->operation.operation = 0x0b;
+		break;
+	default:
+		DBF_DEV_EVENT(DBF_ERR, device,
+			    "fill LRE unknown opcode 0x%x", cmd);
+		BUG();
+	}
+	set_ch_t(&data->seek_addr,
+		 trk / private->rdc_data.trk_per_cyl,
+		 trk % private->rdc_data.trk_per_cyl);
+	data->search_arg.cyl = data->seek_addr.cyl;
+	data->search_arg.head = data->seek_addr.head;
+	data->search_arg.record = rec_on_trk;
+}
+
+static int prefix_LRE(struct ccw1 *ccw, struct PFX_eckd_data *pfxdata,
+		      unsigned int trk, unsigned int totrk, int cmd,
+		      struct dasd_device *basedev, struct dasd_device *startdev,
+		      unsigned char format, unsigned int rec_on_trk, int count,
+		      unsigned int blksize, unsigned int tlf)
 {
 	struct dasd_eckd_private *basepriv, *startpriv;
-	struct DE_eckd_data *data;
+	struct DE_eckd_data *dedata;
+	struct LRE_eckd_data *lredata;
 	u32 begcyl, endcyl;
 	u16 heads, beghead, endhead;
 	int rc = 0;
 
 	basepriv = (struct dasd_eckd_private *) basedev->private;
 	startpriv = (struct dasd_eckd_private *) startdev->private;
-	data = &pfxdata->define_extend;
+	dedata = &pfxdata->define_extent;
+	lredata = &pfxdata->locate_record;
 
 	ccw->cmd_code = DASD_ECKD_CCW_PFX;
 	ccw->flags = 0;
@@ -324,10 +442,16 @@ static int prefix(struct ccw1 *ccw, stru
 
 	memset(pfxdata, 0, sizeof(*pfxdata));
 	/* prefix data */
-	pfxdata->format = 0;
+	if (format > 1) {
+		DBF_DEV_EVENT(DBF_ERR, basedev,
+			      "PFX LRE unknown format 0x%x", format);
+		BUG();
+		return -EINVAL;
+	}
+	pfxdata->format = format;
 	pfxdata->base_address = basepriv->ned->unit_addr;
 	pfxdata->base_lss = basepriv->ned->ID;
-	pfxdata->validity.define_extend = 1;
+	pfxdata->validity.define_extent = 1;
 
 	/* private uid is kept up to date, conf_data may be outdated */
 	if (startpriv->uid.type != UA_BASE_DEVICE) {
@@ -347,43 +471,55 @@ static int prefix(struct ccw1 *ccw, stru
 	case DASD_ECKD_CCW_READ_KD:
 	case DASD_ECKD_CCW_READ_KD_MT:
 	case DASD_ECKD_CCW_READ_COUNT:
-		data->mask.perm = 0x1;
-		data->attributes.operation = basepriv->attrib.operation;
+		dedata->mask.perm = 0x1;
+		dedata->attributes.operation = basepriv->attrib.operation;
+		break;
+	case DASD_ECKD_CCW_READ_TRACK_DATA:
+		dedata->mask.perm = 0x1;
+		dedata->attributes.operation = basepriv->attrib.operation;
+		dedata->blk_size = 0;
 		break;
 	case DASD_ECKD_CCW_WRITE:
 	case DASD_ECKD_CCW_WRITE_MT:
 	case DASD_ECKD_CCW_WRITE_KD:
 	case DASD_ECKD_CCW_WRITE_KD_MT:
-		data->mask.perm = 0x02;
-		data->attributes.operation = basepriv->attrib.operation;
+		dedata->mask.perm = 0x02;
+		dedata->attributes.operation = basepriv->attrib.operation;
 		rc = check_XRC_on_prefix(pfxdata, basedev);
 		break;
 	case DASD_ECKD_CCW_WRITE_CKD:
 	case DASD_ECKD_CCW_WRITE_CKD_MT:
-		data->attributes.operation = DASD_BYPASS_CACHE;
+		dedata->attributes.operation = DASD_BYPASS_CACHE;
 		rc = check_XRC_on_prefix(pfxdata, basedev);
 		break;
 	case DASD_ECKD_CCW_ERASE:
 	case DASD_ECKD_CCW_WRITE_HOME_ADDRESS:
 	case DASD_ECKD_CCW_WRITE_RECORD_ZERO:
-		data->mask.perm = 0x3;
-		data->mask.auth = 0x1;
-		data->attributes.operation = DASD_BYPASS_CACHE;
+		dedata->mask.perm = 0x3;
+		dedata->mask.auth = 0x1;
+		dedata->attributes.operation = DASD_BYPASS_CACHE;
 		rc = check_XRC_on_prefix(pfxdata, basedev);
 		break;
-	default:
-		DBF_DEV_EVENT(DBF_ERR, basedev, "unknown prefix opcode 0x%x",
-			      cmd);
+	case DASD_ECKD_CCW_WRITE_TRACK_DATA:
+		dedata->mask.perm = 0x02;
+		dedata->attributes.operation = basepriv->attrib.operation;
+		dedata->blk_size = blksize;
+		rc = check_XRC_on_prefix(pfxdata, basedev);
 		break;
+	default:
+		DBF_DEV_EVENT(DBF_ERR, basedev,
+			    "PFX LRE unknown opcode 0x%x", cmd);
+		BUG();
+		return -EINVAL;
 	}
 
-	data->attributes.mode = 0x3;	/* ECKD */
+	dedata->attributes.mode = 0x3;	/* ECKD */
 
 	if ((basepriv->rdc_data.cu_type == 0x2105 ||
 	     basepriv->rdc_data.cu_type == 0x2107 ||
 	     basepriv->rdc_data.cu_type == 0x1750)
 	    && !(basepriv->uses_cdl && trk < 2))
-		data->ga_extended |= 0x40; /* Regular Data Format Mode */
+		dedata->ga_extended |= 0x40; /* Regular Data Format Mode */
 
 	heads = basepriv->rdc_data.trk_per_cyl;
 	begcyl = trk / heads;
@@ -392,8 +528,8 @@ static int prefix(struct ccw1 *ccw, stru
 	endhead = totrk % heads;
 
 	/* check for sequential prestage - enhance cylinder range */
-	if (data->attributes.operation == DASD_SEQ_PRESTAGE ||
-	    data->attributes.operation == DASD_SEQ_ACCESS) {
+	if (dedata->attributes.operation == DASD_SEQ_PRESTAGE ||
+	    dedata->attributes.operation == DASD_SEQ_ACCESS) {
 
 		if (endcyl + basepriv->attrib.nr_cyl < basepriv->real_cyl)
 			endcyl += basepriv->attrib.nr_cyl;
@@ -401,11 +537,25 @@ static int prefix(struct ccw1 *ccw, stru
 			endcyl = (basepriv->real_cyl - 1);
 	}
 
-	set_ch_t(&data->beg_ext, begcyl, beghead);
-	set_ch_t(&data->end_ext, endcyl, endhead);
+	set_ch_t(&dedata->beg_ext, begcyl, beghead);
+	set_ch_t(&dedata->end_ext, endcyl, endhead);
+
+	if (format == 1) {
+		fill_LRE_data(lredata, trk, rec_on_trk, count, cmd,
+			      basedev, blksize, tlf);
+	}
+
 	return rc;
 }
 
+static int prefix(struct ccw1 *ccw, struct PFX_eckd_data *pfxdata,
+		  unsigned int trk, unsigned int totrk, int cmd,
+		  struct dasd_device *basedev, struct dasd_device *startdev)
+{
+	return prefix_LRE(ccw, pfxdata, trk, totrk, cmd, basedev, startdev,
+			  0, 0, 0, 0, 0);
+}
+
 static void
 locate_record(struct ccw1 *ccw, struct LO_eckd_data *data, unsigned int trk,
 	      unsigned int rec_on_trk, int no_rec, int cmd,
@@ -853,7 +1003,8 @@ static int dasd_eckd_read_features(struc
 /*
  * Build CP for Perform Subsystem Function - SSC.
  */
-static struct dasd_ccw_req *dasd_eckd_build_psf_ssc(struct dasd_device *device)
+static struct dasd_ccw_req *dasd_eckd_build_psf_ssc(struct dasd_device *device,
+						    int enable_pav)
 {
 	struct dasd_ccw_req *cqr;
 	struct dasd_psf_ssc_data *psf_ssc_data;
@@ -870,9 +1021,11 @@ static struct dasd_ccw_req *dasd_eckd_bu
 	}
 	psf_ssc_data = (struct dasd_psf_ssc_data *)cqr->data;
 	psf_ssc_data->order = PSF_ORDER_SSC;
-	psf_ssc_data->suborder = 0x88;
-	psf_ssc_data->reserved[0] = 0x88;
-
+	psf_ssc_data->suborder = 0x40;
+	if (enable_pav) {
+		psf_ssc_data->suborder |= 0x88;
+		psf_ssc_data->reserved[0] = 0x88;
+	}
 	ccw = cqr->cpaddr;
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
 	ccw->cda = (__u32)(addr_t)psf_ssc_data;
@@ -893,12 +1046,12 @@ static struct dasd_ccw_req *dasd_eckd_bu
  * call might change behaviour of DASD devices.
  */
 static int
-dasd_eckd_psf_ssc(struct dasd_device *device)
+dasd_eckd_psf_ssc(struct dasd_device *device, int enable_pav)
 {
 	struct dasd_ccw_req *cqr;
 	int rc;
 
-	cqr = dasd_eckd_build_psf_ssc(device);
+	cqr = dasd_eckd_build_psf_ssc(device, enable_pav);
 	if (IS_ERR(cqr))
 		return PTR_ERR(cqr);
 
@@ -917,12 +1070,13 @@ static int dasd_eckd_validate_server(str
 {
 	int rc;
 	struct dasd_eckd_private *private;
+	int enable_pav;
 
-	/* Currently PAV is the only reason to 'validate' server on LPAR */
 	if (dasd_nopav || MACHINE_IS_VM)
-		return 0;
-
-	rc = dasd_eckd_psf_ssc(device);
+		enable_pav = 0;
+	else
+		enable_pav = 1;
+	rc = dasd_eckd_psf_ssc(device, enable_pav);
 	/* may be requested feature is not available on server,
 	 * therefore just report error and go ahead */
 	private = (struct dasd_eckd_private *) device->private;
@@ -1513,40 +1667,41 @@ static void dasd_eckd_handle_unsolicited
 						   struct irb *irb)
 {
 	char mask;
+	char *sense = NULL;
 
 	/* first of all check for state change pending interrupt */
 	mask = DEV_STAT_ATTENTION | DEV_STAT_DEV_END | DEV_STAT_UNIT_EXCEP;
-	if ((irb->scsw.cmd.dstat & mask) == mask) {
+	if ((scsw_dstat(&irb->scsw) & mask) == mask) {
 		dasd_generic_handle_state_change(device);
 		return;
 	}
 
 	/* summary unit check */
-	if ((irb->scsw.cmd.dstat & DEV_STAT_UNIT_CHECK) &&
+	if ((scsw_dstat(&irb->scsw) & DEV_STAT_UNIT_CHECK) &&
 	    (irb->ecw[7] == 0x0D)) {
 		dasd_alias_handle_summary_unit_check(device, irb);
 		return;
 	}
 
-
+	sense = dasd_get_sense(irb);
 	/* service information message SIM */
-	if (irb->esw.esw0.erw.cons && !(irb->ecw[27] & DASD_SENSE_BIT_0) &&
-	    ((irb->ecw[6] & DASD_SIM_SENSE) == DASD_SIM_SENSE)) {
-		dasd_3990_erp_handle_sim(device, irb->ecw);
+	if (sense && !(sense[27] & DASD_SENSE_BIT_0) &&
+	    ((sense[6] & DASD_SIM_SENSE) == DASD_SIM_SENSE)) {
+		dasd_3990_erp_handle_sim(device, sense);
 		dasd_schedule_device_bh(device);
 		return;
 	}
 
-	if ((irb->scsw.cmd.cc == 1) &&
-	    (irb->scsw.cmd.fctl & SCSW_FCTL_START_FUNC) &&
-	    (irb->scsw.cmd.actl & SCSW_ACTL_START_PEND) &&
-	    (irb->scsw.cmd.stctl & SCSW_STCTL_STATUS_PEND)) {
+	if ((scsw_cc(&irb->scsw) == 1) &&
+	    (scsw_fctl(&irb->scsw) & SCSW_FCTL_START_FUNC) &&
+	    (scsw_actl(&irb->scsw) & SCSW_ACTL_START_PEND) &&
+	    (scsw_stctl(&irb->scsw) & SCSW_STCTL_STATUS_PEND)) {
 		/* fake irb do nothing, they are handled elsewhere */
 		dasd_schedule_device_bh(device);
 		return;
 	}
 
-	if (!(irb->esw.esw0.erw.cons)) {
+	if (!sense) {
 		/* just report other unsolicited interrupts */
 		DBF_DEV_EVENT(DBF_ERR, device, "%s",
 			    "unsolicited interrupt received");
@@ -1562,9 +1717,19 @@ static void dasd_eckd_handle_unsolicited
 	return;
 };
 
-static struct dasd_ccw_req *dasd_eckd_build_cp(struct dasd_device *startdev,
+
+static struct dasd_ccw_req *dasd_eckd_build_cp_cmd_single(
+					       struct dasd_device *startdev,
 					       struct dasd_block *block,
-					       struct request *req)
+					       struct request *req,
+					       sector_t first_rec,
+					       sector_t last_rec,
+					       sector_t first_trk,
+					       sector_t last_trk,
+					       unsigned int first_offs,
+					       unsigned int last_offs,
+					       unsigned int blk_per_trk,
+					       unsigned int blksize)
 {
 	struct dasd_eckd_private *private;
 	unsigned long *idaws;
@@ -1574,11 +1739,9 @@ static struct dasd_ccw_req *dasd_eckd_bu
 	struct req_iterator iter;
 	struct bio_vec *bv;
 	char *dst;
-	unsigned int blksize, blk_per_trk, off;
+	unsigned int off;
 	int count, cidaw, cplength, datasize;
-	sector_t recid, first_rec, last_rec;
-	sector_t first_trk, last_trk;
-	unsigned int first_offs, last_offs;
+	sector_t recid;
 	unsigned char cmd, rcmd;
 	int use_prefix;
 	struct dasd_device *basedev;
@@ -1591,15 +1754,7 @@ static struct dasd_ccw_req *dasd_eckd_bu
 		cmd = DASD_ECKD_CCW_WRITE_MT;
 	else
 		return ERR_PTR(-EINVAL);
-	/* Calculate number of blocks/records per track. */
-	blksize = block->bp_block;
-	blk_per_trk = recs_per_track(&private->rdc_data, 0, blksize);
-	/* Calculate record id of first and last block. */
-	first_rec = first_trk = req->sector >> block->s2b_shift;
-	first_offs = sector_div(first_trk, blk_per_trk);
-	last_rec = last_trk =
-		(req->sector + req->nr_sectors - 1) >> block->s2b_shift;
-	last_offs = sector_div(last_trk, blk_per_trk);
+
 	/* Check struct bio and count the number of blocks for the request. */
 	count = 0;
 	cidaw = 0;
@@ -1749,6 +1904,497 @@ static struct dasd_ccw_req *dasd_eckd_bu
 	return cqr;
 }
 
+static struct dasd_ccw_req *dasd_eckd_build_cp_cmd_track(
+					       struct dasd_device *startdev,
+					       struct dasd_block *block,
+					       struct request *req,
+					       sector_t first_rec,
+					       sector_t last_rec,
+					       sector_t first_trk,
+					       sector_t last_trk,
+					       unsigned int first_offs,
+					       unsigned int last_offs,
+					       unsigned int blk_per_trk,
+					       unsigned int blksize)
+{
+	struct dasd_eckd_private *private;
+	unsigned long *idaws;
+	struct dasd_ccw_req *cqr;
+	struct ccw1 *ccw;
+	struct req_iterator iter;
+	struct bio_vec *bv;
+	char *dst, *idaw_dst;
+	unsigned int cidaw, cplength, datasize;
+	unsigned int tlf;
+	sector_t recid;
+	unsigned char cmd;
+	struct dasd_device *basedev;
+	unsigned int trkcount, count, count_to_trk_end;
+	unsigned int idaw_len, seg_len, part_len, len_to_track_end;
+	unsigned char new_track, end_idaw;
+	sector_t trkid;
+	unsigned int recoffs;
+
+	basedev = block->base;
+	private = (struct dasd_eckd_private *) basedev->private;
+	if (rq_data_dir(req) == READ)
+		cmd = DASD_ECKD_CCW_READ_TRACK_DATA;
+	else if (rq_data_dir(req) == WRITE)
+		cmd = DASD_ECKD_CCW_WRITE_TRACK_DATA;
+	else
+		return ERR_PTR(-EINVAL);
+
+	/* Track based I/O needs IDAWs for each page, and not just for
+	 * 64 bit addresses. We need additional idals for pages
+	 * that get filled from two tracks, so we use the number
+	 * of records as upper limit.
+	 */
+	cidaw = last_rec - first_rec + 1;
+	trkcount = last_trk - first_trk + 1;
+
+	/* 1x prefix + one read/write ccw per track */
+	cplength = 1 + trkcount;
+
+	/* on 31-bit we need space for two 32 bit addresses per page
+	 * on 64-bit one 64 bit address
+	 */
+	datasize = sizeof(struct PFX_eckd_data) +
+		cidaw * sizeof(unsigned long long);
+
+	/* Allocate the ccw request. */
+	cqr = dasd_smalloc_request(dasd_eckd_discipline.name,
+				   cplength, datasize, startdev);
+	if (IS_ERR(cqr))
+		return cqr;
+	ccw = cqr->cpaddr;
+	/* transfer length factor: how many bytes to read from the last track */
+	if (first_trk == last_trk)
+		tlf = last_offs - first_offs + 1;
+	else
+		tlf = last_offs + 1;
+	tlf *= blksize;
+
+	if (prefix_LRE(ccw++, cqr->data, first_trk,
+		       last_trk, cmd, basedev, startdev,
+		       1 /* format */, first_offs + 1,
+		       trkcount, blksize,
+		       tlf) == -EAGAIN) {
+		/* Clock not in sync and XRC is enabled.
+		 * Try again later.
+		 */
+		dasd_sfree_request(cqr, startdev);
+		return ERR_PTR(-EAGAIN);
+	}
+
+	/*
+	 * The translation of request into ccw programs must meet the
+	 * following conditions:
+	 * - all idaws but the first and the last must address full pages
+	 *   (or 2K blocks on 31-bit)
+	 * - the scope of a ccw and it's idal ends with the track boundaries
+	 */
+	idaws = (unsigned long *) (cqr->data + sizeof(struct PFX_eckd_data));
+	recid = first_rec;
+	new_track = 1;
+	end_idaw = 0;
+	len_to_track_end = 0;
+	idaw_dst = 0;
+	idaw_len = 0;
+	rq_for_each_segment(bv, req, iter) {
+		dst = page_address(bv->bv_page) + bv->bv_offset;
+		seg_len = bv->bv_len;
+		while (seg_len) {
+			if (new_track) {
+				trkid = recid;
+				recoffs = sector_div(trkid, blk_per_trk);
+				count_to_trk_end = blk_per_trk - recoffs;
+				count = min((last_rec - recid + 1),
+					    (sector_t)count_to_trk_end);
+				len_to_track_end = count * blksize;
+				ccw[-1].flags |= CCW_FLAG_CC;
+				ccw->cmd_code = cmd;
+				ccw->count = len_to_track_end;
+				ccw->cda = (__u32)(addr_t)idaws;
+				ccw->flags = CCW_FLAG_IDA;
+				ccw++;
+				recid += count;
+				new_track = 0;
+			}
+			/* If we start a new idaw, everything is fine and the
+			 * start of the new idaw is the start of this segment.
+			 * If we continue an idaw, we must make sure that the
+			 * current segment begins where the so far accumulated
+			 * idaw ends
+			 */
+			if (!idaw_dst)
+				idaw_dst = dst;
+			if ((idaw_dst + idaw_len) != dst) {
+				dasd_sfree_request(cqr, startdev);
+				return ERR_PTR(-ERANGE);
+			}
+			part_len = min(seg_len, len_to_track_end);
+			seg_len -= part_len;
+			dst += part_len;
+			idaw_len += part_len;
+			len_to_track_end -= part_len;
+			/* collected memory area ends on an IDA_BLOCK border,
+			 * -> create an idaw
+			 * idal_create_words will handle cases where idaw_len
+			 * is larger then IDA_BLOCK_SIZE
+			 */
+			if (!(__pa(idaw_dst + idaw_len) & (IDA_BLOCK_SIZE-1)))
+				end_idaw = 1;
+			/* We also need to end the idaw at track end */
+			if (!len_to_track_end) {
+				new_track = 1;
+				end_idaw = 1;
+			}
+			if (end_idaw) {
+				idaws = idal_create_words(idaws, idaw_dst,
+							  idaw_len);
+				idaw_dst = 0;
+				idaw_len = 0;
+				end_idaw = 0;
+			}
+		}
+	}
+
+	if (blk_noretry_request(req) ||
+	    block->base->features & DASD_FEATURE_FAILFAST)
+		set_bit(DASD_CQR_FLAGS_FAILFAST, &cqr->flags);
+	cqr->startdev = startdev;
+	cqr->memdev = startdev;
+	cqr->block = block;
+	cqr->expires = 5 * 60 * HZ;	/* 5 minutes */
+	cqr->lpm = private->path_data.ppm;
+	cqr->retries = 256;
+	cqr->buildclk = get_clock();
+	cqr->status = DASD_CQR_FILLED;
+	return cqr;
+}
+
+static int prepare_itcw(struct itcw *itcw,
+			unsigned int trk, unsigned int totrk, int cmd,
+			struct dasd_device *basedev,
+			struct dasd_device *startdev,
+			unsigned int rec_on_trk, int count,
+			unsigned int blksize,
+			unsigned int total_data_size,
+			unsigned int tlf,
+			unsigned int blk_per_trk)
+{
+	struct PFX_eckd_data pfxdata;
+	struct dasd_eckd_private *basepriv, *startpriv;
+	struct DE_eckd_data *dedata;
+	struct LRE_eckd_data *lredata;
+	struct dcw *dcw;
+
+	u32 begcyl, endcyl;
+	u16 heads, beghead, endhead;
+	u8 pfx_cmd;
+
+	int rc = 0;
+	int sector = 0;
+	int dn, d;
+
+
+	/* setup prefix data */
+	basepriv = (struct dasd_eckd_private *) basedev->private;
+	startpriv = (struct dasd_eckd_private *) startdev->private;
+	dedata = &pfxdata.define_extent;
+	lredata = &pfxdata.locate_record;
+
+	memset(&pfxdata, 0, sizeof(pfxdata));
+	pfxdata.format = 1; /* PFX with LRE */
+	pfxdata.base_address = basepriv->ned->unit_addr;
+	pfxdata.base_lss = basepriv->ned->ID;
+	pfxdata.validity.define_extent = 1;
+
+	/* private uid is kept up to date, conf_data may be outdated */
+	if (startpriv->uid.type != UA_BASE_DEVICE) {
+		pfxdata.validity.verify_base = 1;
+		if (startpriv->uid.type == UA_HYPER_PAV_ALIAS)
+			pfxdata.validity.hyper_pav = 1;
+	}
+
+	switch (cmd) {
+	case DASD_ECKD_CCW_READ_TRACK_DATA:
+		dedata->mask.perm = 0x1;
+		dedata->attributes.operation = basepriv->attrib.operation;
+		dedata->blk_size = blksize;
+		dedata->ga_extended |= 0x42;
+		lredata->operation.orientation = 0x0;
+		lredata->operation.operation = 0x0C;
+		lredata->auxiliary.check_bytes = 0x01;
+		pfx_cmd = DASD_ECKD_CCW_PFX_READ;
+		break;
+	case DASD_ECKD_CCW_WRITE_TRACK_DATA:
+		dedata->mask.perm = 0x02;
+		dedata->attributes.operation = basepriv->attrib.operation;
+		dedata->blk_size = blksize;
+		rc = check_XRC_on_prefix(&pfxdata, basedev);
+		dedata->ga_extended |= 0x42;
+		lredata->operation.orientation = 0x0;
+		lredata->operation.operation = 0x3F;
+		lredata->extended_operation = 0x23;
+		lredata->auxiliary.check_bytes = 0x2;
+		pfx_cmd = DASD_ECKD_CCW_PFX;
+		break;
+	default:
+		DBF_DEV_EVENT(DBF_ERR, basedev,
+			      "prepare itcw, unknown opcode 0x%x", cmd);
+		BUG();
+		break;
+	}
+	if (rc)
+		return rc;
+
+	dedata->attributes.mode = 0x3;	/* ECKD */
+
+	heads = basepriv->rdc_data.trk_per_cyl;
+	begcyl = trk / heads;
+	beghead = trk % heads;
+	endcyl = totrk / heads;
+	endhead = totrk % heads;
+
+	/* check for sequential prestage - enhance cylinder range */
+	if (dedata->attributes.operation == DASD_SEQ_PRESTAGE ||
+	    dedata->attributes.operation == DASD_SEQ_ACCESS) {
+
+		if (endcyl + basepriv->attrib.nr_cyl < basepriv->real_cyl)
+			endcyl += basepriv->attrib.nr_cyl;
+		else
+			endcyl = (basepriv->real_cyl - 1);
+	}
+
+	set_ch_t(&dedata->beg_ext, begcyl, beghead);
+	set_ch_t(&dedata->end_ext, endcyl, endhead);
+
+	dedata->ep_format = 0x20; /* records per track is valid */
+	dedata->ep_rec_per_track = blk_per_trk;
+
+	if (rec_on_trk) {
+		switch (basepriv->rdc_data.dev_type) {
+		case 0x3390:
+			dn = ceil_quot(blksize + 6, 232);
+			d = 9 + ceil_quot(blksize + 6 * (dn + 1), 34);
+			sector = (49 + (rec_on_trk - 1) * (10 + d)) / 8;
+			break;
+		case 0x3380:
+			d = 7 + ceil_quot(blksize + 12, 32);
+			sector = (39 + (rec_on_trk - 1) * (8 + d)) / 7;
+			break;
+		}
+	}
+
+	lredata->auxiliary.length_valid = 1;
+	lredata->auxiliary.length_scope = 1;
+	lredata->auxiliary.imbedded_ccw_valid = 1;
+	lredata->length = tlf;
+	lredata->imbedded_ccw = cmd;
+	lredata->count = count;
+	lredata->sector = sector;
+	set_ch_t(&lredata->seek_addr, begcyl, beghead);
+	lredata->search_arg.cyl = lredata->seek_addr.cyl;
+	lredata->search_arg.head = lredata->seek_addr.head;
+	lredata->search_arg.record = rec_on_trk;
+
+	dcw = itcw_add_dcw(itcw, pfx_cmd, 0,
+		     &pfxdata, sizeof(pfxdata), total_data_size);
+
+	return rc;
+}
+
+static struct dasd_ccw_req *dasd_eckd_build_cp_tpm_track(
+					       struct dasd_device *startdev,
+					       struct dasd_block *block,
+					       struct request *req,
+					       sector_t first_rec,
+					       sector_t last_rec,
+					       sector_t first_trk,
+					       sector_t last_trk,
+					       unsigned int first_offs,
+					       unsigned int last_offs,
+					       unsigned int blk_per_trk,
+					       unsigned int blksize)
+{
+	struct dasd_eckd_private *private;
+	struct dasd_ccw_req *cqr;
+	struct req_iterator iter;
+	struct bio_vec *bv;
+	char *dst;
+	unsigned int trkcount, ctidaw;
+	unsigned char cmd;
+	struct dasd_device *basedev;
+	unsigned int tlf;
+	struct itcw *itcw;
+	struct tidaw *last_tidaw = NULL;
+	int itcw_op;
+	size_t itcw_size;
+
+	basedev = block->base;
+	private = (struct dasd_eckd_private *) basedev->private;
+	if (rq_data_dir(req) == READ) {
+		cmd = DASD_ECKD_CCW_READ_TRACK_DATA;
+		itcw_op = ITCW_OP_READ;
+	} else if (rq_data_dir(req) == WRITE) {
+		cmd = DASD_ECKD_CCW_WRITE_TRACK_DATA;
+		itcw_op = ITCW_OP_WRITE;
+	} else
+		return ERR_PTR(-EINVAL);
+
+	/* trackbased I/O needs address all memory via TIDAWs,
+	 * not just for 64 bit addresses. This allows us to map
+	 * each segment directly to one tidaw.
+	 */
+	trkcount = last_trk - first_trk + 1;
+	ctidaw = 0;
+	rq_for_each_segment(bv, req, iter) {
+		++ctidaw;
+	}
+
+	/* Allocate the ccw request. */
+	itcw_size = itcw_calc_size(0, ctidaw, 0);
+	cqr = dasd_smalloc_request(dasd_eckd_discipline.name,
+				   0, itcw_size, startdev);
+	if (IS_ERR(cqr))
+		return cqr;
+
+	cqr->cpmode = 1;
+	cqr->startdev = startdev;
+	cqr->memdev = startdev;
+	cqr->block = block;
+	cqr->expires = 100*HZ;
+	cqr->buildclk = get_clock();
+	cqr->status = DASD_CQR_FILLED;
+	cqr->retries = 10;
+
+	/* transfer length factor: how many bytes to read from the last track */
+	if (first_trk == last_trk)
+		tlf = last_offs - first_offs + 1;
+	else
+		tlf = last_offs + 1;
+	tlf *= blksize;
+
+	itcw = itcw_init(cqr->data, itcw_size, itcw_op, 0, ctidaw, 0);
+	cqr->cpaddr = itcw_get_tcw(itcw);
+
+	if (prepare_itcw(itcw, first_trk, last_trk,
+			 cmd, basedev, startdev,
+			 first_offs + 1,
+			 trkcount, blksize,
+			 (last_rec - first_rec + 1) * blksize,
+			 tlf, blk_per_trk) == -EAGAIN) {
+		/* Clock not in sync and XRC is enabled.
+		 * Try again later.
+		 */
+		dasd_sfree_request(cqr, startdev);
+		return ERR_PTR(-EAGAIN);
+	}
+
+	/*
+	 * A tidaw can address 4k of memory, but must not cross page boundaries
+	 * We can let the block layer handle this by setting
+	 * blk_queue_segment_boundary to page boundaries and
+	 * blk_max_segment_size to page size when setting up the request queue.
+	 */
+	rq_for_each_segment(bv, req, iter) {
+		dst = page_address(bv->bv_page) + bv->bv_offset;
+		last_tidaw = itcw_add_tidaw(itcw, 0x00, dst, bv->bv_len);
+		if (IS_ERR(last_tidaw))
+			return (struct dasd_ccw_req *)last_tidaw;
+	}
+
+	last_tidaw->flags |= 0x80;
+	itcw_finalize(itcw);
+
+	if (blk_noretry_request(req) ||
+	    block->base->features & DASD_FEATURE_FAILFAST)
+		set_bit(DASD_CQR_FLAGS_FAILFAST, &cqr->flags);
+	cqr->startdev = startdev;
+	cqr->memdev = startdev;
+	cqr->block = block;
+	cqr->expires = 5 * 60 * HZ;	/* 5 minutes */
+	cqr->lpm = private->path_data.ppm;
+	cqr->retries = 256;
+	cqr->buildclk = get_clock();
+	cqr->status = DASD_CQR_FILLED;
+	return cqr;
+}
+
+static struct dasd_ccw_req *dasd_eckd_build_cp(struct dasd_device *startdev,
+					       struct dasd_block *block,
+					       struct request *req)
+{
+	int tpm, cmdrtd, cmdwtd;
+	int use_prefix;
+
+	struct dasd_eckd_private *private;
+	int fcx_in_css, fcx_in_gneq, fcx_in_features;
+	struct dasd_device *basedev;
+	sector_t first_rec, last_rec;
+	sector_t first_trk, last_trk;
+	unsigned int first_offs, last_offs;
+	unsigned int blk_per_trk, blksize;
+	int cdlspecial;
+	struct dasd_ccw_req *cqr;
+
+	basedev = block->base;
+	private = (struct dasd_eckd_private *) basedev->private;
+
+	/* Calculate number of blocks/records per track. */
+	blksize = block->bp_block;
+	blk_per_trk = recs_per_track(&private->rdc_data, 0, blksize);
+	/* Calculate record id of first and last block. */
+	first_rec = first_trk = req->sector >> block->s2b_shift;
+	first_offs = sector_div(first_trk, blk_per_trk);
+	last_rec = last_trk =
+		(req->sector + req->nr_sectors - 1) >> block->s2b_shift;
+	last_offs = sector_div(last_trk, blk_per_trk);
+	cdlspecial = (private->uses_cdl && first_rec < 2*blk_per_trk);
+
+	/* is transport mode supported ? */
+	fcx_in_css = css_general_characteristics.fcx;
+	fcx_in_gneq = private->gneq->reserved2[7] & 0x04;
+	fcx_in_features = private->features.feature[40] & 0x80;
+	tpm = fcx_in_css && fcx_in_gneq && fcx_in_features;
+
+	/* is read track data and write track data in command mode supported? */
+	cmdrtd = private->features.feature[9] & 0x20;
+	cmdwtd = private->features.feature[12] & 0x40;
+	use_prefix = private->features.feature[8] & 0x01;
+
+	cqr = NULL;
+	if (cdlspecial || dasd_page_cache) {
+		/* do nothing, just fall through to the cmd mode single case */
+	} else if (!dasd_nofcx && tpm && (first_trk == last_trk)) {
+		cqr = dasd_eckd_build_cp_tpm_track(startdev, block, req,
+						    first_rec, last_rec,
+						    first_trk, last_trk,
+						    first_offs, last_offs,
+						    blk_per_trk, blksize);
+		if (IS_ERR(cqr) && PTR_ERR(cqr) != -EAGAIN)
+			cqr = NULL;
+	} else if (use_prefix &&
+		   (((rq_data_dir(req) == READ) && cmdrtd) ||
+		    ((rq_data_dir(req) == WRITE) && cmdwtd))) {
+		cqr = dasd_eckd_build_cp_cmd_track(startdev, block, req,
+						   first_rec, last_rec,
+						   first_trk, last_trk,
+						   first_offs, last_offs,
+						   blk_per_trk, blksize);
+		if (IS_ERR(cqr) && PTR_ERR(cqr) != -EAGAIN)
+			cqr = NULL;
+	}
+	if (!cqr)
+		cqr = dasd_eckd_build_cp_cmd_single(startdev, block, req,
+						    first_rec, last_rec,
+						    first_trk, last_trk,
+						    first_offs, last_offs,
+						    blk_per_trk, blksize);
+	return cqr;
+}
+
 static int
 dasd_eckd_free_cp(struct dasd_ccw_req *cqr, struct request *req)
 {
@@ -1802,7 +2448,7 @@ out:
 }
 
 /*
- * Modify ccw chain in cqr so it can be started on a base device.
+ * Modify ccw/tcw in cqr so it can be started on a base device.
  *
  * Note that this is not enough to restart the cqr!
  * Either reset cqr->startdev as well (summary unit check handling)
@@ -1812,13 +2458,24 @@ void dasd_eckd_reset_ccw_to_base_io(stru
 {
 	struct ccw1 *ccw;
 	struct PFX_eckd_data *pfxdata;
-
-	ccw = cqr->cpaddr;
-	pfxdata = cqr->data;
-
-	if (ccw->cmd_code == DASD_ECKD_CCW_PFX) {
+	struct tcw *tcw;
+	struct tccb *tccb;
+	struct dcw *dcw;
+
+	if (cqr->cpmode == 1) {
+		tcw = cqr->cpaddr;
+		tccb = tcw_get_tccb(tcw);
+		dcw = (struct dcw *)&tccb->tca[0];
+		pfxdata = (struct PFX_eckd_data *)&dcw->cd[0];
 		pfxdata->validity.verify_base = 0;
 		pfxdata->validity.hyper_pav = 0;
+	} else {
+		ccw = cqr->cpaddr;
+		pfxdata = cqr->data;
+		if (ccw->cmd_code == DASD_ECKD_CCW_PFX) {
+			pfxdata->validity.verify_base = 0;
+			pfxdata->validity.hyper_pav = 0;
+		}
 	}
 }
 
@@ -1896,6 +2553,7 @@ dasd_eckd_release(struct dasd_device *de
 {
 	struct dasd_ccw_req *cqr;
 	int rc;
+	struct ccw1 *ccw;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -1907,10 +2565,11 @@ dasd_eckd_release(struct dasd_device *de
 			    "Could not allocate initialization request");
 		return PTR_ERR(cqr);
 	}
-	cqr->cpaddr->cmd_code = DASD_ECKD_CCW_RELEASE;
-        cqr->cpaddr->flags |= CCW_FLAG_SLI;
-        cqr->cpaddr->count = 32;
-	cqr->cpaddr->cda = (__u32)(addr_t) cqr->data;
+	ccw = cqr->cpaddr;
+	ccw->cmd_code = DASD_ECKD_CCW_RELEASE;
+	ccw->flags |= CCW_FLAG_SLI;
+	ccw->count = 32;
+	ccw->cda = (__u32)(addr_t) cqr->data;
 	cqr->startdev = device;
 	cqr->memdev = device;
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
@@ -1937,6 +2596,7 @@ dasd_eckd_reserve(struct dasd_device *de
 {
 	struct dasd_ccw_req *cqr;
 	int rc;
+	struct ccw1 *ccw;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -1948,10 +2608,11 @@ dasd_eckd_reserve(struct dasd_device *de
 			    "Could not allocate initialization request");
 		return PTR_ERR(cqr);
 	}
-	cqr->cpaddr->cmd_code = DASD_ECKD_CCW_RESERVE;
-        cqr->cpaddr->flags |= CCW_FLAG_SLI;
-        cqr->cpaddr->count = 32;
-	cqr->cpaddr->cda = (__u32)(addr_t) cqr->data;
+	ccw = cqr->cpaddr;
+	ccw->cmd_code = DASD_ECKD_CCW_RESERVE;
+	ccw->flags |= CCW_FLAG_SLI;
+	ccw->count = 32;
+	ccw->cda = (__u32)(addr_t) cqr->data;
 	cqr->startdev = device;
 	cqr->memdev = device;
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
@@ -1977,6 +2638,7 @@ dasd_eckd_steal_lock(struct dasd_device 
 {
 	struct dasd_ccw_req *cqr;
 	int rc;
+	struct ccw1 *ccw;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -1988,10 +2650,11 @@ dasd_eckd_steal_lock(struct dasd_device 
 			    "Could not allocate initialization request");
 		return PTR_ERR(cqr);
 	}
-	cqr->cpaddr->cmd_code = DASD_ECKD_CCW_SLCK;
-        cqr->cpaddr->flags |= CCW_FLAG_SLI;
-        cqr->cpaddr->count = 32;
-	cqr->cpaddr->cda = (__u32)(addr_t) cqr->data;
+	ccw = cqr->cpaddr;
+	ccw->cmd_code = DASD_ECKD_CCW_SLCK;
+	ccw->flags |= CCW_FLAG_SLI;
+	ccw->count = 32;
+	ccw->cda = (__u32)(addr_t) cqr->data;
 	cqr->startdev = device;
 	cqr->memdev = device;
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
@@ -2299,7 +2962,7 @@ dasd_eckd_dump_sense_dbf(struct dasd_dev
  * Print sense data and related channel program.
  * Parts are printed because printk buffer is only 1024 bytes.
  */
-static void dasd_eckd_dump_sense(struct dasd_device *device,
+static void dasd_eckd_dump_sense_ccw(struct dasd_device *device,
 				 struct dasd_ccw_req *req, struct irb *irb)
 {
 	char *page;
@@ -2318,7 +2981,7 @@ static void dasd_eckd_dump_sense(struct 
 		      dev_name(&device->cdev->dev));
 	len += sprintf(page + len, KERN_ERR PRINTK_HEADER
 		       " in req: %p CS: 0x%02X DS: 0x%02X\n", req,
-		       irb->scsw.cmd.cstat, irb->scsw.cmd.dstat);
+		       scsw_cstat(&irb->scsw), scsw_dstat(&irb->scsw));
 	len += sprintf(page + len, KERN_ERR PRINTK_HEADER
 		       " device %s: Failing CCW: %p\n",
 		       dev_name(&device->cdev->dev),
@@ -2394,6 +3057,147 @@ static void dasd_eckd_dump_sense(struct 
 	free_page((unsigned long) page);
 }
 
+
+/*
+ * Print sense data from a tcw.
+ */
+static void dasd_eckd_dump_sense_tcw(struct dasd_device *device,
+				 struct dasd_ccw_req *req, struct irb *irb)
+{
+	char *page;
+	int len, sl, sct, residual;
+
+	struct tsb *tsb;
+	u8 *sense;
+
+
+	page = (char *) get_zeroed_page(GFP_ATOMIC);
+	if (page == NULL) {
+		DEV_MESSAGE(KERN_ERR, device, " %s",
+			    "No memory to dump sense data");
+		return;
+	}
+	/* dump the sense data */
+	len = sprintf(page,  KERN_ERR PRINTK_HEADER
+		      " I/O status report for device %s:\n",
+		      dev_name(&device->cdev->dev));
+	len += sprintf(page + len, KERN_ERR PRINTK_HEADER
+		       " in req: %p CS: 0x%02X DS: 0x%02X "
+		       "fcxs: 0x%02X schxs: 0x%02X\n", req,
+		       scsw_cstat(&irb->scsw), scsw_dstat(&irb->scsw),
+		       irb->scsw.tm.fcxs, irb->scsw.tm.schxs);
+	len += sprintf(page + len, KERN_ERR PRINTK_HEADER
+		       " device %s: Failing TCW: %p\n",
+		       dev_name(&device->cdev->dev),
+		       (void *) (addr_t) irb->scsw.tm.tcw);
+
+	tsb = NULL;
+	sense = NULL;
+	if (irb->scsw.tm.tcw)
+		tsb = tcw_get_tsb(
+			(struct tcw *)(unsigned long)irb->scsw.tm.tcw);
+
+	if (tsb && (irb->scsw.tm.fcxs == 0x01)) {
+		len += sprintf(page + len, KERN_ERR PRINTK_HEADER
+			       " tsb->length %d\n", tsb->length);
+		len += sprintf(page + len, KERN_ERR PRINTK_HEADER
+			       " tsb->flags %x\n", tsb->flags);
+		len += sprintf(page + len, KERN_ERR PRINTK_HEADER
+			       " tsb->dcw_offset %d\n", tsb->dcw_offset);
+		len += sprintf(page + len, KERN_ERR PRINTK_HEADER
+			       " tsb->count %d\n", tsb->count);
+		residual = tsb->count - 28;
+		len += sprintf(page + len, KERN_ERR PRINTK_HEADER
+			       " residual %d\n", residual);
+
+		switch (tsb->flags & 0x07) {
+		case 1:	/* tsa_iostat */
+			len += sprintf(page + len, KERN_ERR PRINTK_HEADER
+			       " tsb->tsa.iostat.dev_time %d\n",
+				       tsb->tsa.iostat.dev_time);
+			len += sprintf(page + len, KERN_ERR PRINTK_HEADER
+			       " tsb->tsa.iostat.def_time %d\n",
+				       tsb->tsa.iostat.def_time);
+			len += sprintf(page + len, KERN_ERR PRINTK_HEADER
+			       " tsb->tsa.iostat.queue_time %d\n",
+				       tsb->tsa.iostat.queue_time);
+			len += sprintf(page + len, KERN_ERR PRINTK_HEADER
+			       " tsb->tsa.iostat.dev_busy_time %d\n",
+				       tsb->tsa.iostat.dev_busy_time);
+			len += sprintf(page + len, KERN_ERR PRINTK_HEADER
+			       " tsb->tsa.iostat.dev_act_time %d\n",
+				       tsb->tsa.iostat.dev_act_time);
+			sense = tsb->tsa.iostat.sense;
+			break;
+		case 2: /* ts_ddpc */
+			len += sprintf(page + len, KERN_ERR PRINTK_HEADER
+			       " tsb->tsa.ddpc.rc %d\n", tsb->tsa.ddpc.rc);
+			len += sprintf(page + len, KERN_ERR PRINTK_HEADER
+			       " tsb->tsa.ddpc.rcq:  ");
+			for (sl = 0; sl < 16; sl++) {
+				for (sct = 0; sct < 8; sct++) {
+					len += sprintf(page + len, " %02x",
+						       tsb->tsa.ddpc.rcq[sl]);
+				}
+				len += sprintf(page + len, "\n");
+			}
+			sense = tsb->tsa.ddpc.sense;
+			break;
+		case 3: /* tsa_intrg */
+			len += sprintf(page + len, KERN_ERR PRINTK_HEADER
+				      " tsb->tsa.intrg.: not supportet yet \n");
+			break;
+		}
+
+		if (sense) {
+			for (sl = 0; sl < 4; sl++) {
+				len += sprintf(page + len,
+					       KERN_ERR PRINTK_HEADER
+					       " Sense(hex) %2d-%2d:",
+					       (8 * sl), ((8 * sl) + 7));
+				for (sct = 0; sct < 8; sct++) {
+					len += sprintf(page + len, " %02x",
+						       sense[8 * sl + sct]);
+				}
+				len += sprintf(page + len, "\n");
+			}
+
+			if (sense[27] & DASD_SENSE_BIT_0) {
+				/* 24 Byte Sense Data */
+				sprintf(page + len, KERN_ERR PRINTK_HEADER
+					" 24 Byte: %x MSG %x, "
+					"%s MSGb to SYSOP\n",
+					sense[7] >> 4, sense[7] & 0x0f,
+					sense[1] & 0x10 ? "" : "no");
+			} else {
+				/* 32 Byte Sense Data */
+				sprintf(page + len, KERN_ERR PRINTK_HEADER
+					" 32 Byte: Format: %x "
+					"Exception class %x\n",
+					sense[6] & 0x0f, sense[22] >> 4);
+			}
+		} else {
+			sprintf(page + len, KERN_ERR PRINTK_HEADER
+				" SORRY - NO VALID SENSE AVAILABLE\n");
+		}
+	} else {
+		sprintf(page + len, KERN_ERR PRINTK_HEADER
+			" SORRY - NO TSB DATA AVAILABLE\n");
+	}
+	printk("%s", page);
+	free_page((unsigned long) page);
+}
+
+static void dasd_eckd_dump_sense(struct dasd_device *device,
+				 struct dasd_ccw_req *req, struct irb *irb)
+{
+	if (req && scsw_is_tm(&req->irb.scsw))
+		dasd_eckd_dump_sense_tcw(device, req, irb);
+	else
+		dasd_eckd_dump_sense_ccw(device, req, irb);
+}
+
+
 /*
  * max_blocks is dependent on the amount of storage that is available
  * in the static io buffer for each device. Currently each device has
Index: quilt-2.6/drivers/s390/block/dasd_eckd.h
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_eckd.h
+++ quilt-2.6/drivers/s390/block/dasd_eckd.h
@@ -38,8 +38,11 @@
 #define DASD_ECKD_CCW_RELEASE		 0x94
 #define DASD_ECKD_CCW_READ_CKD_MT	 0x9e
 #define DASD_ECKD_CCW_WRITE_CKD_MT	 0x9d
+#define DASD_ECKD_CCW_WRITE_TRACK_DATA	 0xA5
+#define DASD_ECKD_CCW_READ_TRACK_DATA	 0xA6
 #define DASD_ECKD_CCW_RESERVE		 0xB4
 #define DASD_ECKD_CCW_PFX		 0xE7
+#define DASD_ECKD_CCW_PFX_READ		 0xEA
 #define DASD_ECKD_CCW_RSCK		 0xF9
 
 /*
@@ -123,7 +126,9 @@ struct DE_eckd_data {
 	unsigned long long ep_sys_time; /* Ext Parameter - System Time Stamp */
 	__u8 ep_format;        /* Extended Parameter format byte       */
 	__u8 ep_prio;          /* Extended Parameter priority I/O byte */
-	__u8 ep_reserved[6];   /* Extended Parameter Reserved          */
+	__u8 ep_reserved1;     /* Extended Parameter Reserved	       */
+	__u8 ep_rec_per_track; /* Number of records on a track	       */
+	__u8 ep_reserved[4];   /* Extended Parameter Reserved	       */
 } __attribute__ ((packed));
 
 struct LO_eckd_data {
@@ -144,11 +149,37 @@ struct LO_eckd_data {
 	__u16 length;
 } __attribute__ ((packed));
 
+struct LRE_eckd_data {
+	struct {
+		unsigned char orientation:2;
+		unsigned char operation:6;
+	} __attribute__ ((packed)) operation;
+	struct {
+		unsigned char length_valid:1;
+		unsigned char length_scope:1;
+		unsigned char imbedded_ccw_valid:1;
+		unsigned char check_bytes:2;
+		unsigned char imbedded_count_valid:1;
+		unsigned char reserved:1;
+		unsigned char read_count_suffix:1;
+	} __attribute__ ((packed)) auxiliary;
+	__u8 imbedded_ccw;
+	__u8 count;
+	struct ch_t seek_addr;
+	struct chr_t search_arg;
+	__u8 sector;
+	__u16 length;
+	__u8 imbedded_count;
+	__u8 extended_operation;
+	__u16 extended_parameter_length;
+	__u8 extended_parameter[0];
+} __attribute__ ((packed));
+
 /* Prefix data for format 0x00 and 0x01 */
 struct PFX_eckd_data {
 	unsigned char format;
 	struct {
-		unsigned char define_extend:1;
+		unsigned char define_extent:1;
 		unsigned char time_stamp:1;
 		unsigned char verify_base:1;
 		unsigned char hyper_pav:1;
@@ -158,9 +189,8 @@ struct PFX_eckd_data {
 	__u8 aux;
 	__u8 base_lss;
 	__u8 reserved[7];
-	struct DE_eckd_data define_extend;
-	struct LO_eckd_data locate_record;
-	__u8 LO_extended_data[4];
+	struct DE_eckd_data define_extent;
+	struct LRE_eckd_data locate_record;
 } __attribute__ ((packed));
 
 struct dasd_eckd_characteristics {
Index: quilt-2.6/drivers/s390/block/dasd_eer.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_eer.c
+++ quilt-2.6/drivers/s390/block/dasd_eer.c
@@ -297,11 +297,12 @@ static void dasd_eer_write_standard_trig
 	struct dasd_eer_header header;
 	unsigned long flags;
 	struct eerbuffer *eerb;
+	char *sense;
 
 	/* go through cqr chain and count the valid sense data sets */
 	data_size = 0;
 	for (temp_cqr = cqr; temp_cqr; temp_cqr = temp_cqr->refers)
-		if (temp_cqr->irb.esw.esw0.erw.cons)
+		if (dasd_get_sense(&temp_cqr->irb))
 			data_size += 32;
 
 	header.total_size = sizeof(header) + data_size + 4; /* "EOR" */
@@ -316,9 +317,11 @@ static void dasd_eer_write_standard_trig
 	list_for_each_entry(eerb, &bufferlist, list) {
 		dasd_eer_start_record(eerb, header.total_size);
 		dasd_eer_write_buffer(eerb, (char *) &header, sizeof(header));
-		for (temp_cqr = cqr; temp_cqr; temp_cqr = temp_cqr->refers)
-			if (temp_cqr->irb.esw.esw0.erw.cons)
-				dasd_eer_write_buffer(eerb, cqr->irb.ecw, 32);
+		for (temp_cqr = cqr; temp_cqr; temp_cqr = temp_cqr->refers) {
+			sense = dasd_get_sense(&temp_cqr->irb);
+			if (sense)
+				dasd_eer_write_buffer(eerb, sense, 32);
+		}
 		dasd_eer_write_buffer(eerb, "EOR", 4);
 	}
 	spin_unlock_irqrestore(&bufferlock, flags);
@@ -451,6 +454,7 @@ int dasd_eer_enable(struct dasd_device *
 {
 	struct dasd_ccw_req *cqr;
 	unsigned long flags;
+	struct ccw1 *ccw;
 
 	if (device->eer_cqr)
 		return 0;
@@ -468,10 +472,11 @@ int dasd_eer_enable(struct dasd_device *
 	cqr->expires = 10 * HZ;
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
 
-	cqr->cpaddr->cmd_code = DASD_ECKD_CCW_SNSS;
-	cqr->cpaddr->count = SNSS_DATA_SIZE;
-	cqr->cpaddr->flags = 0;
-	cqr->cpaddr->cda = (__u32)(addr_t) cqr->data;
+	ccw = cqr->cpaddr;
+	ccw->cmd_code = DASD_ECKD_CCW_SNSS;
+	ccw->count = SNSS_DATA_SIZE;
+	ccw->flags = 0;
+	ccw->cda = (__u32)(addr_t) cqr->data;
 
 	cqr->buildclk = get_clock();
 	cqr->status = DASD_CQR_FILLED;
Index: quilt-2.6/drivers/s390/block/dasd_int.h
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_int.h
+++ quilt-2.6/drivers/s390/block/dasd_int.h
@@ -160,7 +160,8 @@ struct dasd_ccw_req {
 	struct dasd_block *block;	/* the originating block device */
 	struct dasd_device *memdev;	/* the device used to allocate this */
 	struct dasd_device *startdev;	/* device the request is started on */
-	struct ccw1 *cpaddr;		/* address of channel program */
+	void *cpaddr;			/* address of ccw or tcw */
+	unsigned char cpmode;		/* 0 = cmd mode, 1 = itcw */
 	char status;			/* status of this request */
 	short retries;			/* A retry counter */
 	unsigned long flags;        	/* flags of this request */
@@ -578,12 +579,14 @@ int dasd_generic_notify(struct ccw_devic
 void dasd_generic_handle_state_change(struct dasd_device *);
 
 int dasd_generic_read_dev_chars(struct dasd_device *, char *, void **, int);
+char *dasd_get_sense(struct irb *);
 
 /* externals in dasd_devmap.c */
 extern int dasd_max_devindex;
 extern int dasd_probeonly;
 extern int dasd_autodetect;
 extern int dasd_nopav;
+extern int dasd_nofcx;
 
 int dasd_devmap_init(void);
 void dasd_devmap_exit(void);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
