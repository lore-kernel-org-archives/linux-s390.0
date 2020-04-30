Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61754 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729197AbgD3N4M (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Apr 2020 09:56:12 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 07/14] net/smc: multiple link support and LLC flow for smc_llc_do_confirm_rkey
Date: Thu, 30 Apr 2020 15:55:44 +0200
Message-Id: <20200430135551.26267-8-kgraul@linux.ibm.com>
In-Reply-To: <20200430135551.26267-1-kgraul@linux.ibm.com>
References: <20200430135551.26267-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Adapt smc_llc_do_confirm_rkey() to use the LLC flow and support the
rkeys of multiple links when the CONFIRM_RKEY LLC message is build.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.h |  2 --
 net/smc/smc_llc.c  | 65 ++++++++++++++++++++++++++++++----------------
 net/smc/smc_llc.h  |  2 +-
 3 files changed, 43 insertions(+), 26 deletions(-)

diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 31237c4c0d93..4e0dfb1d5804 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -123,8 +123,6 @@ struct smc_link {
 	struct delayed_work	llc_testlink_wrk; /* testlink worker */
 	struct completion	llc_testlink_resp; /* wait for rx of testlink */
 	int			llc_testlink_time; /* testlink interval */
-	struct completion	llc_confirm_rkey_resp; /* w4 rx of cnf rkey */
-	int			llc_confirm_rkey_resp_rc; /* rc from cnf rkey */
 	struct completion	llc_delete_rkey_resp; /* w4 rx of del rkey */
 	int			llc_delete_rkey_resp_rc; /* rc from del rkey */
 	struct mutex		llc_delete_rkey_mutex; /* serialize usage */
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 644e9ab0dec5..5db11f54b4cd 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -369,27 +369,44 @@ int smc_llc_send_confirm_link(struct smc_link *link,
 }
 
 /* send LLC confirm rkey request */
-static int smc_llc_send_confirm_rkey(struct smc_link *link,
+static int smc_llc_send_confirm_rkey(struct smc_link *send_link,
 				     struct smc_buf_desc *rmb_desc)
 {
 	struct smc_llc_msg_confirm_rkey *rkeyllc;
 	struct smc_wr_tx_pend_priv *pend;
 	struct smc_wr_buf *wr_buf;
-	int rc;
+	struct smc_link *link;
+	int i, rc, rtok_ix;
 
-	rc = smc_llc_add_pending_send(link, &wr_buf, &pend);
+	rc = smc_llc_add_pending_send(send_link, &wr_buf, &pend);
 	if (rc)
 		return rc;
 	rkeyllc = (struct smc_llc_msg_confirm_rkey *)wr_buf;
 	memset(rkeyllc, 0, sizeof(*rkeyllc));
 	rkeyllc->hd.common.type = SMC_LLC_CONFIRM_RKEY;
 	rkeyllc->hd.length = sizeof(struct smc_llc_msg_confirm_rkey);
+
+	rtok_ix = 1;
+	for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++) {
+		link = &send_link->lgr->lnk[i];
+		if (link->state == SMC_LNK_ACTIVE && link != send_link) {
+			rkeyllc->rtoken[rtok_ix].link_id = link->link_id;
+			rkeyllc->rtoken[rtok_ix].rmb_key =
+				htonl(rmb_desc->mr_rx[link->link_idx]->rkey);
+			rkeyllc->rtoken[rtok_ix].rmb_vaddr = cpu_to_be64(
+				(u64)sg_dma_address(
+					rmb_desc->sgt[link->link_idx].sgl));
+			rtok_ix++;
+		}
+	}
+	/* rkey of send_link is in rtoken[0] */
+	rkeyllc->rtoken[0].num_rkeys = rtok_ix - 1;
 	rkeyllc->rtoken[0].rmb_key =
-		htonl(rmb_desc->mr_rx[link->link_idx]->rkey);
+		htonl(rmb_desc->mr_rx[send_link->link_idx]->rkey);
 	rkeyllc->rtoken[0].rmb_vaddr = cpu_to_be64(
-		(u64)sg_dma_address(rmb_desc->sgt[link->link_idx].sgl));
+		(u64)sg_dma_address(rmb_desc->sgt[send_link->link_idx].sgl));
 	/* send llc message */
-	rc = smc_wr_tx_send(link, pend);
+	rc = smc_wr_tx_send(send_link, pend);
 	return rc;
 }
 
