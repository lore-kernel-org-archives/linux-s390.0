Return-Path: <linux-kernel-owner+w=401wt.eu-S1753144AbXCZUx0@vger.kernel.org>
Message-Id: <20070326205251.297882867@de.ibm.com>
References: <20070326205225.438154546@de.ibm.com>
Date: Mon, 26 Mar 2007 22:52:29 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [patch 4/6] cio: Device status validity.
Content-Disposition: inline; filename=004-cio-devstatus.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Only accumulate device status field in irb if it is valid.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/cio/device_status.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/s390/cio/device_status.c
===================================================================
--- linux-2.6.orig/drivers/s390/cio/device_status.c
+++ linux-2.6/drivers/s390/cio/device_status.c
@@ -263,7 +263,11 @@ ccw_device_accumulate_irb(struct ccw_dev
 		cdev_irb->scsw.cpa = irb->scsw.cpa;
 	/* Accumulate device status, but not the device busy flag. */
 	cdev_irb->scsw.dstat &= ~DEV_STAT_BUSY;
-	cdev_irb->scsw.dstat |= irb->scsw.dstat;
+	/* dstat is not always valid. */
+	if (irb->scsw.stctl &
+	    (SCSW_STCTL_PRIM_STATUS | SCSW_STCTL_SEC_STATUS
+	     | SCSW_STCTL_INTER_STATUS | SCSW_STCTL_ALERT_STATUS))
+		cdev_irb->scsw.dstat |= irb->scsw.dstat;
 	/* Accumulate subchannel status. */
 	cdev_irb->scsw.cstat |= irb->scsw.cstat;
 	/* Copy residual count if it is valid. */

-- 
