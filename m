Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25514 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725806AbgKBTec (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Nov 2020 14:34:32 -0500
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 01/15] net/smc: use helper smc_conn_abort() in listen processing
Date: Mon,  2 Nov 2020 20:33:55 +0100
Message-Id: <20201102193409.70901-2-kgraul@linux.ibm.com>
In-Reply-To: <20201102193409.70901-1-kgraul@linux.ibm.com>
References: <20201102193409.70901-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, raspl@linux.ibm.com

The helper smc_connect_abort() can be used by the listen processing
functions, too. And rename this helper to smc_conn_abort() to make the
purpose clearer.
No functional change.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/af_smc.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 527185af7bf3..bc3e45289771 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -552,8 +552,7 @@ static int smc_connect_decline_fallback(struct smc_sock *smc, int reason_code,
 	return smc_connect_fallback(smc, reason_code);
 }
 
-/* abort connecting */
-static void smc_connect_abort(struct smc_sock *smc, int local_first)
+static void smc_conn_abort(struct smc_sock *smc, int local_first)
 {
 	if (local_first)
 		smc_lgr_cleanup_early(&smc->conn);
@@ -814,7 +813,7 @@ static int smc_connect_rdma(struct smc_sock *smc,
 
 	return 0;
 connect_abort:
-	smc_connect_abort(smc, ini->first_contact_local);
+	smc_conn_abort(smc, ini->first_contact_local);
 	mutex_unlock(&smc_client_lgr_pending);
 	smc->connect_nonblock = 0;
 
@@ -893,7 +892,7 @@ static int smc_connect_ism(struct smc_sock *smc,
 
 	return 0;
 connect_abort:
-	smc_connect_abort(smc, ini->first_contact_local);
+	smc_conn_abort(smc, ini->first_contact_local);
 	mutex_unlock(&smc_server_lgr_pending);
 	smc->connect_nonblock = 0;
 
@@ -1320,10 +1319,7 @@ static void smc_listen_decline(struct smc_sock *new_smc, int reason_code,
 			       int local_first, u8 version)
 {
 	/* RDMA setup failed, switch back to TCP */
-	if (local_first)
-		smc_lgr_cleanup_early(&new_smc->conn);
-	else
-		smc_conn_free(&new_smc->conn);
+	smc_conn_abort(new_smc, local_first);
 	if (reason_code < 0) { /* error, no fallback possible */
 		smc_listen_out_err(new_smc);
 		return;
@@ -1429,10 +1425,7 @@ static int smc_listen_ism_init(struct smc_sock *new_smc,
 	/* Create send and receive buffers */
 	rc = smc_buf_create(new_smc, true);
 	if (rc) {
-		if (ini->first_contact_local)
-			smc_lgr_cleanup_early(&new_smc->conn);
-		else
-			smc_conn_free(&new_smc->conn);
+		smc_conn_abort(new_smc, ini->first_contact_local);
 		return (rc == -ENOSPC) ? SMC_CLC_DECL_MAX_DMB :
 					 SMC_CLC_DECL_MEM;
 	}
-- 
2.17.1
