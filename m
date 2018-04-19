From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next v2 3/4] net/smc: handle sockopt TCP_CORK
Date: Thu, 19 Apr 2018 15:56:54 +0200
Message-ID: <20180419135655.3058-4-ubraun@linux.ibm.com>
References: <20180419135655.3058-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180419135655.3058-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.vnet.ibm.com>

TCP sockopts must not interfere with the CLC handshake on the
CLC socket. Therefore, we defer some of them till the CLC
handshake has completed, like setting TCP_CORK.

For a corked SMC socket RDMA writes are deferred, if there is
still sufficient send buffer space available.

Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 net/smc/af_smc.c | 36 +++++++++++++++++++++++++++++++++++-
 net/smc/smc.h    |  4 ++++
 net/smc/smc_tx.c | 16 +++++++++++++---
 net/smc/smc_tx.h |  8 ++++++++
 4 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 297c2cb93b34..27d3aa8d0181 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -389,8 +389,16 @@ static int smc_apply_deferred_sockopts(struct smc_sock *smc)
 		val = 0;
 		rc = kernel_setsockopt(smc->clcsock, SOL_TCP, TCP_NODELAY,
 				       (char *)&val, sizeof(val));
+		if (rc)
+			return rc;
+		opt_smc->deferred_nodelay_reset = 0;
+	}
+	if (opt_smc->deferred_cork_set) {
+		val = 1;
+		rc = kernel_setsockopt(smc->clcsock, SOL_TCP, TCP_CORK,
+				       (char *)&val, sizeof(val));
 		if (!rc)
-			opt_smc->deferred_nodelay_reset = 0;
+			opt_smc->deferred_cork_set = 0;
 	}
 	return rc;
 }
@@ -1327,6 +1335,9 @@ static int smc_setsockopt(struct socket *sock, int level, int optname,
 	switch (optname) {
 	case TCP_NODELAY:
 		if (sk->sk_state != SMC_INIT && sk->sk_state != SMC_LISTEN) {
+			if (val && smc_tx_is_corked(smc))
+				mod_delayed_work(system_wq, &smc->conn.tx_work,
+						 0);
 			release_sock(sk);
 			goto clcsock;
 		}
@@ -1339,6 +1350,23 @@ static int smc_setsockopt(struct socket *sock, int level, int optname,
 		else
 			smc->deferred_nodelay_reset = 1;
 		break;
+	case TCP_CORK:
+		if (sk->sk_state != SMC_INIT && sk->sk_state != SMC_LISTEN) {
+			if (!val)
+				mod_delayed_work(system_wq, &smc->conn.tx_work,
+						 0);
+			release_sock(sk);
+			goto clcsock;
+		}
+		/* for the CLC-handshake TCP_CORK is not desired;
+		 * in case of fallback to TCP, cork setting is
+		 * triggered afterwards.
+		 */
+		if (val)
+			smc->deferred_cork_set = 1;
+		else
+			smc->deferred_cork_set = 0;
+		break;
 	case TCP_FASTOPEN:
 	case TCP_FASTOPEN_CONNECT:
 	case TCP_FASTOPEN_KEY:
@@ -1395,6 +1423,12 @@ static int smc_getsockopt(struct socket *sock, int level, int optname,
 		else
 			goto clcsock;
 		break;
+	case TCP_CORK:
+		if (smc->deferred_cork_set)
+			val = 1;
+		else
+			goto clcsock;
+		break;
 	default:
 		goto clcsock;
 	}
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 6dfc1c90bed2..38888da5a5ea 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -189,6 +189,10 @@ struct smc_sock {				/* smc sock container */
 						/* defer Nagle after CLC
 						 * handshake
 						 */
+	u8			deferred_cork_set : 1;
+						/* defer corking after CLC
+						 * handshake
+						 */
 };
 
 static inline struct smc_sock *smc_sk(const struct sock *sk)
diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index 72f004c9c9b1..a31377bb400b 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -26,6 +26,7 @@
 #include "smc_tx.h"
 
 #define SMC_TX_WORK_DELAY	HZ
+#define SMC_TX_CORK_DELAY	(HZ >> 2)	/* 250 ms */
 
 /***************************** sndbuf producer *******************************/
 
@@ -209,7 +210,16 @@ int smc_tx_sendmsg(struct smc_sock *smc, struct msghdr *msg, size_t len)
 		/* since we just produced more new data into sndbuf,
 		 * trigger sndbuf consumer: RDMA write into peer RMBE and CDC
 		 */
-		smc_tx_sndbuf_nonempty(conn);
+		if ((msg->msg_flags & MSG_MORE || smc_tx_is_corked(smc)) &&
+		    (atomic_read(&conn->sndbuf_space) >
+						(conn->sndbuf_size >> 1)))
+			/* for a corked socket defer the RDMA writes if there
+			 * is still sufficient sndbuf_space available
+			 */
+			schedule_delayed_work(&conn->tx_work,
+					      SMC_TX_CORK_DELAY);
+		else
+			smc_tx_sndbuf_nonempty(conn);
 	} /* while (msg_data_left(msg)) */
 
 	return send_done;
@@ -409,8 +419,8 @@ int smc_tx_sndbuf_nonempty(struct smc_connection *conn)
 			}
 			rc = 0;
 			if (conn->alert_token_local) /* connection healthy */
-				schedule_delayed_work(&conn->tx_work,
-						      SMC_TX_WORK_DELAY);
+				mod_delayed_work(system_wq, &conn->tx_work,
+						 SMC_TX_WORK_DELAY);
 		}
 		goto out_unlock;
 	}
diff --git a/net/smc/smc_tx.h b/net/smc/smc_tx.h
index 78255964fa4d..e5f4188b4bdb 100644
--- a/net/smc/smc_tx.h
+++ b/net/smc/smc_tx.h
@@ -14,6 +14,7 @@
 
 #include <linux/socket.h>
 #include <linux/types.h>
+#include <net/tcp.h>
 
 #include "smc.h"
 #include "smc_cdc.h"
@@ -27,6 +28,13 @@ static inline int smc_tx_prepared_sends(struct smc_connection *conn)
 	return smc_curs_diff(conn->sndbuf_size, &sent, &prep);
 }
 
+static inline bool smc_tx_is_corked(struct smc_sock *smc)
+{
+	struct tcp_sock *tp = tcp_sk(smc->clcsock->sk);
+
+	return (tp->nonagle & TCP_NAGLE_CORK) ? true : false;
+}
+
 void smc_tx_init(struct smc_sock *smc);
 int smc_tx_sendmsg(struct smc_sock *smc, struct msghdr *msg, size_t len);
 int smc_tx_sndbuf_nonempty(struct smc_connection *conn);
-- 
2.13.5
