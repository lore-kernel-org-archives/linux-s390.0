From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 1/4] smc: simplify abort logic
Date: Thu,  3 May 2018 18:12:36 +0200
Message-ID: <20180503161239.71747-2-ubraun@linux.ibm.com>
References: <20180503161239.71747-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180503161239.71747-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Raspl <stefan.raspl@linux.ibm.com>

Some of the conditions to exit recv() are common in two pathes - cleaning up
code by moving the check up so we have it only once.

Signed-off-by: Stefan Raspl <raspl@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com><
---
 net/smc/smc_rx.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index af851d8df1f8..def33fb29ac9 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -112,26 +112,22 @@ int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg, size_t len,
 		if (atomic_read(&conn->bytes_to_rcv))
 			goto copy;
 
+		if (sk->sk_shutdown & RCV_SHUTDOWN ||
+		    smc_cdc_rxed_any_close_or_senddone(conn) ||
+		    conn->local_tx_ctrl.conn_state_flags.peer_conn_abort)
+			break;
+
 		if (read_done) {
 			if (sk->sk_err ||
 			    sk->sk_state == SMC_CLOSED ||
-			    sk->sk_shutdown & RCV_SHUTDOWN ||
 			    !timeo ||
-			    signal_pending(current) ||
-			    smc_cdc_rxed_any_close_or_senddone(conn) ||
-			    conn->local_tx_ctrl.conn_state_flags.
-			    peer_conn_abort)
+			    signal_pending(current))
 				break;
 		} else {
 			if (sk->sk_err) {
 				read_done = sock_error(sk);
 				break;
 			}
-			if (sk->sk_shutdown & RCV_SHUTDOWN ||
-			    smc_cdc_rxed_any_close_or_senddone(conn) ||
-			    conn->local_tx_ctrl.conn_state_flags.
-			    peer_conn_abort)
-				break;
 			if (sk->sk_state == SMC_CLOSED) {
 				if (!sock_flag(sk, SOCK_DONE)) {
 					/* This occurs when user tries to read
-- 
2.13.5
