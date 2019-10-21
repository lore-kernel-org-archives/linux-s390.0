Return-Path: <netdev-owner@vger.kernel.org>
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 3/8] net/smc: improve abnormal termination locking
Date: Mon, 21 Oct 2019 16:13:10 +0200
In-Reply-To: <20191021141315.58969-1-kgraul@linux.ibm.com>
References: <20191021141315.58969-1-kgraul@linux.ibm.com>
Message-Id: <20191021141315.58969-4-kgraul@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, gor@linux.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>

Locking hierarchy requires that the link group conns_lock can be
taken if the socket lock is held, but not vice versa. Nevertheless
socket termination during abnormal link group termination should
be protected by the socket lock.
This patch reduces the time segments the link group conns_lock is
held to enable usage of lock_sock in smc_lgr_terminate().

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_core.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index b53ba8f0a833..1f58cd82928c 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -491,23 +491,26 @@ static void __smc_lgr_terminate(struct smc_link_group *lgr)
 	if (!lgr->is_smcd)
 		smc_llc_link_inactive(&lgr->lnk[SMC_SINGLE_LINK]);
 
-	write_lock_bh(&lgr->conns_lock);
+	/* kill remaining link group connections */
+	read_lock_bh(&lgr->conns_lock);
 	node = rb_first(&lgr->conns_all);
 	while (node) {
+		read_unlock_bh(&lgr->conns_lock);
 		conn = rb_entry(node, struct smc_connection, alert_node);
 		smc = container_of(conn, struct smc_sock, conn);
+		lock_sock(&smc->sk);
 		sock_hold(&smc->sk); /* sock_put in close work */
 		conn->killed = 1;
 		conn->local_tx_ctrl.conn_state_flags.peer_conn_abort = 1;
-		__smc_lgr_unregister_conn(conn);
+		smc_lgr_unregister_conn(conn);
 		conn->lgr = NULL;
-		write_unlock_bh(&lgr->conns_lock);
 		if (!schedule_work(&conn->close_work))
 			sock_put(&smc->sk);
-		write_lock_bh(&lgr->conns_lock);
+		release_sock(&smc->sk);
+		read_lock_bh(&lgr->conns_lock);
 		node = rb_first(&lgr->conns_all);
 	}
-	write_unlock_bh(&lgr->conns_lock);
+	read_unlock_bh(&lgr->conns_lock);
 	if (!lgr->is_smcd)
 		wake_up(&lgr->lnk[SMC_SINGLE_LINK].wr_reg_wait);
 	smc_lgr_schedule_free_work(lgr);
-- 
2.17.1
