Return-Path: <SRS0=wH8C=SN=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 5/5] net/smc: move unhash before release of clcsock
Date: Thu, 11 Apr 2019 11:17:34 +0200
In-Reply-To: <20190411091734.4263-1-ubraun@linux.ibm.com>
References: <20190411091734.4263-1-ubraun@linux.ibm.com>
Message-Id: <20190411091734.4263-6-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, kgraul@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Commit <26d92e951fe0>
("net/smc: move unhash as early as possible in smc_release()")
fixes one occurrence in the smc code, but the same pattern exists
in other places. This patch covers the remaining occurrences and
makes sure, the unhash operation is done before the smc->clcsock is
released. This avoids a potential use-after-free in smc_diag_dump().

Reviewed-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index d2a0d15f809c..6f869ef49b32 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -884,11 +884,11 @@ static int smc_clcsock_accept(struct smc_sock *lsmc, struct smc_sock **new_smc)
 	if  (rc < 0)
 		lsk->sk_err = -rc;
 	if (rc < 0 || lsk->sk_state == SMC_CLOSED) {
+		new_sk->sk_prot->unhash(new_sk);
 		if (new_clcsock)
 			sock_release(new_clcsock);
 		new_sk->sk_state = SMC_CLOSED;
 		sock_set_flag(new_sk, SOCK_DEAD);
-		new_sk->sk_prot->unhash(new_sk);
 		sock_put(new_sk); /* final */
 		*new_smc = NULL;
 		goto out;
@@ -939,11 +939,11 @@ struct sock *smc_accept_dequeue(struct sock *parent,
 
 		smc_accept_unlink(new_sk);
 		if (new_sk->sk_state == SMC_CLOSED) {
+			new_sk->sk_prot->unhash(new_sk);
 			if (isk->clcsock) {
 				sock_release(isk->clcsock);
 				isk->clcsock = NULL;
 			}
-			new_sk->sk_prot->unhash(new_sk);
 			sock_put(new_sk); /* final */
 			continue;
 		}
@@ -973,6 +973,7 @@ void smc_close_non_accepted(struct sock *sk)
 		sock_set_flag(sk, SOCK_DEAD);
 		sk->sk_shutdown |= SHUTDOWN_MASK;
 	}
+	sk->sk_prot->unhash(sk);
 	if (smc->clcsock) {
 		struct socket *tcp;
 
@@ -988,7 +989,6 @@ void smc_close_non_accepted(struct sock *sk)
 			smc_conn_free(&smc->conn);
 	}
 	release_sock(sk);
-	sk->sk_prot->unhash(sk);
 	sock_put(sk); /* final sock_put */
 }
 
-- 
2.16.4
