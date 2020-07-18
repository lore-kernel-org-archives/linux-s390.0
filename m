Return-Path: <netdev-owner@vger.kernel.org>
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net v2 05/10] net/smc: drop out-of-flow llc response messages
Date: Sat, 18 Jul 2020 15:06:13 +0200
Message-Id: <20200718130618.16724-6-kgraul@linux.ibm.com>
In-Reply-To: <20200718130618.16724-1-kgraul@linux.ibm.com>
References: <20200718130618.16724-1-kgraul@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

To be save from unexpected or late llc response messages check if the
arrived message fits to the current flow type and drop out-of-flow
messages. And drop it when there is already a response assigned to
the flow.

Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
Fixes: ef79d439cd12 ("net/smc: process llc responses in tasklet context")
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_llc.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 58f4da2e0cc7..78704f03e72a 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -1587,6 +1587,8 @@ static void smc_llc_event_work(struct work_struct *work)
 static void smc_llc_rx_response(struct smc_link *link,
 				struct smc_llc_qentry *qentry)
 {
+	enum smc_llc_flowtype flowtype = link->lgr->llc_flow_lcl.type;
+	struct smc_llc_flow *flow = &link->lgr->llc_flow_lcl;
 	u8 llc_type = qentry->msg.raw.hdr.common.type;
 
 	switch (llc_type) {
@@ -1595,15 +1597,20 @@ static void smc_llc_rx_response(struct smc_link *link,
 			complete(&link->llc_testlink_resp);
 		break;
 	case SMC_LLC_ADD_LINK:
-	case SMC_LLC_DELETE_LINK:
-	case SMC_LLC_CONFIRM_LINK:
 	case SMC_LLC_ADD_LINK_CONT:
+	case SMC_LLC_CONFIRM_LINK:
+		if (flowtype != SMC_LLC_FLOW_ADD_LINK || flow->qentry)
+			break;	/* drop out-of-flow response */
+		goto assign;
+	case SMC_LLC_DELETE_LINK:
+		if (flowtype != SMC_LLC_FLOW_DEL_LINK || flow->qentry)
+			break;	/* drop out-of-flow response */
+		goto assign;
 	case SMC_LLC_CONFIRM_RKEY:
 	case SMC_LLC_DELETE_RKEY:
-		/* assign responses to the local flow, we requested them */
-		smc_llc_flow_qentry_set(&link->lgr->llc_flow_lcl, qentry);
-		wake_up(&link->lgr->llc_msg_waiter);
-		return;
+		if (flowtype != SMC_LLC_FLOW_RKEY || flow->qentry)
+			break;	/* drop out-of-flow response */
+		goto assign;
 	case SMC_LLC_CONFIRM_RKEY_CONT:
 		/* not used because max links is 3 */
 		break;
@@ -1612,6 +1619,11 @@ static void smc_llc_rx_response(struct smc_link *link,
 		break;
 	}
 	kfree(qentry);
+	return;
+assign:
+	/* assign responses to the local flow, we requested them */
+	smc_llc_flow_qentry_set(&link->lgr->llc_flow_lcl, qentry);
+	wake_up(&link->lgr->llc_msg_waiter);
 }
 
 static void smc_llc_enqueue(struct smc_link *link, union smc_llc_msg *llc)
-- 
2.17.1
