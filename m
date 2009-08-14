Return-Path: <linux-kernel-owner+w=401wt.eu-S1755503AbZHNL0U@vger.kernel.org>
Message-Id: <20090814112613.471582384@de.ibm.com>
References: <20090814112517.982007860@de.ibm.com>
Date: Fri, 14 Aug 2009 13:25:21 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 04/34] cio: fix not oper handling after failed line processing
Content-Disposition: inline; filename=103-cio-not-oper-handling.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Sebastian Ott <sebott@linux.vnet.ibm.com>

If online/offline processing of a ccw device fails, resulting in not
operational state, notify the driver and unregister the device in case
the driver dosn't want to keep it.

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device_fsm.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c
+++ quilt-2.6/drivers/s390/cio/device_fsm.c
@@ -394,6 +394,13 @@ ccw_device_done(struct ccw_device *cdev,
 			ccw_device_schedule_sch_unregister(cdev);
 		cdev->private->flags.donotify = 0;
 	}
+	if (state == DEV_STATE_NOT_OPER) {
+		CIO_MSG_EVENT(0, "Device %04x gone on subchannel %04x\n",
+			      cdev->private->dev_id.devno, sch->schid.sch_no);
+		if (!ccw_device_notify(cdev, CIO_GONE))
+			ccw_device_schedule_sch_unregister(cdev);
+		cdev->private->flags.donotify = 0;
+	}
 
 	if (cdev->private->flags.donotify) {
 		cdev->private->flags.donotify = 0;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
