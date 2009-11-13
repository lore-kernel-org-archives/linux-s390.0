Return-Path: <linux-kernel-owner+w=401wt.eu-S1756644AbZKMPLM@vger.kernel.org>
Message-Id: <20091113150916.074101742@de.ibm.com>
Date: Fri, 13 Nov 2009 16:09:02 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 38/52] [PATCH] cio: use ccw request infrastructure for pgid
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=137-cio-internal-pgid.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Use the newly introduced ccw request infrastructure to implement
pgid related operations: sense pgid, set pgid and disband pg.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device.c      |    3 
 drivers/s390/cio/device.h      |    3 
 drivers/s390/cio/device_fsm.c  |  100 ----
 drivers/s390/cio/device_pgid.c |  868 +++++++++++++++++------------------------
 drivers/s390/cio/io_sch.h      |    5 
 5 files changed, 379 insertions(+), 600 deletions(-)

Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c	2009-11-13 16:08:19.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device.c	2009-11-13 16:08:20.000000000 +0100
@@ -957,9 +957,6 @@
 {
 	memset(&sch->config, 0, sizeof(sch->config));
 	sch->config.csense = 1;
-	/* Use subchannel mp mode when there is more than 1 installed CHPID. */
-	if ((sch->schib.pmcw.pim & (sch->schib.pmcw.pim - 1)) != 0)
-		sch->config.mp = 1;
 }
 
 static void io_subchannel_init_fields(struct subchannel *sch)
Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c	2009-11-13 16:08:20.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device_fsm.c	2009-11-13 16:08:20.000000000 +0100
@@ -394,58 +394,6 @@
 	wake_up(&cdev->private->wait_q);
 }
 
-static int cmp_pgid(struct pgid *p1, struct pgid *p2)
-{
-	char *c1;
-	char *c2;
-
-	c1 = (char *)p1;
-	c2 = (char *)p2;
-
-	return memcmp(c1 + 1, c2 + 1, sizeof(struct pgid) - 1);
-}
-
-static void __ccw_device_get_common_pgid(struct ccw_device *cdev)
-{
-	int i;
-	int last;
-
-	last = 0;
-	for (i = 0; i < 8; i++) {
-		if (cdev->private->pgid[i].inf.ps.state1 == SNID_STATE1_RESET)
-			/* No PGID yet */
-			continue;
-		if (cdev->private->pgid[last].inf.ps.state1 ==
-		    SNID_STATE1_RESET) {
-			/* First non-zero PGID */
-			last = i;
-			continue;
-		}
-		if (cmp_pgid(&cdev->private->pgid[i],
-			     &cdev->private->pgid[last]) == 0)
-			/* Non-conflicting PGIDs */
-			continue;
-
-		/* PGID mismatch, can't pathgroup. */
-		CIO_MSG_EVENT(0, "SNID - pgid mismatch for device "
-			      "0.%x.%04x, can't pathgroup\n",
-			      cdev->private->dev_id.ssid,
-			      cdev->private->dev_id.devno);
-		cdev->private->options.pgroup = 0;
-		return;
-	}
-	if (cdev->private->pgid[last].inf.ps.state1 ==
-	    SNID_STATE1_RESET)
-		/* No previous pgid found */
-		memcpy(&cdev->private->pgid[0],
-		       &channel_subsystems[0]->global_pgid,
-		       sizeof(struct pgid));
-	else
-		/* Use existing pgid */
-		memcpy(&cdev->private->pgid[0], &cdev->private->pgid[last],
-		       sizeof(struct pgid));
-}
-
 /*
  * Function called from device_pgid.c after sense path ground has completed.
  */
@@ -457,12 +405,8 @@
 	sch = to_subchannel(cdev->dev.parent);
 	switch (err) {
 	case -EOPNOTSUPP: /* path grouping not supported, use nop instead. */
-		cdev->private->options.pgroup = 0;
-		break;
 	case 0: /* success */
 	case -EACCES: /* partial success, some paths not operational */
-		/* Check if all pgids are equal or 0. */
-		__ccw_device_get_common_pgid(cdev);
 		break;
 	case -ETIME:		/* Sense path group id stopped by timeout. */
 	case -EUSERS:		/* device is reserved for someone else. */
@@ -474,7 +418,6 @@
 	}
 	/* Start Path Group verification. */
 	cdev->private->state = DEV_STATE_VERIFY;
-	cdev->private->flags.doverify = 0;
 	ccw_device_verify_start(cdev);
 }
 
@@ -537,7 +480,6 @@
 	sch->lpm = sch->vpm;
 	/* Repeat path verification? */
 	if (cdev->private->flags.doverify) {
-		cdev->private->flags.doverify = 0;
 		ccw_device_verify_start(cdev);
 		return;
 	}
@@ -602,7 +544,6 @@
 	if (!cdev->private->options.pgroup) {
 		/* Start initial path verification. */
 		cdev->private->state = DEV_STATE_VERIFY;
-		cdev->private->flags.doverify = 0;
 		ccw_device_verify_start(cdev);
 		return 0;
 	}
@@ -624,7 +565,6 @@
 		break;
 	default:
 		cdev->private->flags.donotify = 0;
-		dev_fsm_event(cdev, DEV_EVENT_NOTOPER);
 		ccw_device_done(cdev, DEV_STATE_NOT_OPER);
 		break;
 	}
@@ -673,27 +613,6 @@
 }
 
 /*
- * Handle timeout in device online/offline process.
- */
-static void
-ccw_device_onoff_timeout(struct ccw_device *cdev, enum dev_event dev_event)
-{
-	int ret;
-
-	ret = ccw_device_cancel_halt_clear(cdev);
-	switch (ret) {
-	case 0:
-		ccw_device_done(cdev, DEV_STATE_BOXED);
-		break;
-	case -ENODEV:
-		ccw_device_done(cdev, DEV_STATE_NOT_OPER);
-		break;
-	default:
-		ccw_device_set_timeout(cdev, 3*HZ);
-	}
-}
-
-/*
  * Handle not operational event in non-special state.
  */
 static void ccw_device_generic_notoper(struct ccw_device *cdev,
@@ -751,7 +670,6 @@
 	}
 	/* Device is idle, we can do the path verification. */
 	cdev->private->state = DEV_STATE_VERIFY;
