Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4612 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727121AbgEBMgR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 2 May 2020 08:36:17 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 03/13] net/smc: final part of add link processing as SMC client
Date: Sat,  2 May 2020 14:35:42 +0200
Message-Id: <20200502123552.17204-4-kgraul@linux.ibm.com>
In-Reply-To: <20200502123552.17204-1-kgraul@linux.ibm.com>
References: <20200502123552.17204-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

This patch finalizes the ADD_LINK processing of new links. Receive the
CONFIRM_LINK request from peer, complete the link initialization,
register all used buffers with the IB device and finally send the
CONFIRM_LINK response, which completes the ADD_LINK processing.
And activate smc_llc_cli_add_link() in af_smc.c.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c  |  2 +-
 net/smc/smc_llc.c | 62 ++++++++++++++++++++++++++++++++++++++++++++---
 net/smc/smc_llc.h |  1 +
 3 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 6663a63be9e4..1afb6e4275f2 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -427,7 +427,7 @@ static int smcr_clnt_conf_first_link(struct smc_sock *smc)
 		return rc;
 	}
 	smc_llc_flow_qentry_clr(&link->lgr->llc_flow_lcl);
-	/* tbd: call smc_llc_cli_add_link(link, qentry); */
+	smc_llc_cli_add_link(link, qentry);
 	return 0;
 }
 
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index af1727c2b7ea..d56ca60597d4 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -381,7 +381,7 @@ int smc_llc_send_confirm_link(struct smc_link *link,
 	hton24(confllc->sender_qp_num, link->roce_qp->qp_num);
 	confllc->link_num = link->link_id;
 	memcpy(confllc->link_uid, lgr->id, SMC_LGR_ID_SIZE);
-	confllc->max_links = SMC_LLC_ADD_LNK_MAX_LINKS; /* enforce peer resp. */
+	confllc->max_links = SMC_LLC_ADD_LNK_MAX_LINKS;
 	/* send llc message */
 	rc = smc_wr_tx_send(link, pend);
 	return rc;
@@ -724,6 +724,61 @@ static int smc_llc_cli_add_link_reject(struct smc_llc_qentry *qentry)
 	return smc_llc_send_message(qentry->link, &qentry->msg);
 }
 
+static int smc_llc_cli_conf_link(struct smc_link *link,
+				 struct smc_init_info *ini,
+				 struct smc_link *link_new,
+				 enum smc_lgr_type lgr_new_t)
+{
+	struct smc_link_group *lgr = link->lgr;
+	struct smc_llc_msg_del_link *del_llc;
+	struct smc_llc_qentry *qentry = NULL;
+	int rc = 0;
+
+	/* receive CONFIRM LINK request over RoCE fabric */
+	qentry = smc_llc_wait(lgr, NULL, SMC_LLC_WAIT_FIRST_TIME, 0);
+	if (!qentry) {
+		rc = smc_llc_send_delete_link(link, link_new->link_id,
+					      SMC_LLC_REQ, false,
+					      SMC_LLC_DEL_LOST_PATH);
+		return -ENOLINK;
+	}
+	if (qentry->msg.raw.hdr.common.type != SMC_LLC_CONFIRM_LINK) {
+		/* received DELETE_LINK instead */
+		del_llc = &qentry->msg.delete_link;
+		qentry->msg.raw.hdr.flags |= SMC_LLC_FLAG_RESP;
+		smc_llc_send_message(link, &qentry->msg);
+		smc_llc_flow_qentry_del(&lgr->llc_flow_lcl);
+		return -ENOLINK;
+	}
+	smc_llc_flow_qentry_del(&lgr->llc_flow_lcl);
+
+	rc = smc_ib_modify_qp_rts(link_new);
+	if (rc) {
+		smc_llc_send_delete_link(link, link_new->link_id, SMC_LLC_REQ,
+					 false, SMC_LLC_DEL_LOST_PATH);
+		return -ENOLINK;
+	}
+	smc_wr_remember_qp_attr(link_new);
+
+	rc = smcr_buf_reg_lgr(link_new);
+	if (rc) {
+		smc_llc_send_delete_link(link, link_new->link_id, SMC_LLC_REQ,
+					 false, SMC_LLC_DEL_LOST_PATH);
+		return -ENOLINK;
+	}
+
+	/* send CONFIRM LINK response over RoCE fabric */
+	rc = smc_llc_send_confirm_link(link_new, SMC_LLC_RESP);
+	if (rc) {
+		smc_llc_send_delete_link(link, link_new->link_id, SMC_LLC_REQ,
+					 false, SMC_LLC_DEL_LOST_PATH);
+		return -ENOLINK;
+	}
+	smc_llc_link_active(link_new);
+	lgr->type = lgr_new_t;
+	return 0;
+}
+
 static void smc_llc_save_add_link_info(struct smc_link *link,
 				       struct smc_llc_msg_add_link *add_llc)
 {
@@ -785,7 +840,7 @@ int smc_llc_cli_add_link(struct smc_link *link, struct smc_llc_qentry *qentry)
 		rc = 0;
 		goto out_clear_lnk;
 	}
-	/* tbd: rc = smc_llc_cli_conf_link(link, &ini, lnk_new, lgr_new_t); */
+	rc = smc_llc_cli_conf_link(link, &ini, lnk_new, lgr_new_t);
 	if (!rc)
 		goto out;
 out_clear_lnk:
@@ -820,7 +875,8 @@ static void smc_llc_add_link_work(struct work_struct *work)
 		goto out;
 	}
 
-	/* tbd: call smc_llc_process_cli_add_link(lgr); */
+	if (lgr->role == SMC_CLNT)
+		smc_llc_process_cli_add_link(lgr);
 	/* tbd: call smc_llc_process_srv_add_link(lgr); */
 out:
 	smc_llc_flow_stop(lgr, &lgr->llc_flow_lcl);
diff --git a/net/smc/smc_llc.h b/net/smc/smc_llc.h
index 97a4f02f5a93..7c314bbef8c8 100644
--- a/net/smc/smc_llc.h
+++ b/net/smc/smc_llc.h
@@ -88,6 +88,7 @@ struct smc_llc_qentry *smc_llc_wait(struct smc_link_group *lgr,
 				    int time_out, u8 exp_msg);
 struct smc_llc_qentry *smc_llc_flow_qentry_clr(struct smc_llc_flow *flow);
 void smc_llc_flow_qentry_del(struct smc_llc_flow *flow);
+int smc_llc_cli_add_link(struct smc_link *link, struct smc_llc_qentry *qentry);
 int smc_llc_init(void) __init;
 
 #endif /* SMC_LLC_H */
-- 
2.17.1
