From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 05/10] net/smc: always call the POLL_IN part of sk_wake_async
Date: Mon, 10 Apr 2017 14:58:00 +0200
Message-ID: <20170410125805.13653-6-ubraun@linux.vnet.ibm.com>
References: <20170410125805.13653-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170410125805.13653-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Wake up reading file descriptors for a closing socket as well, otherwise
some socket applications may stall.

Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 net/smc/smc_rx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index c4ef9a4..f0c8b08 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -36,11 +36,10 @@ static void smc_rx_data_ready(struct sock *sk)
 	if (skwq_has_sleeper(wq))
 		wake_up_interruptible_sync_poll(&wq->wait, POLLIN | POLLPRI |
 						POLLRDNORM | POLLRDBAND);
+	sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_IN);
 	if ((sk->sk_shutdown == SHUTDOWN_MASK) ||
 	    (sk->sk_state == SMC_CLOSED))
 		sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_HUP);
-	else
-		sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_IN);
 	rcu_read_unlock();
 }
 
-- 
2.10.2
