From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net V3 5/5] net/smc: use after free fix in smc_wr_tx_put_slot()
Date: Fri, 16 Nov 2018 13:36:17 +0100
Message-ID: <20181116123617.72948-6-ubraun@linux.ibm.com>
References: <20181116123617.72948-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181116123617.72948-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@linux.ibm.com>

In smc_wr_tx_put_slot() field pend->idx is used after being
cleared. That means always idx 0 is cleared in the wr_tx_mask.
This results in a broken administration of available WR send
payload buffers.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_wr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
index 3c458d279855..c2694750a6a8 100644
--- a/net/smc/smc_wr.c
+++ b/net/smc/smc_wr.c
@@ -215,12 +215,14 @@ int smc_wr_tx_put_slot(struct smc_link *link,
 
 	pend = container_of(wr_pend_priv, struct smc_wr_tx_pend, priv);
 	if (pend->idx < link->wr_tx_cnt) {
+		u32 idx = pend->idx;
+
 		/* clear the full struct smc_wr_tx_pend including .priv */
 		memset(&link->wr_tx_pends[pend->idx], 0,
 		       sizeof(link->wr_tx_pends[pend->idx]));
 		memset(&link->wr_tx_bufs[pend->idx], 0,
 		       sizeof(link->wr_tx_bufs[pend->idx]));
-		test_and_clear_bit(pend->idx, link->wr_tx_mask);
+		test_and_clear_bit(idx, link->wr_tx_mask);
 		return 1;
 	}
 
-- 
2.16.4
