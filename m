Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20332 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728927AbgE3Onp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 30 May 2020 10:43:45 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next] net/smc: pre-fetch send buffer outside of send_lock
Date: Sat, 30 May 2020 16:42:37 +0200
Message-Id: <20200530144237.15883-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Pre-fetch send buffer for the CDC validation message before entering the
send_lock. Without that the send call might fail with -EBUSY because
there are no free buffers and waiting for buffers is not possible under
send_lock.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_cdc.c  | 10 +++-------
 net/smc/smc_cdc.h  |  4 +++-
 net/smc/smc_core.c | 18 +++++++++++++++---
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index b2b85e1be72c..a47e8855e045 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -116,19 +116,15 @@ int smc_cdc_msg_send(struct smc_connection *conn,
 }
 
 /* send a validation msg indicating the move of a conn to an other QP link */
-int smcr_cdc_msg_send_validation(struct smc_connection *conn)
+int smcr_cdc_msg_send_validation(struct smc_connection *conn,
+				 struct smc_cdc_tx_pend *pend,
+				 struct smc_wr_buf *wr_buf)
 {
 	struct smc_host_cdc_msg *local = &conn->local_tx_ctrl;
 	struct smc_link *link = conn->lnk;
-	struct smc_cdc_tx_pend *pend;
-	struct smc_wr_buf *wr_buf;
 	struct smc_cdc_msg *peer;
 	int rc;
 
-	rc = smc_cdc_get_free_slot(conn, link, &wr_buf, NULL, &pend);
-	if (rc)
-		return rc;
-
 	peer = (struct smc_cdc_msg *)wr_buf;
 	peer->common.type = local->common.type;
 	peer->len = local->len;
diff --git a/net/smc/smc_cdc.h b/net/smc/smc_cdc.h
index 2ddcc5fb5ceb..0a0a89abd38b 100644
--- a/net/smc/smc_cdc.h
+++ b/net/smc/smc_cdc.h
@@ -296,7 +296,9 @@ int smc_cdc_msg_send(struct smc_connection *conn, struct smc_wr_buf *wr_buf,
 		     struct smc_cdc_tx_pend *pend);
 int smc_cdc_get_slot_and_msg_send(struct smc_connection *conn);
 int smcd_cdc_msg_send(struct smc_connection *conn);
-int smcr_cdc_msg_send_validation(struct smc_connection *conn);
+int smcr_cdc_msg_send_validation(struct smc_connection *conn,
+				 struct smc_cdc_tx_pend *pend,
+				 struct smc_wr_buf *wr_buf);
 int smc_cdc_init(void) __init;
 void smcd_cdc_rx_init(struct smc_connection *conn);
 
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 65de700e1f17..7964a21e5e6f 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -483,7 +483,8 @@ static int smc_write_space(struct smc_connection *conn)
 	return space;
 }
 
-static int smc_switch_cursor(struct smc_sock *smc)
+static int smc_switch_cursor(struct smc_sock *smc, struct smc_cdc_tx_pend *pend,
+			     struct smc_wr_buf *wr_buf)
 {
 	struct smc_connection *conn = &smc->conn;
 	union smc_host_cursor cons, fin;
@@ -520,11 +521,14 @@ static int smc_switch_cursor(struct smc_sock *smc)
 
 	if (smc->sk.sk_state != SMC_INIT &&
 	    smc->sk.sk_state != SMC_CLOSED) {
-		rc = smcr_cdc_msg_send_validation(conn);
+		rc = smcr_cdc_msg_send_validation(conn, pend, wr_buf);
 		if (!rc) {
 			schedule_delayed_work(&conn->tx_work, 0);
 			smc->sk.sk_data_ready(&smc->sk);
 		}
+	} else {
+		smc_wr_tx_put_slot(conn->lnk,
+				   (struct smc_wr_tx_pend_priv *)pend);
 	}
 	return rc;
 }
@@ -533,7 +537,9 @@ struct smc_link *smc_switch_conns(struct smc_link_group *lgr,
 				  struct smc_link *from_lnk, bool is_dev_err)
 {
 	struct smc_link *to_lnk = NULL;
+	struct smc_cdc_tx_pend *pend;
 	struct smc_connection *conn;
+	struct smc_wr_buf *wr_buf;
 	struct smc_sock *smc;
 	struct rb_node *node;
 	int i, rc = 0;
@@ -582,10 +588,16 @@ struct smc_link *smc_switch_conns(struct smc_link_group *lgr,
 		}
 		sock_hold(&smc->sk);
 		read_unlock_bh(&lgr->conns_lock);
+		/* pre-fetch buffer outside of send_lock, might sleep */
+		rc = smc_cdc_get_free_slot(conn, to_lnk, &wr_buf, NULL, &pend);
+		if (rc) {
+			smcr_link_down_cond_sched(to_lnk);
+			return NULL;
+		}
 		/* avoid race with smcr_tx_sndbuf_nonempty() */
 		spin_lock_bh(&conn->send_lock);
 		conn->lnk = to_lnk;
-		rc = smc_switch_cursor(smc);
+		rc = smc_switch_cursor(smc, pend, wr_buf);
 		spin_unlock_bh(&conn->send_lock);
 		sock_put(&smc->sk);
 		if (rc) {
-- 
2.17.1
