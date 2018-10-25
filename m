From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net V2 1/1] net/smc: fix smc_buf_unuse to use the lgr pointer
Date: Thu, 25 Oct 2018 13:25:28 +0200
Message-ID: <20181025112528.77307-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>

The pointer to the link group is unset in the smc connection structure
right before the call to smc_buf_unuse. Provide the lgr pointer to
smc_buf_unuse explicitly.
And move the call to smc_lgr_schedule_free_work to the end of
smc_conn_free.

Fixes: a6920d1d130c ("net/smc: handle unregistered buffers")
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index e871368500e3..18daebcef181 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -122,22 +122,17 @@ static void __smc_lgr_unregister_conn(struct smc_connection *conn)
 	sock_put(&smc->sk); /* sock_hold in smc_lgr_register_conn() */
 }
 
-/* Unregister connection and trigger lgr freeing if applicable
+/* Unregister connection from lgr
  */
 static void smc_lgr_unregister_conn(struct smc_connection *conn)
 {
 	struct smc_link_group *lgr = conn->lgr;
-	int reduced = 0;
 
 	write_lock_bh(&lgr->conns_lock);
 	if (conn->alert_token_local) {
-		reduced = 1;
 		__smc_lgr_unregister_conn(conn);
 	}
 	write_unlock_bh(&lgr->conns_lock);
-	if (!reduced || lgr->conns_num)
-		return;
-	smc_lgr_schedule_free_work(lgr);
 }
 
 /* Send delete link, either as client to request the initiation
@@ -291,7 +286,8 @@ static int smc_lgr_create(struct smc_sock *smc, bool is_smcd,
 	return rc;
 }
 
-static void smc_buf_unuse(struct smc_connection *conn)
+static void smc_buf_unuse(struct smc_connection *conn,
+			  struct smc_link_group *lgr)
 {
 	if (conn->sndbuf_desc)
 		conn->sndbuf_desc->used = 0;
@@ -301,8 +297,6 @@ static void smc_buf_unuse(struct smc_connection *conn)
 			conn->rmb_desc->used = 0;
 		} else {
 			/* buf registration failed, reuse not possible */
-			struct smc_link_group *lgr = conn->lgr;
-
 			write_lock_bh(&lgr->rmbs_lock);
 			list_del(&conn->rmb_desc->list);
 			write_unlock_bh(&lgr->rmbs_lock);
@@ -315,16 +309,21 @@ static void smc_buf_unuse(struct smc_connection *conn)
 /* remove a finished connection from its link group */
 void smc_conn_free(struct smc_connection *conn)
 {
-	if (!conn->lgr)
+	struct smc_link_group *lgr = conn->lgr;
+
+	if (!lgr)
 		return;
-	if (conn->lgr->is_smcd) {
+	if (lgr->is_smcd) {
 		smc_ism_unset_conn(conn);
 		tasklet_kill(&conn->rx_tsklet);
 	} else {
 		smc_cdc_tx_dismiss_slots(conn);
 	}
-	smc_lgr_unregister_conn(conn);
-	smc_buf_unuse(conn);
+	smc_lgr_unregister_conn(conn);		/* unsets conn->lgr */
+	smc_buf_unuse(conn, lgr);		/* allow buffer reuse */
+
+	if (!lgr->conns_num)
+		smc_lgr_schedule_free_work(lgr);
 }
 
 static void smc_link_clear(struct smc_link *lnk)
-- 
2.16.4
