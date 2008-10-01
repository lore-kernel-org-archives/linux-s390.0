Return-Path: <linux-kernel-owner+w=401wt.eu-S1755031AbYJAI73@vger.kernel.org>
Message-Id: <20081001084130.116866217@de.ibm.com>
References: <20081001083317.782967473@de.ibm.com>
Date: Wed, 01 Oct 2008 10:33:36 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 19/21] dasd: fix message flood for unsolicited interrupts
Content-Disposition: inline; filename=118-dasd-flooding.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Haberland <stefan.haberland@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Haberland <stefan.haberland@de.ibm.com>

In the unsolicited interupt handler fake IRBs from CIO have to be
ignored because there is nothing to do. 
The function dump_sense should not be called if there is no sense 
data available.

Signed-off-by: Stefan Haberland <stefan.haberland@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd_eckd.c |   25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

Index: quilt-2.6/drivers/s390/block/dasd_eckd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_eckd.c
+++ quilt-2.6/drivers/s390/block/dasd_eckd.c
@@ -1501,12 +1501,27 @@ static void dasd_eckd_handle_unsolicited
 		return;
 	}
 
-	/* just report other unsolicited interrupts */
-	DEV_MESSAGE(KERN_DEBUG, device, "%s",
-		    "unsolicited interrupt received");
-	device->discipline->dump_sense(device, NULL, irb);
-	dasd_schedule_device_bh(device);
+	if ((irb->scsw.cmd.cc == 1) &&
+	    (irb->scsw.cmd.fctl & SCSW_FCTL_START_FUNC) &&
+	    (irb->scsw.cmd.actl & SCSW_ACTL_START_PEND) &&
+	    (irb->scsw.cmd.stctl & SCSW_STCTL_STATUS_PEND)) {
+		/* fake irb do nothing, they are handled elsewhere */
+		dasd_schedule_device_bh(device);
+		return;
+	}
 
+	if (!(irb->esw.esw0.erw.cons)) {
+		/* just report other unsolicited interrupts */
+		DEV_MESSAGE(KERN_ERR, device, "%s",
+			    "unsolicited interrupt received");
+	} else {
+		DEV_MESSAGE(KERN_ERR, device, "%s",
+			    "unsolicited interrupt received "
+			    "(sense available)");
+		device->discipline->dump_sense(device, NULL, irb);
+	}
+
+	dasd_schedule_device_bh(device);
 	return;
 };
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
