From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 1/6] smc: make smc_close_active_abort() static
Date: Thu,  7 Dec 2017 13:38:44 +0100
Message-ID: <20171207123849.52910-2-ubraun@linux.vnet.ibm.com>
References: <20171207123849.52910-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171207123849.52910-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

smc_close_active_abort() is used in smc_close.c only.
Make it static.

Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 net/smc/smc_close.c | 2 +-
 net/smc/smc_close.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
index 48615d2ac4aa..e194c6cc308a 100644
--- a/net/smc/smc_close.c
+++ b/net/smc/smc_close.c
@@ -113,7 +113,7 @@ static int smc_close_abort(struct smc_connection *conn)
 /* terminate smc socket abnormally - active abort
  * RDMA communication no longer possible
  */
-void smc_close_active_abort(struct smc_sock *smc)
+static void smc_close_active_abort(struct smc_sock *smc)
 {
 	struct smc_cdc_conn_state_flags *txflags =
 		&smc->conn.local_tx_ctrl.conn_state_flags;
diff --git a/net/smc/smc_close.h b/net/smc/smc_close.h
index ed82506b1b0a..8c498885d758 100644
--- a/net/smc/smc_close.h
+++ b/net/smc/smc_close.h
@@ -20,7 +20,6 @@
 #define SMC_CLOSE_SOCK_PUT_DELAY		HZ
 
 void smc_close_wake_tx_prepared(struct smc_sock *smc);
-void smc_close_active_abort(struct smc_sock *smc);
 int smc_close_active(struct smc_sock *smc);
 void smc_close_sock_put_work(struct work_struct *work);
 int smc_close_shutdown_write(struct smc_sock *smc);
-- 
2.13.5
