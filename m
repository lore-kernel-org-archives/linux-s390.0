From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 01/10] net/smc: get rid of old comment
Date: Mon, 10 Apr 2017 14:57:56 +0200
Message-ID: <20170410125805.13653-2-ubraun@linux.vnet.ibm.com>
References: <20170410125805.13653-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170410125805.13653-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

This patch removes an outdated comment.

Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 net/smc/smc_cdc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index 5a33949..4c9c2f6 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -228,8 +228,6 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
 		smc_close_wake_tx_prepared(smc);
 	}
 
-	/* subsequent patch: trigger socket release if connection closed */
-
 	/* socket connected but not accepted */
 	if (!smc->sk.sk_socket)
 		return;
-- 
2.10.2
