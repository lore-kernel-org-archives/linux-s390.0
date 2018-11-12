From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 4/5] net/smc: atomic SMCD cursor handling
Date: Mon, 12 Nov 2018 17:01:32 +0100
Message-ID: <20181112160133.16058-5-ubraun@linux.ibm.com>
References: <20181112160133.16058-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181112160133.16058-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Running uperf tests with SMCD on LPARs results in corrupted cursors.
SMCD cursors should be treated atomically to fix cursor corruption.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_cdc.c | 24 ++++++++++++++----------
 net/smc/smc_cdc.h | 56 ++++++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 57 insertions(+), 23 deletions(-)

diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index ed5dcf03fe0b..18c047c155fd 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -177,23 +177,24 @@ void smc_cdc_tx_dismiss_slots(struct smc_connection *conn)
 int smcd_cdc_msg_send(struct smc_connection *conn)
 {
 	struct smc_sock *smc = container_of(conn, struct smc_sock, conn);
+	union smc_host_cursor curs;
 	struct smcd_cdc_msg cdc;
 	int rc, diff;
 
 	memset(&cdc, 0, sizeof(cdc));
 	cdc.common.type = SMC_CDC_MSG_TYPE;
-	cdc.prod_wrap = conn->local_tx_ctrl.prod.wrap;
-	cdc.prod_count = conn->local_tx_ctrl.prod.count;
-
-	cdc.cons_wrap = conn->local_tx_ctrl.cons.wrap;
-	cdc.cons_count = conn->local_tx_ctrl.cons.count;
-	cdc.prod_flags = conn->local_tx_ctrl.prod_flags;
-	cdc.conn_state_flags = conn->local_tx_ctrl.conn_state_flags;
+	curs.acurs.counter = atomic64_read(&conn->local_tx_ctrl.prod.acurs);
+	cdc.prod.wrap = curs.wrap;
+	cdc.prod.count = curs.count;
+	curs.acurs.counter = atomic64_read(&conn->local_tx_ctrl.cons.acurs);
+	cdc.cons.wrap = curs.wrap;
+	cdc.cons.count = curs.count;
+	cdc.cons.prod_flags = conn->local_tx_ctrl.prod_flags;
+	cdc.cons.conn_state_flags = conn->local_tx_ctrl.conn_state_flags;
 	rc = smcd_tx_ism_write(conn, &cdc, sizeof(cdc), 0, 1);
 	if (rc)
 		return rc;
-	smc_curs_copy(&conn->rx_curs_confirmed, &conn->local_tx_ctrl.cons,
-		      conn);
+	smc_curs_copy(&conn->rx_curs_confirmed, &curs, conn);
 	/* Calculate transmitted data and increment free send buffer space */
 	diff = smc_curs_diff(conn->sndbuf_desc->len, &conn->tx_curs_fin,
 			     &conn->tx_curs_sent);
@@ -331,13 +332,16 @@ static void smc_cdc_msg_recv(struct smc_sock *smc, struct smc_cdc_msg *cdc)
 static void smcd_cdc_rx_tsklet(unsigned long data)
 {
 	struct smc_connection *conn = (struct smc_connection *)data;
+	struct smcd_cdc_msg *data_cdc;
 	struct smcd_cdc_msg cdc;
 	struct smc_sock *smc;
 
 	if (!conn)
 		return;
 
-	memcpy(&cdc, conn->rmb_desc->cpu_addr, sizeof(cdc));
+	data_cdc = (struct smcd_cdc_msg *)conn->rmb_desc->cpu_addr;
+	smcd_curs_copy(&cdc.prod, &data_cdc->prod, conn);
+	smcd_curs_copy(&cdc.cons, &data_cdc->cons, conn);
 	smc = container_of(conn, struct smc_sock, conn);
 	smc_cdc_msg_recv(smc, (struct smc_cdc_msg *)&cdc);
 }
diff --git a/net/smc/smc_cdc.h b/net/smc/smc_cdc.h
index 934df4473a7c..b9772ab77ddf 100644
--- a/net/smc/smc_cdc.h
+++ b/net/smc/smc_cdc.h
@@ -50,17 +50,27 @@ struct smc_cdc_msg {
 	u8				reserved[18];
 } __packed;					/* format defined in RFC7609 */
 
+/* SMC-D cursor format */
+union smcd_cdc_cursor {
+	struct {
+		u16	wrap;
+		u32	count;
+		struct smc_cdc_producer_flags	prod_flags;
+		struct smc_cdc_conn_state_flags	conn_state_flags;
+	} __packed;
+#ifdef KERNEL_HAS_ATOMIC64
+	atomic64_t		acurs;		/* for atomic processing */
+#else
+	u64			acurs;		/* for atomic processing */
+#endif
+} __aligned(8);
+
 /* CDC message for SMC-D */
 struct smcd_cdc_msg {
 	struct smc_wr_rx_hdr common;	/* Type = 0xFE */
 	u8 res1[7];
-	u16 prod_wrap;
-	u32 prod_count;
-	u8 res2[2];
-	u16 cons_wrap;
-	u32 cons_count;
-	struct smc_cdc_producer_flags	prod_flags;
-	struct smc_cdc_conn_state_flags conn_state_flags;
+	union smcd_cdc_cursor	prod;
+	union smcd_cdc_cursor	cons;
 	u8 res3[8];
 } __packed;
 
@@ -135,6 +145,21 @@ static inline void smc_curs_copy_net(union smc_cdc_cursor *tgt,
 #endif
 }
 
+static inline void smcd_curs_copy(union smcd_cdc_cursor *tgt,
+				  union smcd_cdc_cursor *src,
+				  struct smc_connection *conn)
+{
+#ifndef KERNEL_HAS_ATOMIC64
+	unsigned long flags;
+
+	spin_lock_irqsave(&conn->acurs_lock, flags);
+	tgt->acurs = src->acurs;
+	spin_unlock_irqrestore(&conn->acurs_lock, flags);
+#else
+	atomic64_set(&tgt->acurs, atomic64_read(&src->acurs));
+#endif
+}
+
 /* calculate cursor difference between old and new, where old <= new */
 static inline int smc_curs_diff(unsigned int size,
 				union smc_host_cursor *old,
@@ -222,12 +247,17 @@ static inline void smcr_cdc_msg_to_host(struct smc_host_cdc_msg *local,
 static inline void smcd_cdc_msg_to_host(struct smc_host_cdc_msg *local,
 					struct smcd_cdc_msg *peer)
 {
-	local->prod.wrap = peer->prod_wrap;
-	local->prod.count = peer->prod_count;
-	local->cons.wrap = peer->cons_wrap;
-	local->cons.count = peer->cons_count;
-	local->prod_flags = peer->prod_flags;
-	local->conn_state_flags = peer->conn_state_flags;
+	union smc_host_cursor temp;
+
+	temp.wrap = peer->prod.wrap;
+	temp.count = peer->prod.count;
+	atomic64_set(&local->prod.acurs, atomic64_read(&temp.acurs));
+
+	temp.wrap = peer->cons.wrap;
+	temp.count = peer->cons.count;
+	atomic64_set(&local->cons.acurs, atomic64_read(&temp.acurs));
+	local->prod_flags = peer->cons.prod_flags;
+	local->conn_state_flags = peer->cons.conn_state_flags;
 }
 
 static inline void smc_cdc_msg_to_host(struct smc_host_cdc_msg *local,
-- 
2.16.4
