Return-Path: <linux-kernel-owner+w=401wt.eu-S1756766AbXKTKM2@vger.kernel.org>
Message-Id: <20071120101138.740825856@de.ibm.com>
References: <20071120101046.904031933@de.ibm.com>
Date: Tue, 20 Nov 2007 11:10:48 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 2/2] cio: Register/unregister subchannels only from kslowcrw.
Content-Disposition: inline; filename=012-cio-kslowcrw.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Make sure all subchannel handling is done on the slow path workqueue
so that we don't have races between an old subchannel unregistering
and a new subchannel with the same name registering.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/css.c        |    2 +-
 drivers/s390/cio/device_fsm.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c
+++ quilt-2.6/drivers/s390/cio/css.c
@@ -483,7 +483,7 @@ static DECLARE_WORK(css_reprobe_work, re
 void css_schedule_reprobe(void)
 {
 	need_reprobe = 1;
-	queue_work(ccw_device_work, &css_reprobe_work);
+	queue_work(slow_path_wq, &css_reprobe_work);
 }
 
 EXPORT_SYMBOL_GPL(css_schedule_reprobe);
Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c
+++ quilt-2.6/drivers/s390/cio/device_fsm.c
@@ -1034,7 +1034,7 @@ device_trigger_reprobe(struct subchannel
 	if (sch->schib.pmcw.dev != cdev->private->dev_id.devno) {
 		PREPARE_WORK(&cdev->private->kick_work,
 			     ccw_device_move_to_orphanage);
-		queue_work(ccw_device_work, &cdev->private->kick_work);
+		queue_work(slow_path_wq, &cdev->private->kick_work);
 	} else
 		ccw_device_start_id(cdev, 0);
 }

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
