From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 01/10] net/smc: cleanup tcp_listen_worker initialization
Date: Thu, 22 Nov 2018 10:26:34 +0100
Message-ID: <20181122092643.26820-2-ubraun@linux.ibm.com>
References: <20181122092643.26820-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181122092643.26820-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

The tcp_listen_worker is already initialized when socket is
created (in smc_sock_alloc()). Get rid of the duplicate
initialization in smc_listen(). No functional change.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 80e2119f1c70..d9b1a0e4446c 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1354,7 +1354,6 @@ static int smc_listen(struct socket *sock, int backlog)
 	sk->sk_max_ack_backlog = backlog;
 	sk->sk_ack_backlog = 0;
 	sk->sk_state = SMC_LISTEN;
-	INIT_WORK(&smc->tcp_listen_work, smc_tcp_listen_work);
 	sock_hold(sk); /* sock_hold in tcp_listen_worker */
 	if (!schedule_work(&smc->tcp_listen_work))
 		sock_put(sk);
-- 
2.16.4
