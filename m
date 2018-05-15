From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 09/10] net/smc: drop messages when link state is inactive
Date: Tue, 15 May 2018 17:05:02 +0200
Message-ID: <20180515150503.47265-10-ubraun@linux.ibm.com>
References: <20180515150503.47265-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180515150503.47265-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>

Drop incoming messages when the link is flagged as inactive.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_llc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 5d7926cc472c..5800a6b43d83 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -548,6 +548,8 @@ static void smc_llc_rx_handler(struct ib_wc *wc, void *buf)
 		return; /* short message */
 	if (llc->raw.hdr.length != sizeof(*llc))
 		return; /* invalid message */
+	if (link->state == SMC_LNK_INACTIVE)
+		return; /* link not active, drop msg */
 
 	switch (llc->raw.hdr.common.type) {
 	case SMC_LLC_TEST_LINK:
-- 
2.16.3
