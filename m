From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 4/9] net/smc: calculate write offset in RMB only once per connection
Date: Fri, 18 May 2018 09:34:13 +0200
Message-ID: <20180518073418.91878-5-ubraun@linux.ibm.com>
References: <20180518073418.91878-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180518073418.91878-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Hans Wippel <hwippel@linux.ibm.com>

Currently, the write offset within the RMB is calculated on each write
operation although it is fixed for each connection. With this patch, the
offset is calculated once and stored in a connection specific variable.

Signed-off-by: Hans Wippel <hwippel@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c | 5 ++++-
 net/smc/smc.h    | 1 +
 net/smc/smc_tx.c | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index bd67430f3730..9871604ebb53 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -377,10 +377,13 @@ static int smc_clnt_conf_first_link(struct smc_sock *smc)
 static void smc_conn_save_peer_info(struct smc_sock *smc,
 				    struct smc_clc_msg_accept_confirm *clc)
 {
+	int bufsize = smc_uncompress_bufsize(clc->rmbe_size);
+
 	smc->conn.peer_rmbe_idx = clc->rmbe_idx;
 	smc->conn.local_tx_ctrl.token = ntohl(clc->rmbe_alert_token);
-	smc->conn.peer_rmbe_size = smc_uncompress_bufsize(clc->rmbe_size);
+	smc->conn.peer_rmbe_size = bufsize;
 	atomic_set(&smc->conn.peer_rmbe_space, smc->conn.peer_rmbe_size);
+	smc->conn.tx_off = bufsize * (smc->conn.peer_rmbe_idx - 1);
 }
 
 static void smc_link_save_peer_info(struct smc_link *link,
diff --git a/net/smc/smc.h b/net/smc/smc.h
index fb8dec8bc17f..9bc37645e7d5 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -151,6 +151,7 @@ struct smc_connection {
 	u16			tx_cdc_seq;	/* sequence # for CDC send */
 	spinlock_t		send_lock;	/* protect wr_sends */
 	struct delayed_work	tx_work;	/* retry of smc_cdc_msg_send */
+	u32			tx_off;		/* base offset in peer rmb */
 
 	struct smc_host_cdc_msg	local_rx_ctrl;	/* filled during event_handl.
 						 * .prod cf. TCP rcv_nxt
diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index 58a56c992b26..1f4a38b857f0 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -261,7 +261,7 @@ static int smc_tx_rdma_write(struct smc_connection *conn, int peer_rmbe_offset,
 	rdma_wr.remote_addr =
 		lgr->rtokens[conn->rtoken_idx][SMC_SINGLE_LINK].dma_addr +
 		/* RMBE within RMB */
-		((conn->peer_rmbe_idx - 1) * conn->peer_rmbe_size) +
+		conn->tx_off +
 		/* offset within RMBE */
 		peer_rmbe_offset;
 	rdma_wr.rkey = lgr->rtokens[conn->rtoken_idx][SMC_SINGLE_LINK].rkey;
-- 
2.16.3
