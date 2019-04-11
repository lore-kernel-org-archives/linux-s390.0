Return-Path: <SRS0=wH8C=SN=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 1/5] net/smc: wait for pending work before clcsock release_sock
Date: Thu, 11 Apr 2019 11:17:30 +0200
In-Reply-To: <20190411091734.4263-1-ubraun@linux.ibm.com>
References: <20190411091734.4263-1-ubraun@linux.ibm.com>
Message-Id: <20190411091734.4263-2-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, kgraul@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>

When the clcsock is already released using sock_release() and a pending
smc_listen_work accesses the clcsock than that will fail. Solve this
by canceling and waiting for the work to complete first. Because the
work holds the sock_lock it must make sure that the lock is not hold
before the new helper smc_clcsock_release() is invoked. And before the
smc_listen_work starts working check if the parent listen socket is
still valid, otherwise stop the work early.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c    | 14 ++++++++------
 net/smc/smc_close.c | 25 +++++++++++++++++++++----
 net/smc/smc_close.h |  1 +
 3 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 77ef53596d18..9bdaed2f2e35 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -167,10 +167,9 @@ static int smc_release(struct socket *sock)
 
 	if (sk->sk_state == SMC_CLOSED) {
 		if (smc->clcsock) {
-			mutex_lock(&smc->clcsock_release_lock);
-			sock_release(smc->clcsock);
-			smc->clcsock = NULL;
-			mutex_unlock(&smc->clcsock_release_lock);
+			release_sock(sk);
+			smc_clcsock_release(smc);
+			lock_sock(sk);
 		}
 		if (!smc->use_fallback)
 			smc_conn_free(&smc->conn);
@@ -1037,13 +1036,13 @@ static void smc_listen_out(struct smc_sock *new_smc)
 	struct smc_sock *lsmc = new_smc->listen_smc;
 	struct sock *newsmcsk = &new_smc->sk;
 
-	lock_sock_nested(&lsmc->sk, SINGLE_DEPTH_NESTING);
 	if (lsmc->sk.sk_state == SMC_LISTEN) {
+		lock_sock_nested(&lsmc->sk, SINGLE_DEPTH_NESTING);
 		smc_accept_enqueue(&lsmc->sk, newsmcsk);
+		release_sock(&lsmc->sk);
 	} else { /* no longer listening */
 		smc_close_non_accepted(newsmcsk);
 	}
-	release_sock(&lsmc->sk);
 
 	/* Wake up accept */
 	lsmc->sk.sk_data_ready(&lsmc->sk);
@@ -1237,6 +1236,9 @@ static void smc_listen_work(struct work_struct *work)
 	int rc = 0;
 	u8 ibport;
 
+	if (new_smc->listen_smc->sk.sk_state != SMC_LISTEN)
+		return smc_listen_out_err(new_smc);
+
 	if (new_smc->use_fallback) {
 		smc_listen_out_connected(new_smc);
 		return;
diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
index 2ad37e998509..fc06720b53c1 100644
--- a/net/smc/smc_close.c
+++ b/net/smc/smc_close.c
@@ -21,6 +21,22 @@
 
 #define SMC_CLOSE_WAIT_LISTEN_CLCSOCK_TIME	(5 * HZ)
 
+/* release the clcsock that is assigned to the smc_sock */
+void smc_clcsock_release(struct smc_sock *smc)
+{
+	struct socket *tcp;
+
+	if (smc->listen_smc && current_work() != &smc->smc_listen_work)
+		cancel_work_sync(&smc->smc_listen_work);
+	mutex_lock(&smc->clcsock_release_lock);
+	if (smc->clcsock) {
+		tcp = smc->clcsock;
+		smc->clcsock = NULL;
+		sock_release(tcp);
+	}
+	mutex_unlock(&smc->clcsock_release_lock);
+}
+
 static void smc_close_cleanup_listen(struct sock *parent)
 {
 	struct sock *sk;
@@ -321,6 +337,7 @@ static void smc_close_passive_work(struct work_struct *work)
 						   close_work);
 	struct smc_sock *smc = container_of(conn, struct smc_sock, conn);
 	struct smc_cdc_conn_state_flags *rxflags;
+	bool release_clcsock = false;
 	struct sock *sk = &smc->sk;
 	int old_state;
 
@@ -400,13 +417,13 @@ static void smc_close_passive_work(struct work_struct *work)
 		if ((sk->sk_state == SMC_CLOSED) &&
 		    (sock_flag(sk, SOCK_DEAD) || !sk->sk_socket)) {
 			smc_conn_free(conn);
-			if (smc->clcsock) {
-				sock_release(smc->clcsock);
-				smc->clcsock = NULL;
-			}
+			if (smc->clcsock)
+				release_clcsock = true;
 		}
 	}
 	release_sock(sk);
+	if (release_clcsock)
+		smc_clcsock_release(smc);
 	sock_put(sk); /* sock_hold done by schedulers of close_work */
 }
 
diff --git a/net/smc/smc_close.h b/net/smc/smc_close.h
index 19eb6a211c23..e0e3b5df25d2 100644
--- a/net/smc/smc_close.h
+++ b/net/smc/smc_close.h
@@ -23,5 +23,6 @@ void smc_close_wake_tx_prepared(struct smc_sock *smc);
 int smc_close_active(struct smc_sock *smc);
 int smc_close_shutdown_write(struct smc_sock *smc);
 void smc_close_init(struct smc_sock *smc);
+void smc_clcsock_release(struct smc_sock *smc);
 
 #endif /* SMC_CLOSE_H */
-- 
2.16.4
