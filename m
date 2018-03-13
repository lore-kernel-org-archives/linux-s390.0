Return-Path: <netdev-owner@vger.kernel.org>
From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH V2 net 1/1] net/smc: simplify wait when closing listen socket
Date: Tue, 13 Mar 2018 10:41:54 +0100
In-Reply-To: <20180313094154.65533-1-ubraun@linux.vnet.ibm.com>
References: <20180313094154.65533-1-ubraun@linux.vnet.ibm.com>
Message-Id: <20180313094154.65533-2-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Closing of a listen socket wakes up kernel_accept() of
smc_tcp_listen_worker(), and then has to wait till smc_tcp_listen_worker()
gives up the internal clcsock. The wait logic introduced with
commit 127f49705823 ("net/smc: release clcsock from tcp_listen_worker")
might wait longer than necessary. This patch implements the idea to
implement the wait just with flush_work(), and gets rid of the extra
smc_close_wait_listen_clcsock() function.

Fixes: 127f49705823 ("net/smc: release clcsock from tcp_listen_worker")
Reported-by: Hans Wippel <hwippel@linux.vnet.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 net/smc/af_smc.c    |  4 ----
 net/smc/smc_close.c | 25 +++----------------------
 2 files changed, 3 insertions(+), 26 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 8cc97834d4f6..1e0d780855c3 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -978,10 +978,6 @@ static void smc_tcp_listen_work(struct work_struct *work)
 		lsmc->clcsock = NULL;
 	}
 	release_sock(lsk);
-	/* no more listening, wake up smc_close_wait_listen_clcsock and
-	 * accept
-	 */
-	lsk->sk_state_change(lsk);
 	sock_put(&lsmc->sk); /* sock_hold in smc_listen */
 }
 
diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
index e339c0186dcf..fa41d9881741 100644
--- a/net/smc/smc_close.c
+++ b/net/smc/smc_close.c
@@ -30,27 +30,6 @@ static void smc_close_cleanup_listen(struct sock *parent)
 		smc_close_non_accepted(sk);
 }
 
-static void smc_close_wait_listen_clcsock(struct smc_sock *smc)
-{
-	DEFINE_WAIT_FUNC(wait, woken_wake_function);
-	struct sock *sk = &smc->sk;
-	signed long timeout;
-
-	timeout = SMC_CLOSE_WAIT_LISTEN_CLCSOCK_TIME;
-	add_wait_queue(sk_sleep(sk), &wait);
-	do {
-		release_sock(sk);
-		if (smc->clcsock)
-			timeout = wait_woken(&wait, TASK_UNINTERRUPTIBLE,
-					     timeout);
-		sched_annotate_sleep();
-		lock_sock(sk);
-		if (!smc->clcsock)
-			break;
-	} while (timeout);
-	remove_wait_queue(sk_sleep(sk), &wait);
-}
-
 /* wait for sndbuf data being transmitted */
 static void smc_close_stream_wait(struct smc_sock *smc, long timeout)
 {
@@ -204,9 +183,11 @@ int smc_close_active(struct smc_sock *smc)
 			rc = kernel_sock_shutdown(smc->clcsock, SHUT_RDWR);
 			/* wake up kernel_accept of smc_tcp_listen_worker */
 			smc->clcsock->sk->sk_data_ready(smc->clcsock->sk);
-			smc_close_wait_listen_clcsock(smc);
 		}
 		smc_close_cleanup_listen(sk);
+		release_sock(sk);
+		flush_work(&smc->tcp_listen_work);
+		lock_sock(sk);
 		break;
 	case SMC_ACTIVE:
 		smc_close_stream_wait(smc, timeout);
-- 
2.13.5
