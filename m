Return-Path: <linux-kernel-owner+w=401wt.eu-S932573AbYEOPGV@vger.kernel.org>
Message-Id: <20080515150007.550577887@de.ibm.com>
References: <20080515145705.188435204@de.ibm.com>
Date: Thu, 15 May 2008 16:57:06 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 01/11] cio: Remove CCW_CMD_SUSPEND_RECONN in front of CCW_CMD_SET_PGID.
Content-Disposition: inline; filename=001-cio-reconn.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Michael Ernst <mernst@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Ernst <mernst@de.ibm.com>

CCW_CMD_SUSPEND_RECONN causes a system hang if the cable of a
reserved DASD is disconnected and connected again.

Signed-off-by: Michael Ernst <mernst@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device_pgid.c |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

Index: quilt-2.6/drivers/s390/cio/device_pgid.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_pgid.c
+++ quilt-2.6/drivers/s390/cio/device_pgid.c
@@ -243,16 +243,10 @@ __ccw_device_do_pgid(struct ccw_device *
 	/* Setup sense path group id channel program. */
 	cdev->private->pgid[0].inf.fc = func;
 	ccw = cdev->private->iccws;
-	if (!cdev->private->flags.pgid_single) {
-		cdev->private->pgid[0].inf.fc |= SPID_FUNC_MULTI_PATH;
-		ccw->cmd_code = CCW_CMD_SUSPEND_RECONN;
-		ccw->cda = 0;
-		ccw->count = 0;
-		ccw->flags = CCW_FLAG_SLI | CCW_FLAG_CC;
-		ccw++;
-	} else
+	if (cdev->private->flags.pgid_single)
 		cdev->private->pgid[0].inf.fc |= SPID_FUNC_SINGLE_PATH;
-
+	else
+		cdev->private->pgid[0].inf.fc |= SPID_FUNC_MULTI_PATH;
 	ccw->cmd_code = CCW_CMD_SET_PGID;
 	ccw->cda = (__u32) __pa (&cdev->private->pgid[0]);
 	ccw->count = sizeof (struct pgid);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
