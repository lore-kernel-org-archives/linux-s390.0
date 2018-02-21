Return-Path: <netdev-owner@vger.kernel.org>
From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 2/5] net/smc: fix structure size
Date: Wed, 21 Feb 2018 12:32:32 +0100
In-Reply-To: <20180221113235.46702-1-ubraun@linux.vnet.ibm.com>
References: <20180221113235.46702-1-ubraun@linux.vnet.ibm.com>
Message-Id: <20180221113235.46702-3-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.vnet.ibm.com>

The struct smc_cdc_msg must be defined as packed, so the size is 44 bytes.
And change the structure size check, so sizeof is checked.

Signed-off-by: Karsten Graul <kgraul@linux.vnet.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 net/smc/smc_cdc.c | 2 +-
 net/smc/smc_cdc.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index 3cd086e5bd28..9b28e64c50d4 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -82,7 +82,7 @@ static inline void smc_cdc_add_pending_send(struct smc_connection *conn,
 		sizeof(struct smc_cdc_msg) > SMC_WR_BUF_SIZE,
 		"must increase SMC_WR_BUF_SIZE to at least sizeof(struct smc_cdc_msg)");
 	BUILD_BUG_ON_MSG(
-		offsetof(struct smc_cdc_msg, reserved) > SMC_WR_TX_SIZE,
+		sizeof(struct smc_cdc_msg) != SMC_WR_TX_SIZE,
 		"must adapt SMC_WR_TX_SIZE to sizeof(struct smc_cdc_msg); if not all smc_wr upper layer protocols use the same message size any more, must start to set link->wr_tx_sges[i].length on each individual smc_wr_tx_send()");
 	BUILD_BUG_ON_MSG(
 		sizeof(struct smc_cdc_tx_pend) > SMC_WR_TX_PEND_PRIV_SIZE,
diff --git a/net/smc/smc_cdc.h b/net/smc/smc_cdc.h
index ab240b37ad11..d2012fd22100 100644
--- a/net/smc/smc_cdc.h
+++ b/net/smc/smc_cdc.h
@@ -48,7 +48,7 @@ struct smc_cdc_msg {
 	struct smc_cdc_producer_flags	prod_flags;
 	struct smc_cdc_conn_state_flags	conn_state_flags;
 	u8				reserved[18];
-} __aligned(8);
+} __packed;					/* format defined in RFC7609 */
 
 static inline bool smc_cdc_rxed_any_close(struct smc_connection *conn)
 {
-- 
2.13.5
