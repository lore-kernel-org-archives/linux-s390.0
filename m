Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50222 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727055AbgGRNGy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 18 Jul 2020 09:06:54 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net v2 07/10] net/smc: fix handling of delete link requests
Date: Sat, 18 Jul 2020 15:06:15 +0200
Message-Id: <20200718130618.16724-8-kgraul@linux.ibm.com>
In-Reply-To: <20200718130618.16724-1-kgraul@linux.ibm.com>
References: <20200718130618.16724-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

As smc client the delete link requests are assigned to the flow when
_any_ flow is active. This may break other flows that do not expect
delete link requests during their handling. Fix that by assigning the
request only when an add link flow is active. With that fix the code
for smc client and smc server is the same, so remove the separate
handling.

Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
Fixes: 9ec6bf19ec8b ("net/smc: llc_del_link_work and use the LLC flow for delete link")
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_llc.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 30da040ab5b6..fa8cd57a9b32 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -1544,28 +1544,13 @@ static void smc_llc_event_handler(struct smc_llc_qentry *qentry)
 		}
 		break;
 	case SMC_LLC_DELETE_LINK:
-		if (lgr->role == SMC_CLNT) {
-			/* server requests to delete this link, send response */
-			if (lgr->llc_flow_lcl.type != SMC_LLC_FLOW_NONE) {
-				/* DEL LINK REQ during ADD LINK SEQ */
-				smc_llc_flow_qentry_set(&lgr->llc_flow_lcl,
-							qentry);
-				wake_up(&lgr->llc_msg_waiter);
-			} else if (smc_llc_flow_start(&lgr->llc_flow_lcl,
-						      qentry)) {
-				schedule_work(&lgr->llc_del_link_work);
-			}
-		} else {
-			if (lgr->llc_flow_lcl.type == SMC_LLC_FLOW_ADD_LINK &&
-			    !lgr->llc_flow_lcl.qentry) {
-				/* DEL LINK REQ during ADD LINK SEQ */
-				smc_llc_flow_qentry_set(&lgr->llc_flow_lcl,
-							qentry);
-				wake_up(&lgr->llc_msg_waiter);
-			} else if (smc_llc_flow_start(&lgr->llc_flow_lcl,
-						      qentry)) {
-				schedule_work(&lgr->llc_del_link_work);
-			}
+		if (lgr->llc_flow_lcl.type == SMC_LLC_FLOW_ADD_LINK &&
+		    !lgr->llc_flow_lcl.qentry) {
+			/* DEL LINK REQ during ADD LINK SEQ */
+			smc_llc_flow_qentry_set(&lgr->llc_flow_lcl, qentry);
+			wake_up(&lgr->llc_msg_waiter);
+		} else if (smc_llc_flow_start(&lgr->llc_flow_lcl, qentry)) {
+			schedule_work(&lgr->llc_del_link_work);
 		}
 		return;
 	case SMC_LLC_CONFIRM_RKEY:
-- 
2.17.1
