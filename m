From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 08/10] net/smc: set link inactive before calling smc_lgr_free()
Date: Tue, 15 May 2018 17:05:01 +0200
Message-ID: <20180515150503.47265-9-ubraun@linux.ibm.com>
References: <20180515150503.47265-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180515150503.47265-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>

Before smc_lgr_free() is called the link must be set inactive by calling
smc_llc_link_inactive().

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c   | 1 +
 net/smc/smc_core.c | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index ecf9ba68501b..d15762b057c0 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1644,6 +1644,7 @@ static void __exit smc_exit(void)
 	spin_unlock_bh(&smc_lgr_list.lock);
 	list_for_each_entry_safe(lgr, lg, &lgr_freeing_list, list) {
 		list_del_init(&lgr->list);
+		smc_llc_link_inactive(&lgr->lnk[SMC_SINGLE_LINK]);
 		cancel_delayed_work_sync(&lgr->free_work);
 		smc_lgr_free(lgr); /* free link group */
 	}
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 4523bbad8a15..a48ee00b65ff 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -148,8 +148,11 @@ static void smc_lgr_free_work(struct work_struct *work)
 	list_del_init(&lgr->list); /* remove from smc_lgr_list */
 free:
 	spin_unlock_bh(&smc_lgr_list.lock);
-	if (!delayed_work_pending(&lgr->free_work))
+	if (!delayed_work_pending(&lgr->free_work)) {
+		if (lgr->lnk[SMC_SINGLE_LINK].state != SMC_LNK_INACTIVE)
+			smc_llc_link_inactive(&lgr->lnk[SMC_SINGLE_LINK]);
 		smc_lgr_free(lgr);
+	}
 }
 
 /* create a new SMC link group */
-- 
2.16.3
