From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 1/3] net/smc: call consolidation
Date: Thu,  3 May 2018 17:57:37 +0200
Message-ID: <20180503155739.55616-2-ubraun@linux.ibm.com>
References: <20180503155739.55616-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180503155739.55616-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>

Consolidate the call to smc_wr_reg_send() in a new function.
No functional changes.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 8b4c059bd13b..fdb2976117bd 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -292,6 +292,15 @@ static void smc_copy_sock_settings_to_smc(struct smc_sock *smc)
 	smc_copy_sock_settings(&smc->sk, smc->clcsock->sk, SK_FLAGS_CLC_TO_SMC);
 }
 
+/* register a new rmb */
+static int smc_reg_rmb(struct smc_link *link, struct smc_buf_desc *rmb_desc)
+{
+	/* register memory region for new rmb */
+	if (smc_wr_reg_send(link, rmb_desc->mr_rx[SMC_SINGLE_LINK]))
+		return -EFAULT;
+	return 0;
+}
+
 static int smc_clnt_conf_first_link(struct smc_sock *smc)
 {
 	struct smc_link_group *lgr = smc->conn.lgr;
@@ -321,9 +330,7 @@ static int smc_clnt_conf_first_link(struct smc_sock *smc)
 
 	smc_wr_remember_qp_attr(link);
 
-	rc = smc_wr_reg_send(link,
-			     smc->conn.rmb_desc->mr_rx[SMC_SINGLE_LINK]);
-	if (rc)
+	if (smc_reg_rmb(link, smc->conn.rmb_desc))
 		return SMC_CLC_DECL_INTERR;
 
 	/* send CONFIRM LINK response over RoCE fabric */
@@ -473,13 +480,8 @@ static int smc_connect_rdma(struct smc_sock *smc)
 			goto decline_rdma_unlock;
 		}
 	} else {
-		struct smc_buf_desc *buf_desc = smc->conn.rmb_desc;
-
-		if (!buf_desc->reused) {
-			/* register memory region for new rmb */
-			rc = smc_wr_reg_send(link,
-					     buf_desc->mr_rx[SMC_SINGLE_LINK]);
-			if (rc) {
+		if (!smc->conn.rmb_desc->reused) {
+			if (smc_reg_rmb(link, smc->conn.rmb_desc)) {
 				reason_code = SMC_CLC_DECL_INTERR;
 				goto decline_rdma_unlock;
 			}
@@ -719,9 +721,7 @@ static int smc_serv_conf_first_link(struct smc_sock *smc)
 
 	link = &lgr->lnk[SMC_SINGLE_LINK];
 
-	rc = smc_wr_reg_send(link,
-			     smc->conn.rmb_desc->mr_rx[SMC_SINGLE_LINK]);
-	if (rc)
+	if (smc_reg_rmb(link, smc->conn.rmb_desc))
 		return SMC_CLC_DECL_INTERR;
 
 	/* send CONFIRM LINK request to client over the RoCE fabric */
@@ -854,13 +854,8 @@ static void smc_listen_work(struct work_struct *work)
 	smc_rx_init(new_smc);
 
 	if (local_contact != SMC_FIRST_CONTACT) {
-		struct smc_buf_desc *buf_desc = new_smc->conn.rmb_desc;
-
-		if (!buf_desc->reused) {
-			/* register memory region for new rmb */
-			rc = smc_wr_reg_send(link,
-					     buf_desc->mr_rx[SMC_SINGLE_LINK]);
-			if (rc) {
+		if (!new_smc->conn.rmb_desc->reused) {
+			if (smc_reg_rmb(link, new_smc->conn.rmb_desc)) {
 				reason_code = SMC_CLC_DECL_INTERR;
 				goto decline_rdma_unlock;
 			}
-- 
2.13.5
