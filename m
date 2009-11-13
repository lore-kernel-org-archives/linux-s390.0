Return-Path: <linux-kernel-owner+w=401wt.eu-S1756494AbZKMPKg@vger.kernel.org>
Message-Id: <20091113150916.574416935@de.ibm.com>
Date: Fri, 13 Nov 2009 16:09:05 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 41/52] [PATCH] cio: split PGID settings and status
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=140-cio-split-pgid.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Split setting (driver wants feature enabled) and status (feature
setup was successful) for PGID related ccw device features so that
setup errors can be detected. Previously, incorrectly handled setup
errors could in rare cases lead to erratic I/O behavior and
permanently unusuable devices.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/ccwdev.h |    4 ++++
 drivers/s390/block/dasd.c      |    7 -------
 drivers/s390/block/dasd_eckd.c |   12 +++++++++++-
 drivers/s390/char/tape_core.c  |    3 ++-
 drivers/s390/cio/device_fsm.c  |    2 +-
 drivers/s390/cio/device_ops.c  |   27 +++++++++++++++++++++++++++
 drivers/s390/cio/device_pgid.c |   33 ++++++++++++++++++++-------------
 drivers/s390/cio/io_sch.h      |    4 +++-
 8 files changed, 68 insertions(+), 24 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/ccwdev.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/ccwdev.h	2009-11-13 15:48:32.000000000 +0100
+++ quilt-2.6/arch/s390/include/asm/ccwdev.h	2009-11-13 16:08:21.000000000 +0100
@@ -142,6 +142,8 @@
 extern int ccw_device_set_options_mask(struct ccw_device *, unsigned long);
 extern int ccw_device_set_options(struct ccw_device *, unsigned long);
 extern void ccw_device_clear_options(struct ccw_device *, unsigned long);
+int ccw_device_is_pathgroup(struct ccw_device *cdev);
+int ccw_device_is_multipath(struct ccw_device *cdev);
 
 /* Allow for i/o completion notification after primary interrupt status. */
 #define CCWDEV_EARLY_NOTIFICATION	0x0001
@@ -151,6 +153,8 @@
 #define CCWDEV_DO_PATHGROUP             0x0004
 /* Allow forced onlining of boxed devices. */
 #define CCWDEV_ALLOW_FORCE              0x0008
+/* Try to use multipath mode. */
+#define CCWDEV_DO_MULTIPATH		0x0010
 
 extern int ccw_device_start(struct ccw_device *, struct ccw1 *,
 			    unsigned long, __u8, unsigned long);
