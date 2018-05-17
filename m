From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 1/1] net/smc: initialize tx_work before llc initial handshake
Date: Thu, 17 May 2018 12:54:48 +0200
Message-ID: <20180517105448.54721-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>

When the llc handshake fails in an early state, the general cleanup
routines may try to cancel an uninitialized worker. Avoid this by
initializing the worker before the llc initial handshake starts.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 544bab42f925..e96f324dc69f 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -494,6 +494,7 @@ static int smc_connect_rdma(struct smc_sock *smc)
 	rc = smc_clc_send_confirm(smc);
 	if (rc)
 		goto out_err_unlock;
+	smc_tx_init(smc);
 
 	if (local_contact == SMC_FIRST_CONTACT) {
 		/* QP confirmation over RoCE fabric */
@@ -505,9 +506,7 @@ static int smc_connect_rdma(struct smc_sock *smc)
 		if (reason_code > 0)
 			goto decline_rdma_unlock;
 	}
-
 	mutex_unlock(&smc_create_lgr_pending);
-	smc_tx_init(smc);
 
 out_connected:
 	smc_copy_sock_settings_to_clc(smc);
@@ -885,6 +884,7 @@ static void smc_listen_work(struct work_struct *work)
 		reason_code = SMC_CLC_DECL_INTERR;
 		goto decline_rdma_unlock;
 	}
+	smc_tx_init(new_smc);
 
 	if (local_contact == SMC_FIRST_CONTACT) {
 		rc = smc_ib_ready_link(link);
@@ -900,8 +900,6 @@ static void smc_listen_work(struct work_struct *work)
 		if (reason_code > 0)
 			goto decline_rdma_unlock;
 	}
-
-	smc_tx_init(new_smc);
 	mutex_unlock(&smc_create_lgr_pending);
 
 out_connected:
-- 
2.16.3
