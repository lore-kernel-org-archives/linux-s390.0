Return-Path: <linux-kernel-owner+w=401wt.eu-S1756508AbZKMPLb@vger.kernel.org>
Message-Id: <20091113150915.889532603@de.ibm.com>
Date: Fri, 13 Nov 2009 16:09:01 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 37/52] [PATCH] cio: use ccw request infrastructure for sense id
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=136-cio-internal-senseid.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Use the newly introduced ccw request infrastructure to implement
the sense id operation.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device.h     |    1 
 drivers/s390/cio/device_fsm.c |   66 +------
 drivers/s390/cio/device_id.c  |  371 +++++++++++++++---------------------------
 3 files changed, 152 insertions(+), 286 deletions(-)

Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c	2009-11-13 16:08:19.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device_fsm.c	2009-11-13 16:08:20.000000000 +0100
@@ -229,7 +229,6 @@
 
 	sch = to_subchannel(cdev->dev.parent);
 
-	ccw_device_set_timeout(cdev, 0);
 	cio_disable_subchannel(sch);
 	/*
 	 * Now that we tried recognition, we have performed device selection
@@ -263,22 +262,10 @@
 	}
 	switch (state) {
 	case DEV_STATE_NOT_OPER:
-		CIO_MSG_EVENT(2, "SenseID : unknown device %04x on "
-			      "subchannel 0.%x.%04x\n",
-			      cdev->private->dev_id.devno,
-			      sch->schid.ssid, sch->schid.sch_no);
 		break;
 	case DEV_STATE_OFFLINE:
 		if (!cdev->online) {
 			ccw_device_update_sense_data(cdev);
-			/* Issue device info message. */
-			CIO_MSG_EVENT(4, "SenseID : device 0.%x.%04x reports: "
-				      "CU  Type/Mod = %04X/%02X, Dev Type/Mod "
-				      "= %04X/%02X\n",
-				      cdev->private->dev_id.ssid,
-				      cdev->private->dev_id.devno,
-				      cdev->id.cu_type, cdev->id.cu_model,
-				      cdev->id.dev_type, cdev->id.dev_model);
 			break;
 		}
 		cdev->private->state = DEV_STATE_OFFLINE;
@@ -293,10 +280,6 @@
 		}
 		return;
 	case DEV_STATE_BOXED:
-		CIO_MSG_EVENT(0, "SenseID : boxed device %04x on "
-			      " subchannel 0.%x.%04x\n",
-			      cdev->private->dev_id.devno,
-			      sch->schid.ssid, sch->schid.sch_no);
 		if (cdev->id.cu_type != 0) { /* device was recognized before */
 			cdev->private->flags.recog_done = 1;
 			cdev->private->state = DEV_STATE_BOXED;
@@ -520,27 +503,25 @@
 }
 
 /*
- * Handle timeout in device recognition.
+ * Handle events for states that use the ccw request infrastructure.
  */
