From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 4/4] net/smc: handle sockopt TCP_DEFER_ACCEPT
Date: Tue, 17 Apr 2018 17:18:15 +0200
Message-ID: <20180417151815.77191-5-ubraun@linux.ibm.com>
References: <20180417151815.77191-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180417151815.77191-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.vnet.ibm.com>

TCP sockopt setting of TCP_DEFER_ACCEPT should just be applied
to the SMC socket, but not to the internal CLC socket.

If set, the accept is delayed till data is available.

Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 net/smc/af_smc.c | 36 +++++++++++++++++++++++++++++++++++-
 net/smc/smc.h    |  4 ++++
 net/smc/smc_rx.c |  2 +-
 net/smc/smc_rx.h |  1 +
 4 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index c3a950c6950d..2440e9b8d3b7 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1092,9 +1092,29 @@ static int smc_accept(struct socket *sock, struct socket *new_sock,
 
 	if (!rc)
 		rc = sock_error(nsk);
+	release_sock(sk);
+	if (rc)
+		goto out;
+
+	if (lsmc->sockopt_defer_accept && !(flags & O_NONBLOCK)) {
+		/* wait till data arrives on the socket */
+		timeo = msecs_to_jiffies(lsmc->sockopt_defer_accept *
+								MSEC_PER_SEC);
+		if (smc_sk(nsk)->use_fallback) {
+			struct sock *clcsk = smc_sk(nsk)->clcsock->sk;
+
+			lock_sock(clcsk);
+			if (skb_queue_empty(&clcsk->sk_receive_queue))
+				sk_wait_data(clcsk, &timeo, NULL);
+			release_sock(clcsk);
+		} else if (!atomic_read(&smc_sk(nsk)->conn.bytes_to_rcv)) {
+			lock_sock(nsk);
+			smc_rx_wait_data(smc_sk(nsk), &timeo);
+			release_sock(nsk);
+		}
+	}
 
 out:
-	release_sock(sk);
 	sock_put(sk); /* sock_hold above */
 	return rc;
 }
@@ -1361,6 +1381,14 @@ static int smc_setsockopt(struct socket *sock, int level, int optname,
 		else
 			smc->deferred_cork_set = 0;
 		break;
+	case TCP_DEFER_ACCEPT:
+		if (sk->sk_state != SMC_INIT && sk->sk_state != SMC_LISTEN) {
+			release_sock(sk);
+			goto clcsock;
+		}
+		/* for the CLC-handshake TCP_DEFER_ACCEPT is not desired */
+		smc->sockopt_defer_accept = val;
+		break;
 	case TCP_FASTOPEN:
 	case TCP_FASTOPEN_CONNECT:
 	case TCP_FASTOPEN_KEY:
@@ -1417,6 +1445,12 @@ static int smc_getsockopt(struct socket *sock, int level, int optname,
 		else
 			goto clcsock;
 		break;
+	case TCP_DEFER_ACCEPT:
+		if (smc->sockopt_defer_accept)
+			val = smc->sockopt_defer_accept;
+		else
+			goto clcsock;
+		break;
 	default:
 		goto clcsock;
 	}
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 38888da5a5ea..11f869d1f28a 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -180,6 +180,10 @@ struct smc_sock {				/* smc sock container */
 	struct list_head	accept_q;	/* sockets to be accepted */
 	spinlock_t		accept_q_lock;	/* protects accept_q */
 	bool			use_fallback;	/* fallback to tcp */
+	int			sockopt_defer_accept;
+						/* sockopt TCP_DEFER_ACCEPT
+						 * value
+						 */
 	u8			wait_close_tx_prepared : 1;
 						/* shutdown wr or close
 						 * started, waiting for unsent
diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index eff4e0d0bb31..af851d8df1f8 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -51,7 +51,7 @@ static void smc_rx_data_ready(struct sock *sk)
  * 1 if at least 1 byte available in rcvbuf or if socket error/shutdown.
  * 0 otherwise (nothing in rcvbuf nor timeout, e.g. interrupted).
  */
-static int smc_rx_wait_data(struct smc_sock *smc, long *timeo)
+int smc_rx_wait_data(struct smc_sock *smc, long *timeo)
 {
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 	struct smc_connection *conn = &smc->conn;
diff --git a/net/smc/smc_rx.h b/net/smc/smc_rx.h
index 3a32b59bf06c..0b75a6b470e6 100644
--- a/net/smc/smc_rx.h
+++ b/net/smc/smc_rx.h
@@ -20,5 +20,6 @@
 void smc_rx_init(struct smc_sock *smc);
 int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg, size_t len,
 		   int flags);
+int smc_rx_wait_data(struct smc_sock *smc, long *timeo);
 
 #endif /* SMC_RX_H */
-- 
2.13.5
