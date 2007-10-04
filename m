Return-Path: <linux-kernel-owner+w=401wt.eu-S1759993AbXJDLbk@vger.kernel.org>
Message-Id: <20071004112827.288713172@de.ibm.com>
References: <20071004112706.574737175@de.ibm.com>
Date: Thu, 04 Oct 2007 13:27:16 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 10/34] cio: Disable channel measurements (cmf) on shutdown/reboot.
Content-Disposition: inline; filename=010-cio-cmf-disable.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Disable channel measurements for all ccw devices via the ccw bus's
shutdown method. Clear residual cmf related information that may be
in the schib when setting up a new subchannel.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/cio.c    |    5 +++++
 drivers/s390/cio/device.c |    2 ++
 2 files changed, 7 insertions(+)

Index: quilt-2.6/drivers/s390/cio/cio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.c
+++ quilt-2.6/drivers/s390/cio/cio.c
@@ -619,6 +619,11 @@ cio_validate_subchannel (struct subchann
 	sch->schib.pmcw.ena = 0;
 	if ((sch->lpm & (sch->lpm - 1)) != 0)
 		sch->schib.pmcw.mp = 1;	/* multipath mode */
+	/* clean up possible residual cmf stuff */
+	sch->schib.pmcw.mme = 0;
+	sch->schib.pmcw.mbfc = 0;
+	sch->schib.pmcw.mbi = 0;
+	sch->schib.mba = 0;
 	return 0;
 out:
 	if (!cio_is_console(schid))
Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c
+++ quilt-2.6/drivers/s390/cio/device.c
@@ -21,6 +21,7 @@
 #include <asm/ccwdev.h>
 #include <asm/cio.h>
 #include <asm/param.h>		/* HZ */
+#include <asm/cmb.h>
 
 #include "cio.h"
 #include "cio_debug.h"
@@ -1440,6 +1441,7 @@ static void ccw_device_shutdown(struct d
 	cdev = to_ccwdev(dev);
 	if (cdev->drv && cdev->drv->shutdown)
 		cdev->drv->shutdown(cdev);
+	disable_cmf(cdev);
 }
 
 struct bus_type ccw_bus_type = {

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