-static void
-ccw_device_recog_timeout(struct ccw_device *cdev, enum dev_event dev_event)
+static void ccw_device_request_event(struct ccw_device *cdev, enum dev_event e)
 {
-	int ret;
-
-	ret = ccw_device_cancel_halt_clear(cdev);
-	switch (ret) {
-	case 0:
-		ccw_device_recog_done(cdev, DEV_STATE_BOXED);
+	switch (e) {
+	case DEV_EVENT_NOTOPER:
+		ccw_request_notoper(cdev);
 		break;
-	case -ENODEV:
-		ccw_device_recog_done(cdev, DEV_STATE_NOT_OPER);
+	case DEV_EVENT_INTERRUPT:
+		ccw_request_handler(cdev);
+		break;
+	case DEV_EVENT_TIMEOUT:
+		ccw_request_timeout(cdev);
 		break;
 	default:
-		ccw_device_set_timeout(cdev, 3*HZ);
+		break;
 	}
 }
 
-
 void
 ccw_device_verify_done(struct ccw_device *cdev, int err)
 {
@@ -713,15 +694,6 @@
 }
 
 /*
- * Handle not oper event in device recognition.
- */
-static void
-ccw_device_recog_notoper(struct ccw_device *cdev, enum dev_event dev_event)
-{
-	ccw_device_recog_done(cdev, DEV_STATE_NOT_OPER);
-}
-
-/*
  * Handle not operational event in non-special state.
  */
 static void ccw_device_generic_notoper(struct ccw_device *cdev,
@@ -1015,10 +987,6 @@
 	if (cio_enable_subchannel(sch, (u32)(addr_t)sch) != 0)
 		/* Couldn't enable the subchannel for i/o. Sick device. */
 		return;
-
-	/* After 60s the device recognition is considered to have failed. */
-	ccw_device_set_timeout(cdev, 60*HZ);
-
 	cdev->private->state = DEV_STATE_DISCONNECTED_SENSE_ID;
 	ccw_device_sense_id_start(cdev);
 }
@@ -1141,9 +1109,9 @@
 		[DEV_EVENT_VERIFY]	= ccw_device_nop,
 	},
 	[DEV_STATE_SENSE_ID] = {
-		[DEV_EVENT_NOTOPER]	= ccw_device_recog_notoper,
-		[DEV_EVENT_INTERRUPT]	= ccw_device_sense_id_irq,
-		[DEV_EVENT_TIMEOUT]	= ccw_device_recog_timeout,
+		[DEV_EVENT_NOTOPER]	= ccw_device_request_event,
+		[DEV_EVENT_INTERRUPT]	= ccw_device_request_event,
+		[DEV_EVENT_TIMEOUT]	= ccw_device_request_event,
 		[DEV_EVENT_VERIFY]	= ccw_device_nop,
 	},
 	[DEV_STATE_OFFLINE] = {
@@ -1209,9 +1177,9 @@
 		[DEV_EVENT_VERIFY]	= ccw_device_start_id,
 	},
 	[DEV_STATE_DISCONNECTED_SENSE_ID] = {
-		[DEV_EVENT_NOTOPER]	= ccw_device_recog_notoper,
-		[DEV_EVENT_INTERRUPT]	= ccw_device_sense_id_irq,
-		[DEV_EVENT_TIMEOUT]	= ccw_device_recog_timeout,
+		[DEV_EVENT_NOTOPER]	= ccw_device_request_event,
+		[DEV_EVENT_INTERRUPT]	= ccw_device_request_event,
+		[DEV_EVENT_TIMEOUT]	= ccw_device_request_event,
 		[DEV_EVENT_VERIFY]	= ccw_device_nop,
 	},
 	[DEV_STATE_CMFCHANGE] = {
Index: quilt-2.6/drivers/s390/cio/device.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.h	2009-11-13 16:08:20.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device.h	2009-11-13 16:08:20.000000000 +0100
@@ -108,7 +108,6 @@
 
 /* Function prototypes for sense id stuff. */
 void ccw_device_sense_id_start(struct ccw_device *);
-void ccw_device_sense_id_irq(struct ccw_device *, enum dev_event);
 void ccw_device_sense_id_done(struct ccw_device *, int);
 
 /* Function prototypes for path grouping stuff. */
Index: quilt-2.6/drivers/s390/cio/device_id.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_id.c	2009-11-13 15:48:33.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device_id.c	2009-11-13 16:08:20.000000000 +0100
@@ -1,40 +1,39 @@
 /*
- * drivers/s390/cio/device_id.c
+ *  CCW device SENSE ID I/O handling.
  *
- *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
- *			 IBM Corporation
- *    Author(s): Cornelia Huck (cornelia.huck@de.ibm.com)
- *		 Martin Schwidefsky (schwidefsky@de.ibm.com)
- *
- * Sense ID functions.
+ *    Copyright IBM Corp. 2002,2009
+ *    Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
+ *		 Martin Schwidefsky <schwidefsky@de.ibm.com>
+ *		 Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
  */
 
-#include <linux/module.h>
-#include <linux/init.h>
 #include <linux/kernel.h>
-
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/errno.h>
 #include <asm/ccwdev.h>
-#include <asm/delay.h>
+#include <asm/setup.h>
 #include <asm/cio.h>
-#include <asm/lowcore.h>
 #include <asm/diag.h>
 
 #include "cio.h"
 #include "cio_debug.h"
-#include "css.h"
 #include "device.h"
-#include "ioasm.h"
 #include "io_sch.h"
 
+#define SENSE_ID_RETRIES	5
+#define SENSE_ID_TIMEOUT	(10 * HZ)
+#define SENSE_ID_MIN_LEN	4
+#define SENSE_ID_BASIC_LEN	7
+
 /**
- * vm_vdev_to_cu_type - Convert vm virtual device into control unit type
- *			for certain devices.
- * @class: virtual device class
- * @type: virtual device type
+ * diag210_to_senseid - convert diag 0x210 data to sense id information
+ * @senseid: sense id
+ * @diag: diag 0x210 data
  *
- * Returns control unit type if a match was made or %0xffff otherwise.
+ * Return 0 on success, non-zero otherwise.
  */
-static int vm_vdev_to_cu_type(int class, int type)
+static int diag210_to_senseid(struct senseid *senseid, struct diag210 *diag)
 {
 	static struct {
 		int class, type, cu_type;
@@ -71,253 +70,153 @@
 	};
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(vm_devices); i++)
-		if (class == vm_devices[i].class && type == vm_devices[i].type)
-			return vm_devices[i].cu_type;
+	/* Special case for osa devices. */
+	if (diag->vrdcvcla == 0x02 && diag->vrdcvtyp == 0x20) {
+		senseid->cu_type = 0x3088;
+		senseid->cu_model = 0x60;
+		senseid->reserved = 0xff;
+		return 0;
+	}
+	for (i = 0; i < ARRAY_SIZE(vm_devices); i++) {
+		if (diag->vrdcvcla == vm_devices[i].class &&
+		    diag->vrdcvtyp == vm_devices[i].type) {
+			senseid->cu_type = vm_devices[i].cu_type;
+			senseid->reserved = 0xff;
+			return 0;
+		}
+	}
 
-	return 0xffff;
+	return -ENODEV;
 }
 
 /**
- * diag_get_dev_info - retrieve device information via DIAG X'210'
- * @devno: device number
- * @ps: pointer to sense ID data area
+ * diag_get_dev_info - retrieve device information via diag 0x210
+ * @cdev: ccw device
  *
  * Returns zero on success, non-zero otherwise.
  */
