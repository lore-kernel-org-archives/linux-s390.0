Return-Path: <SRS0=RTe9=QT=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 5/7] net/smc: check connections in smc_lgr_free_work
Date: Tue, 12 Feb 2019 16:29:54 +0100
In-Reply-To: <20190212152956.71041-1-ubraun@linux.ibm.com>
References: <20190212152956.71041-1-ubraun@linux.ibm.com>
Message-Id: <20190212152956.71041-6-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>

Remove the shortcut that smc_lgr_free() would skip the check for
existing connections when the link group is not in the link group list.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 349d789a9728..53a17cfa61af 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -160,8 +160,6 @@ static void smc_lgr_free_work(struct work_struct *work)
 	bool conns;
 
 	spin_lock_bh(&smc_lgr_list.lock);
-	if (list_empty(&lgr->list))
-		goto free;
 	read_lock_bh(&lgr->conns_lock);
 	conns = RB_EMPTY_ROOT(&lgr->conns_all);
 	read_unlock_bh(&lgr->conns_lock);
@@ -169,8 +167,8 @@ static void smc_lgr_free_work(struct work_struct *work)
 		spin_unlock_bh(&smc_lgr_list.lock);
 		return;
 	}
-	list_del_init(&lgr->list); /* remove from smc_lgr_list */
-free:
+	if (!list_empty(&lgr->list))
+		list_del_init(&lgr->list); /* remove from smc_lgr_list */
 	spin_unlock_bh(&smc_lgr_list.lock);
 
 	if (!lgr->is_smcd && !lgr->terminating)	{
-- 
2.16.4
