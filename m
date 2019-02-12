Return-Path: <SRS0=RTe9=QT=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 2/7] net/smc: move wake up of close waiter
Date: Tue, 12 Feb 2019 16:29:51 +0100
In-Reply-To: <20190212152956.71041-1-ubraun@linux.ibm.com>
References: <20190212152956.71041-1-ubraun@linux.ibm.com>
Message-Id: <20190212152956.71041-3-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>

Move the call to smc_close_wake_tx_prepared() (which wakes up a possibly
waiting close processing that might wait for 'all data sent') to
smc_tx_sndbuf_nonempty() (which is the main function to send data).

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_cdc.c | 2 --
 net/smc/smc_tx.c  | 7 +++++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index 99d9d6e85dfb..780b36c69292 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -290,8 +290,6 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
 	/* trigger sndbuf consumer: RDMA write into peer RMBE and CDC */
 	if (diff_cons && smc_tx_prepared_sends(conn)) {
 		smc_tx_sndbuf_nonempty(conn);
-		/* trigger socket release if connection closed */
-		smc_close_wake_tx_prepared(smc);
 	}
 	if (diff_cons && conn->urg_tx_pend &&
 	    atomic_read(&conn->peer_rmbe_space) == conn->peer_rmbe_size) {
diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index ce9586bce364..dd10a913b38e 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -24,6 +24,7 @@
 #include "smc.h"
 #include "smc_wr.h"
 #include "smc_cdc.h"
+#include "smc_close.h"
 #include "smc_ism.h"
 #include "smc_tx.h"
 
@@ -554,6 +555,12 @@ int smc_tx_sndbuf_nonempty(struct smc_connection *conn)
 	else
 		rc = smcr_tx_sndbuf_nonempty(conn);
 
+	if (!rc) {
+		/* trigger socket release if connection is closing */
+		struct smc_sock *smc = container_of(conn, struct smc_sock,
+						    conn);
+		smc_close_wake_tx_prepared(smc);
+	}
 	return rc;
 }
 
-- 
2.16.4
