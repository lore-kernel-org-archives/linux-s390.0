From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 10/10] net/smc: do not use IB_SEND_INLINE together with mapped data
Date: Mon, 10 Apr 2017 14:58:05 +0200
Message-ID: <20170410125805.13653-11-ubraun@linux.vnet.ibm.com>
References: <20170410125805.13653-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170410125805.13653-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

smc specifies IB_SEND_INLINE for IB_WR_SEND ib_post_send calls, but
provides a mapped buffer to be sent. This is inconsistent, since
IB_SEND_INLINE works without mapped buffer. Problem has not been
detected in the past, because tests had been limited to Connect X3 cards
from Mellanox, whose mlx4 driver just ignored the IB_SEND_INLINE flag.
For now, the IB_SEND_INLINE flag is removed.

Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 net/smc/smc_ib.c | 1 -
 net/smc/smc_wr.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index b762577..16b7c80 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -257,7 +257,6 @@ int smc_ib_create_queue_pair(struct smc_link *lnk)
 			.max_recv_wr = SMC_WR_BUF_CNT * 3,
 			.max_send_sge = SMC_IB_MAX_SEND_SGE,
 			.max_recv_sge = 1,
-			.max_inline_data = SMC_WR_TX_SIZE,
 		},
 		.sq_sig_type = IB_SIGNAL_REQ_WR,
 		.qp_type = IB_QPT_RC,
diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
index eadf157..874ee9f 100644
--- a/net/smc/smc_wr.c
+++ b/net/smc/smc_wr.c
@@ -447,7 +447,7 @@ static void smc_wr_init_sge(struct smc_link *lnk)
 		lnk->wr_tx_ibs[i].num_sge = 1;
 		lnk->wr_tx_ibs[i].opcode = IB_WR_SEND;
 		lnk->wr_tx_ibs[i].send_flags =
-			IB_SEND_SIGNALED | IB_SEND_SOLICITED | IB_SEND_INLINE;
+			IB_SEND_SIGNALED | IB_SEND_SOLICITED;
 	}
 	for (i = 0; i < lnk->wr_rx_cnt; i++) {
 		lnk->wr_rx_sges[i].addr =
-- 
2.10.2
