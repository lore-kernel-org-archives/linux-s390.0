From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 3/4] net/smc: urgent data support
Date: Wed, 23 May 2018 16:38:11 +0200
Message-ID: <20180523143812.25824-4-ubraun@linux.ibm.com>
References: <20180523143812.25824-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180523143812.25824-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Raspl <raspl@linux.ibm.com>

Add support for out of band data send and receive.

Signed-off-by: Stefan Raspl <raspl@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c   |  24 ++++++++++-
 net/smc/smc.h      |  15 +++++++
 net/smc/smc_cdc.c  |  44 ++++++++++++++++++--
 net/smc/smc_cdc.h  |  13 ++++++
 net/smc/smc_core.c |   1 +
 net/smc/smc_rx.c   | 120 +++++++++++++++++++++++++++++++++++++++++++++++------
 net/smc/smc_tx.c   |  55 ++++++++++++++++--------
 net/smc/smc_tx.h   |   2 +-
 8 files changed, 238 insertions(+), 36 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index f2d925921d81..2c369d4bb1c1 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -8,8 +8,6 @@
  *
  *  Initial restrictions:
  *    - support for alternate links postponed
- *    - partial support for non-blocking sockets only
- *    - support for urgent data postponed
  *
  *  Copyright IBM Corp. 2016, 2018
  *
@@ -1338,6 +1336,8 @@ static __poll_t smc_poll(struct file *file, struct socket *sock,
 			if (sk->sk_state == SMC_APPCLOSEWAIT1)
 				mask |= EPOLLIN;
 		}
+		if (smc->conn.urg_state == SMC_URG_VALID)
+			mask |= EPOLLPRI;
 
 	}
 	release_sock(sk);
