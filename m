Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 1/9] dasd: Clarify comment
Date: Mon,  3 Jun 2013 17:03:14 +0200
Message-Id: <1370271802-30019-2-git-send-email-schwidefsky@de.ibm.com>
In-Reply-To: <1370271802-30019-1-git-send-email-schwidefsky@de.ibm.com>
References: <1370271802-30019-1-git-send-email-schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Hannes Reinecke <hare@suse.de>, Stefan Weinhuber <wein@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Hannes Reinecke <hare@suse.de>

dasd_cancel_req will never return 1, only 0.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Stefan Weinhuber <wein@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 drivers/s390/block/dasd.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index d72a9216e..4985489 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -2402,8 +2402,7 @@ int dasd_sleep_on_immediatly(struct dasd_ccw_req *cqr)
  * Cancels a request that was started with dasd_sleep_on_req.
  * This is useful to timeout requests. The request will be
  * terminated if it is currently in i/o.
- * Returns 1 if the request has been terminated.
- *	   0 if there was no need to terminate the request (not started yet)
+ * Returns 0 if request termination was successful
  *	   negative error code if termination failed
  * Cancellation of a request is an asynchronous operation! The calling
  * function has to wait until the request is properly returned via callback.
@@ -2440,7 +2439,6 @@ int dasd_cancel_req(struct dasd_ccw_req *cqr)
 	return rc;
 }
 
-
 /*
  * SECTION: Operations of the dasd_block layer.
  */
-- 
1.7.9.5
