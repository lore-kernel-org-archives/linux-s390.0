From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 03/10] net/smc: return active RoCE port only
Date: Mon, 10 Apr 2017 14:57:58 +0200
Message-ID: <20170410125805.13653-4-ubraun@linux.vnet.ibm.com>
References: <20170410125805.13653-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170410125805.13653-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

SMC requires an active ib port on the RoCE device.
smc_pnet_find_roce_resource() determines the matching RoCE device port
according to the configured PNET table. Do not return the found
RoCE device port, if it is not flagged active.

Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 net/smc/smc_pnet.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index f1cff01..78f7af2 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -523,8 +523,11 @@ void smc_pnet_find_roce_resource(struct sock *sk,
 	read_lock(&smc_pnettable.lock);
 	list_for_each_entry(pnetelem, &smc_pnettable.pnetlist, list) {
 		if (dst->dev == pnetelem->ndev) {
-			*smcibdev = pnetelem->smcibdev;
-			*ibport = pnetelem->ib_port;
+			if (smc_ib_port_active(pnetelem->smcibdev,
+					       pnetelem->ib_port)) {
+				*smcibdev = pnetelem->smcibdev;
+				*ibport = pnetelem->ib_port;
+			}
 			break;
 		}
 	}
-- 
2.10.2