Index: quilt-2.6/drivers/s390/block/dasd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd.c	2009-11-13 16:08:17.000000000 +0100
+++ quilt-2.6/drivers/s390/block/dasd.c	2009-11-13 16:08:21.000000000 +0100
@@ -2301,13 +2301,6 @@
 {
 	int ret;
 
-	ret = ccw_device_set_options(cdev, CCWDEV_DO_PATHGROUP);
-	if (ret) {
-		DBF_EVENT(DBF_WARNING,
-		       "dasd_generic_probe: could not set ccw-device options "
-		       "for %s\n", dev_name(&cdev->dev));
-		return ret;
-	}
 	ret = dasd_add_sysfs_files(cdev);
 	if (ret) {
 		DBF_EVENT_DEVID(DBF_WARNING, cdev, "%s",
Index: quilt-2.6/drivers/s390/block/dasd_eckd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_eckd.c	2009-11-13 16:08:17.000000000 +0100
+++ quilt-2.6/drivers/s390/block/dasd_eckd.c	2009-11-13 16:08:21.000000000 +0100
@@ -90,7 +90,8 @@
 	int ret;
 
 	/* set ECKD specific ccw-device options */
-	ret = ccw_device_set_options(cdev, CCWDEV_ALLOW_FORCE);
+	ret = ccw_device_set_options(cdev, CCWDEV_ALLOW_FORCE |
+				     CCWDEV_DO_PATHGROUP | CCWDEV_DO_MULTIPATH);
 	if (ret) {
 		DBF_EVENT_DEVID(DBF_WARNING, cdev, "%s",
 				"dasd_eckd_probe: could not set "
@@ -1090,6 +1091,15 @@
 	struct dasd_block *block;
 	int is_known, rc;
 
+	if (!ccw_device_is_pathgroup(device->cdev)) {
+		dev_warn(&device->cdev->dev,
+			 "A channel path group could not be established\n");
+		return -EIO;
+	}
+	if (!ccw_device_is_multipath(device->cdev)) {
+		dev_info(&device->cdev->dev,
+			 "The DASD is not operating in multipath mode\n");
+	}
 	private = (struct dasd_eckd_private *) device->private;
 	if (!private) {
 		private = kzalloc(sizeof(*private), GFP_KERNEL | GFP_DMA);
Index: quilt-2.6/drivers/s390/char/tape_core.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/tape_core.c	2009-11-13 15:48:33.000000000 +0100
+++ quilt-2.6/drivers/s390/char/tape_core.c	2009-11-13 16:08:21.000000000 +0100
@@ -579,7 +579,8 @@
 	device = tape_alloc_device();
 	if (IS_ERR(device))
 		return -ENODEV;
-	ccw_device_set_options(cdev, CCWDEV_DO_PATHGROUP);
+	ccw_device_set_options(cdev, CCWDEV_DO_PATHGROUP |
+				     CCWDEV_DO_MULTIPATH);
 	ret = sysfs_create_group(&cdev->dev.kobj, &tape_attr_group);
 	if (ret) {
 		tape_put_device(device);
Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c	2009-11-13 16:08:20.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device_fsm.c	2009-11-13 16:08:21.000000000 +0100
@@ -601,7 +601,7 @@
 	if (cdev->private->state != DEV_STATE_ONLINE)
 		return -EINVAL;
 	/* Are we doing path grouping? */
-	if (!cdev->private->options.pgroup) {
+	if (!cdev->private->flags.pgroup) {
 		/* No, set state offline immediately. */
 		ccw_device_done(cdev, DEV_STATE_OFFLINE);
 		return 0;
Index: quilt-2.6/drivers/s390/cio/device_ops.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_ops.c	2009-11-13 16:08:20.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device_ops.c	2009-11-13 16:08:21.000000000 +0100
@@ -46,6 +46,7 @@
 	cdev->private->options.repall = (flags & CCWDEV_REPORT_ALL) != 0;
 	cdev->private->options.pgroup = (flags & CCWDEV_DO_PATHGROUP) != 0;
 	cdev->private->options.force = (flags & CCWDEV_ALLOW_FORCE) != 0;
+	cdev->private->options.mpath = (flags & CCWDEV_DO_MULTIPATH) != 0;
 	return 0;
 }
 
@@ -74,6 +75,7 @@
 	cdev->private->options.repall |= (flags & CCWDEV_REPORT_ALL) != 0;
 	cdev->private->options.pgroup |= (flags & CCWDEV_DO_PATHGROUP) != 0;
 	cdev->private->options.force |= (flags & CCWDEV_ALLOW_FORCE) != 0;
+	cdev->private->options.mpath |= (flags & CCWDEV_DO_MULTIPATH) != 0;
 	return 0;
 }
 
@@ -90,9 +92,34 @@
 	cdev->private->options.repall &= (flags & CCWDEV_REPORT_ALL) == 0;
 	cdev->private->options.pgroup &= (flags & CCWDEV_DO_PATHGROUP) == 0;
 	cdev->private->options.force &= (flags & CCWDEV_ALLOW_FORCE) == 0;
+	cdev->private->options.mpath &= (flags & CCWDEV_DO_MULTIPATH) == 0;
 }
 
 /**
+ * ccw_device_is_pathgroup - determine if paths to this device are grouped
+ * @cdev: ccw device
+ *
+ * Return non-zero if there is a path group, zero otherwise.
+ */
+int ccw_device_is_pathgroup(struct ccw_device *cdev)
+{
+	return cdev->private->flags.pgroup;
+}
+EXPORT_SYMBOL(ccw_device_is_pathgroup);
+
+/**
+ * ccw_device_is_multipath - determine if device is operating in multipath mode
+ * @cdev: ccw device
+ *
+ * Return non-zero if device is operating in multipath mode, zero otherwise.
+ */
+int ccw_device_is_multipath(struct ccw_device *cdev)
+{
+	return cdev->private->flags.mpath;
+}
+EXPORT_SYMBOL(ccw_device_is_multipath);
+
+/**
  * ccw_device_clear() - terminate I/O request processing
  * @cdev: target ccw device
  * @intparm: interruption parameter; value is only used if no I/O is
Index: quilt-2.6/drivers/s390/cio/device_pgid.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_pgid.c	2009-11-13 16:08:20.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device_pgid.c	2009-11-13 16:08:21.000000000 +0100
@@ -30,8 +30,8 @@
 {
 	struct subchannel *sch = to_subchannel(cdev->dev.parent);
 	struct ccw_dev_id *id = &cdev->private->dev_id;
-	int mpath = !cdev->private->flags.pgid_single;
-	int pgroup = cdev->private->options.pgroup;
+	int mpath = cdev->private->flags.mpath;
+	int pgroup = cdev->private->flags.pgroup;
 
 	if (rc)
 		goto out;
@@ -150,7 +150,7 @@
 		fn = SPID_FUNC_ESTABLISH;
 	else
 		fn = SPID_FUNC_RESIGN;
-	if (!cdev->private->flags.pgid_single)
+	if (cdev->private->flags.mpath)
 		fn |= SPID_FUNC_MULTI_PATH;
 	spid_build_cp(cdev, fn);
 	ccw_request_start(cdev);
@@ -177,13 +177,13 @@
 	case -EACCES:
 		break;
 	case -EOPNOTSUPP:
-		if (!cdev->private->flags.pgid_single) {
+		if (cdev->private->flags.mpath) {
 			/* Try without multipathing. */
-			cdev->private->flags.pgid_single = 1;
+			cdev->private->flags.mpath = 0;
 			goto out_restart;
 		}
 		/* Try without pathgrouping. */
-		cdev->private->options.pgroup = 0;
+		cdev->private->flags.pgroup = 0;
 		goto out_restart;
 	default:
 		goto err;
@@ -374,7 +374,7 @@
 	req->timeout	= PGID_TIMEOUT;
 	req->maxretries	= PGID_RETRIES;
 	req->lpm	= 0x80;
-	if (cdev->private->options.pgroup) {
+	if (cdev->private->flags.pgroup) {
 		req->callback	= spid_callback;
 		spid_do(cdev);
 	} else {
@@ -400,10 +400,17 @@
 	CIO_HEX_EVENT(4, &cdev->private->dev_id, sizeof(cdev->private->dev_id));
 	if (!cdev->private->flags.pgid_rdy) {
 		/* No pathgrouping possible. */
-		cdev->private->options.pgroup = 0;
-		cdev->private->flags.pgid_single = 1;
-	} else
-		cdev->private->flags.pgid_single = 0;
+		cdev->private->flags.pgroup = 0;
+		cdev->private->flags.mpath = 0;
+	} else {
+		/*
+		 * Initialize pathgroup and multipath state with target values.
+		 * They may change in the course of path verification.
+		 */
+		cdev->private->flags.pgroup = cdev->private->options.pgroup;
+		cdev->private->flags.mpath = cdev->private->options.mpath;
+
+	}
 	cdev->private->flags.doverify = 0;
 	verify_start(cdev);
 }
@@ -419,7 +426,7 @@
 	if (rc)
 		goto out;
 	/* Ensure consistent multipathing state at device and channel. */
-	cdev->private->flags.pgid_single = 1;
+	cdev->private->flags.mpath = 0;
 	if (sch->config.mp) {
 		sch->config.mp = 0;
 		rc = cio_commit_config(sch);
@@ -453,7 +460,7 @@
 	req->lpm	= sch->schib.pmcw.pam & sch->opm;
 	req->callback	= disband_callback;
 	fn = SPID_FUNC_DISBAND;
-	if (!cdev->private->flags.pgid_single)
+	if (cdev->private->flags.mpath)
 		fn |= SPID_FUNC_MULTI_PATH;
 	spid_build_cp(cdev, fn);
 	ccw_request_start(cdev);
Index: quilt-2.6/drivers/s390/cio/io_sch.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/io_sch.h	2009-11-13 16:08:20.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/io_sch.h	2009-11-13 16:08:21.000000000 +0100
@@ -156,9 +156,9 @@
 		unsigned int repall:1;	/* report every interrupt status */
 		unsigned int pgroup:1;	/* do path grouping */
 		unsigned int force:1;	/* allow forced online */
+		unsigned int mpath:1;	/* do multipathing */
 	} __attribute__ ((packed)) options;
 	struct {
-		unsigned int pgid_single:1; /* use single path for Set PGID */
 		unsigned int esid:1;	    /* Ext. SenseID supported by HW */
 		unsigned int dosense:1;	    /* delayed SENSE required */
 		unsigned int doverify:1;    /* delayed path verification */
@@ -167,6 +167,8 @@
 		unsigned int fake_irb:1;    /* deliver faked irb */
 		unsigned int resuming:1;    /* recognition while resume */
 		unsigned int pgid_rdy:1;    /* pgids are ready */
+		unsigned int pgroup:1;	    /* pathgroup is set up */
+		unsigned int mpath:1;	    /* multipathing is set up */
 	} __attribute__((packed)) flags;
 	unsigned long intparm;	/* user interruption parameter */
 	struct qdio_irq *qdio_data;
