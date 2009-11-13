Return-Path: <linux-kernel-owner+w=401wt.eu-S932090AbZKMPNl@vger.kernel.org>
Message-Id: <20091113150915.570953227@de.ibm.com>
Date: Fri, 13 Nov 2009 16:08:59 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 35/52] [PATCH] cio: dont panic in non-fatal conditions
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=134-cio-avoid-panic.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Remove the call to BUG() for situations which are unexpected
but do not cause actual problems.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device_fsm.c |   25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c	2009-11-13 16:08:19.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device_fsm.c	2009-11-13 16:08:19.000000000 +0100
@@ -1055,14 +1055,14 @@
 		ccw_device_start_id(cdev, 0);
 }
 
-static void
-ccw_device_offline_irq(struct ccw_device *cdev, enum dev_event dev_event)
+static void ccw_device_disabled_irq(struct ccw_device *cdev,
+				    enum dev_event dev_event)
 {
 	struct subchannel *sch;
 
 	sch = to_subchannel(cdev->dev.parent);
 	/*
-	 * An interrupt in state offline means a previous disable was not
+	 * An interrupt in a disabled state means a previous disable was not
 	 * successful - should not happen, but we try to disable again.
 	 */
 	cio_disable_subchannel(sch);
@@ -1125,25 +1125,12 @@
 }
 
 /*
- * Bug operation action. 
- */
-static void
-ccw_device_bug(struct ccw_device *cdev, enum dev_event dev_event)
-{
-	CIO_MSG_EVENT(0, "Internal state [%i][%i] not handled for device "
-		      "0.%x.%04x\n", cdev->private->state, dev_event,
-		      cdev->private->dev_id.ssid,
-		      cdev->private->dev_id.devno);
-	BUG();
-}
-
-/*
  * device statemachine
  */
 fsm_func_t *dev_jumptable[NR_DEV_STATES][NR_DEV_EVENTS] = {
 	[DEV_STATE_NOT_OPER] = {
 		[DEV_EVENT_NOTOPER]	= ccw_device_nop,
-		[DEV_EVENT_INTERRUPT]	= ccw_device_bug,
+		[DEV_EVENT_INTERRUPT]	= ccw_device_disabled_irq,
 		[DEV_EVENT_TIMEOUT]	= ccw_device_nop,
 		[DEV_EVENT_VERIFY]	= ccw_device_nop,
 	},
@@ -1161,7 +1148,7 @@
 	},
 	[DEV_STATE_OFFLINE] = {
 		[DEV_EVENT_NOTOPER]	= ccw_device_generic_notoper,
-		[DEV_EVENT_INTERRUPT]	= ccw_device_offline_irq,
+		[DEV_EVENT_INTERRUPT]	= ccw_device_disabled_irq,
 		[DEV_EVENT_TIMEOUT]	= ccw_device_nop,
 		[DEV_EVENT_VERIFY]	= ccw_device_offline_verify,
 	},
@@ -1218,7 +1205,7 @@
 	[DEV_STATE_DISCONNECTED] = {
 		[DEV_EVENT_NOTOPER]	= ccw_device_nop,
 		[DEV_EVENT_INTERRUPT]	= ccw_device_start_id,
-		[DEV_EVENT_TIMEOUT]	= ccw_device_bug,
+		[DEV_EVENT_TIMEOUT]	= ccw_device_nop,
 		[DEV_EVENT_VERIFY]	= ccw_device_start_id,
 	},
 	[DEV_STATE_DISCONNECTED_SENSE_ID] = {
