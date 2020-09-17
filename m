Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49002 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726180AbgIQVC6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 17 Sep 2020 17:02:58 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 1/1] net/smc: fix double kfree in smc_listen_work()
Date: Thu, 17 Sep 2020 22:46:02 +0200
Message-Id: <20200917204602.14586-2-kgraul@linux.ibm.com>
In-Reply-To: <20200917204602.14586-1-kgraul@linux.ibm.com>
References: <20200917204602.14586-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>

If smc_listen_rmda_finish() returns with an error, the storage
addressed by 'buf' is freed a second time.
Consolidate freeing under a common label and jump to that label.

Fixes: 6bb14e48ee8d ("net/smc: dynamic allocation of CLC proposal buffer")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/af_smc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index f5bececfedaa..ed8f97166be9 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1371,7 +1371,6 @@ static void smc_listen_work(struct work_struct *work)
 	}
 
 	/* finish worker */
-	kfree(buf);
 	if (!ism_supported) {
 		rc = smc_listen_rdma_finish(new_smc, &cclc,
 					    ini.first_contact_local);
@@ -1381,12 +1380,13 @@ static void smc_listen_work(struct work_struct *work)
 	}
 	smc_conn_save_peer_info(new_smc, &cclc);
 	smc_listen_out_connected(new_smc);
-	return;
+	goto out_free;
 
 out_unlock:
 	mutex_unlock(&smc_server_lgr_pending);
 out_decl:
 	smc_listen_decline(new_smc, rc, ini.first_contact_local);
+out_free:
 	kfree(buf);
 }
 
-- 
2.17.1
