Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8794 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755050AbgJWSsn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 23 Oct 2020 14:48:43 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net 1/3] net/smc: fix null pointer dereference in smc_listen_decline()
Date: Fri, 23 Oct 2020 20:48:28 +0200
Message-Id: <20201023184830.59548-2-kgraul@linux.ibm.com>
In-Reply-To: <20201023184830.59548-1-kgraul@linux.ibm.com>
References: <20201023184830.59548-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

smc_listen_work() calls smc_listen_decline() on label out_decl,
providing the ini pointer variable. But this pointer can still be null
when the label out_decl is reached.
Fix this by checking the ini variable in smc_listen_work() and call
smc_listen_decline() with the result directly.

Fixes: a7c9c5f4af7f ("net/smc: CLC accept / confirm V2")
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/af_smc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 82be0bd0f6e8..e9f487c8c6d5 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1317,10 +1317,10 @@ static void smc_listen_out_err(struct smc_sock *new_smc)
 
 /* listen worker: decline and fall back if possible */
 static void smc_listen_decline(struct smc_sock *new_smc, int reason_code,
-			       struct smc_init_info *ini, u8 version)
+			       int local_first, u8 version)
 {
 	/* RDMA setup failed, switch back to TCP */
-	if (ini->first_contact_local)
+	if (local_first)
 		smc_lgr_cleanup_early(&new_smc->conn);
 	else
 		smc_conn_free(&new_smc->conn);
@@ -1768,7 +1768,8 @@ static void smc_listen_work(struct work_struct *work)
 out_unlock:
 	mutex_unlock(&smc_server_lgr_pending);
 out_decl:
-	smc_listen_decline(new_smc, rc, ini, version);
+	smc_listen_decline(new_smc, rc, ini ? ini->first_contact_local : 0,
+			   version);
 out_free:
 	kfree(ini);
 	kfree(buf);
-- 
2.17.1
