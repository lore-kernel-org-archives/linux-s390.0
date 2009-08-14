Return-Path: <linux-kernel-owner+w=401wt.eu-S932240AbZHNL0y@vger.kernel.org>
Message-Id: <20090814112612.756971144@de.ibm.com>
References: <20090814112517.982007860@de.ibm.com>
Date: Fri, 14 Aug 2009 13:25:18 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 01/34] cio: fix ineffective verify event
Content-Disposition: inline; filename=100-cio-verify-event.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Path verification events occurring for offline devices are currently
ignored. As a result, offline devices are not removed, even though
they might no longer be accessible (for example because the last path
to the device was varied offline). Fix this by scheduling a status
evaluation for the affected subchannel when a path verification event
occurs.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device_fsm.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c
+++ quilt-2.6/drivers/s390/cio/device_fsm.c
@@ -731,6 +731,17 @@ static void ccw_device_generic_notoper(s
 }
 
 /*
+ * Handle path verification event in offline state.
+ */
+static void ccw_device_offline_verify(struct ccw_device *cdev,
+				      enum dev_event dev_event)
+{
+	struct subchannel *sch = to_subchannel(cdev->dev.parent);
+
+	css_schedule_eval(sch->schid);
+}
+
+/*
  * Handle path verification event.
  */
 static void
@@ -1149,7 +1160,7 @@ fsm_func_t *dev_jumptable[NR_DEV_STATES]
 		[DEV_EVENT_NOTOPER]	= ccw_device_generic_notoper,
 		[DEV_EVENT_INTERRUPT]	= ccw_device_offline_irq,
 		[DEV_EVENT_TIMEOUT]	= ccw_device_nop,
-		[DEV_EVENT_VERIFY]	= ccw_device_nop,
+		[DEV_EVENT_VERIFY]	= ccw_device_offline_verify,
 	},
 	[DEV_STATE_VERIFY] = {
 		[DEV_EVENT_NOTOPER]	= ccw_device_generic_notoper,

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
