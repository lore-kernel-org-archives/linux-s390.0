Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60110 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726152AbgJGU56 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Oct 2020 16:57:58 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 2/3] net/smc: cleanup buffer usage in smc_listen_work()
Date: Wed,  7 Oct 2020 22:57:42 +0200
Message-Id: <20201007205743.83535-3-kgraul@linux.ibm.com>
In-Reply-To: <20201007205743.83535-1-kgraul@linux.ibm.com>
References: <20201007205743.83535-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

coccinelle informs about
net/smc/af_smc.c:1770:10-11: WARNING: opportunity for kzfree/kvfree_sensitive

Its not that kzfree() would help here, the memset() is done to prepare
the buffer for another socket receive.
Fix that warning message by reordering the calls, while at it eliminate
the unneeded variable cclc2 and use sizeof(*buf) as above in the same
function. No functional changes.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/af_smc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index fbe98bb20299..f481f0ed2b78 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1664,7 +1664,6 @@ static void smc_listen_work(struct work_struct *work)
 						smc_listen_work);
 	u8 version = smc_ism_v2_capable ? SMC_V2 : SMC_V1;
 	struct socket *newclcsock = new_smc->clcsock;
-	struct smc_clc_msg_accept_confirm_v2 *cclc2;
 	struct smc_clc_msg_accept_confirm *cclc;
 	struct smc_clc_msg_proposal_area *buf;
 	struct smc_clc_msg_proposal *pclc;
@@ -1740,11 +1739,9 @@ static void smc_listen_work(struct work_struct *work)
 		mutex_unlock(&smc_server_lgr_pending);
 
 	/* receive SMC Confirm CLC message */
-	cclc2 = (struct smc_clc_msg_accept_confirm_v2 *)buf;
-	cclc = (struct smc_clc_msg_accept_confirm *)cclc2;
-	memset(buf, 0, sizeof(struct smc_clc_msg_proposal_area));
-	rc = smc_clc_wait_msg(new_smc, cclc2,
-			      sizeof(struct smc_clc_msg_proposal_area),
+	memset(buf, 0, sizeof(*buf));
+	cclc = (struct smc_clc_msg_accept_confirm *)buf;
+	rc = smc_clc_wait_msg(new_smc, cclc, sizeof(*buf),
 			      SMC_CLC_CONFIRM, CLC_WAIT_TIME);
 	if (rc) {
 		if (!ini->is_smcd)
-- 
2.17.1
