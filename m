Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56830 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727344AbfJUONb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 21 Oct 2019 10:13:31 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9LEDHhK144767
        for <linux-s390@vger.kernel.org>; Mon, 21 Oct 2019 10:13:29 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vsdyugt2j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 21 Oct 2019 10:13:28 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Mon, 21 Oct 2019 15:13:26 +0100
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 8/8] net/smc: remove close abort worker
Date: Mon, 21 Oct 2019 16:13:15 +0200
In-Reply-To: <20191021141315.58969-1-kgraul@linux.ibm.com>
References: <20191021141315.58969-1-kgraul@linux.ibm.com>
Message-Id: <20191021141315.58969-9-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, gor@linux.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>

With the introduction of the link group termination worker there is
no longer a need to postpone smc_close_active_abort() to a worker.
To protect socket destruction due to normal and abnormal socket
closing, the socket refcount is increased.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/af_smc.c    |  4 ++++
 net/smc/smc_close.c | 18 +++++++++++-------
 net/smc/smc_close.h |  1 +
 net/smc/smc_core.c  |  6 +++---
 4 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 5b932583e407..91ea098fabd9 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -167,6 +167,7 @@ static int smc_release(struct socket *sock)
 	if (!sk)
 		goto out;
 
+	sock_hold(sk); /* sock_put below */
 	smc = smc_sk(sk);
 
 	/* cleanup for a dangling non-blocking connect */
@@ -189,6 +190,7 @@ static int smc_release(struct socket *sock)
 	sock->sk = NULL;
 	release_sock(sk);
 
+	sock_put(sk); /* sock_hold above */
 	sock_put(sk); /* final sock_put */
 out:
 	return rc;
@@ -970,12 +972,14 @@ void smc_close_non_accepted(struct sock *sk)
 {
 	struct smc_sock *smc = smc_sk(sk);
 
+	sock_hold(sk); /* sock_put below */
 	lock_sock(sk);
 	if (!sk->sk_lingertime)
 		/* wait for peer closing */
 		sk->sk_lingertime = SMC_MAX_STREAM_WAIT_TIMEOUT;
 	__smc_release(smc);
 	release_sock(sk);
+	sock_put(sk); /* sock_hold above */
 	sock_put(sk); /* final sock_put */
 }
 
diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
index 2bbcd45a421e..d34e5adce2eb 100644
--- a/net/smc/smc_close.c
+++ b/net/smc/smc_close.c
@@ -113,9 +113,10 @@ int smc_close_abort(struct smc_connection *conn)
 /* terminate smc socket abnormally - active abort
  * link group is terminated, i.e. RDMA communication no longer possible
  */
-static void smc_close_active_abort(struct smc_sock *smc)
+void smc_close_active_abort(struct smc_sock *smc)
 {
 	struct sock *sk = &smc->sk;
+	bool release_clcsock = false;
 
 	if (sk->sk_state != SMC_INIT && smc->clcsock && smc->clcsock->sk) {
 		sk->sk_err = ECONNABORTED;
@@ -137,11 +138,14 @@ static void smc_close_active_abort(struct smc_sock *smc)
 		cancel_delayed_work_sync(&smc->conn.tx_work);
 		lock_sock(sk);
 		sk->sk_state = SMC_CLOSED;
+		sock_put(sk); /* postponed passive closing */
 		break;
 	case SMC_PEERCLOSEWAIT1:
 	case SMC_PEERCLOSEWAIT2:
 	case SMC_PEERFINCLOSEWAIT:
 		sk->sk_state = SMC_CLOSED;
+		smc_conn_free(&smc->conn);
+		release_clcsock = true;
 		sock_put(sk); /* passive closing */
 		break;
 	case SMC_PROCESSABORT:
@@ -156,6 +160,12 @@ static void smc_close_active_abort(struct smc_sock *smc)
 
 	sock_set_flag(sk, SOCK_DEAD);
 	sk->sk_state_change(sk);
+
+	if (release_clcsock) {
+		release_sock(sk);
+		smc_clcsock_release(smc);
+		lock_sock(sk);
+	}
 }
 
 static inline bool smc_close_sent_any_close(struct smc_connection *conn)
@@ -328,12 +338,6 @@ static void smc_close_passive_work(struct work_struct *work)
 	lock_sock(sk);
 	old_state = sk->sk_state;
 
-	if (conn->killed) {
-		/* abnormal termination */
-		smc_close_active_abort(smc);
-		goto wakeup;
-	}
-
 	rxflags = &conn->local_rx_ctrl.conn_state_flags;
 	if (rxflags->peer_conn_abort) {
 		/* peer has not received all data */
diff --git a/net/smc/smc_close.h b/net/smc/smc_close.h
index 084c4f37aa96..634fea2b7c95 100644
--- a/net/smc/smc_close.h
+++ b/net/smc/smc_close.h
@@ -25,5 +25,6 @@ int smc_close_shutdown_write(struct smc_sock *smc);
 void smc_close_init(struct smc_sock *smc);
 void smc_clcsock_release(struct smc_sock *smc);
 int smc_close_abort(struct smc_connection *conn);
+void smc_close_active_abort(struct smc_sock *smc);
 
 #endif /* SMC_CLOSE_H */
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 46d4b944c4c4..ed02eac636da 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -519,9 +519,7 @@ static void smc_conn_kill(struct smc_connection *conn)
 	smc_sk_wake_ups(smc);
 	smc_lgr_unregister_conn(conn);
 	smc->sk.sk_err = ECONNABORTED;
-	sock_hold(&smc->sk); /* sock_put in close work */
-	if (!schedule_work(&conn->close_work))
-		sock_put(&smc->sk);
+	smc_close_active_abort(smc);
 }
 
 /* terminate link group */
@@ -544,9 +542,11 @@ static void __smc_lgr_terminate(struct smc_link_group *lgr)
 		read_unlock_bh(&lgr->conns_lock);
 		conn = rb_entry(node, struct smc_connection, alert_node);
 		smc = container_of(conn, struct smc_sock, conn);
+		sock_hold(&smc->sk); /* sock_put below */
 		lock_sock(&smc->sk);
 		smc_conn_kill(conn);
 		release_sock(&smc->sk);
+		sock_put(&smc->sk); /* sock_hold above */
 		read_lock_bh(&lgr->conns_lock);
 		node = rb_first(&lgr->conns_all);
 	}
-- 
2.17.1
