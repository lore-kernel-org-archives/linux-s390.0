From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 08/10] net/smc: remove duplicate unhash
Date: Mon, 10 Apr 2017 14:58:03 +0200
Message-ID: <20170410125805.13653-9-ubraun@linux.vnet.ibm.com>
References: <20170410125805.13653-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170410125805.13653-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

unhash is already called in sock_put_work. Remove the second call.

Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 net/smc/af_smc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 3b7eda6..491a8b2 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -147,7 +147,6 @@ static int smc_release(struct socket *sock)
 		schedule_delayed_work(&smc->sock_put_work,
 				      SMC_CLOSE_SOCK_PUT_DELAY);
 	}
-	sk->sk_prot->unhash(sk);
 	release_sock(sk);
 
 	sock_put(sk);
-- 
2.10.2
