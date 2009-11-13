Return-Path: <linux-kernel-owner+w=401wt.eu-S1756442AbZKMPKU@vger.kernel.org>
Message-Id: <20091113150918.109516578@de.ibm.com>
Date: Fri, 13 Nov 2009 16:09:13 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 49/52] [PATCH] cio: quiesce subchannel in io_subchannel_remove
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=148-cio-quiesce-subchannel.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Sebastian Ott <sebott@linux.vnet.ibm.com>

Ensure that there will be no more interrupts for an
unregistered device by using the same quiesce and disable loop
as in io_subchannel_shutdown.

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c	2009-11-13 16:08:22.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device.c	2009-11-13 16:08:22.000000000 +0100
@@ -1059,6 +1059,8 @@
 	return 0;
 }
 
+static void io_subchannel_quiesce(struct subchannel *);
+
 static int
 io_subchannel_remove (struct subchannel *sch)
 {
@@ -1068,6 +1070,7 @@
 	cdev = sch_get_cdev(sch);
 	if (!cdev)
 		goto out_free;
+	io_subchannel_quiesce(sch);
 	/* Set ccw device to not operational and drop reference. */
 	spin_lock_irqsave(cdev->ccwlock, flags);
 	sch_set_cdev(sch, NULL);
@@ -1150,7 +1153,7 @@
 	return 0;
 }
 
-static void io_subchannel_shutdown(struct subchannel *sch)
+static void io_subchannel_quiesce(struct subchannel *sch)
 {
 	struct ccw_device *cdev;
 	int ret;
@@ -1182,6 +1185,11 @@
 	spin_unlock_irq(sch->lock);
 }
 
+static void io_subchannel_shutdown(struct subchannel *sch)
+{
+	io_subchannel_quiesce(sch);
+}
+
 static int device_is_disconnected(struct ccw_device *cdev)
 {
 	if (!cdev)
