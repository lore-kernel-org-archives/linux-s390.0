Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33778 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728748AbgEDMTR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 May 2020 08:19:17 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 11/12] net/smc: create improved SMC-R link_uid
Date: Mon,  4 May 2020 14:18:47 +0200
Message-Id: <20200504121848.46585-12-kgraul@linux.ibm.com>
In-Reply-To: <20200504121848.46585-1-kgraul@linux.ibm.com>
References: <20200504121848.46585-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

The link_uid of an SMC-R link is exchanged between SMC peers and its
value can be used for debugging purposes. Create a unique link_uid
during link initialization and use it in communication with SMC-R peers.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.c |  1 +
 net/smc/smc_core.h |  4 +++-
 net/smc/smc_llc.c  | 18 ++++++++++++++----
 net/smc/smc_llc.h  |  1 +
 4 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index fb391bc6781e..fb5f685ff494 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -331,6 +331,7 @@ int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
 	lnk->smcibdev = ini->ib_dev;
 	lnk->ibport = ini->ib_port;
 	lnk->path_mtu = ini->ib_dev->pattr[ini->ib_port - 1].active_mtu;
+	smc_llc_link_set_uid(lnk);
 	INIT_WORK(&lnk->link_down_wrk, smc_link_down_work);
 	if (!ini->ib_dev->initialized) {
 		rc = (int)smc_ib_setup_per_ibdev(ini->ib_dev);
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 32bc45af9a1a..e2ace20db7fd 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -70,6 +70,8 @@ struct smc_rdma_wr {				/* work requests per message
 	struct ib_rdma_wr	wr_tx_rdma[SMC_MAX_RDMA_WRITES];
 };
 
+#define SMC_LGR_ID_SIZE		4
+
 struct smc_link {
 	struct smc_ib_device	*smcibdev;	/* ib-device */
 	u8			ibport;		/* port - values 1 | 2 */
@@ -116,6 +118,7 @@ struct smc_link {
 	u8			peer_mac[ETH_ALEN];	/* = gid[8:10||13:15] */
 	u8			peer_gid[SMC_GID_SIZE];	/* gid of peer*/
 	u8			link_id;	/* unique # within link group */
+	u8			link_uid[SMC_LGR_ID_SIZE]; /* unique lnk id */
 	u8			link_idx;	/* index in lgr link array */
 	u8			link_is_asym;	/* is link asymmetric? */
 	struct smc_link_group	*lgr;		/* parent link group */
@@ -178,7 +181,6 @@ struct smc_rtoken {				/* address/key of remote RMB */
 	u32			rkey;
 };
 
-#define SMC_LGR_ID_SIZE		4
 #define SMC_BUF_MIN_SIZE	16384	/* minimum size of an RMB */
 #define SMC_RMBE_SIZES		16	/* number of distinct RMBE sizes */
 /* theoretically, the RFC states that largest size would be 512K,
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 482acf80e26e..afb889d60881 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -361,7 +361,6 @@ static int smc_llc_add_pending_send(struct smc_link *link,
 int smc_llc_send_confirm_link(struct smc_link *link,
 			      enum smc_llc_reqresp reqresp)
 {
-	struct smc_link_group *lgr = smc_get_lgr(link);
 	struct smc_llc_msg_confirm_link *confllc;
 	struct smc_wr_tx_pend_priv *pend;
 	struct smc_wr_buf *wr_buf;
@@ -382,7 +381,7 @@ int smc_llc_send_confirm_link(struct smc_link *link,
 	memcpy(confllc->sender_gid, link->gid, SMC_GID_SIZE);
 	hton24(confllc->sender_qp_num, link->roce_qp->qp_num);
 	confllc->link_num = link->link_id;
-	memcpy(confllc->link_uid, lgr->id, SMC_LGR_ID_SIZE);
+	memcpy(confllc->link_uid, link->link_uid, SMC_LGR_ID_SIZE);
 	confllc->max_links = SMC_LLC_ADD_LNK_MAX_LINKS;
 	/* send llc message */
 	rc = smc_wr_tx_send(link, pend);
@@ -845,7 +844,8 @@ int smc_llc_cli_add_link(struct smc_link *link, struct smc_llc_qentry *qentry)
 	if (rc)
 		goto out_reject;
 	smc_llc_save_add_link_info(lnk_new, llc);
-	lnk_new->link_id = llc->link_num;
+	lnk_new->link_id = llc->link_num;	/* SMC server assigns link id */
+	smc_llc_link_set_uid(lnk_new);
 
 	rc = smc_ib_ready_link(lnk_new);
 	if (rc)
@@ -1775,12 +1775,22 @@ int smc_llc_do_delete_rkey(struct smc_link_group *lgr,
 	return rc;
 }
 
+void smc_llc_link_set_uid(struct smc_link *link)
+{
+	__be32 link_uid;
+
+	link_uid = htonl(*((u32 *)link->lgr->id) + link->link_id);
+	memcpy(link->link_uid, &link_uid, SMC_LGR_ID_SIZE);
+}
+
 /* evaluate confirm link request or response */
 int smc_llc_eval_conf_link(struct smc_llc_qentry *qentry,
 			   enum smc_llc_reqresp type)
 {
-	if (type == SMC_LLC_REQ)	/* SMC server assigns link_id */
+	if (type == SMC_LLC_REQ) {	/* SMC server assigns link_id */
 		qentry->link->link_id = qentry->msg.confirm_link.link_num;
+		smc_llc_link_set_uid(qentry->link);
+	}
 	if (!(qentry->msg.raw.hdr.flags & SMC_LLC_FLAG_NO_RMBE_EYEC))
 		return -ENOTSUPP;
 	return 0;
diff --git a/net/smc/smc_llc.h b/net/smc/smc_llc.h
index f5882ebf357b..1b68f229cb99 100644
--- a/net/smc/smc_llc.h
+++ b/net/smc/smc_llc.h
@@ -92,6 +92,7 @@ int smc_llc_flow_initiate(struct smc_link_group *lgr,
 void smc_llc_flow_stop(struct smc_link_group *lgr, struct smc_llc_flow *flow);
 int smc_llc_eval_conf_link(struct smc_llc_qentry *qentry,
 			   enum smc_llc_reqresp type);
+void smc_llc_link_set_uid(struct smc_link *link);
 struct smc_llc_qentry *smc_llc_wait(struct smc_link_group *lgr,
 				    struct smc_link *lnk,
 				    int time_out, u8 exp_msg);
-- 
2.17.1
