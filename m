Return-Path: <linux-kernel-owner+w=401wt.eu-S1756249AbZKMPPV@vger.kernel.org>
Message-Id: <20091113150917.934915538@de.ibm.com>
Date: Fri, 13 Nov 2009 16:09:12 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 48/52] [PATCH] cio: handle busy subchannel in ccw_device_move_to_sch
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=147-cio-handle-busy-subchannel.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Sebastian Ott <sebott@linux.vnet.ibm.com>

Try to disable the old subchannel before we ask the driver core
to move the attached device to a new parent. This way we can use
the QUIESCE state during shutdown which prevents a possible use
after free situation in some error cases.

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device.c |   24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c	2009-11-13 16:08:22.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device.c	2009-11-13 16:08:22.000000000 +0100
@@ -892,12 +892,27 @@
 				  struct subchannel *sch)
 {
 	struct subchannel *old_sch;
-	int rc;
+	int rc, old_enabled = 0;
 
 	old_sch = to_subchannel(cdev->dev.parent);
 	/* Obtain child reference for new parent. */
 	if (!get_device(&sch->dev))
 		return -ENODEV;
+
+	if (!sch_is_pseudo_sch(old_sch)) {
+		spin_lock_irq(old_sch->lock);
+		old_enabled = old_sch->schib.pmcw.ena;
+		rc = 0;
+		if (old_enabled)
+			rc = cio_disable_subchannel(old_sch);
+		spin_unlock_irq(old_sch->lock);
+		if (rc == -EBUSY) {
+			/* Release child reference for new parent. */
+			put_device(&sch->dev);
+			return rc;
+		}
+	}
+
 	mutex_lock(&sch->reg_mutex);
 	rc = device_move(&cdev->dev, &sch->dev, DPM_ORDER_PARENT_BEFORE_DEV);
 	mutex_unlock(&sch->reg_mutex);
@@ -906,6 +921,12 @@
 			      cdev->private->dev_id.ssid,
 			      cdev->private->dev_id.devno, sch->schid.ssid,
 			      sch->schib.pmcw.dev, rc);
+		if (old_enabled) {
+			/* Try to reenable the old subchannel. */
+			spin_lock_irq(old_sch->lock);
+			cio_enable_subchannel(old_sch, (u32)(addr_t)old_sch);
+			spin_unlock_irq(old_sch->lock);
+		}
 		/* Release child reference for new parent. */
 		put_device(&sch->dev);
 		return rc;
@@ -914,7 +935,6 @@
 	if (!sch_is_pseudo_sch(old_sch)) {
 		spin_lock_irq(old_sch->lock);
 		sch_set_cdev(old_sch, NULL);
-		cio_disable_subchannel(old_sch);
 		spin_unlock_irq(old_sch->lock);
 		css_schedule_eval(old_sch->schid);
 	}
