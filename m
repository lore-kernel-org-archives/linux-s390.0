Return-Path: <netdev-owner@vger.kernel.org>
From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net 1/1] net/smc: wakeup closing listen socket
Date: Wed,  7 Mar 2018 13:59:31 +0100
In-Reply-To: <20180307125931.42248-1-ubraun@linux.vnet.ibm.com>
References: <20180307125931.42248-1-ubraun@linux.vnet.ibm.com>
Message-Id: <20180307125931.42248-2-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Closing of a listen socket wakes up kernel_accept() of
smc_tcp_listen_worker(), and then has to wait till smc_tcp_listen_worker()
gives up the internal clcsock. This wait is non-interruptible, and does
not fit to the interruptible wakeup in smc_tcp_listen_worker().
Thus wakeup fails, and waiting for the closed internal clcsock never ends
before the wait timeout is reached.
This patch introduces the matching non-interruptible wakeup.

Fixes: 127f49705823 ("net/smc: release clcsock from tcp_listen_worker")
Reported-by: Hans Wippel <hwippel@linux.vnet.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 net/smc/af_smc.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 8cc97834d4f6..ad4c43eb7e7f 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -946,6 +946,20 @@ static void smc_listen_work(struct work_struct *work)
 	goto enqueue; /* queue new sock with sk_err set */
 }
 
+/* a non-interruptible variant of sock_def_wakeup() for wakeup of
+ * smc_close_wait_listen_clcsock()
+ */
+static void smc_sock_wakeup(struct sock *sk)
+{
+	struct socket_wq *wq;
+
+	rcu_read_lock();
+	wq = rcu_dereference(sk->sk_wq);
+	if (skwq_has_sleeper(wq))
+		wake_up_all(&wq->wait);
+	rcu_read_unlock();
+}
+
 static void smc_tcp_listen_work(struct work_struct *work)
 {
 	struct smc_sock *lsmc = container_of(work, struct smc_sock,
@@ -981,7 +995,7 @@ static void smc_tcp_listen_work(struct work_struct *work)
 	/* no more listening, wake up smc_close_wait_listen_clcsock and
 	 * accept
 	 */
-	lsk->sk_state_change(lsk);
+	smc_sock_wakeup(lsk);
 	sock_put(&lsmc->sk); /* sock_hold in smc_listen */
 }
 
-- 
2.13.5
