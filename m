Return-Path: <linux-kernel-owner+w=401wt.eu-S1757668AbYFCRIy@vger.kernel.org>
Message-Id: <20080603170518.363409480@de.ibm.com>
References: <20080603165859.107949986@de.ibm.com>
Date: Tue, 03 Jun 2008 18:59:00 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 01/14] cio: Register all subchannels.
Content-Disposition: inline; filename=100-cio-all-subchannels.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Register all valid subchannels, not only I/O subchannels.
Move I/O subchannel specific initialization to io_subchannel_probe().

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/chp.h    |    1 
 drivers/s390/cio/cio.c    |  124 ++++++++++++++++++----------------------------
 drivers/s390/cio/css.c    |   19 -------
 drivers/s390/cio/css.h    |    2 
 drivers/s390/cio/device.c |   38 ++++++++++++--
 5 files changed, 85 insertions(+), 99 deletions(-)

Index: quilt-2.6/drivers/s390/cio/chp.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chp.h
+++ quilt-2.6/drivers/s390/cio/chp.h
@@ -12,6 +12,7 @@
 #include <linux/device.h>
 #include <asm/chpid.h>
 #include "chsc.h"
+#include "css.h"
 
 #define CHP_STATUS_STANDBY		0
 #define CHP_STATUS_CONFIGURED		1
Index: quilt-2.6/drivers/s390/cio/cio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.c
+++ quilt-2.6/drivers/s390/cio/cio.c
@@ -2,7 +2,7 @@
  *  drivers/s390/cio/cio.c
  *   S/390 common I/O routines -- low level i/o calls
  *
- *    Copyright (C) IBM Corp. 1999,2006
+ *    Copyright IBM Corp. 1999,2008
  *    Author(s): Ingo Adlung (adlung@de.ibm.com)
  *		 Cornelia Huck (cornelia.huck@de.ibm.com)
  *		 Arnd Bergmann (arndb@de.ibm.com)
@@ -494,27 +494,46 @@ int cio_create_sch_lock(struct subchanne
 	return 0;
 }
 
-/*
- * cio_validate_subchannel()
+static int cio_validate_io_subchannel(struct subchannel *sch)
+{
+	/* Initialization for io subchannels. */
+	if (!css_sch_is_valid(&sch->schib))
+		return -ENODEV;
+
+	/* Devno is valid. */
+	if (is_blacklisted(sch->schid.ssid, sch->schib.pmcw.dev)) {
+		/*
+		 * This device must not be known to Linux. So we simply
+		 * say that there is no device and return ENODEV.
+		 */
+		CIO_MSG_EVENT(6, "Blacklisted device detected "
+			      "at devno %04X, subchannel set %x\n",
+			      sch->schib.pmcw.dev, sch->schid.ssid);
+		return -ENODEV;
+	}
+	return 0;
+}
+
+/**
+ * cio_validate_subchannel - basic validation of subchannel
+ * @sch: subchannel structure to be filled out
+ * @schid: subchannel id
  *
  * Find out subchannel type and initialize struct subchannel.
  * Return codes:
- *   SUBCHANNEL_TYPE_IO for a normal io subchannel
- *   SUBCHANNEL_TYPE_CHSC for a chsc subchannel
- *   SUBCHANNEL_TYPE_MESSAGE for a messaging subchannel
- *   SUBCHANNEL_TYPE_ADM for a adm(?) subchannel
+ *   0 on success
  *   -ENXIO for non-defined subchannels
- *   -ENODEV for subchannels with invalid device number or blacklisted devices
+ *   -ENODEV for invalid subchannels or blacklisted devices
+ *   -EIO for subchannels in an invalid subchannel set
  */
