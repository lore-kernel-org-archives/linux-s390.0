From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 06/13] s390/qeth: clean up initial MTU determination
Date: Wed, 18 Oct 2017 17:40:18 +0200
Message-ID: <20171018154025.73630-7-jwi@linux.vnet.ibm.com>
References: <20171018154025.73630-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171018154025.73630-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

1. Drop the support for Token Ring,
2. use the ETH_DATA_LEN macro for the default L2 MTU,
3. handle OSM via the default case (as OSM is L2-only), and
4. document why the L3 MTU is reduced.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 735b03cae727..acf16fa75c63 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -2219,18 +2219,12 @@ static int qeth_get_initial_mtu_for_card(struct qeth_card *card)
 	case QETH_CARD_TYPE_IQD:
 		return card->info.max_mtu;
 	case QETH_CARD_TYPE_OSD:
-		switch (card->info.link_type) {
-		case QETH_LINK_TYPE_HSTR:
-		case QETH_LINK_TYPE_LANE_TR:
-			return 2000;
-		default:
-			return card->options.layer2 ? 1500 : 1492;
-		}
-	case QETH_CARD_TYPE_OSM:
 	case QETH_CARD_TYPE_OSX:
-		return card->options.layer2 ? 1500 : 1492;
+		if (!card->options.layer2)
+			return ETH_DATA_LEN - 8; /* L3: allow for LLC + SNAP */
+		/* fall through */
 	default:
-		return 1500;
+		return ETH_DATA_LEN;
 	}
 }
 
-- 
2.13.5
