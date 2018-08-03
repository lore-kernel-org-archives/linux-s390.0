Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 1/1] net/smc: no cursor update send in state SMC_INIT
Date: Fri,  3 Aug 2018 10:38:33 +0200
Message-Id: <20180803083833.51029-1-ubraun@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

If a writer blocked condition is received without data, the current
consumer cursor is immediately sent. Servers could already receive this
condition in state SMC_INIT without finished tx-setup. This patch
avoids sending a consumer cursor update in this case.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_cdc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index a7e8d63fc8ae..9bde1e4ca288 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -233,7 +233,8 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
 			/* force immediate tx of current consumer cursor, but
 			 * under send_lock to guarantee arrival in seqno-order
 			 */
-			smc_tx_sndbuf_nonempty(conn);
+			if (smc->sk.sk_state != SMC_INIT)
+				smc_tx_sndbuf_nonempty(conn);
 		}
 	}
 
-- 
2.16.4
