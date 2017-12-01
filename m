From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net 3/3] s390/qeth: build max size GSO skbs on L2 devices
Date: Fri,  1 Dec 2017 10:14:51 +0100
Message-ID: <20171201091451.52270-4-jwi@linux.vnet.ibm.com>
References: <20171201091451.52270-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171201091451.52270-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The current GSO skb size limit was copy&pasted over from the L3 path,
where it is needed due to a TSO limitation.
As L2 devices don't offer TSO support (and thus all GSO skbs are
segmented before they reach the driver), there's no reason to restrict
the stack in how large it may build the GSO skbs.

Fixes: d52aec97e5bc ("qeth: enable scatter/gather in layer 2 mode")
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 2 --
 drivers/s390/net/qeth_l3_main.c | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 85162712d207..f21c94810373 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1030,8 +1030,6 @@ static int qeth_l2_setup_netdev(struct qeth_card *card)
 
 	card->info.broadcast_capable = 1;
 	qeth_l2_request_initial_mac(card);
-	card->dev->gso_max_size = (QETH_MAX_BUFFER_ELEMENTS(card) - 1) *
-				  PAGE_SIZE;
 	SET_NETDEV_DEV(card->dev, &card->gdev->dev);
 	netif_napi_add(card->dev, &card->napi, qeth_poll, QETH_NAPI_WEIGHT);
 	netif_carrier_off(card->dev);
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 46a841258fc8..2a25f20566d8 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2987,8 +2987,8 @@ static int qeth_l3_setup_netdev(struct qeth_card *card)
 				NETIF_F_HW_VLAN_CTAG_RX |
 				NETIF_F_HW_VLAN_CTAG_FILTER;
 	netif_keep_dst(card->dev);
-	card->dev->gso_max_size = (QETH_MAX_BUFFER_ELEMENTS(card) - 1) *
-				  PAGE_SIZE;
+	netif_set_gso_max_size(card->dev, (QETH_MAX_BUFFER_ELEMENTS(card) - 1) *
+					  PAGE_SIZE);
 
 	SET_NETDEV_DEV(card->dev, &card->gdev->dev);
 	netif_napi_add(card->dev, &card->napi, qeth_poll, QETH_NAPI_WEIGHT);
-- 
2.13.5
