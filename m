Return-Path: <SRS0=h9J9=SO=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 1/8] net/smc: nonblocking connect rework
Date: Fri, 12 Apr 2019 12:57:23 +0200
In-Reply-To: <20190412105730.96245-1-ubraun@linux.ibm.com>
References: <20190412105730.96245-1-ubraun@linux.ibm.com>
Message-Id: <20190412105730.96245-2-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, kgraul@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

For nonblocking sockets move the kernel_connect() from the connect
worker into the initial smc_connect part to return kernel_connect()
errors other than -EINPROGRESS to user space.

Reviewed-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c | 78 +++++++++++++++++++++++++++++++-------------------------
 net/smc/smc.h    | 11 +++-----
 2 files changed, 47 insertions(+), 42 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 77ef53596d18..e1b7b5bdb440 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -134,11 +134,9 @@ static int smc_release(struct socket *sock)
 	smc = smc_sk(sk);
 
 	/* cleanup for a dangling non-blocking connect */
-	if (smc->connect_info && sk->sk_state == SMC_INIT)
+	if (smc->connect_nonblock && sk->sk_state == SMC_INIT)
 		tcp_abort(smc->clcsock->sk, ECONNABORTED);
 	flush_work(&smc->connect_work);
-	kfree(smc->connect_info);
-	smc->connect_info = NULL;
 
 	if (sk->sk_state == SMC_LISTEN)
 		/* smc_close_non_accepted() is called and acquires
@@ -452,6 +450,7 @@ static int smc_connect_fallback(struct smc_sock *smc, int reason_code)
 	smc->use_fallback = true;
 	smc->fallback_rsn = reason_code;
 	smc_copy_sock_settings_to_clc(smc);
+	smc->connect_nonblock = 0;
 	if (smc->sk.sk_state == SMC_INIT)
 		smc->sk.sk_state = SMC_ACTIVE;
 	return 0;
@@ -491,6 +490,7 @@ static int smc_connect_abort(struct smc_sock *smc, int reason_code,
 		mutex_unlock(&smc_client_lgr_pending);
 
 	smc_conn_free(&smc->conn);
+	smc->connect_nonblock = 0;
 	return reason_code;
 }
 
@@ -633,6 +633,7 @@ static int smc_connect_rdma(struct smc_sock *smc,
 	mutex_unlock(&smc_client_lgr_pending);
 
 	smc_copy_sock_settings_to_clc(smc);
+	smc->connect_nonblock = 0;
 	if (smc->sk.sk_state == SMC_INIT)
 		smc->sk.sk_state = SMC_ACTIVE;
 
@@ -671,6 +672,7 @@ static int smc_connect_ism(struct smc_sock *smc,
 	mutex_unlock(&smc_server_lgr_pending);
 
 	smc_copy_sock_settings_to_clc(smc);
+	smc->connect_nonblock = 0;
 	if (smc->sk.sk_state == SMC_INIT)
 		smc->sk.sk_state = SMC_ACTIVE;
 
@@ -756,17 +758,30 @@ static void smc_connect_work(struct work_struct *work)
 {
 	struct smc_sock *smc = container_of(work, struct smc_sock,
 					    connect_work);
-	int rc;
+	long timeo = smc->sk.sk_sndtimeo;
+	int rc = 0;
 
-	lock_sock(&smc->sk);
-	rc = kernel_connect(smc->clcsock, &smc->connect_info->addr,
-			    smc->connect_info->alen, smc->connect_info->flags);
+	if (!timeo)
+		timeo = MAX_SCHEDULE_TIMEOUT;
+	lock_sock(smc->clcsock->sk);
 	if (smc->clcsock->sk->sk_err) {
 		smc->sk.sk_err = smc->clcsock->sk->sk_err;
-		goto out;
-	}
-	if (rc < 0) {
-		smc->sk.sk_err = -rc;
+	} else if ((1 << smc->clcsock->sk->sk_state) &
+					(TCPF_SYN_SENT | TCP_SYN_RECV)) {
+		rc = sk_stream_wait_connect(smc->clcsock->sk, &timeo);
+		if ((rc == -EPIPE) &&
+		    ((1 << smc->clcsock->sk->sk_state) &
+					(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)))
+			rc = 0;
+	}
+	release_sock(smc->clcsock->sk);
+	lock_sock(&smc->sk);
+	if (rc != 0 || smc->sk.sk_err) {
+		smc->sk.sk_state = SMC_CLOSED;
+		if (rc == -EPIPE || rc == -EAGAIN)
+			smc->sk.sk_err = EPIPE;
+		else if (signal_pending(current))
+			smc->sk.sk_err = -sock_intr_errno(timeo);
 		goto out;
 	}
 
@@ -779,8 +794,6 @@ static void smc_connect_work(struct work_struct *work)
 		smc->sk.sk_state_change(&smc->sk);
 	else
 		smc->sk.sk_write_space(&smc->sk);
-	kfree(smc->connect_info);
-	smc->connect_info = NULL;
 	release_sock(&smc->sk);
 }
 
@@ -813,26 +826,18 @@ static int smc_connect(struct socket *sock, struct sockaddr *addr,
 
 	smc_copy_sock_settings_to_clc(smc);
 	tcp_sk(smc->clcsock->sk)->syn_smc = 1;
+	if (smc->connect_nonblock) {
+		rc = -EALREADY;
+		goto out;
+	}
+	rc = kernel_connect(smc->clcsock, addr, alen, flags);
+	if (rc && rc != -EINPROGRESS)
+		goto out;
 	if (flags & O_NONBLOCK) {
-		if (smc->connect_info) {
-			rc = -EALREADY;
-			goto out;
-		}
-		smc->connect_info = kzalloc(alen + 2 * sizeof(int), GFP_KERNEL);
-		if (!smc->connect_info) {
-			rc = -ENOMEM;
-			goto out;
-		}
-		smc->connect_info->alen = alen;
-		smc->connect_info->flags = flags ^ O_NONBLOCK;
-		memcpy(&smc->connect_info->addr, addr, alen);
-		schedule_work(&smc->connect_work);
+		if (schedule_work(&smc->connect_work))
+			smc->connect_nonblock = 1;
 		rc = -EINPROGRESS;
 	} else {
-		rc = kernel_connect(smc->clcsock, addr, alen, flags);
-		if (rc)
-			goto out;
-
 		rc = __smc_connect(smc);
 		if (rc < 0)
 			goto out;
@@ -1571,8 +1576,8 @@ static __poll_t smc_poll(struct file *file, struct socket *sock,
 			     poll_table *wait)
 {
 	struct sock *sk = sock->sk;
-	__poll_t mask = 0;
 	struct smc_sock *smc;
+	__poll_t mask = 0;
 
 	if (!sk)
 		return EPOLLNVAL;
@@ -1582,8 +1587,6 @@ static __poll_t smc_poll(struct file *file, struct socket *sock,
 		/* delegate to CLC child sock */
 		mask = smc->clcsock->ops->poll(file, smc->clcsock, wait);
 		sk->sk_err = smc->clcsock->sk->sk_err;
