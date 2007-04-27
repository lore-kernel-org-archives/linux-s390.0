Return-Path: <linux-kernel-owner+w=401wt.eu-S1755865AbXD0OPw@vger.kernel.org>
Message-Id: <20070427140514.092516741@de.ibm.com>
References: <20070427140503.087958775@de.ibm.com>
Date: Fri, 27 Apr 2007 16:05:13 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 10/38] cio: Re-start path verification after aborting internal I/O.
Content-Disposition: inline; filename=108-cio-path-verify.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Stefan Bader <shbader@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Bader <shbader@de.ibm.com>

Path verification triggered by changes to the available CHPIDs will be
interrupted by another change but not re-started. This results in an
invalid path mask.
To solve this make sure to completely re-start path verification when
changing the available paths.

Signed-off-by: Stefan Bader <shbader@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/chsc.c |  108 ++++++++++++++++++++++++------------------------
 1 files changed, 54 insertions(+), 54 deletions(-)

Index: quilt-2.6/drivers/s390/cio/chsc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chsc.c	2007-04-27 16:04:54.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/chsc.c	2007-04-27 16:04:54.000000000 +0200
@@ -178,6 +178,38 @@
 	return ret;
 }
 
+static int check_for_io_on_path(struct subchannel *sch, int mask)
+{
+	int cc;
+
+	cc = stsch(sch->schid, &sch->schib);
+	if (cc)
+		return 0;
+	if (sch->schib.scsw.actl && sch->schib.pmcw.lpum == mask)
+		return 1;
+	return 0;
+}
+
+static void terminate_internal_io(struct subchannel *sch)
+{
+	if (cio_clear(sch)) {
+		/* Recheck device in case clear failed. */
+		sch->lpm = 0;
+		if (device_trigger_verify(sch) != 0) {
+			if(css_enqueue_subchannel_slow(sch->schid)) {
+				css_clear_subchannel_slow_list();
+				need_rescan = 1;
+			}
+		}
+		return;
+	}
+	/* Request retry of internal operation. */
+	device_set_intretry(sch);
+	/* Call handler. */
+	if (sch->driver && sch->driver->termination)
+		sch->driver->termination(&sch->dev);
+}
+
 static int
 s390_subchannel_remove_chpid(struct device *dev, void *data)
 {
@@ -208,37 +240,33 @@
 	if (sch->schib.pmcw.pim == 0x80)
 		goto out_unreg;
 
-	if ((sch->schib.scsw.actl & SCSW_ACTL_DEVACT) &&
-	    (sch->schib.scsw.actl & SCSW_ACTL_SCHACT) &&
-	    (sch->schib.pmcw.lpum == mask)) {
-		int cc;
-
-		cc = cio_clear(sch);
-		if (cc == -ENODEV)
+	if (check_for_io_on_path(sch, mask)) {
+		if (device_is_online(sch))
+			device_kill_io(sch);
+		else {
+			terminate_internal_io(sch);
+			/* Re-start path verification. */
+			if (sch->driver && sch->driver->verify)
+				sch->driver->verify(&sch->dev);
+		}
+	} else {
+		/* trigger path verification. */
+		if (sch->driver && sch->driver->verify)
+			sch->driver->verify(&sch->dev);
+		else if (sch->lpm == mask)
 			goto out_unreg;
-		/* Request retry of internal operation. */
-		device_set_intretry(sch);
-		/* Call handler. */
-		if (sch->driver && sch->driver->termination)
-			sch->driver->termination(&sch->dev);
-		goto out_unlock;
 	}
 
-	/* trigger path verification. */
-	if (sch->driver && sch->driver->verify)
-		sch->driver->verify(&sch->dev);
-	else if (sch->lpm == mask)
-		goto out_unreg;
-out_unlock:
 	spin_unlock_irq(sch->lock);
 	return 0;
+
 out_unreg:
-	spin_unlock_irq(sch->lock);
 	sch->lpm = 0;
 	if (css_enqueue_subchannel_slow(sch->schid)) {
 		css_clear_subchannel_slow_list();
 		need_rescan = 1;
 	}
+	spin_unlock_irq(sch->lock);
 	return 0;
 }
 
@@ -683,38 +711,6 @@
 	return rc;
 }
 
-static int check_for_io_on_path(struct subchannel *sch, int index)
-{
-	int cc;
-
-	cc = stsch(sch->schid, &sch->schib);
-	if (cc)
-		return 0;
-	if (sch->schib.scsw.actl && sch->schib.pmcw.lpum == (0x80 >> index))
-		return 1;
-	return 0;
-}
-
-static void terminate_internal_io(struct subchannel *sch)
-{
-	if (cio_clear(sch)) {
-		/* Recheck device in case clear failed. */
-		sch->lpm = 0;
-		if (device_trigger_verify(sch) != 0) {
-			if(css_enqueue_subchannel_slow(sch->schid)) {
-				css_clear_subchannel_slow_list();
-				need_rescan = 1;
-			}
-		}
-		return;
-	}
-	/* Request retry of internal operation. */
-	device_set_intretry(sch);
-	/* Call handler. */
-	if (sch->driver && sch->driver->termination)
-		sch->driver->termination(&sch->dev);
-}
-
 static void __s390_subchannel_vary_chpid(struct subchannel *sch,
 					 struct chp_id chpid, int on)
 {
@@ -741,13 +737,17 @@
 		}
 		sch->opm &= ~(0x80 >> chp);
 		sch->lpm &= ~(0x80 >> chp);
-		if (check_for_io_on_path(sch, chp)) {
+		if (check_for_io_on_path(sch, (0x80 >> chp))) {
 			if (device_is_online(sch))
 				/* Path verification is done after killing. */
 				device_kill_io(sch);
-			else
+			else {
 				/* Kill and retry internal I/O. */
 				terminate_internal_io(sch);
+				/* Re-start path verification. */
+				if (sch->driver && sch->driver->verify)
+					sch->driver->verify(&sch->dev);
+			}
 		} else if (!sch->lpm) {
 			if (device_trigger_verify(sch) != 0) {
 				if (css_enqueue_subchannel_slow(sch->schid)) {

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