-	cdev->private->flags.doverify = 0;
 	ccw_device_verify_start(cdev);
 }
 
@@ -1103,9 +1021,9 @@
 		[DEV_EVENT_VERIFY]	= ccw_device_nop,
 	},
 	[DEV_STATE_SENSE_PGID] = {
-		[DEV_EVENT_NOTOPER]	= ccw_device_generic_notoper,
-		[DEV_EVENT_INTERRUPT]	= ccw_device_sense_pgid_irq,
-		[DEV_EVENT_TIMEOUT]	= ccw_device_onoff_timeout,
+		[DEV_EVENT_NOTOPER]	= ccw_device_request_event,
+		[DEV_EVENT_INTERRUPT]	= ccw_device_request_event,
+		[DEV_EVENT_TIMEOUT]	= ccw_device_request_event,
 		[DEV_EVENT_VERIFY]	= ccw_device_nop,
 	},
 	[DEV_STATE_SENSE_ID] = {
@@ -1121,9 +1039,9 @@
 		[DEV_EVENT_VERIFY]	= ccw_device_offline_verify,
 	},
 	[DEV_STATE_VERIFY] = {
-		[DEV_EVENT_NOTOPER]	= ccw_device_generic_notoper,
-		[DEV_EVENT_INTERRUPT]	= ccw_device_verify_irq,
-		[DEV_EVENT_TIMEOUT]	= ccw_device_onoff_timeout,
+		[DEV_EVENT_NOTOPER]	= ccw_device_request_event,
+		[DEV_EVENT_INTERRUPT]	= ccw_device_request_event,
+		[DEV_EVENT_TIMEOUT]	= ccw_device_request_event,
 		[DEV_EVENT_VERIFY]	= ccw_device_delay_verify,
 	},
 	[DEV_STATE_ONLINE] = {
@@ -1139,9 +1057,9 @@
 		[DEV_EVENT_VERIFY]	= ccw_device_online_verify,
 	},
 	[DEV_STATE_DISBAND_PGID] = {
-		[DEV_EVENT_NOTOPER]	= ccw_device_generic_notoper,
-		[DEV_EVENT_INTERRUPT]	= ccw_device_disband_irq,
-		[DEV_EVENT_TIMEOUT]	= ccw_device_onoff_timeout,
+		[DEV_EVENT_NOTOPER]	= ccw_device_request_event,
+		[DEV_EVENT_INTERRUPT]	= ccw_device_request_event,
+		[DEV_EVENT_TIMEOUT]	= ccw_device_request_event,
 		[DEV_EVENT_VERIFY]	= ccw_device_nop,
 	},
 	[DEV_STATE_BOXED] = {
Index: quilt-2.6/drivers/s390/cio/device.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.h	2009-11-13 16:08:20.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device.h	2009-11-13 16:08:20.000000000 +0100
@@ -112,15 +112,12 @@
 
 /* Function prototypes for path grouping stuff. */
 void ccw_device_sense_pgid_start(struct ccw_device *);
-void ccw_device_sense_pgid_irq(struct ccw_device *, enum dev_event);
 void ccw_device_sense_pgid_done(struct ccw_device *, int);
 
 void ccw_device_verify_start(struct ccw_device *);
-void ccw_device_verify_irq(struct ccw_device *, enum dev_event);
 void ccw_device_verify_done(struct ccw_device *, int);
 
 void ccw_device_disband_start(struct ccw_device *);
-void ccw_device_disband_irq(struct ccw_device *, enum dev_event);
 void ccw_device_disband_done(struct ccw_device *, int);
 
 int ccw_device_call_handler(struct ccw_device *);
Index: quilt-2.6/drivers/s390/cio/device_pgid.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_pgid.c	2009-11-13 16:08:19.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device_pgid.c	2009-11-13 16:08:20.000000000 +0100
@@ -1,594 +1,460 @@
 /*
- * drivers/s390/cio/device_pgid.c
+ *  CCW device PGID and path verification I/O handling.
  *
- *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
- *			 IBM Corporation
- *    Author(s): Cornelia Huck (cornelia.huck@de.ibm.com)
- *		 Martin Schwidefsky (schwidefsky@de.ibm.com)
- *
- * Path Group ID functions.
+ *    Copyright IBM Corp. 2002,2009
+ *    Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
+ *		 Martin Schwidefsky <schwidefsky@de.ibm.com>
+ *		 Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
  */
 
-#include <linux/module.h>
-#include <linux/init.h>
-
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/bitops.h>
 #include <asm/ccwdev.h>
 #include <asm/cio.h>
-#include <asm/delay.h>
-#include <asm/lowcore.h>
 
 #include "cio.h"
 #include "cio_debug.h"
-#include "css.h"
 #include "device.h"
-#include "ioasm.h"
 #include "io_sch.h"
 
+#define PGID_RETRIES	5
+#define PGID_TIMEOUT	(10 * HZ)
+
 /*
- * Helper function called from interrupt context to decide whether an
- * operation should be tried again.
+ * Process path verification data and report result.
  */
-static int __ccw_device_should_retry(union scsw *scsw)
+static void verify_done(struct ccw_device *cdev, int rc)
 {
-	/* CC is only valid if start function bit is set. */
-	if ((scsw->cmd.fctl & SCSW_FCTL_START_FUNC) && scsw->cmd.cc == 1)
-		return 1;
-	/* No more activity. For sense and set PGID we stubbornly try again. */
-	if (!scsw->cmd.actl)
-		return 1;
-	return 0;
+	struct subchannel *sch = to_subchannel(cdev->dev.parent);
+	struct ccw_dev_id *id = &cdev->private->dev_id;
+	int mpath = !cdev->private->flags.pgid_single;
+	int pgroup = cdev->private->options.pgroup;
+
+	if (rc)
+		goto out;
+	/* Ensure consistent multipathing state at device and channel. */
+	if (sch->config.mp != mpath) {
+		sch->config.mp = mpath;
+		rc = cio_commit_config(sch);
+	}
+out:
+	CIO_MSG_EVENT(2, "vrfy: device 0.%x.%04x: rc=%d pgroup=%d mpath=%d "
+			 "vpm=%02x\n", id->ssid, id->devno, rc, pgroup, mpath,
+			 sch->vpm);
+	ccw_device_verify_done(cdev, rc);
 }
 
 /*
- * Start Sense Path Group ID helper function. Used in ccw_device_recog
- * and ccw_device_sense_pgid.
+ * Create channel program to perform a NOOP.
  */
-static int
-__ccw_device_sense_pgid_start(struct ccw_device *cdev)
+static void nop_build_cp(struct ccw_device *cdev)
 {
-	struct subchannel *sch;
-	struct ccw1 *ccw;
-	int ret;
-	int i;
-
-	sch = to_subchannel(cdev->dev.parent);
-	/* Return if we already checked on all paths. */
-	if (cdev->private->imask == 0)
-		return (sch->lpm == 0) ? -ENODEV : -EACCES;
-	i = 8 - ffs(cdev->private->imask);
-
-	/* Setup sense path group id channel program. */
-	ccw = cdev->private->iccws;
-	ccw->cmd_code = CCW_CMD_SENSE_PGID;
-	ccw->count = sizeof (struct pgid);
-	ccw->flags = CCW_FLAG_SLI;
-
-	/* Reset device status. */
-	memset(&cdev->private->irb, 0, sizeof(struct irb));
-	/* Try on every path. */
-	ret = -ENODEV;
-	while (cdev->private->imask != 0) {
-		/* Try every path multiple times. */
-		ccw->cda = (__u32) __pa (&cdev->private->pgid[i]);
-		if (cdev->private->iretry > 0) {
-			cdev->private->iretry--;
-			/* Reset internal retry indication. */
-			cdev->private->flags.intretry = 0;
-			ret = cio_start (sch, cdev->private->iccws, 
-					 cdev->private->imask);
-			/* ret is 0, -EBUSY, -EACCES or -ENODEV */
-			if (ret != -EACCES)
-				return ret;
-			CIO_MSG_EVENT(3, "SNID - Device %04x on Subchannel "
-				      "0.%x.%04x, lpm %02X, became 'not "
-				      "operational'\n",
-				      cdev->private->dev_id.devno,
-				      sch->schid.ssid,
-				      sch->schid.sch_no, cdev->private->imask);
+	struct ccw_request *req = &cdev->private->req;
+	struct ccw1 *cp = cdev->private->iccws;
 
-		}
-		cdev->private->imask >>= 1;
-		cdev->private->iretry = 5;
-		i++;
-	}
-
-	return ret;
+	cp->cmd_code	= CCW_CMD_NOOP;
+	cp->cda		= 0;
+	cp->count	= 0;
+	cp->flags	= CCW_FLAG_SLI;
+	req->cp		= cp;
 }
 
-void
-ccw_device_sense_pgid_start(struct ccw_device *cdev)
+/*
+ * Perform NOOP on a single path.
+ */
+static void nop_do(struct ccw_device *cdev)
 {
-	int ret;
+	struct subchannel *sch = to_subchannel(cdev->dev.parent);
+	struct ccw_request *req = &cdev->private->req;
 
-	/* Set a timeout of 60s */
-	ccw_device_set_timeout(cdev, 60*HZ);
+	/* Adjust lpm. */
+	req->lpm = lpm_adjust(req->lpm, sch->schib.pmcw.pam & sch->opm);
+	if (!req->lpm)
+		goto out_nopath;
+	nop_build_cp(cdev);
+	ccw_request_start(cdev);
+	return;
 
-	cdev->private->state = DEV_STATE_SENSE_PGID;
-	cdev->private->imask = 0x80;
-	cdev->private->iretry = 5;
-	memset (&cdev->private->pgid, 0, sizeof (cdev->private->pgid));
-	ret = __ccw_device_sense_pgid_start(cdev);
-	if (ret && ret != -EBUSY)
-		ccw_device_sense_pgid_done(cdev, ret);
+out_nopath:
+	verify_done(cdev, sch->vpm ? 0 : -EACCES);
 }
 
 /*
- * Called from interrupt context to check if a valid answer
- * to Sense Path Group ID was received.
+ * Adjust NOOP I/O status.
  */
-static int
-__ccw_device_check_sense_pgid(struct ccw_device *cdev)
+static enum io_status nop_filter(struct ccw_device *cdev, void *data,
+				 struct irb *irb, enum io_status status)
 {
-	struct subchannel *sch;
-	struct irb *irb;
-	int i;
-
-	sch = to_subchannel(cdev->dev.parent);
-	irb = &cdev->private->irb;
-	if (irb->scsw.cmd.fctl & (SCSW_FCTL_HALT_FUNC | SCSW_FCTL_CLEAR_FUNC)) {
-		/* Retry Sense PGID if requested. */
-		if (cdev->private->flags.intretry) {
-			cdev->private->flags.intretry = 0;
-			return -EAGAIN;
-		}
-		return -ETIME;
-	}
-	if (irb->esw.esw0.erw.cons &&
-	    (irb->ecw[0]&(SNS0_CMD_REJECT|SNS0_INTERVENTION_REQ))) {
-		/*
-		 * If the device doesn't support the Sense Path Group ID
-		 *  command further retries wouldn't help ...
-		 */
-		return -EOPNOTSUPP;
-	}
-	if (irb->esw.esw0.erw.cons) {
-		CIO_MSG_EVENT(2, "SNID - device 0.%x.%04x, unit check, "
-			      "lpum %02X, cnt %02d, sns : "
-			      "%02X%02X%02X%02X %02X%02X%02X%02X ...\n",
-			      cdev->private->dev_id.ssid,
-			      cdev->private->dev_id.devno,
-			      irb->esw.esw0.sublog.lpum,
-			      irb->esw.esw0.erw.scnt,
-			      irb->ecw[0], irb->ecw[1],
-			      irb->ecw[2], irb->ecw[3],
-			      irb->ecw[4], irb->ecw[5],
-			      irb->ecw[6], irb->ecw[7]);
-		return -EAGAIN;
-	}
-	if (irb->scsw.cmd.cc == 3) {
-		u8 lpm;
-
-		lpm = to_io_private(sch)->orb.cmd.lpm;
-		CIO_MSG_EVENT(3, "SNID - Device %04x on Subchannel 0.%x.%04x,"
-			      " lpm %02X, became 'not operational'\n",
-			      cdev->private->dev_id.devno, sch->schid.ssid,
-			      sch->schid.sch_no, lpm);
-		return -EACCES;
-	}
-	i = 8 - ffs(cdev->private->imask);
-	if (cdev->private->pgid[i].inf.ps.state2 == SNID_STATE2_RESVD_ELSE) {
-		CIO_MSG_EVENT(2, "SNID - Device %04x on Subchannel 0.%x.%04x "
-			      "is reserved by someone else\n",
-			      cdev->private->dev_id.devno, sch->schid.ssid,
-			      sch->schid.sch_no);
-		return -EUSERS;
-	}
-	return 0;
+	/* Only subchannel status might indicate a path error. */
+	if (status == IO_STATUS_ERROR && irb->scsw.cmd.cstat == 0)
+		return IO_DONE;
+	return status;
 }
 
 /*
- * Got interrupt for Sense Path Group ID.
+ * Process NOOP request result for a single path.
  */
-void
-ccw_device_sense_pgid_irq(struct ccw_device *cdev, enum dev_event dev_event)
+static void nop_callback(struct ccw_device *cdev, void *data, int rc)
 {
-	struct subchannel *sch;
-	struct irb *irb;
-	int ret;
+	struct subchannel *sch = to_subchannel(cdev->dev.parent);
+	struct ccw_request *req = &cdev->private->req;
 
-	irb = (struct irb *) __LC_IRB;
+	if (rc == 0)
+		sch->vpm |= req->lpm;
+	else if (rc != -EACCES)
+		goto err;
+	req->lpm >>= 1;
+	nop_do(cdev);
+	return;
 
-	if (irb->scsw.cmd.stctl ==
-	    (SCSW_STCTL_STATUS_PEND | SCSW_STCTL_ALERT_STATUS)) {
-		if (__ccw_device_should_retry(&irb->scsw)) {
-			ret = __ccw_device_sense_pgid_start(cdev);
-			if (ret && ret != -EBUSY)
-				ccw_device_sense_pgid_done(cdev, ret);
-		}
-		return;
-	}
-	if (ccw_device_accumulate_and_sense(cdev, irb) != 0)
-		return;
-	sch = to_subchannel(cdev->dev.parent);
-	ret = __ccw_device_check_sense_pgid(cdev);
-	memset(&cdev->private->irb, 0, sizeof(struct irb));
-	switch (ret) {
-	/* 0, -ETIME, -EOPNOTSUPP, -EAGAIN, -EACCES or -EUSERS */
-	case -EOPNOTSUPP:	/* Sense Path Group ID not supported */
-		ccw_device_sense_pgid_done(cdev, -EOPNOTSUPP);
-		break;
-	case -ETIME:		/* Sense path group id stopped by timeout. */
-		ccw_device_sense_pgid_done(cdev, -ETIME);
-		break;
-	case -EACCES:		/* channel is not operational. */
-		sch->lpm &= ~cdev->private->imask;
-		/* Fall through. */
-	case 0:			/* Sense Path Group ID successful. */
-		cdev->private->imask >>= 1;
-		cdev->private->iretry = 5;
-		/* Fall through. */
-	case -EAGAIN:		/* Try again. */
-		ret = __ccw_device_sense_pgid_start(cdev);
-		if (ret != 0 && ret != -EBUSY)
-			ccw_device_sense_pgid_done(cdev, ret);
-		break;
-	case -EUSERS:		/* device is reserved for someone else. */
-		ccw_device_sense_pgid_done(cdev, -EUSERS);
-		break;
-	}
+err:
+	verify_done(cdev, rc);
 }
 
 /*
- * Path Group ID helper function.
+ * Create channel program to perform SET PGID on a single path.
  */
-static int
-__ccw_device_do_pgid(struct ccw_device *cdev, __u8 func)
+static void spid_build_cp(struct ccw_device *cdev, u8 fn)
 {
-	struct subchannel *sch;
-	struct ccw1 *ccw;
-	int ret;
-
-	sch = to_subchannel(cdev->dev.parent);
-
-	/* Setup sense path group id channel program. */
-	cdev->private->pgid[0].inf.fc = func;
-	ccw = cdev->private->iccws;
-	if (cdev->private->flags.pgid_single)
-		cdev->private->pgid[0].inf.fc |= SPID_FUNC_SINGLE_PATH;
-	else
-		cdev->private->pgid[0].inf.fc |= SPID_FUNC_MULTI_PATH;
-	ccw->cmd_code = CCW_CMD_SET_PGID;
-	ccw->cda = (__u32) __pa (&cdev->private->pgid[0]);
-	ccw->count = sizeof (struct pgid);
-	ccw->flags = CCW_FLAG_SLI;
-
-	/* Reset device status. */
-	memset(&cdev->private->irb, 0, sizeof(struct irb));
-
-	/* Try multiple times. */
-	ret = -EACCES;
-	if (cdev->private->iretry > 0) {
-		cdev->private->iretry--;
-		/* Reset internal retry indication. */
-		cdev->private->flags.intretry = 0;
-		ret = cio_start (sch, cdev->private->iccws,
-				 cdev->private->imask);
-		/* We expect an interrupt in case of success or busy
-		 * indication. */
-		if ((ret == 0) || (ret == -EBUSY))
-			return ret;
-	}
-	/* PGID command failed on this path. */
-	CIO_MSG_EVENT(3, "SPID - Device %04x on Subchannel "
-		      "0.%x.%04x, lpm %02X, became 'not operational'\n",
-		      cdev->private->dev_id.devno, sch->schid.ssid,
-		      sch->schid.sch_no, cdev->private->imask);
-	return ret;
+	struct ccw_request *req = &cdev->private->req;
+	struct ccw1 *cp = cdev->private->iccws;
+	int i = 8 - ffs(req->lpm);
+	struct pgid *pgid = &cdev->private->pgid[i];
+
+	pgid->inf.fc	= fn;
+	cp->cmd_code	= CCW_CMD_SET_PGID;
+	cp->cda		= (u32) (addr_t) pgid;
+	cp->count	= sizeof(*pgid);
+	cp->flags	= CCW_FLAG_SLI;
+	req->cp		= cp;
 }
 
 /*
- * Helper function to send a nop ccw down a path.
- */
-static int __ccw_device_do_nop(struct ccw_device *cdev)
-{
-	struct subchannel *sch;
-	struct ccw1 *ccw;
-	int ret;
-
-	sch = to_subchannel(cdev->dev.parent);
-
-	/* Setup nop channel program. */
-	ccw = cdev->private->iccws;
-	ccw->cmd_code = CCW_CMD_NOOP;
-	ccw->cda = 0;
-	ccw->count = 0;
-	ccw->flags = CCW_FLAG_SLI;
-
-	/* Reset device status. */
-	memset(&cdev->private->irb, 0, sizeof(struct irb));
-
-	/* Try multiple times. */
-	ret = -EACCES;
-	if (cdev->private->iretry > 0) {
-		cdev->private->iretry--;
-		/* Reset internal retry indication. */
-		cdev->private->flags.intretry = 0;
-		ret = cio_start (sch, cdev->private->iccws,
-				 cdev->private->imask);
-		/* We expect an interrupt in case of success or busy
-		 * indication. */
-		if ((ret == 0) || (ret == -EBUSY))
-			return ret;
-	}
-	/* nop command failed on this path. */
-	CIO_MSG_EVENT(3, "NOP - Device %04x on Subchannel "
-		      "0.%x.%04x, lpm %02X, became 'not operational'\n",
-		      cdev->private->dev_id.devno, sch->schid.ssid,
-		      sch->schid.sch_no, cdev->private->imask);
-	return ret;
+ * Perform establish/resign SET PGID on a single path.
+ */
+static void spid_do(struct ccw_device *cdev)
+{
+	struct subchannel *sch = to_subchannel(cdev->dev.parent);
+	struct ccw_request *req = &cdev->private->req;
+	u8 fn;
+
+	/* Adjust lpm if paths are not set in pam. */
+	req->lpm = lpm_adjust(req->lpm, sch->schib.pmcw.pam);
+	if (!req->lpm)
+		goto out_nopath;
+	/* Channel program setup. */
+	if (req->lpm & sch->opm)
+		fn = SPID_FUNC_ESTABLISH;
+	else
+		fn = SPID_FUNC_RESIGN;
+	if (!cdev->private->flags.pgid_single)
+		fn |= SPID_FUNC_MULTI_PATH;
+	spid_build_cp(cdev, fn);
+	ccw_request_start(cdev);
+	return;
+
+out_nopath:
+	verify_done(cdev, sch->vpm ? 0 : -EACCES);
 }
 
+static void verify_start(struct ccw_device *cdev);
 
 /*
- * Called from interrupt context to check if a valid answer
- * to Set Path Group ID was received.
+ * Process SET PGID request result for a single path.
  */
-static int
-__ccw_device_check_pgid(struct ccw_device *cdev)
+static void spid_callback(struct ccw_device *cdev, void *data, int rc)
 {
-	struct subchannel *sch;
-	struct irb *irb;
+	struct subchannel *sch = to_subchannel(cdev->dev.parent);
+	struct ccw_request *req = &cdev->private->req;
 
-	sch = to_subchannel(cdev->dev.parent);
-	irb = &cdev->private->irb;
-	if (irb->scsw.cmd.fctl & (SCSW_FCTL_HALT_FUNC | SCSW_FCTL_CLEAR_FUNC)) {
-		/* Retry Set PGID if requested. */
-		if (cdev->private->flags.intretry) {
-			cdev->private->flags.intretry = 0;
-			return -EAGAIN;
+	switch (rc) {
+	case 0:
+		sch->vpm |= req->lpm & sch->opm;
+		break;
+	case -EACCES:
+		break;
+	case -EOPNOTSUPP:
+		if (!cdev->private->flags.pgid_single) {
+			/* Try without multipathing. */
+			cdev->private->flags.pgid_single = 1;
+			goto out_restart;
 		}
-		return -ETIME;
-	}
-	if (irb->esw.esw0.erw.cons) {
-		if (irb->ecw[0] & SNS0_CMD_REJECT)
-			return -EOPNOTSUPP;
-		/* Hmm, whatever happened, try again. */
-		CIO_MSG_EVENT(2, "SPID - device 0.%x.%04x, unit check, "
-			      "cnt %02d, "
-			      "sns : %02X%02X%02X%02X %02X%02X%02X%02X ...\n",
-			      cdev->private->dev_id.ssid,
-			      cdev->private->dev_id.devno,
-			      irb->esw.esw0.erw.scnt,
-			      irb->ecw[0], irb->ecw[1],
-			      irb->ecw[2], irb->ecw[3],
-			      irb->ecw[4], irb->ecw[5],
-			      irb->ecw[6], irb->ecw[7]);
-		return -EAGAIN;
-	}
-	if (irb->scsw.cmd.cc == 3) {
-		CIO_MSG_EVENT(3, "SPID - Device %04x on Subchannel 0.%x.%04x,"
-			      " lpm %02X, became 'not operational'\n",
-			      cdev->private->dev_id.devno, sch->schid.ssid,
-			      sch->schid.sch_no, cdev->private->imask);
-		return -EACCES;
+		/* Try without pathgrouping. */
+		cdev->private->options.pgroup = 0;
+		goto out_restart;
+	default:
+		goto err;
 	}
-	return 0;
+	req->lpm >>= 1;
+	spid_do(cdev);
+	return;
+
+out_restart:
+	verify_start(cdev);
+	return;
+err:
+	verify_done(cdev, rc);
+}
+
+static int pgid_cmp(struct pgid *p1, struct pgid *p2)
+{
+	return memcmp((char *) p1 + 1, (char *) p2 + 1,
+		      sizeof(struct pgid) - 1);
 }
 
 /*
- * Called from interrupt context to check the path status after a nop has
- * been send.
+ * Determine pathgroup state from PGID data.
  */
-static int __ccw_device_check_nop(struct ccw_device *cdev)
+static void pgid_analyze(struct ccw_device *cdev, struct pgid **p,
+			 int *mismatch, int *reserved, int *reset)
 {
-	struct subchannel *sch;
-	struct irb *irb;
+	struct pgid *pgid = &cdev->private->pgid[0];
+	struct pgid *first = NULL;
+	int lpm;
+	int i;
 
-	sch = to_subchannel(cdev->dev.parent);
-	irb = &cdev->private->irb;
-	if (irb->scsw.cmd.fctl & (SCSW_FCTL_HALT_FUNC | SCSW_FCTL_CLEAR_FUNC)) {
-		/* Retry NOP if requested. */
-		if (cdev->private->flags.intretry) {
-			cdev->private->flags.intretry = 0;
-			return -EAGAIN;
+	*mismatch = 0;
+	*reserved = 0;
+	*reset = 0;
+	for (i = 0, lpm = 0x80; i < 8; i++, pgid++, lpm >>= 1) {
+		if ((cdev->private->pgid_valid_mask & lpm) == 0)
+			continue;
+		if (pgid->inf.ps.state2 == SNID_STATE2_RESVD_ELSE)
+			*reserved = 1;
+		if (pgid->inf.ps.state1 == SNID_STATE1_RESET) {
+			/* A PGID was reset. */
+			*reset = 1;
+			continue;
 		}
-		return -ETIME;
-	}
-	if (irb->scsw.cmd.cc == 3) {
-		CIO_MSG_EVENT(3, "NOP - Device %04x on Subchannel 0.%x.%04x,"
-			      " lpm %02X, became 'not operational'\n",
-			      cdev->private->dev_id.devno, sch->schid.ssid,
-			      sch->schid.sch_no, cdev->private->imask);
-		return -EACCES;
+		if (!first) {
+			first = pgid;
+			continue;
+		}
+		if (pgid_cmp(pgid, first) != 0)
+			*mismatch = 1;
 	}
-	return 0;
+	if (!first)
+		first = &channel_subsystems[0]->global_pgid;
+	*p = first;
 }
 
-static void
-__ccw_device_verify_start(struct ccw_device *cdev)
+static void pgid_fill(struct ccw_device *cdev, struct pgid *pgid)
 {
-	struct subchannel *sch;
-	__u8 func;
-	int ret;
-
-	sch = to_subchannel(cdev->dev.parent);
-	/* Repeat for all paths. */
-	for (; cdev->private->imask; cdev->private->imask >>= 1,
-				     cdev->private->iretry = 5) {
-		if ((cdev->private->imask & sch->schib.pmcw.pam) == 0)
-			/* Path not available, try next. */
-			continue;
-		if (cdev->private->options.pgroup) {
-			if (sch->opm & cdev->private->imask)
-				func = SPID_FUNC_ESTABLISH;
-			else
-				func = SPID_FUNC_RESIGN;
-			ret = __ccw_device_do_pgid(cdev, func);
-		} else
-			ret = __ccw_device_do_nop(cdev);
-		/* We expect an interrupt in case of success or busy
-		 * indication. */
-		if (ret == 0 || ret == -EBUSY)
-			return;
-		/* Permanent path failure, try next. */
-	}
-	/* Done with all paths. */
-	ccw_device_verify_done(cdev, (sch->vpm != 0) ? 0 : -EACCES);
+	int i;
+
+	for (i = 0; i < 8; i++)
+		memcpy(&cdev->private->pgid[i], pgid, sizeof(struct pgid));
 }
-		
+
 /*
- * Got interrupt for Set Path Group ID.
+ * Process SENSE PGID data and report result.
  */
-void
-ccw_device_verify_irq(struct ccw_device *cdev, enum dev_event dev_event)
+static void snid_done(struct ccw_device *cdev, int rc)
 {
-	struct subchannel *sch;
-	struct irb *irb;
-	int ret;
-
-	irb = (struct irb *) __LC_IRB;
+	struct ccw_dev_id *id = &cdev->private->dev_id;
+	struct pgid *pgid;
+	int mismatch = 0;
+	int reserved = 0;
+	int reset = 0;
 
-	if (irb->scsw.cmd.stctl ==
-	    (SCSW_STCTL_STATUS_PEND | SCSW_STCTL_ALERT_STATUS)) {
-		if (__ccw_device_should_retry(&irb->scsw))
-			__ccw_device_verify_start(cdev);
-		return;
+	if (rc)
+		goto out;
+	pgid_analyze(cdev, &pgid, &mismatch, &reserved, &reset);
+	if (!mismatch) {
+		pgid_fill(cdev, pgid);
+		cdev->private->flags.pgid_rdy = 1;
 	}
-	if (ccw_device_accumulate_and_sense(cdev, irb) != 0)
-		return;
-	sch = to_subchannel(cdev->dev.parent);
-	if (cdev->private->options.pgroup)
-		ret = __ccw_device_check_pgid(cdev);
-	else
-		ret = __ccw_device_check_nop(cdev);
-	memset(&cdev->private->irb, 0, sizeof(struct irb));
+	if (reserved)
+		rc = -EUSERS;
+out:
+	CIO_MSG_EVENT(2, "snid: device 0.%x.%04x: rc=%d pvm=%02x mism=%d "
+		      "rsvd=%d reset=%d\n", id->ssid, id->devno, rc,
+		      cdev->private->pgid_valid_mask, mismatch, reserved,
+		      reset);
+	ccw_device_sense_pgid_done(cdev, rc);
+}
 
-	switch (ret) {
-	/* 0, -ETIME, -EAGAIN, -EOPNOTSUPP or -EACCES */
-	case 0:
-		/* Path verification ccw finished successfully, update lpm. */
-		sch->vpm |= sch->opm & cdev->private->imask;
-		/* Go on with next path. */
-		cdev->private->imask >>= 1;
-		cdev->private->iretry = 5;
-		__ccw_device_verify_start(cdev);
-		break;
-	case -EOPNOTSUPP:
-		/*
-		 * One of those strange devices which claim to be able
-		 * to do multipathing but not for Set Path Group ID.
-		 */
-		if (cdev->private->flags.pgid_single)
-			cdev->private->options.pgroup = 0;
-		else
-			cdev->private->flags.pgid_single = 1;
-		/* Retry */
-		sch->vpm = 0;
-		cdev->private->imask = 0x80;
-		cdev->private->iretry = 5;
-		/* fall through. */
-	case -EAGAIN:		/* Try again. */
-		__ccw_device_verify_start(cdev);
-		break;
-	case -ETIME:		/* Set path group id stopped by timeout. */
-		ccw_device_verify_done(cdev, -ETIME);
-		break;
-	case -EACCES:		/* channel is not operational. */
-		cdev->private->imask >>= 1;
-		cdev->private->iretry = 5;
-		__ccw_device_verify_start(cdev);
-		break;
-	}
+/*
+ * Create channel program to perform a SENSE PGID on a single path.
+ */
+static void snid_build_cp(struct ccw_device *cdev)
+{
+	struct ccw_request *req = &cdev->private->req;
+	struct ccw1 *cp = cdev->private->iccws;
+	int i = 8 - ffs(req->lpm);
+
+	/* Channel program setup. */
+	cp->cmd_code	= CCW_CMD_SENSE_PGID;
+	cp->cda		= (u32) (addr_t) &cdev->private->pgid[i];
+	cp->count	= sizeof(struct pgid);
+	cp->flags	= CCW_FLAG_SLI;
+	req->cp		= cp;
 }
 
-void
-ccw_device_verify_start(struct ccw_device *cdev)
+/*
+ * Perform SENSE PGID on a single path.
+ */
+static void snid_do(struct ccw_device *cdev)
 {
 	struct subchannel *sch = to_subchannel(cdev->dev.parent);
+	struct ccw_request *req = &cdev->private->req;
 
-	cdev->private->flags.pgid_single = 0;
-	cdev->private->imask = 0x80;
-	cdev->private->iretry = 5;
+	/* Adjust lpm if paths are not set in pam. */
+	req->lpm = lpm_adjust(req->lpm, sch->schib.pmcw.pam);
+	if (!req->lpm)
+		goto out_nopath;
+	snid_build_cp(cdev);
+	ccw_request_start(cdev);
+	return;
 
-	/* Start with empty vpm. */
-	sch->vpm = 0;
-
-	/* Get current pam. */
-	if (cio_update_schib(sch)) {
-		ccw_device_verify_done(cdev, -ENODEV);
-		return;
-	}
-	/* After 60s path verification is considered to have failed. */
-	ccw_device_set_timeout(cdev, 60*HZ);
-	__ccw_device_verify_start(cdev);
-}
-
-static void
-__ccw_device_disband_start(struct ccw_device *cdev)
-{
-	struct subchannel *sch;
-	int ret;
-
-	sch = to_subchannel(cdev->dev.parent);
-	while (cdev->private->imask != 0) {
-		if (sch->lpm & cdev->private->imask) {
-			ret = __ccw_device_do_pgid(cdev, SPID_FUNC_DISBAND);
-			if (ret == 0)
-				return;
-		}
-		cdev->private->iretry = 5;
-		cdev->private->imask >>= 1;
-	}
-	ccw_device_disband_done(cdev, (sch->lpm != 0) ? 0 : -ENODEV);
+out_nopath:
+	snid_done(cdev, cdev->private->pgid_valid_mask ? 0 : -EACCES);
 }
 
 /*
- * Got interrupt for Unset Path Group ID.
+ * Process SENSE PGID request result for single path.
+ */
+static void snid_callback(struct ccw_device *cdev, void *data, int rc)
+{
+	struct ccw_request *req = &cdev->private->req;
+
+	if (rc == 0)
+		cdev->private->pgid_valid_mask |= req->lpm;
+	else if (rc != -EACCES)
+		goto err;
+	req->lpm >>= 1;
+	snid_do(cdev);
+	return;
+
+err:
+	snid_done(cdev, rc);
+}
+
+/**
+ * ccw_device_sense_pgid_start - perform SENSE PGID
+ * @cdev: ccw device
+ *
+ * Execute a SENSE PGID channel program on each path to @cdev to update its
+ * PGID information. When finished, call ccw_device_sense_id_done with a
+ * return code specifying the result.
  */
-void
-ccw_device_disband_irq(struct ccw_device *cdev, enum dev_event dev_event)
+void ccw_device_sense_pgid_start(struct ccw_device *cdev)
 {
-	struct subchannel *sch;
-	struct irb *irb;
-	int ret;
+	struct ccw_request *req = &cdev->private->req;
 
-	irb = (struct irb *) __LC_IRB;
+	CIO_TRACE_EVENT(4, "snid");
+	CIO_HEX_EVENT(4, &cdev->private->dev_id, sizeof(cdev->private->dev_id));
+	/* Initialize PGID data. */
+	memset(cdev->private->pgid, 0, sizeof(cdev->private->pgid));
+	cdev->private->flags.pgid_rdy = 0;
+	cdev->private->pgid_valid_mask = 0;
+	/* Initialize request data. */
+	memset(req, 0, sizeof(*req));
+	req->timeout	= PGID_TIMEOUT;
+	req->maxretries	= PGID_RETRIES;
+	req->callback	= snid_callback;
+	req->lpm	= 0x80;
+	snid_do(cdev);
+}
 
-	if (irb->scsw.cmd.stctl ==
-	    (SCSW_STCTL_STATUS_PEND | SCSW_STCTL_ALERT_STATUS)) {
-		if (__ccw_device_should_retry(&irb->scsw))
-			__ccw_device_disband_start(cdev);
-		return;
+/*
+ * Perform path verification.
+ */
+static void verify_start(struct ccw_device *cdev)
+{
+	struct subchannel *sch = to_subchannel(cdev->dev.parent);
+	struct ccw_request *req = &cdev->private->req;
+
+	sch->vpm = 0;
+	/* Initialize request data. */
+	memset(req, 0, sizeof(*req));
+	req->timeout	= PGID_TIMEOUT;
+	req->maxretries	= PGID_RETRIES;
+	req->lpm	= 0x80;
+	if (cdev->private->options.pgroup) {
+		req->callback	= spid_callback;
+		spid_do(cdev);
+	} else {
+		req->filter	= nop_filter;
+		req->callback	= nop_callback;
+		nop_do(cdev);
 	}
-	if (ccw_device_accumulate_and_sense(cdev, irb) != 0)
-		return;
-	sch = to_subchannel(cdev->dev.parent);
-	ret = __ccw_device_check_pgid(cdev);
-	memset(&cdev->private->irb, 0, sizeof(struct irb));
-	switch (ret) {
-	/* 0, -ETIME, -EAGAIN, -EOPNOTSUPP or -EACCES */
-	case 0:			/* disband successful. */
-		ccw_device_disband_done(cdev, ret);
-		break;
-	case -EOPNOTSUPP:
-		/*
-		 * One of those strange devices which claim to be able
-		 * to do multipathing but not for Unset Path Group ID.
-		 */
+}
+
+/**
+ * ccw_device_verify_start - perform path verification
+ * @cdev: ccw device
+ *
+ * Perform an I/O on each available channel path to @cdev to determine which
+ * paths are operational. The resulting path mask is stored in sch->vpm.
+ * If device options specify pathgrouping, establish a pathgroup for the
+ * operational paths. When finished, call ccw_device_verify_done with a
+ * return code specifying the result.
+ */
+void ccw_device_verify_start(struct ccw_device *cdev)
+{
+	CIO_TRACE_EVENT(4, "vrfy");
+	CIO_HEX_EVENT(4, &cdev->private->dev_id, sizeof(cdev->private->dev_id));
+	if (!cdev->private->flags.pgid_rdy) {
+		/* No pathgrouping possible. */
+		cdev->private->options.pgroup = 0;
 		cdev->private->flags.pgid_single = 1;
-		/* fall through. */
-	case -EAGAIN:		/* Try again. */
-		__ccw_device_disband_start(cdev);
-		break;
-	case -ETIME:		/* Set path group id stopped by timeout. */
-		ccw_device_disband_done(cdev, -ETIME);
-		break;
-	case -EACCES:		/* channel is not operational. */
-		cdev->private->imask >>= 1;
-		cdev->private->iretry = 5;
-		__ccw_device_disband_start(cdev);
-		break;
-	}
+	} else
+		cdev->private->flags.pgid_single = 0;
+	cdev->private->flags.doverify = 0;
+	verify_start(cdev);
 }
 
-void
-ccw_device_disband_start(struct ccw_device *cdev)
+/*
+ * Process disband SET PGID request result.
+ */
+static void disband_callback(struct ccw_device *cdev, void *data, int rc)
+{
+	struct subchannel *sch = to_subchannel(cdev->dev.parent);
+	struct ccw_dev_id *id = &cdev->private->dev_id;
+
+	if (rc)
+		goto out;
+	/* Ensure consistent multipathing state at device and channel. */
+	cdev->private->flags.pgid_single = 1;
+	if (sch->config.mp) {
+		sch->config.mp = 0;
+		rc = cio_commit_config(sch);
+	}
+out:
+	CIO_MSG_EVENT(0, "disb: device 0.%x.%04x: rc=%d\n", id->ssid, id->devno,
+		      rc);
+	ccw_device_disband_done(cdev, rc);
+}
+
+/**
+ * ccw_device_disband_start - disband pathgroup
+ * @cdev: ccw device
+ *
+ * Execute a SET PGID channel program on @cdev to disband a previously
+ * established pathgroup. When finished, call ccw_device_disband_done with
+ * a return code specifying the result.
+ */
+void ccw_device_disband_start(struct ccw_device *cdev)
 {
-	/* After 60s disbanding is considered to have failed. */
-	ccw_device_set_timeout(cdev, 60*HZ);
+	struct subchannel *sch = to_subchannel(cdev->dev.parent);
+	struct ccw_request *req = &cdev->private->req;
+	u8 fn;
 
-	cdev->private->flags.pgid_single = 0;
-	cdev->private->iretry = 5;
-	cdev->private->imask = 0x80;
-	__ccw_device_disband_start(cdev);
+	CIO_TRACE_EVENT(4, "disb");
+	CIO_HEX_EVENT(4, &cdev->private->dev_id, sizeof(cdev->private->dev_id));
+	/* Request setup. */
+	memset(req, 0, sizeof(*req));
+	req->timeout	= PGID_TIMEOUT;
+	req->maxretries	= PGID_RETRIES;
+	req->lpm	= sch->schib.pmcw.pam & sch->opm;
+	req->callback	= disband_callback;
+	fn = SPID_FUNC_DISBAND;
+	if (!cdev->private->flags.pgid_single)
+		fn |= SPID_FUNC_MULTI_PATH;
+	spid_build_cp(cdev, fn);
+	ccw_request_start(cdev);
 }
Index: quilt-2.6/drivers/s390/cio/io_sch.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/io_sch.h	2009-11-13 16:08:20.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/io_sch.h	2009-11-13 16:08:20.000000000 +0100
@@ -149,8 +149,8 @@
 	struct ccw_dev_id dev_id;	/* device id */
 	struct subchannel_id schid;	/* subchannel number */
 	struct ccw_request req;		/* internal I/O request */
-	u8 imask;		/* lpm mask for SNID/SID/SPGID */
-	int iretry;		/* retry counter SNID/SID/SPGID */
+	int iretry;
+	u8 pgid_valid_mask;		/* mask of valid PGIDs */
 	struct {
 		unsigned int fast:1;	/* post with "channel end" */
 		unsigned int repall:1;	/* report every interrupt status */
@@ -167,6 +167,7 @@
 		unsigned int fake_irb:1;    /* deliver faked irb */
 		unsigned int intretry:1;    /* retry internal operation */
 		unsigned int resuming:1;    /* recognition while resume */
+		unsigned int pgid_rdy:1;    /* pgids are ready */
 	} __attribute__((packed)) flags;
 	unsigned long intparm;	/* user interruption parameter */
 	struct qdio_irq *qdio_data;
