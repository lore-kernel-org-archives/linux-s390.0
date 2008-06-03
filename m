Return-Path: <linux-kernel-owner+w=401wt.eu-S1756188AbYFCRIA@vger.kernel.org>
Message-Id: <20080603170520.287666831@de.ibm.com>
References: <20080603165859.107949986@de.ibm.com>
Date: Tue, 03 Jun 2008 18:59:07 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 08/14] cio: introduce fcx enabled scsw format
Content-Disposition: inline; filename=107-fcx-scsw.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Extend the scsw data structure to the format required by fcx. Also
provide helper functions for easier access to fields which are present
in both the traditional as well as the modified format.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd.c          |   18 
 drivers/s390/block/dasd_3990_erp.c |   15 
 drivers/s390/block/dasd_eckd.c     |   12 
 drivers/s390/block/dasd_fba.c      |   12 
 drivers/s390/char/con3215.c        |    6 
 drivers/s390/char/con3270.c        |    6 
 drivers/s390/char/fs3270.c         |    6 
 drivers/s390/char/raw3270.c        |   16 
 drivers/s390/char/tape_34xx.c      |   12 
 drivers/s390/char/tape_3590.c      |   21 
 drivers/s390/char/tape_core.c      |   15 
 drivers/s390/char/tty3270.c        |    6 
 drivers/s390/char/vmur.c           |    5 
 drivers/s390/cio/Makefile          |    2 
 drivers/s390/cio/cio.c             |   14 
 drivers/s390/cio/cio.h             |    3 
 drivers/s390/cio/cmf.c             |    8 
 drivers/s390/cio/device.c          |    2 
 drivers/s390/cio/device_fsm.c      |   49 +-
 drivers/s390/cio/device_id.c       |   14 
 drivers/s390/cio/device_ops.c      |   17 
 drivers/s390/cio/device_pgid.c     |   24 -
 drivers/s390/cio/device_status.c   |  133 ++---
 drivers/s390/cio/qdio.c            |    4 
 drivers/s390/cio/scsw.c            |  844 +++++++++++++++++++++++++++++++++++++
 drivers/s390/net/claw.c            |   77 +--
 drivers/s390/net/ctcm_fsms.c       |   12 
 drivers/s390/net/ctcm_main.c       |   28 -
 drivers/s390/net/lcs.c             |   37 -
 drivers/s390/net/qeth_core_main.c  |   12 
 include/asm-s390/cio.h             |  114 ++++
 31 files changed, 1256 insertions(+), 288 deletions(-)

