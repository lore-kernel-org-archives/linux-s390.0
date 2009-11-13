Return-Path: <linux-kernel-owner+w=401wt.eu-S1756385AbZKMPKL@vger.kernel.org>
Message-Id: <20091113150918.296550253@de.ibm.com>
Date: Fri, 13 Nov 2009 16:09:14 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 50/52] [PATCH] cio: change locking in io_subchannel_remove
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=149-cio-subchannel-locking.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Sebastian Ott <sebott@linux.vnet.ibm.com>

IO subchannels are always unregistered in process context, so use
spin_lock_irq in the corresponding remove callback.

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c	2009-11-13 16:08:22.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device.c	2009-11-13 16:08:23.000000000 +0100
@@ -1065,17 +1065,16 @@
 io_subchannel_remove (struct subchannel *sch)
 {
 	struct ccw_device *cdev;
-	unsigned long flags;
 
 	cdev = sch_get_cdev(sch);
 	if (!cdev)
 		goto out_free;
 	io_subchannel_quiesce(sch);
 	/* Set ccw device to not operational and drop reference. */
-	spin_lock_irqsave(cdev->ccwlock, flags);
+	spin_lock_irq(cdev->ccwlock);
 	sch_set_cdev(sch, NULL);
 	cdev->private->state = DEV_STATE_NOT_OPER;
-	spin_unlock_irqrestore(cdev->ccwlock, flags);
+	spin_unlock_irq(cdev->ccwlock);
 	ccw_device_unregister(cdev);
 out_free:
 	kfree(sch->private);
