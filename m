Return-Path: <linux-kernel-owner+w=401wt.eu-S1756573AbZKMPK6@vger.kernel.org>
Message-Id: <20091113150916.765762750@de.ibm.com>
Date: Fri, 13 Nov 2009 16:09:06 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 42/52] [PATCH] cio: use sense-pgid operation for path verification
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=141-cio-path-verification.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Set-pgid operations fail for some device types under z/VM for which
the hypervisor has already set the pgid. Also reserved devices or
changed pgids are not correctly recognized. Fix these problems by
using a combination of sense-pgid and set-pgid and by also accepting
pre-defined pgid settings.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device.h      |    3 
 drivers/s390/cio/device_fsm.c  |   41 +----------
 drivers/s390/cio/device_pgid.c |  148 ++++++++++++++++++++++++++---------------
 drivers/s390/cio/io_sch.h      |    1 
 4 files changed, 99 insertions(+), 94 deletions(-)

Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c	2009-11-13 16:08:21.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device_fsm.c	2009-11-13 16:08:21.000000000 +0100
@@ -395,33 +395,6 @@
 }
 
 /*
- * Function called from device_pgid.c after sense path ground has completed.
- */
-void
-ccw_device_sense_pgid_done(struct ccw_device *cdev, int err)
-{
-	struct subchannel *sch;
-
-	sch = to_subchannel(cdev->dev.parent);
-	switch (err) {
-	case -EOPNOTSUPP: /* path grouping not supported, use nop instead. */
-	case 0: /* success */
-	case -EACCES: /* partial success, some paths not operational */
-		break;
-	case -ETIME:		/* Sense path group id stopped by timeout. */
-	case -EUSERS:		/* device is reserved for someone else. */
-		ccw_device_done(cdev, DEV_STATE_BOXED);
-		return;
-	default:
-		ccw_device_done(cdev, DEV_STATE_NOT_OPER);
-		return;
-	}
-	/* Start Path Group verification. */
-	cdev->private->state = DEV_STATE_VERIFY;
-	ccw_device_verify_start(cdev);
-}
-
-/*
  * Start device recognition.
  */
 void ccw_device_recognition(struct ccw_device *cdev)
@@ -503,6 +476,7 @@
 		}
 		break;
 	case -ETIME:
+	case -EUSERS:
 		/* Reset oper notify indication after verify error. */
 		cdev->private->flags.donotify = 0;
 		ccw_device_done(cdev, DEV_STATE_BOXED);
@@ -540,16 +514,9 @@
 			dev_fsm_event(cdev, DEV_EVENT_NOTOPER);
 		return ret;
 	}
-	/* Do we want to do path grouping? */
-	if (!cdev->private->options.pgroup) {
-		/* Start initial path verification. */
-		cdev->private->state = DEV_STATE_VERIFY;
-		ccw_device_verify_start(cdev);
-		return 0;
-	}
-	/* Do a SensePGID first. */
-	cdev->private->state = DEV_STATE_SENSE_PGID;
-	ccw_device_sense_pgid_start(cdev);
+	/* Start initial path verification. */
+	cdev->private->state = DEV_STATE_VERIFY;
+	ccw_device_verify_start(cdev);
 	return 0;
 }
 
Index: quilt-2.6/drivers/s390/cio/device.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.h	2009-11-13 16:08:20.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device.h	2009-11-13 16:08:21.000000000 +0100
@@ -110,9 +110,6 @@
 void ccw_device_sense_id_done(struct ccw_device *, int);
 
 /* Function prototypes for path grouping stuff. */
-void ccw_device_sense_pgid_start(struct ccw_device *);
-void ccw_device_sense_pgid_done(struct ccw_device *, int);
-
 void ccw_device_verify_start(struct ccw_device *);
 void ccw_device_verify_done(struct ccw_device *, int);
 
Index: quilt-2.6/drivers/s390/cio/device_pgid.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_pgid.c	2009-11-13 16:08:21.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device_pgid.c	2009-11-13 16:08:21.000000000 +0100
@@ -141,8 +141,8 @@
 	struct ccw_request *req = &cdev->private->req;
 	u8 fn;
 
-	/* Adjust lpm if paths are not set in pam. */
-	req->lpm = lpm_adjust(req->lpm, sch->schib.pmcw.pam);
+	/* Use next available path that is not already in correct state. */
+	req->lpm = lpm_adjust(req->lpm, sch->schib.pmcw.pam & ~sch->vpm);
 	if (!req->lpm)
 		goto out_nopath;
 	/* Channel program setup. */
