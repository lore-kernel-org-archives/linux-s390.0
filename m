Return-Path: <linux-kernel-owner+w=401wt.eu-S1762547AbZBYPOc@vger.kernel.org>
Message-Id: <20090225150834.457822219@de.ibm.com>
References: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:06:48 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 26/46] cio: Use ccw_device_set_notoper().
Content-Disposition: inline; filename=125-cio-set-notoper.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Use ccw_device_set_notoper() (which also deletes the device
timer and disables the subchannel) instead of simply setting
the state to DEV_STATE_NOT_OPER in the generic not operational
handling code. This prevents unexpected interrupts popping up
for devices that are deemed not operational.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device_fsm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c
+++ quilt-2.6/drivers/s390/cio/device_fsm.c
@@ -728,7 +728,7 @@ static void ccw_device_generic_notoper(s
 {
 	struct subchannel *sch;
 
-	cdev->private->state = DEV_STATE_NOT_OPER;
+	ccw_device_set_notoper(cdev);
 	sch = to_subchannel(cdev->dev.parent);
 	css_schedule_eval(sch->schid);
 }

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
