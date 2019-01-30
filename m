Return-Path: <SRS0=auZG=QG=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 9/9] net/smc: fix use of variable in cleared area
Date: Wed, 30 Jan 2019 18:51:08 +0100
In-Reply-To: <20190130175108.103221-1-ubraun@linux.ibm.com>
References: <20190130175108.103221-1-ubraun@linux.ibm.com>
Message-Id: <20190130175108.103221-10-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>

Do not use pend->idx as index for the arrays because its value is
located in the cleared area. Use the existing local variable instead.
Without this fix the wrong area might be cleared.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_wr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
index c2694750a6a8..1dc88c32d6bb 100644
--- a/net/smc/smc_wr.c
+++ b/net/smc/smc_wr.c
@@ -218,10 +218,10 @@ int smc_wr_tx_put_slot(struct smc_link *link,
 		u32 idx = pend->idx;
 
 		/* clear the full struct smc_wr_tx_pend including .priv */
-		memset(&link->wr_tx_pends[pend->idx], 0,
-		       sizeof(link->wr_tx_pends[pend->idx]));
-		memset(&link->wr_tx_bufs[pend->idx], 0,
-		       sizeof(link->wr_tx_bufs[pend->idx]));
+		memset(&link->wr_tx_pends[idx], 0,
+		       sizeof(link->wr_tx_pends[idx]));
+		memset(&link->wr_tx_bufs[idx], 0,
+		       sizeof(link->wr_tx_bufs[idx]));
 		test_and_clear_bit(idx, link->wr_tx_mask);
 		return 1;
 	}
-- 
2.16.4
