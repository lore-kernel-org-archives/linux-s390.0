Return-Path: <linux-kernel-owner+w=401wt.eu-S1756699AbZKMPLV@vger.kernel.org>
Message-Id: <20091113150916.401269430@de.ibm.com>
Date: Fri, 13 Nov 2009 16:09:04 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 40/52] [PATCH] cio: remove intretry flag
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=139-cio-remove-intretry.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

After changing all internal I/O functions to use the newly introduced
ccw request infrastructure, retries are handled automatically after a
clear operation. Therefore remove the internal retry flag and
associated code.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device.c        |   58 +++++++++++----------------------------
 drivers/s390/cio/device.h        |    1 
 drivers/s390/cio/device_fsm.c    |   27 ------------------
 drivers/s390/cio/device_ops.c    |    3 --
 drivers/s390/cio/device_status.c |    3 --
 drivers/s390/cio/io_sch.h        |    1 
 6 files changed, 18 insertions(+), 75 deletions(-)

Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c	2009-11-13 16:08:20.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device.c	2009-11-13 16:08:20.000000000 +0100
@@ -1068,36 +1068,6 @@
 		dev_fsm_event(cdev, DEV_EVENT_VERIFY);
 }
 
-static int check_for_io_on_path(struct subchannel *sch, int mask)
-{
-	if (cio_update_schib(sch))
-		return 0;
-	if (scsw_actl(&sch->schib.scsw) && sch->schib.pmcw.lpum == mask)
-		return 1;
-	return 0;
-}
-
-static void terminate_internal_io(struct subchannel *sch,
-				  struct ccw_device *cdev)
-{
-	if (cio_clear(sch)) {
-		/* Recheck device in case clear failed. */
-		sch->lpm = 0;
-		if (cdev->online)
-			dev_fsm_event(cdev, DEV_EVENT_VERIFY);
-		else
-			css_schedule_eval(sch->schid);
-		return;
-	}
-	cdev->private->state = DEV_STATE_CLEAR_VERIFY;
-	/* Request retry of internal operation. */
-	cdev->private->flags.intretry = 1;
-	/* Call handler. */
-	if (cdev->handler)
-		cdev->handler(cdev, cdev->private->intparm,
-			      ERR_PTR(-EIO));
-}
-
 static void io_subchannel_terminate_path(struct subchannel *sch, u8 mask)
 {
 	struct ccw_device *cdev;
@@ -1105,18 +1075,24 @@
 	cdev = sch_get_cdev(sch);
 	if (!cdev)
 		return;
-	if (check_for_io_on_path(sch, mask)) {
-		if (cdev->private->state == DEV_STATE_ONLINE)
-			ccw_device_kill_io(cdev);
-		else {
-			terminate_internal_io(sch, cdev);
-			/* Re-start path verification. */
-			dev_fsm_event(cdev, DEV_EVENT_VERIFY);
-		}
-	} else
-		/* trigger path verification. */
-		dev_fsm_event(cdev, DEV_EVENT_VERIFY);
+	if (cio_update_schib(sch))
+		goto err;
+	/* Check for I/O on path. */
+	if (scsw_actl(&sch->schib.scsw) == 0 || sch->schib.pmcw.lpum != mask)
+		goto out;
+	if (cdev->private->state == DEV_STATE_ONLINE) {
+		ccw_device_kill_io(cdev);
+		goto out;
+	}
+	if (cio_clear(sch))
+		goto err;
+out:
+	/* Trigger path verification. */
+	dev_fsm_event(cdev, DEV_EVENT_VERIFY);
+	return;
 
+err:
+	dev_fsm_event(cdev, DEV_EVENT_NOTOPER);
 }
 
 static int io_subchannel_chp_event(struct subchannel *sch,
Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c	2009-11-13 16:08:20.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device_fsm.c	2009-11-13 16:08:20.000000000 +0100
@@ -771,12 +771,6 @@
 	 */
 	if (scsw_fctl(&irb->scsw) &
 	    (SCSW_FCTL_CLEAR_FUNC | SCSW_FCTL_HALT_FUNC)) {
-		/* Retry Basic Sense if requested. */
-		if (cdev->private->flags.intretry) {
-			cdev->private->flags.intretry = 0;
-			ccw_device_do_sense(cdev, irb);
-			return;
-		}
 		cdev->private->flags.dosense = 0;
 		memset(&cdev->private->irb, 0, sizeof(struct irb));
 		ccw_device_accumulate_irb(cdev, irb);
@@ -800,21 +794,6 @@
 }
 
 static void
-ccw_device_clear_verify(struct ccw_device *cdev, enum dev_event dev_event)
-{
-	struct irb *irb;
-
-	irb = (struct irb *) __LC_IRB;
-	/* Accumulate status. We don't do basic sense. */
-	ccw_device_accumulate_irb(cdev, irb);
-	/* Remember to clear irb to avoid residuals. */
-	memset(&cdev->private->irb, 0, sizeof(struct irb));
-	/* Try to start delayed device verification. */
-	ccw_device_online_verify(cdev, 0);
-	/* Note: Don't call handler for cio initiated clear! */
-}
-
-static void
 ccw_device_killing_irq(struct ccw_device *cdev, enum dev_event dev_event)
 {
 	struct subchannel *sch;
@@ -1069,12 +1048,6 @@
 		[DEV_EVENT_VERIFY]	= ccw_device_nop,
 	},
 	/* states to wait for i/o completion before doing something */
-	[DEV_STATE_CLEAR_VERIFY] = {
-		[DEV_EVENT_NOTOPER]	= ccw_device_generic_notoper,
-		[DEV_EVENT_INTERRUPT]   = ccw_device_clear_verify,
-		[DEV_EVENT_TIMEOUT]	= ccw_device_nop,
-		[DEV_EVENT_VERIFY]	= ccw_device_nop,
-	},
 	[DEV_STATE_TIMEOUT_KILL] = {
 		[DEV_EVENT_NOTOPER]	= ccw_device_generic_notoper,
 		[DEV_EVENT_INTERRUPT]	= ccw_device_killing_irq,
Index: quilt-2.6/drivers/s390/cio/device.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.h	2009-11-13 16:08:20.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device.h	2009-11-13 16:08:20.000000000 +0100
@@ -21,7 +21,6 @@
 	DEV_STATE_DISBAND_PGID,
 	DEV_STATE_BOXED,
 	/* states to wait for i/o completion before doing something */
-	DEV_STATE_CLEAR_VERIFY,
 	DEV_STATE_TIMEOUT_KILL,
 	DEV_STATE_QUIESCE,
 	/* special states for devices gone not operational */
Index: quilt-2.6/drivers/s390/cio/device_ops.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_ops.c	2009-11-13 15:48:33.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device_ops.c	2009-11-13 16:08:20.000000000 +0100
@@ -167,8 +167,7 @@
 		return -EINVAL;
 	if (cdev->private->state == DEV_STATE_NOT_OPER)
 		return -ENODEV;
-	if (cdev->private->state == DEV_STATE_VERIFY ||
-	    cdev->private->state == DEV_STATE_CLEAR_VERIFY) {
+	if (cdev->private->state == DEV_STATE_VERIFY) {
 		/* Remember to fake irb when finished. */
 		if (!cdev->private->flags.fake_irb) {
 			cdev->private->flags.fake_irb = 1;
Index: quilt-2.6/drivers/s390/cio/device_status.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_status.c	2009-11-13 15:48:33.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device_status.c	2009-11-13 16:08:20.000000000 +0100
@@ -336,9 +336,6 @@
 	sense_ccw->count = SENSE_MAX_COUNT;
 	sense_ccw->flags = CCW_FLAG_SLI;
 
-	/* Reset internal retry indication. */
-	cdev->private->flags.intretry = 0;
-
 	rc = cio_start(sch, sense_ccw, 0xff);
 	if (rc == -ENODEV || rc == -EACCES)
 		dev_fsm_event(cdev, DEV_EVENT_VERIFY);
Index: quilt-2.6/drivers/s390/cio/io_sch.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/io_sch.h	2009-11-13 16:08:20.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/io_sch.h	2009-11-13 16:08:20.000000000 +0100
@@ -165,7 +165,6 @@
 		unsigned int donotify:1;    /* call notify function */
 		unsigned int recog_done:1;  /* dev. recog. complete */
 		unsigned int fake_irb:1;    /* deliver faked irb */
-		unsigned int intretry:1;    /* retry internal operation */
 		unsigned int resuming:1;    /* recognition while resume */
 		unsigned int pgid_rdy:1;    /* pgids are ready */
 	} __attribute__((packed)) flags;
