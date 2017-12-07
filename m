From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 5/6] smc: no consumer update in tasklet context
Date: Thu,  7 Dec 2017 13:38:48 +0100
Message-ID: <20171207123849.52910-6-ubraun@linux.vnet.ibm.com>
References: <20171207123849.52910-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171207123849.52910-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

The SMC protocol requires to send a separate consumer cursor update,
if it cannot be piggybacked to updates of the producer cursor.
When receiving a blocked signal from the sender, this update is sent
already in tasklet context. In addition consumer cursor updates are
sent after data receival.
Sending of cursor updates is controlled by sequence numbers.
Assuming receiving stray messages the receiver drops updates with older
sequence numbers than an already received cursor update with a higher
sequence number.
Sending consumer cursor updates in tasklet context may result in
wrong order sends and its corresponding drops at the receiver. Since
it is sufficient to send consumer cursor updates once the data is
received, this patch gets rid of the consumer cursor update in tasklet
context to guarantee in-sequence arrival of cursor updates.

Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 net/smc/smc_cdc.c | 12 +++---------
 net/smc/smc_tx.c  |  9 ++-------
 2 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index 87f7bede6eab..d4155ff6acde 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -213,6 +213,9 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
 		/* guarantee 0 <= bytes_to_rcv <= rmbe_size */
 		smp_mb__after_atomic();
 		smc->sk.sk_data_ready(&smc->sk);
+	} else if ((conn->local_rx_ctrl.prod_flags.write_blocked) ||
+		   (conn->local_rx_ctrl.prod_flags.cons_curs_upd_req)) {
+		smc->sk.sk_data_ready(&smc->sk);
 	}
 
 	if (conn->local_rx_ctrl.conn_state_flags.peer_conn_abort) {
@@ -234,15 +237,6 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
 		/* trigger socket release if connection closed */
 		smc_close_wake_tx_prepared(smc);
 	}
-
-	/* socket connected but not accepted */
-	if (!smc->sk.sk_socket)
-		return;
-
-	/* data available */
-	if ((conn->local_rx_ctrl.prod_flags.write_blocked) ||
-	    (conn->local_rx_ctrl.prod_flags.cons_curs_upd_req))
-		smc_tx_consumer_update(conn);
 }
 
 /* called under tasklet context */
diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index 77555c6ed199..2e50fddf8ce9 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -448,9 +448,7 @@ static void smc_tx_work(struct work_struct *work)
 void smc_tx_consumer_update(struct smc_connection *conn)
 {
 	union smc_host_cursor cfed, cons;
-	struct smc_cdc_tx_pend *pend;
-	struct smc_wr_buf *wr_buf;
-	int to_confirm, rc;
+	int to_confirm;
 
 	smc_curs_write(&cons,
 		       smc_curs_read(&conn->local_tx_ctrl.cons, conn),
@@ -464,10 +462,7 @@ void smc_tx_consumer_update(struct smc_connection *conn)
 	    ((to_confirm > conn->rmbe_update_limit) &&
 	     ((to_confirm > (conn->rmbe_size / 2)) ||
 	      conn->local_rx_ctrl.prod_flags.write_blocked))) {
-		rc = smc_cdc_get_free_slot(conn, &wr_buf, &pend);
-		if (!rc)
-			rc = smc_cdc_msg_send(conn, wr_buf, pend);
-		if (rc < 0) {
+		if (smc_cdc_get_slot_and_msg_send(conn) < 0) {
 			schedule_delayed_work(&conn->tx_work,
 					      SMC_TX_WORK_DELAY);
 			return;
-- 
2.13.5
