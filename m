Return-Path: <linux-kernel-owner+w=401wt.eu-S1759493AbZFDQ0M@vger.kernel.org>
Message-Id: <20090604161859.951154288@de.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
Date: Thu, 04 Jun 2009 18:18:49 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 02/38] dasd: forward internal errors to dasd_sleep_on caller
Content-Disposition: inline; filename=dasd-forward-startio-errors.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Weinhuber <wein@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Weinhuber <wein@de.ibm.com>

If a DASD requests is started with dasd_sleep_on and fails, then the
calling function may need to know the reason for the failure.
In cases of hardware errors it can inspect the sense data in the irb,
but when the reason is internal (e.g. start_IO failed) then it needs
a meaningfull return code.

Signed-off-by: Stefan Weinhuber <wein@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 drivers/s390/block/dasd.c      |   30 ++++++++++++++++++++++++------
 drivers/s390/block/dasd_diag.c |    1 +
 drivers/s390/block/dasd_eckd.c |    8 +++++---
 drivers/s390/block/dasd_int.h  |    1 +
 4 files changed, 31 insertions(+), 9 deletions(-)

Index: linux-2.6/drivers/s390/block/dasd.c
===================================================================
--- linux-2.6.orig/drivers/s390/block/dasd.c
+++ linux-2.6/drivers/s390/block/dasd.c
@@ -851,8 +851,10 @@ int dasd_start_IO(struct dasd_ccw_req *c
 
 	/* Check the cqr */
 	rc = dasd_check_cqr(cqr);
-	if (rc)
+	if (rc) {
+		cqr->intrc = rc;
 		return rc;
+	}
 	device = (struct dasd_device *) cqr->startdev;
 	if (cqr->retries < 0) {
 		/* internal error 14 - start_IO run out of retries */
@@ -915,6 +917,7 @@ int dasd_start_IO(struct dasd_ccw_req *c
 		BUG();
 		break;
 	}
+	cqr->intrc = rc;
 	return rc;
 }
 
@@ -1454,8 +1457,12 @@ int dasd_sleep_on(struct dasd_ccw_req *c
 	dasd_add_request_tail(cqr);
 	wait_event(generic_waitq, _wait_for_wakeup(cqr));
 
-	/* Request status is either done or failed. */
-	rc = (cqr->status == DASD_CQR_DONE) ? 0 : -EIO;
+	if (cqr->status == DASD_CQR_DONE)
+		rc = 0;
+	else if (cqr->intrc)
+		rc = cqr->intrc;
+	else
+		rc = -EIO;
 	return rc;
 }
 
@@ -1477,8 +1484,15 @@ int dasd_sleep_on_interruptible(struct d
 		dasd_cancel_req(cqr);
 		/* wait (non-interruptible) for final status */
 		wait_event(generic_waitq, _wait_for_wakeup(cqr));
+		cqr->intrc = rc;
 	}
-	rc = (cqr->status == DASD_CQR_DONE) ? 0 : -EIO;
+
+	if (cqr->status == DASD_CQR_DONE)
+		rc = 0;
+	else if (cqr->intrc)
+		rc = cqr->intrc;
+	else
+		rc = -EIO;
 	return rc;
 }
 
@@ -1523,8 +1537,12 @@ int dasd_sleep_on_immediatly(struct dasd
 
 	wait_event(generic_waitq, _wait_for_wakeup(cqr));
 
-	/* Request status is either done or failed. */
-	rc = (cqr->status == DASD_CQR_DONE) ? 0 : -EIO;
+	if (cqr->status == DASD_CQR_DONE)
+		rc = 0;
+	else if (cqr->intrc)
+		rc = cqr->intrc;
+	else
+		rc = -EIO;
 	return rc;
 }
 
Index: linux-2.6/drivers/s390/block/dasd_diag.c
===================================================================
--- linux-2.6.orig/drivers/s390/block/dasd_diag.c
+++ linux-2.6/drivers/s390/block/dasd_diag.c
@@ -202,6 +202,7 @@ dasd_start_diag(struct dasd_ccw_req * cq
 		rc = -EIO;
 		break;
 	}
+	cqr->intrc = rc;
 	return rc;
 }
 
Index: linux-2.6/drivers/s390/block/dasd_int.h
===================================================================
--- linux-2.6.orig/drivers/s390/block/dasd_int.h
+++ linux-2.6/drivers/s390/block/dasd_int.h
@@ -173,6 +173,7 @@ struct dasd_ccw_req {
 	void *data;			/* pointer to data area */
 
 	/* these are important for recovering erroneous requests          */
+	int intrc;			/* internal error, e.g. from start_IO */
 	struct irb irb;			/* device status in case of an error */
 	struct dasd_ccw_req *refers;	/* ERP-chain queueing. */
 	void *function; 		/* originating ERP action */
Index: linux-2.6/drivers/s390/block/dasd_eckd.c
===================================================================
--- linux-2.6.orig/drivers/s390/block/dasd_eckd.c
+++ linux-2.6/drivers/s390/block/dasd_eckd.c
@@ -3017,8 +3017,9 @@ static void dasd_eckd_dump_sense_ccw(str
 		      " I/O status report for device %s:\n",
 		      dev_name(&device->cdev->dev));
 	len += sprintf(page + len, KERN_ERR PRINTK_HEADER
-		       " in req: %p CS: 0x%02X DS: 0x%02X\n", req,
-		       scsw_cstat(&irb->scsw), scsw_dstat(&irb->scsw));
+		       " in req: %p CS: 0x%02X DS: 0x%02X CC: 0x%02X RC: %d\n",
+		       req, scsw_cstat(&irb->scsw), scsw_dstat(&irb->scsw),
+		       scsw_cc(&irb->scsw), req->intrc);
 	len += sprintf(page + len, KERN_ERR PRINTK_HEADER
 		       " device %s: Failing CCW: %p\n",
 		       dev_name(&device->cdev->dev),
@@ -3119,9 +3120,10 @@ static void dasd_eckd_dump_sense_tcw(str
 		      " I/O status report for device %s:\n",
 		      dev_name(&device->cdev->dev));
 	len += sprintf(page + len, KERN_ERR PRINTK_HEADER
-		       " in req: %p CS: 0x%02X DS: 0x%02X "
+		       " in req: %p CS: 0x%02X DS: 0x%02X CC: 0x%02X RC: %d "
 		       "fcxs: 0x%02X schxs: 0x%02X\n", req,
 		       scsw_cstat(&irb->scsw), scsw_dstat(&irb->scsw),
+		       scsw_cc(&irb->scsw), req->intrc,
 		       irb->scsw.tm.fcxs, irb->scsw.tm.schxs);
 	len += sprintf(page + len, KERN_ERR PRINTK_HEADER
 		       " device %s: Failing TCW: %p\n",

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
