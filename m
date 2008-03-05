Return-Path: <linux-kernel-owner+w=401wt.eu-S934372AbYCEMC7@vger.kernel.org>
Message-Id: <20080305115713.799161805@de.ibm.com>
References: <20080305115432.691030908@de.ibm.com>
Date: Wed, 05 Mar 2008 12:54:36 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 04/10] dasd: let dasd erp matching recognize alias recovery
Content-Disposition: inline; filename=004-dasd-erp.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Stefan Weinhuber <wein@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Weinhuber <wein@de.ibm.com>

When a request fails that was started on an alias device then the
first recovery step is to retry it on the base device. If the
recovery request fails again with the same symptoms, the next step
should not be a simple retry, but should be a proper recovery based
on sense data, etc. To do so, the dasd recovery functions need to
recognize the alias recovery step in the erp chain by comparing
the start devices.

Signed-off-by: Stefan Weinhuber <wein@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd_3990_erp.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Index: quilt-2.6/drivers/s390/block/dasd_3990_erp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_3990_erp.c
+++ quilt-2.6/drivers/s390/block/dasd_3990_erp.c
@@ -2310,10 +2310,8 @@ static int
 dasd_3990_erp_error_match(struct dasd_ccw_req *cqr1, struct dasd_ccw_req *cqr2)
 {
 
-	/* check failed CCW */
-	if (cqr1->irb.scsw.cpa != cqr2->irb.scsw.cpa) {
-		//	return 0;	/* CCW doesn't match */
-	}
+	if (cqr1->startdev != cqr2->startdev)
+		return 0;
 
 	if (cqr1->irb.esw.esw0.erw.cons != cqr2->irb.esw.esw0.erw.cons)
 		return 0;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
