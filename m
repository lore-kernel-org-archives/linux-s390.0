From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 05/13] s390/qeth: de-indent else after return
Date: Thu, 26 Apr 2018 09:42:16 +0200
Message-ID: <20180426074224.100432-6-jwi@linux.ibm.com>
References: <20180426074224.100432-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180426074224.100432-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Kittipon Meesompop <kmeesomp@linux.vnet.ibm.com>

Trivial cleanup, in preparation for a subsequent patch.

Signed-off-by: Kittipon Meesompop <kmeesomp@linux.vnet.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 43 ++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 64f27de079ca..0e8ed8787fd3 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2533,28 +2533,27 @@ static int qeth_l3_setup_netdev(struct qeth_card *card)
 		    (card->info.link_type == QETH_LINK_TYPE_HSTR)) {
 			pr_info("qeth_l3: ignoring TR device\n");
 			return -ENODEV;
-		} else {
-			card->dev = alloc_etherdev(0);
-			if (!card->dev)
-				return -ENODEV;
-			card->dev->netdev_ops = &qeth_l3_osa_netdev_ops;
-
-			/*IPv6 address autoconfiguration stuff*/
-			qeth_l3_get_unique_id(card);
-			if (!(card->info.unique_id & UNIQUE_ID_NOT_BY_CARD))
-				card->dev->dev_id = card->info.unique_id &
-							 0xffff;
-
-			card->dev->hw_features |= NETIF_F_SG;
-			card->dev->vlan_features |= NETIF_F_SG;
-
-			if (!card->info.guestlan) {
-				card->dev->features |= NETIF_F_SG;
-				card->dev->hw_features |= NETIF_F_TSO |
-					NETIF_F_RXCSUM | NETIF_F_IP_CSUM;
-				card->dev->vlan_features |= NETIF_F_TSO |
-					NETIF_F_RXCSUM | NETIF_F_IP_CSUM;
-			}
+		}
+
+		card->dev = alloc_etherdev(0);
+		if (!card->dev)
+			return -ENODEV;
+		card->dev->netdev_ops = &qeth_l3_osa_netdev_ops;
+
+		/*IPv6 address autoconfiguration stuff*/
+		qeth_l3_get_unique_id(card);
+		if (!(card->info.unique_id & UNIQUE_ID_NOT_BY_CARD))
+			card->dev->dev_id = card->info.unique_id & 0xffff;
+
+		card->dev->hw_features |= NETIF_F_SG;
+		card->dev->vlan_features |= NETIF_F_SG;
+
+		if (!card->info.guestlan) {
+			card->dev->features |= NETIF_F_SG;
+			card->dev->hw_features |= NETIF_F_TSO |
+				NETIF_F_RXCSUM | NETIF_F_IP_CSUM;
+			card->dev->vlan_features |= NETIF_F_TSO |
+				NETIF_F_RXCSUM | NETIF_F_IP_CSUM;
 		}
 	} else if (card->info.type == QETH_CARD_TYPE_IQD) {
 		card->dev = alloc_netdev(0, "hsi%d", NET_NAME_UNKNOWN,
-- 
2.13.5
