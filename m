From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 4/4] net/smc: longer delay when freeing client link groups
Date: Wed, 23 May 2018 16:38:12 +0200
Message-ID: <20180523143812.25824-5-ubraun@linux.ibm.com>
References: <20180523143812.25824-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180523143812.25824-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Client link group creation always follows the server linkgroup creation.
If peer creates a new server link group, client has to create a new
client link group. If peer reuses a server link group for a new
connection, client has to reuse its client link group as well. To
avoid out-of-sync conditions for link groups a longer delay for
for client link group removal is defined to make sure this link group
still exists, once the peer decides to reuse a server link group.

Currently the client link group delay time is just 10 jiffies larger
than the server link group delay time. This patch increases the delay
difference to 10 seconds to have a better protection against
out-of-sync link groups.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 2bf138e7d3ec..add82b0266f3 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -28,7 +28,7 @@
 
 #define SMC_LGR_NUM_INCR		256
 #define SMC_LGR_FREE_DELAY_SERV		(600 * HZ)
-#define SMC_LGR_FREE_DELAY_CLNT		(SMC_LGR_FREE_DELAY_SERV + 10)
+#define SMC_LGR_FREE_DELAY_CLNT		(SMC_LGR_FREE_DELAY_SERV + 10 * HZ)
 
 static struct smc_lgr_list smc_lgr_list = {	/* established link groups */
 	.lock = __SPIN_LOCK_UNLOCKED(smc_lgr_list.lock),
-- 
2.16.3
