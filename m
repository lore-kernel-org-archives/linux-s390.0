Return-Path: <SRS0=RTe9=QT=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 4/7] net/smc: reduce amount of status updates to peer
Date: Tue, 12 Feb 2019 16:29:53 +0100
In-Reply-To: <20190212152956.71041-1-ubraun@linux.ibm.com>
References: <20190212152956.71041-1-ubraun@linux.ibm.com>
Message-Id: <20190212152956.71041-5-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>

In smc_cdc_msg_recv_action() the received cdc message is evaluated.
To reduce the number of messaged triggered by this evaluation the logic
is streamlined. For the write_blocked condition we do not need to send
a response immediately. The remaining conditions can be put together
into one if clause.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_cdc.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index 780b36c69292..28bbdb04bc35 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -273,24 +273,18 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
 		smp_mb__after_atomic();
 		smc->sk.sk_data_ready(&smc->sk);
 	} else {
-		if (conn->local_rx_ctrl.prod_flags.write_blocked ||
-		    conn->local_rx_ctrl.prod_flags.cons_curs_upd_req ||
-		    conn->local_rx_ctrl.prod_flags.urg_data_pending) {
-			if (conn->local_rx_ctrl.prod_flags.urg_data_pending)
-				conn->urg_state = SMC_URG_NOTYET;
-			/* force immediate tx of current consumer cursor, but
-			 * under send_lock to guarantee arrival in seqno-order
-			 */
-			if (smc->sk.sk_state != SMC_INIT)
-				smc_tx_sndbuf_nonempty(conn);
-		}
+		if (conn->local_rx_ctrl.prod_flags.write_blocked)
+			smc->sk.sk_data_ready(&smc->sk);
+		if (conn->local_rx_ctrl.prod_flags.urg_data_pending)
+			conn->urg_state = SMC_URG_NOTYET;
 	}
 
-	/* piggy backed tx info */
 	/* trigger sndbuf consumer: RDMA write into peer RMBE and CDC */
-	if (diff_cons && smc_tx_prepared_sends(conn)) {
+	if ((diff_cons && smc_tx_prepared_sends(conn)) ||
+	    conn->local_rx_ctrl.prod_flags.cons_curs_upd_req ||
+	    conn->local_rx_ctrl.prod_flags.urg_data_pending)
 		smc_tx_sndbuf_nonempty(conn);
-	}
+
 	if (diff_cons && conn->urg_tx_pend &&
 	    atomic_read(&conn->peer_rmbe_space) == conn->peer_rmbe_size) {
 		/* urg data confirmed by peer, indicate we're ready for more */
-- 
2.16.4
