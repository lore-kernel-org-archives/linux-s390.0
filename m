Return-Path: <linux-kernel-owner+w=401wt.eu-S1764100AbYD2OS7@vger.kernel.org>
Message-Id: <20080429140250.291598912@de.ibm.com>
References: <20080429140117.631962807@de.ibm.com>
Date: Tue, 29 Apr 2008 16:01:24 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 07/15] cio: Make isc handling more robust.
Content-Disposition: inline; filename=007-cio-isc.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Introduce an ->isc field in the subchannel to store the desired
interruption subclass, since sch->schib.pmcw.isc may be overwritten
by the hardware on stsch() after machine checks.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/cio.c        |    9 ++++-----
 drivers/s390/cio/cio.h        |    3 ++-
 drivers/s390/cio/device_fsm.c |   10 +++-------
 drivers/s390/cio/device_ops.c |    2 +-
 4 files changed, 10 insertions(+), 14 deletions(-)

Index: quilt-2.6/drivers/s390/cio/cio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.c
+++ quilt-2.6/drivers/s390/cio/cio.c
@@ -407,8 +407,7 @@ cio_modify (struct subchannel *sch)
 /*
  * Enable subchannel.
  */
-int cio_enable_subchannel(struct subchannel *sch, unsigned int isc,
-			  u32 intparm)
+int cio_enable_subchannel(struct subchannel *sch, u32 intparm)
 {
 	char dbf_txt[15];
 	int ccode;
@@ -426,7 +425,7 @@ int cio_enable_subchannel(struct subchan
 
 	for (retry = 5, ret = 0; retry > 0; retry--) {
 		sch->schib.pmcw.ena = 1;
-		sch->schib.pmcw.isc = isc;
+		sch->schib.pmcw.isc = sch->isc;
 		sch->schib.pmcw.intparm = intparm;
 		ret = cio_modify(sch);
 		if (ret == -ENODEV)
@@ -600,6 +599,7 @@ cio_validate_subchannel (struct subchann
 	else
 		sch->opm = chp_get_sch_opm(sch);
 	sch->lpm = sch->schib.pmcw.pam & sch->opm;
+	sch->isc = 3;
 
 	CIO_DEBUG(KERN_INFO, 0,
 		  "Detected device %04x on subchannel 0.%x.%04X"
@@ -610,13 +610,11 @@ cio_validate_subchannel (struct subchann
 
 	/*
 	 * We now have to initially ...
-	 *  ... set "interruption subclass"
 	 *  ... enable "concurrent sense"
 	 *  ... enable "multipath mode" if more than one
 	 *	  CHPID is available. This is done regardless
 	 *	  whether multiple paths are available for us.
 	 */
-	sch->schib.pmcw.isc = 3;	/* could be smth. else */
 	sch->schib.pmcw.csense = 1;	/* concurrent sense */
 	sch->schib.pmcw.ena = 0;
 	if ((sch->lpm & (sch->lpm - 1)) != 0)
@@ -812,6 +810,7 @@ cio_probe_console(void)
 	 * enable console I/O-interrupt subclass 7
 	 */
 	ctl_set_bit(6, 24);
+	console_subchannel.isc = 7;
 	console_subchannel.schib.pmcw.isc = 7;
 	console_subchannel.schib.pmcw.intparm =
 		(u32)(addr_t)&console_subchannel;
Index: quilt-2.6/drivers/s390/cio/cio.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.h
+++ quilt-2.6/drivers/s390/cio/cio.h
@@ -74,6 +74,7 @@ struct subchannel {
 	__u8 lpm;		/* logical path mask */
 	__u8 opm;               /* operational path mask */
 	struct schib schib;	/* subchannel information block */
+	int isc; /* desired interruption subclass */
 	struct chsc_ssd_info ssd_info;	/* subchannel description */
 	struct device dev;	/* entry in device tree */
 	struct css_driver *driver;
@@ -85,7 +86,7 @@ struct subchannel {
 #define to_subchannel(n) container_of(n, struct subchannel, dev)
 
 extern int cio_validate_subchannel (struct subchannel *, struct subchannel_id);
-extern int cio_enable_subchannel(struct subchannel *, unsigned int, u32);
+extern int cio_enable_subchannel(struct subchannel *, u32);
 extern int cio_disable_subchannel (struct subchannel *);
 extern int cio_cancel (struct subchannel *);
 extern int cio_clear (struct subchannel *);
Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c
+++ quilt-2.6/drivers/s390/cio/device_fsm.c
@@ -555,8 +555,7 @@ ccw_device_recognition(struct ccw_device
 	    (cdev->private->state != DEV_STATE_BOXED))
 		return -EINVAL;
 	sch = to_subchannel(cdev->dev.parent);
-	ret = cio_enable_subchannel(sch, sch->schib.pmcw.isc,
-				    (u32)(addr_t)sch);
+	ret = cio_enable_subchannel(sch, (u32)(addr_t)sch);
 	if (ret != 0)
 		/* Couldn't enable the subchannel for i/o. Sick device. */
 		return ret;
@@ -667,8 +666,7 @@ ccw_device_online(struct ccw_device *cde
 	sch = to_subchannel(cdev->dev.parent);
 	if (css_init_done && !get_device(&cdev->dev))
 		return -ENODEV;
-	ret = cio_enable_subchannel(sch, sch->schib.pmcw.isc,
-				    (u32)(addr_t)sch);
+	ret = cio_enable_subchannel(sch, (u32)(addr_t)sch);
 	if (ret != 0) {
 		/* Couldn't enable the subchannel for i/o. Sick device. */
 		if (ret == -ENODEV)
@@ -1048,8 +1046,7 @@ ccw_device_start_id(struct ccw_device *c
 	struct subchannel *sch;
 
 	sch = to_subchannel(cdev->dev.parent);
-	if (cio_enable_subchannel(sch, sch->schib.pmcw.isc,
-				  (u32)(addr_t)sch) != 0)
+	if (cio_enable_subchannel(sch, (u32)(addr_t)sch) != 0)
 		/* Couldn't enable the subchannel for i/o. Sick device. */
 		return;
 
@@ -1082,7 +1079,6 @@ device_trigger_reprobe(struct subchannel
 	 */
 	sch->lpm = sch->schib.pmcw.pam & sch->opm;
 	/* Re-set some bits in the pmcw that were lost. */
-	sch->schib.pmcw.isc = 3;
 	sch->schib.pmcw.csense = 1;
 	sch->schib.pmcw.ena = 0;
 	if ((sch->lpm & (sch->lpm - 1)) != 0)
Index: quilt-2.6/drivers/s390/cio/device_ops.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_ops.c
+++ quilt-2.6/drivers/s390/cio/device_ops.c
@@ -508,7 +508,7 @@ ccw_device_stlck(struct ccw_device *cdev
 		return -ENOMEM;
 	}
 	spin_lock_irqsave(sch->lock, flags);
-	ret = cio_enable_subchannel(sch, 3, (u32)(addr_t)sch);
+	ret = cio_enable_subchannel(sch, (u32)(addr_t)sch);
 	if (ret)
 		goto out_unlock;
 	/*

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
