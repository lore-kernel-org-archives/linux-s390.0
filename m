Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30508 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726951AbgIJQtV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Sep 2020 12:49:21 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 06/10] net/smc: reduce smc_listen_decline() calls
Date: Thu, 10 Sep 2020 18:48:25 +0200
Message-Id: <20200910164829.65426-7-kgraul@linux.ibm.com>
In-Reply-To: <20200910164829.65426-1-kgraul@linux.ibm.com>
References: <20200910164829.65426-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>

smc_listen_work() contains already an smc_listen_decline() exit.
Use this exit for smc_listen_rdma_finish() problems as well.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/af_smc.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index f27a596b2624..9f3e148c60c5 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1233,27 +1233,17 @@ static int smc_listen_rdma_finish(struct smc_sock *new_smc,
 	if (local_first)
 		smc_link_save_peer_info(link, cclc);
 
-	if (smc_rmb_rtoken_handling(&new_smc->conn, link, cclc)) {
-		reason_code = SMC_CLC_DECL_ERR_RTOK;
-		goto decline;
-	}
+	if (smc_rmb_rtoken_handling(&new_smc->conn, link, cclc))
+		return SMC_CLC_DECL_ERR_RTOK;
 
 	if (local_first) {
-		if (smc_ib_ready_link(link)) {
-			reason_code = SMC_CLC_DECL_ERR_RDYLNK;
-			goto decline;
-		}
+		if (smc_ib_ready_link(link))
+			return SMC_CLC_DECL_ERR_RDYLNK;
 		/* QP confirmation over RoCE fabric */
 		smc_llc_flow_initiate(link->lgr, SMC_LLC_FLOW_ADD_LINK);
 		reason_code = smcr_serv_conf_first_link(new_smc);
 		smc_llc_flow_stop(link->lgr, &link->lgr->llc_flow_lcl);
-		if (reason_code)
-			goto decline;
 	}
-	return 0;
-
-decline:
-	smc_listen_decline(new_smc, reason_code, local_first);
 	return reason_code;
 }
 
@@ -1382,9 +1372,9 @@ static void smc_listen_work(struct work_struct *work)
 	if (!ism_supported) {
 		rc = smc_listen_rdma_finish(new_smc, &cclc,
 					    ini.first_contact_local);
-		mutex_unlock(&smc_server_lgr_pending);
 		if (rc)
-			return;
+			goto out_unlock;
+		mutex_unlock(&smc_server_lgr_pending);
 	}
 	smc_conn_save_peer_info(new_smc, &cclc);
 	smc_listen_out_connected(new_smc);
-- 
2.17.1