-static int diag_get_dev_info(u16 devno, struct senseid *ps)
+static int diag210_get_dev_info(struct ccw_device *cdev)
 {
+	struct ccw_dev_id *dev_id = &cdev->private->dev_id;
+	struct senseid *senseid = &cdev->private->senseid;
 	struct diag210 diag_data;
-	int ccode;
-
-	CIO_TRACE_EVENT (4, "VMvdinf");
-
-	diag_data = (struct diag210) {
-		.vrdcdvno = devno,
-		.vrdclen = sizeof (diag_data),
-	};
-
-	ccode = diag210 (&diag_data);
-	if ((ccode == 0) || (ccode == 2)) {
-		ps->reserved = 0xff;
-
-		/* Special case for osa devices. */
-		if (diag_data.vrdcvcla == 0x02 && diag_data.vrdcvtyp == 0x20) {
-			ps->cu_type = 0x3088;
-			ps->cu_model = 0x60;
-			return 0;
-		}
-		ps->cu_type = vm_vdev_to_cu_type(diag_data.vrdcvcla,
-						diag_data.vrdcvtyp);
-		if (ps->cu_type != 0xffff)
-			return 0;
-	}
-
-	CIO_MSG_EVENT(0, "DIAG X'210' for device %04X returned (cc = %d):"
-		      "vdev class : %02X, vdev type : %04X \n ...  "
-		      "rdev class : %02X, rdev type : %04X, "
-		      "rdev model: %02X\n",
-		      devno, ccode,
-		      diag_data.vrdcvcla, diag_data.vrdcvtyp,
-		      diag_data.vrdcrccl, diag_data.vrdccrty,
-		      diag_data.vrdccrmd);
+	int rc;
 
+	if (dev_id->ssid != 0)
+		return -ENODEV;
+	memset(&diag_data, 0, sizeof(diag_data));
+	diag_data.vrdcdvno	= dev_id->devno;
+	diag_data.vrdclen	= sizeof(diag_data);
+	rc = diag210(&diag_data);
+	CIO_TRACE_EVENT(4, "diag210");
+	CIO_HEX_EVENT(4, &rc, sizeof(rc));
+	CIO_HEX_EVENT(4, &diag_data, sizeof(diag_data));
+	if (rc != 0 && rc != 2)
+		goto err_failed;
+	if (diag210_to_senseid(senseid, &diag_data))
+		goto err_unknown;
+	return 0;
+
+err_unknown:
+	CIO_MSG_EVENT(0, "snsid: device 0.%x.%04x: unknown diag210 data\n",
+		      dev_id->ssid, dev_id->devno);
+	return -ENODEV;
+err_failed:
+	CIO_MSG_EVENT(0, "snsid: device 0.%x.%04x: diag210 failed (rc=%d)\n",
+		      dev_id->ssid, dev_id->devno, rc);
 	return -ENODEV;
 }
 
 /*
- * Start Sense ID helper function.
- * Try to obtain the 'control unit'/'device type' information
- *  associated with the subchannel.
+ * Initialize SENSE ID data.
  */
