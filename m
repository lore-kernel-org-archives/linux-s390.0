From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 1/1] net/smc: save link group ptr before calling smc_buf_unuse
Date: Tue, 23 Oct 2018 15:48:05 +0200
Message-ID: <20181023134805.2429-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>

The pointer to the link group is unset in the smc connection structure
right before the call to smc_buf_unuse. Save the pointer and provide it
to smc_buf_unuse.

Fixes: a6920d1d130c ("net/smc: handle unregistered buffers")
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index e871368500e3..12d8493f72f4 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -291,7 +291,8 @@ static int smc_lgr_create(struct smc_sock *smc, bool is_smcd,
 	return rc;
 }
 
-static void smc_buf_unuse(struct smc_connection *conn)
+static void smc_buf_unuse(struct smc_connection *conn,
+			  struct smc_link_group *lgr)
 {
 	if (conn->sndbuf_desc)
 		conn->sndbuf_desc->used = 0;
@@ -301,8 +302,6 @@ static void smc_buf_unuse(struct smc_connection *conn)
 			conn->rmb_desc->used = 0;
 		} else {
 			/* buf registration failed, reuse not possible */
-			struct smc_link_group *lgr = conn->lgr;
-
 			write_lock_bh(&lgr->rmbs_lock);
 			list_del(&conn->rmb_desc->list);
 			write_unlock_bh(&lgr->rmbs_lock);
@@ -315,6 +314,8 @@ static void smc_buf_unuse(struct smc_connection *conn)
 /* remove a finished connection from its link group */
 void smc_conn_free(struct smc_connection *conn)
 {
+	struct smc_link_group *lgr;
+
 	if (!conn->lgr)
 		return;
 	if (conn->lgr->is_smcd) {
@@ -323,8 +324,9 @@ void smc_conn_free(struct smc_connection *conn)
 	} else {
 		smc_cdc_tx_dismiss_slots(conn);
 	}
+	lgr = conn->lgr; /* smc_lgr_unregister_conn() unsets lgr */
 	smc_lgr_unregister_conn(conn);
-	smc_buf_unuse(conn);
+	smc_buf_unuse(conn, lgr);
 }
 
 static void smc_link_clear(struct smc_link *lnk)
-- 
2.16.4
