Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 7/9] block: check for timeout function in blk_rq_timed_out()
Date: Mon,  3 Jun 2013 17:03:20 +0200
Message-Id: <1370271802-30019-8-git-send-email-schwidefsky@de.ibm.com>
In-Reply-To: <1370271802-30019-1-git-send-email-schwidefsky@de.ibm.com>
References: <1370271802-30019-1-git-send-email-schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Hannes Reinecke <hare@suse.de>, Stefan Weinhuber <wein@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Hannes Reinecke <hare@suse.de>

rq_timed_out_fn might have been unset while the request
was in flight, so we need to check for it in blk_rq_timed_out().

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Stefan Weinhuber <wein@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 block/blk-timeout.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 6e4744c..65f1035 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -82,9 +82,10 @@ void blk_delete_timer(struct request *req)
 static void blk_rq_timed_out(struct request *req)
 {
 	struct request_queue *q = req->q;
-	enum blk_eh_timer_return ret;
+	enum blk_eh_timer_return ret = BLK_EH_RESET_TIMER;
 
-	ret = q->rq_timed_out_fn(req);
+	if (q->rq_timed_out_fn)
+		ret = q->rq_timed_out_fn(req);
 	switch (ret) {
 	case BLK_EH_HANDLED:
 		__blk_complete_request(req);
-- 
1.7.9.5
