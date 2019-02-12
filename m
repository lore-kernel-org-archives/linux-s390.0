Return-Path: <SRS0=RTe9=QT=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 1/7] net/smc: reset cursor update required flag
Date: Tue, 12 Feb 2019 16:29:50 +0100
In-Reply-To: <20190212152956.71041-1-ubraun@linux.ibm.com>
References: <20190212152956.71041-1-ubraun@linux.ibm.com>
Message-Id: <20190212152956.71041-2-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>

When an updated rx_cursor_confirmed field was sent to the peer then
reset the cons_curs_upd_req flag. And remove the duplicate reset and
cursor update in smc_tx_consumer_update().

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_cdc.c | 5 ++++-
 net/smc/smc_tx.c  | 3 ---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index a712c9f8699b..99d9d6e85dfb 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -105,8 +105,10 @@ int smc_cdc_msg_send(struct smc_connection *conn,
 			    &conn->local_tx_ctrl, conn);
 	smc_curs_copy(&cfed, &((struct smc_host_cdc_msg *)wr_buf)->cons, conn);
 	rc = smc_wr_tx_send(link, (struct smc_wr_tx_pend_priv *)pend);
-	if (!rc)
+	if (!rc) {
 		smc_curs_copy(&conn->rx_curs_confirmed, &cfed, conn);
+		conn->local_rx_ctrl.prod_flags.cons_curs_upd_req = 0;
+	}
 
 	return rc;
 }
@@ -194,6 +196,7 @@ int smcd_cdc_msg_send(struct smc_connection *conn)
 	if (rc)
 		return rc;
 	smc_curs_copy(&conn->rx_curs_confirmed, &curs, conn);
+	conn->local_rx_ctrl.prod_flags.cons_curs_upd_req = 0;
 	/* Calculate transmitted data and increment free send buffer space */
 	diff = smc_curs_diff(conn->sndbuf_desc->len, &conn->tx_curs_fin,
 			     &conn->tx_curs_sent);
diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index f93f3580c100..ce9586bce364 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -610,9 +610,6 @@ void smc_tx_consumer_update(struct smc_connection *conn, bool force)
 					      SMC_TX_WORK_DELAY);
 			return;
 		}
-		smc_curs_copy(&conn->rx_curs_confirmed,
-			      &conn->local_tx_ctrl.cons, conn);
-		conn->local_rx_ctrl.prod_flags.cons_curs_upd_req = 0;
 	}
 	if (conn->local_rx_ctrl.prod_flags.write_blocked &&
 	    !atomic_read(&conn->bytes_to_rcv))
-- 
2.16.4
