Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27756 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728299AbgECMjs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 3 May 2020 08:39:48 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next v2 01/11] net/smc: first part of add link processing as SMC client
Date: Sun,  3 May 2020 14:38:40 +0200
Message-Id: <20200503123850.57261-2-kgraul@linux.ibm.com>
In-Reply-To: <20200503123850.57261-1-kgraul@linux.ibm.com>
References: <20200503123850.57261-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

First set of functions to process an ADD_LINK LLC request as an SMC
client. Find an alternate IB device, determine the new link group type
and get the index for the new link. Then ready the link, map the buffers
and send an ADD_LINK LLC response. If any error occurs, send a reject
LLC message and terminate the processing.
Add smc_llc_alloc_alt_link() to find a free link index for a new link,
depending on the new link group type.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.c |   4 +-
 net/smc/smc_core.h |   2 +
 net/smc/smc_llc.c  | 107 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 60c708f6de51..2f8faa9c9e8e 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -273,8 +273,8 @@ static u8 smcr_next_link_id(struct smc_link_group *lgr)
 	return link_id;
 }
 
-static int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
-			  u8 link_idx, struct smc_init_info *ini)
+int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
+		   u8 link_idx, struct smc_init_info *ini)
 {
 	u8 rndvec[3];
 	int rc;
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 555ada9d2423..4e00819e2db7 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -374,6 +374,8 @@ void smc_lgr_schedule_free_work_fast(struct smc_link_group *lgr);
 int smc_core_init(void);
 void smc_core_exit(void);
 
+int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
+		   u8 link_idx, struct smc_init_info *ini);
 void smcr_link_clear(struct smc_link *lnk);
 int smcr_buf_map_lgr(struct smc_link *lnk);
 int smcr_buf_reg_lgr(struct smc_link *lnk);
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 4e3db4d4b783..8716d8739329 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -17,6 +17,7 @@
 #include "smc_core.h"
 #include "smc_clc.h"
 #include "smc_llc.h"
+#include "smc_pnet.h"
 
 #define SMC_LLC_DATA_LEN		40
 
@@ -541,6 +542,112 @@ static int smc_llc_send_message(struct smc_link *link, void *llcbuf)
 
 /********************************* receive ***********************************/
 
+static int smc_llc_alloc_alt_link(struct smc_link_group *lgr,
+				  enum smc_lgr_type lgr_new_t)
+{
+	int i;
+
+	if (lgr->type == SMC_LGR_SYMMETRIC ||
+	    (lgr->type != SMC_LGR_SINGLE &&
+	     (lgr_new_t == SMC_LGR_ASYMMETRIC_LOCAL ||
+	      lgr_new_t == SMC_LGR_ASYMMETRIC_PEER)))
+		return -EMLINK;
+
+	if (lgr_new_t == SMC_LGR_ASYMMETRIC_LOCAL ||
+	    lgr_new_t == SMC_LGR_ASYMMETRIC_PEER) {
+		for (i = SMC_LINKS_PER_LGR_MAX - 1; i >= 0; i--)
+			if (lgr->lnk[i].state == SMC_LNK_UNUSED)
+				return i;
+	} else {
+		for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++)
+			if (lgr->lnk[i].state == SMC_LNK_UNUSED)
+				return i;
+	}
+	return -EMLINK;
+}
+
+/* prepare and send an add link reject response */
+static int smc_llc_cli_add_link_reject(struct smc_llc_qentry *qentry)
+{
+	qentry->msg.raw.hdr.flags |= SMC_LLC_FLAG_RESP;
+	qentry->msg.raw.hdr.flags |= SMC_LLC_FLAG_ADD_LNK_REJ;
+	qentry->msg.raw.hdr.add_link_rej_rsn = SMC_LLC_REJ_RSN_NO_ALT_PATH;
+	return smc_llc_send_message(qentry->link, &qentry->msg);
+}
+
+static void smc_llc_save_add_link_info(struct smc_link *link,
+				       struct smc_llc_msg_add_link *add_llc)
+{
+	link->peer_qpn = ntoh24(add_llc->sender_qp_num);
+	memcpy(link->peer_gid, add_llc->sender_gid, SMC_GID_SIZE);
+	memcpy(link->peer_mac, add_llc->sender_mac, ETH_ALEN);
+	link->peer_psn = ntoh24(add_llc->initial_psn);
+	link->peer_mtu = add_llc->qp_mtu;
+}
+
+/* as an SMC client, process an add link request */
+int smc_llc_cli_add_link(struct smc_link *link, struct smc_llc_qentry *qentry)
+{
+	struct smc_llc_msg_add_link *llc = &qentry->msg.add_link;
+	enum smc_lgr_type lgr_new_t = SMC_LGR_SYMMETRIC;
+	struct smc_link_group *lgr = smc_get_lgr(link);
+	struct smc_link *lnk_new = NULL;
+	struct smc_init_info ini;
+	int lnk_idx, rc = 0;
+
+	ini.vlan_id = lgr->vlan_id;
+	smc_pnet_find_alt_roce(lgr, &ini, link->smcibdev);
+	if (!memcmp(llc->sender_gid, link->peer_gid, SMC_GID_SIZE) &&
+	    !memcmp(llc->sender_mac, link->peer_mac, ETH_ALEN)) {
+		if (!ini.ib_dev)
+			goto out_reject;
+		lgr_new_t = SMC_LGR_ASYMMETRIC_PEER;
+	}
+	if (!ini.ib_dev) {
+		lgr_new_t = SMC_LGR_ASYMMETRIC_LOCAL;
+		ini.ib_dev = link->smcibdev;
+		ini.ib_port = link->ibport;
+	}
+	lnk_idx = smc_llc_alloc_alt_link(lgr, lgr_new_t);
+	if (lnk_idx < 0)
+		goto out_reject;
+	lnk_new = &lgr->lnk[lnk_idx];
+	rc = smcr_link_init(lgr, lnk_new, lnk_idx, &ini);
+	if (rc)
+		goto out_reject;
+	smc_llc_save_add_link_info(lnk_new, llc);
+	lnk_new->link_id = llc->link_num;
+
+	rc = smc_ib_ready_link(lnk_new);
+	if (rc)
+		goto out_clear_lnk;
+
+	rc = smcr_buf_map_lgr(lnk_new);
+	if (rc)
+		goto out_clear_lnk;
+
+	rc = smc_llc_send_add_link(link,
+				   lnk_new->smcibdev->mac[ini.ib_port - 1],
+				   lnk_new->gid, lnk_new, SMC_LLC_RESP);
+	if (rc)
+		goto out_clear_lnk;
+	/* tbd: rc = smc_llc_cli_rkey_exchange(link, lnk_new); */
+	if (rc) {
+		rc = 0;
+		goto out_clear_lnk;
+	}
+	/* tbd: rc = smc_llc_cli_conf_link(link, &ini, lnk_new, lgr_new_t); */
+	if (!rc)
+		goto out;
+out_clear_lnk:
+	smcr_link_clear(lnk_new);
+out_reject:
+	smc_llc_cli_add_link_reject(qentry);
+out:
+	kfree(qentry);
+	return rc;
+}
+
 /* worker to process an add link message */
 static void smc_llc_add_link_work(struct work_struct *work)
 {
-- 
2.17.1
