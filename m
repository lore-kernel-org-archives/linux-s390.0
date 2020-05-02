Return-Path: <netdev-owner@vger.kernel.org>
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 04/13] net/smc: first part of add link processing as SMC server
Date: Sat,  2 May 2020 14:35:43 +0200
Message-Id: <20200502123552.17204-5-kgraul@linux.ibm.com>
In-Reply-To: <20200502123552.17204-1-kgraul@linux.ibm.com>
References: <20200502123552.17204-1-kgraul@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

First set of functions to process an ADD_LINK LLC request as an SMC
server. Find an alternate IB device, determine the new link group type
and get the index for the new link. Then initialize the link and send
the ADD_LINK LLC message to the peer. Save the contents of the response,
ready the link, map all used buffers and register the buffers with the
IB device. If any error occurs, stop the processing and clear the link.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_llc.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index d56ca60597d4..954eda708c91 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -863,6 +863,94 @@ static void smc_llc_process_cli_add_link(struct smc_link_group *lgr)
 	mutex_unlock(&lgr->llc_conf_mutex);
 }
 
+int smc_llc_srv_add_link(struct smc_link *link)
+{
+	enum smc_lgr_type lgr_new_t = SMC_LGR_SYMMETRIC;
+	struct smc_link_group *lgr = link->lgr;
+	struct smc_llc_msg_add_link *add_llc;
+	struct smc_llc_qentry *qentry = NULL;
+	struct smc_link *link_new;
+	struct smc_init_info ini;
+	int lnk_idx, rc = 0;
+
+	/* ignore client add link recommendation, start new flow */
+	ini.vlan_id = lgr->vlan_id;
+	smc_pnet_find_alt_roce(lgr, &ini, link->smcibdev);
+	if (!ini.ib_dev) {
+		lgr_new_t = SMC_LGR_ASYMMETRIC_LOCAL;
+		ini.ib_dev = link->smcibdev;
+		ini.ib_port = link->ibport;
+	}
+	lnk_idx = smc_llc_alloc_alt_link(lgr, lgr_new_t);
+	if (lnk_idx < 0)
+		return 0;
+
+	rc = smcr_link_init(lgr, &lgr->lnk[lnk_idx], lnk_idx, &ini);
+	if (rc)
+		return rc;
+	link_new = &lgr->lnk[lnk_idx];
+	rc = smc_llc_send_add_link(link,
+				   link_new->smcibdev->mac[ini.ib_port - 1],
+				   link_new->gid, link_new, SMC_LLC_REQ);
+	if (rc)
+		goto out_err;
+	/* receive ADD LINK response over the RoCE fabric */
+	qentry = smc_llc_wait(lgr, link, SMC_LLC_WAIT_TIME, SMC_LLC_ADD_LINK);
+	if (!qentry) {
+		rc = -ETIMEDOUT;
+		goto out_err;
+	}
+	add_llc = &qentry->msg.add_link;
+	if (add_llc->hd.flags & SMC_LLC_FLAG_ADD_LNK_REJ) {
+		smc_llc_flow_qentry_del(&lgr->llc_flow_lcl);
+		rc = -ENOLINK;
+		goto out_err;
+	}
+	if (lgr->type == SMC_LGR_SINGLE &&
+	    (!memcmp(add_llc->sender_gid, link->peer_gid, SMC_GID_SIZE) &&
+	     !memcmp(add_llc->sender_mac, link->peer_mac, ETH_ALEN))) {
+		lgr_new_t = SMC_LGR_ASYMMETRIC_PEER;
+	}
+	smc_llc_save_add_link_info(link_new, add_llc);
+	smc_llc_flow_qentry_del(&lgr->llc_flow_lcl);
+
+	rc = smc_ib_ready_link(link_new);
+	if (rc)
+		goto out_err;
+	rc = smcr_buf_map_lgr(link_new);
+	if (rc)
+		goto out_err;
+	rc = smcr_buf_reg_lgr(link_new);
+	if (rc)
+		goto out_err;
+	/* tbd: rc = smc_llc_srv_rkey_exchange(link, link_new); */
+	if (rc)
+		goto out_err;
+	/* tbd: rc = smc_llc_srv_conf_link(link, link_new, lgr_new_t); */
+	if (rc)
+		goto out_err;
+	return 0;
+out_err:
+	smcr_link_clear(link_new);
+	return rc;
+}
+
+static void smc_llc_process_srv_add_link(struct smc_link_group *lgr)
+{
+	struct smc_link *link = lgr->llc_flow_lcl.qentry->link;
+	int rc;
+
+	smc_llc_flow_qentry_del(&lgr->llc_flow_lcl);
+
+	mutex_lock(&lgr->llc_conf_mutex);
+	rc = smc_llc_srv_add_link(link);
+	if (!rc && lgr->type == SMC_LGR_SYMMETRIC) {
+		/* delete any asymmetric link */
+		/* tbd: smc_llc_delete_asym_link(lgr); */
+	}
+	mutex_unlock(&lgr->llc_conf_mutex);
+}
+
 /* worker to process an add link message */
 static void smc_llc_add_link_work(struct work_struct *work)
 {
-- 
2.17.1
