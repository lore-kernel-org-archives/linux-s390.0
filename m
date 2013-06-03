Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 3/9] dasd: process all requests in the device tasklet
Date: Mon,  3 Jun 2013 17:03:16 +0200
Message-Id: <1370271802-30019-4-git-send-email-schwidefsky@de.ibm.com>
In-Reply-To: <1370271802-30019-1-git-send-email-schwidefsky@de.ibm.com>
References: <1370271802-30019-1-git-send-email-schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Hannes Reinecke <hare@suse.de>, Stefan Weinhuber <wein@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Hannes Reinecke <hare@suse.de>

Originally the DASD device tasklet would process the entries on
the ccw_queue until the first non-final request was found.
Which was okay as long as all requests have the same retries and
expires parameter.
However, as we're now allowing to modify both it is possible to
have requests _after_ the first request which already have expired.
So we need to check all requests in the device tasklet.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Stefan Weinhuber <wein@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 drivers/s390/block/dasd.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 4985489..000e514 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1787,11 +1787,11 @@ static void __dasd_device_process_ccw_queue(struct dasd_device *device,
 	list_for_each_safe(l, n, &device->ccw_queue) {
 		cqr = list_entry(l, struct dasd_ccw_req, devlist);
 
-		/* Stop list processing at the first non-final request. */
+		/* Skip any non-final request. */
 		if (cqr->status == DASD_CQR_QUEUED ||
 		    cqr->status == DASD_CQR_IN_IO ||
 		    cqr->status == DASD_CQR_CLEAR_PENDING)
-			break;
+			continue;
 		if (cqr->status == DASD_CQR_ERROR) {
 			__dasd_device_recovery(device, cqr);
 		}
-- 
1.7.9.5
