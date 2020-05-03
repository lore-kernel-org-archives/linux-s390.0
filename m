Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58408 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728203AbgECMjs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 3 May 2020 08:39:48 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next v2 05/11] net/smc: rkey processing for a new link as SMC server
Date: Sun,  3 May 2020 14:38:44 +0200
Message-Id: <20200503123850.57261-6-kgraul@linux.ibm.com>
In-Reply-To: <20200503123850.57261-1-kgraul@linux.ibm.com>
References: <20200503123850.57261-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Part of SMC server new link establishment is the exchange of rkeys for
used buffers.
Loop over all used RMB buffers and send ADD_LINK_CONTINUE LLC messages
to the peer.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_llc.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index e2f254e21759..de73432bd72f 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -863,6 +863,47 @@ static void smc_llc_process_cli_add_link(struct smc_link_group *lgr)
 	mutex_unlock(&lgr->llc_conf_mutex);
 }
 
+static int smc_llc_srv_rkey_exchange(struct smc_link *link,
+				     struct smc_link *link_new)
+{
+	struct smc_llc_msg_add_link_cont *addc_llc;
+	struct smc_link_group *lgr = link->lgr;
+	u8 max, num_rkeys_send, num_rkeys_recv;
+	struct smc_llc_qentry *qentry = NULL;
+	struct smc_buf_desc *buf_pos;
+	int buf_lst;
+	int rc = 0;
+	int i;
+
+	mutex_lock(&lgr->rmbs_lock);
+	num_rkeys_send = lgr->conns_num;
+	buf_pos = smc_llc_get_first_rmb(lgr, &buf_lst);
+	do {
+		smc_llc_add_link_cont(link, link_new, &num_rkeys_send,
+				      &buf_lst, &buf_pos);
+		qentry = smc_llc_wait(lgr, link, SMC_LLC_WAIT_TIME,
+				      SMC_LLC_ADD_LINK_CONT);
+		if (!qentry) {
+			rc = -ETIMEDOUT;
+			goto out;
+		}
+		addc_llc = &qentry->msg.add_link_cont;
+		num_rkeys_recv = addc_llc->num_rkeys;
+		max = min_t(u8, num_rkeys_recv, SMC_LLC_RKEYS_PER_CONT_MSG);
+		for (i = 0; i < max; i++) {
+			smc_rtoken_set(lgr, link->link_idx, link_new->link_idx,
+				       addc_llc->rt[i].rmb_key,
+				       addc_llc->rt[i].rmb_vaddr_new,
+				       addc_llc->rt[i].rmb_key_new);
+			num_rkeys_recv--;
+		}
+		smc_llc_flow_qentry_del(&lgr->llc_flow_lcl);
+	} while (num_rkeys_send || num_rkeys_recv);
+out:
+	mutex_unlock(&lgr->rmbs_lock);
+	return rc;
+}
+
 int smc_llc_srv_add_link(struct smc_link *link)
 {
 	enum smc_lgr_type lgr_new_t = SMC_LGR_SYMMETRIC;
@@ -923,7 +964,7 @@ int smc_llc_srv_add_link(struct smc_link *link)
 	rc = smcr_buf_reg_lgr(link_new);
 	if (rc)
 		goto out_err;
-	/* tbd: rc = smc_llc_srv_rkey_exchange(link, link_new); */
+	rc = smc_llc_srv_rkey_exchange(link, link_new);
 	if (rc)
 		goto out_err;
 	/* tbd: rc = smc_llc_srv_conf_link(link, link_new, lgr_new_t); */
-- 
2.17.1
