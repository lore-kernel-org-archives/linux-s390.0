Return-Path: <linux-kernel-owner+w=401wt.eu-S1757561AbXK0Q3o@vger.kernel.org>
Message-Id: <20071127162919.357661634@de.ibm.com>
References: <20071127162210.262064983@de.ibm.com>
Date: Tue, 27 Nov 2007 17:22:11 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 1/4] cio: Issue SenseID per path.
Content-Disposition: inline; filename=001-cio-senseid.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

We may receive a unit check for every path when we issue a SenseID.
Unfortunately, the channel subsystem will try on a different path
every time if we use a lpm of 0xff, which will exhaust our retry
counter.

Therefore, revert SenseID to its previous per-path behaviour and
just leave out the suspend multipath reconnect.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device_id.c |   37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

Index: quilt-2.6/drivers/s390/cio/device_id.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_id.c
+++ quilt-2.6/drivers/s390/cio/device_id.c
@@ -113,6 +113,7 @@ __ccw_device_sense_id_start(struct ccw_d
 {
 	struct subchannel *sch;
 	struct ccw1 *ccw;
+	int ret;
 
 	sch = to_subchannel(cdev->dev.parent);
 	/* Setup sense channel program. */
@@ -124,9 +125,25 @@ __ccw_device_sense_id_start(struct ccw_d
 
 	/* Reset device status. */
 	memset(&cdev->private->irb, 0, sizeof(struct irb));
-	cdev->private->flags.intretry = 0;
 
-	return cio_start(sch, ccw, LPM_ANYPATH);
+	/* Try on every path. */
+	ret = -ENODEV;
+	while (cdev->private->imask != 0) {
+		if ((sch->opm & cdev->private->imask) != 0 &&
+		    cdev->private->iretry > 0) {
+			cdev->private->iretry--;
+			/* Reset internal retry indication. */
+			cdev->private->flags.intretry = 0;
+			ret = cio_start (sch, cdev->private->iccws,
+					 cdev->private->imask);
+			/* ret is 0, -EBUSY, -EACCES or -ENODEV */
+			if (ret != -EACCES)
+				return ret;
+		}
+		cdev->private->imask >>= 1;
+		cdev->private->iretry = 5;
+	}
+	return ret;
 }
 
 void
@@ -136,7 +153,8 @@ ccw_device_sense_id_start(struct ccw_dev
 
 	memset (&cdev->private->senseid, 0, sizeof (struct senseid));
 	cdev->private->senseid.cu_type = 0xFFFF;
-	cdev->private->iretry = 3;
+	cdev->private->imask = 0x80;
+	cdev->private->iretry = 5;
 	ret = __ccw_device_sense_id_start(cdev);
 	if (ret && ret != -EBUSY)
 		ccw_device_sense_id_done(cdev, ret);
@@ -252,13 +270,14 @@ ccw_device_sense_id_irq(struct ccw_devic
 		ccw_device_sense_id_done(cdev, ret);
 		break;
 	case -EACCES:		/* channel is not operational. */
+		sch->lpm &= ~cdev->private->imask;
+		cdev->private->imask >>= 1;
+		cdev->private->iretry = 5;
+		/* fall through. */
 	case -EAGAIN:		/* try again. */
-		cdev->private->iretry--;
-		if (cdev->private->iretry > 0) {
-			ret = __ccw_device_sense_id_start(cdev);
-			if (ret == 0 || ret == -EBUSY)
-				break;
-		}
+		ret = __ccw_device_sense_id_start(cdev);
+		if (ret == 0 || ret == -EBUSY)
+			break;
 		/* fall through. */
 	default:		/* Sense ID failed. Try asking VM. */
 		if (MACHINE_IS_VM) {

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
