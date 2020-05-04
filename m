Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38588 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728614AbgEDMTP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 May 2020 08:19:15 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 04/12] net/smc: handle incoming CDC validation message
Date: Mon,  4 May 2020 14:18:40 +0200
Message-Id: <20200504121848.46585-5-kgraul@linux.ibm.com>
In-Reply-To: <20200504121848.46585-1-kgraul@linux.ibm.com>
References: <20200504121848.46585-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Call smc_cdc_msg_validate() when a CDC message with the failover
validation bit enabled was received. Validate that the sequence number
sent with the message is one we already have received. If not, messages
were lost and the connection is terminated using a new abort_work.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc.h      |  2 ++
 net/smc/smc_cdc.c  | 37 +++++++++++++++++++++++++++++++------
 net/smc/smc_core.c | 15 +++++++++++++++
 3 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/net/smc/smc.h b/net/smc/smc.h
index 1e9113771600..6f1c42da7a4c 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -188,12 +188,14 @@ struct smc_connection {
 	spinlock_t		acurs_lock;	/* protect cursors */
 #endif
 	struct work_struct	close_work;	/* peer sent some closing */
+	struct work_struct	abort_work;	/* abort the connection */
 	struct tasklet_struct	rx_tsklet;	/* Receiver tasklet for SMC-D */
 	u8			rx_off;		/* receive offset:
 						 * 0 for SMC-R, 32 for SMC-D
 						 */
 	u64			peer_token;	/* SMC-D token of peer */
 	u8			killed : 1;	/* abnormal termination */
+	u8			out_of_sync : 1; /* out of sync with peer */
 };
 
 struct smc_sock {				/* smc sock container */
diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index e6b7eef71831..b2b85e1be72c 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -282,6 +282,28 @@ static void smc_cdc_handle_urg_data_arrival(struct smc_sock *smc,
 	sk_send_sigurg(&smc->sk);
 }
 
+static void smc_cdc_msg_validate(struct smc_sock *smc, struct smc_cdc_msg *cdc,
+				 struct smc_link *link)
+{
+	struct smc_connection *conn = &smc->conn;
+	u16 recv_seq = ntohs(cdc->seqno);
+	s16 diff;
+
+	/* check that seqnum was seen before */
+	diff = conn->local_rx_ctrl.seqno - recv_seq;
+	if (diff < 0) { /* diff larger than 0x7fff */
+		/* drop connection */
+		conn->out_of_sync = 1;	/* prevent any further receives */
+		spin_lock_bh(&conn->send_lock);
+		conn->local_tx_ctrl.conn_state_flags.peer_conn_abort = 1;
+		conn->lnk = link;
+		spin_unlock_bh(&conn->send_lock);
+		sock_hold(&smc->sk); /* sock_put in abort_work */
+		if (!schedule_work(&conn->abort_work))
+			sock_put(&smc->sk);
+	}
+}
+
 static void smc_cdc_msg_recv_action(struct smc_sock *smc,
 				    struct smc_cdc_msg *cdc)
 {
@@ -412,16 +434,19 @@ static void smc_cdc_rx_handler(struct ib_wc *wc, void *buf)
 	read_lock_bh(&lgr->conns_lock);
 	conn = smc_lgr_find_conn(ntohl(cdc->token), lgr);
 	read_unlock_bh(&lgr->conns_lock);
-	if (!conn)
+	if (!conn || conn->out_of_sync)
 		return;
 	smc = container_of(conn, struct smc_sock, conn);
 
-	if (!cdc->prod_flags.failover_validation) {
-		if (smc_cdc_before(ntohs(cdc->seqno),
-				   conn->local_rx_ctrl.seqno))
-			/* received seqno is old */
-			return;
+	if (cdc->prod_flags.failover_validation) {
+		smc_cdc_msg_validate(smc, cdc, link);
+		return;
 	}
+	if (smc_cdc_before(ntohs(cdc->seqno),
+			   conn->local_rx_ctrl.seqno))
+		/* received seqno is old */
+		return;
+
 	smc_cdc_msg_recv(smc, cdc);
 }
 
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index a558ce0bde97..b5633fa19b6d 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -615,6 +615,8 @@ void smc_conn_free(struct smc_connection *conn)
 		tasklet_kill(&conn->rx_tsklet);
 	} else {
 		smc_cdc_tx_dismiss_slots(conn);
+		if (current_work() != &conn->abort_work)
+			cancel_work_sync(&conn->abort_work);
 	}
 	if (!list_empty(&lgr->list)) {
 		smc_lgr_unregister_conn(conn);
@@ -996,6 +998,18 @@ void smc_smcr_terminate_all(struct smc_ib_device *smcibdev)
 	}
 }
 
+/* abort connection, abort_work scheduled from tasklet context */
+static void smc_conn_abort_work(struct work_struct *work)
+{
+	struct smc_connection *conn = container_of(work,
+						   struct smc_connection,
+						   abort_work);
+	struct smc_sock *smc = container_of(conn, struct smc_sock, conn);
+
+	smc_conn_kill(conn, true);
+	sock_put(&smc->sk); /* sock_hold done by schedulers of abort_work */
+}
+
 /* link is up - establish alternate link if applicable */
 static void smcr_link_up(struct smc_link_group *lgr,
 			 struct smc_ib_device *smcibdev, u8 ibport)
@@ -1302,6 +1316,7 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 	conn->local_tx_ctrl.common.type = SMC_CDC_MSG_TYPE;
 	conn->local_tx_ctrl.len = SMC_WR_TX_SIZE;
 	conn->urg_state = SMC_URG_READ;
+	INIT_WORK(&smc->conn.abort_work, smc_conn_abort_work);
 	if (ini->is_smcd) {
 		conn->rx_off = sizeof(struct smcd_cdc_msg);
 		smcd_cdc_rx_init(conn); /* init tasklet for this conn */
-- 
2.17.1
