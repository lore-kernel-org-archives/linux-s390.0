Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 3/5] net/smc: enable fallback for connection abort in state INIT
Date: Tue, 18 Sep 2018 15:46:36 +0200
In-Reply-To: <20180918134638.90271-1-ubraun@linux.ibm.com>
References: <20180918134638.90271-1-ubraun@linux.ibm.com>
Message-Id: <20180918134638.90271-4-ubraun@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

If a linkgroup is terminated abnormally already due to failing
LLC CONFIRM LINK or LLC ADD LINK, fallback to TCP is still possible.
In this case do not switch to state SMC_PEERABORTWAIT and do not set
sk_err.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_close.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
index ac961dfb1ea1..ea2b87f29469 100644
--- a/net/smc/smc_close.c
+++ b/net/smc/smc_close.c
@@ -100,15 +100,14 @@ static void smc_close_active_abort(struct smc_sock *smc)
 	struct smc_cdc_conn_state_flags *txflags =
 		&smc->conn.local_tx_ctrl.conn_state_flags;
 
-	sk->sk_err = ECONNABORTED;
-	if (smc->clcsock && smc->clcsock->sk) {
-		smc->clcsock->sk->sk_err = ECONNABORTED;
-		smc->clcsock->sk->sk_state_change(smc->clcsock->sk);
+	if (sk->sk_state != SMC_INIT && smc->clcsock && smc->clcsock->sk) {
+		sk->sk_err = ECONNABORTED;
+		if (smc->clcsock && smc->clcsock->sk) {
+			smc->clcsock->sk->sk_err = ECONNABORTED;
+			smc->clcsock->sk->sk_state_change(smc->clcsock->sk);
+		}
 	}
 	switch (sk->sk_state) {
-	case SMC_INIT:
-		sk->sk_state = SMC_PEERABORTWAIT;
-		break;
 	case SMC_ACTIVE:
 		sk->sk_state = SMC_PEERABORTWAIT;
 		release_sock(sk);
@@ -143,6 +142,7 @@ static void smc_close_active_abort(struct smc_sock *smc)
 	case SMC_PEERFINCLOSEWAIT:
 		sock_put(sk); /* passive closing */
 		break;
+	case SMC_INIT:
 	case SMC_PEERABORTWAIT:
 	case SMC_CLOSED:
 		break;
-- 
2.16.4
