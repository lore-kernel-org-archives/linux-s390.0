Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17134 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726249AbgHMP32 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 13 Aug 2020 11:29:28 -0400
From: Steffen Maier <maier@linux.ibm.com>
Subject: [PATCH] zfcp: fix use-after-free in request timeout handlers
Date: Thu, 13 Aug 2020 17:28:56 +0200
Message-Id: <20200813152856.50088-1-maier@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, Benjamin Block <bblock@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Steffen Maier <maier@linux.ibm.com>, stable@vger.kernel.org

Before v4.15 commit 75492a51568b ("s390/scsi: Convert timers to use
timer_setup()"), we intentionally only passed zfcp_adapter as context
argument to zfcp_fsf_request_timeout_handler(). Since we only trigger
adapter recovery, it was unnecessary to sync against races between timeout
and (late) completion.
Likewise, we only passed zfcp_erp_action as context argument to
zfcp_erp_timeout_handler(). Since we only wakeup an ERP action, it was
unnecessary to sync against races between timeout and (late) completion.

Meanwhile the timeout handlers get timer_list as context argument
and do a timer-specific container-of to zfcp_fsf_req which can have
been freed.

Fix it by making sure that any request timeout handlers, that might
just have started before del_timer(), are completed by using
del_timer_sync() instead. This ensures the request free happens
afterwards.

Space time diagram of potential use-after-free:

Basic idea is to have 2 or more pending requests whose timeouts run
out at almost the same time.

req 1 timeout     ERP thread        req 2 timeout
----------------  ----------------  ---------------------------------------
zfcp_fsf_request_timeout_handler
fsf_req = from_timer(fsf_req, t, timer)
adapter = fsf_req->adapter
zfcp_qdio_siosl(adapter)
zfcp_erp_adapter_reopen(adapter,...)
                  zfcp_erp_strategy
                  ...
                  zfcp_fsf_req_dismiss_all
                  list_for_each_entry_safe
                    zfcp_fsf_req_complete 1
                    del_timer 1
                    zfcp_fsf_req_free 1
                    zfcp_fsf_req_complete 2
                                    zfcp_fsf_request_timeout_handler
                    del_timer 2
                                    fsf_req = from_timer(fsf_req, t, timer)
                    zfcp_fsf_req_free 2
                                    adapter = fsf_req->adapter
                                              ^^^^^^^ already freed

Suggested-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Julian Wiedmann <jwi@linux.ibm.com>
Fixes: 75492a51568b ("s390/scsi: Convert timers to use timer_setup()")
Cc: <stable@vger.kernel.org> #4.15+
Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_fsf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index c795f22249d8..140186fe1d1e 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -434,7 +434,7 @@ static void zfcp_fsf_req_complete(struct zfcp_fsf_req *req)
 		return;
 	}
 
-	del_timer(&req->timer);
+	del_timer_sync(&req->timer);
 	zfcp_fsf_protstatus_eval(req);
 	zfcp_fsf_fsfstatus_eval(req);
 	req->handler(req);
@@ -867,7 +867,7 @@ static int zfcp_fsf_req_send(struct zfcp_fsf_req *req)
 	req->qdio_req.qdio_outb_usage = atomic_read(&qdio->req_q_free);
 	req->issued = get_tod_clock();
 	if (zfcp_qdio_send(qdio, &req->qdio_req)) {
-		del_timer(&req->timer);
+		del_timer_sync(&req->timer);
 		/* lookup request again, list might have changed */
 		zfcp_reqlist_find_rm(adapter->req_list, req_id);
 		zfcp_erp_adapter_reopen(adapter, 0, "fsrs__1");
-- 
2.17.1
