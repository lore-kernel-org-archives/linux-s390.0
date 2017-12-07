From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 3/6] smc: no update for unused sk_write_pending
Date: Thu,  7 Dec 2017 13:38:46 +0100
Message-ID: <20171207123849.52910-4-ubraun@linux.vnet.ibm.com>
References: <20171207123849.52910-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171207123849.52910-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

The smc code never checks the sk_write_pending sock field.
Thus there is no need to update it.

Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 net/smc/smc_tx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index c48dc2d5fd3a..77555c6ed199 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -104,14 +104,12 @@ static int smc_tx_wait_memory(struct smc_sock *smc, int flags)
 		if (atomic_read(&conn->sndbuf_space))
 			break; /* at least 1 byte of free space available */
 		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
-		sk->sk_write_pending++;
 		sk_wait_event(sk, &timeo,
 			      sk->sk_err ||
 			      (sk->sk_shutdown & SEND_SHUTDOWN) ||
 			      smc_cdc_rxed_any_close_or_senddone(conn) ||
 			      atomic_read(&conn->sndbuf_space),
 			      &wait);
-		sk->sk_write_pending--;
 	}
 	remove_wait_queue(sk_sleep(sk), &wait);
 	return rc;
-- 
2.13.5
