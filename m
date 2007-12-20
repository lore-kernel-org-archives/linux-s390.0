Return-Path: <linux-kernel-owner+w=401wt.eu-S965178AbXLTP0r@vger.kernel.org>
Message-Id: <20071220152105.138785512@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:19:35 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 10/47] cio: I/O subchannel specific fields.
Content-Disposition: inline; filename=109-cio-fields.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Some fields may be !0 only for I/O subchannels. Add some checks
where required. Also adapt cio_enable_subchannel() to make the
caller specify the intparm, which makes it more generic.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/chsc.c       |    5 +++--
 drivers/s390/cio/cio.c        |   24 ++++++++++++------------
 drivers/s390/cio/cio.h        |    4 ++--
 drivers/s390/cio/css.c        |   18 ++++++++++++++++--
 drivers/s390/cio/css.h        |    2 ++
 drivers/s390/cio/device_fsm.c |    9 ++++++---
 drivers/s390/cio/device_ops.c |    2 +-
 7 files changed, 42 insertions(+), 22 deletions(-)

Index: quilt-2.6/drivers/s390/cio/chsc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chsc.c
+++ quilt-2.6/drivers/s390/cio/chsc.c
@@ -89,7 +89,8 @@ int chsc_get_ssd_info(struct subchannel_
 	/* Copy data */
 	ret = 0;
 	memset(ssd, 0, sizeof(struct chsc_ssd_info));
-	if ((ssd_area->st != 0) && (ssd_area->st != 2))
+	if ((ssd_area->st != SUBCHANNEL_TYPE_IO) &&
+	    (ssd_area->st != SUBCHANNEL_TYPE_MSG))
 		goto out_free;
 	ssd->path_mask = ssd_area->path_mask;
 	ssd->fla_valid_mask = ssd_area->fla_valid_mask;
@@ -158,7 +159,7 @@ s390_subchannel_remove_chpid(struct devi
 	spin_lock_irq(sch->lock);
 
 	stsch(sch->schid, &schib);
-	if (!schib.pmcw.dnv)
+	if (!css_sch_is_valid(&schib))
 		goto out_unreg;
 	memcpy(&sch->schib, &schib, sizeof(struct schib));
 	/* Check for single path devices. */
Index: quilt-2.6/drivers/s390/cio/cio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.c
+++ quilt-2.6/drivers/s390/cio/cio.c
@@ -406,8 +406,8 @@ cio_modify (struct subchannel *sch)
 /*
  * Enable subchannel.
  */
-int
-cio_enable_subchannel (struct subchannel *sch, unsigned int isc)
+int cio_enable_subchannel(struct subchannel *sch, unsigned int isc,
+			  u32 intparm)
 {
 	char dbf_txt[15];
 	int ccode;
@@ -426,7 +426,7 @@ cio_enable_subchannel (struct subchannel
 	for (retry = 5, ret = 0; retry > 0; retry--) {
 		sch->schib.pmcw.ena = 1;
 		sch->schib.pmcw.isc = isc;
-		sch->schib.pmcw.intparm = (u32)(addr_t)sch;
+		sch->schib.pmcw.intparm = intparm;
 		ret = cio_modify(sch);
 		if (ret == -ENODEV)
 			break;
@@ -577,11 +577,8 @@ cio_validate_subchannel (struct subchann
 	}
 
 	/* Initialization for io subchannels. */
-	if (!sch->schib.pmcw.dnv) {
-		/* io subchannel but device number is invalid. */
-		err = -ENODEV;
-		goto out;
-	}
+	if (!css_sch_is_valid(&sch->schib))
+		return -ENODEV;
 	/* Devno is valid. */
 	if (is_blacklisted (sch->schid.ssid, sch->schib.pmcw.dev)) {
 		/*
@@ -745,9 +742,9 @@ cio_test_for_console(struct subchannel_i
 {
 	if (stsch_err(schid, &console_subchannel.schib) != 0)
 		return -ENXIO;
-	if (console_subchannel.schib.pmcw.dnv &&
-	    console_subchannel.schib.pmcw.dev ==
-	    console_devno) {
+	if ((console_subchannel.schib.pmcw.st == SUBCHANNEL_TYPE_IO) &&
+	    console_subchannel.schib.pmcw.dnv &&
+	    (console_subchannel.schib.pmcw.dev == console_devno)) {
 		console_irq = schid.sch_no;
 		return 1; /* found */
 	}
@@ -765,6 +762,7 @@ cio_get_console_sch_no(void)
 		/* VM provided us with the irq number of the console. */
 		schid.sch_no = console_irq;
 		if (stsch(schid, &console_subchannel.schib) != 0 ||
+		    (console_subchannel.schib.pmcw.st != SUBCHANNEL_TYPE_IO) ||
 		    !console_subchannel.schib.pmcw.dnv)
 			return -1;
 		console_devno = console_subchannel.schib.pmcw.dev;
@@ -1029,7 +1027,7 @@ static int __reipl_subchannel_match(stru
 
 	if (stsch_reset(schid, &schib))
 		return -ENXIO;
-	if (schib.pmcw.dnv &&
+	if ((schib.pmcw.st == SUBCHANNEL_TYPE_IO) && schib.pmcw.dnv &&
 	    (schib.pmcw.dev == match_id->devid.devno) &&
 	    (schid.ssid == match_id->devid.ssid)) {
 		match_id->schid = schid;
@@ -1075,6 +1073,8 @@ int __init cio_get_iplinfo(struct cio_ip
 		return -ENODEV;
 	if (stsch(schid, &schib))
 		return -ENODEV;
+	if (schib.pmcw.st != SUBCHANNEL_TYPE_IO)
+		return -ENODEV;
 	if (!schib.pmcw.dnv)
 		return -ENODEV;
 	iplinfo->devno = schib.pmcw.dev;
Index: quilt-2.6/drivers/s390/cio/cio.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.h
+++ quilt-2.6/drivers/s390/cio/cio.h
@@ -60,7 +60,7 @@ struct subchannel {
 	enum {
 		SUBCHANNEL_TYPE_IO = 0,
 		SUBCHANNEL_TYPE_CHSC = 1,
-		SUBCHANNEL_TYPE_MESSAGE = 2,
+		SUBCHANNEL_TYPE_MSG = 2,
 		SUBCHANNEL_TYPE_ADM = 3,
 	} st;			/* subchannel type */
 
@@ -85,7 +85,7 @@ struct subchannel {
 #define to_subchannel(n) container_of(n, struct subchannel, dev)
 
 extern int cio_validate_subchannel (struct subchannel *, struct subchannel_id);
-extern int cio_enable_subchannel (struct subchannel *, unsigned int);
+extern int cio_enable_subchannel(struct subchannel *, unsigned int, u32);
 extern int cio_disable_subchannel (struct subchannel *);
 extern int cio_cancel (struct subchannel *);
 extern int cio_clear (struct subchannel *);
Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c
+++ quilt-2.6/drivers/s390/cio/css.c
@@ -237,11 +237,25 @@ get_subchannel_by_schid(struct subchanne
 	return dev ? to_subchannel(dev) : NULL;
 }
 
+/**
+ * css_sch_is_valid() - check if a subchannel is valid
+ * @schib: subchannel information block for the subchannel
+ */
+int css_sch_is_valid(struct schib *schib)
+{
+	if ((schib->pmcw.st == SUBCHANNEL_TYPE_IO) && !schib->pmcw.dnv)
+		return 0;
+	return 1;
+}
+EXPORT_SYMBOL_GPL(css_sch_is_valid);
+
 static int css_get_subchannel_status(struct subchannel *sch)
 {
 	struct schib schib;
 
-	if (stsch(sch->schid, &schib) || !schib.pmcw.dnv)
+	if (stsch(sch->schid, &schib))
+		return CIO_GONE;
+	if (!css_sch_is_valid(&schib))
 		return CIO_GONE;
 	if (sch->schib.pmcw.dnv && (schib.pmcw.dev != sch->schib.pmcw.dev))
 		return CIO_REVALIDATE;
@@ -349,7 +363,7 @@ static int css_evaluate_new_subchannel(s
 		/* Will be done on the slow path. */
 		return -EAGAIN;
 	}
-	if (stsch_err(schid, &schib) || !schib.pmcw.dnv) {
+	if (stsch_err(schid, &schib) || !css_sch_is_valid(&schib)) {
 		/* Unusable - ignore. */
 		return 0;
 	}
Index: quilt-2.6/drivers/s390/cio/css.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.h
+++ quilt-2.6/drivers/s390/cio/css.h
@@ -136,6 +136,8 @@ void css_schedule_eval(struct subchannel
 void css_schedule_eval_all(void);
 
 int sch_is_pseudo_sch(struct subchannel *);
+struct schib;
+int css_sch_is_valid(struct schib *);
 
 extern struct workqueue_struct *slow_path_wq;
 
Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c
+++ quilt-2.6/drivers/s390/cio/device_fsm.c
@@ -553,7 +553,8 @@ ccw_device_recognition(struct ccw_device
 	    (cdev->private->state != DEV_STATE_BOXED))
 		return -EINVAL;
 	sch = to_subchannel(cdev->dev.parent);
-	ret = cio_enable_subchannel(sch, sch->schib.pmcw.isc);
+	ret = cio_enable_subchannel(sch, sch->schib.pmcw.isc,
+				    (u32)(addr_t)sch);
 	if (ret != 0)
 		/* Couldn't enable the subchannel for i/o. Sick device. */
 		return ret;
@@ -663,7 +664,8 @@ ccw_device_online(struct ccw_device *cde
 	sch = to_subchannel(cdev->dev.parent);
 	if (css_init_done && !get_device(&cdev->dev))
 		return -ENODEV;
-	ret = cio_enable_subchannel(sch, sch->schib.pmcw.isc);
+	ret = cio_enable_subchannel(sch, sch->schib.pmcw.isc,
+				    (u32)(addr_t)sch);
 	if (ret != 0) {
 		/* Couldn't enable the subchannel for i/o. Sick device. */
 		if (ret == -ENODEV)
@@ -1043,7 +1045,8 @@ ccw_device_start_id(struct ccw_device *c
 	struct subchannel *sch;
 
 	sch = to_subchannel(cdev->dev.parent);
-	if (cio_enable_subchannel(sch, sch->schib.pmcw.isc) != 0)
+	if (cio_enable_subchannel(sch, sch->schib.pmcw.isc,
+				  (u32)(addr_t)sch) != 0)
 		/* Couldn't enable the subchannel for i/o. Sick device. */
 		return;
 
Index: quilt-2.6/drivers/s390/cio/device_ops.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_ops.c
+++ quilt-2.6/drivers/s390/cio/device_ops.c
@@ -501,7 +501,7 @@ ccw_device_stlck(struct ccw_device *cdev
 		return -ENOMEM;
 	}
 	spin_lock_irqsave(sch->lock, flags);
-	ret = cio_enable_subchannel(sch, 3);
+	ret = cio_enable_subchannel(sch, 3, (u32)(addr_t)sch);
 	if (ret)
 		goto out_unlock;
 	/*

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
