Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 19 Jan 2018 14:54:50 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2] smc: return booleans instead of integers
Message-ID: <20180119205450.GA10785@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ursula Braun <ubraun@linux.vnet.ibm.com>, "David S. Miller" <davem@davemloft.net>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-ID: <linux-s390.vger.kernel.org>

Return statements in functions returning bool should use
true/false instead of 1/0.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - Fix function using_ipsec as suggested by Ursula Braun.
 - Update subject line.

 net/smc/smc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc.h b/net/smc/smc.h
index 0bee9d1..6328565 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -253,12 +253,12 @@ static inline int smc_uncompress_bufsize(u8 compressed)
 static inline bool using_ipsec(struct smc_sock *smc)
 {
 	return (smc->clcsock->sk->sk_policy[0] ||
-		smc->clcsock->sk->sk_policy[1]) ? 1 : 0;
+		smc->clcsock->sk->sk_policy[1]) ? true : false;
 }
 #else
 static inline bool using_ipsec(struct smc_sock *smc)
 {
-	return 0;
+	return false;
 }
 #endif
 
-- 
2.7.4
