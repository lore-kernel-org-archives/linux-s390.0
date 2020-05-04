Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36514 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728754AbgEDMTS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 May 2020 08:19:18 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 12/12] net/smc: save SMC-R peer link_uid
Date: Mon,  4 May 2020 14:18:48 +0200
Message-Id: <20200504121848.46585-13-kgraul@linux.ibm.com>
In-Reply-To: <20200504121848.46585-1-kgraul@linux.ibm.com>
References: <20200504121848.46585-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

During SMC-R link establishment the peers exchange the link_uid that
is used for debugging purposes. Save the peer link_uid in smc_link so it
can be retrieved by the smc_diag netlink interface.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c   | 2 ++
 net/smc/smc_core.h | 1 +
 net/smc/smc_llc.c  | 9 +++++++++
 net/smc/smc_llc.h  | 1 +
 4 files changed, 13 insertions(+)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index c67272007f41..4e4421c95ca1 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -390,6 +390,7 @@ static int smcr_clnt_conf_first_link(struct smc_sock *smc)
 				      SMC_CLC_DECLINE, CLC_WAIT_TIME_SHORT);
 		return rc == -EAGAIN ? SMC_CLC_DECL_TIMEOUT_CL : rc;
 	}
+	smc_llc_save_peer_uid(qentry);
 	rc = smc_llc_eval_conf_link(qentry, SMC_LLC_REQ);
 	smc_llc_flow_qentry_del(&link->lgr->llc_flow_lcl);
 	if (rc)
@@ -1056,6 +1057,7 @@ static int smcr_serv_conf_first_link(struct smc_sock *smc)
 				      SMC_CLC_DECLINE, CLC_WAIT_TIME_SHORT);
 		return rc == -EAGAIN ? SMC_CLC_DECL_TIMEOUT_CL : rc;
 	}
+	smc_llc_save_peer_uid(qentry);
 	rc = smc_llc_eval_conf_link(qentry, SMC_LLC_RESP);
 	smc_llc_flow_qentry_del(&link->lgr->llc_flow_lcl);
 	if (rc)
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index e2ace20db7fd..4ae76802214f 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -119,6 +119,7 @@ struct smc_link {
 	u8			peer_gid[SMC_GID_SIZE];	/* gid of peer*/
 	u8			link_id;	/* unique # within link group */
 	u8			link_uid[SMC_LGR_ID_SIZE]; /* unique lnk id */
+	u8			peer_link_uid[SMC_LGR_ID_SIZE]; /* peer uid */
 	u8			link_idx;	/* index in lgr link array */
 	u8			link_is_asym;	/* is link asymmetric? */
 	struct smc_link_group	*lgr;		/* parent link group */
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index afb889d60881..66ddc9cf5e2f 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -770,6 +770,7 @@ static int smc_llc_cli_conf_link(struct smc_link *link,
 		smc_llc_flow_qentry_del(&lgr->llc_flow_lcl);
 		return -ENOLINK;
 	}
+	smc_llc_save_peer_uid(qentry);
 	smc_llc_flow_qentry_del(&lgr->llc_flow_lcl);
 
 	rc = smc_ib_modify_qp_rts(link_new);
@@ -1041,6 +1042,7 @@ static int smc_llc_srv_conf_link(struct smc_link *link,
 					 false, SMC_LLC_DEL_LOST_PATH);
 		return -ENOLINK;
 	}
+	smc_llc_save_peer_uid(qentry);
 	smc_llc_link_active(link_new);
 	if (lgr_new_t == SMC_LGR_ASYMMETRIC_LOCAL ||
 	    lgr_new_t == SMC_LGR_ASYMMETRIC_PEER)
@@ -1783,6 +1785,13 @@ void smc_llc_link_set_uid(struct smc_link *link)
 	memcpy(link->link_uid, &link_uid, SMC_LGR_ID_SIZE);
 }
 
+/* save peers link user id, used for debug purposes */
+void smc_llc_save_peer_uid(struct smc_llc_qentry *qentry)
+{
+	memcpy(qentry->link->peer_link_uid, qentry->msg.confirm_link.link_uid,
+	       SMC_LGR_ID_SIZE);
+}
+
 /* evaluate confirm link request or response */
 int smc_llc_eval_conf_link(struct smc_llc_qentry *qentry,
 			   enum smc_llc_reqresp type)
diff --git a/net/smc/smc_llc.h b/net/smc/smc_llc.h
index 1b68f229cb99..55287376112d 100644
--- a/net/smc/smc_llc.h
+++ b/net/smc/smc_llc.h
@@ -93,6 +93,7 @@ void smc_llc_flow_stop(struct smc_link_group *lgr, struct smc_llc_flow *flow);
 int smc_llc_eval_conf_link(struct smc_llc_qentry *qentry,
 			   enum smc_llc_reqresp type);
 void smc_llc_link_set_uid(struct smc_link *link);
+void smc_llc_save_peer_uid(struct smc_llc_qentry *qentry);
 struct smc_llc_qentry *smc_llc_wait(struct smc_link_group *lgr,
 				    struct smc_link *lnk,
 				    int time_out, u8 exp_msg);
-- 
2.17.1
