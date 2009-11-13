Return-Path: <linux-kernel-owner+w=401wt.eu-S1756885AbZKMPL4@vger.kernel.org>
Message-Id: <20091113150915.398821774@de.ibm.com>
Date: Fri, 13 Nov 2009 16:08:58 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 34/52] [PATCH] cio: ensure proper locking during device recognition
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=133-cio-recognition-locking.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Device recognition needs to be started with the ccw device lock
held to prevent race conditions between I/O starting and interrupt
reception.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device.c |    2 ++
 1 file changed, 2 insertions(+)

Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c	2009-11-13 16:08:18.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device.c	2009-11-13 16:08:19.000000000 +0100
@@ -488,7 +488,9 @@
 {
 	/* Do device recognition, if needed. */
 	if (cdev->private->state == DEV_STATE_BOXED) {
+		spin_lock_irq(cdev->ccwlock);
 		ccw_device_recognition(cdev);
+		spin_unlock_irq(cdev->ccwlock);
 		wait_event(cdev->private->wait_q,
 			   cdev->private->flags.recog_done);
 		if (cdev->private->state != DEV_STATE_OFFLINE)
