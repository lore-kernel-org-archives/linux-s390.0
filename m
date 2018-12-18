Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Tue, 18 Dec 2018 09:02:25 -0800
From: Myungho Jung <mhjungk@gmail.com>
Subject: [PATCH v3] net/smc: fix TCP fallback socket release
Message-ID: <20181218170221.GA21835@myunghoj-Precision-5530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ursula Braun <ubraun@linux.ibm.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

clcsock can be released while kernel_accept() references it in TCP
listen worker. Also, clcsock needs to wake up before released if TCP
fallback is used and the clcsock is blocked by accept. Add a lock to
safely release clcsock and call kernel_sock_shutdown() to wake up
clcsock from accept in smc_release().

Reported-by: syzbot+0bf2e01269f1274b4b03@syzkaller.appspotmail.com
Reported-by: syzbot+e3132895630f957306bc@syzkaller.appspotmail.com
Signed-off-by: Myungho Jung <mhjungk@gmail.com>
---
 net/smc/af_smc.c | 14 ++++++++++++--
 net/smc/smc.h    |  4 ++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 5fbaf1901571..82cb0e5634bc 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -147,8 +147,14 @@ static int smc_release(struct socket *sock)
 		sk->sk_shutdown |= SHUTDOWN_MASK;
 	}
 	if (smc->clcsock) {
+		if (smc->use_fallback && sk->sk_state == SMC_LISTEN) {
+			/* wake up clcsock accept */
+			rc = kernel_sock_shutdown(smc->clcsock, SHUT_RDWR);
+		}
+		mutex_lock(&smc->clcsock_release_lock);
 		sock_release(smc->clcsock);
 		smc->clcsock = NULL;
+		mutex_unlock(&smc->clcsock_release_lock);
 	}
 	if (smc->use_fallback) {
 		if (sk->sk_state != SMC_LISTEN && sk->sk_state != SMC_INIT)
@@ -205,6 +211,7 @@ static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
 	spin_lock_init(&smc->conn.send_lock);
 	sk->sk_prot->hash(sk);
 	sk_refcnt_debug_inc(sk);
+	mutex_init(&smc->clcsock_release_lock);
 
 	return sk;
 }
@@ -821,7 +828,7 @@ static int smc_clcsock_accept(struct smc_sock *lsmc, struct smc_sock **new_smc)
 	struct socket *new_clcsock = NULL;
 	struct sock *lsk = &lsmc->sk;
 	struct sock *new_sk;
-	int rc;
+	int rc = -EINVAL;
 
 	release_sock(lsk);
 	new_sk = smc_sock_alloc(sock_net(lsk), NULL, lsk->sk_protocol);
@@ -834,7 +841,10 @@ static int smc_clcsock_accept(struct smc_sock *lsmc, struct smc_sock **new_smc)
 	}
 	*new_smc = smc_sk(new_sk);
 
-	rc = kernel_accept(lsmc->clcsock, &new_clcsock, 0);
+	mutex_lock(&lsmc->clcsock_release_lock);
+	if (lsmc->clcsock)
+		rc = kernel_accept(lsmc->clcsock, &new_clcsock, 0);
+	mutex_unlock(&lsmc->clcsock_release_lock);
 	lock_sock(lsk);
 	if  (rc < 0)
 		lsk->sk_err = -rc;
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 08786ace6010..5721416d0605 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -219,6 +219,10 @@ struct smc_sock {				/* smc sock container */
 						 * started, waiting for unsent
 						 * data to be sent
 						 */
+	struct mutex            clcsock_release_lock;
+						/* protects clcsock of a listen
+						 * socket
+						 * */
 };
 
 static inline struct smc_sock *smc_sk(const struct sock *sk)
-- 
2.17.1
