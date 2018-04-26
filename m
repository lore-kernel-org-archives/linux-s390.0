From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next v3 2/4] net/smc: handle sockopts forcing fallback
Date: Thu, 26 Apr 2018 17:18:21 +0200
Message-ID: <20180426151823.78967-3-ubraun@linux.ibm.com>
References: <20180426151823.78967-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180426151823.78967-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.ibm.com>

Several TCP sockopts do not work for SMC. One example are the
TCP_FASTOPEN sockopts, since SMC-connection setup is based on the TCP
three-way-handshake.
If the SMC socket is still in state SMC_INIT, such sockopts trigger
fallback to TCP. Otherwise an error is returned.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 4470501374bf..d274be7265ea 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -391,6 +391,9 @@ static int smc_connect_rdma(struct smc_sock *smc)
 
 	sock_hold(&smc->sk); /* sock put in passive closing */
 
+	if (smc->use_fallback)
+		goto out_connected;
+
 	if (!tcp_sk(smc->clcsock->sk)->syn_smc) {
 		/* peer has not signalled SMC-capability */
 		smc->use_fallback = true;
@@ -790,6 +793,9 @@ static void smc_listen_work(struct work_struct *work)
 	int rc = 0;
 	u8 ibport;
 
+	if (new_smc->use_fallback)
+		goto out_connected;
+
 	/* check if peer is smc capable */
 	if (!tcp_sk(newclcsock->sk)->syn_smc) {
 		new_smc->use_fallback = true;
@@ -968,7 +974,7 @@ static void smc_tcp_listen_work(struct work_struct *work)
 			continue;
 
 		new_smc->listen_smc = lsmc;
-		new_smc->use_fallback = false; /* assume rdma capability first*/
+		new_smc->use_fallback = lsmc->use_fallback;
 		sock_hold(lsk); /* sock_put in smc_listen_work */
 		INIT_WORK(&new_smc->smc_listen_work, smc_listen_work);
 		smc_copy_sock_settings_to_smc(new_smc);
@@ -1004,7 +1010,8 @@ static int smc_listen(struct socket *sock, int backlog)
 	 * them to the clc socket -- copy smc socket options to clc socket
 	 */
 	smc_copy_sock_settings_to_clc(smc);
-	tcp_sk(smc->clcsock->sk)->syn_smc = 1;
+	if (!smc->use_fallback)
+		tcp_sk(smc->clcsock->sk)->syn_smc = 1;
 
 	rc = kernel_listen(smc->clcsock, backlog);
 	if (rc)
@@ -1097,6 +1104,16 @@ static int smc_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	    (sk->sk_state != SMC_APPCLOSEWAIT1) &&
 	    (sk->sk_state != SMC_INIT))
 		goto out;
+
+	if (msg->msg_flags & MSG_FASTOPEN) {
+		if (sk->sk_state == SMC_INIT) {
+			smc->use_fallback = true;
+		} else {
+			rc = -EINVAL;
+			goto out;
+		}
+	}
+
 	if (smc->use_fallback)
 		rc = smc->clcsock->ops->sendmsg(smc->clcsock, msg, len);
 	else
@@ -1274,14 +1291,43 @@ static int smc_setsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 	struct smc_sock *smc;
+	int rc;
 
 	smc = smc_sk(sk);
 
 	/* generic setsockopts reaching us here always apply to the
 	 * CLC socket
 	 */
-	return smc->clcsock->ops->setsockopt(smc->clcsock, level, optname,
-					     optval, optlen);
+	rc = smc->clcsock->ops->setsockopt(smc->clcsock, level, optname,
+					   optval, optlen);
+	if (smc->clcsock->sk->sk_err) {
+		sk->sk_err = smc->clcsock->sk->sk_err;
+		sk->sk_error_report(sk);
+	}
+	if (rc)
+		return rc;
+
+	lock_sock(sk);
+	switch (optname) {
+	case TCP_ULP:
+	case TCP_FASTOPEN:
+	case TCP_FASTOPEN_CONNECT:
+	case TCP_FASTOPEN_KEY:
+	case TCP_FASTOPEN_NO_COOKIE:
+		/* option not supported by SMC */
+		if (sk->sk_state == SMC_INIT) {
+			smc->use_fallback = true;
+		} else {
+			if (!smc->use_fallback)
+				rc = -EINVAL;
+		}
+		break;
+	default:
+		break;
+	}
+	release_sock(sk);
+
+	return rc;
 }
 
 static int smc_getsockopt(struct socket *sock, int level, int optname,
-- 
2.13.5
