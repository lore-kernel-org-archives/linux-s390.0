From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 07/10] s390/qeth: increase GSO max size for eligible L3 devices
Date: Wed, 11 Jul 2018 17:42:44 +0200
Message-ID: <20180711154247.5523-8-jwi@linux.ibm.com>
References: <20180711154247.5523-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180711154247.5523-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

When a L3 device doesn't offer TSO, allow the stack to build full-size
GSO skbs.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 7b4de46bf6e3..d07803df460b 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2536,8 +2536,9 @@ static int qeth_l3_setup_netdev(struct qeth_card *card)
 				NETIF_F_HW_VLAN_CTAG_RX |
 				NETIF_F_HW_VLAN_CTAG_FILTER;
 	netif_keep_dst(card->dev);
-	netif_set_gso_max_size(card->dev, (QETH_MAX_BUFFER_ELEMENTS(card) - 1) *
-					  PAGE_SIZE);
+	if (card->dev->hw_features & NETIF_F_TSO)
+		netif_set_gso_max_size(card->dev,
+				       PAGE_SIZE * (QETH_MAX_BUFFER_ELEMENTS(card) - 1));
 
 	SET_NETDEV_DEV(card->dev, &card->gdev->dev);
 	netif_napi_add(card->dev, &card->napi, qeth_poll, QETH_NAPI_WEIGHT);
-- 
2.16.4