-int
-cio_validate_subchannel (struct subchannel *sch, struct subchannel_id schid)
+int cio_validate_subchannel(struct subchannel *sch, struct subchannel_id schid)
 {
 	char dbf_txt[15];
 	int ccode;
 	int err;
 
-	sprintf (dbf_txt, "valsch%x", schid.sch_no);
-	CIO_TRACE_EVENT (4, dbf_txt);
+	sprintf(dbf_txt, "valsch%x", schid.sch_no);
+	CIO_TRACE_EVENT(4, dbf_txt);
 
 	/* Nuke all fields. */
 	memset(sch, 0, sizeof(struct subchannel));
@@ -545,66 +564,18 @@ cio_validate_subchannel (struct subchann
 	}
 	/* Copy subchannel type from path management control word. */
 	sch->st = sch->schib.pmcw.st;
-
-	/*
-	 * ... just being curious we check for non I/O subchannels
-	 */
-	if (sch->st != 0) {
-		CIO_MSG_EVENT(4, "Subchannel 0.%x.%04x reports "
-			      "non-I/O subchannel type %04X\n",
-			      sch->schid.ssid, sch->schid.sch_no, sch->st);
-		/* We stop here for non-io subchannels. */
-		err = sch->st;
-		goto out;
-	}
-
-	/* Initialization for io subchannels. */
-	if (!css_sch_is_valid(&sch->schib)) {
-		err = -ENODEV;
-		goto out;
+	switch (sch->st) {
+	case SUBCHANNEL_TYPE_IO:
+		err = cio_validate_io_subchannel(sch);
+		break;
+	default:
+		err = 0;
 	}
-
-	/* Devno is valid. */
-	if (is_blacklisted (sch->schid.ssid, sch->schib.pmcw.dev)) {
-		/*
-		 * This device must not be known to Linux. So we simply
-		 * say that there is no device and return ENODEV.
-		 */
-		CIO_MSG_EVENT(6, "Blacklisted device detected "
-			      "at devno %04X, subchannel set %x\n",
-			      sch->schib.pmcw.dev, sch->schid.ssid);
-		err = -ENODEV;
+	if (err)
 		goto out;
-	}
-	if (cio_is_console(sch->schid))
-		sch->opm = 0xff;
-	else
-		sch->opm = chp_get_sch_opm(sch);
-	sch->lpm = sch->schib.pmcw.pam & sch->opm;
-	sch->isc = 3;
-
-	CIO_MSG_EVENT(6, "Detected device %04x on subchannel 0.%x.%04X "
-		      "- PIM = %02X, PAM = %02X, POM = %02X\n",
-		      sch->schib.pmcw.dev, sch->schid.ssid,
-		      sch->schid.sch_no, sch->schib.pmcw.pim,
-		      sch->schib.pmcw.pam, sch->schib.pmcw.pom);
 
-	/*
-	 * We now have to initially ...
-	 *  ... enable "concurrent sense"
-	 *  ... enable "multipath mode" if more than one
-	 *	  CHPID is available. This is done regardless
-	 *	  whether multiple paths are available for us.
-	 */
-	sch->schib.pmcw.csense = 1;	/* concurrent sense */
-	sch->schib.pmcw.ena = 0;
-	if ((sch->lpm & (sch->lpm - 1)) != 0)
-		sch->schib.pmcw.mp = 1;	/* multipath mode */
-	/* clean up possible residual cmf stuff */
-	sch->schib.pmcw.mme = 0;
-	sch->schib.pmcw.mbfc = 0;
-	sch->schib.pmcw.mbi = 0;
-	sch->schib.mba = 0;
+	CIO_MSG_EVENT(4, "Subchannel 0.%x.%04x reports subchannel type %04X\n",
+		      sch->schid.ssid, sch->schid.sch_no, sch->st);
 	return 0;
 out:
 	if (!cio_is_console(schid))
@@ -791,7 +762,6 @@ cio_probe_console(void)
 	 * enable console I/O-interrupt subclass 7
 	 */
 	ctl_set_bit(6, 24);
-	console_subchannel.isc = 7;
 	console_subchannel.schib.pmcw.isc = 7;
 	console_subchannel.schib.pmcw.intparm =
 		(u32)(addr_t)&console_subchannel;
@@ -862,7 +832,7 @@ static void udelay_reset(unsigned long u
 }
 
 static int
-__clear_subchannel_easy(struct subchannel_id schid)
+__clear_io_subchannel_easy(struct subchannel_id schid)
 {
 	int retry;
 
@@ -919,11 +889,19 @@ static int __shutdown_subchannel_easy(st
 	case -ENODEV:
 		break;
 	default: /* -EBUSY */
-		if (__clear_subchannel_easy(schid))
-			break; /* give up... */
+		switch (schib.pmcw.st) {
+		case SUBCHANNEL_TYPE_IO:
+			if (__clear_io_subchannel_easy(schid))
+				goto out; /* give up... */
+			break;
+		default:
+			/* No default clear strategy */
+			break;
+		}
 		stsch(schid, &schib);
 		__disable_subchannel_easy(schid, &schib);
 	}
+out:
 	return 0;
 }
 
Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c
+++ quilt-2.6/drivers/s390/cio/css.c
@@ -121,25 +121,6 @@ css_alloc_subchannel(struct subchannel_i
 		kfree(sch);
 		return ERR_PTR(ret);
 	}
-
-	if (sch->st != SUBCHANNEL_TYPE_IO) {
-		/* For now we ignore all non-io subchannels. */
-		kfree(sch);
-		return ERR_PTR(-EINVAL);
-	}
-
-	/* 
-	 * Set intparm to subchannel address.
-	 * This is fine even on 64bit since the subchannel is always located
-	 * under 2G.
-	 */
-	sch->schib.pmcw.intparm = (u32)(addr_t)sch;
-	ret = cio_modify(sch);
-	if (ret) {
-		kfree(sch->lock);
-		kfree(sch);
-		return ERR_PTR(ret);
-	}
 	return sch;
 }
 
Index: quilt-2.6/drivers/s390/cio/css.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.h
+++ quilt-2.6/drivers/s390/cio/css.h
@@ -60,8 +60,6 @@ struct pgid {
 
 /*
  * A css driver handles all subchannels of one type.
- * Currently, we only care about I/O subchannels (type 0), these
- * have a ccw_device connected to them.
  */
 struct subchannel;
 struct css_driver {
Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c
+++ quilt-2.6/drivers/s390/cio/device.c
@@ -24,6 +24,7 @@
 #include <asm/param.h>		/* HZ */
 #include <asm/cmb.h>
 
+#include "chp.h"
 #include "cio.h"
 #include "cio_debug.h"
 #include "css.h"
@@ -1037,7 +1038,6 @@ io_subchannel_recog(struct ccw_device *c
 	struct ccw_device_private *priv;
 
 	sch_set_cdev(sch, cdev);
-	sch->driver = &io_subchannel_driver;
 	cdev->ccwlock = sch->lock;
 
 	/* Init private data. */
@@ -1122,8 +1122,33 @@ static void io_subchannel_irq(struct sub
 		dev_fsm_event(cdev, DEV_EVENT_INTERRUPT);
 }
 
-static int
-io_subchannel_probe (struct subchannel *sch)
+static void io_subchannel_init_fields(struct subchannel *sch)
+{
+	if (cio_is_console(sch->schid))
+		sch->opm = 0xff;
+	else
+		sch->opm = chp_get_sch_opm(sch);
+	sch->lpm = sch->schib.pmcw.pam & sch->opm;
+	sch->isc = cio_is_console(sch->schid) ? 7 : 3;
+
+	CIO_MSG_EVENT(6, "Detected device %04x on subchannel 0.%x.%04X"
+		      " - PIM = %02X, PAM = %02X, POM = %02X\n",
+		      sch->schib.pmcw.dev, sch->schid.ssid,
+		      sch->schid.sch_no, sch->schib.pmcw.pim,
+		      sch->schib.pmcw.pam, sch->schib.pmcw.pom);
+	/* Initially set up some fields in the pmcw. */
+	sch->schib.pmcw.ena = 0;
+	sch->schib.pmcw.csense = 1;	/* concurrent sense */
+	if ((sch->lpm & (sch->lpm - 1)) != 0)
+		sch->schib.pmcw.mp = 1; /* multipath mode */
+	/* clean up possible residual cmf stuff */
+	sch->schib.pmcw.mme = 0;
+	sch->schib.pmcw.mbfc = 0;
+	sch->schib.pmcw.mbi = 0;
+	sch->schib.mba = 0;
+}
+
+static int io_subchannel_probe(struct subchannel *sch)
 {
 	struct ccw_device *cdev;
 	int rc;
@@ -1152,6 +1177,7 @@ io_subchannel_probe (struct subchannel *
 			get_device(&cdev->dev);
 		return 0;
 	}
+	io_subchannel_init_fields(sch);
 	/*
 	 * First check if a fitting device may be found amongst the
 	 * disconnected devices or in the orphanage.
@@ -1297,14 +1323,16 @@ spinlock_t * cio_get_console_lock(void)
 	return &ccw_console_lock;
 }
 
-static int
-ccw_device_console_enable (struct ccw_device *cdev, struct subchannel *sch)
+static int ccw_device_console_enable(struct ccw_device *cdev,
+				     struct subchannel *sch)
 {
 	int rc;
 
 	/* Attach subchannel private data. */
 	sch->private = cio_get_console_priv();
 	memset(sch->private, 0, sizeof(struct io_subchannel_private));
+	io_subchannel_init_fields(sch);
+	sch->driver = &io_subchannel_driver;
 	/* Initialize the ccw_device structure. */
 	cdev->dev.parent= &sch->dev;
 	rc = io_subchannel_recog(cdev, sch);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
