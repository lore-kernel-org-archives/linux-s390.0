Return-Path: <linux-kernel-owner+w=401wt.eu-S1760201AbYEOPEo@vger.kernel.org>
Message-Id: <20080515150009.353727628@de.ibm.com>
References: <20080515145705.188435204@de.ibm.com>
Date: Thu, 15 May 2008 16:57:13 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 08/11] dasd: fix timeout handling in interrupt handler
Content-Disposition: inline; filename=008-dasd-timeout.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Stefan Weinhuber <wein@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Weinhuber <wein@de.ibm.com>

When the dasd_int_handler is called with an error code instead of
an irb, the associated request should be restarted. This handling
was missing from the -ETIMEDOUT case. In fact it should be done in
any case.

Signed-off-by: Stefan Weinhuber <wein@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: quilt-2.6/drivers/s390/block/dasd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd.c
+++ quilt-2.6/drivers/s390/block/dasd.c
@@ -925,6 +925,8 @@ static void dasd_handle_killed_request(s
 	struct dasd_ccw_req *cqr;
 	struct dasd_device *device;
 
+	if (!intparm)
+		return;
 	cqr = (struct dasd_ccw_req *) intparm;
 	if (cqr->status != DASD_CQR_IN_IO) {
 		MESSAGE(KERN_DEBUG,
@@ -976,17 +978,16 @@ void dasd_int_handler(struct ccw_device 
 	if (IS_ERR(irb)) {
 		switch (PTR_ERR(irb)) {
 		case -EIO:
-			dasd_handle_killed_request(cdev, intparm);
 			break;
 		case -ETIMEDOUT:
 			printk(KERN_WARNING"%s(%s): request timed out\n",
 			       __func__, cdev->dev.bus_id);
-			//FIXME - dasd uses own timeout interface...
 			break;
 		default:
 			printk(KERN_WARNING"%s(%s): unknown error %ld\n",
 			       __func__, cdev->dev.bus_id, PTR_ERR(irb));
 		}
+		dasd_handle_killed_request(cdev, intparm);
 		return;
 	}
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
