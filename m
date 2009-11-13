Return-Path: <linux-kernel-owner+w=401wt.eu-S1756914AbZKMPL7@vger.kernel.org>
Message-Id: <20091113150915.209911383@de.ibm.com>
Date: Fri, 13 Nov 2009 16:08:57 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 33/52] [PATCH] cio: handle error during path verification consistently
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=132-cio-verification-errors.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Handle verification errors consistently through the existing
callback ccw_device_done to reduce cleanup code duplication.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device_fsm.c  |   19 +++++++++----------
 drivers/s390/cio/device_pgid.c |    2 +-
 2 files changed, 10 insertions(+), 11 deletions(-)

Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c	2009-11-13 16:08:18.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device_fsm.c	2009-11-13 16:08:19.000000000 +0100
@@ -549,9 +549,8 @@
 	sch = to_subchannel(cdev->dev.parent);
 	/* Update schib - pom may have changed. */
 	if (cio_update_schib(sch)) {
-		cdev->private->flags.donotify = 0;
-		ccw_device_done(cdev, DEV_STATE_NOT_OPER);
-		return;
+		err = -ENODEV;
+		goto callback;
 	}
 	/* Update lpm with verified path mask. */
 	sch->lpm = sch->vpm;
@@ -561,9 +560,8 @@
 		ccw_device_verify_start(cdev);
 		return;
 	}
+callback:
 	switch (err) {
-	case -EOPNOTSUPP: /* path grouping not supported, just set online. */
-		cdev->private->options.pgroup = 0;
 	case 0:
 		ccw_device_done(cdev, DEV_STATE_ONLINE);
 		/* Deliver fake irb to device driver, if needed. */
@@ -586,14 +584,15 @@
 		cdev->private->flags.donotify = 0;
 		ccw_device_done(cdev, DEV_STATE_BOXED);
 		break;
+	case -EACCES:
+		/* Reset oper notify indication after verify error. */
+		cdev->private->flags.donotify = 0;
+		ccw_device_done(cdev, DEV_STATE_DISCONNECTED);
+		break;
 	default:
 		/* Reset oper notify indication after verify error. */
 		cdev->private->flags.donotify = 0;
-		if (cdev->online) {
-			ccw_device_set_timeout(cdev, 0);
-			dev_fsm_event(cdev, DEV_EVENT_NOTOPER);
-		} else
-			ccw_device_done(cdev, DEV_STATE_NOT_OPER);
+		ccw_device_done(cdev, DEV_STATE_NOT_OPER);
 		break;
 	}
 }
Index: quilt-2.6/drivers/s390/cio/device_pgid.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_pgid.c	2009-11-13 15:48:33.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device_pgid.c	2009-11-13 16:08:19.000000000 +0100
@@ -423,7 +423,7 @@
 		/* Permanent path failure, try next. */
 	}
 	/* Done with all paths. */
-	ccw_device_verify_done(cdev, (sch->vpm != 0) ? 0 : -ENODEV);
+	ccw_device_verify_done(cdev, (sch->vpm != 0) ? 0 : -EACCES);
 }
 		
 /*