-static int
-__ccw_device_sense_id_start(struct ccw_device *cdev)
-{
-	struct subchannel *sch;
-	struct ccw1 *ccw;
-	int ret;
-
-	sch = to_subchannel(cdev->dev.parent);
-	/* Setup sense channel program. */
-	ccw = cdev->private->iccws;
-	ccw->cmd_code = CCW_CMD_SENSE_ID;
-	ccw->cda = (__u32) __pa (&cdev->private->senseid);
-	ccw->count = sizeof (struct senseid);
-	ccw->flags = CCW_FLAG_SLI;
-
-	/* Reset device status. */
-	memset(&cdev->private->irb, 0, sizeof(struct irb));
-
-	/* Try on every path. */
-	ret = -ENODEV;
-	while (cdev->private->imask != 0) {
-		cdev->private->senseid.cu_type = 0xFFFF;
-		if ((sch->opm & cdev->private->imask) != 0 &&
-		    cdev->private->iretry > 0) {
-			cdev->private->iretry--;
-			/* Reset internal retry indication. */
-			cdev->private->flags.intretry = 0;
-			ret = cio_start (sch, cdev->private->iccws,
-					 cdev->private->imask);
-			/* ret is 0, -EBUSY, -EACCES or -ENODEV */
-			if (ret != -EACCES)
-				return ret;
-		}
-		cdev->private->imask >>= 1;
-		cdev->private->iretry = 5;
-	}
-	return ret;
-}
-
-void
-ccw_device_sense_id_start(struct ccw_device *cdev)
+static void snsid_init(struct ccw_device *cdev)
 {
-	int ret;
-
-	memset (&cdev->private->senseid, 0, sizeof (struct senseid));
-	cdev->private->imask = 0x80;
-	cdev->private->iretry = 5;
-	ret = __ccw_device_sense_id_start(cdev);
-	if (ret && ret != -EBUSY)
-		ccw_device_sense_id_done(cdev, ret);
+	cdev->private->flags.esid = 0;
+	memset(&cdev->private->senseid, 0, sizeof(cdev->private->senseid));
+	cdev->private->senseid.cu_type = 0xffff;
 }
 
 /*
- * Called from interrupt context to check if a valid answer
- * to Sense ID was received.
+ * Check for complete SENSE ID data.
  */
