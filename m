From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 1/6] net/smc: cancel tx worker in case of socket aborts
Date: Thu, 25 Jan 2018 11:15:31 +0100
Message-ID: <20180125101536.15727-2-ubraun@linux.vnet.ibm.com>
References: <20180125101536.15727-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180125101536.15727-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

If an SMC socket is aborted, the tx worker should be cancelled.

Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 net/smc/smc_close.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
index 1468a2a3cdf4..6de909612bd0 100644
--- a/net/smc/smc_close.c
+++ b/net/smc/smc_close.c
@@ -107,6 +107,9 @@ static void smc_close_active_abort(struct smc_sock *smc)
 	case SMC_INIT:
 	case SMC_ACTIVE:
 		sk->sk_state = SMC_PEERABORTWAIT;
+		release_sock(sk);
+		cancel_delayed_work_sync(&smc->conn.tx_work);
+		lock_sock(sk);
 		break;
 	case SMC_APPCLOSEWAIT1:
 	case SMC_APPCLOSEWAIT2:
@@ -116,6 +119,9 @@ static void smc_close_active_abort(struct smc_sock *smc)
 			sk->sk_state = SMC_PEERABORTWAIT;
 		else
 			sk->sk_state = SMC_CLOSED;
+		release_sock(sk);
+		cancel_delayed_work_sync(&smc->conn.tx_work);
+		lock_sock(sk);
 		break;
 	case SMC_PEERCLOSEWAIT1:
 	case SMC_PEERCLOSEWAIT2:
@@ -249,9 +255,6 @@ int smc_close_active(struct smc_sock *smc)
 		/* peer sending PeerConnectionClosed will cause transition */
 		break;
 	case SMC_PROCESSABORT:
-		release_sock(sk);
-		cancel_delayed_work_sync(&conn->tx_work);
-		lock_sock(sk);
 		smc_close_abort(conn);
 		sk->sk_state = SMC_CLOSED;
 		break;
@@ -327,6 +330,9 @@ static void smc_close_passive_work(struct work_struct *work)
 	rxflags = &conn->local_rx_ctrl.conn_state_flags;
 	if (rxflags->peer_conn_abort) {
 		smc_close_passive_abort_received(smc);
+		release_sock(&smc->sk);
+		cancel_delayed_work_sync(&conn->tx_work);
+		lock_sock(&smc->sk);
 		goto wakeup;
 	}
 
-- 
2.13.5