@@ -712,6 +729,7 @@ static void smc_llc_rx_response(struct smc_link *link,
 		break;
 	case SMC_LLC_ADD_LINK:
 	case SMC_LLC_CONFIRM_LINK:
+	case SMC_LLC_CONFIRM_RKEY:
 		/* assign responses to the local flow, we requested them */
 		smc_llc_flow_qentry_set(&link->lgr->llc_flow_lcl, qentry);
 		wake_up_interruptible(&link->lgr->llc_waiter);
@@ -720,11 +738,6 @@ static void smc_llc_rx_response(struct smc_link *link,
 		if (link->lgr->role == SMC_SERV)
 			smc_lgr_schedule_free_work_fast(link->lgr);
 		break;
-	case SMC_LLC_CONFIRM_RKEY:
-		link->llc_confirm_rkey_resp_rc = llc->raw.hdr.flags &
-						 SMC_LLC_FLAG_RKEY_NEG;
-		complete(&link->llc_confirm_rkey_resp);
-		break;
 	case SMC_LLC_CONFIRM_RKEY_CONT:
 		/* unused as long as we don't send this type of msg */
 		break;
@@ -837,7 +850,6 @@ void smc_llc_lgr_clear(struct smc_link_group *lgr)
 
 int smc_llc_link_init(struct smc_link *link)
 {
-	init_completion(&link->llc_confirm_rkey_resp);
 	init_completion(&link->llc_delete_rkey_resp);
 	mutex_init(&link->llc_delete_rkey_mutex);
 	init_completion(&link->llc_testlink_resp);
@@ -870,23 +882,30 @@ void smc_llc_link_clear(struct smc_link *link)
 	smc_wr_wakeup_tx_wait(link);
 }
 
-/* register a new rtoken at the remote peer */
-int smc_llc_do_confirm_rkey(struct smc_link *link,
+/* register a new rtoken at the remote peer (for all links) */
+int smc_llc_do_confirm_rkey(struct smc_link *send_link,
 			    struct smc_buf_desc *rmb_desc)
 {
-	int rc;
+	struct smc_link_group *lgr = send_link->lgr;
+	struct smc_llc_qentry *qentry = NULL;
+	int rc = 0;
 
-	/* protected by mutex smc_create_lgr_pending */
-	reinit_completion(&link->llc_confirm_rkey_resp);
-	rc = smc_llc_send_confirm_rkey(link, rmb_desc);
+	rc = smc_llc_flow_initiate(lgr, SMC_LLC_FLOW_RKEY);
 	if (rc)
 		return rc;
+	rc = smc_llc_send_confirm_rkey(send_link, rmb_desc);
+	if (rc)
+		goto out;
 	/* receive CONFIRM RKEY response from server over RoCE fabric */
-	rc = wait_for_completion_interruptible_timeout(
-			&link->llc_confirm_rkey_resp, SMC_LLC_WAIT_TIME);
-	if (rc <= 0 || link->llc_confirm_rkey_resp_rc)
-		return -EFAULT;
-	return 0;
+	qentry = smc_llc_wait(lgr, send_link, SMC_LLC_WAIT_TIME,
+			      SMC_LLC_CONFIRM_RKEY);
+	if (!qentry || (qentry->msg.raw.hdr.flags & SMC_LLC_FLAG_RKEY_NEG))
+		rc = -EFAULT;
+out:
+	if (qentry)
+		smc_llc_flow_qentry_del(&lgr->llc_flow_lcl);
+	smc_llc_flow_stop(lgr, &lgr->llc_flow_lcl);
+	return rc;
 }
 
 /* unregister an rtoken at the remote peer */
diff --git a/net/smc/smc_llc.h b/net/smc/smc_llc.h
index 637acf91ffb7..d82d8346b61e 100644
--- a/net/smc/smc_llc.h
+++ b/net/smc/smc_llc.h
@@ -59,7 +59,7 @@ int smc_llc_link_init(struct smc_link *link);
 void smc_llc_link_active(struct smc_link *link);
 void smc_llc_link_deleting(struct smc_link *link);
 void smc_llc_link_clear(struct smc_link *link);
-int smc_llc_do_confirm_rkey(struct smc_link *link,
+int smc_llc_do_confirm_rkey(struct smc_link *send_link,
 			    struct smc_buf_desc *rmb_desc);
 int smc_llc_do_delete_rkey(struct smc_link *link,
 			   struct smc_buf_desc *rmb_desc);
-- 
2.17.1
