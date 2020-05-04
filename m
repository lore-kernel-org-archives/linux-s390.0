Return-Path: <netdev-owner@vger.kernel.org>
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 03/12] net/smc: send failover validation message
Date: Mon,  4 May 2020 14:18:39 +0200
Message-Id: <20200504121848.46585-4-kgraul@linux.ibm.com>
In-Reply-To: <20200504121848.46585-1-kgraul@linux.ibm.com>
References: <20200504121848.46585-1-kgraul@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

When a connection is switched to a new link then a link validation
message must be sent to the peer over the new link, containing the
sequence number of the last CDC message that was sent over the old link.
The peer will validate if this sequence number is the same or lower then
the number he received, and abort the connection if messages were lost.
Add smcr_cdc_msg_send_validation() to send the message validation
message and call it when a connection was switched in
smc_switch_cursor().

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_cdc.c  | 25 +++++++++++++++++++++++++
 net/smc/smc_cdc.h  |  1 +
 net/smc/smc_core.c |  2 +-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index 3ca986066f32..e6b7eef71831 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -115,6 +115,31 @@ int smc_cdc_msg_send(struct smc_connection *conn,
 	return rc;
 }
 
+/* send a validation msg indicating the move of a conn to an other QP link */
+int smcr_cdc_msg_send_validation(struct smc_connection *conn)
+{
+	struct smc_host_cdc_msg *local = &conn->local_tx_ctrl;
+	struct smc_link *link = conn->lnk;
+	struct smc_cdc_tx_pend *pend;
+	struct smc_wr_buf *wr_buf;
+	struct smc_cdc_msg *peer;
+	int rc;
+
+	rc = smc_cdc_get_free_slot(conn, link, &wr_buf, NULL, &pend);
+	if (rc)
+		return rc;
+
+	peer = (struct smc_cdc_msg *)wr_buf;
+	peer->common.type = local->common.type;
+	peer->len = local->len;
+	peer->seqno = htons(conn->tx_cdc_seq_fin); /* seqno last compl. tx */
+	peer->token = htonl(local->token);
+	peer->prod_flags.failover_validation = 1;
+
+	rc = smc_wr_tx_send(link, (struct smc_wr_tx_pend_priv *)pend);
+	return rc;
+}
+
 static int smcr_cdc_get_slot_and_msg_send(struct smc_connection *conn)
 {
 	struct smc_cdc_tx_pend *pend;
diff --git a/net/smc/smc_cdc.h b/net/smc/smc_cdc.h
index 42246b4bdcc9..9cfabc9af120 100644
--- a/net/smc/smc_cdc.h
+++ b/net/smc/smc_cdc.h
@@ -313,6 +313,7 @@ int smc_cdc_msg_send(struct smc_connection *conn, struct smc_wr_buf *wr_buf,
 		     struct smc_cdc_tx_pend *pend);
 int smc_cdc_get_slot_and_msg_send(struct smc_connection *conn);
 int smcd_cdc_msg_send(struct smc_connection *conn);
+int smcr_cdc_msg_send_validation(struct smc_connection *conn);
 int smc_cdc_init(void) __init;
 void smcd_cdc_rx_init(struct smc_connection *conn);
 
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 21bc1ec07e99..a558ce0bde97 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -483,7 +483,7 @@ static int smc_switch_cursor(struct smc_sock *smc)
 
 	if (smc->sk.sk_state != SMC_INIT &&
 	    smc->sk.sk_state != SMC_CLOSED) {
-		/* tbd: call rc = smc_cdc_get_slot_and_msg_send(conn); */
+		rc = smcr_cdc_msg_send_validation(conn);
 		if (!rc) {
 			schedule_delayed_work(&conn->tx_work, 0);
 			smc->sk.sk_data_ready(&smc->sk);
-- 
2.17.1
