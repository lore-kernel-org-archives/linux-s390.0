From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 1/1] net/smc: rebuild nonblocking connect
Date: Wed, 27 Jun 2018 17:59:50 +0200
Message-ID: <20180627155950.21153-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com, xiyou.wangcong@gmail.com, eric.dumazet@gmail.com
List-ID: <linux-s390.vger.kernel.org>

The recent poll change may lead to stalls for non-blocking connecting
SMC sockets, since sock_poll_wait is no longer performed on the
internal CLC socket, but on the outer SMC socket.  kernel_connect() on
the internal CLC socket returns with -EINPROGRESS, but the wake up
logic does not work in all cases. If the internal CLC socket is still
in state TCP_SYN_SENT when polled, sock_poll_wait() from sock_poll()
does not sleep. It is supposed to sleep till the state of the internal
CLC socket switches to TCP_ESTABLISHED.

This problem triggered a redesign of the SMC nonblocking connect logic.
This patch introduces a connect worker covering all connect steps
followed by a wake up of socket waiters. It allows to get rid of all
delays and locks in smc_poll().

Fixes: c0129a061442 ("smc: convert to ->poll_mask")
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c | 91 +++++++++++++++++++++++++++++++++++++++-----------------
 net/smc/smc.h    |  8 +++++
 2 files changed, 71 insertions(+), 28 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index da7f02edcd37..4d1d4ddb2f49 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -45,6 +45,7 @@ static DEFINE_MUTEX(smc_create_lgr_pending);	/* serialize link group
 						 */
 
 static void smc_tcp_listen_work(struct work_struct *);
+static void smc_connect_work(struct work_struct *);
 
 static void smc_set_keepalive(struct sock *sk, int val)
 {
@@ -122,6 +123,12 @@ static int smc_release(struct socket *sock)
 		goto out;
 
 	smc = smc_sk(sk);
+
+	/* cleanup for a dangling non-blocking connect */
+	flush_work(&smc->connect_work);
+	kfree(smc->connect_info);
+	smc->connect_info = NULL;
+
 	if (sk->sk_state == SMC_LISTEN)
 		/* smc_close_non_accepted() is called and acquires
 		 * sock lock for child sockets again
@@ -186,6 +193,7 @@ static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
 	sk->sk_protocol = protocol;
 	smc = smc_sk(sk);
 	INIT_WORK(&smc->tcp_listen_work, smc_tcp_listen_work);
+	INIT_WORK(&smc->connect_work, smc_connect_work);
 	INIT_DELAYED_WORK(&smc->conn.tx_work, smc_tx_work);
 	INIT_LIST_HEAD(&smc->accept_q);
 	spin_lock_init(&smc->accept_q_lock);
@@ -576,6 +584,35 @@ static int __smc_connect(struct smc_sock *smc)
 	return 0;
 }
 
+static void smc_connect_work(struct work_struct *work)
+{
+	struct smc_sock *smc = container_of(work, struct smc_sock,
+					    connect_work);
+	int rc;
+
+	lock_sock(&smc->sk);
+	rc = kernel_connect(smc->clcsock, &smc->connect_info->addr,
+			    smc->connect_info->alen, smc->connect_info->flags);
+	if (smc->clcsock->sk->sk_err) {
+		smc->sk.sk_err = smc->clcsock->sk->sk_err;
+		goto out;
+	}
+	if (rc < 0) {
+		smc->sk.sk_err = -rc;
+		goto out;
+	}
+
+	rc = __smc_connect(smc);
+	if (rc < 0)
+		smc->sk.sk_err = -rc;
+
+out:
+	smc->sk.sk_state_change(&smc->sk);
+	kfree(smc->connect_info);
+	smc->connect_info = NULL;
+	release_sock(&smc->sk);
+}
+
 static int smc_connect(struct socket *sock, struct sockaddr *addr,
 		       int alen, int flags)
 {
@@ -605,15 +642,32 @@ static int smc_connect(struct socket *sock, struct sockaddr *addr,
 
 	smc_copy_sock_settings_to_clc(smc);
 	tcp_sk(smc->clcsock->sk)->syn_smc = 1;
-	rc = kernel_connect(smc->clcsock, addr, alen, flags);
-	if (rc)
-		goto out;
+	if (flags & O_NONBLOCK) {
+		if (smc->connect_info) {
+			rc = -EALREADY;
+			goto out;
+		}
+		smc->connect_info = kzalloc(alen + 2 * sizeof(int), GFP_KERNEL);
+		if (!smc->connect_info) {
+			rc = -ENOMEM;
+			goto out;
+		}
+		smc->connect_info->alen = alen;
+		smc->connect_info->flags = flags ^ O_NONBLOCK;
+		memcpy(&smc->connect_info->addr, addr, alen);
+		schedule_work(&smc->connect_work);
+		rc = -EINPROGRESS;
+	} else {
+		rc = kernel_connect(smc->clcsock, addr, alen, flags);
+		if (rc)
+			goto out;
 
-	rc = __smc_connect(smc);
-	if (rc < 0)
-		goto out;
-	else
-		rc = 0; /* success cases including fallback */
+		rc = __smc_connect(smc);
+		if (rc < 0)
+			goto out;
+		else
+			rc = 0; /* success cases including fallback */
+	}
 
 out:
 	release_sock(sk);
