Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50446 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726847AbgIJTta (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Sep 2020 15:49:30 -0400
From: Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH 2/2] zfcp: clarify access to erp_action in zfcp_fsf_req_complete()
Date: Thu, 10 Sep 2020 21:49:16 +0200
Message-Id: <c500eac301fcbba5af942bbd200f2d6b14e46994.1599765652.git.bblock@linux.ibm.com>
In-Reply-To: <cover.1599765652.git.bblock@linux.ibm.com>
References: <cover.1599765652.git.bblock@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Julian Wiedmann <jwi@linux.ibm.com>, Benjamin Block <bblock@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

While reviewing
commit 936e6b85da04 ("scsi: zfcp: Fix panic on ERP timeout for previously
dismissed ERP action"),
I stumbled over zfcp_fsf_req_complete() and wondered whether it has
similar issues wrt concurrent modification of req->erp_action
by zfcp_erp_strategy_check_fsfreq().

But a closer look shows that both its two callers
[zfcp_fsf_reqid_check(), zfcp_fsf_req_dismiss_all()] remove the request
from the adapter's req_list under the req_list's lock.
Hence we can trust that if zfcp_erp_strategy_check_fsfreq() concurrently
looks up the corresponding req_id, it won't find this request and is thus
unable to modify it while it's being processed by zfcp_fsf_req_complete().

Add a code comment that hopefully makes this easier for future readers,
and condense the two accesses to ->erp_action that made me trip over
this code path in the first place.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_fsf.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index c795f22249d8..d9de26157da2 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -426,9 +426,14 @@ static void zfcp_fsf_protstatus_eval(struct zfcp_fsf_req *req)
  * or it has been dismissed due to a queue shutdown, this function
  * is called to process the completion status and trigger further
  * events related to the FSF request.
+ * Caller must ensure that the request has been removed from
+ * adapter->req_list, to protect against concurrent modification
+ * by zfcp_erp_strategy_check_fsfreq().
  */
 static void zfcp_fsf_req_complete(struct zfcp_fsf_req *req)
 {
+	struct zfcp_erp_action *erp_action;
+
 	if (unlikely(zfcp_fsf_req_is_status_read_buffer(req))) {
 		zfcp_fsf_status_read_handler(req);
 		return;
@@ -439,8 +444,9 @@ static void zfcp_fsf_req_complete(struct zfcp_fsf_req *req)
 	zfcp_fsf_fsfstatus_eval(req);
 	req->handler(req);
 
-	if (req->erp_action)
-		zfcp_erp_notify(req->erp_action, 0);
+	erp_action = req->erp_action;
+	if (erp_action)
+		zfcp_erp_notify(erp_action, 0);
 
 	if (likely(req->status & ZFCP_STATUS_FSFREQ_CLEANUP))
 		zfcp_fsf_req_free(req);
-- 
2.26.2
