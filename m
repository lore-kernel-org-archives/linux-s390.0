Return-Path: <netdev-owner@vger.kernel.org>
From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 2/3] net/smc: free link group without pending free_work only
Date: Wed, 14 Mar 2018 11:01:01 +0100
In-Reply-To: <20180314100102.40474-1-ubraun@linux.vnet.ibm.com>
References: <20180314100102.40474-1-ubraun@linux.vnet.ibm.com>
Message-Id: <20180314100102.40474-3-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Make sure there is no pending or running free_work worker for the link
group when freeing the link group.

Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 net/smc/af_smc.c   | 1 +
 net/smc/smc_core.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 2c6f4e0a9f3d..649489f825a5 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1477,6 +1477,7 @@ static void __exit smc_exit(void)
 	spin_unlock_bh(&smc_lgr_list.lock);
 	list_for_each_entry_safe(lgr, lg, &lgr_freeing_list, list) {
 		list_del_init(&lgr->list);
+		cancel_delayed_work_sync(&lgr->free_work);
 		smc_lgr_free(lgr); /* free link group */
 	}
 	static_branch_disable(&tcp_have_smc);
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index f76f60e463cb..ec6189fe2a48 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -140,7 +140,8 @@ static void smc_lgr_free_work(struct work_struct *work)
 	list_del_init(&lgr->list); /* remove from smc_lgr_list */
 free:
 	spin_unlock_bh(&smc_lgr_list.lock);
-	smc_lgr_free(lgr);
+	if (!delayed_work_pending(&lgr->free_work))
+		smc_lgr_free(lgr);
 }
 
 /* create a new SMC link group */
-- 
2.13.5
