From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 08/13] s390/qeth: no VLAN support on OSM
Date: Wed, 18 Oct 2017 17:40:20 +0200
Message-ID: <20171018154025.73630-9-jwi@linux.vnet.ibm.com>
References: <20171018154025.73630-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171018154025.73630-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Instead of silently discarding VLAN registration requests on OSM,
just indicate that this card type doesn't support VLAN.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 87aa8c2ab5b0..d2537c09126d 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -348,10 +348,6 @@ static int qeth_l2_vlan_rx_add_vid(struct net_device *dev,
 	QETH_CARD_TEXT_(card, 4, "aid:%d", vid);
 	if (!vid)
 		return 0;
-	if (card->info.type == QETH_CARD_TYPE_OSM) {
-		QETH_CARD_TEXT(card, 3, "aidOSM");
-		return 0;
-	}
 	if (qeth_wait_for_threads(card, QETH_RECOVER_THREAD)) {
 		QETH_CARD_TEXT(card, 3, "aidREC");
 		return 0;
@@ -381,10 +377,6 @@ static int qeth_l2_vlan_rx_kill_vid(struct net_device *dev,
 	int rc = 0;
 
 	QETH_CARD_TEXT_(card, 4, "kid:%d", vid);
-	if (card->info.type == QETH_CARD_TYPE_OSM) {
-		QETH_CARD_TEXT(card, 3, "kidOSM");
-		return 0;
-	}
 	if (qeth_wait_for_threads(card, QETH_RECOVER_THREAD)) {
 		QETH_CARD_TEXT(card, 3, "kidREC");
 		return 0;
@@ -1010,7 +1002,11 @@ static int qeth_l2_setup_netdev(struct qeth_card *card)
 	} else {
 		card->dev->ethtool_ops = &qeth_l2_ethtool_ops;
 	}
-	card->dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
+
+	if (card->info.type == QETH_CARD_TYPE_OSM)
+		card->dev->features |= NETIF_F_VLAN_CHALLENGED;
+	else
+		card->dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
 	if (card->info.type == QETH_CARD_TYPE_OSD && !card->info.guestlan) {
 		card->dev->hw_features = NETIF_F_SG;
 		card->dev->vlan_features = NETIF_F_SG;
@@ -1120,8 +1116,7 @@ static int __qeth_l2_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 			goto out_remove;
 	}
 
-	if (card->info.type != QETH_CARD_TYPE_OSN &&
-	    card->info.type != QETH_CARD_TYPE_OSM)
+	if (card->info.type != QETH_CARD_TYPE_OSN)
 		qeth_l2_process_vlans(card);
 
 	netif_tx_disable(card->dev);
-- 
2.13.5
