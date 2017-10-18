From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH V2 net-next 1/3] smc: fix mutex unlocks during link group creation
Date: Wed, 18 Oct 2017 16:29:58 +0200
Message-ID: <20171018143000.23884-2-ubraun@linux.vnet.ibm.com>
References: <20171018143000.23884-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171018143000.23884-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Link group creation is synchronized with the smc_create_lgr_pending
lock. In smc_listen_work() this mutex is sometimes unlocked, even
though it has not been locked before. This issue will surface in
presence of the SMC rendezvous code.

Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 net/smc/af_smc.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 745f145d4c4d..70f7640f5090 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -808,7 +808,7 @@ static void smc_listen_work(struct work_struct *work)
 		rc = local_contact;
 		if (rc == -ENOMEM)
 			reason_code = SMC_CLC_DECL_MEM;/* insufficient memory*/
-		goto decline_rdma;
+		goto decline_rdma_unlock;
 	}
 	link = &new_smc->conn.lgr->lnk[SMC_SINGLE_LINK];
 
@@ -816,7 +816,7 @@ static void smc_listen_work(struct work_struct *work)
 	rc = smc_buf_create(new_smc);
 	if (rc) {
 		reason_code = SMC_CLC_DECL_MEM;
-		goto decline_rdma;
+		goto decline_rdma_unlock;
 	}
 
 	smc_close_init(new_smc);
@@ -831,7 +831,7 @@ static void smc_listen_work(struct work_struct *work)
 					     buf_desc->mr_rx[SMC_SINGLE_LINK]);
 			if (rc) {
 				reason_code = SMC_CLC_DECL_INTERR;
-				goto decline_rdma;
+				goto decline_rdma_unlock;
 			}
 		}
 	}
@@ -839,15 +839,15 @@ static void smc_listen_work(struct work_struct *work)
 
 	rc = smc_clc_send_accept(new_smc, local_contact);
 	if (rc)
-		goto out_err;
+		goto out_err_unlock;
 
 	/* receive SMC Confirm CLC message */
 	reason_code = smc_clc_wait_msg(new_smc, &cclc, sizeof(cclc),
 				       SMC_CLC_CONFIRM);
 	if (reason_code < 0)
-		goto out_err;
+		goto out_err_unlock;
 	if (reason_code > 0)
-		goto decline_rdma;
+		goto decline_rdma_unlock;
 	smc_conn_save_peer_info(new_smc, &cclc);
 	if (local_contact == SMC_FIRST_CONTACT)
 		smc_link_save_peer_info(link, &cclc);
@@ -855,34 +855,34 @@ static void smc_listen_work(struct work_struct *work)
 	rc = smc_rmb_rtoken_handling(&new_smc->conn, &cclc);
 	if (rc) {
 		reason_code = SMC_CLC_DECL_INTERR;
-		goto decline_rdma;
+		goto decline_rdma_unlock;
 	}
 
 	if (local_contact == SMC_FIRST_CONTACT) {
 		rc = smc_ib_ready_link(link);
 		if (rc) {
 			reason_code = SMC_CLC_DECL_INTERR;
-			goto decline_rdma;
+			goto decline_rdma_unlock;
 		}
 		/* QP confirmation over RoCE fabric */
 		reason_code = smc_serv_conf_first_link(new_smc);
 		if (reason_code < 0) {
 			/* peer is not aware of a problem */
 			rc = reason_code;
-			goto out_err;
+			goto out_err_unlock;
 		}
 		if (reason_code > 0)
-			goto decline_rdma;
+			goto decline_rdma_unlock;
 	}
 
 	smc_tx_init(new_smc);
+	mutex_unlock(&smc_create_lgr_pending);
 
 out_connected:
 	sk_refcnt_debug_inc(newsmcsk);
 	if (newsmcsk->sk_state == SMC_INIT)
 		newsmcsk->sk_state = SMC_ACTIVE;
 enqueue:
-	mutex_unlock(&smc_create_lgr_pending);
 	lock_sock_nested(&lsmc->sk, SINGLE_DEPTH_NESTING);
 	if (lsmc->sk.sk_state == SMC_LISTEN) {
 		smc_accept_enqueue(&lsmc->sk, newsmcsk);
@@ -896,6 +896,8 @@ static void smc_listen_work(struct work_struct *work)
 	sock_put(&lsmc->sk); /* sock_hold in smc_tcp_listen_work */
 	return;
 
+decline_rdma_unlock:
+	mutex_unlock(&smc_create_lgr_pending);
 decline_rdma:
 	/* RDMA setup failed, switch back to TCP */
 	smc_conn_free(&new_smc->conn);
@@ -907,6 +909,8 @@ static void smc_listen_work(struct work_struct *work)
 	}
 	goto out_connected;
 
+out_err_unlock:
+	mutex_unlock(&smc_create_lgr_pending);
 out_err:
 	newsmcsk->sk_state = SMC_CLOSED;
 	smc_conn_free(&new_smc->conn);
-- 
2.13.5
