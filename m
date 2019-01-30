Return-Path: <SRS0=auZG=QG=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 6/9] net/smc: do not wait under send_lock
Date: Wed, 30 Jan 2019 18:51:05 +0100
In-Reply-To: <20190130175108.103221-1-ubraun@linux.ibm.com>
References: <20190130175108.103221-1-ubraun@linux.ibm.com>
Message-Id: <20190130175108.103221-7-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>

smc_cdc_get_free_slot() might wait for free transfer buffers when using
SMC-R. This wait should not be done under the send_lock, which is a
spin_lock. This fixes a cpu loop in parallel threads waiting for the
send_lock.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_tx.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index f99951f3f7fd..36af3de731b9 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -488,25 +488,23 @@ static int smcr_tx_sndbuf_nonempty(struct smc_connection *conn)
 	struct smc_wr_buf *wr_buf;
 	int rc;
 
-	spin_lock_bh(&conn->send_lock);
 	rc = smc_cdc_get_free_slot(conn, &wr_buf, &pend);
 	if (rc < 0) {
 		if (rc == -EBUSY) {
 			struct smc_sock *smc =
 				container_of(conn, struct smc_sock, conn);
 
-			if (smc->sk.sk_err == ECONNABORTED) {
-				rc = sock_error(&smc->sk);
-				goto out_unlock;
-			}
+			if (smc->sk.sk_err == ECONNABORTED)
+				return sock_error(&smc->sk);
 			rc = 0;
 			if (conn->alert_token_local) /* connection healthy */
 				mod_delayed_work(system_wq, &conn->tx_work,
 						 SMC_TX_WORK_DELAY);
 		}
-		goto out_unlock;
+		return rc;
 	}
 
+	spin_lock_bh(&conn->send_lock);
 	if (!conn->local_tx_ctrl.prod_flags.urg_data_present) {
 		rc = smc_tx_rdma_writes(conn);
 		if (rc) {
-- 
2.16.4
