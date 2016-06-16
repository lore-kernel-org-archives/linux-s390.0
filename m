From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 06/13] qeth: enable scatter/gather by default
Date: Thu, 16 Jun 2016 16:18:56 +0200
Message-ID: <1466086743-55484-7-git-send-email-ubraun@linux.vnet.ibm.com>
References: <1466086743-55484-1-git-send-email-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1466086743-55484-1-git-send-email-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, utz.bacher@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Eugene Crosser <Eugene.Crosser@ru.ibm.com>

Set scatter/gather ON by default on OSA, for both layer 2 and
layer 3 modes. We always use fragmentation over QDIO anyway,
so let the upper layers of the stack take advantage of that.

Signed-off-by: Eugene Crosser <Eugene.Crosser@ru.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
Reviewed-by: Lakhvich Dmitriy <ldmitriy@ru.ibm.com>
Reviewed-by: Thomas Richter <tmricht@de.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 4 ++--
 drivers/s390/net/qeth_l3_main.c | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index ec163e4..e24627f 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1140,8 +1140,8 @@ static int qeth_l2_setup_netdev(struct qeth_card *card)
 	if (card->info.type == QETH_CARD_TYPE_OSD && !card->info.guestlan) {
 		card->dev->hw_features = NETIF_F_IP_CSUM | NETIF_F_RXCSUM |
 					 NETIF_F_SG;
-		/* Turn on RX offloading per default */
-		card->dev->features |= NETIF_F_RXCSUM;
+		/* Turn on RX offloading and SG per default */
+		card->dev->features |= NETIF_F_RXCSUM | NETIF_F_SG;
 	}
 	card->info.broadcast_capable = 1;
 	qeth_l2_request_initial_mac(card);
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 76ddd18..0afdb14 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -3191,7 +3191,8 @@ static int qeth_l3_setup_netdev(struct qeth_card *card)
 				card->dev->hw_features = NETIF_F_SG |
 					NETIF_F_RXCSUM | NETIF_F_IP_CSUM |
 					NETIF_F_TSO;
-				card->dev->features = NETIF_F_RXCSUM;
+				card->dev->features = NETIF_F_RXCSUM |
+						      NETIF_F_SG;
 			}
 		}
 	} else if (card->info.type == QETH_CARD_TYPE_IQD) {
-- 
2.6.6