@@ -1278,34 +1332,17 @@ static __poll_t smc_poll_mask(struct socket *sock, __poll_t events)
 	struct sock *sk = sock->sk;
 	__poll_t mask = 0;
 	struct smc_sock *smc;
-	int rc;
 
 	if (!sk)
 		return EPOLLNVAL;
 
 	smc = smc_sk(sock->sk);
-	sock_hold(sk);
-	lock_sock(sk);
 	if ((sk->sk_state == SMC_INIT) || smc->use_fallback) {
 		/* delegate to CLC child sock */
-		release_sock(sk);
 		mask = smc->clcsock->ops->poll_mask(smc->clcsock, events);
-		lock_sock(sk);
 		sk->sk_err = smc->clcsock->sk->sk_err;
-		if (sk->sk_err) {
+		if (sk->sk_err)
 			mask |= EPOLLERR;
-		} else {
-			/* if non-blocking connect finished ... */
-			if (sk->sk_state == SMC_INIT &&
-			    mask & EPOLLOUT &&
-			    smc->clcsock->sk->sk_state != TCP_CLOSE) {
-				rc = __smc_connect(smc);
-				if (rc < 0)
-					mask |= EPOLLERR;
-				/* success cases including fallback */
-				mask |= EPOLLOUT | EPOLLWRNORM;
-			}
-		}
 	} else {
 		if (sk->sk_err)
 			mask |= EPOLLERR;
@@ -1334,8 +1371,6 @@ static __poll_t smc_poll_mask(struct socket *sock, __poll_t events)
 			mask |= EPOLLPRI;
 
 	}
-	release_sock(sk);
-	sock_put(sk);
 
 	return mask;
 }
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 51ae1f10d81a..d7ca26570482 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -187,11 +187,19 @@ struct smc_connection {
 	struct work_struct	close_work;	/* peer sent some closing */
 };
 
+struct smc_connect_info {
+	int			flags;
+	int			alen;
+	struct sockaddr		addr;
+};
+
 struct smc_sock {				/* smc sock container */
 	struct sock		sk;
 	struct socket		*clcsock;	/* internal tcp socket */
 	struct smc_connection	conn;		/* smc connection */
 	struct smc_sock		*listen_smc;	/* listen parent */
+	struct smc_connect_info *connect_info;	/* connect address & flags */
+	struct work_struct	connect_work;	/* handle non-blocking connect*/
 	struct work_struct	tcp_listen_work;/* handle tcp socket accepts */
 	struct work_struct	smc_listen_work;/* prepare new accept socket */
 	struct list_head	accept_q;	/* sockets to be accepted */
-- 
2.16.4
