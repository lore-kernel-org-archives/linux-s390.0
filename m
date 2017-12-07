From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 4/6] smc: cleanup close checking during data receival
Date: Thu,  7 Dec 2017 13:38:47 +0100
Message-ID: <20171207123849.52910-5-ubraun@linux.vnet.ibm.com>
References: <20171207123849.52910-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171207123849.52910-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

When waiting for data to be received it must be checked if the
peer signals shutdown. The SMC code uses two different checks
for this purpose, even though just one check is sufficient.
This patch removes the superfluous test for SOCK_DONE.

Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 net/smc/smc_rx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index cbf58637ee14..9dc392ca06bf 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -65,7 +65,6 @@ static int smc_rx_wait_data(struct smc_sock *smc, long *timeo)
 	rc = sk_wait_event(sk, timeo,
 			   sk->sk_err ||
 			   sk->sk_shutdown & RCV_SHUTDOWN ||
-			   sock_flag(sk, SOCK_DONE) ||
 			   atomic_read(&conn->bytes_to_rcv) ||
 			   smc_cdc_rxed_any_close_or_senddone(conn),
 			   &wait);
@@ -116,7 +115,7 @@ int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg, size_t len,
 		if (read_done) {
 			if (sk->sk_err ||
 			    sk->sk_state == SMC_CLOSED ||
-			    (sk->sk_shutdown & RCV_SHUTDOWN) ||
+			    sk->sk_shutdown & RCV_SHUTDOWN ||
 			    !timeo ||
 			    signal_pending(current) ||
 			    smc_cdc_rxed_any_close_or_senddone(conn) ||
@@ -124,8 +123,6 @@ int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg, size_t len,
 			    peer_conn_abort)
 				break;
 		} else {
-			if (sock_flag(sk, SOCK_DONE))
-				break;
 			if (sk->sk_err) {
 				read_done = sock_error(sk);
 				break;
-- 
2.13.5
