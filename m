From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 2/4] net/smc: handle sockopt TCP_NODELAY
Date: Tue, 17 Apr 2018 17:18:13 +0200
Message-ID: <20180417151815.77191-3-ubraun@linux.ibm.com>
References: <20180417151815.77191-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180417151815.77191-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.vnet.ibm.com>

TCP sockopts must not interfere with the CLC handshake on the
CLC socket. Therefore, we defer some of them till the CLC
handshake has completed, like resetting TCP_NODELAY.

While touching setsockopt, the TCP_FASTOPEN sockopts are
ignored, since SMC-connection setup is based on the TCP
three-way-handshake.

Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 net/smc/af_smc.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 net/smc/smc.h    |   4 ++
 2 files changed, 111 insertions(+), 2 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 5f8046c62d90..96f4d182f998 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -377,6 +377,22 @@ static void smc_link_save_peer_info(struct smc_link *link,
 	link->peer_mtu = clc->qp_mtu;
 }
 
+/* deferred setsockopt's not desired during clc handshake */
+static void smc_apply_deferred_sockopts(struct smc_sock *smc)
+{
+	struct smc_sock *opt_smc = smc;
+	u8 val;
+
+	if (smc->listen_smc)
+		opt_smc = smc->listen_smc;
+	if (opt_smc->deferred_nodelay_reset) {
+		val = 0;
+		kernel_setsockopt(smc->clcsock, SOL_TCP, TCP_NODELAY, &val,
+				  sizeof(val));
+		opt_smc->deferred_nodelay_reset = 0;
+	}
+}
+
 /* setup for RDMA connection of client */
 static int smc_connect_rdma(struct smc_sock *smc)
 {
@@ -506,6 +522,7 @@ static int smc_connect_rdma(struct smc_sock *smc)
 	smc_tx_init(smc);
 
 out_connected:
+	smc_apply_deferred_sockopts(smc);
 	smc_copy_sock_settings_to_clc(smc);
 	if (smc->sk.sk_state == SMC_INIT)
 		smc->sk.sk_state = SMC_ACTIVE;
@@ -908,6 +925,7 @@ static void smc_listen_work(struct work_struct *work)
 	mutex_unlock(&smc_create_lgr_pending);
 
 out_connected:
+	smc_apply_deferred_sockopts(new_smc);
 	sk_refcnt_debug_inc(newsmcsk);
 	if (newsmcsk->sk_state == SMC_INIT)
 		newsmcsk->sk_state = SMC_ACTIVE;
@@ -1280,9 +1298,60 @@ static int smc_setsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 	struct smc_sock *smc;
+	int val;
 
 	smc = smc_sk(sk);
+	if (smc->use_fallback || level != SOL_TCP)
+		goto clcsock;
+
+	/* level SOL_TCP */
+	switch (optname) {
+	case TCP_CONGESTION:
+	case TCP_ULP:
+		/* sockopts without integer value; do not apply to SMC */
+		goto clcsock;
+	default:
+		break;
+	}
 
+	if (optlen < sizeof(int))
+		return -EINVAL;
+	if (get_user(val, (int __user *)optval))
+		return -EFAULT;
+
+	lock_sock(sk);
+	switch (optname) {
+	case TCP_NODELAY:
+		if (sk->sk_state != SMC_INIT && sk->sk_state != SMC_LISTEN) {
+			release_sock(sk);
+			goto clcsock;
+		}
+		/* for the CLC-handshake TCP_NODELAY is desired;
+		 * in case of fallback to TCP, a nodelay reset is
+		 * triggered afterwards.
+		 */
+		if (val)
+			smc->deferred_nodelay_reset = 0;
+		else
+			smc->deferred_nodelay_reset = 1;
+		break;
+	case TCP_FASTOPEN:
+	case TCP_FASTOPEN_CONNECT:
+	case TCP_FASTOPEN_KEY:
+	case TCP_FASTOPEN_NO_COOKIE:
+		/* ignore these options; 3-way handshake shouldn't be
+		 * bypassed with SMC
+		 */
+		break;
+	default:
+		/* apply option to the CLC socket */
+		release_sock(sk);
+		goto clcsock;
+	}
+	release_sock(sk);
+	return 0;
+
+clcsock:
 	/* generic setsockopts reaching us here always apply to the
 	 * CLC socket
 	 */
@@ -1293,10 +1362,41 @@ static int smc_setsockopt(struct socket *sock, int level, int optname,
 static int smc_getsockopt(struct socket *sock, int level, int optname,
 			  char __user *optval, int __user *optlen)
 {
+	struct sock *sk = sock->sk;
 	struct smc_sock *smc;
+	int val, len;
 
-	smc = smc_sk(sock->sk);
-	/* socket options apply to the CLC socket */
+	smc = smc_sk(sk);
+
+	if (smc->use_fallback || level != SOL_TCP)
+		goto clcsock;
+
+	if (get_user(len, optlen))
+		return -EFAULT;
+	len = min_t(unsigned int, len, sizeof(int));
+	if (len < 0)
+		return -EINVAL;
+
+	/* level SOL_TCP */
+	switch (optname) {
+	case TCP_NODELAY:
+		if (smc->deferred_nodelay_reset)
+			val = 0;
+		else
+			goto clcsock;
+		break;
+	default:
+		goto clcsock;
+	}
+
+	if (put_user(len, optlen))
+		return -EFAULT;
+	if (copy_to_user(optval, &val, len))
+		return -EFAULT;
+	return 0;
+
+clcsock:
+	/* socket options applying to the CLC socket */
 	return smc->clcsock->ops->getsockopt(smc->clcsock, level, optname,
 					     optval, optlen);
 }
@@ -1387,6 +1487,7 @@ static int smc_create(struct net *net, struct socket *sock, int protocol,
 	int family = (protocol == SMCPROTO_SMC6) ? PF_INET6 : PF_INET;
 	struct smc_sock *smc;
 	struct sock *sk;
+	u8 val = 1;
 	int rc;
 
 	rc = -ESOCKTNOSUPPORT;
@@ -1412,6 +1513,10 @@ static int smc_create(struct net *net, struct socket *sock, int protocol,
 		sk_common_release(sk);
 		goto out;
 	}
+	/* clc handshake should run with disabled Nagle algorithm */
+	kernel_setsockopt(smc->clcsock, SOL_TCP, TCP_NODELAY, &val,
+			  sizeof(val));
+	smc->deferred_nodelay_reset = 1; /* TCP_NODELAY is not the default */
 	smc->sk.sk_sndbuf = max(smc->clcsock->sk->sk_sndbuf, SMC_BUF_MIN_SIZE);
 	smc->sk.sk_rcvbuf = max(smc->clcsock->sk->sk_rcvbuf, SMC_BUF_MIN_SIZE);
 
diff --git a/net/smc/smc.h b/net/smc/smc.h
index e4829a2f46ba..6dfc1c90bed2 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -185,6 +185,10 @@ struct smc_sock {				/* smc sock container */
 						 * started, waiting for unsent
 						 * data to be sent
 						 */
+	u8			deferred_nodelay_reset : 1;
+						/* defer Nagle after CLC
+						 * handshake
+						 */
 };
 
 static inline struct smc_sock *smc_sk(const struct sock *sk)
-- 
2.13.5
