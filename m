Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32398 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729204AbgD3N4O (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Apr 2020 09:56:14 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 12/14] net/smc: adapt SMC remote DELETE_RKEY processing to use the LLC flow
Date: Thu, 30 Apr 2020 15:55:49 +0200
Message-Id: <20200430135551.26267-13-kgraul@linux.ibm.com>
In-Reply-To: <20200430135551.26267-1-kgraul@linux.ibm.com>
References: <20200430135551.26267-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Use the LLC flow framework for the processing of DELETE_RKEY messages
that were received from the peer.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_llc.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index b7b5cc01b78e..e458207bde9e 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -601,31 +601,37 @@ static void smc_llc_rmt_conf_rkey(struct smc_link_group *lgr)
 	smc_llc_flow_qentry_del(&lgr->llc_flow_rmt);
 }
 
-static void smc_llc_rx_confirm_rkey_cont(struct smc_link *link,
-				      struct smc_llc_msg_confirm_rkey_cont *llc)
-{
-	/* ignore rtokens for other links, we have only one link */
-	llc->hd.flags |= SMC_LLC_FLAG_RESP;
-	smc_llc_send_message(link, llc);
-}
-
-static void smc_llc_rx_delete_rkey(struct smc_link *link,
-				   struct smc_llc_msg_delete_rkey *llc)
+/* process a delete_rkey request from peer, remote flow */
+static void smc_llc_rmt_delete_rkey(struct smc_link_group *lgr)
 {
+	struct smc_llc_msg_delete_rkey *llc;
+	struct smc_llc_qentry *qentry;
+	struct smc_link *link;
 	u8 err_mask = 0;
 	int i, max;
 
+	qentry = lgr->llc_flow_rmt.qentry;
+	llc = &qentry->msg.delete_rkey;
+	link = qentry->link;
+
 	max = min_t(u8, llc->num_rkeys, SMC_LLC_DEL_RKEY_MAX);
 	for (i = 0; i < max; i++) {
 		if (smc_rtoken_delete(link, llc->rkey[i]))
 			err_mask |= 1 << (SMC_LLC_DEL_RKEY_MAX - 1 - i);
 	}
-
 	if (err_mask) {
 		llc->hd.flags |= SMC_LLC_FLAG_RKEY_NEG;
 		llc->err_mask = err_mask;
 	}
+	llc->hd.flags |= SMC_LLC_FLAG_RESP;
+	smc_llc_send_message(link, &qentry->msg);
+	smc_llc_flow_qentry_del(&lgr->llc_flow_rmt);
+}
 
+static void smc_llc_rx_confirm_rkey_cont(struct smc_link *link,
+				      struct smc_llc_msg_confirm_rkey_cont *llc)
+{
+	/* ignore rtokens for other links, we have only one link */
 	llc->hd.flags |= SMC_LLC_FLAG_RESP;
 	smc_llc_send_message(link, llc);
 }
@@ -698,8 +704,13 @@ static void smc_llc_event_handler(struct smc_llc_qentry *qentry)
 		smc_llc_rx_confirm_rkey_cont(link, &llc->confirm_rkey_cont);
 		break;
 	case SMC_LLC_DELETE_RKEY:
-		smc_llc_rx_delete_rkey(link, &llc->delete_rkey);
-		break;
+		/* new request from remote, assign to remote flow */
+		if (smc_llc_flow_start(&lgr->llc_flow_rmt, qentry)) {
+			/* process here, does not wait for more llc msgs */
+			smc_llc_rmt_delete_rkey(lgr);
+			smc_llc_flow_stop(lgr, &lgr->llc_flow_rmt);
+		}
+		return;
 	}
 out:
 	kfree(qentry);
-- 
2.17.1