-static int
-ccw_device_check_sense_id(struct ccw_device *cdev)
+static int snsid_check(struct ccw_device *cdev, void *data)
 {
-	struct subchannel *sch;
-	struct irb *irb;
+	struct cmd_scsw *scsw = &cdev->private->irb.scsw.cmd;
+	int len = sizeof(struct senseid) - scsw->count;
 
-	sch = to_subchannel(cdev->dev.parent);
-	irb = &cdev->private->irb;
-
-	/* Check the error cases. */
-	if (irb->scsw.cmd.fctl & (SCSW_FCTL_HALT_FUNC | SCSW_FCTL_CLEAR_FUNC)) {
-		/* Retry Sense ID if requested. */
-		if (cdev->private->flags.intretry) {
-			cdev->private->flags.intretry = 0;
-			return -EAGAIN;
-		}
-		return -ETIME;
-	}
-	if (irb->esw.esw0.erw.cons && (irb->ecw[0] & SNS0_CMD_REJECT)) {
-		/*
-		 * if the device doesn't support the SenseID
-		 *  command further retries wouldn't help ...
-		 * NB: We don't check here for intervention required like we
-		 *     did before, because tape devices with no tape inserted
-		 *     may present this status *in conjunction with* the
-		 *     sense id information. So, for intervention required,
-		 *     we use the "whack it until it talks" strategy...
-		 */
-		CIO_MSG_EVENT(0, "SenseID : device %04x on Subchannel "
-			      "0.%x.%04x reports cmd reject\n",
-			      cdev->private->dev_id.devno, sch->schid.ssid,
-			      sch->schid.sch_no);
+	/* Check for incomplete SENSE ID data. */
+	if (len < SENSE_ID_MIN_LEN)
+		goto out_restart;
+	if (cdev->private->senseid.cu_type == 0xffff)
+		goto out_restart;
+	/* Check for incompatible SENSE ID data. */
+	if (cdev->private->senseid.reserved != 0xff)
 		return -EOPNOTSUPP;
-	}
-	if (irb->esw.esw0.erw.cons) {
-		CIO_MSG_EVENT(2, "SenseID : UC on dev 0.%x.%04x, "
-			      "lpum %02X, cnt %02d, sns :"
-			      " %02X%02X%02X%02X %02X%02X%02X%02X ...\n",
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
-		if ((lpm & sch->schib.pmcw.pim & sch->schib.pmcw.pam) != 0)
-			CIO_MSG_EVENT(4, "SenseID : path %02X for device %04x "
-				      "on subchannel 0.%x.%04x is "
-				      "'not operational'\n", lpm,
-				      cdev->private->dev_id.devno,
-				      sch->schid.ssid, sch->schid.sch_no);
-		return -EACCES;
-	}
-
-	/* Did we get a proper answer ? */
-	if (irb->scsw.cmd.cc == 0 && cdev->private->senseid.cu_type != 0xFFFF &&
-	    cdev->private->senseid.reserved == 0xFF) {
-		if (irb->scsw.cmd.count < sizeof(struct senseid) - 8)
-			cdev->private->flags.esid = 1;
-		return 0; /* Success */
-	}
+	/* Check for extended-identification information. */
+	if (len > SENSE_ID_BASIC_LEN)
+		cdev->private->flags.esid = 1;
+	return 0;
 
-	/* Hmm, whatever happened, try again. */
-	CIO_MSG_EVENT(2, "SenseID : start_IO() for device %04x on "
-		      "subchannel 0.%x.%04x returns status %02X%02X\n",
-		      cdev->private->dev_id.devno, sch->schid.ssid,
-		      sch->schid.sch_no,
-		      irb->scsw.cmd.dstat, irb->scsw.cmd.cstat);
+out_restart:
+	snsid_init(cdev);
 	return -EAGAIN;
 }
 
 /*
- * Got interrupt for Sense ID.
+ * Process SENSE ID request result.
  */
-void
-ccw_device_sense_id_irq(struct ccw_device *cdev, enum dev_event dev_event)
+static void snsid_callback(struct ccw_device *cdev, void *data, int rc)
 {
-	struct subchannel *sch;
-	struct irb *irb;
-	int ret;
-
-	sch = to_subchannel(cdev->dev.parent);
-	irb = (struct irb *) __LC_IRB;
-	/* Retry sense id, if needed. */
-	if (irb->scsw.cmd.stctl ==
-	    (SCSW_STCTL_STATUS_PEND | SCSW_STCTL_ALERT_STATUS)) {
-		if ((irb->scsw.cmd.cc == 1) || !irb->scsw.cmd.actl) {
-			ret = __ccw_device_sense_id_start(cdev);
-			if (ret && ret != -EBUSY)
-				ccw_device_sense_id_done(cdev, ret);
+	struct ccw_dev_id *id = &cdev->private->dev_id;
+	struct senseid *senseid = &cdev->private->senseid;
+	int vm = 0;
+
+	if (rc && MACHINE_IS_VM) {
+		/* Try diag 0x210 fallback on z/VM. */
+		snsid_init(cdev);
+		if (diag210_get_dev_info(cdev) == 0) {
+			rc = 0;
+			vm = 1;
 		}
-		return;
 	}
-	if (ccw_device_accumulate_and_sense(cdev, irb) != 0)
-		return;
-	ret = ccw_device_check_sense_id(cdev);
-	memset(&cdev->private->irb, 0, sizeof(struct irb));
-	switch (ret) {
-	/* 0, -ETIME, -EOPNOTSUPP, -EAGAIN or -EACCES */
-	case 0:			/* Sense id succeeded. */
-	case -ETIME:		/* Sense id stopped by timeout. */
-		ccw_device_sense_id_done(cdev, ret);
-		break;
-	case -EACCES:		/* channel is not operational. */
-		sch->lpm &= ~cdev->private->imask;
-		cdev->private->imask >>= 1;
-		cdev->private->iretry = 5;
-		/* fall through. */
-	case -EAGAIN:		/* try again. */
-		ret = __ccw_device_sense_id_start(cdev);
-		if (ret == 0 || ret == -EBUSY)
-			break;
-		/* fall through. */
-	default:		/* Sense ID failed. Try asking VM. */
-		if (MACHINE_IS_VM)
-			ret = diag_get_dev_info(cdev->private->dev_id.devno,
-						&cdev->private->senseid);
-		else
-			/*
-			 * If we can't couldn't identify the device type we
-			 *  consider the device "not operational".
-			 */
-			ret = -ENODEV;
+	CIO_MSG_EVENT(2, "snsid: device 0.%x.%04x: rc=%d %04x/%02x "
+		      "%04x/%02x%s\n", id->ssid, id->devno, rc,
+		      senseid->cu_type, senseid->cu_model, senseid->dev_type,
+		      senseid->dev_model, vm ? " (diag210)" : "");
+	ccw_device_sense_id_done(cdev, rc);
+}
 
-		ccw_device_sense_id_done(cdev, ret);
-		break;
-	}
+/**
+ * ccw_device_sense_id_start - perform SENSE ID
+ * @cdev: ccw device
+ *
+ * Execute a SENSE ID channel program on @cdev to update its sense id
+ * information. When finished, call ccw_device_sense_id_done with a
+ * return code specifying the result.
+ */
+void ccw_device_sense_id_start(struct ccw_device *cdev)
+{
+	struct subchannel *sch = to_subchannel(cdev->dev.parent);
+	struct ccw_request *req = &cdev->private->req;
+	struct ccw1 *cp = cdev->private->iccws;
+
+	CIO_TRACE_EVENT(4, "snsid");
+	CIO_HEX_EVENT(4, &cdev->private->dev_id, sizeof(cdev->private->dev_id));
+	/* Data setup. */
+	snsid_init(cdev);
+	/* Channel program setup. */
+	cp->cmd_code	= CCW_CMD_SENSE_ID;
+	cp->cda		= (u32) (addr_t) &cdev->private->senseid;
+	cp->count	= sizeof(struct senseid);
+	cp->flags	= CCW_FLAG_SLI;
+	/* Request setup. */
+	memset(req, 0, sizeof(*req));
+	req->cp		= cp;
+	req->timeout	= SENSE_ID_TIMEOUT;
+	req->maxretries	= SENSE_ID_RETRIES;
+	req->lpm	= sch->schib.pmcw.pam & sch->opm;
+	req->check	= snsid_check;
+	req->callback	= snsid_callback;
+	ccw_request_start(cdev);
 }
