From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 09/10] net/smc: destruct non-accepted sockets
Date: Mon, 10 Apr 2017 14:58:04 +0200
Message-ID: <20170410125805.13653-10-ubraun@linux.vnet.ibm.com>
References: <20170410125805.13653-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170410125805.13653-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Make sure sockets never accepted are removed cleanly.

Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 net/smc/af_smc.c    | 14 +++++++++-----
 net/smc/smc_close.c |  1 -
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 491a8b2..5b6ee21 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -638,7 +638,8 @@ struct sock *smc_accept_dequeue(struct sock *parent,
 
 		smc_accept_unlink(new_sk);
 		if (new_sk->sk_state == SMC_CLOSED) {
-			/* tbd in follow-on patch: close this sock */
+			new_sk->sk_prot->unhash(new_sk);
+			sock_put(new_sk);
 			continue;
 		}
 		if (new_sock)
@@ -658,8 +659,13 @@ void smc_close_non_accepted(struct sock *sk)
 	if (!sk->sk_lingertime)
 		/* wait for peer closing */
 		sk->sk_lingertime = SMC_MAX_STREAM_WAIT_TIMEOUT;
-	if (!smc->use_fallback)
+	if (smc->use_fallback) {
+		sk->sk_state = SMC_CLOSED;
+	} else {
 		smc_close_active(smc);
+		sock_set_flag(sk, SOCK_DEAD);
+		sk->sk_shutdown |= SHUTDOWN_MASK;
+	}
 	if (smc->clcsock) {
 		struct socket *tcp;
 
@@ -667,11 +673,9 @@ void smc_close_non_accepted(struct sock *sk)
 		smc->clcsock = NULL;
 		sock_release(tcp);
 	}
-	sock_set_flag(sk, SOCK_DEAD);
-	sk->sk_shutdown |= SHUTDOWN_MASK;
 	if (smc->use_fallback) {
 		schedule_delayed_work(&smc->sock_put_work, TCP_TIMEWAIT_LEN);
-	} else {
+	} else if (sk->sk_state == SMC_CLOSED) {
 		smc_conn_free(&smc->conn);
 		schedule_delayed_work(&smc->sock_put_work,
 				      SMC_CLOSE_SOCK_PUT_DELAY);
diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
index 9070720b..3c2e166 100644
--- a/net/smc/smc_close.c
+++ b/net/smc/smc_close.c
@@ -191,7 +191,6 @@ int smc_close_active(struct smc_sock *smc)
 		sk->sk_state = SMC_CLOSED;
 		if (smc->smc_listen_work.func)
 			cancel_work_sync(&smc->smc_listen_work);
-		sock_put(sk);
 		break;
 	case SMC_LISTEN:
 		sk->sk_state = SMC_CLOSED;
-- 
2.10.2
