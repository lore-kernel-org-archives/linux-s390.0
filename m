Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29224 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727887AbgEBMgT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 2 May 2020 08:36:19 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 10/13] net/smc: delete link processing as SMC client
Date: Sat,  2 May 2020 14:35:49 +0200
Message-Id: <20200502123552.17204-11-kgraul@linux.ibm.com>
In-Reply-To: <20200502123552.17204-1-kgraul@linux.ibm.com>
References: <20200502123552.17204-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Add smc_llc_process_cli_delete_link() to process a DELETE_LINK request
as SMC client. When the request is to delete ALL links then terminate
the whole link group. If not, find the link to delete by its link_id,
send the DELETE_LINK response LLC message and then clear the deleted
link. Finally determine and update the link group state.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_llc.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index e4e3910a9624..cd57b4fb1842 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -863,6 +863,18 @@ static void smc_llc_process_cli_add_link(struct smc_link_group *lgr)
 	mutex_unlock(&lgr->llc_conf_mutex);
 }
 
+static int smc_llc_active_link_count(struct smc_link_group *lgr)
+{
+	int i, link_count = 0;
+
+	for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++) {
+		if (!smc_link_usable(&lgr->lnk[i]))
+			continue;
+		link_count++;
+	}
+	return link_count;
+}
+
 /* find the asymmetric link when 3 links are established  */
 static struct smc_link *smc_llc_find_asym_link(struct smc_link_group *lgr)
 {
@@ -1118,6 +1130,63 @@ static void smc_llc_add_link_work(struct work_struct *work)
 	smc_llc_flow_stop(lgr, &lgr->llc_flow_lcl);
 }
 
+static void smc_llc_process_cli_delete_link(struct smc_link_group *lgr)
+{
+	struct smc_link *lnk_del = NULL, *lnk_asym, *lnk;
+	struct smc_llc_msg_del_link *del_llc;
+	struct smc_llc_qentry *qentry;
+	int active_links;
+	int lnk_idx;
+
+	qentry = smc_llc_flow_qentry_clr(&lgr->llc_flow_lcl);
+	lnk = qentry->link;
+	del_llc = &qentry->msg.delete_link;
+
+	if (del_llc->hd.flags & SMC_LLC_FLAG_DEL_LINK_ALL) {
+		smc_lgr_terminate_sched(lgr);
+		goto out;
+	}
+	mutex_lock(&lgr->llc_conf_mutex);
+	/* delete single link */
+	for (lnk_idx = 0; lnk_idx < SMC_LINKS_PER_LGR_MAX; lnk_idx++) {
+		if (lgr->lnk[lnk_idx].link_id != del_llc->link_num)
+			continue;
+		lnk_del = &lgr->lnk[lnk_idx];
+		break;
+	}
+	del_llc->hd.flags |= SMC_LLC_FLAG_RESP;
+	if (!lnk_del) {
+		/* link was not found */
+		del_llc->reason = htonl(SMC_LLC_DEL_NOLNK);
+		smc_llc_send_message(lnk, &qentry->msg);
+		goto out_unlock;
+	}
+	lnk_asym = smc_llc_find_asym_link(lgr);
+
+	del_llc->reason = 0;
+	smc_llc_send_message(lnk, &qentry->msg); /* response */
+
+	if (smc_link_downing(&lnk_del->state)) {
+		/* tbd: call smc_switch_conns(lgr, lnk_del, false); */
+		smc_wr_tx_wait_no_pending_sends(lnk_del);
+	}
+	smcr_link_clear(lnk_del);
+
+	active_links = smc_llc_active_link_count(lgr);
+	if (lnk_del == lnk_asym) {
+		/* expected deletion of asym link, don't change lgr state */
+	} else if (active_links == 1) {
+		lgr->type = SMC_LGR_SINGLE;
+	} else if (!active_links) {
+		lgr->type = SMC_LGR_NONE;
+		smc_lgr_terminate_sched(lgr);
+	}
+out_unlock:
+	mutex_unlock(&lgr->llc_conf_mutex);
+out:
+	kfree(qentry);
+}
+
 static void smc_llc_delete_link_work(struct work_struct *work)
 {
 	struct smc_link_group *lgr = container_of(work, struct smc_link_group,
@@ -1128,6 +1197,9 @@ static void smc_llc_delete_link_work(struct work_struct *work)
 		smc_llc_flow_qentry_del(&lgr->llc_flow_lcl);
 		goto out;
 	}
+
+	if (lgr->role == SMC_CLNT)
+		smc_llc_process_cli_delete_link(lgr);
 out:
 	smc_llc_flow_stop(lgr, &lgr->llc_flow_lcl);
 }
-- 
2.17.1
