From: Steffen Maier <maier@linux.vnet.ibm.com>
Subject: [PATCH 3/3] zfcp: drop open coded assignments of timer_list.function
Date: Wed,  8 Nov 2017 15:17:09 +0100
Message-ID: <20171108141709.79074-4-maier@linux.vnet.ibm.com>
References: <20171108141709.79074-1-maier@linux.vnet.ibm.com>
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <20171108141709.79074-1-maier@linux.vnet.ibm.com>
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Kees Cook <keescook@chromium.org>
Cc: linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Steffen Maier <maier@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The majority of requests is regular SCSI I/O on the hot path.
Since these use a timeout owned by the block layer, zfcp does not use
zfcp_fsf_req.timer. Hence, the very early unconditional and even
incomplete (handler function yet unknown) timer initialization in
zfcp_fsf_req_create() is not necessary.

Instead defer the timer initialization to when we know zfcp needs to use
its own request timeout in zfcp_fsf_start_timer() and
zfcp_fsf_start_erp_timer(). At that point in time we also know the handler
function. So drop open coded assignments of timer_list.function and
instead use the new timer API wrapper function timer_setup().

This way, we don't have to touch zfcp again, when the cast macro
TIMER_FUNC_TYPE gets removed again after the global conversion to
timer_setup() is complete.

Depends-on: v4.14-rc3 commit 686fef928bba ("timer: Prepare to change timer callback argument type")
Signed-off-by: Steffen Maier <maier@linux.vnet.ibm.com>
Reviewed-by: Jens Remus <jremus@linux.vnet.ibm.com>
---
 drivers/s390/scsi/zfcp_fsf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index 51b81c0a0652..c8e368f0f299 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -34,7 +34,7 @@ static void zfcp_fsf_request_timeout_handler(struct timer_list *t)
 static void zfcp_fsf_start_timer(struct zfcp_fsf_req *fsf_req,
 				 unsigned long timeout)
 {
-	fsf_req->timer.function = (TIMER_FUNC_TYPE)zfcp_fsf_request_timeout_handler;
+	timer_setup(&fsf_req->timer, zfcp_fsf_request_timeout_handler, 0);
 	fsf_req->timer.expires = jiffies + timeout;
 	add_timer(&fsf_req->timer);
 }
@@ -42,7 +42,7 @@ static void zfcp_fsf_start_timer(struct zfcp_fsf_req *fsf_req,
 static void zfcp_fsf_start_erp_timer(struct zfcp_fsf_req *fsf_req)
 {
 	BUG_ON(!fsf_req->erp_action);
-	fsf_req->timer.function = (TIMER_FUNC_TYPE)zfcp_erp_timeout_handler;
+	timer_setup(&fsf_req->timer, zfcp_erp_timeout_handler, 0);
 	fsf_req->timer.expires = jiffies + 30 * HZ;
 	add_timer(&fsf_req->timer);
 }
@@ -692,7 +692,6 @@ static struct zfcp_fsf_req *zfcp_fsf_req_create(struct zfcp_qdio *qdio,
 		adapter->req_no++;
 
 	INIT_LIST_HEAD(&req->list);
-	timer_setup(&req->timer, NULL, 0);
 	init_completion(&req->completion);
 
 	req->adapter = adapter;
-- 
2.13.5
