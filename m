Return-Path: <linux-kernel-owner+w=401wt.eu-S1756838AbZKMPLj@vger.kernel.org>
Message-Id: <20091113150915.748645282@de.ibm.com>
Date: Fri, 13 Nov 2009 16:09:00 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 36/52] [PATCH] cio: consistent infrastructure for internal I/O requests
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=135-cio-internal-io.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Reduce code duplication by introducing a central infrastructure to
perform an internal I/O operation on a CCW device.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/Makefile |    2 
 drivers/s390/cio/ccwreq.c |  327 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/s390/cio/device.h |    8 +
 drivers/s390/cio/io_sch.h |   50 +++++++
 4 files changed, 386 insertions(+), 1 deletion(-)

Index: quilt-2.6/drivers/s390/cio/ccwreq.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ quilt-2.6/drivers/s390/cio/ccwreq.c	2009-11-13 16:08:19.000000000 +0100
@@ -0,0 +1,327 @@
+/*
+ *  Handling of internal CCW device requests.
+ *
+ *    Copyright IBM Corp. 2009
+ *    Author(s): Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
+ */
+
+#include <linux/types.h>
+#include <linux/err.h>
+#include <asm/ccwdev.h>
+#include <asm/cio.h>
+
+#include "io_sch.h"
+#include "cio.h"
+#include "device.h"
+#include "cio_debug.h"
+
+/**
+ * lpm_adjust - adjust path mask
+ * @lpm: path mask to adjust
+ * @mask: mask of available paths
+ *
+ * Shift @lpm right until @lpm and @mask have at least one bit in common or
+ * until @lpm is zero. Return the resulting lpm.
+ */
+int lpm_adjust(int lpm, int mask)
+{
+	while (lpm && ((lpm & mask) == 0))
+		lpm >>= 1;
+	return lpm;
+}
+
+/*
+ * Adjust path mask to use next path and reset retry count. Return resulting
+ * path mask.
+ */
+static u16 ccwreq_next_path(struct ccw_device *cdev)
+{
+	struct ccw_request *req = &cdev->private->req;
+
+	req->retries	= req->maxretries;
+	req->mask	= lpm_adjust(req->mask >>= 1, req->lpm);
+
+	return req->mask;
+}
+
+/*
+ * Clean up device state and report to callback.
+ */
+static void ccwreq_stop(struct ccw_device *cdev, int rc)
+{
+	struct subchannel *sch = to_subchannel(cdev->dev.parent);
+	struct ccw_request *req = &cdev->private->req;
+
+	if (req->done)
+		return;
+	req->done = 1;
+	ccw_device_set_timeout(cdev, 0);
+	memset(&cdev->private->irb, 0, sizeof(struct irb));
+	sch->lpm = sch->schib.pmcw.pam;
+	if (rc && rc != -ENODEV && req->drc)
+		rc = req->drc;
+	req->callback(cdev, req->data, rc);
+}
+
+/*
+ * (Re-)Start the operation until retries and paths are exhausted.
+ */
+static void ccwreq_do(struct ccw_device *cdev)
+{
+	struct ccw_request *req = &cdev->private->req;
+	struct subchannel *sch = to_subchannel(cdev->dev.parent);
+	struct ccw1 *cp = req->cp;
+	int rc = -EACCES;
+
+	while (req->mask) {
+		if (req->retries-- == 0) {
+			/* Retries exhausted, try next path. */
+			ccwreq_next_path(cdev);
+			continue;
+		}
+		/* Perform start function. */
+		sch->lpm = 0xff;
+		memset(&cdev->private->irb, 0, sizeof(struct irb));
+		rc = cio_start(sch, cp, req->mask);
+		if (rc == 0) {
+			/* I/O started successfully. */
+			ccw_device_set_timeout(cdev, req->timeout);
+			return;
+		}
+		if (rc == -ENODEV) {
+			/* Permanent device error. */
+			break;
+		}
+		if (rc == -EACCES) {
+			/* Permant path error. */
+			ccwreq_next_path(cdev);
+			continue;
+		}
+		/* Temporary improper status. */
+		rc = cio_clear(sch);
+		if (rc)
+			break;
+		return;
+	}
+	ccwreq_stop(cdev, rc);
+}
+
+/**
+ * ccw_request_start - perform I/O request
+ * @cdev: ccw device
+ *
+ * Perform the I/O request specified by cdev->req.
+ */
+void ccw_request_start(struct ccw_device *cdev)
+{
+	struct ccw_request *req = &cdev->private->req;
+
+	req->mask	= 0x80;
+	req->retries	= req->maxretries;
+	req->mask	= lpm_adjust(req->mask, req->lpm);
+	req->drc	= 0;
+	req->done	= 0;
+	req->cancel	= 0;
+	if (!req->mask)
+		goto out_nopath;
+	ccwreq_do(cdev);
+	return;
+
+out_nopath:
+	ccwreq_stop(cdev, -EACCES);
+}
+
+/**
+ * ccw_request_cancel - cancel running I/O request
+ * @cdev: ccw device
+ *
+ * Cancel the I/O request specified by cdev->req. Return non-zero if request
+ * has already finished, zero otherwise.
+ */
+int ccw_request_cancel(struct ccw_device *cdev)
+{
+	struct subchannel *sch = to_subchannel(cdev->dev.parent);
+	struct ccw_request *req = &cdev->private->req;
+	int rc;
+
+	if (req->done)
+		return 1;
+	req->cancel = 1;
+	rc = cio_clear(sch);
+	if (rc)
+		ccwreq_stop(cdev, rc);
+	return 0;
+}
+
+/*
+ * Return the status of the internal I/O started on the specified ccw device.
+ * Perform BASIC SENSE if required.
+ */
+static enum io_status ccwreq_status(struct ccw_device *cdev, struct irb *lcirb)
+{
+	struct irb *irb = &cdev->private->irb;
+	struct cmd_scsw *scsw = &irb->scsw.cmd;
+
+	/* Perform BASIC SENSE if needed. */
+	if (ccw_device_accumulate_and_sense(cdev, lcirb))
+		return IO_RUNNING;
+	/* Check for halt/clear interrupt. */
+	if (scsw->fctl & (SCSW_FCTL_HALT_FUNC | SCSW_FCTL_CLEAR_FUNC))
+		return IO_KILLED;
+	/* Check for path error. */
+	if (scsw->cc == 3 || scsw->pno)
+		return IO_PATH_ERROR;
+	/* Handle BASIC SENSE data. */
+	if (irb->esw.esw0.erw.cons) {
+		CIO_TRACE_EVENT(2, "sensedata");
+		CIO_HEX_EVENT(2, &cdev->private->dev_id,
+			      sizeof(struct ccw_dev_id));
+		CIO_HEX_EVENT(2, &cdev->private->irb.ecw, SENSE_MAX_COUNT);
+		/* Check for command reject. */
+		if (irb->ecw[0] & SNS0_CMD_REJECT)
+			return IO_REJECTED;
+		/* Assume that unexpected SENSE data implies an error. */
+		return IO_STATUS_ERROR;
+	}
+	/* Check for channel errors. */
+	if (scsw->cstat != 0)
+		return IO_STATUS_ERROR;
+	/* Check for device errors. */
+	if (scsw->dstat & ~(DEV_STAT_CHN_END | DEV_STAT_DEV_END))
+		return IO_STATUS_ERROR;
+	/* Check for final state. */
+	if (!(scsw->dstat & DEV_STAT_DEV_END))
+		return IO_RUNNING;
+	/* Check for other improper status. */
+	if (scsw->cc == 1 && (scsw->stctl & SCSW_STCTL_ALERT_STATUS))
+		return IO_STATUS_ERROR;
+	return IO_DONE;
+}
+
+/*
+ * Log ccw request status.
+ */
+static void ccwreq_log_status(struct ccw_device *cdev, enum io_status status)
+{
+	struct ccw_request *req = &cdev->private->req;
+	struct {
+		struct ccw_dev_id dev_id;
+		u16 retries;
+		u8 lpm;
+		u8 status;
+	}  __attribute__ ((packed)) data;
+	data.dev_id	= cdev->private->dev_id;
+	data.retries	= req->retries;
+	data.lpm	= req->mask;
+	data.status	= (u8) status;
+	CIO_TRACE_EVENT(2, "reqstat");
+	CIO_HEX_EVENT(2, &data, sizeof(data));
+}
+
+/**
+ * ccw_request_handler - interrupt handler for I/O request procedure.
+ * @cdev: ccw device
+ *
+ * Handle interrupt during I/O request procedure.
+ */
+void ccw_request_handler(struct ccw_device *cdev)
+{
+	struct ccw_request *req = &cdev->private->req;
+	struct irb *irb = (struct irb *) __LC_IRB;
+	enum io_status status;
+	int rc = -EOPNOTSUPP;
+
+	/* Check status of I/O request. */
+	status = ccwreq_status(cdev, irb);
+	if (req->filter)
+		status = req->filter(cdev, req->data, irb, status);
+	if (status != IO_RUNNING)
+		ccw_device_set_timeout(cdev, 0);
+	if (status != IO_DONE && status != IO_RUNNING)
+		ccwreq_log_status(cdev, status);
+	switch (status) {
+	case IO_DONE:
+		break;
+	case IO_RUNNING:
+		return;
+	case IO_REJECTED:
+		goto err;
+	case IO_PATH_ERROR:
+		goto out_next_path;
+	case IO_STATUS_ERROR:
+		goto out_restart;
+	case IO_KILLED:
+		/* Check if request was cancelled on purpose. */
+		if (req->cancel) {
+			rc = -EIO;
+			goto err;
+		}
+		goto out_restart;
+	}
+	/* Check back with request initiator. */
+	if (!req->check)
+		goto out;
+	switch (req->check(cdev, req->data)) {
+	case 0:
+		break;
+	case -EAGAIN:
+		goto out_restart;
+	case -EACCES:
+		goto out_next_path;
+	default:
+		goto err;
+	}
+out:
+	ccwreq_stop(cdev, 0);
+	return;
+
+out_next_path:
+	/* Try next path and restart I/O. */
+	if (!ccwreq_next_path(cdev)) {
+		rc = -EACCES;
+		goto err;
+	}
+out_restart:
+	/* Restart. */
+	ccwreq_do(cdev);
+	return;
+err:
+	ccwreq_stop(cdev, rc);
+}
+
+
+/**
+ * ccw_request_timeout - timeout handler for I/O request procedure
+ * @cdev: ccw device
+ *
+ * Handle timeout during I/O request procedure.
+ */
+void ccw_request_timeout(struct ccw_device *cdev)
+{
+	struct subchannel *sch = to_subchannel(cdev->dev.parent);
+	struct ccw_request *req = &cdev->private->req;
+	int rc;
+
+	if (!ccwreq_next_path(cdev)) {
+		/* set the final return code for this request */
+		req->drc = -ETIME;
+	}
+	rc = cio_clear(sch);
+	if (rc)
+		goto err;
+	return;
+
+err:
+	ccwreq_stop(cdev, rc);
+}
+
+/**
+ * ccw_request_notoper - notoper handler for I/O request procedure
+ * @cdev: ccw device
+ *
+ * Handle timeout during I/O request procedure.
+ */
+void ccw_request_notoper(struct ccw_device *cdev)
+{
+	ccwreq_stop(cdev, -ENODEV);
+}
Index: quilt-2.6/drivers/s390/cio/device.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.h	2009-11-13 16:08:18.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device.h	2009-11-13 16:08:20.000000000 +0100
@@ -98,6 +98,14 @@
 int ccw_device_accumulate_and_sense(struct ccw_device *, struct irb *);
 int ccw_device_do_sense(struct ccw_device *, struct irb *);
 