-		if (sk->sk_err)
-			mask |= EPOLLERR;
 	} else {
 		if (sk->sk_state != SMC_CLOSED)
 			sock_poll_wait(file, sock, wait);
@@ -1594,9 +1597,14 @@ static __poll_t smc_poll(struct file *file, struct socket *sock,
 			mask |= EPOLLHUP;
 		if (sk->sk_state == SMC_LISTEN) {
 			/* woken up by sk_data_ready in smc_listen_work() */
-			mask = smc_accept_poll(sk);
+			mask |= smc_accept_poll(sk);
+		} else if (smc->use_fallback) { /* as result of connect_work()*/
+			mask |= smc->clcsock->ops->poll(file, smc->clcsock,
+							   wait);
+			sk->sk_err = smc->clcsock->sk->sk_err;
 		} else {
-			if (atomic_read(&smc->conn.sndbuf_space) ||
+			if ((sk->sk_state != SMC_INIT &&
+			     atomic_read(&smc->conn.sndbuf_space)) ||
 			    sk->sk_shutdown & SEND_SHUTDOWN) {
 				mask |= EPOLLOUT | EPOLLWRNORM;
 			} else {
diff --git a/net/smc/smc.h b/net/smc/smc.h
index adbdf195eb08..878313f8d6c1 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -190,18 +190,11 @@ struct smc_connection {
 	u64			peer_token;	/* SMC-D token of peer */
 };
 
-struct smc_connect_info {
-	int			flags;
-	int			alen;
-	struct sockaddr		addr;
-};
-
 struct smc_sock {				/* smc sock container */
 	struct sock		sk;
 	struct socket		*clcsock;	/* internal tcp socket */
 	struct smc_connection	conn;		/* smc connection */
 	struct smc_sock		*listen_smc;	/* listen parent */
-	struct smc_connect_info *connect_info;	/* connect address & flags */
 	struct work_struct	connect_work;	/* handle non-blocking connect*/
 	struct work_struct	tcp_listen_work;/* handle tcp socket accepts */
 	struct work_struct	smc_listen_work;/* prepare new accept socket */
@@ -219,6 +212,10 @@ struct smc_sock {				/* smc sock container */
 						 * started, waiting for unsent
 						 * data to be sent
 						 */
+	u8			connect_nonblock : 1;
+						/* non-blocking connect in
+						 * flight
+						 */
 	struct mutex            clcsock_release_lock;
 						/* protects clcsock of a listen
 						 * socket
-- 
2.16.4