@@ -199,6 +199,19 @@
 	verify_done(cdev, rc);
 }
 
+static void spid_start(struct ccw_device *cdev)
+{
+	struct ccw_request *req = &cdev->private->req;
+
+	/* Initialize request data. */
+	memset(req, 0, sizeof(*req));
+	req->timeout	= PGID_TIMEOUT;
+	req->maxretries	= PGID_RETRIES;
+	req->lpm	= 0x80;
+	req->callback	= spid_callback;
+	spid_do(cdev);
+}
+
 static int pgid_cmp(struct pgid *p1, struct pgid *p2)
 {
 	return memcmp((char *) p1 + 1, (char *) p2 + 1,
@@ -241,6 +254,40 @@
 	*p = first;
 }
 
+static u8 pgid_to_vpm(struct ccw_device *cdev)
+{
+	struct subchannel *sch = to_subchannel(cdev->dev.parent);
+	struct pgid *pgid;
+	int i;
+	int lpm;
+	u8 vpm = 0;
+
+	/* Set VPM bits for paths which are already in the target state. */
+	for (i = 0; i < 8; i++) {
+		lpm = 0x80 >> i;
+		if ((cdev->private->pgid_valid_mask & lpm) == 0)
+			continue;
+		pgid = &cdev->private->pgid[i];
+		if (sch->opm & lpm) {
+			if (pgid->inf.ps.state1 != SNID_STATE1_GROUPED)
+				continue;
+		} else {
+			if (pgid->inf.ps.state1 != SNID_STATE1_UNGROUPED)
+				continue;
+		}
+		if (cdev->private->flags.mpath) {
+			if (pgid->inf.ps.state3 != SNID_STATE3_MULTI_PATH)
+				continue;
+		} else {
+			if (pgid->inf.ps.state3 != SNID_STATE3_SINGLE_PATH)
+				continue;
+		}
+		vpm |= lpm;
+	}
+
+	return vpm;
+}
+
 static void pgid_fill(struct ccw_device *cdev, struct pgid *pgid)
 {
 	int i;
@@ -255,6 +302,7 @@
 static void snid_done(struct ccw_device *cdev, int rc)
 {
 	struct ccw_dev_id *id = &cdev->private->dev_id;
+	struct subchannel *sch = to_subchannel(cdev->dev.parent);
 	struct pgid *pgid;
 	int mismatch = 0;
 	int reserved = 0;
@@ -263,18 +311,38 @@
 	if (rc)
 		goto out;
 	pgid_analyze(cdev, &pgid, &mismatch, &reserved, &reset);
-	if (!mismatch) {
-		pgid_fill(cdev, pgid);
-		cdev->private->flags.pgid_rdy = 1;
-	}
 	if (reserved)
 		rc = -EUSERS;
+	else if (mismatch)
+		rc = -EOPNOTSUPP;
+	else {
+		sch->vpm = pgid_to_vpm(cdev);
+		pgid_fill(cdev, pgid);
+	}
 out:
-	CIO_MSG_EVENT(2, "snid: device 0.%x.%04x: rc=%d pvm=%02x mism=%d "
-		      "rsvd=%d reset=%d\n", id->ssid, id->devno, rc,
-		      cdev->private->pgid_valid_mask, mismatch, reserved,
-		      reset);
-	ccw_device_sense_pgid_done(cdev, rc);
+	CIO_MSG_EVENT(2, "snid: device 0.%x.%04x: rc=%d pvm=%02x vpm=%02x "
+		      "mism=%d rsvd=%d reset=%d\n", id->ssid, id->devno, rc,
+		      cdev->private->pgid_valid_mask, sch->vpm, mismatch,
+		      reserved, reset);
+	switch (rc) {
+	case 0:
+		/* Anything left to do? */
+		if (sch->vpm == sch->schib.pmcw.pam) {
+			verify_done(cdev, sch->vpm == 0 ? -EACCES : 0);
+			return;
+		}
+		/* Perform path-grouping. */
+		spid_start(cdev);
+		break;
+	case -EOPNOTSUPP:
+		/* Path-grouping not supported. */
+		cdev->private->flags.pgroup = 0;
+		cdev->private->flags.mpath = 0;
+		verify_start(cdev);
+		break;
+	default:
+		verify_done(cdev, rc);
+	}
 }
 
 /*
@@ -333,33 +401,6 @@
 	snid_done(cdev, rc);
 }
 
-/**
- * ccw_device_sense_pgid_start - perform SENSE PGID
- * @cdev: ccw device
- *
- * Execute a SENSE PGID channel program on each path to @cdev to update its
- * PGID information. When finished, call ccw_device_sense_id_done with a
- * return code specifying the result.
- */
-void ccw_device_sense_pgid_start(struct ccw_device *cdev)
-{
-	struct ccw_request *req = &cdev->private->req;
-
-	CIO_TRACE_EVENT(4, "snid");
-	CIO_HEX_EVENT(4, &cdev->private->dev_id, sizeof(cdev->private->dev_id));
-	/* Initialize PGID data. */
-	memset(cdev->private->pgid, 0, sizeof(cdev->private->pgid));
-	cdev->private->flags.pgid_rdy = 0;
-	cdev->private->pgid_valid_mask = 0;
-	/* Initialize request data. */
-	memset(req, 0, sizeof(*req));
-	req->timeout	= PGID_TIMEOUT;
-	req->maxretries	= PGID_RETRIES;
-	req->callback	= snid_callback;
-	req->lpm	= 0x80;
-	snid_do(cdev);
-}
-
 /*
  * Perform path verification.
  */
@@ -367,6 +408,7 @@
 {
 	struct subchannel *sch = to_subchannel(cdev->dev.parent);
 	struct ccw_request *req = &cdev->private->req;
+	struct ccw_dev_id *devid = &cdev->private->dev_id;
 
 	sch->vpm = 0;
 	/* Initialize request data. */
@@ -375,9 +417,13 @@
 	req->maxretries	= PGID_RETRIES;
 	req->lpm	= 0x80;
 	if (cdev->private->flags.pgroup) {
-		req->callback	= spid_callback;
-		spid_do(cdev);
+		CIO_TRACE_EVENT(4, "snid");
+		CIO_HEX_EVENT(4, devid, sizeof(*devid));
+		req->callback	= snid_callback;
+		snid_do(cdev);
 	} else {
+		CIO_TRACE_EVENT(4, "nop");
+		CIO_HEX_EVENT(4, devid, sizeof(*devid));
 		req->filter	= nop_filter;
 		req->callback	= nop_callback;
 		nop_do(cdev);
@@ -398,19 +444,15 @@
 {
 	CIO_TRACE_EVENT(4, "vrfy");
 	CIO_HEX_EVENT(4, &cdev->private->dev_id, sizeof(cdev->private->dev_id));
-	if (!cdev->private->flags.pgid_rdy) {
-		/* No pathgrouping possible. */
-		cdev->private->flags.pgroup = 0;
-		cdev->private->flags.mpath = 0;
-	} else {
-		/*
-		 * Initialize pathgroup and multipath state with target values.
-		 * They may change in the course of path verification.
-		 */
-		cdev->private->flags.pgroup = cdev->private->options.pgroup;
-		cdev->private->flags.mpath = cdev->private->options.mpath;
-
-	}
+	/* Initialize PGID data. */
+	memset(cdev->private->pgid, 0, sizeof(cdev->private->pgid));
+	cdev->private->pgid_valid_mask = 0;
+	/*
+	 * Initialize pathgroup and multipath state with target values.
+	 * They may change in the course of path verification.
+	 */
+	cdev->private->flags.pgroup = cdev->private->options.pgroup;
+	cdev->private->flags.mpath = cdev->private->options.mpath;
 	cdev->private->flags.doverify = 0;
 	verify_start(cdev);
 }
Index: quilt-2.6/drivers/s390/cio/io_sch.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/io_sch.h	2009-11-13 16:08:21.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/io_sch.h	2009-11-13 16:08:21.000000000 +0100
@@ -166,7 +166,6 @@
 		unsigned int recog_done:1;  /* dev. recog. complete */
 		unsigned int fake_irb:1;    /* deliver faked irb */
 		unsigned int resuming:1;    /* recognition while resume */
-		unsigned int pgid_rdy:1;    /* pgids are ready */
 		unsigned int pgroup:1;	    /* pathgroup is set up */
 		unsigned int mpath:1;	    /* multipathing is set up */
 	} __attribute__((packed)) flags;
