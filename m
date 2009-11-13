Return-Path: <linux-kernel-owner+w=401wt.eu-S1756345AbZKMPKB@vger.kernel.org>
Message-Id: <20091113150918.625258802@de.ibm.com>
Date: Fri, 13 Nov 2009 16:09:16 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 52/52] [PATCH] cio: dont unregister a busy device in ccw_device_set_offline
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=151-cio-busy-device-unregister.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Sebastian Ott <sebott@linux.vnet.ibm.com>

If we detect a busy subchannel after the driver's set_offline
callback returned in ccw_device_set_offline, the current behavior
is to unregister the device, which may lead to undesired
consequences. Change this to just quiesce the subchannel and go on
with the offline processing.

Note: This is no excuse for not fixing these drivers -
after the set_offline callback they should have no running IO!

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device.c |   29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c	2009-11-13 16:08:23.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device.c	2009-11-13 16:08:23.000000000 +0100
@@ -314,6 +314,8 @@
 	}
 }
 
+static void io_subchannel_quiesce(struct subchannel *);
+
 /**
  * ccw_device_set_offline() - disable a ccw device for I/O
  * @cdev: target ccw device
@@ -327,7 +329,8 @@
  */
 int ccw_device_set_offline(struct ccw_device *cdev)
 {
-	int ret;
+	struct subchannel *sch;
+	int ret, state;
 
 	if (!cdev)
 		return -ENODEV;
@@ -341,6 +344,7 @@
 	}
 	cdev->online = 0;
 	spin_lock_irq(cdev->ccwlock);
+	sch = to_subchannel(cdev->dev.parent);
 	/* Wait until a final state or DISCONNECTED is reached */
 	while (!dev_fsm_final_state(cdev) &&
 	       cdev->private->state != DEV_STATE_DISCONNECTED) {
@@ -349,9 +353,21 @@
 			   cdev->private->state == DEV_STATE_DISCONNECTED));
 		spin_lock_irq(cdev->ccwlock);
 	}
-	ret = ccw_device_offline(cdev);
-	if (ret)
-		goto error;
+	do {
+		ret = ccw_device_offline(cdev);
+		if (!ret)
+			break;
+		CIO_MSG_EVENT(0, "ccw_device_offline returned %d, device "
+			      "0.%x.%04x\n", ret, cdev->private->dev_id.ssid,
+			      cdev->private->dev_id.devno);
+		if (ret != -EBUSY)
+			goto error;
+		state = cdev->private->state;
+		spin_unlock_irq(cdev->ccwlock);
+		io_subchannel_quiesce(sch);
+		spin_lock_irq(cdev->ccwlock);
+		cdev->private->state = state;
+	} while (ret == -EBUSY);
 	spin_unlock_irq(cdev->ccwlock);
 	wait_event(cdev->private->wait_q, (dev_fsm_final_state(cdev) ||
 		   cdev->private->state == DEV_STATE_DISCONNECTED));
@@ -368,9 +384,6 @@
 	return 0;
 
 error:
-	CIO_MSG_EVENT(0, "ccw_device_offline returned %d, device 0.%x.%04x\n",
-		      ret, cdev->private->dev_id.ssid,
-		      cdev->private->dev_id.devno);
 	cdev->private->state = DEV_STATE_OFFLINE;
 	dev_fsm_event(cdev, DEV_EVENT_NOTOPER);
 	spin_unlock_irq(cdev->ccwlock);
@@ -1059,8 +1072,6 @@
 	return 0;
 }
 
-static void io_subchannel_quiesce(struct subchannel *);
-
 static int
 io_subchannel_remove (struct subchannel *sch)
 {
