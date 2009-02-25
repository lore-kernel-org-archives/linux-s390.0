Return-Path: <linux-kernel-owner+w=401wt.eu-S1763361AbZBYPZp@vger.kernel.org>
Message-Id: <20090225150834.201977804@de.ibm.com>
References: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:06:47 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 25/46] cio: Try harder to disable subchannel.
Content-Disposition: inline; filename=124-cio-sub-disable.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Acting upon the assumption that cio_disable_subchannel()
is only called when we really want to disable the subchannel
(a) remove the check for activity (it is already done in
    ccw_device_offline(), which is the place where it matters)
(b) collect pending status via tsch() and ignore it (it
    can't matter anymore since the subchannel will be disabled).

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/cio.c        |   18 ++++++++++--------
 drivers/s390/cio/device_fsm.c |    2 +-
 2 files changed, 11 insertions(+), 9 deletions(-)

Index: quilt-2.6/drivers/s390/cio/cio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.c
+++ quilt-2.6/drivers/s390/cio/cio.c
@@ -472,6 +472,7 @@ EXPORT_SYMBOL_GPL(cio_enable_subchannel)
 int cio_disable_subchannel(struct subchannel *sch)
 {
 	char dbf_txt[15];
+	int retry;
 	int ret;
 
 	CIO_TRACE_EVENT (2, "dissch");
@@ -482,16 +483,17 @@ int cio_disable_subchannel(struct subcha
 	if (cio_update_schib(sch))
 		return -ENODEV;
 
-	if (scsw_actl(&sch->schib.scsw) != 0)
-		/*
-		 * the disable function must not be called while there are
-		 *  requests pending for completion !
-		 */
-		return -EBUSY;
-
 	sch->config.ena = 0;
-	ret = cio_commit_config(sch);
 
+	for (retry = 0; retry < 3; retry++) {
+		ret = cio_commit_config(sch);
+		if (ret == -EBUSY) {
+			struct irb irb;
+			if (tsch(sch->schid, &irb) != 0)
+				break;
+		} else
+			break;
+	}
 	sprintf (dbf_txt, "ret:%d", ret);
 	CIO_TRACE_EVENT (2, dbf_txt);
 	return ret;
Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c
+++ quilt-2.6/drivers/s390/cio/device_fsm.c
@@ -1052,7 +1052,7 @@ ccw_device_offline_irq(struct ccw_device
 	sch = to_subchannel(cdev->dev.parent);
 	/*
 	 * An interrupt in state offline means a previous disable was not
-	 * successful. Try again.
+	 * successful - should not happen, but we try to disable again.
 	 */
 	cio_disable_subchannel(sch);
 }

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
