Return-Path: <SRS0=K4f4=Q4=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 1/6] net/smc: cleanup for smcr_tx_sndbuf_nonempty
Date: Thu, 21 Feb 2019 13:00:58 +0100
In-Reply-To: <20190221120103.10866-1-ubraun@linux.ibm.com>
References: <20190221120103.10866-1-ubraun@linux.ibm.com>
Message-Id: <20190221120103.10866-2-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, kgraul@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Use local variable pflags from the beginning of function
smcr_tx_sndbuf_nonempty

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_tx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index a3bff08ff8c8..f0de323d15d6 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -483,7 +483,7 @@ static int smc_tx_rdma_writes(struct smc_connection *conn,
  */
 static int smcr_tx_sndbuf_nonempty(struct smc_connection *conn)
 {
-	struct smc_cdc_producer_flags *pflags;
+	struct smc_cdc_producer_flags *pflags = &conn->local_tx_ctrl.prod_flags;
 	struct smc_rdma_wr *wr_rdma_buf;
 	struct smc_cdc_tx_pend *pend;
 	struct smc_wr_buf *wr_buf;
@@ -506,7 +506,7 @@ static int smcr_tx_sndbuf_nonempty(struct smc_connection *conn)
 	}
 
 	spin_lock_bh(&conn->send_lock);
-	if (!conn->local_tx_ctrl.prod_flags.urg_data_present) {
+	if (!pflags->urg_data_present) {
 		rc = smc_tx_rdma_writes(conn, wr_rdma_buf);
 		if (rc) {
 			smc_wr_tx_put_slot(&conn->lgr->lnk[SMC_SINGLE_LINK],
@@ -516,7 +516,6 @@ static int smcr_tx_sndbuf_nonempty(struct smc_connection *conn)
 	}
 
 	rc = smc_cdc_msg_send(conn, wr_buf, pend);
-	pflags = &conn->local_tx_ctrl.prod_flags;
 	if (!rc && pflags->urg_data_present) {
 		pflags->urg_data_pending = 0;
 		pflags->urg_data_present = 0;
-- 
2.16.4
