From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net V2 1/1] net/smc: coordinate wait queues for nonblocking connect
Date: Thu, 21 Jun 2018 16:23:18 +0200
Message-ID: <20180621142318.72681-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com, xiyou.wangcong@gmail.com, hch@lst.de
List-ID: <linux-s390.vger.kernel.org>

The recent poll change may lead to stalls for non-blocking connecting
SMC sockets, since sock_poll_wait is no longer performed on the
internal CLC socket, but on the outer SMC socket.  kernel_connect() on
the internal CLC socket returns with -EINPROGRESS, but the wake up
logic does not work in all cases. If the internal CLC socket is still
in state TCP_SYN_SENT when polled, sock_poll_wait() from sock_poll()
does not sleep. It is supposed to sleep till the state of the internal
CLC socket switches to TCP_ESTABLISHED.

This patch temporarily propagates the wait queue from the internal
CLC sock to the SMC sock, till the non-blocking connect() is
finished.

In addition locking is reduced due to the removed poll waits.

Fixes: c0129a061442 ("smc: convert to ->poll_mask")
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c | 15 +++++++++++----
 net/smc/smc.h    |  1 +
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index da7f02edcd37..d76331aae6e1 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -23,6 +23,7 @@
 #include <linux/workqueue.h>
 #include <linux/in.h>
 #include <linux/sched/signal.h>
+#include <linux/rcupdate.h>
 
 #include <net/sock.h>
 #include <net/tcp.h>
@@ -605,6 +606,13 @@ static int smc_connect(struct socket *sock, struct sockaddr *addr,
 
 	smc_copy_sock_settings_to_clc(smc);
 	tcp_sk(smc->clcsock->sk)->syn_smc = 1;
+	if (flags & O_NONBLOCK) {
+		rcu_read_lock();
+		smc->smcwq = rcu_dereference(sk->sk_wq);
+		rcu_assign_pointer(sock->sk->sk_wq,
+				   rcu_dereference(smc->clcsock->sk->sk_wq));
+		rcu_read_unlock();
+	}
 	rc = kernel_connect(smc->clcsock, addr, alen, flags);
 	if (rc)
 		goto out;
@@ -1285,12 +1293,9 @@ static __poll_t smc_poll_mask(struct socket *sock, __poll_t events)
 
 	smc = smc_sk(sock->sk);
 	sock_hold(sk);
-	lock_sock(sk);
 	if ((sk->sk_state == SMC_INIT) || smc->use_fallback) {
 		/* delegate to CLC child sock */
-		release_sock(sk);
 		mask = smc->clcsock->ops->poll_mask(smc->clcsock, events);
-		lock_sock(sk);
 		sk->sk_err = smc->clcsock->sk->sk_err;
 		if (sk->sk_err) {
 			mask |= EPOLLERR;
@@ -1299,7 +1304,10 @@ static __poll_t smc_poll_mask(struct socket *sock, __poll_t events)
 			if (sk->sk_state == SMC_INIT &&
 			    mask & EPOLLOUT &&
 			    smc->clcsock->sk->sk_state != TCP_CLOSE) {
+				lock_sock(sk);
+				rcu_assign_pointer(sock->sk->sk_wq, smc->smcwq);
 				rc = __smc_connect(smc);
+				release_sock(sk);
 				if (rc < 0)
 					mask |= EPOLLERR;
 				/* success cases including fallback */
@@ -1334,7 +1342,6 @@ static __poll_t smc_poll_mask(struct socket *sock, __poll_t events)
 			mask |= EPOLLPRI;
 
 	}
-	release_sock(sk);
 	sock_put(sk);
 
 	return mask;
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 51ae1f10d81a..89d6d7ef973f 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -190,6 +190,7 @@ struct smc_connection {
 struct smc_sock {				/* smc sock container */
 	struct sock		sk;
 	struct socket		*clcsock;	/* internal tcp socket */
+	struct socket_wq	*smcwq;		/* original smcsock wq */
 	struct smc_connection	conn;		/* smc connection */
 	struct smc_sock		*listen_smc;	/* listen parent */
 	struct work_struct	tcp_listen_work;/* handle tcp socket accepts */
-- 
2.16.4