+/* Function prototype for internal request handling. */
+int lpm_adjust(int lpm, int mask);
+void ccw_request_start(struct ccw_device *);
+int ccw_request_cancel(struct ccw_device *cdev);
+void ccw_request_handler(struct ccw_device *cdev);
+void ccw_request_timeout(struct ccw_device *cdev);
+void ccw_request_notoper(struct ccw_device *cdev);
+
 /* Function prototypes for sense id stuff. */
 void ccw_device_sense_id_start(struct ccw_device *);
 void ccw_device_sense_id_irq(struct ccw_device *, enum dev_event);
Index: quilt-2.6/drivers/s390/cio/io_sch.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/io_sch.h	2009-11-13 16:08:18.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/io_sch.h	2009-11-13 16:08:20.000000000 +0100
@@ -1,7 +1,10 @@
 #ifndef S390_IO_SCH_H
 #define S390_IO_SCH_H
 
+#include <linux/types.h>
 #include <asm/schid.h>
+#include <asm/ccwdev.h>
+#include "css.h"
 
 /*
  * command-mode operation request block
@@ -68,6 +71,52 @@
 #define MAX_CIWS 8
 
 /*
+ * Possible status values for a CCW request's I/O.
+ */
+enum io_status {
+	IO_DONE,
+	IO_RUNNING,
+	IO_STATUS_ERROR,
+	IO_PATH_ERROR,
+	IO_REJECTED,
+	IO_KILLED
+};
+
+/**
+ * ccw_request - Internal CCW request.
+ * @cp: channel program to start
+ * @timeout: maximum allowable time in jiffies between start I/O and interrupt
+ * @maxretries: number of retries per I/O operation and path
+ * @lpm: mask of paths to use
+ * @check: optional callback that determines if results are final
+ * @filter: optional callback to adjust request status based on IRB data
+ * @callback: final callback
+ * @data: user-defined pointer passed to all callbacks
+ * @mask: current path mask
+ * @retries: current number of retries
+ * @drc: delayed return code
+ * @cancel: non-zero if request was cancelled
+ * @done: non-zero if request was finished
+ */
+struct ccw_request {
+	struct ccw1 *cp;
+	unsigned long timeout;
+	u16 maxretries;
+	u8 lpm;
+	int (*check)(struct ccw_device *, void *);
+	enum io_status (*filter)(struct ccw_device *, void *, struct irb *,
+				 enum io_status);
+	void (*callback)(struct ccw_device *, void *, int);
+	void *data;
+	/* These fields are used internally. */
+	u8 mask;
+	u16 retries;
+	int drc;
+	int cancel:1;
+	int done:1;
+} __attribute__((packed));
+
+/*
  * sense-id response buffer layout
  */
 struct senseid {
@@ -99,6 +148,7 @@
 	unsigned long registered;
 	struct ccw_dev_id dev_id;	/* device id */
 	struct subchannel_id schid;	/* subchannel number */
+	struct ccw_request req;		/* internal I/O request */
 	u8 imask;		/* lpm mask for SNID/SID/SPGID */
 	int iretry;		/* retry counter SNID/SID/SPGID */
 	struct {
Index: quilt-2.6/drivers/s390/cio/Makefile
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/Makefile	2009-11-13 15:48:33.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/Makefile	2009-11-13 16:08:20.000000000 +0100
@@ -3,7 +3,7 @@
 #
 
 obj-y += airq.o blacklist.o chsc.o cio.o css.o chp.o idset.o isc.o \
-	fcx.o itcw.o crw.o
+	fcx.o itcw.o crw.o ccwreq.o
 ccw_device-objs += device.o device_fsm.o device_ops.o
 ccw_device-objs += device_id.o device_pgid.o device_status.o
 obj-y += ccw_device.o cmf.o
