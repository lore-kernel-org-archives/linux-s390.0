Return-Path: <linux-kernel-owner+w=401wt.eu-S1755868AbXD0OPu@vger.kernel.org>
Message-Id: <20070427140514.809855077@de.ibm.com>
References: <20070427140503.087958775@de.ibm.com>
Date: Fri, 27 Apr 2007 16:05:16 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 13/38] cio: Dont call css_update_ssd_info from interrupt context.
Content-Disposition: inline; filename=111-cio-update-ssd.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device.c     |    3 ++-
 drivers/s390/cio/device_fsm.c |    1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c	2007-04-27 16:04:55.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/device.c	2007-04-27 16:04:55.000000000 +0200
@@ -743,6 +743,7 @@
 static void sch_attach_device(struct subchannel *sch,
 			      struct ccw_device *cdev)
 {
+	css_update_ssd_info(sch);
 	spin_lock_irq(sch->lock);
 	sch->dev.driver_data = cdev;
 	cdev->private->schid = sch->schid;
@@ -878,7 +879,7 @@
 	priv = container_of(work, struct ccw_device_private, kick_work);
 	cdev = priv->cdev;
 	sch = to_subchannel(cdev->dev.parent);
-
+	css_update_ssd_info(sch);
 	/*
 	 * io_subchannel_register() will also be called after device
 	 * recognition has been done for a boxed device (which will already
Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c	2007-04-27 16:04:55.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/device_fsm.c	2007-04-27 16:04:55.000000000 +0200
@@ -246,7 +246,6 @@
 	 */
 	old_lpm = sch->lpm;
 	stsch(sch->schid, &sch->schib);
-	css_update_ssd_info(sch);
 	sch->lpm = sch->schib.pmcw.pam & sch->opm;
 	/* Check since device may again have become not operational. */
 	if (!sch->schib.pmcw.dnv)

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
