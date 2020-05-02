Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38056 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727914AbgEBMgS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 2 May 2020 08:36:18 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 13/13] net/smc: save state of last sent CDC message
Date: Sat,  2 May 2020 14:35:52 +0200
Message-Id: <20200502123552.17204-14-kgraul@linux.ibm.com>
In-Reply-To: <20200502123552.17204-1-kgraul@linux.ibm.com>
References: <20200502123552.17204-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

When a link goes down and all connections of this link need to be
switched to an other link then the producer cursor and the sequence of
the last successfully sent CDC message must be known. Add the two fields
to the SMC connection and update it in the tx completion handler.
And to allow matching of sequences in error cases reset the seqno to the
old value in smc_cdc_msg_send() when the actual send failed.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc.h     | 4 ++++
 net/smc/smc_cdc.c | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/net/smc/smc.h b/net/smc/smc.h
index 1a084afa7372..1e9113771600 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -143,6 +143,9 @@ struct smc_connection {
 						 * .prod cf. TCP snd_nxt
 						 * .cons cf. TCP sends ack
 						 */
+	union smc_host_cursor	local_tx_ctrl_fin;
+						/* prod crsr - confirmed by peer
+						 */
 	union smc_host_cursor	tx_curs_prep;	/* tx - prepared data
 						 * snd_max..wmem_alloc
 						 */
@@ -154,6 +157,7 @@ struct smc_connection {
 						 */
 	atomic_t		sndbuf_space;	/* remaining space in sndbuf */
 	u16			tx_cdc_seq;	/* sequence # for CDC send */
+	u16			tx_cdc_seq_fin;	/* sequence # - tx completed */
 	spinlock_t		send_lock;	/* protect wr_sends */
 	struct delayed_work	tx_work;	/* retry of smc_cdc_msg_send */
 	u32			tx_off;		/* base offset in peer rmb */
diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index f64589d823aa..c5e33296e55c 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -47,6 +47,9 @@ static void smc_cdc_tx_handler(struct smc_wr_tx_pend_priv *pnd_snd,
 		/* guarantee 0 <= sndbuf_space <= sndbuf_desc->len */
 		smp_mb__after_atomic();
 		smc_curs_copy(&conn->tx_curs_fin, &cdcpend->cursor, conn);
+		smc_curs_copy(&conn->local_tx_ctrl_fin, &cdcpend->p_cursor,
+			      conn);
+		conn->tx_cdc_seq_fin = cdcpend->ctrl_seq;
 	}
 	smc_tx_sndbuf_nonfull(smc);
 	bh_unlock_sock(&smc->sk);
@@ -104,6 +107,9 @@ int smc_cdc_msg_send(struct smc_connection *conn,
 	if (!rc) {
 		smc_curs_copy(&conn->rx_curs_confirmed, &cfed, conn);
 		conn->local_rx_ctrl.prod_flags.cons_curs_upd_req = 0;
+	} else {
+		conn->tx_cdc_seq--;
+		conn->local_tx_ctrl.seqno = conn->tx_cdc_seq;
 	}
 
 	return rc;
-- 
2.17.1
