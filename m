From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 1/9] net/smc: add common buffer size in send and receive buffer descriptors
Date: Fri, 18 May 2018 09:34:10 +0200
Message-ID: <20180518073418.91878-2-ubraun@linux.ibm.com>
References: <20180518073418.91878-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180518073418.91878-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Hans Wippel <hwippel@linux.ibm.com>

In addition to the buffer references, SMC currently stores the sizes of
the receive and send buffers in each connection as separate variables.
This patch introduces a buffer length variable in the common buffer
descriptor and uses this length instead.

Signed-off-by: Hans Wippel <hwippel@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c   |  2 +-
 net/smc/smc.h      |  2 --
 net/smc/smc_cdc.c  |  8 ++++----
 net/smc/smc_core.c |  8 ++------
 net/smc/smc_core.h |  1 +
 net/smc/smc_diag.c |  5 +++--
 net/smc/smc_rx.c   | 10 +++++-----
 net/smc/smc_tx.c   | 28 ++++++++++++++--------------
 net/smc/smc_tx.h   |  2 +-
 9 files changed, 31 insertions(+), 35 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 6ad4f6c771c3..409b1367970c 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1421,7 +1421,7 @@ static int smc_ioctl(struct socket *sock, unsigned int cmd,
 		/* output queue size (not send + not acked) */
 		if (smc->sk.sk_state == SMC_LISTEN)
 			return -EINVAL;
-		answ = smc->conn.sndbuf_size -
+		answ = smc->conn.sndbuf_desc->len -
 					atomic_read(&smc->conn.sndbuf_space);
 		break;
 	case SIOCOUTQNSD:
diff --git a/net/smc/smc.h b/net/smc/smc.h
index ec209cd48d42..ad6694f516dd 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -126,9 +126,7 @@ struct smc_connection {
 	int			rtoken_idx;	/* idx to peer RMB rkey/addr */
 
 	struct smc_buf_desc	*sndbuf_desc;	/* send buffer descriptor */
-	int			sndbuf_size;	/* sndbuf size <== sock wmem */
 	struct smc_buf_desc	*rmb_desc;	/* RMBE descriptor */
-	int			rmbe_size;	/* RMBE size <== sock rmem */
 	int			rmbe_size_short;/* compressed notation */
 	int			rmbe_update_limit;
 						/* lower limit for consumer
diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index 42ad57365eca..2809f9902446 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -44,13 +44,13 @@ static void smc_cdc_tx_handler(struct smc_wr_tx_pend_priv *pnd_snd,
 	smc = container_of(cdcpend->conn, struct smc_sock, conn);
 	bh_lock_sock(&smc->sk);
 	if (!wc_status) {
-		diff = smc_curs_diff(cdcpend->conn->sndbuf_size,
+		diff = smc_curs_diff(cdcpend->conn->sndbuf_desc->len,
 				     &cdcpend->conn->tx_curs_fin,
 				     &cdcpend->cursor);
 		/* sndbuf_space is decreased in smc_sendmsg */
 		smp_mb__before_atomic();
 		atomic_add(diff, &cdcpend->conn->sndbuf_space);
-		/* guarantee 0 <= sndbuf_space <= sndbuf_size */
+		/* guarantee 0 <= sndbuf_space <= sndbuf_desc->len */
 		smp_mb__after_atomic();
 		smc_curs_write(&cdcpend->conn->tx_curs_fin,
 			       smc_curs_read(&cdcpend->cursor, cdcpend->conn),
@@ -198,13 +198,13 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
 		smp_mb__after_atomic();
 	}
 
-	diff_prod = smc_curs_diff(conn->rmbe_size, &prod_old,
+	diff_prod = smc_curs_diff(conn->rmb_desc->len, &prod_old,
 				  &conn->local_rx_ctrl.prod);
 	if (diff_prod) {
 		/* bytes_to_rcv is decreased in smc_recvmsg */
 		smp_mb__before_atomic();
 		atomic_add(diff_prod, &conn->bytes_to_rcv);
-		/* guarantee 0 <= bytes_to_rcv <= rmbe_size */
+		/* guarantee 0 <= bytes_to_rcv <= rmb_desc->len */
 		smp_mb__after_atomic();
 		smc->sk.sk_data_ready(&smc->sk);
 	} else if ((conn->local_rx_ctrl.prod_flags.write_blocked) ||
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 08c05cd0bbae..6396426080f9 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -236,15 +236,12 @@ static int smc_lgr_create(struct smc_sock *smc,
 
 static void smc_buf_unuse(struct smc_connection *conn)
 {
-	if (conn->sndbuf_desc) {
+	if (conn->sndbuf_desc)
 		conn->sndbuf_desc->used = 0;
-		conn->sndbuf_size = 0;
-	}
 	if (conn->rmb_desc) {
 		if (!conn->rmb_desc->regerr) {
 			conn->rmb_desc->reused = 1;
 			conn->rmb_desc->used = 0;
-			conn->rmbe_size = 0;
 		} else {
 			/* buf registration failed, reuse not possible */
 			struct smc_link_group *lgr = conn->lgr;
@@ -616,6 +613,7 @@ static struct smc_buf_desc *smc_new_buf_create(struct smc_link_group *lgr,
 		}
 	}
 
+	buf_desc->len = bufsize;
 	return buf_desc;
 }
 
@@ -675,14 +673,12 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_rmb)
 
 	if (is_rmb) {
 		conn->rmb_desc = buf_desc;
-		conn->rmbe_size = bufsize;
 		conn->rmbe_size_short = bufsize_short;
 		smc->sk.sk_rcvbuf = bufsize * 2;
 		atomic_set(&conn->bytes_to_rcv, 0);
 		conn->rmbe_update_limit = smc_rmb_wnd_update_limit(bufsize);
 	} else {
 		conn->sndbuf_desc = buf_desc;
-		conn->sndbuf_size = bufsize;
 		smc->sk.sk_sndbuf = bufsize * 2;
 		atomic_set(&conn->sndbuf_space, bufsize);
 	}
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 845dc073de13..4885a7efa84f 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -124,6 +124,7 @@ struct smc_buf_desc {
 	struct list_head	list;
 	void			*cpu_addr;	/* virtual address of buffer */
 	struct page		*pages;
+	int			len;		/* length of buffer */
 	struct sg_table		sgt[SMC_LINKS_PER_LGR_MAX];/* virtual buffer */
 	struct ib_mr		*mr_rx[SMC_LINKS_PER_LGR_MAX];
 						/* for rmb only: memory region
diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index 05dd7e6d314d..839354402215 100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -101,8 +101,9 @@ static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
 		struct smc_connection *conn = &smc->conn;
 		struct smc_diag_conninfo cinfo = {
 			.token = conn->alert_token_local,
-			.sndbuf_size = conn->sndbuf_size,
-			.rmbe_size = conn->rmbe_size,
+			.sndbuf_size = conn->sndbuf_desc ?
+				conn->sndbuf_desc->len : 0,
+			.rmbe_size = conn->rmb_desc ? conn->rmb_desc->len : 0,
 			.peer_rmbe_size = conn->peer_rmbe_size,
 
 			.rx_prod.wrap = conn->local_rx_ctrl.prod.wrap,
diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index ed45569289f5..290a434471d1 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -51,7 +51,7 @@ static void smc_rx_wake_up(struct sock *sk)
 static void smc_rx_update_consumer(struct smc_connection *conn,
 				   union smc_host_cursor cons, size_t len)
 {
-	smc_curs_add(conn->rmbe_size, &cons, len);
+	smc_curs_add(conn->rmb_desc->len, &cons, len);
 	smc_curs_write(&conn->local_tx_ctrl.cons, smc_curs_read(&cons, conn),
 		       conn);
 	/* send consumer cursor update if required */
@@ -288,11 +288,11 @@ int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg,
 			       conn);
 		/* subsequent splice() calls pick up where previous left */
 		if (splbytes)
-			smc_curs_add(conn->rmbe_size, &cons, splbytes);
+			smc_curs_add(conn->rmb_desc->len, &cons, splbytes);
 		/* determine chunks where to read from rcvbuf */
 		/* either unwrapped case, or 1st chunk of wrapped case */
-		chunk_len = min_t(size_t,
-				  copylen, conn->rmbe_size - cons.count);
+		chunk_len = min_t(size_t, copylen, conn->rmb_desc->len -
+				  cons.count);
 		chunk_len_sum = chunk_len;
 		chunk_off = cons.count;
 		smc_rmb_sync_sg_for_cpu(conn);
@@ -331,7 +331,7 @@ int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg,
 			/* increased in recv tasklet smc_cdc_msg_rcv() */
 			smp_mb__before_atomic();
 			atomic_sub(copylen, &conn->bytes_to_rcv);
-			/* guarantee 0 <= bytes_to_rcv <= rmbe_size */
+			/* guarantee 0 <= bytes_to_rcv <= rmb_desc->len */
 			smp_mb__after_atomic();
 			if (msg)
 				smc_rx_update_consumer(conn, cons, copylen);
diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index 08a7de98bb03..58bc7ca3101a 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -180,8 +180,8 @@ int smc_tx_sendmsg(struct smc_sock *smc, struct msghdr *msg, size_t len)
 		tx_cnt_prep = prep.count;
 		/* determine chunks where to write into sndbuf */
 		/* either unwrapped case, or 1st chunk of wrapped case */
-		chunk_len = min_t(size_t,
-				  copylen, conn->sndbuf_size - tx_cnt_prep);
+		chunk_len = min_t(size_t, copylen, conn->sndbuf_desc->len -
+				  tx_cnt_prep);
 		chunk_len_sum = chunk_len;
 		chunk_off = tx_cnt_prep;
 		smc_sndbuf_sync_sg_for_cpu(conn);
@@ -206,21 +206,21 @@ int smc_tx_sendmsg(struct smc_sock *smc, struct msghdr *msg, size_t len)
 		}
 		smc_sndbuf_sync_sg_for_device(conn);
 		/* update cursors */
-		smc_curs_add(conn->sndbuf_size, &prep, copylen);
+		smc_curs_add(conn->sndbuf_desc->len, &prep, copylen);
 		smc_curs_write(&conn->tx_curs_prep,
 			       smc_curs_read(&prep, conn),
 			       conn);
 		/* increased in send tasklet smc_cdc_tx_handler() */
 		smp_mb__before_atomic();
 		atomic_sub(copylen, &conn->sndbuf_space);
-		/* guarantee 0 <= sndbuf_space <= sndbuf_size */
+		/* guarantee 0 <= sndbuf_space <= sndbuf_desc->len */
 		smp_mb__after_atomic();
 		/* since we just produced more new data into sndbuf,
 		 * trigger sndbuf consumer: RDMA write into peer RMBE and CDC
 		 */
 		if ((msg->msg_flags & MSG_MORE || smc_tx_is_corked(smc)) &&
 		    (atomic_read(&conn->sndbuf_space) >
-						(conn->sndbuf_size >> 1)))
+						(conn->sndbuf_desc->len >> 1)))
 			/* for a corked socket defer the RDMA writes if there
 			 * is still sufficient sndbuf_space available
 			 */
@@ -286,7 +286,7 @@ static inline void smc_tx_advance_cursors(struct smc_connection *conn,
 	atomic_sub(len, &conn->peer_rmbe_space);
 	/* guarantee 0 <= peer_rmbe_space <= peer_rmbe_size */
 	smp_mb__after_atomic();
-	smc_curs_add(conn->sndbuf_size, sent, len);
+	smc_curs_add(conn->sndbuf_desc->len, sent, len);
 }
 
 /* sndbuf consumer: prepare all necessary (src&dst) chunks of data transmit;
@@ -309,7 +309,7 @@ static int smc_tx_rdma_writes(struct smc_connection *conn)
 	smc_curs_write(&sent, smc_curs_read(&conn->tx_curs_sent, conn), conn);
 	smc_curs_write(&prep, smc_curs_read(&conn->tx_curs_prep, conn), conn);
 	/* cf. wmem_alloc - (snd_max - snd_una) */
-	to_send = smc_curs_diff(conn->sndbuf_size, &sent, &prep);
+	to_send = smc_curs_diff(conn->sndbuf_desc->len, &sent, &prep);
 	if (to_send <= 0)
 		return 0;
 
@@ -351,12 +351,12 @@ static int smc_tx_rdma_writes(struct smc_connection *conn)
 	dst_len_sum = dst_len;
 	src_off = sent.count;
 	/* dst_len determines the maximum src_len */
-	if (sent.count + dst_len <= conn->sndbuf_size) {
+	if (sent.count + dst_len <= conn->sndbuf_desc->len) {
 		/* unwrapped src case: single chunk of entire dst_len */
 		src_len = dst_len;
 	} else {
 		/* wrapped src case: 2 chunks of sum dst_len; start with 1st: */
-		src_len = conn->sndbuf_size - sent.count;
+		src_len = conn->sndbuf_desc->len - sent.count;
 	}
 	src_len_sum = src_len;
 	dma_addr = sg_dma_address(conn->sndbuf_desc->sgt[SMC_SINGLE_LINK].sgl);
@@ -368,8 +368,8 @@ static int smc_tx_rdma_writes(struct smc_connection *conn)
 			sges[srcchunk].lkey = link->roce_pd->local_dma_lkey;
 			num_sges++;
 			src_off += src_len;
-			if (src_off >= conn->sndbuf_size)
-				src_off -= conn->sndbuf_size;
+			if (src_off >= conn->sndbuf_desc->len)
+				src_off -= conn->sndbuf_desc->len;
 						/* modulo in send ring */
 			if (src_len_sum == dst_len)
 				break; /* either on 1st or 2nd iteration */
@@ -387,7 +387,7 @@ static int smc_tx_rdma_writes(struct smc_connection *conn)
 		dst_len = len - dst_len; /* remainder */
 		dst_len_sum += dst_len;
 		src_len = min_t(int,
-				dst_len, conn->sndbuf_size - sent.count);
+				dst_len, conn->sndbuf_desc->len - sent.count);
 		src_len_sum = src_len;
 	}
 
@@ -484,11 +484,11 @@ void smc_tx_consumer_update(struct smc_connection *conn)
 	smc_curs_write(&cfed,
 		       smc_curs_read(&conn->rx_curs_confirmed, conn),
 		       conn);
-	to_confirm = smc_curs_diff(conn->rmbe_size, &cfed, &cons);
+	to_confirm = smc_curs_diff(conn->rmb_desc->len, &cfed, &cons);
 
 	if (conn->local_rx_ctrl.prod_flags.cons_curs_upd_req ||
 	    ((to_confirm > conn->rmbe_update_limit) &&
-	     ((to_confirm > (conn->rmbe_size / 2)) ||
+	     ((to_confirm > (conn->rmb_desc->len / 2)) ||
 	      conn->local_rx_ctrl.prod_flags.write_blocked))) {
 		if ((smc_cdc_get_slot_and_msg_send(conn) < 0) &&
 		    conn->alert_token_local) { /* connection healthy */
diff --git a/net/smc/smc_tx.h b/net/smc/smc_tx.h
index 8f64b12bf03c..44d077942976 100644
--- a/net/smc/smc_tx.h
+++ b/net/smc/smc_tx.h
@@ -24,7 +24,7 @@ static inline int smc_tx_prepared_sends(struct smc_connection *conn)
 
 	smc_curs_write(&sent, smc_curs_read(&conn->tx_curs_sent, conn), conn);
 	smc_curs_write(&prep, smc_curs_read(&conn->tx_curs_prep, conn), conn);
-	return smc_curs_diff(conn->sndbuf_size, &sent, &prep);
+	return smc_curs_diff(conn->sndbuf_desc->len, &sent, &prep);
 }
 
 void smc_tx_work(struct work_struct *work);
-- 
2.16.3
