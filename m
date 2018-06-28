From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 03/10] net/smc: optimize consumer cursor updates
Date: Thu, 28 Jun 2018 19:05:06 +0200
Message-ID: <20180628170513.5089-4-ubraun@linux.ibm.com>
References: <20180628170513.5089-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180628170513.5089-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, hwippel@linux.ibm.com, sebott@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@de.ibm.com>

The SMC protocol requires to send a separate consumer cursor update,
if it cannot be piggybacked to updates of the producer cursor.
Currently the decision to send a separate consumer cursor update
just considers the amount of data already received by the socket
program. It does not consider the amount of data already arrived, but
not yet consumed by the receiver. Basing the decision on the
difference between already confirmed and already arrived data
(instead of difference between already confirmed and already consumed
data), may lead to a somewhat earlier consumer cursor update send in
fast unidirectional traffic scenarios, and thus to better throughput.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Suggested-by: Thomas Richter <tmricht@linux.ibm.com>
---
 net/smc/smc_tx.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index cee666400752..f82886b7d1d8 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -495,7 +495,8 @@ void smc_tx_work(struct work_struct *work)
 
 void smc_tx_consumer_update(struct smc_connection *conn, bool force)
 {
-	union smc_host_cursor cfed, cons;
+	union smc_host_cursor cfed, cons, prod;
+	int sender_free = conn->rmb_desc->len;
 	int to_confirm;
 
 	smc_curs_write(&cons,
@@ -505,11 +506,18 @@ void smc_tx_consumer_update(struct smc_connection *conn, bool force)
 		       smc_curs_read(&conn->rx_curs_confirmed, conn),
 		       conn);
 	to_confirm = smc_curs_diff(conn->rmb_desc->len, &cfed, &cons);
+	if (to_confirm > conn->rmbe_update_limit) {
+		smc_curs_write(&prod,
+			       smc_curs_read(&conn->local_rx_ctrl.prod, conn),
+			       conn);
+		sender_free = conn->rmb_desc->len -
+			      smc_curs_diff(conn->rmb_desc->len, &prod, &cfed);
+	}
 
 	if (conn->local_rx_ctrl.prod_flags.cons_curs_upd_req ||
 	    force ||
 	    ((to_confirm > conn->rmbe_update_limit) &&
-	     ((to_confirm > (conn->rmb_desc->len / 2)) ||
+	     ((sender_free <= (conn->rmb_desc->len / 2)) ||
 	      conn->local_rx_ctrl.prod_flags.write_blocked))) {
 		if ((smc_cdc_get_slot_and_msg_send(conn) < 0) &&
 		    conn->alert_token_local) { /* connection healthy */
-- 
2.16.4
