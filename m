Return-Path: <linux-kernel-owner+w=401wt.eu-S1756857AbZKMPLt@vger.kernel.org>
Message-Id: <20091113150916.243815199@de.ibm.com>
Date: Fri, 13 Nov 2009 16:09:03 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 39/52] [PATCH] cio: allow setting not-operational devices offline
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=138-cio-allow-offline.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Accept a request for setting a not-operational device offline.
This way, users can remove devices from Linux which would otherwise
remain unusable until reboot.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c	2009-11-13 16:08:20.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device.c	2009-11-13 16:08:20.000000000 +0100
@@ -529,11 +529,10 @@
 	int force, ret;
 	unsigned long i;
 
-	if ((cdev->private->state != DEV_STATE_OFFLINE &&
-	     cdev->private->state != DEV_STATE_ONLINE &&
-	     cdev->private->state != DEV_STATE_BOXED &&
-	     cdev->private->state != DEV_STATE_DISCONNECTED) ||
-	    atomic_cmpxchg(&cdev->private->onoff, 0, 1) != 0)
+	if (!dev_fsm_final_state(cdev) &&
+	    cdev->private->state != DEV_STATE_DISCONNECTED)
+		return -EAGAIN;
+	if (atomic_cmpxchg(&cdev->private->onoff, 0, 1) != 0)
 		return -EAGAIN;
 
 	if (cdev->drv && !try_module_get(cdev->drv->owner)) {
