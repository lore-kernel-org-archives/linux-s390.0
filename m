From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next v3 3/4] net/smc: sockopts TCP_NODELAY and TCP_CORK
Date: Thu, 26 Apr 2018 17:18:22 +0200
Message-ID: <20180426151823.78967-4-ubraun@linux.ibm.com>
References: <20180426151823.78967-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180426151823.78967-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.ibm.com>

Setting sockopt TCP_NODELAY or resetting sockopt TCP_CORK
triggers data transfer.

For a corked SMC socket RDMA writes are deferred, if there is
still sufficient send buffer space available.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c | 20 +++++++++++++++++++-
 net/smc/smc_tx.c | 24 +++++++++++++++++++++---
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index d274be7265ea..9d8b381281e3 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1291,7 +1291,7 @@ static int smc_setsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 	struct smc_sock *smc;
-	int rc;
+	int val, rc;
 
 	smc = smc_sk(sk);
 
@@ -1307,6 +1307,10 @@ static int smc_setsockopt(struct socket *sock, int level, int optname,
 	if (rc)
 		return rc;
 
+	if (optlen < sizeof(int))
+		return rc;
+	get_user(val, (int __user *)optval);
+
 	lock_sock(sk);
 	switch (optname) {
 	case TCP_ULP:
@@ -1322,6 +1326,20 @@ static int smc_setsockopt(struct socket *sock, int level, int optname,
 				rc = -EINVAL;
 		}
 		break;
+	case TCP_NODELAY:
+		if (sk->sk_state != SMC_INIT && sk->sk_state != SMC_LISTEN) {
+			if (val)
+				mod_delayed_work(system_wq, &smc->conn.tx_work,
+						 0);
+		}
+		break;
+	case TCP_CORK:
+		if (sk->sk_state != SMC_INIT && sk->sk_state != SMC_LISTEN) {
+			if (!val)
+				mod_delayed_work(system_wq, &smc->conn.tx_work,
+						 0);
+		}
+		break;
 	default:
 		break;
 	}
diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index 72f004c9c9b1..58dfe0bd9d60 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -19,6 +19,7 @@
 #include <linux/sched/signal.h>
 
 #include <net/sock.h>
+#include <net/tcp.h>
 
 #include "smc.h"
 #include "smc_wr.h"
@@ -26,6 +27,7 @@
 #include "smc_tx.h"
 
 #define SMC_TX_WORK_DELAY	HZ
+#define SMC_TX_CORK_DELAY	(HZ >> 2)	/* 250 ms */
 
 /***************************** sndbuf producer *******************************/
 
@@ -115,6 +117,13 @@ static int smc_tx_wait_memory(struct smc_sock *smc, int flags)
 	return rc;
 }
 
+static bool smc_tx_is_corked(struct smc_sock *smc)
+{
+	struct tcp_sock *tp = tcp_sk(smc->clcsock->sk);
+
+	return (tp->nonagle & TCP_NAGLE_CORK) ? true : false;
+}
+
 /* sndbuf producer: main API called by socket layer.
  * called under sock lock.
  */
@@ -209,7 +218,16 @@ int smc_tx_sendmsg(struct smc_sock *smc, struct msghdr *msg, size_t len)
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
@@ -409,8 +427,8 @@ int smc_tx_sndbuf_nonempty(struct smc_connection *conn)
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
-- 
2.13.5