Index: quilt-2.6/drivers/s390/block/dasd_3990_erp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_3990_erp.c
+++ quilt-2.6/drivers/s390/block/dasd_3990_erp.c
@@ -1572,7 +1572,7 @@ dasd_3990_erp_action_1B_32(struct dasd_c
 
 	/* determine the address of the CCW to be restarted */
 	/* Imprecise ending is not set -> addr from IRB-SCSW */
-	cpa = default_erp->refers->irb.scsw.cpa;
+	cpa = default_erp->refers->irb.scsw.cmd.cpa;
 
 	if (cpa == 0) {
 
@@ -1725,7 +1725,7 @@ dasd_3990_update_1B(struct dasd_ccw_req 
 
 	/* determine the address of the CCW to be restarted */
 	/* Imprecise ending is not set -> addr from IRB-SCSW */
-	cpa = previous_erp->irb.scsw.cpa;
+	cpa = previous_erp->irb.scsw.cmd.cpa;
 
 	if (cpa == 0) {
 
@@ -2171,7 +2171,7 @@ dasd_3990_erp_control_check(struct dasd_
 {
 	struct dasd_device *device = erp->startdev;
 
-	if (erp->refers->irb.scsw.cstat & (SCHN_STAT_INTF_CTRL_CHK
+	if (erp->refers->irb.scsw.cmd.cstat & (SCHN_STAT_INTF_CTRL_CHK
 					   | SCHN_STAT_CHN_CTRL_CHK)) {
 		DEV_MESSAGE(KERN_DEBUG, device, "%s",
 			    "channel or interface control check");
@@ -2352,9 +2352,9 @@ dasd_3990_erp_error_match(struct dasd_cc
 
 	if ((cqr1->irb.esw.esw0.erw.cons == 0) &&
 	    (cqr2->irb.esw.esw0.erw.cons == 0))	{
-		if ((cqr1->irb.scsw.cstat & (SCHN_STAT_INTF_CTRL_CHK |
+		if ((cqr1->irb.scsw.cmd.cstat & (SCHN_STAT_INTF_CTRL_CHK |
 					     SCHN_STAT_CHN_CTRL_CHK)) ==
-		    (cqr2->irb.scsw.cstat & (SCHN_STAT_INTF_CTRL_CHK |
+		    (cqr2->irb.scsw.cmd.cstat & (SCHN_STAT_INTF_CTRL_CHK |
 					     SCHN_STAT_CHN_CTRL_CHK)))
 			return 1; /* match with ifcc*/
 	}
@@ -2622,8 +2622,9 @@ dasd_3990_erp_action(struct dasd_ccw_req
 	}
 
 	/* double-check if current erp/cqr was successfull */
-	if ((cqr->irb.scsw.cstat == 0x00) &&
-	    (cqr->irb.scsw.dstat == (DEV_STAT_CHN_END|DEV_STAT_DEV_END))) {
+	if ((cqr->irb.scsw.cmd.cstat == 0x00) &&
+	    (cqr->irb.scsw.cmd.dstat ==
+	     (DEV_STAT_CHN_END | DEV_STAT_DEV_END))) {
 
 		DEV_MESSAGE(KERN_DEBUG, device,
 			    "ERP called for successful request %p"
Index: quilt-2.6/drivers/s390/block/dasd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd.c
+++ quilt-2.6/drivers/s390/block/dasd.c
@@ -995,14 +995,14 @@ void dasd_int_handler(struct ccw_device 
 	now = get_clock();
 
 	DBF_EVENT(DBF_ERR, "Interrupt: bus_id %s CS/DS %04x ip %08x",
-		  cdev->dev.bus_id, ((irb->scsw.cstat<<8)|irb->scsw.dstat),
-		  (unsigned int) intparm);
+		  cdev->dev.bus_id, ((irb->scsw.cmd.cstat << 8) |
+		  irb->scsw.cmd.dstat), (unsigned int) intparm);
 
 	/* check for unsolicited interrupts */
 	cqr = (struct dasd_ccw_req *) intparm;
-	if (!cqr || ((irb->scsw.cc == 1) &&
-		     (irb->scsw.fctl & SCSW_FCTL_START_FUNC) &&
-		     (irb->scsw.stctl & SCSW_STCTL_STATUS_PEND)) ) {
+	if (!cqr || ((irb->scsw.cmd.cc == 1) &&
+		     (irb->scsw.cmd.fctl & SCSW_FCTL_START_FUNC) &&
+		     (irb->scsw.cmd.stctl & SCSW_STCTL_STATUS_PEND))) {
 		if (cqr && cqr->status == DASD_CQR_IN_IO)
 			cqr->status = DASD_CQR_QUEUED;
 		device = dasd_device_from_cdev_locked(cdev);
@@ -1025,7 +1025,7 @@ void dasd_int_handler(struct ccw_device 
 
 	/* Check for clear pending */
 	if (cqr->status == DASD_CQR_CLEAR_PENDING &&
-	    irb->scsw.fctl & SCSW_FCTL_CLEAR_FUNC) {
+	    irb->scsw.cmd.fctl & SCSW_FCTL_CLEAR_FUNC) {
 		cqr->status = DASD_CQR_CLEARED;
 		dasd_device_clear_timer(device);
 		wake_up(&dasd_flush_wq);
@@ -1041,11 +1041,11 @@ void dasd_int_handler(struct ccw_device 
 		return;
 	}
 	DBF_DEV_EVENT(DBF_DEBUG, device, "Int: CS/DS 0x%04x for cqr %p",
-		      ((irb->scsw.cstat << 8) | irb->scsw.dstat), cqr);
+		      ((irb->scsw.cmd.cstat << 8) | irb->scsw.cmd.dstat), cqr);
 	next = NULL;
 	expires = 0;
-	if (irb->scsw.dstat == (DEV_STAT_CHN_END | DEV_STAT_DEV_END) &&
-	    irb->scsw.cstat == 0 && !irb->esw.esw0.erw.cons) {
+	if (irb->scsw.cmd.dstat == (DEV_STAT_CHN_END | DEV_STAT_DEV_END) &&
+	    irb->scsw.cmd.cstat == 0 && !irb->esw.esw0.erw.cons) {
 		/* request was completed successfully */
 		cqr->status = DASD_CQR_SUCCESS;
 		cqr->stopclk = now;
Index: quilt-2.6/drivers/s390/block/dasd_eckd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_eckd.c
+++ quilt-2.6/drivers/s390/block/dasd_eckd.c
@@ -1404,13 +1404,14 @@ static void dasd_eckd_handle_unsolicited
 
 	/* first of all check for state change pending interrupt */
 	mask = DEV_STAT_ATTENTION | DEV_STAT_DEV_END | DEV_STAT_UNIT_EXCEP;
-	if ((irb->scsw.dstat & mask) == mask) {
+	if ((irb->scsw.cmd.dstat & mask) == mask) {
 		dasd_generic_handle_state_change(device);
 		return;
 	}
 
 	/* summary unit check */
-	if ((irb->scsw.dstat & DEV_STAT_UNIT_CHECK) && irb->ecw[7] == 0x0D) {
+	if ((irb->scsw.cmd.dstat & DEV_STAT_UNIT_CHECK) &&
+	    (irb->ecw[7] == 0x0D)) {
 		dasd_alias_handle_summary_unit_check(device, irb);
 		return;
 	}
@@ -2068,11 +2069,11 @@ static void dasd_eckd_dump_sense(struct 
 		      device->cdev->dev.bus_id);
 	len += sprintf(page + len, KERN_ERR PRINTK_HEADER
 		       " in req: %p CS: 0x%02X DS: 0x%02X\n", req,
-		       irb->scsw.cstat, irb->scsw.dstat);
+		       irb->scsw.cmd.cstat, irb->scsw.cmd.dstat);
 	len += sprintf(page + len, KERN_ERR PRINTK_HEADER
 		       " device %s: Failing CCW: %p\n",
 		       device->cdev->dev.bus_id,
-		       (void *) (addr_t) irb->scsw.cpa);
+		       (void *) (addr_t) irb->scsw.cmd.cpa);
 	if (irb->esw.esw0.erw.cons) {
 		for (sl = 0; sl < 4; sl++) {
 			len += sprintf(page + len, KERN_ERR PRINTK_HEADER
@@ -2122,7 +2123,8 @@ static void dasd_eckd_dump_sense(struct 
 		/* scsw->cda is either valid or zero  */
 		len = 0;
 		from = ++to;
-		fail = (struct ccw1 *)(addr_t) irb->scsw.cpa; /* failing CCW */
+		fail = (struct ccw1 *)(addr_t)
+				irb->scsw.cmd.cpa; /* failing CCW */
 		if (from <  fail - 2) {
 			from = fail - 2;     /* there is a gap - print header */
 			len += sprintf(page, KERN_ERR PRINTK_HEADER "......\n");
Index: quilt-2.6/drivers/s390/block/dasd_fba.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_fba.c
+++ quilt-2.6/drivers/s390/block/dasd_fba.c
@@ -222,7 +222,7 @@ static void dasd_fba_handle_unsolicited_
 
 	/* first of all check for state change pending interrupt */
 	mask = DEV_STAT_ATTENTION | DEV_STAT_DEV_END | DEV_STAT_UNIT_EXCEP;
-	if ((irb->scsw.dstat & mask) == mask) {
+	if ((irb->scsw.cmd.dstat & mask) == mask) {
 		dasd_generic_handle_state_change(device);
 		return;
 	}
@@ -449,11 +449,11 @@ dasd_fba_dump_sense(struct dasd_device *
 		      device->cdev->dev.bus_id);
 	len += sprintf(page + len, KERN_ERR PRINTK_HEADER
 		       " in req: %p CS: 0x%02X DS: 0x%02X\n", req,
-		       irb->scsw.cstat, irb->scsw.dstat);
+		       irb->scsw.cmd.cstat, irb->scsw.cmd.dstat);
 	len += sprintf(page + len, KERN_ERR PRINTK_HEADER
 		       " device %s: Failing CCW: %p\n",
 		       device->cdev->dev.bus_id,
-		       (void *) (addr_t) irb->scsw.cpa);
+		       (void *) (addr_t) irb->scsw.cmd.cpa);
 	if (irb->esw.esw0.erw.cons) {
 		for (sl = 0; sl < 4; sl++) {
 			len += sprintf(page + len, KERN_ERR PRINTK_HEADER
@@ -498,11 +498,11 @@ dasd_fba_dump_sense(struct dasd_device *
 
 	/* print failing CCW area */
 	len = 0;
-	if (act <  ((struct ccw1 *)(addr_t) irb->scsw.cpa) - 2) {
-		act = ((struct ccw1 *)(addr_t) irb->scsw.cpa) - 2;
+	if (act <  ((struct ccw1 *)(addr_t) irb->scsw.cmd.cpa) - 2) {
+		act = ((struct ccw1 *)(addr_t) irb->scsw.cmd.cpa) - 2;
 		len += sprintf(page + len, KERN_ERR PRINTK_HEADER "......\n");
 	}
-	end = min((struct ccw1 *)(addr_t) irb->scsw.cpa + 2, last);
+	end = min((struct ccw1 *)(addr_t) irb->scsw.cmd.cpa + 2, last);
 	while (act <= end) {
 		len += sprintf(page + len, KERN_ERR PRINTK_HEADER
 			       " CCW %p: %08X %08X DAT:",
Index: quilt-2.6/drivers/s390/char/con3215.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/con3215.c
+++ quilt-2.6/drivers/s390/char/con3215.c
@@ -385,8 +385,8 @@ raw3215_irq(struct ccw_device *cdev, uns
 
 	raw = cdev->dev.driver_data;
 	req = (struct raw3215_req *) intparm;
-	cstat = irb->scsw.cstat;
-	dstat = irb->scsw.dstat;
+	cstat = irb->scsw.cmd.cstat;
+	dstat = irb->scsw.cmd.dstat;
 	if (cstat != 0) {
 		raw->message = KERN_WARNING
 			"Got nonzero channel status in raw3215_irq "
@@ -415,7 +415,7 @@ raw3215_irq(struct ccw_device *cdev, uns
 			return;		     /* That shouldn't happen ... */
 		if (req->type == RAW3215_READ) {
 			/* store residual count, then wait for device end */
-			req->residual = irb->scsw.count;
+			req->residual = irb->scsw.cmd.count;
 		}
 		if (dstat == 0x08)
 			break;
Index: quilt-2.6/drivers/s390/char/con3270.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/con3270.c
+++ quilt-2.6/drivers/s390/char/con3270.c
@@ -411,15 +411,15 @@ static int
 con3270_irq(struct con3270 *cp, struct raw3270_request *rq, struct irb *irb)
 {
 	/* Handle ATTN. Schedule tasklet to read aid. */
-	if (irb->scsw.dstat & DEV_STAT_ATTENTION)
+	if (irb->scsw.cmd.dstat & DEV_STAT_ATTENTION)
 		con3270_issue_read(cp);
 
 	if (rq) {
-		if (irb->scsw.dstat & DEV_STAT_UNIT_CHECK)
+		if (irb->scsw.cmd.dstat & DEV_STAT_UNIT_CHECK)
 			rq->rc = -EIO;
 		else
 			/* Normal end. Copy residual count. */
-			rq->rescnt = irb->scsw.count;
+			rq->rescnt = irb->scsw.cmd.count;
 	}
 	return RAW3270_IO_DONE;
 }
Index: quilt-2.6/drivers/s390/char/fs3270.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/fs3270.c
+++ quilt-2.6/drivers/s390/char/fs3270.c
@@ -216,17 +216,17 @@ static int
 fs3270_irq(struct fs3270 *fp, struct raw3270_request *rq, struct irb *irb)
 {
 	/* Handle ATTN. Set indication and wake waiters for attention. */
-	if (irb->scsw.dstat & DEV_STAT_ATTENTION) {
+	if (irb->scsw.cmd.dstat & DEV_STAT_ATTENTION) {
 		fp->attention = 1;
 		wake_up(&fp->wait);
 	}
 
 	if (rq) {
-		if (irb->scsw.dstat & DEV_STAT_UNIT_CHECK)
+		if (irb->scsw.cmd.dstat & DEV_STAT_UNIT_CHECK)
 			rq->rc = -EIO;
 		else
 			/* Normal end. Copy residual count. */
-			rq->rescnt = irb->scsw.count;
+			rq->rescnt = irb->scsw.cmd.count;
 	}
 	return RAW3270_IO_DONE;
 }
Index: quilt-2.6/drivers/s390/char/raw3270.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/raw3270.c
+++ quilt-2.6/drivers/s390/char/raw3270.c
@@ -372,17 +372,17 @@ raw3270_irq (struct ccw_device *cdev, un
 
 	if (IS_ERR(irb))
 		rc = RAW3270_IO_RETRY;
-	else if (irb->scsw.fctl & SCSW_FCTL_HALT_FUNC) {
+	else if (irb->scsw.cmd.fctl & SCSW_FCTL_HALT_FUNC) {
 		rq->rc = -EIO;
 		rc = RAW3270_IO_DONE;
-	} else if (irb->scsw.dstat ==  (DEV_STAT_CHN_END | DEV_STAT_DEV_END |
-					DEV_STAT_UNIT_EXCEP)) {
+	} else if (irb->scsw.cmd.dstat == (DEV_STAT_CHN_END | DEV_STAT_DEV_END |
+					   DEV_STAT_UNIT_EXCEP)) {
 		/* Handle CE-DE-UE and subsequent UDE */
 		set_bit(RAW3270_FLAGS_BUSY, &rp->flags);
 		rc = RAW3270_IO_BUSY;
 	} else if (test_bit(RAW3270_FLAGS_BUSY, &rp->flags)) {
 		/* Wait for UDE if busy flag is set. */
-		if (irb->scsw.dstat & DEV_STAT_DEV_END) {
+		if (irb->scsw.cmd.dstat & DEV_STAT_DEV_END) {
 			clear_bit(RAW3270_FLAGS_BUSY, &rp->flags);
 			/* Got it, now retry. */
 			rc = RAW3270_IO_RETRY;
@@ -497,7 +497,7 @@ raw3270_init_irq(struct raw3270_view *vi
 	 * Unit-Check Processing:
 	 * Expect Command Reject or Intervention Required.
 	 */
-	if (irb->scsw.dstat & DEV_STAT_UNIT_CHECK) {
+	if (irb->scsw.cmd.dstat & DEV_STAT_UNIT_CHECK) {
 		/* Request finished abnormally. */
 		if (irb->ecw[0] & SNS0_INTERVENTION_REQ) {
 			set_bit(RAW3270_FLAGS_BUSY, &view->dev->flags);
@@ -505,16 +505,16 @@ raw3270_init_irq(struct raw3270_view *vi
 		}
 	}
 	if (rq) {
-		if (irb->scsw.dstat & DEV_STAT_UNIT_CHECK) {
+		if (irb->scsw.cmd.dstat & DEV_STAT_UNIT_CHECK) {
 			if (irb->ecw[0] & SNS0_CMD_REJECT)
 				rq->rc = -EOPNOTSUPP;
 			else
 				rq->rc = -EIO;
 		} else
 			/* Request finished normally. Copy residual count. */
-			rq->rescnt = irb->scsw.count;
+			rq->rescnt = irb->scsw.cmd.count;
 	}
-	if (irb->scsw.dstat & DEV_STAT_ATTENTION) {
+	if (irb->scsw.cmd.dstat & DEV_STAT_ATTENTION) {
 		set_bit(RAW3270_FLAGS_ATTN, &view->dev->flags);
 		wake_up(&raw3270_wait_queue);
 	}
Index: quilt-2.6/drivers/s390/char/tape_34xx.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/tape_34xx.c
+++ quilt-2.6/drivers/s390/char/tape_34xx.c
@@ -196,7 +196,7 @@ tape_34xx_erp_retry(struct tape_request 
 static int
 tape_34xx_unsolicited_irq(struct tape_device *device, struct irb *irb)
 {
-	if (irb->scsw.dstat == 0x85 /* READY */) {
+	if (irb->scsw.cmd.dstat == 0x85) { /* READY */
 		/* A medium was inserted in the drive. */
 		DBF_EVENT(6, "xuud med\n");
 		tape_34xx_delete_sbid_from(device, 0);
@@ -844,22 +844,22 @@ tape_34xx_irq(struct tape_device *device
 	if (request == NULL)
 		return tape_34xx_unsolicited_irq(device, irb);
 
-	if ((irb->scsw.dstat & DEV_STAT_UNIT_EXCEP) &&
-	    (irb->scsw.dstat & DEV_STAT_DEV_END) &&
+	if ((irb->scsw.cmd.dstat & DEV_STAT_UNIT_EXCEP) &&
+	    (irb->scsw.cmd.dstat & DEV_STAT_DEV_END) &&
 	    (request->op == TO_WRI)) {
 		/* Write at end of volume */
 		PRINT_INFO("End of volume\n"); /* XXX */
 		return tape_34xx_erp_failed(request, -ENOSPC);
 	}
 
-	if (irb->scsw.dstat & DEV_STAT_UNIT_CHECK)
+	if (irb->scsw.cmd.dstat & DEV_STAT_UNIT_CHECK)
 		return tape_34xx_unit_check(device, request, irb);
 
-	if (irb->scsw.dstat & DEV_STAT_DEV_END) {
+	if (irb->scsw.cmd.dstat & DEV_STAT_DEV_END) {
 		/*
 		 * A unit exception occurs on skipping over a tapemark block.
 		 */
-		if (irb->scsw.dstat & DEV_STAT_UNIT_EXCEP) {
+		if (irb->scsw.cmd.dstat & DEV_STAT_UNIT_EXCEP) {
 			if (request->op == TO_BSB || request->op == TO_FSB)
 				request->rescnt++;
 			else
Index: quilt-2.6/drivers/s390/char/tape_3590.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/tape_3590.c
+++ quilt-2.6/drivers/s390/char/tape_3590.c
@@ -837,13 +837,13 @@ tape_3590_erp_retry(struct tape_device *
 static int
 tape_3590_unsolicited_irq(struct tape_device *device, struct irb *irb)
 {
-	if (irb->scsw.dstat == DEV_STAT_CHN_END)
+	if (irb->scsw.cmd.dstat == DEV_STAT_CHN_END)
 		/* Probably result of halt ssch */
 		return TAPE_IO_PENDING;
-	else if (irb->scsw.dstat == 0x85)
+	else if (irb->scsw.cmd.dstat == 0x85)
 		/* Device Ready */
 		DBF_EVENT(3, "unsol.irq! tape ready: %08x\n", device->cdev_id);
-	else if (irb->scsw.dstat & DEV_STAT_ATTENTION) {
+	else if (irb->scsw.cmd.dstat & DEV_STAT_ATTENTION) {
 		tape_3590_schedule_work(device, TO_READ_ATTMSG);
 	} else {
 		DBF_EVENT(3, "unsol.irq! dev end: %08x\n", device->cdev_id);
@@ -1515,18 +1515,19 @@ tape_3590_irq(struct tape_device *device
 	if (request == NULL)
 		return tape_3590_unsolicited_irq(device, irb);
 
-	if ((irb->scsw.dstat & DEV_STAT_UNIT_EXCEP) &&
-	    (irb->scsw.dstat & DEV_STAT_DEV_END) && (request->op == TO_WRI)) {
+	if ((irb->scsw.cmd.dstat & DEV_STAT_UNIT_EXCEP) &&
+	    (irb->scsw.cmd.dstat & DEV_STAT_DEV_END) &&
+	    (request->op == TO_WRI)) {
 		/* Write at end of volume */
 		DBF_EVENT(2, "End of volume\n");
 		return tape_3590_erp_failed(device, request, irb, -ENOSPC);
 	}
 
-	if (irb->scsw.dstat & DEV_STAT_UNIT_CHECK)
+	if (irb->scsw.cmd.dstat & DEV_STAT_UNIT_CHECK)
 		return tape_3590_unit_check(device, request, irb);
 
-	if (irb->scsw.dstat & DEV_STAT_DEV_END) {
-		if (irb->scsw.dstat == DEV_STAT_UNIT_EXCEP) {
+	if (irb->scsw.cmd.dstat & DEV_STAT_DEV_END) {
+		if (irb->scsw.cmd.dstat == DEV_STAT_UNIT_EXCEP) {
 			if (request->op == TO_FSB || request->op == TO_BSB)
 				request->rescnt++;
 			else
@@ -1536,12 +1537,12 @@ tape_3590_irq(struct tape_device *device
 		return tape_3590_done(device, request);
 	}
 
-	if (irb->scsw.dstat & DEV_STAT_CHN_END) {
+	if (irb->scsw.cmd.dstat & DEV_STAT_CHN_END) {
 		DBF_EVENT(2, "cannel end\n");
 		return TAPE_IO_PENDING;
 	}
 
-	if (irb->scsw.dstat & DEV_STAT_ATTENTION) {
+	if (irb->scsw.cmd.dstat & DEV_STAT_ATTENTION) {
 		DBF_EVENT(2, "Unit Attention when busy..\n");
 		return TAPE_IO_PENDING;
 	}
Index: quilt-2.6/drivers/s390/char/tape_core.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/tape_core.c
+++ quilt-2.6/drivers/s390/char/tape_core.c
@@ -839,7 +839,7 @@ tape_dump_sense(struct tape_device* devi
 
 	PRINT_INFO("-------------------------------------------------\n");
 	PRINT_INFO("DSTAT : %02x  CSTAT: %02x	CPA: %04x\n",
-		   irb->scsw.dstat, irb->scsw.cstat, irb->scsw.cpa);
+		   irb->scsw.cmd.dstat, irb->scsw.cmd.cstat, irb->scsw.cmd.cpa);
 	PRINT_INFO("DEVICE: %s\n", device->cdev->dev.bus_id);
 	if (request != NULL)
 		PRINT_INFO("OP	  : %s\n", tape_op_verbose[request->op]);
@@ -867,7 +867,7 @@ tape_dump_sense_dbf(struct tape_device *
 	else
 		op = "---";
 	DBF_EVENT(3, "DSTAT : %02x   CSTAT: %02x\n",
-		  irb->scsw.dstat,irb->scsw.cstat);
+		  irb->scsw.cmd.dstat, irb->scsw.cmd.cstat);
 	DBF_EVENT(3, "DEVICE: %08x OP\t: %s\n", device->cdev_id, op);
 	sptr = (unsigned int *) irb->ecw;
 	DBF_EVENT(3, "%08x %08x\n", sptr[0], sptr[1]);
@@ -1083,10 +1083,11 @@ __tape_do_irq (struct ccw_device *cdev, 
 	 * error might still apply. So we just schedule the request to be
 	 * started later.
 	 */
-	if (irb->scsw.cc != 0 && (irb->scsw.fctl & SCSW_FCTL_START_FUNC) &&
+	if (irb->scsw.cmd.cc != 0 &&
+	    (irb->scsw.cmd.fctl & SCSW_FCTL_START_FUNC) &&
 	    (request->status == TAPE_REQUEST_IN_IO)) {
 		DBF_EVENT(3,"(%08x): deferred cc=%i, fctl=%i. restarting\n",
-			device->cdev_id, irb->scsw.cc, irb->scsw.fctl);
+			device->cdev_id, irb->scsw.cmd.cc, irb->scsw.cmd.fctl);
 		request->status = TAPE_REQUEST_QUEUED;
 		schedule_delayed_work(&device->tape_dnr, HZ);
 		return;
@@ -1094,8 +1095,8 @@ __tape_do_irq (struct ccw_device *cdev, 
 
 	/* May be an unsolicited irq */
 	if(request != NULL)
-		request->rescnt = irb->scsw.count;
-	else if ((irb->scsw.dstat == 0x85 || irb->scsw.dstat == 0x80) &&
+		request->rescnt = irb->scsw.cmd.count;
+	else if ((irb->scsw.cmd.dstat == 0x85 || irb->scsw.cmd.dstat == 0x80) &&
 		 !list_empty(&device->req_queue)) {
 		/* Not Ready to Ready after long busy ? */
 		struct tape_request *req;
@@ -1111,7 +1112,7 @@ __tape_do_irq (struct ccw_device *cdev, 
 			return;
 		}
 	}
-	if (irb->scsw.dstat != 0x0c) {
+	if (irb->scsw.cmd.dstat != 0x0c) {
 		/* Set the 'ONLINE' flag depending on sense byte 1 */
 		if(*(((__u8 *) irb->ecw) + 1) & SENSE_DRIVE_ONLINE)
 			device->tape_generic_status |= GMT_ONLINE(~0);
Index: quilt-2.6/drivers/s390/char/tty3270.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/tty3270.c
+++ quilt-2.6/drivers/s390/char/tty3270.c
@@ -663,7 +663,7 @@ static int
 tty3270_irq(struct tty3270 *tp, struct raw3270_request *rq, struct irb *irb)
 {
 	/* Handle ATTN. Schedule tasklet to read aid. */
-	if (irb->scsw.dstat & DEV_STAT_ATTENTION) {
+	if (irb->scsw.cmd.dstat & DEV_STAT_ATTENTION) {
 		if (!tp->throttle)
 			tty3270_issue_read(tp, 0);
 		else
@@ -671,11 +671,11 @@ tty3270_irq(struct tty3270 *tp, struct r
 	}
 
 	if (rq) {
-		if (irb->scsw.dstat & DEV_STAT_UNIT_CHECK)
+		if (irb->scsw.cmd.dstat & DEV_STAT_UNIT_CHECK)
 			rq->rc = -EIO;
 		else
 			/* Normal end. Copy residual count. */
-			rq->rescnt = irb->scsw.count;
+			rq->rescnt = irb->scsw.cmd.count;
 	}
 	return RAW3270_IO_DONE;
 }
Index: quilt-2.6/drivers/s390/char/vmur.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/vmur.c
+++ quilt-2.6/drivers/s390/char/vmur.c
@@ -277,7 +277,8 @@ static void ur_int_handler(struct ccw_de
 	struct urdev *urd;
 
 	TRACE("ur_int_handler: intparm=0x%lx cstat=%02x dstat=%02x res=%u\n",
-	      intparm, irb->scsw.cstat, irb->scsw.dstat, irb->scsw.count);
+	      intparm, irb->scsw.cmd.cstat, irb->scsw.cmd.dstat,
+	      irb->scsw.cmd.count);
 
 	if (!intparm) {
 		TRACE("ur_int_handler: unsolicited interrupt\n");
@@ -288,7 +289,7 @@ static void ur_int_handler(struct ccw_de
 	/* On special conditions irb is an error pointer */
 	if (IS_ERR(irb))
 		urd->io_request_rc = PTR_ERR(irb);
-	else if (irb->scsw.dstat == (DEV_STAT_CHN_END | DEV_STAT_DEV_END))
+	else if (irb->scsw.cmd.dstat == (DEV_STAT_CHN_END | DEV_STAT_DEV_END))
 		urd->io_request_rc = 0;
 	else
 		urd->io_request_rc = -EIO;
Index: quilt-2.6/drivers/s390/cio/cio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.c
+++ quilt-2.6/drivers/s390/cio/cio.c
@@ -128,7 +128,7 @@ cio_tpi(void)
 	local_bh_disable();
 	irq_enter ();
 	spin_lock(sch->lock);
-	memcpy (&sch->schib.scsw, &irb->scsw, sizeof (struct scsw));
+	memcpy(&sch->schib.scsw, &irb->scsw, sizeof(union scsw));
 	if (sch->driver && sch->driver->irq)
 		sch->driver->irq(sch);
 	spin_unlock(sch->lock);
@@ -202,7 +202,7 @@ cio_start_key (struct subchannel *sch,	/
 		/*
 		 * initialize device status information
 		 */
-		sch->schib.scsw.actl |= SCSW_ACTL_START_PEND;
+		sch->schib.scsw.cmd.actl |= SCSW_ACTL_START_PEND;
 		return 0;
 	case 1:		/* status pending */
 	case 2:		/* busy */
@@ -237,7 +237,7 @@ cio_resume (struct subchannel *sch)
 
 	switch (ccode) {
 	case 0:
-		sch->schib.scsw.actl |= SCSW_ACTL_RESUME_PEND;
+		sch->schib.scsw.cmd.actl |= SCSW_ACTL_RESUME_PEND;
 		return 0;
 	case 1:
 		return -EBUSY;
@@ -277,7 +277,7 @@ cio_halt(struct subchannel *sch)
 
 	switch (ccode) {
 	case 0:
-		sch->schib.scsw.actl |= SCSW_ACTL_HALT_PEND;
+		sch->schib.scsw.cmd.actl |= SCSW_ACTL_HALT_PEND;
 		return 0;
 	case 1:		/* status pending */
 	case 2:		/* busy */
@@ -312,7 +312,7 @@ cio_clear(struct subchannel *sch)
 
 	switch (ccode) {
 	case 0:
-		sch->schib.scsw.actl |= SCSW_ACTL_CLEAR_PEND;
+		sch->schib.scsw.cmd.actl |= SCSW_ACTL_CLEAR_PEND;
 		return 0;
 	default:		/* device not operational */
 		return -ENODEV;
@@ -458,7 +458,7 @@ int cio_disable_subchannel(struct subcha
 	if (ccode == 3)		/* Not operational. */
 		return -ENODEV;
 
-	if (sch->schib.scsw.actl != 0)
+	if (scsw_actl(&sch->schib.scsw) != 0)
 		/*
 		 * the disable function must not be called while there are
 		 *  requests pending for completion !
@@ -708,7 +708,7 @@ void wait_cons_dev(void)
 		if (!cio_tpi())
 			cpu_relax();
 		spin_lock(console_subchannel.lock);
-	} while (console_subchannel.schib.scsw.actl != 0);
+	} while (console_subchannel.schib.scsw.cmd.actl != 0);
 	/*
 	 * restore previous isc value
 	 */
Index: quilt-2.6/drivers/s390/cio/cio.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.h
+++ quilt-2.6/drivers/s390/cio/cio.h
@@ -5,6 +5,7 @@
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <asm/chpid.h>
+#include <asm/cio.h>
 #include "chsc.h"
 #include "schid.h"
 
@@ -48,7 +49,7 @@ struct pmcw {
  */
 struct schib {
 	struct pmcw pmcw;	 /* path management control word */
-	struct scsw scsw;	 /* subchannel status word */
+	union scsw scsw;	 /* subchannel status word */
 	__u64 mba;               /* measurement block address */
 	__u8 mda[4];		 /* model dependent area */
 } __attribute__ ((packed,aligned(4)));
Index: quilt-2.6/drivers/s390/cio/cmf.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cmf.c
+++ quilt-2.6/drivers/s390/cio/cmf.c
@@ -341,12 +341,12 @@ static int cmf_copy_block(struct ccw_dev
 	if (stsch(sch->schid, &sch->schib))
 		return -ENODEV;
 
-	if (sch->schib.scsw.fctl & SCSW_FCTL_START_FUNC) {
+	if (scsw_fctl(&sch->schib.scsw) & SCSW_FCTL_START_FUNC) {
 		/* Don't copy if a start function is in progress. */
-		if ((!(sch->schib.scsw.actl & SCSW_ACTL_SUSPENDED)) &&
-		    (sch->schib.scsw.actl &
+		if ((!(scsw_actl(&sch->schib.scsw) & SCSW_ACTL_SUSPENDED)) &&
+		    (scsw_actl(&sch->schib.scsw) &
 		     (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT)) &&
-		    (!(sch->schib.scsw.stctl & SCSW_STCTL_SEC_STATUS)))
+		    (!(scsw_stctl(&sch->schib.scsw) & SCSW_STCTL_SEC_STATUS)))
 			return -EBUSY;
 	}
 	cmb_data = cdev->private->cmb;
Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c
+++ quilt-2.6/drivers/s390/cio/device.c
@@ -1281,7 +1281,7 @@ static int check_for_io_on_path(struct s
 	cc = stsch(sch->schid, &sch->schib);
 	if (cc)
 		return 0;
-	if (sch->schib.scsw.actl && sch->schib.pmcw.lpum == mask)
+	if (scsw_actl(&sch->schib.scsw) && sch->schib.pmcw.lpum == mask)
 		return 1;
 	return 0;
 }
Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c
+++ quilt-2.6/drivers/s390/cio/device_fsm.c
@@ -133,15 +133,15 @@ ccw_device_cancel_halt_clear(struct ccw_
 		/* Not operational -> done. */
 		return 0;
 	/* Stage 1: cancel io. */
-	if (!(sch->schib.scsw.actl & SCSW_ACTL_HALT_PEND) &&
-	    !(sch->schib.scsw.actl & SCSW_ACTL_CLEAR_PEND)) {
+	if (!(scsw_actl(&sch->schib.scsw) & SCSW_ACTL_HALT_PEND) &&
+	    !(scsw_actl(&sch->schib.scsw) & SCSW_ACTL_CLEAR_PEND)) {
 		ret = cio_cancel(sch);
 		if (ret != -EINVAL)
 			return ret;
 		/* cancel io unsuccessful. From now on it is asynchronous. */
 		cdev->private->iretry = 3;	/* 3 halt retries. */
 	}
-	if (!(sch->schib.scsw.actl & SCSW_ACTL_CLEAR_PEND)) {
+	if (!(scsw_actl(&sch->schib.scsw) & SCSW_ACTL_CLEAR_PEND)) {
 		/* Stage 2: halt io. */
 		if (cdev->private->iretry) {
 			cdev->private->iretry--;
@@ -551,10 +551,11 @@ ccw_device_verify_done(struct ccw_device
 		/* Deliver fake irb to device driver, if needed. */
 		if (cdev->private->flags.fake_irb) {
 			memset(&cdev->private->irb, 0, sizeof(struct irb));
-			cdev->private->irb.scsw.cc = 1;
-			cdev->private->irb.scsw.fctl = SCSW_FCTL_START_FUNC;
-			cdev->private->irb.scsw.actl = SCSW_ACTL_START_PEND;
-			cdev->private->irb.scsw.stctl = SCSW_STCTL_STATUS_PEND;
+			cdev->private->irb.scsw.cmd.cc = 1;
+			cdev->private->irb.scsw.cmd.fctl = SCSW_FCTL_START_FUNC;
+			cdev->private->irb.scsw.cmd.actl = SCSW_ACTL_START_PEND;
+			cdev->private->irb.scsw.cmd.stctl =
+				SCSW_STCTL_STATUS_PEND;
 			cdev->private->flags.fake_irb = 0;
 			if (cdev->handler)
 				cdev->handler(cdev, cdev->private->intparm,
@@ -648,13 +649,10 @@ ccw_device_offline(struct ccw_device *cd
 	sch = to_subchannel(cdev->dev.parent);
 	if (stsch(sch->schid, &sch->schib) || !sch->schib.pmcw.dnv)
 		return -ENODEV;
-	if (cdev->private->state != DEV_STATE_ONLINE) {
-		if (sch->schib.scsw.actl != 0)
-			return -EBUSY;
-		return -EINVAL;
-	}
-	if (sch->schib.scsw.actl != 0)
+	if (scsw_actl(&sch->schib.scsw) != 0)
 		return -EBUSY;
+	if (cdev->private->state != DEV_STATE_ONLINE)
+		return -EINVAL;
 	/* Are we doing path grouping? */
 	if (!cdev->private->options.pgroup) {
 		/* No, set state offline immediately. */
@@ -729,9 +727,9 @@ ccw_device_online_verify(struct ccw_devi
 	 */
 	stsch(sch->schid, &sch->schib);
 
-	if (sch->schib.scsw.actl != 0 ||
-	    (sch->schib.scsw.stctl & SCSW_STCTL_STATUS_PEND) ||
-	    (cdev->private->irb.scsw.stctl & SCSW_STCTL_STATUS_PEND)) {
+	if (scsw_actl(&sch->schib.scsw) != 0 ||
+	    (scsw_stctl(&sch->schib.scsw) & SCSW_STCTL_STATUS_PEND) ||
+	    (scsw_stctl(&cdev->private->irb.scsw) & SCSW_STCTL_STATUS_PEND)) {
 		/*
 		 * No final status yet or final status not yet delivered
 		 * to the device driver. Can't do path verfication now,
@@ -756,10 +754,8 @@ ccw_device_irq(struct ccw_device *cdev, 
 
 	irb = (struct irb *) __LC_IRB;
 	/* Check for unsolicited interrupt. */
-	if ((irb->scsw.stctl ==
-	    		(SCSW_STCTL_STATUS_PEND | SCSW_STCTL_ALERT_STATUS))
-	    && (!irb->scsw.cc)) {
-		if ((irb->scsw.dstat & DEV_STAT_UNIT_CHECK) &&
+	if (!scsw_is_solicited(&irb->scsw)) {
+		if ((irb->scsw.cmd.dstat & DEV_STAT_UNIT_CHECK) &&
 		    !irb->esw.esw0.erw.cons) {
 			/* Unit check but no sense data. Need basic sense. */
 			if (ccw_device_do_sense(cdev, irb) != 0)
@@ -822,9 +818,9 @@ ccw_device_w4sense(struct ccw_device *cd
 
 	irb = (struct irb *) __LC_IRB;
 	/* Check for unsolicited interrupt. */
-	if (irb->scsw.stctl ==
-	    		(SCSW_STCTL_STATUS_PEND | SCSW_STCTL_ALERT_STATUS)) {
-		if (irb->scsw.cc == 1)
+	if (scsw_stctl(&irb->scsw) ==
+	    (SCSW_STCTL_STATUS_PEND | SCSW_STCTL_ALERT_STATUS)) {
+		if (scsw_cc(&irb->scsw) == 1)
 			/* Basic sense hasn't started. Try again. */
 			ccw_device_do_sense(cdev, irb);
 		else {
@@ -842,7 +838,8 @@ ccw_device_w4sense(struct ccw_device *cd
 	 * only deliver the halt/clear interrupt to the device driver as if it
 	 * had killed the original request.
 	 */
-	if (irb->scsw.fctl & (SCSW_FCTL_CLEAR_FUNC | SCSW_FCTL_HALT_FUNC)) {
+	if (scsw_fctl(&irb->scsw) &
+	    (SCSW_FCTL_CLEAR_FUNC | SCSW_FCTL_HALT_FUNC)) {
 		/* Retry Basic Sense if requested. */
 		if (cdev->private->flags.intretry) {
 			cdev->private->flags.intretry = 0;
@@ -949,9 +946,9 @@ ccw_device_stlck_done(struct ccw_device 
 	case DEV_EVENT_INTERRUPT:
 		irb = (struct irb *) __LC_IRB;
 		/* Check for unsolicited interrupt. */
-		if ((irb->scsw.stctl ==
+		if ((scsw_stctl(&irb->scsw) ==
 		     (SCSW_STCTL_STATUS_PEND | SCSW_STCTL_ALERT_STATUS)) &&
-		    (!irb->scsw.cc))
+		    (!scsw_cc(&irb->scsw)))
 			/* FIXME: we should restart stlck here, but this
 			 * is extremely unlikely ... */
 			goto out_wakeup;
Index: quilt-2.6/drivers/s390/cio/device_id.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_id.c
+++ quilt-2.6/drivers/s390/cio/device_id.c
@@ -196,7 +196,7 @@ ccw_device_check_sense_id(struct ccw_dev
 	irb = &cdev->private->irb;
 
 	/* Check the error cases. */
-	if (irb->scsw.fctl & (SCSW_FCTL_HALT_FUNC | SCSW_FCTL_CLEAR_FUNC)) {
+	if (irb->scsw.cmd.fctl & (SCSW_FCTL_HALT_FUNC | SCSW_FCTL_CLEAR_FUNC)) {
 		/* Retry Sense ID if requested. */
 		if (cdev->private->flags.intretry) {
 			cdev->private->flags.intretry = 0;
@@ -234,7 +234,7 @@ ccw_device_check_sense_id(struct ccw_dev
 			      irb->ecw[6], irb->ecw[7]);
 		return -EAGAIN;
 	}
-	if (irb->scsw.cc == 3) {
+	if (irb->scsw.cmd.cc == 3) {
 		u8 lpm;
 
 		lpm = to_io_private(sch)->orb.lpm;
@@ -248,9 +248,9 @@ ccw_device_check_sense_id(struct ccw_dev
 	}
 
 	/* Did we get a proper answer ? */
-	if (irb->scsw.cc == 0 && cdev->private->senseid.cu_type != 0xFFFF &&
+	if (irb->scsw.cmd.cc == 0 && cdev->private->senseid.cu_type != 0xFFFF &&
 	    cdev->private->senseid.reserved == 0xFF) {
-		if (irb->scsw.count < sizeof(struct senseid) - 8)
+		if (irb->scsw.cmd.count < sizeof(struct senseid) - 8)
 			cdev->private->flags.esid = 1;
 		return 0; /* Success */
 	}
@@ -260,7 +260,7 @@ ccw_device_check_sense_id(struct ccw_dev
 		      "subchannel 0.%x.%04x returns status %02X%02X\n",
 		      cdev->private->dev_id.devno, sch->schid.ssid,
 		      sch->schid.sch_no,
-		      irb->scsw.dstat, irb->scsw.cstat);
+		      irb->scsw.cmd.dstat, irb->scsw.cmd.cstat);
 	return -EAGAIN;
 }
 
@@ -277,9 +277,9 @@ ccw_device_sense_id_irq(struct ccw_devic
 	sch = to_subchannel(cdev->dev.parent);
 	irb = (struct irb *) __LC_IRB;
 	/* Retry sense id, if needed. */
-	if (irb->scsw.stctl ==
+	if (irb->scsw.cmd.stctl ==
 	    (SCSW_STCTL_STATUS_PEND | SCSW_STCTL_ALERT_STATUS)) {
-		if ((irb->scsw.cc == 1) || !irb->scsw.actl) {
+		if ((irb->scsw.cmd.cc == 1) || !irb->scsw.cmd.actl) {
 			ret = __ccw_device_sense_id_start(cdev);
 			if (ret && ret != -EBUSY)
 				ccw_device_sense_id_done(cdev, ret);
Index: quilt-2.6/drivers/s390/cio/device_ops.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_ops.c
+++ quilt-2.6/drivers/s390/cio/device_ops.c
@@ -179,8 +179,8 @@ int ccw_device_start_key(struct ccw_devi
 			return -EBUSY;
 	}
 	if (cdev->private->state != DEV_STATE_ONLINE ||
-	    ((sch->schib.scsw.stctl & SCSW_STCTL_PRIM_STATUS) &&
-	     !(sch->schib.scsw.stctl & SCSW_STCTL_SEC_STATUS)) ||
+	    ((sch->schib.scsw.cmd.stctl & SCSW_STCTL_PRIM_STATUS) &&
+	     !(sch->schib.scsw.cmd.stctl & SCSW_STCTL_SEC_STATUS)) ||
 	    cdev->private->flags.doverify)
 		return -EBUSY;
 	ret = cio_set_options (sch, flags);
@@ -379,7 +379,7 @@ int ccw_device_resume(struct ccw_device 
 	if (cdev->private->state == DEV_STATE_NOT_OPER)
 		return -ENODEV;
 	if (cdev->private->state != DEV_STATE_ONLINE ||
-	    !(sch->schib.scsw.actl & SCSW_ACTL_SUSPENDED))
+	    !(sch->schib.scsw.cmd.actl & SCSW_ACTL_SUSPENDED))
 		return -EINVAL;
 	return cio_resume(sch);
 }
@@ -404,7 +404,7 @@ ccw_device_call_handler(struct ccw_devic
 	 *  - fast notification was requested (primary status)
 	 *  - unsolicited interrupts
 	 */
-	stctl = cdev->private->irb.scsw.stctl;
+	stctl = scsw_stctl(&cdev->private->irb.scsw);
 	ending_status = (stctl & SCSW_STCTL_SEC_STATUS) ||
 		(stctl == (SCSW_STCTL_ALERT_STATUS | SCSW_STCTL_STATUS_PEND)) ||
 		(stctl == SCSW_STCTL_STATUS_PEND);
@@ -528,14 +528,15 @@ ccw_device_stlck(struct ccw_device *cdev
 		cio_disable_subchannel(sch); //FIXME: return code?
 		goto out_unlock;
 	}
-	cdev->private->irb.scsw.actl |= SCSW_ACTL_START_PEND;
+	cdev->private->irb.scsw.cmd.actl |= SCSW_ACTL_START_PEND;
 	spin_unlock_irqrestore(sch->lock, flags);
-	wait_event(cdev->private->wait_q, cdev->private->irb.scsw.actl == 0);
+	wait_event(cdev->private->wait_q,
+		   cdev->private->irb.scsw.cmd.actl == 0);
 	spin_lock_irqsave(sch->lock, flags);
 	cio_disable_subchannel(sch); //FIXME: return code?
-	if ((cdev->private->irb.scsw.dstat !=
+	if ((cdev->private->irb.scsw.cmd.dstat !=
 	     (DEV_STAT_CHN_END|DEV_STAT_DEV_END)) ||
-	    (cdev->private->irb.scsw.cstat != 0))
+	    (cdev->private->irb.scsw.cmd.cstat != 0))
 		ret = -EIO;
 	/* Clear irb. */
 	memset(&cdev->private->irb, 0, sizeof(struct irb));
Index: quilt-2.6/drivers/s390/cio/device_pgid.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_pgid.c
+++ quilt-2.6/drivers/s390/cio/device_pgid.c
@@ -28,13 +28,13 @@
  * Helper function called from interrupt context to decide whether an
  * operation should be tried again.
  */
-static int __ccw_device_should_retry(struct scsw *scsw)
+static int __ccw_device_should_retry(union scsw *scsw)
 {
 	/* CC is only valid if start function bit is set. */
-	if ((scsw->fctl & SCSW_FCTL_START_FUNC) && scsw->cc == 1)
+	if ((scsw->cmd.fctl & SCSW_FCTL_START_FUNC) && scsw->cmd.cc == 1)
 		return 1;
 	/* No more activity. For sense and set PGID we stubbornly try again. */
-	if (!scsw->actl)
+	if (!scsw->cmd.actl)
 		return 1;
 	return 0;
 }
@@ -125,7 +125,7 @@ __ccw_device_check_sense_pgid(struct ccw
 
 	sch = to_subchannel(cdev->dev.parent);
 	irb = &cdev->private->irb;
-	if (irb->scsw.fctl & (SCSW_FCTL_HALT_FUNC | SCSW_FCTL_CLEAR_FUNC)) {
+	if (irb->scsw.cmd.fctl & (SCSW_FCTL_HALT_FUNC | SCSW_FCTL_CLEAR_FUNC)) {
 		/* Retry Sense PGID if requested. */
 		if (cdev->private->flags.intretry) {
 			cdev->private->flags.intretry = 0;
@@ -155,7 +155,7 @@ __ccw_device_check_sense_pgid(struct ccw
 			      irb->ecw[6], irb->ecw[7]);
 		return -EAGAIN;
 	}
-	if (irb->scsw.cc == 3) {
+	if (irb->scsw.cmd.cc == 3) {
 		u8 lpm;
 
 		lpm = to_io_private(sch)->orb.lpm;
@@ -188,7 +188,7 @@ ccw_device_sense_pgid_irq(struct ccw_dev
 
 	irb = (struct irb *) __LC_IRB;
 
-	if (irb->scsw.stctl ==
+	if (irb->scsw.cmd.stctl ==
 	    (SCSW_STCTL_STATUS_PEND | SCSW_STCTL_ALERT_STATUS)) {
 		if (__ccw_device_should_retry(&irb->scsw)) {
 			ret = __ccw_device_sense_pgid_start(cdev);
@@ -331,7 +331,7 @@ __ccw_device_check_pgid(struct ccw_devic
 
 	sch = to_subchannel(cdev->dev.parent);
 	irb = &cdev->private->irb;
-	if (irb->scsw.fctl & (SCSW_FCTL_HALT_FUNC | SCSW_FCTL_CLEAR_FUNC)) {
+	if (irb->scsw.cmd.fctl & (SCSW_FCTL_HALT_FUNC | SCSW_FCTL_CLEAR_FUNC)) {
 		/* Retry Set PGID if requested. */
 		if (cdev->private->flags.intretry) {
 			cdev->private->flags.intretry = 0;
@@ -355,7 +355,7 @@ __ccw_device_check_pgid(struct ccw_devic
 			      irb->ecw[6], irb->ecw[7]);
 		return -EAGAIN;
 	}
-	if (irb->scsw.cc == 3) {
+	if (irb->scsw.cmd.cc == 3) {
 		CIO_MSG_EVENT(3, "SPID - Device %04x on Subchannel 0.%x.%04x,"
 			      " lpm %02X, became 'not operational'\n",
 			      cdev->private->dev_id.devno, sch->schid.ssid,
@@ -376,7 +376,7 @@ static int __ccw_device_check_nop(struct
 
 	sch = to_subchannel(cdev->dev.parent);
 	irb = &cdev->private->irb;
-	if (irb->scsw.fctl & (SCSW_FCTL_HALT_FUNC | SCSW_FCTL_CLEAR_FUNC)) {
+	if (irb->scsw.cmd.fctl & (SCSW_FCTL_HALT_FUNC | SCSW_FCTL_CLEAR_FUNC)) {
 		/* Retry NOP if requested. */
 		if (cdev->private->flags.intretry) {
 			cdev->private->flags.intretry = 0;
@@ -384,7 +384,7 @@ static int __ccw_device_check_nop(struct
 		}
 		return -ETIME;
 	}
-	if (irb->scsw.cc == 3) {
+	if (irb->scsw.cmd.cc == 3) {
 		CIO_MSG_EVENT(3, "NOP - Device %04x on Subchannel 0.%x.%04x,"
 			      " lpm %02X, became 'not operational'\n",
 			      cdev->private->dev_id.devno, sch->schid.ssid,
@@ -438,7 +438,7 @@ ccw_device_verify_irq(struct ccw_device 
 
 	irb = (struct irb *) __LC_IRB;
 
-	if (irb->scsw.stctl ==
+	if (irb->scsw.cmd.stctl ==
 	    (SCSW_STCTL_STATUS_PEND | SCSW_STCTL_ALERT_STATUS)) {
 		if (__ccw_device_should_retry(&irb->scsw))
 			__ccw_device_verify_start(cdev);
@@ -544,7 +544,7 @@ ccw_device_disband_irq(struct ccw_device
 
 	irb = (struct irb *) __LC_IRB;
 
-	if (irb->scsw.stctl ==
+	if (irb->scsw.cmd.stctl ==
 	    (SCSW_STCTL_STATUS_PEND | SCSW_STCTL_ALERT_STATUS)) {
 		if (__ccw_device_should_retry(&irb->scsw))
 			__ccw_device_disband_start(cdev);
Index: quilt-2.6/drivers/s390/cio/device_status.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_status.c
+++ quilt-2.6/drivers/s390/cio/device_status.c
@@ -29,9 +29,11 @@
 static void
 ccw_device_msg_control_check(struct ccw_device *cdev, struct irb *irb)
 {
-	if (!(irb->scsw.cstat & (SCHN_STAT_CHN_DATA_CHK |
-				 SCHN_STAT_CHN_CTRL_CHK |
-				 SCHN_STAT_INTF_CTRL_CHK)))
+	char dbf_text[15];
+
+	if (!scsw_is_valid_cstat(&irb->scsw) ||
+	    !(scsw_cstat(&irb->scsw) & (SCHN_STAT_CHN_DATA_CHK |
+	      SCHN_STAT_CHN_CTRL_CHK | SCHN_STAT_INTF_CTRL_CHK)))
 		return;
 	CIO_MSG_EVENT(0, "Channel-Check or Interface-Control-Check "
 		      "received"
@@ -39,15 +41,10 @@ ccw_device_msg_control_check(struct ccw_
 		      ": %02X sch_stat : %02X\n",
 		      cdev->private->dev_id.devno, cdev->private->schid.ssid,
 		      cdev->private->schid.sch_no,
-		      irb->scsw.dstat, irb->scsw.cstat);
-
-	if (irb->scsw.cc != 3) {
-		char dbf_text[15];
-
-		sprintf(dbf_text, "chk%x", cdev->private->schid.sch_no);
-		CIO_TRACE_EVENT(0, dbf_text);
-		CIO_HEX_EVENT(0, irb, sizeof (struct irb));
-	}
+		      scsw_dstat(&irb->scsw), scsw_cstat(&irb->scsw));
+	sprintf(dbf_text, "chk%x", cdev->private->schid.sch_no);
+	CIO_TRACE_EVENT(0, dbf_text);
+	CIO_HEX_EVENT(0, irb, sizeof(struct irb));
 }
 
 /*
@@ -81,12 +78,12 @@ ccw_device_accumulate_ecw(struct ccw_dev
 	 * are condition that have to be met for the extended control
 	 * bit to have meaning. Sick.
 	 */
-	cdev->private->irb.scsw.ectl = 0;
-	if ((irb->scsw.stctl & SCSW_STCTL_ALERT_STATUS) &&
-	    !(irb->scsw.stctl & SCSW_STCTL_INTER_STATUS))
-		cdev->private->irb.scsw.ectl = irb->scsw.ectl;
+	cdev->private->irb.scsw.cmd.ectl = 0;
+	if ((irb->scsw.cmd.stctl & SCSW_STCTL_ALERT_STATUS) &&
+	    !(irb->scsw.cmd.stctl & SCSW_STCTL_INTER_STATUS))
+		cdev->private->irb.scsw.cmd.ectl = irb->scsw.cmd.ectl;
 	/* Check if extended control word is valid. */
-	if (!cdev->private->irb.scsw.ectl)
+	if (!cdev->private->irb.scsw.cmd.ectl)
 		return;
 	/* Copy concurrent sense / model dependent information. */
 	memcpy (&cdev->private->irb.ecw, irb->ecw, sizeof (irb->ecw));
@@ -98,11 +95,12 @@ ccw_device_accumulate_ecw(struct ccw_dev
 static int
 ccw_device_accumulate_esw_valid(struct irb *irb)
 {
-	if (!irb->scsw.eswf && irb->scsw.stctl == SCSW_STCTL_STATUS_PEND)
+	if (!irb->scsw.cmd.eswf &&
+	    (irb->scsw.cmd.stctl == SCSW_STCTL_STATUS_PEND))
 		return 0;
-	if (irb->scsw.stctl == 
-	    		(SCSW_STCTL_INTER_STATUS|SCSW_STCTL_STATUS_PEND) &&
-	    !(irb->scsw.actl & SCSW_ACTL_SUSPENDED))
+	if (irb->scsw.cmd.stctl ==
+			(SCSW_STCTL_INTER_STATUS|SCSW_STCTL_STATUS_PEND) &&
+	    !(irb->scsw.cmd.actl & SCSW_ACTL_SUSPENDED))
 		return 0;
 	return 1;
 }
@@ -125,7 +123,7 @@ ccw_device_accumulate_esw(struct ccw_dev
 	cdev_irb->esw.esw1.lpum = irb->esw.esw1.lpum;
 
 	/* Copy subchannel logout information if esw is of format 0. */
-	if (irb->scsw.eswf) {
+	if (irb->scsw.cmd.eswf) {
 		cdev_sublog = &cdev_irb->esw.esw0.sublog;
 		sublog = &irb->esw.esw0.sublog;
 		/* Copy extended status flags. */
@@ -134,7 +132,7 @@ ccw_device_accumulate_esw(struct ccw_dev
 		 * Copy fields that have a meaning for channel data check
 		 * channel control check and interface control check.
 		 */
-		if (irb->scsw.cstat & (SCHN_STAT_CHN_DATA_CHK |
+		if (irb->scsw.cmd.cstat & (SCHN_STAT_CHN_DATA_CHK |
 				       SCHN_STAT_CHN_CTRL_CHK |
 				       SCHN_STAT_INTF_CTRL_CHK)) {
 			/* Copy ancillary report bit. */
@@ -155,7 +153,7 @@ ccw_device_accumulate_esw(struct ccw_dev
 		/* Copy i/o-error alert. */
 		cdev_sublog->ioerr = sublog->ioerr;
 		/* Copy channel path timeout bit. */
-		if (irb->scsw.cstat & SCHN_STAT_INTF_CTRL_CHK)
+		if (irb->scsw.cmd.cstat & SCHN_STAT_INTF_CTRL_CHK)
 			cdev_irb->esw.esw0.erw.cpt = irb->esw.esw0.erw.cpt;
 		/* Copy failing storage address validity flag. */
 		cdev_irb->esw.esw0.erw.fsavf = irb->esw.esw0.erw.fsavf;
@@ -200,24 +198,24 @@ ccw_device_accumulate_irb(struct ccw_dev
 	 * If not, the remaining bit have no meaning and we must ignore them.
 	 * The esw is not meaningful as well...
 	 */
-	if (!(irb->scsw.stctl & SCSW_STCTL_STATUS_PEND))
+	if (!(scsw_stctl(&irb->scsw) & SCSW_STCTL_STATUS_PEND))
 		return;
 
 	/* Check for channel checks and interface control checks. */
 	ccw_device_msg_control_check(cdev, irb);
 
 	/* Check for path not operational. */
-	if (irb->scsw.pno && irb->scsw.fctl != 0 &&
-	    (!(irb->scsw.stctl & SCSW_STCTL_INTER_STATUS) ||
-	     (irb->scsw.actl & SCSW_ACTL_SUSPENDED)))
+	if (scsw_is_valid_pno(&irb->scsw) && scsw_pno(&irb->scsw))
 		ccw_device_path_notoper(cdev);
-
+	/* No irb accumulation for transport mode irbs. */
+	if (scsw_is_tm(&irb->scsw)) {
+		memcpy(&cdev->private->irb, irb, sizeof(struct irb));
+		return;
+	}
 	/*
 	 * Don't accumulate unsolicited interrupts.
 	 */
-	if ((irb->scsw.stctl ==
-	     (SCSW_STCTL_STATUS_PEND | SCSW_STCTL_ALERT_STATUS)) &&
-	    (!irb->scsw.cc))
+	if (!scsw_is_solicited(&irb->scsw))
 		return;
 
 	cdev_irb = &cdev->private->irb;
@@ -227,62 +225,63 @@ ccw_device_accumulate_irb(struct ccw_dev
 	 * status at the subchannel has been cleared and we must not pass
 	 * intermediate accumulated status to the device driver.
 	 */
-	if (irb->scsw.fctl & SCSW_FCTL_CLEAR_FUNC)
+	if (irb->scsw.cmd.fctl & SCSW_FCTL_CLEAR_FUNC)
 		memset(&cdev->private->irb, 0, sizeof(struct irb));
 
 	/* Copy bits which are valid only for the start function. */
-	if (irb->scsw.fctl & SCSW_FCTL_START_FUNC) {
+	if (irb->scsw.cmd.fctl & SCSW_FCTL_START_FUNC) {
 		/* Copy key. */
-		cdev_irb->scsw.key = irb->scsw.key;
+		cdev_irb->scsw.cmd.key = irb->scsw.cmd.key;
 		/* Copy suspend control bit. */
-		cdev_irb->scsw.sctl = irb->scsw.sctl;
+		cdev_irb->scsw.cmd.sctl = irb->scsw.cmd.sctl;
 		/* Accumulate deferred condition code. */
-		cdev_irb->scsw.cc |= irb->scsw.cc;
+		cdev_irb->scsw.cmd.cc |= irb->scsw.cmd.cc;
 		/* Copy ccw format bit. */
-		cdev_irb->scsw.fmt = irb->scsw.fmt;
+		cdev_irb->scsw.cmd.fmt = irb->scsw.cmd.fmt;
 		/* Copy prefetch bit. */
-		cdev_irb->scsw.pfch = irb->scsw.pfch;
+		cdev_irb->scsw.cmd.pfch = irb->scsw.cmd.pfch;
 		/* Copy initial-status-interruption-control. */
-		cdev_irb->scsw.isic = irb->scsw.isic;
+		cdev_irb->scsw.cmd.isic = irb->scsw.cmd.isic;
 		/* Copy address limit checking control. */
-		cdev_irb->scsw.alcc = irb->scsw.alcc;
+		cdev_irb->scsw.cmd.alcc = irb->scsw.cmd.alcc;
 		/* Copy suppress suspend bit. */
-		cdev_irb->scsw.ssi = irb->scsw.ssi;
+		cdev_irb->scsw.cmd.ssi = irb->scsw.cmd.ssi;
 	}
 
 	/* Take care of the extended control bit and extended control word. */
 	ccw_device_accumulate_ecw(cdev, irb);
 	    
 	/* Accumulate function control. */
-	cdev_irb->scsw.fctl |= irb->scsw.fctl;
+	cdev_irb->scsw.cmd.fctl |= irb->scsw.cmd.fctl;
 	/* Copy activity control. */
-	cdev_irb->scsw.actl= irb->scsw.actl;
+	cdev_irb->scsw.cmd.actl = irb->scsw.cmd.actl;
 	/* Accumulate status control. */
-	cdev_irb->scsw.stctl |= irb->scsw.stctl;
+	cdev_irb->scsw.cmd.stctl |= irb->scsw.cmd.stctl;
 	/*
 	 * Copy ccw address if it is valid. This is a bit simplified
 	 * but should be close enough for all practical purposes.
 	 */
-	if ((irb->scsw.stctl & SCSW_STCTL_PRIM_STATUS) ||
-	    ((irb->scsw.stctl == 
+	if ((irb->scsw.cmd.stctl & SCSW_STCTL_PRIM_STATUS) ||
+	    ((irb->scsw.cmd.stctl ==
 	      (SCSW_STCTL_INTER_STATUS|SCSW_STCTL_STATUS_PEND)) &&
-	     (irb->scsw.actl & SCSW_ACTL_DEVACT) &&
-	     (irb->scsw.actl & SCSW_ACTL_SCHACT)) ||
-	    (irb->scsw.actl & SCSW_ACTL_SUSPENDED))
-		cdev_irb->scsw.cpa = irb->scsw.cpa;
+	     (irb->scsw.cmd.actl & SCSW_ACTL_DEVACT) &&
+	     (irb->scsw.cmd.actl & SCSW_ACTL_SCHACT)) ||
+	    (irb->scsw.cmd.actl & SCSW_ACTL_SUSPENDED))
+		cdev_irb->scsw.cmd.cpa = irb->scsw.cmd.cpa;
 	/* Accumulate device status, but not the device busy flag. */
-	cdev_irb->scsw.dstat &= ~DEV_STAT_BUSY;
+	cdev_irb->scsw.cmd.dstat &= ~DEV_STAT_BUSY;
 	/* dstat is not always valid. */
-	if (irb->scsw.stctl &
+	if (irb->scsw.cmd.stctl &
 	    (SCSW_STCTL_PRIM_STATUS | SCSW_STCTL_SEC_STATUS
 	     | SCSW_STCTL_INTER_STATUS | SCSW_STCTL_ALERT_STATUS))
-		cdev_irb->scsw.dstat |= irb->scsw.dstat;
+		cdev_irb->scsw.cmd.dstat |= irb->scsw.cmd.dstat;
 	/* Accumulate subchannel status. */
-	cdev_irb->scsw.cstat |= irb->scsw.cstat;
+	cdev_irb->scsw.cmd.cstat |= irb->scsw.cmd.cstat;
 	/* Copy residual count if it is valid. */
-	if ((irb->scsw.stctl & SCSW_STCTL_PRIM_STATUS) &&
-	    (irb->scsw.cstat & ~(SCHN_STAT_PCI | SCHN_STAT_INCORR_LEN)) == 0)
-		cdev_irb->scsw.count = irb->scsw.count;
+	if ((irb->scsw.cmd.stctl & SCSW_STCTL_PRIM_STATUS) &&
+	    (irb->scsw.cmd.cstat & ~(SCHN_STAT_PCI | SCHN_STAT_INCORR_LEN))
+	     == 0)
+		cdev_irb->scsw.cmd.count = irb->scsw.cmd.count;
 
 	/* Take care of bits in the extended status word. */
 	ccw_device_accumulate_esw(cdev, irb);
@@ -299,7 +298,7 @@ ccw_device_accumulate_irb(struct ccw_dev
 	 *	 sense facility available/supported when enabling the
 	 *	 concurrent sense facility.
 	 */
-	if ((cdev_irb->scsw.dstat & DEV_STAT_UNIT_CHECK) &&
+	if ((cdev_irb->scsw.cmd.dstat & DEV_STAT_UNIT_CHECK) &&
 	    !(cdev_irb->esw.esw0.erw.cons))
 		cdev->private->flags.dosense = 1;
 }
@@ -317,7 +316,7 @@ ccw_device_do_sense(struct ccw_device *c
 	sch = to_subchannel(cdev->dev.parent);
 
 	/* A sense is required, can we do it now ? */
-	if ((irb->scsw.actl  & (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT)) != 0)
+	if (scsw_actl(&irb->scsw) & (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT))
 		/*
 		 * we received an Unit Check but we have no final
 		 *  status yet, therefore we must delay the SENSE
@@ -355,20 +354,18 @@ ccw_device_accumulate_basic_sense(struct
 	 * If not, the remaining bit have no meaning and we must ignore them.
 	 * The esw is not meaningful as well...
 	 */
-	if (!(irb->scsw.stctl & SCSW_STCTL_STATUS_PEND))
+	if (!(scsw_stctl(&irb->scsw) & SCSW_STCTL_STATUS_PEND))
 		return;
 
 	/* Check for channel checks and interface control checks. */
 	ccw_device_msg_control_check(cdev, irb);
 
 	/* Check for path not operational. */
-	if (irb->scsw.pno && irb->scsw.fctl != 0 &&
-	    (!(irb->scsw.stctl & SCSW_STCTL_INTER_STATUS) ||
-	     (irb->scsw.actl & SCSW_ACTL_SUSPENDED)))
+	if (scsw_is_valid_pno(&irb->scsw) && scsw_pno(&irb->scsw))
 		ccw_device_path_notoper(cdev);
 
-	if (!(irb->scsw.dstat & DEV_STAT_UNIT_CHECK) &&
-	    (irb->scsw.dstat & DEV_STAT_CHN_END)) {
+	if (!(irb->scsw.cmd.dstat & DEV_STAT_UNIT_CHECK) &&
+	    (irb->scsw.cmd.dstat & DEV_STAT_CHN_END)) {
 		cdev->private->irb.esw.esw0.erw.cons = 1;
 		cdev->private->flags.dosense = 0;
 	}
@@ -386,11 +383,11 @@ int
 ccw_device_accumulate_and_sense(struct ccw_device *cdev, struct irb *irb)
 {
 	ccw_device_accumulate_irb(cdev, irb);
-	if ((irb->scsw.actl  & (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT)) != 0)
+	if ((irb->scsw.cmd.actl  & (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT)) != 0)
 		return -EBUSY;
 	/* Check for basic sense. */
 	if (cdev->private->flags.dosense &&
-	    !(irb->scsw.dstat & DEV_STAT_UNIT_CHECK)) {
+	    !(irb->scsw.cmd.dstat & DEV_STAT_UNIT_CHECK)) {
 		cdev->private->irb.esw.esw0.erw.cons = 1;
 		cdev->private->flags.dosense = 0;
 		return 0;
Index: quilt-2.6/drivers/s390/cio/Makefile
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/Makefile
+++ quilt-2.6/drivers/s390/cio/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the S/390 common i/o drivers
 #
 
-obj-y += airq.o blacklist.o chsc.o cio.o css.o chp.o idset.o
+obj-y += airq.o blacklist.o chsc.o cio.o css.o chp.o idset.o scsw.o
 ccw_device-objs += device.o device_fsm.o device_ops.o
 ccw_device-objs += device_id.o device_pgid.o device_status.o
 obj-y += ccw_device.o cmf.o
Index: quilt-2.6/drivers/s390/cio/qdio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio.c
+++ quilt-2.6/drivers/s390/cio/qdio.c
@@ -2139,8 +2139,8 @@ qdio_handler(struct ccw_device *cdev, un
 	QDIO_DBF_TEXT4(0, trace, dbf_text);
 #endif /* CONFIG_QDIO_DEBUG */
 
-        cstat = irb->scsw.cstat;
-        dstat = irb->scsw.dstat;
+	cstat = irb->scsw.cmd.cstat;
+	dstat = irb->scsw.cmd.dstat;
 
 	switch (irq_ptr->state) {
 	case QDIO_IRQ_STATE_INACTIVE:
Index: quilt-2.6/drivers/s390/cio/scsw.c
===================================================================
--- /dev/null
+++ quilt-2.6/drivers/s390/cio/scsw.c
@@ -0,0 +1,844 @@
+/*
+ *  Helper functions for scsw access.
+ *
+ *    Copyright IBM Corp. 2008
+ *    Author(s): Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
+ */
+
+#include <linux/types.h>
+#include <linux/module.h>
+#include <asm/cio.h>
+#include "css.h"
+#include "chsc.h"
+
+/**
+ * scsw_is_tm - check for transport mode scsw
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the specified scsw is a transport mode scsw, zero
+ * otherwise.
+ */
+int scsw_is_tm(union scsw *scsw)
+{
+	return css_characteristics_avail && css_general_characteristics.fcx &&
+	       (scsw->tm.x == 1);
+}
+EXPORT_SYMBOL(scsw_is_tm);
+
+/**
+ * scsw_key - return scsw key field
+ * @scsw: pointer to scsw
+ *
+ * Return the value of the key field of the specified scsw, regardless of
+ * whether it is a transport mode or command mode scsw.
+ */
+u32 scsw_key(union scsw *scsw)
+{
+	if (scsw_is_tm(scsw))
+		return scsw->tm.key;
+	else
+		return scsw->cmd.key;
+}
+EXPORT_SYMBOL(scsw_key);
+
+/**
+ * scsw_eswf - return scsw eswf field
+ * @scsw: pointer to scsw
+ *
+ * Return the value of the eswf field of the specified scsw, regardless of
+ * whether it is a transport mode or command mode scsw.
+ */
+u32 scsw_eswf(union scsw *scsw)
+{
+	if (scsw_is_tm(scsw))
+		return scsw->tm.eswf;
+	else
+		return scsw->cmd.eswf;
+}
+EXPORT_SYMBOL(scsw_eswf);
+
+/**
+ * scsw_cc - return scsw cc field
+ * @scsw: pointer to scsw
+ *
+ * Return the value of the cc field of the specified scsw, regardless of
+ * whether it is a transport mode or command mode scsw.
+ */
+u32 scsw_cc(union scsw *scsw)
+{
+	if (scsw_is_tm(scsw))
+		return scsw->tm.cc;
+	else
+		return scsw->cmd.cc;
+}
+EXPORT_SYMBOL(scsw_cc);
+
+/**
+ * scsw_ectl - return scsw ectl field
+ * @scsw: pointer to scsw
+ *
+ * Return the value of the ectl field of the specified scsw, regardless of
+ * whether it is a transport mode or command mode scsw.
+ */
+u32 scsw_ectl(union scsw *scsw)
+{
+	if (scsw_is_tm(scsw))
+		return scsw->tm.ectl;
+	else
+		return scsw->cmd.ectl;
+}
+EXPORT_SYMBOL(scsw_ectl);
+
+/**
+ * scsw_pno - return scsw pno field
+ * @scsw: pointer to scsw
+ *
+ * Return the value of the pno field of the specified scsw, regardless of
+ * whether it is a transport mode or command mode scsw.
+ */
+u32 scsw_pno(union scsw *scsw)
+{
+	if (scsw_is_tm(scsw))
+		return scsw->tm.pno;
+	else
+		return scsw->cmd.pno;
+}
+EXPORT_SYMBOL(scsw_pno);
+
+/**
+ * scsw_fctl - return scsw fctl field
+ * @scsw: pointer to scsw
+ *
+ * Return the value of the fctl field of the specified scsw, regardless of
+ * whether it is a transport mode or command mode scsw.
+ */
+u32 scsw_fctl(union scsw *scsw)
+{
+	if (scsw_is_tm(scsw))
+		return scsw->tm.fctl;
+	else
+		return scsw->cmd.fctl;
+}
+EXPORT_SYMBOL(scsw_fctl);
+
+/**
+ * scsw_actl - return scsw actl field
+ * @scsw: pointer to scsw
+ *
+ * Return the value of the actl field of the specified scsw, regardless of
+ * whether it is a transport mode or command mode scsw.
+ */
+u32 scsw_actl(union scsw *scsw)
+{
+	if (scsw_is_tm(scsw))
+		return scsw->tm.actl;
+	else
+		return scsw->cmd.actl;
+}
+EXPORT_SYMBOL(scsw_actl);
+
+/**
+ * scsw_stctl - return scsw stctl field
+ * @scsw: pointer to scsw
+ *
+ * Return the value of the stctl field of the specified scsw, regardless of
+ * whether it is a transport mode or command mode scsw.
+ */
+u32 scsw_stctl(union scsw *scsw)
+{
+	if (scsw_is_tm(scsw))
+		return scsw->tm.stctl;
+	else
+		return scsw->cmd.stctl;
+}
+EXPORT_SYMBOL(scsw_stctl);
+
+/**
+ * scsw_dstat - return scsw dstat field
+ * @scsw: pointer to scsw
+ *
+ * Return the value of the dstat field of the specified scsw, regardless of
+ * whether it is a transport mode or command mode scsw.
+ */
+u32 scsw_dstat(union scsw *scsw)
+{
+	if (scsw_is_tm(scsw))
+		return scsw->tm.dstat;
+	else
+		return scsw->cmd.dstat;
+}
+EXPORT_SYMBOL(scsw_dstat);
+
+/**
+ * scsw_cstat - return scsw cstat field
+ * @scsw: pointer to scsw
+ *
+ * Return the value of the cstat field of the specified scsw, regardless of
+ * whether it is a transport mode or command mode scsw.
+ */
+u32 scsw_cstat(union scsw *scsw)
+{
+	if (scsw_is_tm(scsw))
+		return scsw->tm.cstat;
+	else
+		return scsw->cmd.cstat;
+}
+EXPORT_SYMBOL(scsw_cstat);
+
+/**
+ * scsw_cmd_is_valid_key - check key field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the key field of the specified command mode scsw is
+ * valid, zero otherwise.
+ */
+int scsw_cmd_is_valid_key(union scsw *scsw)
+{
+	return (scsw->cmd.fctl & SCSW_FCTL_START_FUNC);
+}
+EXPORT_SYMBOL(scsw_cmd_is_valid_key);
+
+/**
+ * scsw_cmd_is_valid_sctl - check fctl field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the fctl field of the specified command mode scsw is
+ * valid, zero otherwise.
+ */
+int scsw_cmd_is_valid_sctl(union scsw *scsw)
+{
+	return (scsw->cmd.fctl & SCSW_FCTL_START_FUNC);
+}
+EXPORT_SYMBOL(scsw_cmd_is_valid_sctl);
+
+/**
+ * scsw_cmd_is_valid_eswf - check eswf field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the eswf field of the specified command mode scsw is
+ * valid, zero otherwise.
+ */
+int scsw_cmd_is_valid_eswf(union scsw *scsw)
+{
+	return (scsw->cmd.stctl & SCSW_STCTL_STATUS_PEND);
+}
+EXPORT_SYMBOL(scsw_cmd_is_valid_eswf);
+
+/**
+ * scsw_cmd_is_valid_cc - check cc field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the cc field of the specified command mode scsw is
+ * valid, zero otherwise.
+ */
+int scsw_cmd_is_valid_cc(union scsw *scsw)
+{
+	return (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) &&
+	       (scsw->cmd.stctl & SCSW_STCTL_STATUS_PEND);
+}
+EXPORT_SYMBOL(scsw_cmd_is_valid_cc);
+
+/**
+ * scsw_cmd_is_valid_fmt - check fmt field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the fmt field of the specified command mode scsw is
+ * valid, zero otherwise.
+ */
+int scsw_cmd_is_valid_fmt(union scsw *scsw)
+{
+	return (scsw->cmd.fctl & SCSW_FCTL_START_FUNC);
+}
+EXPORT_SYMBOL(scsw_cmd_is_valid_fmt);
+
+/**
+ * scsw_cmd_is_valid_pfch - check pfch field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the pfch field of the specified command mode scsw is
+ * valid, zero otherwise.
+ */
+int scsw_cmd_is_valid_pfch(union scsw *scsw)
+{
+	return (scsw->cmd.fctl & SCSW_FCTL_START_FUNC);
+}
+EXPORT_SYMBOL(scsw_cmd_is_valid_pfch);
+
+/**
+ * scsw_cmd_is_valid_isic - check isic field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the isic field of the specified command mode scsw is
+ * valid, zero otherwise.
+ */
+int scsw_cmd_is_valid_isic(union scsw *scsw)
+{
+	return (scsw->cmd.fctl & SCSW_FCTL_START_FUNC);
+}
+EXPORT_SYMBOL(scsw_cmd_is_valid_isic);
+
+/**
+ * scsw_cmd_is_valid_alcc - check alcc field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the alcc field of the specified command mode scsw is
+ * valid, zero otherwise.
+ */
+int scsw_cmd_is_valid_alcc(union scsw *scsw)
+{
+	return (scsw->cmd.fctl & SCSW_FCTL_START_FUNC);
+}
+EXPORT_SYMBOL(scsw_cmd_is_valid_alcc);
+
+/**
+ * scsw_cmd_is_valid_ssi - check ssi field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the ssi field of the specified command mode scsw is
+ * valid, zero otherwise.
+ */
+int scsw_cmd_is_valid_ssi(union scsw *scsw)
+{
+	return (scsw->cmd.fctl & SCSW_FCTL_START_FUNC);
+}
+EXPORT_SYMBOL(scsw_cmd_is_valid_ssi);
+
+/**
+ * scsw_cmd_is_valid_zcc - check zcc field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the zcc field of the specified command mode scsw is
+ * valid, zero otherwise.
+ */
+int scsw_cmd_is_valid_zcc(union scsw *scsw)
+{
+	return (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) &&
+	       (scsw->cmd.stctl & SCSW_STCTL_INTER_STATUS);
+}
+EXPORT_SYMBOL(scsw_cmd_is_valid_zcc);
+
+/**
+ * scsw_cmd_is_valid_ectl - check ectl field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the ectl field of the specified command mode scsw is
+ * valid, zero otherwise.
+ */
+int scsw_cmd_is_valid_ectl(union scsw *scsw)
+{
+	return (scsw->cmd.stctl & SCSW_STCTL_STATUS_PEND) &&
+	       !(scsw->cmd.stctl & SCSW_STCTL_INTER_STATUS) &&
+	       (scsw->cmd.stctl & SCSW_STCTL_ALERT_STATUS);
+}
+EXPORT_SYMBOL(scsw_cmd_is_valid_ectl);
+
+/**
+ * scsw_cmd_is_valid_pno - check pno field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the pno field of the specified command mode scsw is
+ * valid, zero otherwise.
+ */
+int scsw_cmd_is_valid_pno(union scsw *scsw)
+{
+	return (scsw->cmd.fctl != 0) &&
+	       (scsw->cmd.stctl & SCSW_STCTL_STATUS_PEND) &&
+	       (!(scsw->cmd.stctl & SCSW_STCTL_INTER_STATUS) ||
+		 ((scsw->cmd.stctl & SCSW_STCTL_INTER_STATUS) &&
+		  (scsw->cmd.actl & SCSW_ACTL_SUSPENDED)));
+}
+EXPORT_SYMBOL(scsw_cmd_is_valid_pno);
+
+/**
+ * scsw_cmd_is_valid_fctl - check fctl field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the fctl field of the specified command mode scsw is
+ * valid, zero otherwise.
+ */
+int scsw_cmd_is_valid_fctl(union scsw *scsw)
+{
+	/* Only valid if pmcw.dnv == 1*/
+	return 1;
+}
+EXPORT_SYMBOL(scsw_cmd_is_valid_fctl);
+
+/**
+ * scsw_cmd_is_valid_actl - check actl field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the actl field of the specified command mode scsw is
+ * valid, zero otherwise.
+ */
+int scsw_cmd_is_valid_actl(union scsw *scsw)
+{
+	/* Only valid if pmcw.dnv == 1*/
+	return 1;
+}
+EXPORT_SYMBOL(scsw_cmd_is_valid_actl);
+
+/**
+ * scsw_cmd_is_valid_stctl - check stctl field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the stctl field of the specified command mode scsw is
+ * valid, zero otherwise.
+ */
+int scsw_cmd_is_valid_stctl(union scsw *scsw)
+{
+	/* Only valid if pmcw.dnv == 1*/
+	return 1;
+}
+EXPORT_SYMBOL(scsw_cmd_is_valid_stctl);
+
+/**
+ * scsw_cmd_is_valid_dstat - check dstat field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the dstat field of the specified command mode scsw is
+ * valid, zero otherwise.
+ */
+int scsw_cmd_is_valid_dstat(union scsw *scsw)
+{
+	return (scsw->cmd.stctl & SCSW_STCTL_STATUS_PEND) &&
+	       (scsw->cmd.cc != 3);
+}
+EXPORT_SYMBOL(scsw_cmd_is_valid_dstat);
+
+/**
+ * scsw_cmd_is_valid_cstat - check cstat field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the cstat field of the specified command mode scsw is
+ * valid, zero otherwise.
+ */
+int scsw_cmd_is_valid_cstat(union scsw *scsw)
+{
+	return (scsw->cmd.stctl & SCSW_STCTL_STATUS_PEND) &&
+	       (scsw->cmd.cc != 3);
+}
+EXPORT_SYMBOL(scsw_cmd_is_valid_cstat);
+
+/**
+ * scsw_tm_is_valid_key - check key field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the key field of the specified transport mode scsw is
+ * valid, zero otherwise.
+ */
+int scsw_tm_is_valid_key(union scsw *scsw)
+{
+	return (scsw->tm.fctl & SCSW_FCTL_START_FUNC);
+}
+EXPORT_SYMBOL(scsw_tm_is_valid_key);
+
+/**
+ * scsw_tm_is_valid_eswf - check eswf field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the eswf field of the specified transport mode scsw is
+ * valid, zero otherwise.
+ */
+int scsw_tm_is_valid_eswf(union scsw *scsw)
+{
+	return (scsw->tm.stctl & SCSW_STCTL_STATUS_PEND);
+}
+EXPORT_SYMBOL(scsw_tm_is_valid_eswf);
+
+/**
+ * scsw_tm_is_valid_cc - check cc field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the cc field of the specified transport mode scsw is
+ * valid, zero otherwise.
+ */
+int scsw_tm_is_valid_cc(union scsw *scsw)
+{
+	return (scsw->tm.fctl & SCSW_FCTL_START_FUNC) &&
+	       (scsw->tm.stctl & SCSW_STCTL_STATUS_PEND);
+}
+EXPORT_SYMBOL(scsw_tm_is_valid_cc);
+
+/**
+ * scsw_tm_is_valid_fmt - check fmt field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the fmt field of the specified transport mode scsw is
+ * valid, zero otherwise.
+ */
+int scsw_tm_is_valid_fmt(union scsw *scsw)
+{
+	return 1;
+}
+EXPORT_SYMBOL(scsw_tm_is_valid_fmt);
+
+/**
+ * scsw_tm_is_valid_x - check x field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the x field of the specified transport mode scsw is
+ * valid, zero otherwise.
+ */
+int scsw_tm_is_valid_x(union scsw *scsw)
+{
+	return 1;
+}
+EXPORT_SYMBOL(scsw_tm_is_valid_x);
+
+/**
+ * scsw_tm_is_valid_q - check q field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the q field of the specified transport mode scsw is
+ * valid, zero otherwise.
+ */
+int scsw_tm_is_valid_q(union scsw *scsw)
+{
+	return 1;
+}
+EXPORT_SYMBOL(scsw_tm_is_valid_q);
+
+/**
+ * scsw_tm_is_valid_ectl - check ectl field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the ectl field of the specified transport mode scsw is
+ * valid, zero otherwise.
+ */
+int scsw_tm_is_valid_ectl(union scsw *scsw)
+{
+	return (scsw->tm.stctl & SCSW_STCTL_STATUS_PEND) &&
+	       !(scsw->tm.stctl & SCSW_STCTL_INTER_STATUS) &&
+	       (scsw->tm.stctl & SCSW_STCTL_ALERT_STATUS);
+}
+EXPORT_SYMBOL(scsw_tm_is_valid_ectl);
+
+/**
+ * scsw_tm_is_valid_pno - check pno field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the pno field of the specified transport mode scsw is
+ * valid, zero otherwise.
+ */
+int scsw_tm_is_valid_pno(union scsw *scsw)
+{
+	return (scsw->tm.fctl != 0) &&
+	       (scsw->tm.stctl & SCSW_STCTL_STATUS_PEND) &&
+	       (!(scsw->tm.stctl & SCSW_STCTL_INTER_STATUS) ||
+		 ((scsw->tm.stctl & SCSW_STCTL_INTER_STATUS) &&
+		  (scsw->tm.actl & SCSW_ACTL_SUSPENDED)));
+}
+EXPORT_SYMBOL(scsw_tm_is_valid_pno);
+
+/**
+ * scsw_tm_is_valid_fctl - check fctl field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the fctl field of the specified transport mode scsw is
+ * valid, zero otherwise.
+ */
+int scsw_tm_is_valid_fctl(union scsw *scsw)
+{
+	/* Only valid if pmcw.dnv == 1*/
+	return 1;
+}
+EXPORT_SYMBOL(scsw_tm_is_valid_fctl);
+
+/**
+ * scsw_tm_is_valid_actl - check actl field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the actl field of the specified transport mode scsw is
+ * valid, zero otherwise.
+ */
+int scsw_tm_is_valid_actl(union scsw *scsw)
+{
+	/* Only valid if pmcw.dnv == 1*/
+	return 1;
+}
+EXPORT_SYMBOL(scsw_tm_is_valid_actl);
+
+/**
+ * scsw_tm_is_valid_stctl - check stctl field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the stctl field of the specified transport mode scsw is
+ * valid, zero otherwise.
+ */
+int scsw_tm_is_valid_stctl(union scsw *scsw)
+{
+	/* Only valid if pmcw.dnv == 1*/
+	return 1;
+}
+EXPORT_SYMBOL(scsw_tm_is_valid_stctl);
+
+/**
+ * scsw_tm_is_valid_dstat - check dstat field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the dstat field of the specified transport mode scsw is
+ * valid, zero otherwise.
+ */
+int scsw_tm_is_valid_dstat(union scsw *scsw)
+{
+	return (scsw->tm.stctl & SCSW_STCTL_STATUS_PEND) &&
+	       (scsw->tm.cc != 3);
+}
+EXPORT_SYMBOL(scsw_tm_is_valid_dstat);
+
+/**
+ * scsw_tm_is_valid_cstat - check cstat field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the cstat field of the specified transport mode scsw is
+ * valid, zero otherwise.
+ */
+int scsw_tm_is_valid_cstat(union scsw *scsw)
+{
+	return (scsw->tm.stctl & SCSW_STCTL_STATUS_PEND) &&
+	       (scsw->tm.cc != 3);
+}
+EXPORT_SYMBOL(scsw_tm_is_valid_cstat);
+
+/**
+ * scsw_tm_is_valid_fcxs - check fcxs field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the fcxs field of the specified transport mode scsw is
+ * valid, zero otherwise.
+ */
+int scsw_tm_is_valid_fcxs(union scsw *scsw)
+{
+	return 1;
+}
+EXPORT_SYMBOL(scsw_tm_is_valid_fcxs);
+
+/**
+ * scsw_tm_is_valid_schxs - check schxs field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the schxs field of the specified transport mode scsw is
+ * valid, zero otherwise.
+ */
+int scsw_tm_is_valid_schxs(union scsw *scsw)
+{
+	return (scsw->tm.cstat & (SCHN_STAT_PROG_CHECK |
+				  SCHN_STAT_INTF_CTRL_CHK |
+				  SCHN_STAT_PROT_CHECK |
+				  SCHN_STAT_CHN_DATA_CHK));
+}
+EXPORT_SYMBOL(scsw_tm_is_valid_schxs);
+
+/**
+ * scsw_is_valid_actl - check actl field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the actl field of the specified scsw is valid,
+ * regardless of whether it is a transport mode or command mode scsw.
+ * Return zero if the field does not contain a valid value.
+ */
+int scsw_is_valid_actl(union scsw *scsw)
+{
+	if (scsw_is_tm(scsw))
+		return scsw_tm_is_valid_actl(scsw);
+	else
+		return scsw_cmd_is_valid_actl(scsw);
+}
+EXPORT_SYMBOL(scsw_is_valid_actl);
+
+/**
+ * scsw_is_valid_cc - check cc field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the cc field of the specified scsw is valid,
+ * regardless of whether it is a transport mode or command mode scsw.
+ * Return zero if the field does not contain a valid value.
+ */
+int scsw_is_valid_cc(union scsw *scsw)
+{
+	if (scsw_is_tm(scsw))
+		return scsw_tm_is_valid_cc(scsw);
+	else
+		return scsw_cmd_is_valid_cc(scsw);
+}
+EXPORT_SYMBOL(scsw_is_valid_cc);
+
+/**
+ * scsw_is_valid_cstat - check cstat field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the cstat field of the specified scsw is valid,
+ * regardless of whether it is a transport mode or command mode scsw.
+ * Return zero if the field does not contain a valid value.
+ */
+int scsw_is_valid_cstat(union scsw *scsw)
+{
+	if (scsw_is_tm(scsw))
+		return scsw_tm_is_valid_cstat(scsw);
+	else
+		return scsw_cmd_is_valid_cstat(scsw);
+}
+EXPORT_SYMBOL(scsw_is_valid_cstat);
+
+/**
+ * scsw_is_valid_dstat - check dstat field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the dstat field of the specified scsw is valid,
+ * regardless of whether it is a transport mode or command mode scsw.
+ * Return zero if the field does not contain a valid value.
+ */
+int scsw_is_valid_dstat(union scsw *scsw)
+{
+	if (scsw_is_tm(scsw))
+		return scsw_tm_is_valid_dstat(scsw);
+	else
+		return scsw_cmd_is_valid_dstat(scsw);
+}
+EXPORT_SYMBOL(scsw_is_valid_dstat);
+
+/**
+ * scsw_is_valid_ectl - check ectl field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the ectl field of the specified scsw is valid,
+ * regardless of whether it is a transport mode or command mode scsw.
+ * Return zero if the field does not contain a valid value.
+ */
+int scsw_is_valid_ectl(union scsw *scsw)
+{
+	if (scsw_is_tm(scsw))
+		return scsw_tm_is_valid_ectl(scsw);
+	else
+		return scsw_cmd_is_valid_ectl(scsw);
+}
+EXPORT_SYMBOL(scsw_is_valid_ectl);
+
+/**
+ * scsw_is_valid_eswf - check eswf field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the eswf field of the specified scsw is valid,
+ * regardless of whether it is a transport mode or command mode scsw.
+ * Return zero if the field does not contain a valid value.
+ */
+int scsw_is_valid_eswf(union scsw *scsw)
+{
+	if (scsw_is_tm(scsw))
+		return scsw_tm_is_valid_eswf(scsw);
+	else
+		return scsw_cmd_is_valid_eswf(scsw);
+}
+EXPORT_SYMBOL(scsw_is_valid_eswf);
+
+/**
+ * scsw_is_valid_fctl - check fctl field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the fctl field of the specified scsw is valid,
+ * regardless of whether it is a transport mode or command mode scsw.
+ * Return zero if the field does not contain a valid value.
+ */
+int scsw_is_valid_fctl(union scsw *scsw)
+{
+	if (scsw_is_tm(scsw))
+		return scsw_tm_is_valid_fctl(scsw);
+	else
+		return scsw_cmd_is_valid_fctl(scsw);
+}
+EXPORT_SYMBOL(scsw_is_valid_fctl);
+
+/**
+ * scsw_is_valid_key - check key field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the key field of the specified scsw is valid,
+ * regardless of whether it is a transport mode or command mode scsw.
+ * Return zero if the field does not contain a valid value.
+ */
+int scsw_is_valid_key(union scsw *scsw)
+{
+	if (scsw_is_tm(scsw))
+		return scsw_tm_is_valid_key(scsw);
+	else
+		return scsw_cmd_is_valid_key(scsw);
+}
+EXPORT_SYMBOL(scsw_is_valid_key);
+
+/**
+ * scsw_is_valid_pno - check pno field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the pno field of the specified scsw is valid,
+ * regardless of whether it is a transport mode or command mode scsw.
+ * Return zero if the field does not contain a valid value.
+ */
+int scsw_is_valid_pno(union scsw *scsw)
+{
+	if (scsw_is_tm(scsw))
+		return scsw_tm_is_valid_pno(scsw);
+	else
+		return scsw_cmd_is_valid_pno(scsw);
+}
+EXPORT_SYMBOL(scsw_is_valid_pno);
+
+/**
+ * scsw_is_valid_stctl - check stctl field validity
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the stctl field of the specified scsw is valid,
+ * regardless of whether it is a transport mode or command mode scsw.
+ * Return zero if the field does not contain a valid value.
+ */
+int scsw_is_valid_stctl(union scsw *scsw)
+{
+	if (scsw_is_tm(scsw))
+		return scsw_tm_is_valid_stctl(scsw);
+	else
+		return scsw_cmd_is_valid_stctl(scsw);
+}
+EXPORT_SYMBOL(scsw_is_valid_stctl);
+
+/**
+ * scsw_cmd_is_solicited - check for solicited scsw
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the command mode scsw indicates that the associated
+ * status condition is solicited, zero if it is unsolicited.
+ */
+int scsw_cmd_is_solicited(union scsw *scsw)
+{
+	return (scsw->cmd.cc != 0) || (scsw->cmd.stctl !=
+		(SCSW_STCTL_STATUS_PEND | SCSW_STCTL_ALERT_STATUS));
+}
+EXPORT_SYMBOL(scsw_cmd_is_solicited);
+
+/**
+ * scsw_tm_is_solicited - check for solicited scsw
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the transport mode scsw indicates that the associated
+ * status condition is solicited, zero if it is unsolicited.
+ */
+int scsw_tm_is_solicited(union scsw *scsw)
+{
+	return (scsw->tm.cc != 0) || (scsw->tm.stctl !=
+		(SCSW_STCTL_STATUS_PEND | SCSW_STCTL_ALERT_STATUS));
+}
+EXPORT_SYMBOL(scsw_tm_is_solicited);
+
+/**
+ * scsw_is_solicited - check for solicited scsw
+ * @scsw: pointer to scsw
+ *
+ * Return non-zero if the transport or command mode scsw indicates that the
+ * associated status condition is solicited, zero if it is unsolicited.
+ */
+int scsw_is_solicited(union scsw *scsw)
+{
+	if (scsw_is_tm(scsw))
+		return scsw_tm_is_solicited(scsw);
+	else
+		return scsw_cmd_is_solicited(scsw);
+}
+EXPORT_SYMBOL(scsw_is_solicited);
Index: quilt-2.6/drivers/s390/net/claw.c
===================================================================
--- quilt-2.6.orig/drivers/s390/net/claw.c
+++ quilt-2.6/drivers/s390/net/claw.c
@@ -703,7 +703,8 @@ claw_irq_handler(struct ccw_device *cdev
 	if (!cdev->dev.driver_data) {
                 printk(KERN_WARNING "claw: unsolicited interrupt for device:"
 		 	"%s received c-%02x d-%02x\n",
-                        cdev->dev.bus_id,irb->scsw.cstat, irb->scsw.dstat);
+		       cdev->dev.bus_id, irb->scsw.cmd.cstat,
+		       irb->scsw.cmd.dstat);
 #ifdef FUNCTRACE
                 printk(KERN_INFO "claw: %s() "
 			"exit on line %d\n",__func__,__LINE__);
@@ -732,22 +733,23 @@ claw_irq_handler(struct ccw_device *cdev
 #ifdef IOTRACE
         printk(KERN_INFO "%s: interrupt for device: %04x "
 		"received c-%02x d-%02x state-%02x\n",
-                dev->name, p_ch->devno, irb->scsw.cstat,
-		irb->scsw.dstat, p_ch->claw_state);
+	       dev->name, p_ch->devno, irb->scsw.cmd.cstat,
+	       irb->scsw.cmd.dstat, p_ch->claw_state);
 #endif
 
 	/* Copy interruption response block. */
 	memcpy(p_ch->irb, irb, sizeof(struct irb));
 
         /* Check for good subchannel return code, otherwise error message */
-        if (irb->scsw.cstat  &&  !(irb->scsw.cstat & SCHN_STAT_PCI)) {
+	if (irb->scsw.cmd.cstat && !(irb->scsw.cmd.cstat & SCHN_STAT_PCI)) {
                 printk(KERN_INFO "%s: subchannel check for device: %04x -"
 			" Sch Stat %02x  Dev Stat %02x CPA - %04x\n",
                         dev->name, p_ch->devno,
-			irb->scsw.cstat, irb->scsw.dstat,irb->scsw.cpa);
+			irb->scsw.cmd.cstat, irb->scsw.cmd.dstat,
+			irb->scsw.cmd.cpa);
 #ifdef IOTRACE
 		dumpit((char *)irb,sizeof(struct irb));
-		dumpit((char *)(unsigned long)irb->scsw.cpa,
+		dumpit((char *)(unsigned long)irb->scsw.cmd.cpa,
 			sizeof(struct ccw1));
 #endif
 #ifdef FUNCTRACE
@@ -759,22 +761,24 @@ claw_irq_handler(struct ccw_device *cdev
         }
 
         /* Check the reason-code of a unit check */
-        if (irb->scsw.dstat & DEV_STAT_UNIT_CHECK) {
+	if (irb->scsw.cmd.dstat & DEV_STAT_UNIT_CHECK)
                 ccw_check_unit_check(p_ch, irb->ecw[0]);
-        }
 
         /* State machine to bring the connection up, down and to restart */
-        p_ch->last_dstat = irb->scsw.dstat;
+	p_ch->last_dstat = irb->scsw.cmd.dstat;
 
         switch (p_ch->claw_state) {
                 case CLAW_STOP:/* HALT_IO by claw_release (halt sequence) */
 #ifdef DEBUGMSG
                         printk(KERN_INFO "%s: CLAW_STOP enter\n", dev->name);
 #endif
-                        if (!((p_ch->irb->scsw.stctl & SCSW_STCTL_SEC_STATUS) ||
-	    		(p_ch->irb->scsw.stctl == SCSW_STCTL_STATUS_PEND) ||
-	    		(p_ch->irb->scsw.stctl ==
-	     		(SCSW_STCTL_ALERT_STATUS | SCSW_STCTL_STATUS_PEND)))) {
+			if (!((p_ch->irb->scsw.cmd.stctl &
+			       SCSW_STCTL_SEC_STATUS) ||
+			    (p_ch->irb->scsw.cmd.stctl ==
+				SCSW_STCTL_STATUS_PEND) ||
+			    (p_ch->irb->scsw.cmd.stctl ==
+				(SCSW_STCTL_ALERT_STATUS |
+				 SCSW_STCTL_STATUS_PEND)))) {
 #ifdef FUNCTRACE
                                 printk(KERN_INFO "%s:%s Exit on line %d\n",
 					dev->name,__func__,__LINE__);
@@ -798,10 +802,13 @@ claw_irq_handler(struct ccw_device *cdev
                         printk(KERN_INFO "%s: process CLAW_STAT_HALT_IO\n",
 				dev->name);
 #endif
-                        if (!((p_ch->irb->scsw.stctl & SCSW_STCTL_SEC_STATUS) ||
-	    		(p_ch->irb->scsw.stctl == SCSW_STCTL_STATUS_PEND) ||
-	    		(p_ch->irb->scsw.stctl ==
-	     		(SCSW_STCTL_ALERT_STATUS | SCSW_STCTL_STATUS_PEND)))) {
+			if (!((p_ch->irb->scsw.cmd.stctl &
+			       SCSW_STCTL_SEC_STATUS) ||
+			    (p_ch->irb->scsw.cmd.stctl ==
+			     SCSW_STCTL_STATUS_PEND) ||
+			    (p_ch->irb->scsw.cmd.stctl ==
+			     (SCSW_STCTL_ALERT_STATUS |
+			      SCSW_STCTL_STATUS_PEND)))) {
 #ifdef FUNCTRACE
 				printk(KERN_INFO "%s:%s Exit on line %d\n",
 					dev->name,__func__,__LINE__);
@@ -828,8 +835,8 @@ claw_irq_handler(struct ccw_device *cdev
 					"interrupt for device:"
 				 	"%s received c-%02x d-%02x\n",
                 		        cdev->dev.bus_id,
-					irb->scsw.cstat,
-					irb->scsw.dstat);
+					irb->scsw.cmd.cstat,
+					irb->scsw.cmd.dstat);
 				return;
 				}
 #ifdef DEBUGMSG
@@ -844,7 +851,7 @@ claw_irq_handler(struct ccw_device *cdev
                         return;
                 case CLAW_START_READ:
 			CLAW_DBF_TEXT(4,trace,"ReadIRQ");
-                        if (p_ch->irb->scsw.dstat & DEV_STAT_UNIT_CHECK) {
+			if (p_ch->irb->scsw.cmd.dstat & DEV_STAT_UNIT_CHECK) {
                                 clear_bit(0, (void *)&p_ch->IO_active);
                                 if ((p_ch->irb->ecw[0] & 0x41) == 0x41 ||
                                     (p_ch->irb->ecw[0] & 0x40) == 0x40 ||
@@ -863,8 +870,8 @@ claw_irq_handler(struct ccw_device *cdev
 					CLAW_DBF_TEXT(4,trace,"notrdy");
                                         return;
                         }
-                        if ((p_ch->irb->scsw.cstat & SCHN_STAT_PCI) &&
-			    (p_ch->irb->scsw.dstat==0)) {
+			if ((p_ch->irb->scsw.cmd.cstat & SCHN_STAT_PCI) &&
+			    (p_ch->irb->scsw.cmd.dstat == 0)) {
                                 if (test_and_set_bit(CLAW_BH_ACTIVE,
 					(void *)&p_ch->flag_a) == 0) {
 					tasklet_schedule(&p_ch->tasklet);
@@ -879,10 +886,13 @@ claw_irq_handler(struct ccw_device *cdev
 				CLAW_DBF_TEXT(4,trace,"PCI_read");
                                 return;
                         }
-                        if(!((p_ch->irb->scsw.stctl & SCSW_STCTL_SEC_STATUS) ||
-	    		 (p_ch->irb->scsw.stctl == SCSW_STCTL_STATUS_PEND) ||
-	    		 (p_ch->irb->scsw.stctl ==
-	     		 (SCSW_STCTL_ALERT_STATUS | SCSW_STCTL_STATUS_PEND)))) {
+			if (!((p_ch->irb->scsw.cmd.stctl &
+			       SCSW_STCTL_SEC_STATUS) ||
+			     (p_ch->irb->scsw.cmd.stctl ==
+			      SCSW_STCTL_STATUS_PEND) ||
+			     (p_ch->irb->scsw.cmd.stctl ==
+			      (SCSW_STCTL_ALERT_STATUS |
+			       SCSW_STCTL_STATUS_PEND)))) {
 #ifdef FUNCTRACE
 				printk(KERN_INFO "%s:%s Exit on line %d\n",
 					dev->name,__func__,__LINE__);
@@ -911,7 +921,7 @@ claw_irq_handler(struct ccw_device *cdev
 			CLAW_DBF_TEXT(4,trace,"RdIRQXit");
                         return;
                 case CLAW_START_WRITE:
-                        if (p_ch->irb->scsw.dstat & DEV_STAT_UNIT_CHECK) {
+			if (p_ch->irb->scsw.cmd.dstat & DEV_STAT_UNIT_CHECK) {
                                 printk(KERN_INFO "%s: Unit Check Occured in "
 					"write channel\n",dev->name);
                                 clear_bit(0, (void *)&p_ch->IO_active);
@@ -934,16 +944,19 @@ claw_irq_handler(struct ccw_device *cdev
 				CLAW_DBF_TEXT(4,trace,"rstrtwrt");
                                 return;
                         }
-                        if (p_ch->irb->scsw.dstat & DEV_STAT_UNIT_EXCEP) {
+			if (p_ch->irb->scsw.cmd.dstat & DEV_STAT_UNIT_EXCEP) {
                                         clear_bit(0, (void *)&p_ch->IO_active);
                                         printk(KERN_INFO "%s: Unit Exception "
 						"Occured in write channel\n",
 						dev->name);
                         }
-                        if(!((p_ch->irb->scsw.stctl & SCSW_STCTL_SEC_STATUS) ||
-	    		(p_ch->irb->scsw.stctl == SCSW_STCTL_STATUS_PEND) ||
-	    		(p_ch->irb->scsw.stctl ==
-	     		(SCSW_STCTL_ALERT_STATUS | SCSW_STCTL_STATUS_PEND)))) {
+			if (!((p_ch->irb->scsw.cmd.stctl &
+			       SCSW_STCTL_SEC_STATUS) ||
+			     (p_ch->irb->scsw.cmd.stctl ==
+			      SCSW_STCTL_STATUS_PEND) ||
+			     (p_ch->irb->scsw.cmd.stctl ==
+			      (SCSW_STCTL_ALERT_STATUS |
+			       SCSW_STCTL_STATUS_PEND)))) {
 #ifdef FUNCTRACE
 				printk(KERN_INFO "%s:%s Exit on line %d\n",
 					dev->name,__func__,__LINE__);
Index: quilt-2.6/drivers/s390/net/ctcm_fsms.c
===================================================================
--- quilt-2.6.orig/drivers/s390/net/ctcm_fsms.c
+++ quilt-2.6/drivers/s390/net/ctcm_fsms.c
@@ -257,9 +257,9 @@ static void chx_txdone(fsm_instance *fi,
 	if (duration > ch->prof.tx_time)
 		ch->prof.tx_time = duration;
 
-	if (ch->irb->scsw.count != 0)
+	if (ch->irb->scsw.cmd.count != 0)
 		ctcm_pr_debug("%s: TX not complete, remaining %d bytes\n",
-			     dev->name, ch->irb->scsw.count);
+			     dev->name, ch->irb->scsw.cmd.count);
 	fsm_deltimer(&ch->timer);
 	while ((skb = skb_dequeue(&ch->io_queue))) {
 		priv->stats.tx_packets++;
@@ -353,7 +353,7 @@ static void chx_rx(fsm_instance *fi, int
 	struct channel *ch = arg;
 	struct net_device *dev = ch->netdev;
 	struct ctcm_priv *priv = dev->priv;
-	int len = ch->max_bufsize - ch->irb->scsw.count;
+	int len = ch->max_bufsize - ch->irb->scsw.cmd.count;
 	struct sk_buff *skb = ch->trans_skb;
 	__u16 block_len = *((__u16 *)skb->data);
 	int check_len;
@@ -1234,9 +1234,9 @@ static void ctcmpc_chx_txdone(fsm_instan
 	if (duration > ch->prof.tx_time)
 		ch->prof.tx_time = duration;
 
-	if (ch->irb->scsw.count != 0)
+	if (ch->irb->scsw.cmd.count != 0)
 		ctcm_pr_debug("%s: TX not complete, remaining %d bytes\n",
-				dev->name, ch->irb->scsw.count);
+				dev->name, ch->irb->scsw.cmd.count);
 	fsm_deltimer(&ch->timer);
 	while ((skb = skb_dequeue(&ch->io_queue))) {
 		priv->stats.tx_packets++;
@@ -1394,7 +1394,7 @@ static void ctcmpc_chx_rx(fsm_instance *
 	struct sk_buff		*skb = ch->trans_skb;
 	struct sk_buff		*new_skb;
 	unsigned long	saveflags = 0;	/* avoids compiler warning */
-	int len	= ch->max_bufsize - ch->irb->scsw.count;
+	int len	= ch->max_bufsize - ch->irb->scsw.cmd.count;
 
 	if (do_debug_data) {
 		CTCM_DBF_TEXT_(TRACE, CTC_DBF_DEBUG, "mpc_ch_rx %s cp:%i %s\n",
Index: quilt-2.6/drivers/s390/net/ctcm_main.c
===================================================================
--- quilt-2.6.orig/drivers/s390/net/ctcm_main.c
+++ quilt-2.6/drivers/s390/net/ctcm_main.c
@@ -1236,8 +1236,8 @@ static void ctcm_irq_handler(struct ccw_
 	/* Check for unsolicited interrupts. */
 	if (cgdev == NULL) {
 		ctcm_pr_warn("ctcm: Got unsolicited irq: %s c-%02x d-%02x\n",
-			    cdev->dev.bus_id, irb->scsw.cstat,
-			    irb->scsw.dstat);
+			    cdev->dev.bus_id, irb->scsw.cmd.cstat,
+			    irb->scsw.cmd.dstat);
 		return;
 	}
 
@@ -1266,40 +1266,40 @@ static void ctcm_irq_handler(struct ccw_
 				"received c-%02x d-%02x\n",
 				dev->name,
 				ch->id,
-				irb->scsw.cstat,
-				irb->scsw.dstat);
+				irb->scsw.cmd.cstat,
+				irb->scsw.cmd.dstat);
 
 	/* Copy interruption response block. */
 	memcpy(ch->irb, irb, sizeof(struct irb));
 
 	/* Check for good subchannel return code, otherwise error message */
-	if (irb->scsw.cstat) {
+	if (irb->scsw.cmd.cstat) {
 		fsm_event(ch->fsm, CTC_EVENT_SC_UNKNOWN, ch);
 		ctcm_pr_warn("%s: subchannel check for dev: %s - %02x %02x\n",
-			    dev->name, ch->id, irb->scsw.cstat,
-			    irb->scsw.dstat);
+			    dev->name, ch->id, irb->scsw.cmd.cstat,
+			    irb->scsw.cmd.dstat);
 		return;
 	}
 
 	/* Check the reason-code of a unit check */
-	if (irb->scsw.dstat & DEV_STAT_UNIT_CHECK) {
+	if (irb->scsw.cmd.dstat & DEV_STAT_UNIT_CHECK) {
 		ccw_unit_check(ch, irb->ecw[0]);
 		return;
 	}
-	if (irb->scsw.dstat & DEV_STAT_BUSY) {
-		if (irb->scsw.dstat & DEV_STAT_ATTENTION)
+	if (irb->scsw.cmd.dstat & DEV_STAT_BUSY) {
+		if (irb->scsw.cmd.dstat & DEV_STAT_ATTENTION)
 			fsm_event(ch->fsm, CTC_EVENT_ATTNBUSY, ch);
 		else
 			fsm_event(ch->fsm, CTC_EVENT_BUSY, ch);
 		return;
 	}
-	if (irb->scsw.dstat & DEV_STAT_ATTENTION) {
+	if (irb->scsw.cmd.dstat & DEV_STAT_ATTENTION) {
 		fsm_event(ch->fsm, CTC_EVENT_ATTN, ch);
 		return;
 	}
-	if ((irb->scsw.stctl & SCSW_STCTL_SEC_STATUS) ||
-	    (irb->scsw.stctl == SCSW_STCTL_STATUS_PEND) ||
-	    (irb->scsw.stctl ==
+	if ((irb->scsw.cmd.stctl & SCSW_STCTL_SEC_STATUS) ||
+	    (irb->scsw.cmd.stctl == SCSW_STCTL_STATUS_PEND) ||
+	    (irb->scsw.cmd.stctl ==
 	     (SCSW_STCTL_ALERT_STATUS | SCSW_STCTL_STATUS_PEND)))
 		fsm_event(ch->fsm, CTC_EVENT_FINSTAT, ch);
 	else
Index: quilt-2.6/drivers/s390/net/lcs.c
===================================================================
--- quilt-2.6.orig/drivers/s390/net/lcs.c
+++ quilt-2.6/drivers/s390/net/lcs.c
@@ -1327,8 +1327,8 @@ lcs_get_problem(struct ccw_device *cdev,
 	char *sense;
 
 	sense = (char *) irb->ecw;
-	cstat = irb->scsw.cstat;
-	dstat = irb->scsw.dstat;
+	cstat = irb->scsw.cmd.cstat;
+	dstat = irb->scsw.cmd.dstat;
 
 	if (cstat & (SCHN_STAT_CHN_CTRL_CHK | SCHN_STAT_INTF_CTRL_CHK |
 		     SCHN_STAT_CHN_DATA_CHK | SCHN_STAT_CHAIN_CHECK |
@@ -1388,11 +1388,13 @@ lcs_irq(struct ccw_device *cdev, unsigne
 	else
 		channel = &card->write;
 
-	cstat = irb->scsw.cstat;
-	dstat = irb->scsw.dstat;
+	cstat = irb->scsw.cmd.cstat;
+	dstat = irb->scsw.cmd.dstat;
 	LCS_DBF_TEXT_(5, trace, "Rint%s",cdev->dev.bus_id);
-	LCS_DBF_TEXT_(5, trace, "%4x%4x",irb->scsw.cstat, irb->scsw.dstat);
-	LCS_DBF_TEXT_(5, trace, "%4x%4x",irb->scsw.fctl, irb->scsw.actl);
+	LCS_DBF_TEXT_(5, trace, "%4x%4x", irb->scsw.cmd.cstat,
+		      irb->scsw.cmd.dstat);
+	LCS_DBF_TEXT_(5, trace, "%4x%4x", irb->scsw.cmd.fctl,
+		      irb->scsw.cmd.actl);
 
 	/* Check for channel and device errors presented */
 	rc = lcs_get_problem(cdev, irb);
@@ -1410,11 +1412,11 @@ lcs_irq(struct ccw_device *cdev, unsigne
 	}
 	/* How far in the ccw chain have we processed? */
 	if ((channel->state != LCS_CH_STATE_INIT) &&
-	    (irb->scsw.fctl & SCSW_FCTL_START_FUNC)) {
-		index = (struct ccw1 *) __va((addr_t) irb->scsw.cpa)
+	    (irb->scsw.cmd.fctl & SCSW_FCTL_START_FUNC)) {
+		index = (struct ccw1 *) __va((addr_t) irb->scsw.cmd.cpa)
 			- channel->ccws;
-		if ((irb->scsw.actl & SCSW_ACTL_SUSPENDED) ||
-		    (irb->scsw.cstat & SCHN_STAT_PCI))
+		if ((irb->scsw.cmd.actl & SCSW_ACTL_SUSPENDED) ||
+		    (irb->scsw.cmd.cstat & SCHN_STAT_PCI))
 			/* Bloody io subsystem tells us lies about cpa... */
 			index = (index - 1) & (LCS_NUM_BUFFS - 1);
 		while (channel->io_idx != index) {
@@ -1425,25 +1427,24 @@ lcs_irq(struct ccw_device *cdev, unsigne
 		}
 	}
 
-	if ((irb->scsw.dstat & DEV_STAT_DEV_END) ||
-	    (irb->scsw.dstat & DEV_STAT_CHN_END) ||
-	    (irb->scsw.dstat & DEV_STAT_UNIT_CHECK))
+	if ((irb->scsw.cmd.dstat & DEV_STAT_DEV_END) ||
+	    (irb->scsw.cmd.dstat & DEV_STAT_CHN_END) ||
+	    (irb->scsw.cmd.dstat & DEV_STAT_UNIT_CHECK))
 		/* Mark channel as stopped. */
 		channel->state = LCS_CH_STATE_STOPPED;
-	else if (irb->scsw.actl & SCSW_ACTL_SUSPENDED)
+	else if (irb->scsw.cmd.actl & SCSW_ACTL_SUSPENDED)
 		/* CCW execution stopped on a suspend bit. */
 		channel->state = LCS_CH_STATE_SUSPENDED;
-	if (irb->scsw.fctl & SCSW_FCTL_HALT_FUNC) {
-		if (irb->scsw.cc != 0) {
+	if (irb->scsw.cmd.fctl & SCSW_FCTL_HALT_FUNC) {
+		if (irb->scsw.cmd.cc != 0) {
 			ccw_device_halt(channel->ccwdev, (addr_t) channel);
 			return;
 		}
 		/* The channel has been stopped by halt_IO. */
 		channel->state = LCS_CH_STATE_HALTED;
 	}
-	if (irb->scsw.fctl & SCSW_FCTL_CLEAR_FUNC) {
+	if (irb->scsw.cmd.fctl & SCSW_FCTL_CLEAR_FUNC)
 		channel->state = LCS_CH_STATE_CLEARED;
-	}
 	/* Do the rest in the tasklet. */
 	tasklet_schedule(&channel->irq_tasklet);
 }
Index: quilt-2.6/drivers/s390/net/qeth_core_main.c
===================================================================
--- quilt-2.6.orig/drivers/s390/net/qeth_core_main.c
+++ quilt-2.6/drivers/s390/net/qeth_core_main.c
@@ -738,8 +738,8 @@ static int qeth_get_problem(struct ccw_d
 	char *sense;
 
 	sense = (char *) irb->ecw;
-	cstat = irb->scsw.cstat;
-	dstat = irb->scsw.dstat;
+	cstat = irb->scsw.cmd.cstat;
+	dstat = irb->scsw.cmd.dstat;
 
 	if (cstat & (SCHN_STAT_CHN_CTRL_CHK | SCHN_STAT_INTF_CTRL_CHK |
 		     SCHN_STAT_CHN_DATA_CHK | SCHN_STAT_CHAIN_CHECK |
@@ -826,8 +826,8 @@ static void qeth_irq(struct ccw_device *
 
 	if (__qeth_check_irb_error(cdev, intparm, irb))
 		return;
-	cstat = irb->scsw.cstat;
-	dstat = irb->scsw.dstat;
+	cstat = irb->scsw.cmd.cstat;
+	dstat = irb->scsw.cmd.dstat;
 
 	card = CARD_FROM_CDEV(cdev);
 	if (!card)
@@ -845,10 +845,10 @@ static void qeth_irq(struct ccw_device *
 	}
 	atomic_set(&channel->irq_pending, 0);
 
-	if (irb->scsw.fctl & (SCSW_FCTL_CLEAR_FUNC))
+	if (irb->scsw.cmd.fctl & (SCSW_FCTL_CLEAR_FUNC))
 		channel->state = CH_STATE_STOPPED;
 
-	if (irb->scsw.fctl & (SCSW_FCTL_HALT_FUNC))
+	if (irb->scsw.cmd.fctl & (SCSW_FCTL_HALT_FUNC))
 		channel->state = CH_STATE_HALTED;
 
 	/*let's wake up immediately on data channel*/
Index: quilt-2.6/include/asm-s390/cio.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/cio.h
+++ quilt-2.6/include/asm-s390/cio.h
@@ -16,7 +16,7 @@
 #define __MAX_CSSID 0
 
 /**
- * struct scsw - subchannel status word
+ * struct cmd_scsw - command-mode subchannel status word
  * @key: subchannel key
  * @sctl: suspend control
  * @eswf: esw format
@@ -38,7 +38,7 @@
  * @cstat: subchannel status
  * @count: residual count
  */
-struct scsw {
+struct cmd_scsw {
 	__u32 key  : 4;
 	__u32 sctl : 1;
 	__u32 eswf : 1;
@@ -61,6 +61,114 @@ struct scsw {
 	__u32 count : 16;
 } __attribute__ ((packed));
 
+/**
+ * struct tm_scsw - transport-mode subchannel status word
+ * @key: subchannel key
+ * @eswf: esw format
+ * @cc: deferred condition code
+ * @fmt: format
+ * @x: IRB-format control
+ * @q: interrogate-complete
+ * @ectl: extended control
+ * @pno: path not operational
+ * @fctl: function control
+ * @actl: activity control
+ * @stctl: status control
+ * @tcw: TCW address
+ * @dstat: device status
+ * @cstat: subchannel status
+ * @fcxs: FCX status
+ * @schxs: subchannel-extended status
+ */
+struct tm_scsw {
+	u32 key:4;
+	u32 :1;
+	u32 eswf:1;
+	u32 cc:2;
+	u32 fmt:3;
+	u32 x:1;
+	u32 q:1;
+	u32 :1;
+	u32 ectl:1;
+	u32 pno:1;
+	u32 :1;
+	u32 fctl:3;
+	u32 actl:7;
+	u32 stctl:5;
+	u32 tcw;
+	u32 dstat:8;
+	u32 cstat:8;
+	u32 fcxs:8;
+	u32 schxs:8;
+} __attribute__ ((packed));
+
+/**
+ * union scsw - subchannel status word
+ * @cmd: command-mode SCSW
+ * @tm: transport-mode SCSW
+ */
+union scsw {
+	struct cmd_scsw cmd;
+	struct tm_scsw tm;
+} __attribute__ ((packed));
+
+int scsw_is_tm(union scsw *scsw);
+u32 scsw_key(union scsw *scsw);
+u32 scsw_eswf(union scsw *scsw);
+u32 scsw_cc(union scsw *scsw);
+u32 scsw_ectl(union scsw *scsw);
+u32 scsw_pno(union scsw *scsw);
+u32 scsw_fctl(union scsw *scsw);
+u32 scsw_actl(union scsw *scsw);
+u32 scsw_stctl(union scsw *scsw);
+u32 scsw_dstat(union scsw *scsw);
+u32 scsw_cstat(union scsw *scsw);
+int scsw_is_solicited(union scsw *scsw);
+int scsw_is_valid_key(union scsw *scsw);
+int scsw_is_valid_eswf(union scsw *scsw);
+int scsw_is_valid_cc(union scsw *scsw);
+int scsw_is_valid_ectl(union scsw *scsw);
+int scsw_is_valid_pno(union scsw *scsw);
+int scsw_is_valid_fctl(union scsw *scsw);
+int scsw_is_valid_actl(union scsw *scsw);
+int scsw_is_valid_stctl(union scsw *scsw);
+int scsw_is_valid_dstat(union scsw *scsw);
+int scsw_is_valid_cstat(union scsw *scsw);
+int scsw_cmd_is_valid_key(union scsw *scsw);
+int scsw_cmd_is_valid_sctl(union scsw *scsw);
+int scsw_cmd_is_valid_eswf(union scsw *scsw);
+int scsw_cmd_is_valid_cc(union scsw *scsw);
+int scsw_cmd_is_valid_fmt(union scsw *scsw);
+int scsw_cmd_is_valid_pfch(union scsw *scsw);
+int scsw_cmd_is_valid_isic(union scsw *scsw);
+int scsw_cmd_is_valid_alcc(union scsw *scsw);
+int scsw_cmd_is_valid_ssi(union scsw *scsw);
+int scsw_cmd_is_valid_zcc(union scsw *scsw);
+int scsw_cmd_is_valid_ectl(union scsw *scsw);
+int scsw_cmd_is_valid_pno(union scsw *scsw);
+int scsw_cmd_is_valid_fctl(union scsw *scsw);
+int scsw_cmd_is_valid_actl(union scsw *scsw);
+int scsw_cmd_is_valid_stctl(union scsw *scsw);
+int scsw_cmd_is_valid_dstat(union scsw *scsw);
+int scsw_cmd_is_valid_cstat(union scsw *scsw);
+int scsw_cmd_is_solicited(union scsw *scsw);
+int scsw_tm_is_valid_key(union scsw *scsw);
+int scsw_tm_is_valid_eswf(union scsw *scsw);
+int scsw_tm_is_valid_cc(union scsw *scsw);
+int scsw_tm_is_valid_fmt(union scsw *scsw);
+int scsw_tm_is_valid_x(union scsw *scsw);
+int scsw_tm_is_valid_q(union scsw *scsw);
+int scsw_tm_is_valid_ectl(union scsw *scsw);
+int scsw_tm_is_valid_pno(union scsw *scsw);
+int scsw_tm_is_valid_fctl(union scsw *scsw);
+int scsw_tm_is_valid_actl(union scsw *scsw);
+int scsw_tm_is_valid_stctl(union scsw *scsw);
+int scsw_tm_is_valid_dstat(union scsw *scsw);
+int scsw_tm_is_valid_cstat(union scsw *scsw);
+int scsw_tm_is_valid_fcxs(union scsw *scsw);
+int scsw_tm_is_valid_schxs(union scsw *scsw);
+int scsw_tm_is_solicited(union scsw *scsw);
+
 #define SCSW_FCTL_CLEAR_FUNC	 0x1
 #define SCSW_FCTL_HALT_FUNC	 0x2
 #define SCSW_FCTL_START_FUNC	 0x4
@@ -303,7 +411,7 @@ struct esw3 {
  * if applicable).
  */
 struct irb {
-	struct scsw scsw;
+	union scsw scsw;
 	union {
 		struct esw0 esw0;
 		struct esw1 esw1;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
