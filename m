From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 2/6] net/smc: handle state SMC_PEERFINCLOSEWAIT correctly
Date: Thu, 25 Jan 2018 11:15:32 +0100
Message-ID: <20180125101536.15727-3-ubraun@linux.vnet.ibm.com>
References: <20180125101536.15727-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180125101536.15727-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

A state transition from closing state SMC_PEERFINCLOSEWAIT to closing
state SMC_APPFINCLOSEWAIT is not allowed. Once a closing indication
from the peer has been received, the socket reaches state SMC_CLOSED.

And receiving a peer_conn_abort just changes the state of the socket
into one of the states SMC_PROCESSABORT or SMC_CLOSED;
sending a peer_conn_abort occurs in smc_close_active() for state
SMC_PROCESSABORT only.

Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 net/smc/smc_close.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
index 6de909612bd0..3dc109f5db56 100644
--- a/net/smc/smc_close.c
+++ b/net/smc/smc_close.c
@@ -280,7 +280,6 @@ static void smc_close_passive_abort_received(struct smc_sock *smc)
 	case SMC_APPFINCLOSEWAIT:
 	case SMC_APPCLOSEWAIT1:
 	case SMC_APPCLOSEWAIT2:
-		smc_close_abort(&smc->conn);
 		sk->sk_state = SMC_PROCESSABORT;
 		break;
 	case SMC_PEERCLOSEWAIT1:
@@ -288,7 +287,6 @@ static void smc_close_passive_abort_received(struct smc_sock *smc)
 		if (txflags->peer_done_writing &&
 		    !smc_close_sent_any_close(&smc->conn)) {
 			/* just shutdown, but not yet closed locally */
-			smc_close_abort(&smc->conn);
 			sk->sk_state = SMC_PROCESSABORT;
 		} else {
 			sk->sk_state = SMC_CLOSED;
@@ -354,7 +352,6 @@ static void smc_close_passive_work(struct work_struct *work)
 		/* fall through */
 		/* to check for closing */
 	case SMC_PEERCLOSEWAIT2:
-	case SMC_PEERFINCLOSEWAIT:
 		if (!smc_cdc_rxed_any_close(conn))
 			break;
 		if (sock_flag(sk, SOCK_DEAD) &&
@@ -366,6 +363,10 @@ static void smc_close_passive_work(struct work_struct *work)
 			sk->sk_state = SMC_APPFINCLOSEWAIT;
 		}
 		break;
+	case SMC_PEERFINCLOSEWAIT:
+		if (smc_cdc_rxed_any_close(conn))
+			sk->sk_state = SMC_CLOSED;
+		break;
 	case SMC_APPCLOSEWAIT1:
 	case SMC_APPCLOSEWAIT2:
 	case SMC_APPFINCLOSEWAIT:
-- 
2.13.5
