Return-Path: <netdev-owner@vger.kernel.org>
From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 3/3] net/smc: schedule free_work when link group is terminated
Date: Wed, 14 Mar 2018 11:01:02 +0100
In-Reply-To: <20180314100102.40474-1-ubraun@linux.vnet.ibm.com>
References: <20180314100102.40474-1-ubraun@linux.vnet.ibm.com>
Message-Id: <20180314100102.40474-4-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.vnet.ibm.com>

The free_work worker must be scheduled when the link group is
abnormally terminated.

Signed-off-by: Karsten Graul <kgraul@linux.vnet.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 net/smc/smc_core.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index ec6189fe2a48..f44f6803f7ff 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -32,6 +32,17 @@
 
 static u32 smc_lgr_num;			/* unique link group number */
 
+static void smc_lgr_schedule_free_work(struct smc_link_group *lgr)
+{
+	/* client link group creation always follows the server link group
+	 * creation. For client use a somewhat higher removal delay time,
+	 * otherwise there is a risk of out-of-sync link groups.
+	 */
+	mod_delayed_work(system_wq, &lgr->free_work,
+			 lgr->role == SMC_CLNT ? SMC_LGR_FREE_DELAY_CLNT :
+						 SMC_LGR_FREE_DELAY_SERV);
+}
+
 /* Register connection's alert token in our lookup structure.
  * To use rbtrees we have to implement our own insert core.
  * Requires @conns_lock
@@ -111,13 +122,7 @@ static void smc_lgr_unregister_conn(struct smc_connection *conn)
 	write_unlock_bh(&lgr->conns_lock);
 	if (!reduced || lgr->conns_num)
 		return;
-	/* client link group creation always follows the server link group
-	 * creation. For client use a somewhat higher removal delay time,
-	 * otherwise there is a risk of out-of-sync link groups.
-	 */
-	mod_delayed_work(system_wq, &lgr->free_work,
-			 lgr->role == SMC_CLNT ? SMC_LGR_FREE_DELAY_CLNT :
-						 SMC_LGR_FREE_DELAY_SERV);
+	smc_lgr_schedule_free_work(lgr);
 }
 
 static void smc_lgr_free_work(struct work_struct *work)
@@ -344,6 +349,7 @@ void smc_lgr_terminate(struct smc_link_group *lgr)
 	}
 	write_unlock_bh(&lgr->conns_lock);
 	wake_up(&lgr->lnk[SMC_SINGLE_LINK].wr_reg_wait);
+	smc_lgr_schedule_free_work(lgr);
 }
 
 /* Determine vlan of internal TCP socket.
-- 
2.13.5
