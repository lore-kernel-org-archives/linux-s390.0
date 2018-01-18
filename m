Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 18 Jan 2018 17:33:23 -0600
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] smc: return boolean instead of integer in using_ipsec
Message-ID: <20180118233323.GA22539@embeddedor.com>
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

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 net/smc/smc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc.h b/net/smc/smc.h
index 0bee9d1..ef13af4 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -258,7 +258,7 @@ static inline bool using_ipsec(struct smc_sock *smc)
 #else
 static inline bool using_ipsec(struct smc_sock *smc)
 {
-	return 0;
+	return false;
 }
 #endif
 
-- 
2.7.4
