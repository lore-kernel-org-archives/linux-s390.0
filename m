Return-Path: <linux-kernel-owner+w=401wt.eu-S1756696AbZKMPPo@vger.kernel.org>
Message-Id: <20091113150913.996961975@de.ibm.com>
Date: Fri, 13 Nov 2009 16:08:50 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 26/52] [PATCH] cio: fix double free in case of probe failure
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=125-cio-probe-free.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

io_subchannel_probe() frees memory for sch->private which is later
freed again when io_subchannel_remove() is called. Fix this problem
by removing the cleanup in io_subchannel_probe().

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c	2009-11-13 15:48:33.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device.c	2009-11-13 16:08:17.000000000 +0100
@@ -1292,7 +1292,7 @@
 	sch->private = kzalloc(sizeof(struct io_subchannel_private),
 			       GFP_KERNEL | GFP_DMA);
 	if (!sch->private)
-		goto out_err;
+		goto out_schedule;
 	/*
 	 * First check if a fitting device may be found amongst the
 	 * disconnected devices or in the orphanage.
@@ -1317,7 +1317,7 @@
 	}
 	cdev = io_subchannel_create_ccwdev(sch);
 	if (IS_ERR(cdev))
-		goto out_err;
+		goto out_schedule;
 	rc = io_subchannel_recog(cdev, sch);
 	if (rc) {
 		spin_lock_irqsave(sch->lock, flags);
@@ -1325,9 +1325,7 @@
 		spin_unlock_irqrestore(sch->lock, flags);
 	}
 	return 0;
-out_err:
-	kfree(sch->private);
-	sysfs_remove_group(&sch->dev.kobj, &io_subchannel_attr_group);
+
 out_schedule:
 	io_subchannel_schedule_removal(sch);
 	return 0;
@@ -1341,13 +1339,14 @@
 
 	cdev = sch_get_cdev(sch);
 	if (!cdev)
-		return 0;
+		goto out_free;
 	/* Set ccw device to not operational and drop reference. */
 	spin_lock_irqsave(cdev->ccwlock, flags);
 	sch_set_cdev(sch, NULL);
 	cdev->private->state = DEV_STATE_NOT_OPER;
 	spin_unlock_irqrestore(cdev->ccwlock, flags);
 	ccw_device_unregister(cdev);
+out_free:
 	kfree(sch->private);
 	sysfs_remove_group(&sch->dev.kobj, &io_subchannel_attr_group);
 	return 0;
