Return-Path: <linux-kernel-owner+w=401wt.eu-S932273AbZHNL05@vger.kernel.org>
Message-Id: <20090814112614.671701262@de.ibm.com>
References: <20090814112517.982007860@de.ibm.com>
Date: Fri, 14 Aug 2009 13:25:26 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 09/34] dasd: fail requests when device state is less then ready
Content-Disposition: inline; filename=108-dasd-fail-request.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Weinhuber <wein@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Weinhuber <wein@de.ibm.com>

A DASD device that is not ready or online has no defined disk layout,
so all requests that arrive in such a state need to be returned as
failed.

Signed-off-by: Stefan Weinhuber <wein@de.ibm.com>

---

 drivers/s390/block/dasd.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: quilt-2.6/drivers/s390/block/dasd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd.c
+++ quilt-2.6/drivers/s390/block/dasd.c
@@ -1699,8 +1699,11 @@ static void __dasd_process_request_queue
 	 * for that. State DASD_STATE_ONLINE is normal block device
 	 * operation.
 	 */
-	if (basedev->state < DASD_STATE_READY)
+	if (basedev->state < DASD_STATE_READY) {
+		while ((req = blk_fetch_request(block->request_queue)))
+			__blk_end_request_all(req, -EIO);
 		return;
+	}
 	/* Now we try to fetch requests from the request queue */
 	while (!blk_queue_plugged(queue) && (req = blk_peek_request(queue))) {
 		if (basedev->features & DASD_FEATURE_READONLY &&

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
