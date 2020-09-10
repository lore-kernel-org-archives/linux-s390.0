Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59370 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726801AbgIJQtV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Sep 2020 12:49:21 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 01/10] net/smc: reduce active tcp_listen workers
Date: Thu, 10 Sep 2020 18:48:20 +0200
Message-Id: <20200910164829.65426-2-kgraul@linux.ibm.com>
In-Reply-To: <20200910164829.65426-1-kgraul@linux.ibm.com>
References: <20200910164829.65426-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>

SMC starts a separate tcp_listen worker for every SMC socket in
state SMC_LISTEN, and can accept an incoming connection request only,
if this worker is really running and waiting in kernel_accept(). But
the number of running workers is limited.
This patch reworks the listening SMC code and starts a tcp_listen worker
after the SYN-ACK handshake on the internal clc-socket only.

Suggested-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Reviewed-by: Guvenc Gulce <guvenc@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/af_smc.c    | 38 +++++++++++++++++++++++++++++++-------
 net/smc/smc.h       |  2 ++
 net/smc/smc_close.c |  7 +++----
 3 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index e7649bbc2b87..7212de4da71d 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -940,10 +940,10 @@ static int smc_clcsock_accept(struct smc_sock *lsmc, struct smc_sock **new_smc)
 
 	mutex_lock(&lsmc->clcsock_release_lock);
 	if (lsmc->clcsock)
-		rc = kernel_accept(lsmc->clcsock, &new_clcsock, 0);
+		rc = kernel_accept(lsmc->clcsock, &new_clcsock, SOCK_NONBLOCK);
 	mutex_unlock(&lsmc->clcsock_release_lock);
 	lock_sock(lsk);
-	if  (rc < 0)
+	if  (rc < 0 && rc != -EAGAIN)
 		lsk->sk_err = -rc;
 	if (rc < 0 || lsk->sk_state == SMC_CLOSED) {
 		new_sk->sk_prot->unhash(new_sk);
@@ -956,6 +956,10 @@ static int smc_clcsock_accept(struct smc_sock *lsmc, struct smc_sock **new_smc)
 		goto out;
 	}
 
+	/* new clcsock has inherited the smc listen-specific sk_data_ready
+	 * function; switch it back to the original sk_data_ready function
+	 */
+	new_clcsock->sk->sk_data_ready = lsmc->clcsk_data_ready;
 	(*new_smc)->clcsock = new_clcsock;
 out:
 	return rc;
@@ -1406,7 +1410,7 @@ static void smc_tcp_listen_work(struct work_struct *work)
 	lock_sock(lsk);
 	while (lsk->sk_state == SMC_LISTEN) {
 		rc = smc_clcsock_accept(lsmc, &new_smc);
-		if (rc)
+		if (rc) /* clcsock accept queue empty or error */
 			goto out;
 		if (!new_smc)
 			continue;
@@ -1426,7 +1430,23 @@ static void smc_tcp_listen_work(struct work_struct *work)
 
 out:
 	release_sock(lsk);
-	sock_put(&lsmc->sk); /* sock_hold in smc_listen */
+	sock_put(&lsmc->sk); /* sock_hold in smc_clcsock_data_ready() */
+}
+
+static void smc_clcsock_data_ready(struct sock *listen_clcsock)
+{
+	struct smc_sock *lsmc;
+
+	lsmc = (struct smc_sock *)
+	       ((uintptr_t)listen_clcsock->sk_user_data & ~SK_USER_DATA_NOCOPY);
+	if (!lsmc)
+		return;
+	lsmc->clcsk_data_ready(listen_clcsock);
+	if (lsmc->sk.sk_state == SMC_LISTEN) {
+		sock_hold(&lsmc->sk); /* sock_put in smc_tcp_listen_work() */
+		if (!schedule_work(&lsmc->tcp_listen_work))
+			sock_put(&lsmc->sk);
+	}
 }
 
 static int smc_listen(struct socket *sock, int backlog)
@@ -1455,15 +1475,19 @@ static int smc_listen(struct socket *sock, int backlog)
 	if (!smc->use_fallback)
 		tcp_sk(smc->clcsock->sk)->syn_smc = 1;
 
+	/* save original sk_data_ready function and establish
+	 * smc-specific sk_data_ready function
+	 */
+	smc->clcsk_data_ready = smc->clcsock->sk->sk_data_ready;
+	smc->clcsock->sk->sk_data_ready = smc_clcsock_data_ready;
+	smc->clcsock->sk->sk_user_data =
+		(void *)((uintptr_t)smc | SK_USER_DATA_NOCOPY);
 	rc = kernel_listen(smc->clcsock, backlog);
 	if (rc)
 		goto out;
 	sk->sk_max_ack_backlog = backlog;
 	sk->sk_ack_backlog = 0;
 	sk->sk_state = SMC_LISTEN;
-	sock_hold(sk); /* sock_hold in tcp_listen_worker */
-	if (!schedule_work(&smc->tcp_listen_work))
-		sock_put(sk);
 
 out:
 	release_sock(sk);
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 6f1c42da7a4c..f38144f83f54 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -201,6 +201,8 @@ struct smc_connection {
 struct smc_sock {				/* smc sock container */
 	struct sock		sk;
 	struct socket		*clcsock;	/* internal tcp socket */
+	void			(*clcsk_data_ready)(struct sock *sk);
+						/* original data_ready fct. **/
 	struct smc_connection	conn;		/* smc connection */
 	struct smc_sock		*listen_smc;	/* listen parent */
 	struct work_struct	connect_work;	/* handle non-blocking connect*/
diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
index 0e7409e469c0..10d05a6d34fc 100644
--- a/net/smc/smc_close.c
+++ b/net/smc/smc_close.c
@@ -208,12 +208,11 @@ int smc_close_active(struct smc_sock *smc)
 		break;
 	case SMC_LISTEN:
 		sk->sk_state = SMC_CLOSED;
+		smc->clcsock->sk->sk_data_ready = smc->clcsk_data_ready;
+		smc->clcsock->sk->sk_user_data = NULL;
 		sk->sk_state_change(sk); /* wake up accept */
-		if (smc->clcsock && smc->clcsock->sk) {
+		if (smc->clcsock && smc->clcsock->sk)
 			rc = kernel_sock_shutdown(smc->clcsock, SHUT_RDWR);
-			/* wake up kernel_accept of smc_tcp_listen_worker */
-			smc->clcsock->sk->sk_data_ready(smc->clcsock->sk);
-		}
 		smc_close_cleanup_listen(sk);
 		release_sock(sk);
 		flush_work(&smc->tcp_listen_work);
-- 
2.17.1
