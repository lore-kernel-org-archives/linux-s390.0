Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19770 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728919AbgD3N4N (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Apr 2020 09:56:13 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 11/14] net/smc: adapt SMC remote CONFIRM_RKEY processing to use the LLC flow
Date: Thu, 30 Apr 2020 15:55:48 +0200
Message-Id: <20200430135551.26267-12-kgraul@linux.ibm.com>
In-Reply-To: <20200430135551.26267-1-kgraul@linux.ibm.com>
References: <20200430135551.26267-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Use the LLC flow framework for the processing of CONFIRM_RKEY messages
that were received from the peer.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_llc.c | 56 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 15 deletions(-)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 4945abbad111..b7b5cc01b78e 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -105,6 +105,7 @@ struct smc_llc_msg_confirm_rkey_cont {	/* type 0x08 */
 };
 
 #define SMC_LLC_DEL_RKEY_MAX	8
+#define SMC_LLC_FLAG_RKEY_RETRY	0x10
 #define SMC_LLC_FLAG_RKEY_NEG	0x20
 
 struct smc_llc_msg_delete_rkey {	/* type 0x09 */
@@ -563,21 +564,41 @@ static void smc_llc_rx_delete_link(struct smc_link *link,
 	smc_lgr_terminate_sched(lgr);
 }
 
-static void smc_llc_rx_confirm_rkey(struct smc_link *link,
-				    struct smc_llc_msg_confirm_rkey *llc)
+/* process a confirm_rkey request from peer, remote flow */
+static void smc_llc_rmt_conf_rkey(struct smc_link_group *lgr)
 {
-	int rc;
-
-	rc = smc_rtoken_add(link,
-			    llc->rtoken[0].rmb_vaddr,
-			    llc->rtoken[0].rmb_key);
-
-	/* ignore rtokens for other links, we have only one link */
-
+	struct smc_llc_msg_confirm_rkey *llc;
+	struct smc_llc_qentry *qentry;
+	struct smc_link *link;
+	int num_entries;
+	int rk_idx;
+	int i;
+
+	qentry = lgr->llc_flow_rmt.qentry;
+	llc = &qentry->msg.confirm_rkey;
+	link = qentry->link;
+
+	num_entries = llc->rtoken[0].num_rkeys;
+	/* first rkey entry is for receiving link */
+	rk_idx = smc_rtoken_add(link,
+				llc->rtoken[0].rmb_vaddr,
+				llc->rtoken[0].rmb_key);
+	if (rk_idx < 0)
+		goto out_err;
+
+	for (i = 1; i <= min_t(u8, num_entries, SMC_LLC_RKEYS_PER_MSG - 1); i++)
+		smc_rtoken_set2(lgr, rk_idx, llc->rtoken[i].link_id,
+				llc->rtoken[i].rmb_vaddr,
+				llc->rtoken[i].rmb_key);
+	/* max links is 3 so there is no need to support conf_rkey_cont msgs */
+	goto out;
+out_err:
+	llc->hd.flags |= SMC_LLC_FLAG_RKEY_NEG;
+	llc->hd.flags |= SMC_LLC_FLAG_RKEY_RETRY;
+out:
 	llc->hd.flags |= SMC_LLC_FLAG_RESP;
-	if (rc < 0)
-		llc->hd.flags |= SMC_LLC_FLAG_RKEY_NEG;
-	smc_llc_send_message(link, llc);
+	smc_llc_send_message(link, &qentry->msg);
+	smc_llc_flow_qentry_del(&lgr->llc_flow_rmt);
 }
 
 static void smc_llc_rx_confirm_rkey_cont(struct smc_link *link,
@@ -666,8 +687,13 @@ static void smc_llc_event_handler(struct smc_llc_qentry *qentry)
 		smc_llc_rx_delete_link(link, &llc->delete_link);
 		break;
 	case SMC_LLC_CONFIRM_RKEY:
-		smc_llc_rx_confirm_rkey(link, &llc->confirm_rkey);
-		break;
+		/* new request from remote, assign to remote flow */
+		if (smc_llc_flow_start(&lgr->llc_flow_rmt, qentry)) {
+			/* process here, does not wait for more llc msgs */
+			smc_llc_rmt_conf_rkey(lgr);
+			smc_llc_flow_stop(lgr, &lgr->llc_flow_rmt);
+		}
+		return;
 	case SMC_LLC_CONFIRM_RKEY_CONT:
 		smc_llc_rx_confirm_rkey_cont(link, &llc->confirm_rkey_cont);
 		break;
-- 
2.17.1
