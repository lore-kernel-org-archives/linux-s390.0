Return-Path: <linux-kernel-owner+w=401wt.eu-S933721AbXKPO0B@vger.kernel.org>
Message-Id: <20071116142525.884966146@de.ibm.com>
References: <20071116142441.484714036@de.ibm.com>
Date: Fri, 16 Nov 2007 15:24:42 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 01/10] cio: change device sense procedure to work with pav aliases
Content-Disposition: inline; filename=001-cio-sense.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Modify the sense id channel program to allow device sensing of pav
alias devices which belong to a base device with ungrouped paths.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device_id.c |   45 ++++++++-----------------------------------
 1 file changed, 9 insertions(+), 36 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/device_id.c linux-2.6-patched/drivers/s390/cio/device_id.c
--- linux-2.6/drivers/s390/cio/device_id.c	2007-10-09 22:31:38.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_id.c	2007-11-16 14:27:37.000000000 +0100
@@ -113,19 +113,10 @@ __ccw_device_sense_id_start(struct ccw_d
 {
 	struct subchannel *sch;
 	struct ccw1 *ccw;
-	int ret;
 
 	sch = to_subchannel(cdev->dev.parent);
 	/* Setup sense channel program. */
 	ccw = cdev->private->iccws;
-	if (sch->schib.pmcw.pim != 0x80) {
-		/* more than one path installed. */
-		ccw->cmd_code = CCW_CMD_SUSPEND_RECONN;
-		ccw->cda = 0;
-		ccw->count = 0;
-		ccw->flags = CCW_FLAG_SLI | CCW_FLAG_CC;
-		ccw++;
-	}
 	ccw->cmd_code = CCW_CMD_SENSE_ID;
 	ccw->cda = (__u32) __pa (&cdev->private->senseid);
 	ccw->count = sizeof (struct senseid);
@@ -133,25 +124,9 @@ __ccw_device_sense_id_start(struct ccw_d
 
 	/* Reset device status. */
 	memset(&cdev->private->irb, 0, sizeof(struct irb));
+	cdev->private->flags.intretry = 0;
 
-	/* Try on every path. */
-	ret = -ENODEV;
-	while (cdev->private->imask != 0) {
-		if ((sch->opm & cdev->private->imask) != 0 &&
-		    cdev->private->iretry > 0) {
-			cdev->private->iretry--;
-			/* Reset internal retry indication. */
-			cdev->private->flags.intretry = 0;
-			ret = cio_start (sch, cdev->private->iccws,
-					 cdev->private->imask);
-			/* ret is 0, -EBUSY, -EACCES or -ENODEV */
-			if (ret != -EACCES)
-				return ret;
-		}
-		cdev->private->imask >>= 1;
-		cdev->private->iretry = 5;
-	}
-	return ret;
+	return cio_start(sch, ccw, LPM_ANYPATH);
 }
 
 void
@@ -161,8 +136,7 @@ ccw_device_sense_id_start(struct ccw_dev
 
 	memset (&cdev->private->senseid, 0, sizeof (struct senseid));
 	cdev->private->senseid.cu_type = 0xFFFF;
-	cdev->private->imask = 0x80;
-	cdev->private->iretry = 5;
+	cdev->private->iretry = 3;
 	ret = __ccw_device_sense_id_start(cdev);
 	if (ret && ret != -EBUSY)
 		ccw_device_sense_id_done(cdev, ret);
@@ -278,14 +252,13 @@ ccw_device_sense_id_irq(struct ccw_devic
 		ccw_device_sense_id_done(cdev, ret);
 		break;
 	case -EACCES:		/* channel is not operational. */
-		sch->lpm &= ~cdev->private->imask;
-		cdev->private->imask >>= 1;
-		cdev->private->iretry = 5;
-		/* fall through. */
 	case -EAGAIN:		/* try again. */
-		ret = __ccw_device_sense_id_start(cdev);
-		if (ret == 0 || ret == -EBUSY)
-			break;
+		cdev->private->iretry--;
+		if (cdev->private->iretry > 0) {
+			ret = __ccw_device_sense_id_start(cdev);
+			if (ret == 0 || ret == -EBUSY)
+				break;
+		}
 		/* fall through. */
 	default:		/* Sense ID failed. Try asking VM. */
 		if (MACHINE_IS_VM) {

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
