From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 7/9] s390/qeth: silence qeth_fix_features()
Date: Tue,  6 Jun 2017 14:33:48 +0200
Message-ID: <20170606123350.13781-8-jwi@linux.vnet.ibm.com>
References: <20170606123350.13781-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170606123350.13781-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Noting the lack of TSO support on every feature change is just silly,
in particular since the requested features might not even affect
NETIF_F_TSO.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index a159eb900d03..3cc802cff9d1 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -6390,11 +6390,8 @@ netdev_features_t qeth_fix_features(struct net_device *dev,
 		features &= ~NETIF_F_IP_CSUM;
 	if (!qeth_is_supported(card, IPA_INBOUND_CHECKSUM))
 		features &= ~NETIF_F_RXCSUM;
-	if (!qeth_is_supported(card, IPA_OUTBOUND_TSO)) {
+	if (!qeth_is_supported(card, IPA_OUTBOUND_TSO))
 		features &= ~NETIF_F_TSO;
-		dev_info(&card->gdev->dev, "Outbound TSO not supported on %s\n",
-			 QETH_CARD_IFNAME(card));
-	}
 	/* if the card isn't up, remove features that require hw changes */
 	if (card->state == CARD_STATE_DOWN ||
 	    card->state == CARD_STATE_RECOVER)
-- 
2.11.2
