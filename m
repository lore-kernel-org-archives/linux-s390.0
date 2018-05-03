From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 3/3] smc: fix sendpage() call
Date: Thu,  3 May 2018 17:57:39 +0200
Message-ID: <20180503155739.55616-4-ubraun@linux.ibm.com>
References: <20180503155739.55616-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180503155739.55616-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Raspl <stefan.raspl@linux.ibm.com>

The sendpage() call grabs the sock lock before calling the default
implementation - which tries to grab it once again.

Signed-off-by: Stefan Raspl <raspl@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com><
---
 net/smc/af_smc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index d03b8d29ffc0..544bab42f925 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1315,8 +1315,11 @@ static ssize_t smc_sendpage(struct socket *sock, struct page *page,
 
 	smc = smc_sk(sk);
 	lock_sock(sk);
-	if (sk->sk_state != SMC_ACTIVE)
+	if (sk->sk_state != SMC_ACTIVE) {
+		release_sock(sk);
 		goto out;
+	}
+	release_sock(sk);
 	if (smc->use_fallback)
 		rc = kernel_sendpage(smc->clcsock, page, offset,
 				     size, flags);
@@ -1324,7 +1327,6 @@ static ssize_t smc_sendpage(struct socket *sock, struct page *page,
 		rc = sock_no_sendpage(sock, page, offset, size, flags);
 
 out:
-	release_sock(sk);
 	return rc;
 }
 
-- 
2.13.5
