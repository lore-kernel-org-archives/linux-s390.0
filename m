From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH net-next] net/smc: fix error return code in smc_setsockopt()
Date: Thu, 31 May 2018 02:31:22 +0000
Message-ID: <1527733882-149144-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: Ursula Braun <ubraun@linux.ibm.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-s390@vger.kernel.org, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Fix to return error code -EINVAL instead of 0 if optlen is invalid.

Fixes: 01d2f7e2cdd3 ("net/smc: sockopts TCP_NODELAY and TCP_CORK")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 net/smc/af_smc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 2c369d4..973b447 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1420,7 +1420,7 @@ static int smc_setsockopt(struct socket *sock, int level, int optname,
 		return rc;
 
 	if (optlen < sizeof(int))
-		return rc;
+		return -EINVAL;
 	get_user(val, (int __user *)optval);
 
 	lock_sock(sk);
