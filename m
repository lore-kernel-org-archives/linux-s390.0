Return-Path: <linux-kernel-owner+w=401wt.eu-S1756678AbZKMPPm@vger.kernel.org>
Message-Id: <20091113150914.166966263@de.ibm.com>
Date: Fri, 13 Nov 2009 16:08:51 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 27/52] [PATCH] cio: fix repeat setting of cdev parent association
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=126-cio-parent-assoc.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

sch_create_and_recog_new_device() associates a parent subchannel
with its ccw device child even though this is already done by
the subsequently called io_subchannel_recog(). Also make sure
io_subchannel_recog() sets the association under lock.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c	2009-11-13 16:08:17.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device.c	2009-11-13 16:08:17.000000000 +0100
@@ -888,9 +888,6 @@
 		css_sch_device_unregister(sch);
 		return;
 	}
-	spin_lock_irq(sch->lock);
-	sch_set_cdev(sch, cdev);
-	spin_unlock_irq(sch->lock);
 	/* Start recognition for the new ccw device. */
 	if (io_subchannel_recog(cdev, sch)) {
 		spin_lock_irq(sch->lock);
@@ -1107,7 +1104,6 @@
 	int rc;
 	struct ccw_device_private *priv;
 
-	sch_set_cdev(sch, cdev);
 	cdev->ccwlock = sch->lock;
 
 	/* Init private data. */
@@ -1125,6 +1121,7 @@
 
 	/* Start async. device sensing. */
 	spin_lock_irq(sch->lock);
+	sch_set_cdev(sch, cdev);
 	rc = ccw_device_recognition(cdev);
 	spin_unlock_irq(sch->lock);
 	if (rc) {