@@ -1477,10 +1477,13 @@ static int smc_getsockopt(struct socket *sock, int level, int optname,
 static int smc_ioctl(struct socket *sock, unsigned int cmd,
 		     unsigned long arg)
 {
+	union smc_host_cursor cons, urg;
+	struct smc_connection *conn;
 	struct smc_sock *smc;
 	int answ;
 
 	smc = smc_sk(sock->sk);
+	conn = &smc->conn;
 	if (smc->use_fallback) {
 		if (!smc->clcsock)
 			return -EBADF;
@@ -1517,6 +1520,23 @@ static int smc_ioctl(struct socket *sock, unsigned int cmd,
 		else
 			answ = smc_tx_prepared_sends(&smc->conn);
 		break;
+	case SIOCATMARK:
+		if (smc->sk.sk_state == SMC_LISTEN)
+			return -EINVAL;
+		if (smc->sk.sk_state == SMC_INIT ||
+		    smc->sk.sk_state == SMC_CLOSED) {
+			answ = 0;
+		} else {
+			smc_curs_write(&cons,
+			       smc_curs_read(&conn->local_tx_ctrl.cons, conn),
+				       conn);
+			smc_curs_write(&urg,
+				       smc_curs_read(&conn->urg_curs, conn),
+				       conn);
+			answ = smc_curs_diff(conn->rmb_desc->len,
+					     &cons, &urg) == 1;
+		}
+		break;
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/net/smc/smc.h b/net/smc/smc.h
index a1467e411645..51ae1f10d81a 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -114,6 +114,12 @@ struct smc_host_cdc_msg {		/* Connection Data Control message */
 	u8				reserved[18];
 } __aligned(8);
 
+enum smc_urg_state {
+	SMC_URG_VALID,			/* data present */
+	SMC_URG_NOTYET,			/* data pending */
+	SMC_URG_READ			/* data was already read */
+};
+
 struct smc_connection {
 	struct rb_node		alert_node;
 	struct smc_link_group	*lgr;		/* link group of connection */
@@ -160,6 +166,15 @@ struct smc_connection {
 	union smc_host_cursor	rx_curs_confirmed; /* confirmed to peer
 						    * source of snd_una ?
 						    */
+	union smc_host_cursor	urg_curs;	/* points at urgent byte */
+	enum smc_urg_state	urg_state;
+	bool			urg_tx_pend;	/* urgent data staged */
+	bool			urg_rx_skip_pend;
+						/* indicate urgent oob data
+						 * read, but previous regular
+						 * data still pending
+						 */
+	char			urg_rx_byte;	/* urgent byte */
 	atomic_t		bytes_to_rcv;	/* arrived data,
 						 * not yet received
 						 */
diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index 8d2c079c87b0..a7e8d63fc8ae 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -164,6 +164,28 @@ static inline bool smc_cdc_before(u16 seq1, u16 seq2)
 	return (s16)(seq1 - seq2) < 0;
 }
 
+static void smc_cdc_handle_urg_data_arrival(struct smc_sock *smc,
+					    int *diff_prod)
+{
+	struct smc_connection *conn = &smc->conn;
+	char *base;
+
+	/* new data included urgent business */
+	smc_curs_write(&conn->urg_curs,
+		       smc_curs_read(&conn->local_rx_ctrl.prod, conn),
+		       conn);
+	conn->urg_state = SMC_URG_VALID;
+	if (!sock_flag(&smc->sk, SOCK_URGINLINE))
+		/* we'll skip the urgent byte, so don't account for it */
+		(*diff_prod)--;
+	base = (char *)conn->rmb_desc->cpu_addr;
+	if (conn->urg_curs.count)
+		conn->urg_rx_byte = *(base + conn->urg_curs.count - 1);
+	else
+		conn->urg_rx_byte = *(base + conn->rmb_desc->len - 1);
+	sk_send_sigurg(&smc->sk);
+}
+
 static void smc_cdc_msg_recv_action(struct smc_sock *smc,
 				    struct smc_cdc_msg *cdc)
 {
@@ -194,15 +216,25 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
 	diff_prod = smc_curs_diff(conn->rmb_desc->len, &prod_old,
 				  &conn->local_rx_ctrl.prod);
 	if (diff_prod) {
+		if (conn->local_rx_ctrl.prod_flags.urg_data_present)
+			smc_cdc_handle_urg_data_arrival(smc, &diff_prod);
 		/* bytes_to_rcv is decreased in smc_recvmsg */
 		smp_mb__before_atomic();
 		atomic_add(diff_prod, &conn->bytes_to_rcv);
 		/* guarantee 0 <= bytes_to_rcv <= rmb_desc->len */
 		smp_mb__after_atomic();
 		smc->sk.sk_data_ready(&smc->sk);
-	} else if ((conn->local_rx_ctrl.prod_flags.write_blocked) ||
-		   (conn->local_rx_ctrl.prod_flags.cons_curs_upd_req)) {
-		smc->sk.sk_data_ready(&smc->sk);
+	} else {
+		if (conn->local_rx_ctrl.prod_flags.write_blocked ||
+		    conn->local_rx_ctrl.prod_flags.cons_curs_upd_req ||
+		    conn->local_rx_ctrl.prod_flags.urg_data_pending) {
+			if (conn->local_rx_ctrl.prod_flags.urg_data_pending)
+				conn->urg_state = SMC_URG_NOTYET;
+			/* force immediate tx of current consumer cursor, but
+			 * under send_lock to guarantee arrival in seqno-order
+			 */
+			smc_tx_sndbuf_nonempty(conn);
+		}
 	}
 
 	/* piggy backed tx info */
@@ -212,6 +244,12 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
 		/* trigger socket release if connection closed */
 		smc_close_wake_tx_prepared(smc);
 	}
+	if (diff_cons && conn->urg_tx_pend &&
+	    atomic_read(&conn->peer_rmbe_space) == conn->peer_rmbe_size) {
+		/* urg data confirmed by peer, indicate we're ready for more */
+		conn->urg_tx_pend = false;
+		smc->sk.sk_write_space(&smc->sk);
+	}
 
 	if (conn->local_rx_ctrl.conn_state_flags.peer_conn_abort) {
 		smc->sk.sk_err = ECONNRESET;
diff --git a/net/smc/smc_cdc.h b/net/smc/smc_cdc.h
index d2012fd22100..f60082fee5b8 100644
--- a/net/smc/smc_cdc.h
+++ b/net/smc/smc_cdc.h
@@ -146,6 +146,19 @@ static inline int smc_curs_diff(unsigned int size,
 	return max_t(int, 0, (new->count - old->count));
 }
 
+/* calculate cursor difference between old and new - returns negative
+ * value in case old > new
+ */
+static inline int smc_curs_comp(unsigned int size,
+				union smc_host_cursor *old,
+				union smc_host_cursor *new)
+{
+	if (old->wrap > new->wrap ||
+	    (old->wrap == new->wrap && old->count > new->count))
+		return -smc_curs_diff(size, new, old);
+	return smc_curs_diff(size, old, new);
+}
+
 static inline void smc_host_cursor_to_cdc(union smc_cdc_cursor *peer,
 					  union smc_host_cursor *local,
 					  struct smc_connection *conn)
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 21c244f53b0a..2bf138e7d3ec 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -544,6 +544,7 @@ int smc_conn_create(struct smc_sock *smc,
 	}
 	conn->local_tx_ctrl.common.type = SMC_CDC_MSG_TYPE;
 	conn->local_tx_ctrl.len = SMC_WR_TX_SIZE;
+	conn->urg_state = SMC_URG_READ;
 #ifndef KERNEL_HAS_ATOMIC64
 	spin_lock_init(&conn->acurs_lock);
 #endif
diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index 290a434471d1..3d77b383cccd 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -47,16 +47,59 @@ static void smc_rx_wake_up(struct sock *sk)
  *   @conn   connection to update
  *   @cons   consumer cursor
  *   @len    number of Bytes consumed
+ *   Returns:
+ *   1 if we should end our receive, 0 otherwise
  */
-static void smc_rx_update_consumer(struct smc_connection *conn,
-				   union smc_host_cursor cons, size_t len)
+static int smc_rx_update_consumer(struct smc_sock *smc,
+				  union smc_host_cursor cons, size_t len)
 {
+	struct smc_connection *conn = &smc->conn;
+	struct sock *sk = &smc->sk;
+	bool force = false;
+	int diff, rc = 0;
+
 	smc_curs_add(conn->rmb_desc->len, &cons, len);
+
+	/* did we process urgent data? */
+	if (conn->urg_state == SMC_URG_VALID || conn->urg_rx_skip_pend) {
+		diff = smc_curs_comp(conn->rmb_desc->len, &cons,
+				     &conn->urg_curs);
+		if (sock_flag(sk, SOCK_URGINLINE)) {
+			if (diff == 0) {
+				force = true;
+				rc = 1;
+				conn->urg_state = SMC_URG_READ;
+			}
+		} else {
+			if (diff == 1) {
+				/* skip urgent byte */
+				force = true;
+				smc_curs_add(conn->rmb_desc->len, &cons, 1);
+				conn->urg_rx_skip_pend = false;
+			} else if (diff < -1)
+				/* we read past urgent byte */
+				conn->urg_state = SMC_URG_READ;
+		}
+	}
+
 	smc_curs_write(&conn->local_tx_ctrl.cons, smc_curs_read(&cons, conn),
 		       conn);
+
 	/* send consumer cursor update if required */
 	/* similar to advertising new TCP rcv_wnd if required */
-	smc_tx_consumer_update(conn);
+	smc_tx_consumer_update(conn, force);
+
+	return rc;
+}
+
+static void smc_rx_update_cons(struct smc_sock *smc, size_t len)
+{
+	struct smc_connection *conn = &smc->conn;
+	union smc_host_cursor cons;
+
+	smc_curs_write(&cons, smc_curs_read(&conn->local_tx_ctrl.cons, conn),
+		       conn);
+	smc_rx_update_consumer(smc, cons, len);
 }
 
 struct smc_spd_priv {
@@ -70,7 +113,6 @@ static void smc_rx_pipe_buf_release(struct pipe_inode_info *pipe,
 	struct smc_spd_priv *priv = (struct smc_spd_priv *)buf->private;
 	struct smc_sock *smc = priv->smc;
 	struct smc_connection *conn;
-	union smc_host_cursor cons;
 	struct sock *sk = &smc->sk;
 
 	if (sk->sk_state == SMC_CLOSED ||
@@ -79,9 +121,7 @@ static void smc_rx_pipe_buf_release(struct pipe_inode_info *pipe,
 		goto out;
 	conn = &smc->conn;
 	lock_sock(sk);
-	smc_curs_write(&cons, smc_curs_read(&conn->local_tx_ctrl.cons, conn),
-		       conn);
-	smc_rx_update_consumer(conn, cons, priv->len);
+	smc_rx_update_cons(smc, priv->len);
 	release_sock(sk);
 	if (atomic_sub_and_test(priv->len, &conn->splice_pending))
 		smc_rx_wake_up(sk);
@@ -184,6 +224,52 @@ int smc_rx_wait(struct smc_sock *smc, long *timeo,
 	return rc;
 }
 
+static int smc_rx_recv_urg(struct smc_sock *smc, struct msghdr *msg, int len,
+			   int flags)
+{
+	struct smc_connection *conn = &smc->conn;
+	union smc_host_cursor cons;
+	struct sock *sk = &smc->sk;
+	int rc = 0;
+
+	if (sock_flag(sk, SOCK_URGINLINE) ||
+	    !(conn->urg_state == SMC_URG_VALID) ||
+	    conn->urg_state == SMC_URG_READ)
+		return -EINVAL;
+
+	if (conn->urg_state == SMC_URG_VALID) {
+		if (!(flags & MSG_PEEK))
+			smc->conn.urg_state = SMC_URG_READ;
+		msg->msg_flags |= MSG_OOB;
+		if (len > 0) {
+			if (!(flags & MSG_TRUNC))
+				rc = memcpy_to_msg(msg, &conn->urg_rx_byte, 1);
+			len = 1;
+			smc_curs_write(&cons,
+				       smc_curs_read(&conn->local_tx_ctrl.cons,
+						     conn),
+				       conn);
+			if (smc_curs_diff(conn->rmb_desc->len, &cons,
+					  &conn->urg_curs) > 1)
+				conn->urg_rx_skip_pend = true;
+			/* Urgent Byte was already accounted for, but trigger
+			 * skipping the urgent byte in non-inline case
+			 */
+			if (!(flags & MSG_PEEK))
+				smc_rx_update_consumer(smc, cons, 0);
+		} else {
+			msg->msg_flags |= MSG_TRUNC;
+		}
+
+		return rc ? -EFAULT : len;
+	}
+
+	if (sk->sk_state == SMC_CLOSED || sk->sk_shutdown & RCV_SHUTDOWN)
+		return 0;
+
+	return -EAGAIN;
+}
+
 /* smc_rx_recvmsg - receive data from RMBE
  * @msg:	copy data to receive buffer
  * @pipe:	copy data to pipe if set - indicates splice() call
@@ -209,12 +295,12 @@ int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg,
 
 	if (unlikely(flags & MSG_ERRQUEUE))
 		return -EINVAL; /* future work for sk.sk_family == AF_SMC */
-	if (flags & MSG_OOB)
-		return -EINVAL; /* future work */
 
 	sk = &smc->sk;
 	if (sk->sk_state == SMC_LISTEN)
 		return -ENOTCONN;
+	if (flags & MSG_OOB)
+		return smc_rx_recv_urg(smc, msg, len, flags);
 	timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
 	target = sock_rcvlowat(sk, flags & MSG_WAITALL, len);
 
@@ -227,6 +313,9 @@ int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg,
 
 		if (atomic_read(&conn->bytes_to_rcv))
 			goto copy;
+		else if (conn->urg_state == SMC_URG_VALID)
+			/* we received a single urgent Byte - skip */
+			smc_rx_update_cons(smc, 0);
 
 		if (sk->sk_shutdown & RCV_SHUTDOWN ||
 		    smc_cdc_rxed_any_close_or_senddone(conn) ||
@@ -281,14 +370,18 @@ int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg,
 			continue;
 		}
 
-		/* not more than what user space asked for */
-		copylen = min_t(size_t, read_remaining, readable);
 		smc_curs_write(&cons,
 			       smc_curs_read(&conn->local_tx_ctrl.cons, conn),
 			       conn);
 		/* subsequent splice() calls pick up where previous left */
 		if (splbytes)
 			smc_curs_add(conn->rmb_desc->len, &cons, splbytes);
+		if (conn->urg_state == SMC_URG_VALID &&
+		    sock_flag(&smc->sk, SOCK_URGINLINE) &&
+		    readable > 1)
+			readable--;	/* always stop at urgent Byte */
+		/* not more than what user space asked for */
+		copylen = min_t(size_t, read_remaining, readable);
 		/* determine chunks where to read from rcvbuf */
 		/* either unwrapped case, or 1st chunk of wrapped case */
 		chunk_len = min_t(size_t, copylen, conn->rmb_desc->len -
@@ -333,8 +426,8 @@ int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg,
 			atomic_sub(copylen, &conn->bytes_to_rcv);
 			/* guarantee 0 <= bytes_to_rcv <= rmb_desc->len */
 			smp_mb__after_atomic();
-			if (msg)
-				smc_rx_update_consumer(conn, cons, copylen);
+			if (msg && smc_rx_update_consumer(smc, cons, copylen))
+				goto out;
 		}
 	} while (read_remaining);
 out:
@@ -346,4 +439,5 @@ void smc_rx_init(struct smc_sock *smc)
 {
 	smc->sk.sk_data_ready = smc_rx_wake_up;
 	atomic_set(&smc->conn.splice_pending, 0);
+	smc->conn.urg_state = SMC_URG_READ;
 }
diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index 1f4a38b857f0..cee666400752 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -32,7 +32,7 @@
 /***************************** sndbuf producer *******************************/
 
 /* callback implementation for sk.sk_write_space()
- * to wakeup sndbuf producers that blocked with smc_tx_wait_memory().
+ * to wakeup sndbuf producers that blocked with smc_tx_wait().
  * called under sk_socket lock.
  */
 static void smc_tx_write_space(struct sock *sk)
@@ -56,7 +56,7 @@ static void smc_tx_write_space(struct sock *sk)
 	}
 }
 
-/* Wakeup sndbuf producers that blocked with smc_tx_wait_memory().
+/* Wakeup sndbuf producers that blocked with smc_tx_wait().
  * Cf. tcp_data_snd_check()=>tcp_check_space()=>tcp_new_space().
  */
 void smc_tx_sndbuf_nonfull(struct smc_sock *smc)
@@ -66,8 +66,10 @@ void smc_tx_sndbuf_nonfull(struct smc_sock *smc)
 		smc->sk.sk_write_space(&smc->sk);
 }
 
-/* blocks sndbuf producer until at least one byte of free space available */
-static int smc_tx_wait_memory(struct smc_sock *smc, int flags)
+/* blocks sndbuf producer until at least one byte of free space available
+ * or urgent Byte was consumed
+ */
+static int smc_tx_wait(struct smc_sock *smc, int flags)
 {
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 	struct smc_connection *conn = &smc->conn;
@@ -103,14 +105,15 @@ static int smc_tx_wait_memory(struct smc_sock *smc, int flags)
 			break;
 		}
 		sk_clear_bit(SOCKWQ_ASYNC_NOSPACE, sk);
-		if (atomic_read(&conn->sndbuf_space))
-			break; /* at least 1 byte of free space available */
+		if (atomic_read(&conn->sndbuf_space) && !conn->urg_tx_pend)
+			break; /* at least 1 byte of free & no urgent data */
 		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
 		sk_wait_event(sk, &timeo,
 			      sk->sk_err ||
 			      (sk->sk_shutdown & SEND_SHUTDOWN) ||
 			      smc_cdc_rxed_any_close(conn) ||
-			      atomic_read(&conn->sndbuf_space),
+			      (atomic_read(&conn->sndbuf_space) &&
+			       !conn->urg_tx_pend),
 			      &wait);
 	}
 	remove_wait_queue(sk_sleep(sk), &wait);
@@ -157,8 +160,11 @@ int smc_tx_sendmsg(struct smc_sock *smc, struct msghdr *msg, size_t len)
 		if (smc_cdc_rxed_any_close(conn))
 			return send_done ?: -ECONNRESET;
 
-		if (!atomic_read(&conn->sndbuf_space)) {
-			rc = smc_tx_wait_memory(smc, msg->msg_flags);
+		if (msg->msg_flags & MSG_OOB)
+			conn->local_tx_ctrl.prod_flags.urg_data_pending = 1;
+
+		if (!atomic_read(&conn->sndbuf_space) || conn->urg_tx_pend) {
+			rc = smc_tx_wait(smc, msg->msg_flags);
 			if (rc) {
 				if (send_done)
 					return send_done;
@@ -168,7 +174,7 @@ int smc_tx_sendmsg(struct smc_sock *smc, struct msghdr *msg, size_t len)
 		}
 
 		/* initialize variables for 1st iteration of subsequent loop */
-		/* could be just 1 byte, even after smc_tx_wait_memory above */
+		/* could be just 1 byte, even after smc_tx_wait above */
 		writespace = atomic_read(&conn->sndbuf_space);
 		/* not more than what user space asked for */
 		copylen = min_t(size_t, send_remaining, writespace);
@@ -218,6 +224,8 @@ int smc_tx_sendmsg(struct smc_sock *smc, struct msghdr *msg, size_t len)
 		/* since we just produced more new data into sndbuf,
 		 * trigger sndbuf consumer: RDMA write into peer RMBE and CDC
 		 */
+		if ((msg->msg_flags & MSG_OOB) && !send_remaining)
+			conn->urg_tx_pend = true;
 		if ((msg->msg_flags & MSG_MORE || smc_tx_is_corked(smc)) &&
 		    (atomic_read(&conn->sndbuf_space) >
 						(conn->sndbuf_desc->len >> 1)))
@@ -299,6 +307,7 @@ static int smc_tx_rdma_writes(struct smc_connection *conn)
 	union smc_host_cursor sent, prep, prod, cons;
 	struct ib_sge sges[SMC_IB_MAX_SEND_SGE];
 	struct smc_link_group *lgr = conn->lgr;
+	struct smc_cdc_producer_flags *pflags;
 	int to_send, rmbespace;
 	struct smc_link *link;
 	dma_addr_t dma_addr;
@@ -326,7 +335,8 @@ static int smc_tx_rdma_writes(struct smc_connection *conn)
 		       conn);
 
 	/* if usable snd_wnd closes ask peer to advertise once it opens again */
-	conn->local_tx_ctrl.prod_flags.write_blocked = (to_send >= rmbespace);
+	pflags = &conn->local_tx_ctrl.prod_flags;
+	pflags->write_blocked = (to_send >= rmbespace);
 	/* cf. usable snd_wnd */
 	len = min(to_send, rmbespace);
 
@@ -391,6 +401,8 @@ static int smc_tx_rdma_writes(struct smc_connection *conn)
 		src_len_sum = src_len;
 	}
 
+	if (conn->urg_tx_pend && len == to_send)
+		pflags->urg_data_present = 1;
 	smc_tx_advance_cursors(conn, &prod, &sent, len);
 	/* update connection's cursors with advanced local cursors */
 	smc_curs_write(&conn->local_tx_ctrl.prod,
@@ -410,6 +422,7 @@ static int smc_tx_rdma_writes(struct smc_connection *conn)
  */
 int smc_tx_sndbuf_nonempty(struct smc_connection *conn)
 {
+	struct smc_cdc_producer_flags *pflags;
 	struct smc_cdc_tx_pend *pend;
 	struct smc_wr_buf *wr_buf;
 	int rc;
@@ -433,14 +446,21 @@ int smc_tx_sndbuf_nonempty(struct smc_connection *conn)
 		goto out_unlock;
 	}
 
-	rc = smc_tx_rdma_writes(conn);
-	if (rc) {
-		smc_wr_tx_put_slot(&conn->lgr->lnk[SMC_SINGLE_LINK],
-				   (struct smc_wr_tx_pend_priv *)pend);
-		goto out_unlock;
+	if (!conn->local_tx_ctrl.prod_flags.urg_data_present) {
+		rc = smc_tx_rdma_writes(conn);
+		if (rc) {
+			smc_wr_tx_put_slot(&conn->lgr->lnk[SMC_SINGLE_LINK],
+					   (struct smc_wr_tx_pend_priv *)pend);
+			goto out_unlock;
+		}
 	}
 
 	rc = smc_cdc_msg_send(conn, wr_buf, pend);
+	pflags = &conn->local_tx_ctrl.prod_flags;
+	if (!rc && pflags->urg_data_present) {
+		pflags->urg_data_pending = 0;
+		pflags->urg_data_present = 0;
+	}
 
 out_unlock:
 	spin_unlock_bh(&conn->send_lock);
@@ -473,7 +493,7 @@ void smc_tx_work(struct work_struct *work)
 	release_sock(&smc->sk);
 }
 
-void smc_tx_consumer_update(struct smc_connection *conn)
+void smc_tx_consumer_update(struct smc_connection *conn, bool force)
 {
 	union smc_host_cursor cfed, cons;
 	int to_confirm;
@@ -487,6 +507,7 @@ void smc_tx_consumer_update(struct smc_connection *conn)
 	to_confirm = smc_curs_diff(conn->rmb_desc->len, &cfed, &cons);
 
 	if (conn->local_rx_ctrl.prod_flags.cons_curs_upd_req ||
+	    force ||
 	    ((to_confirm > conn->rmbe_update_limit) &&
 	     ((to_confirm > (conn->rmb_desc->len / 2)) ||
 	      conn->local_rx_ctrl.prod_flags.write_blocked))) {
diff --git a/net/smc/smc_tx.h b/net/smc/smc_tx.h
index 44d077942976..9d2238909fa0 100644
--- a/net/smc/smc_tx.h
+++ b/net/smc/smc_tx.h
@@ -32,6 +32,6 @@ void smc_tx_init(struct smc_sock *smc);
 int smc_tx_sendmsg(struct smc_sock *smc, struct msghdr *msg, size_t len);
 int smc_tx_sndbuf_nonempty(struct smc_connection *conn);
 void smc_tx_sndbuf_nonfull(struct smc_sock *smc);
-void smc_tx_consumer_update(struct smc_connection *conn);
+void smc_tx_consumer_update(struct smc_connection *conn, bool force);
 
 #endif /* SMC_TX_H */
-- 
2.16.3
