From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 6/6] net/smc: continue waiting if peer signals write_shutdown
Date: Wed, 24 Jan 2018 10:28:17 +0100
Message-ID: <20180124092817.103089-7-ubraun@linux.vnet.ibm.com>
References: <20180124092817.103089-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180124092817.103089-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

If the peer sends a shutdown WRITE, this should not affect sending
in general, and waiting for send buffer space in particular.
Stop waiting of the local socket for send buffer space only, if peer
signals closing, but not if peer signals just shutdown WRITE.

Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 net/smc/smc_tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index 2e50fddf8ce9..fea6482233a6 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -86,7 +86,7 @@ static int smc_tx_wait_memory(struct smc_sock *smc, int flags)
 			rc = -EPIPE;
 			break;
 		}
-		if (conn->local_rx_ctrl.conn_state_flags.peer_conn_abort) {
+		if (smc_cdc_rxed_any_close(conn)) {
 			rc = -ECONNRESET;
 			break;
 		}
@@ -107,7 +107,7 @@ static int smc_tx_wait_memory(struct smc_sock *smc, int flags)
 		sk_wait_event(sk, &timeo,
 			      sk->sk_err ||
 			      (sk->sk_shutdown & SEND_SHUTDOWN) ||
-			      smc_cdc_rxed_any_close_or_senddone(conn) ||
+			      smc_cdc_rxed_any_close(conn) ||
 			      atomic_read(&conn->sndbuf_space),
 			      &wait);
 	}
-- 
2.13.5
