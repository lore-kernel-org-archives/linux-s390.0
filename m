From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 2/4] net/smc: lock smc_lgr_list in port_terminate()
Date: Wed, 23 May 2018 16:38:10 +0200
Message-ID: <20180523143812.25824-3-ubraun@linux.ibm.com>
References: <20180523143812.25824-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180523143812.25824-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Hans Wippel <hwippel@linux.ibm.com>

Currently, smc_port_terminate() is not holding the lock of the lgr list
while it is traversing the list. This patch adds locking to this
function and changes smc_lgr_terminate() accordingly.

Signed-off-by: Hans Wippel <hwippel@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 1e5c0e90a706..21c244f53b0a 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -346,7 +346,7 @@ void smc_lgr_forget(struct smc_link_group *lgr)
 }
 
 /* terminate linkgroup abnormally */
-void smc_lgr_terminate(struct smc_link_group *lgr)
+static void __smc_lgr_terminate(struct smc_link_group *lgr)
 {
 	struct smc_connection *conn;
 	struct smc_sock *smc;
@@ -355,7 +355,8 @@ void smc_lgr_terminate(struct smc_link_group *lgr)
 	if (lgr->terminating)
 		return;	/* lgr already terminating */
 	lgr->terminating = 1;
-	smc_lgr_forget(lgr);
+	if (!list_empty(&lgr->list)) /* forget lgr */
+		list_del_init(&lgr->list);
 	smc_llc_link_inactive(&lgr->lnk[SMC_SINGLE_LINK]);
 
 	write_lock_bh(&lgr->conns_lock);
@@ -377,16 +378,25 @@ void smc_lgr_terminate(struct smc_link_group *lgr)
 	smc_lgr_schedule_free_work(lgr);
 }
 
+void smc_lgr_terminate(struct smc_link_group *lgr)
+{
+	spin_lock_bh(&smc_lgr_list.lock);
+	__smc_lgr_terminate(lgr);
+	spin_unlock_bh(&smc_lgr_list.lock);
+}
+
 /* Called when IB port is terminated */
 void smc_port_terminate(struct smc_ib_device *smcibdev, u8 ibport)
 {
 	struct smc_link_group *lgr, *l;
 
+	spin_lock_bh(&smc_lgr_list.lock);
 	list_for_each_entry_safe(lgr, l, &smc_lgr_list.list, list) {
 		if (lgr->lnk[SMC_SINGLE_LINK].smcibdev == smcibdev &&
 		    lgr->lnk[SMC_SINGLE_LINK].ibport == ibport)
-			smc_lgr_terminate(lgr);
+			__smc_lgr_terminate(lgr);
 	}
+	spin_unlock_bh(&smc_lgr_list.lock);
 }
 
 /* Determine vlan of internal TCP socket.
-- 
2.16.3
