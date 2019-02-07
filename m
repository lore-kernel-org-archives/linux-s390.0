Return-Path: <SRS0=t9U+=QO=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 6/7] net/smc: move code to clear the conn->lgr field
Date: Thu,  7 Feb 2019 15:56:19 +0100
In-Reply-To: <20190207145620.92811-1-ubraun@linux.ibm.com>
References: <20190207145620.92811-1-ubraun@linux.ibm.com>
Message-Id: <20190207145620.92811-7-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>

The lgr field of an smc_connection is set in smc_conn_create() and
should be cleared in smc_conn_free() for consistency reasons, so move
the responsible code.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 35c1cdc93e1c..a1a6d351ae1b 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -118,7 +118,6 @@ static void __smc_lgr_unregister_conn(struct smc_connection *conn)
 	rb_erase(&conn->alert_node, &lgr->conns_all);
 	lgr->conns_num--;
 	conn->alert_token_local = 0;
-	conn->lgr = NULL;
 	sock_put(&smc->sk); /* sock_hold in smc_lgr_register_conn() */
 }
 
@@ -331,8 +330,9 @@ void smc_conn_free(struct smc_connection *conn)
 	} else {
 		smc_cdc_tx_dismiss_slots(conn);
 	}
-	smc_lgr_unregister_conn(conn);		/* unsets conn->lgr */
+	smc_lgr_unregister_conn(conn);
 	smc_buf_unuse(conn, lgr);		/* allow buffer reuse */
+	conn->lgr = NULL;
 
 	if (!lgr->conns_num)
 		smc_lgr_schedule_free_work(lgr);
@@ -462,6 +462,7 @@ static void __smc_lgr_terminate(struct smc_link_group *lgr)
 		sock_hold(&smc->sk); /* sock_put in close work */
 		conn->local_tx_ctrl.conn_state_flags.peer_conn_abort = 1;
 		__smc_lgr_unregister_conn(conn);
+		conn->lgr = NULL;
 		write_unlock_bh(&lgr->conns_lock);
 		if (!schedule_work(&conn->close_work))
 			sock_put(&smc->sk);
-- 
2.16.4
