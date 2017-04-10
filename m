From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 04/10] net/smc: guarantee reset of write_blocked for heavy workload
Date: Mon, 10 Apr 2017 14:57:59 +0200
Message-ID: <20170410125805.13653-5-ubraun@linux.vnet.ibm.com>
References: <20170410125805.13653-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170410125805.13653-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

If peer indicates write_blocked, the cursor state of the received data
should be send to the peer immediately (in smc_tx_consumer_update()).
Afterwards the write_blocked indicator is cleared.

If there is no free slot for another write request, sending is postponed
to worker smc_tx_work, and the write_blocked indicator is not cleared.
Therefore another clearing check is needed in smc_tx_work().

Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 net/smc/smc_tx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index 69a0013..21ec183 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -431,9 +431,13 @@ static void smc_tx_work(struct work_struct *work)
 						   struct smc_connection,
 						   tx_work);
 	struct smc_sock *smc = container_of(conn, struct smc_sock, conn);
+	int rc;
 
 	lock_sock(&smc->sk);
-	smc_tx_sndbuf_nonempty(conn);
+	rc = smc_tx_sndbuf_nonempty(conn);
+	if (!rc && conn->local_rx_ctrl.prod_flags.write_blocked &&
+	    !atomic_read(&conn->bytes_to_rcv))
+		conn->local_rx_ctrl.prod_flags.write_blocked = 0;
 	release_sock(&smc->sk);
 }
 
-- 
2.10.2
