Return-Path: <netdev-owner@vger.kernel.org>
From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 8/8] net/smc: prevent new connections on link group
Date: Thu,  1 Mar 2018 13:51:33 +0100
In-Reply-To: <20180301125133.12211-1-ubraun@linux.vnet.ibm.com>
References: <20180301125133.12211-1-ubraun@linux.vnet.ibm.com>
Message-Id: <20180301125133.12211-9-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.vnet.ibm.com>

When the processing of a DELETE LINK message has started,
new connections should not be added to the link group that
is about to terminate.

Signed-off-by: Karsten Graul <kgraul@linux.vnet.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 net/smc/af_smc.c   |  9 ---------
 net/smc/smc_core.c | 19 ++++++++++---------
 net/smc/smc_core.h |  1 +
 net/smc/smc_llc.c  |  1 +
 4 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 5267ed19b67d..26684e086750 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -356,15 +356,6 @@ static void smc_link_save_peer_info(struct smc_link *link,
 	link->peer_mtu = clc->qp_mtu;
 }
 
-static void smc_lgr_forget(struct smc_link_group *lgr)
-{
-	spin_lock_bh(&smc_lgr_list.lock);
-	/* do not use this link group for new connections */
-	if (!list_empty(&lgr->list))
-		list_del_init(&lgr->list);
-	spin_unlock_bh(&smc_lgr_list.lock);
-}
-
 /* setup for RDMA connection of client */
 static int smc_connect_rdma(struct smc_sock *smc)
 {
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index eb343e15a723..702ce5f85e97 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -308,6 +308,15 @@ void smc_lgr_free(struct smc_link_group *lgr)
 	kfree(lgr);
 }
 
+void smc_lgr_forget(struct smc_link_group *lgr)
+{
+	spin_lock_bh(&smc_lgr_list.lock);
+	/* do not use this link group for new connections */
+	if (!list_empty(&lgr->list))
+		list_del_init(&lgr->list);
+	spin_unlock_bh(&smc_lgr_list.lock);
+}
+
 /* terminate linkgroup abnormally */
 void smc_lgr_terminate(struct smc_link_group *lgr)
 {
@@ -315,15 +324,7 @@ void smc_lgr_terminate(struct smc_link_group *lgr)
 	struct smc_sock *smc;
 	struct rb_node *node;
 
-	spin_lock_bh(&smc_lgr_list.lock);
-	if (list_empty(&lgr->list)) {
-		/* termination already triggered */
-		spin_unlock_bh(&smc_lgr_list.lock);
-		return;
-	}
-	/* do not use this link group for new connections */
-	list_del_init(&lgr->list);
-	spin_unlock_bh(&smc_lgr_list.lock);
+	smc_lgr_forget(lgr);
 
 	write_lock_bh(&lgr->conns_lock);
 	node = rb_first(&lgr->conns_all);
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index cead2093c4b4..07e2a393e6d9 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -197,6 +197,7 @@ struct smc_sock;
 struct smc_clc_msg_accept_confirm;
 
 void smc_lgr_free(struct smc_link_group *lgr);
+void smc_lgr_forget(struct smc_link_group *lgr);
 void smc_lgr_terminate(struct smc_link_group *lgr);
 int smc_buf_create(struct smc_sock *smc);
 int smc_rmb_rtoken_handling(struct smc_connection *conn,
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 45b3e0211c39..54e8d6dc9201 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -384,6 +384,7 @@ static void smc_llc_rx_delete_link(struct smc_link *link,
 			smc_lgr_terminate(lgr);
 	} else {
 		if (lgr->role == SMC_SERV) {
+			smc_lgr_forget(lgr);
 			smc_llc_send_delete_link(link, SMC_LLC_REQ);
 		} else {
 			smc_llc_send_delete_link(link, SMC_LLC_RESP);
-- 
2.13.5
