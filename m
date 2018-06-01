From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 1/1] net/smc: remove duplicate check in smc_setsockopt
Date: Fri,  1 Jun 2018 16:58:39 +0200
Message-ID: <20180601145839.22566-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.ibm.com>

smc_setsockopt contains a check for the length specified on the
setsockopt socket call. If checked, it is supposed to return with
EINVAL. But the equivalent check is already contained in the preceding
setsockopt call on the internal TCP socket. That means, the extra
check can be removed.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Fixes: 01d2f7e2cdd3 ("net/smc: sockopts TCP_NODELAY and TCP_CORK")
Reported-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 net/smc/af_smc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 2c369d4bb1c1..dec3f09f6327 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1419,8 +1419,6 @@ static int smc_setsockopt(struct socket *sock, int level, int optname,
 	if (rc)
 		return rc;
 
-	if (optlen < sizeof(int))
-		return rc;
 	get_user(val, (int __user *)optval);
 
 	lock_sock(sk);
-- 
2.16.3
