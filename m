Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 03/12] s390/qeth: support SG for more device types
Date: Fri,  9 Mar 2018 18:12:54 +0100
In-Reply-To: <20180309171303.65736-1-jwi@linux.vnet.ibm.com>
References: <20180309171303.65736-1-jwi@linux.vnet.ibm.com>
Message-Id: <20180309171303.65736-4-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

NETIF_F_SG support is currently limited to OSA (and for L2 even OSD)
devices. Advertise it for some more device types (OSM, L2 OSX, z/VM OSA)
that share the same code paths. For now, keep it switched off by
default on these devices.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 16 +++++++++-------
 drivers/s390/net/qeth_l3_main.c | 14 ++++++++------
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 1cd583b69eaa..ea607e5fb5dc 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -991,9 +991,16 @@ static int qeth_l2_setup_netdev(struct qeth_card *card)
 		card->dev->features |= NETIF_F_VLAN_CHALLENGED;
 	else
 		card->dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
+
+	if (card->info.type != QETH_CARD_TYPE_OSN &&
+	    card->info.type != QETH_CARD_TYPE_IQD) {
+		card->dev->priv_flags &= ~IFF_TX_SKB_SHARING;
+		card->dev->needed_headroom = sizeof(struct qeth_hdr);
+		card->dev->hw_features |= NETIF_F_SG;
+		card->dev->vlan_features |= NETIF_F_SG;
+	}
+
 	if (card->info.type == QETH_CARD_TYPE_OSD && !card->info.guestlan) {
-		card->dev->hw_features = NETIF_F_SG;
-		card->dev->vlan_features = NETIF_F_SG;
 		card->dev->features |= NETIF_F_SG;
 		/* OSA 3S and earlier has no RX/TX support */
 		if (qeth_is_supported(card, IPA_OUTBOUND_CHECKSUM)) {
@@ -1005,11 +1012,6 @@ static int qeth_l2_setup_netdev(struct qeth_card *card)
 			card->dev->vlan_features |= NETIF_F_RXCSUM;
 		}
 	}
-	if (card->info.type != QETH_CARD_TYPE_OSN &&
-	    card->info.type != QETH_CARD_TYPE_IQD) {
-		card->dev->priv_flags &= ~IFF_TX_SKB_SHARING;
-		card->dev->needed_headroom = sizeof(struct qeth_hdr);
-	}
 
 	card->info.broadcast_capable = 1;
 	qeth_l2_request_initial_mac(card);
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index e5f11cd64fec..e933a273d543 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2785,14 +2785,16 @@ static int qeth_l3_setup_netdev(struct qeth_card *card)
 			if (!(card->info.unique_id & UNIQUE_ID_NOT_BY_CARD))
 				card->dev->dev_id = card->info.unique_id &
 							 0xffff;
+
+			card->dev->hw_features |= NETIF_F_SG;
+			card->dev->vlan_features |= NETIF_F_SG;
+
 			if (!card->info.guestlan) {
-				card->dev->hw_features = NETIF_F_SG |
-					NETIF_F_RXCSUM | NETIF_F_IP_CSUM |
-					NETIF_F_TSO;
-				card->dev->vlan_features = NETIF_F_SG |
-					NETIF_F_RXCSUM | NETIF_F_IP_CSUM |
-					NETIF_F_TSO;
 				card->dev->features |= NETIF_F_SG;
+				card->dev->hw_features |= NETIF_F_TSO |
+					NETIF_F_RXCSUM | NETIF_F_IP_CSUM;
+				card->dev->vlan_features |= NETIF_F_TSO |
+					NETIF_F_RXCSUM | NETIF_F_IP_CSUM;
 			}
 		}
 	} else if (card->info.type == QETH_CARD_TYPE_IQD) {
-- 
2.13.5
