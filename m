Return-Path: <linux-kernel-owner+w=401wt.eu-S1760116AbXEaPgb@vger.kernel.org>
Message-Id: <20070531153438.092445204@de.ibm.com>
References: <20070531142024.011160634@de.ibm.com>
Date: Thu, 31 May 2007 16:20:31 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 7/7] cio: deregister ccw device when pgid disband failed
Content-Disposition: inline; filename=007-cio-pgid.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Deregister ccw device when device failure is detected during offline-
processing (e.g. when no last-path-gone indication was presented by
the hardware) to prevent the device from entering a non-recoverable
not-operational state.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device_fsm.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c
+++ quilt-2.6/drivers/s390/cio/device_fsm.c
@@ -688,6 +688,12 @@ ccw_device_disband_done(struct ccw_devic
 		ccw_device_done(cdev, DEV_STATE_BOXED);
 		break;
 	default:
+		cdev->private->flags.donotify = 0;
+		if (get_device(&cdev->dev)) {
+			PREPARE_WORK(&cdev->private->kick_work,
+				     ccw_device_call_sch_unregister);
+			queue_work(ccw_device_work, &cdev->private->kick_work);
+		}
 		ccw_device_done(cdev, DEV_STATE_NOT_OPER);
 		break;
 	}

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
