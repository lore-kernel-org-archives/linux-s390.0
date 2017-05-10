From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net 3/4] s390/qeth: avoid null pointer dereference on OSN
Date: Wed, 10 May 2017 19:07:53 +0200
Message-ID: <20170510170754.53922-4-jwi@linux.vnet.ibm.com>
References: <20170510170754.53922-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170510170754.53922-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Access card->dev only after checking whether's its valid.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 04666fe231aa..bd2df62a5cdf 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -965,7 +965,6 @@ static int qeth_l2_setup_netdev(struct qeth_card *card)
 	case QETH_CARD_TYPE_OSN:
 		card->dev = alloc_netdev(0, "osn%d", NET_NAME_UNKNOWN,
 					 ether_setup);
-		card->dev->flags |= IFF_NOARP;
 		break;
 	default:
 		card->dev = alloc_etherdev(0);
@@ -980,9 +979,12 @@ static int qeth_l2_setup_netdev(struct qeth_card *card)
 	card->dev->min_mtu = 64;
 	card->dev->max_mtu = ETH_MAX_MTU;
 	card->dev->netdev_ops = &qeth_l2_netdev_ops;
-	card->dev->ethtool_ops =
-		(card->info.type != QETH_CARD_TYPE_OSN) ?
-		&qeth_l2_ethtool_ops : &qeth_l2_osn_ops;
+	if (card->info.type == QETH_CARD_TYPE_OSN) {
+		card->dev->ethtool_ops = &qeth_l2_osn_ops;
+		card->dev->flags |= IFF_NOARP;
+	} else {
+		card->dev->ethtool_ops = &qeth_l2_ethtool_ops;
+	}
 	card->dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
 	if (card->info.type == QETH_CARD_TYPE_OSD && !card->info.guestlan) {
 		card->dev->hw_features = NETIF_F_SG;
-- 
2.10.2
