From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 2/6] net/smc: simplify function smc_clcsock_accept()
Date: Wed, 24 Jan 2018 10:28:13 +0100
Message-ID: <20180124092817.103089-3-ubraun@linux.vnet.ibm.com>
References: <20180124092817.103089-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180124092817.103089-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Cleanup to avoid duplicate code in smc_clcsock_accept().
No functional change.

Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 net/smc/af_smc.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index eccccf743b9f..05cbcd3a6f60 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -599,16 +599,9 @@ static int smc_clcsock_accept(struct smc_sock *lsmc, struct smc_sock **new_smc)
 
 	rc = kernel_accept(lsmc->clcsock, &new_clcsock, 0);
 	lock_sock(lsk);
-	if  (rc < 0) {
+	if  (rc < 0)
 		lsk->sk_err = -rc;
-		new_sk->sk_state = SMC_CLOSED;
-		sock_set_flag(new_sk, SOCK_DEAD);
-		new_sk->sk_prot->unhash(new_sk);
-		sock_put(new_sk);
-		*new_smc = NULL;
-		goto out;
-	}
-	if (lsk->sk_state == SMC_CLOSED) {
+	if (rc < 0 || lsk->sk_state == SMC_CLOSED) {
 		if (new_clcsock)
 			sock_release(new_clcsock);
 		new_sk->sk_state = SMC_CLOSED;
-- 
2.13.5
