From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 5/6] net/smc: improve state change handling after close wait
Date: Wed, 24 Jan 2018 10:28:16 +0100
Message-ID: <20180124092817.103089-6-ubraun@linux.vnet.ibm.com>
References: <20180124092817.103089-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180124092817.103089-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

When a socket is closed or shutdown, smc waits for data being transmitted
in certain states. If the state changes during this wait, the close
switch depending on state should be reentered.
In addition, state change is avoided if sending of close or shutdown fails.

Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 net/smc/smc_close.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
index bc539ccb8fa0..1468a2a3cdf4 100644
--- a/net/smc/smc_close.c
+++ b/net/smc/smc_close.c
@@ -165,9 +165,9 @@ int smc_close_active(struct smc_sock *smc)
 		  0 : sock_flag(sk, SOCK_LINGER) ?
 		      sk->sk_lingertime : SMC_MAX_STREAM_WAIT_TIMEOUT;
 
-again:
 	old_state = sk->sk_state;
-	switch (old_state) {
+again:
+	switch (sk->sk_state) {
 	case SMC_INIT:
 		sk->sk_state = SMC_CLOSED;
 		if (smc->smc_listen_work.func)
@@ -194,6 +194,8 @@ int smc_close_active(struct smc_sock *smc)
 		if (sk->sk_state == SMC_ACTIVE) {
 			/* send close request */
 			rc = smc_close_final(conn);
+			if (rc)
+				break;
 			sk->sk_state = SMC_PEERCLOSEWAIT1;
 		} else {
 			/* peer event has changed the state */
@@ -206,6 +208,8 @@ int smc_close_active(struct smc_sock *smc)
 		    !smc_close_sent_any_close(conn)) {
 			/* just shutdown wr done, send close request */
 			rc = smc_close_final(conn);
+			if (rc)
+				break;
 		}
 		sk->sk_state = SMC_CLOSED;
 		break;
@@ -216,12 +220,13 @@ int smc_close_active(struct smc_sock *smc)
 		release_sock(sk);
 		cancel_delayed_work_sync(&conn->tx_work);
 		lock_sock(sk);
-		if (sk->sk_err != ECONNABORTED) {
-			/* confirm close from peer */
-			rc = smc_close_final(conn);
-			if (rc)
-				break;
-		}
+		if (sk->sk_state != SMC_APPCLOSEWAIT1 &&
+		    sk->sk_state != SMC_APPCLOSEWAIT2)
+			goto again;
+		/* confirm close from peer */
+		rc = smc_close_final(conn);
+		if (rc)
+			break;
 		if (smc_cdc_rxed_any_close(conn))
 			/* peer has closed the socket already */
 			sk->sk_state = SMC_CLOSED;
@@ -235,6 +240,8 @@ int smc_close_active(struct smc_sock *smc)
 		    !smc_close_sent_any_close(conn)) {
 			/* just shutdown wr done, send close request */
 			rc = smc_close_final(conn);
+			if (rc)
+				break;
 		}
 		/* peer sending PeerConnectionClosed will cause transition */
 		break;
@@ -401,20 +408,21 @@ int smc_close_shutdown_write(struct smc_sock *smc)
 		  0 : sock_flag(sk, SOCK_LINGER) ?
 		      sk->sk_lingertime : SMC_MAX_STREAM_WAIT_TIMEOUT;
 
-again:
 	old_state = sk->sk_state;
-	switch (old_state) {
+again:
+	switch (sk->sk_state) {
 	case SMC_ACTIVE:
 		smc_close_stream_wait(smc, timeout);
 		release_sock(sk);
 		cancel_delayed_work_sync(&conn->tx_work);
 		lock_sock(sk);
+		if (sk->sk_state != SMC_ACTIVE)
+			goto again;
 		/* send close wr request */
 		rc = smc_close_wr(conn);
-		if (sk->sk_state == SMC_ACTIVE)
-			sk->sk_state = SMC_PEERCLOSEWAIT1;
-		else
-			goto again;
+		if (rc)
+			break;
+		sk->sk_state = SMC_PEERCLOSEWAIT1;
 		break;
 	case SMC_APPCLOSEWAIT1:
 		/* passive close */
@@ -423,8 +431,12 @@ int smc_close_shutdown_write(struct smc_sock *smc)
 		release_sock(sk);
 		cancel_delayed_work_sync(&conn->tx_work);
 		lock_sock(sk);
+		if (sk->sk_state != SMC_APPCLOSEWAIT1)
+			goto again;
 		/* confirm close from peer */
 		rc = smc_close_wr(conn);
+		if (rc)
+			break;
 		sk->sk_state = SMC_APPCLOSEWAIT2;
 		break;
 	case SMC_APPCLOSEWAIT2:
-- 
2.13.5
